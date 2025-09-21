import subprocess

colors = [ "black", "color", "color_dark", "red", "white" ]

logos: list[tuple[str, list[tuple[str, list[str]]]] | tuple[str, list[tuple[str, list[str]] | tuple[str, list[str]]]]] = [("OX", [
    ("-uni", [ "FRATERNITY" ]),
    ("-uninologo", [ "FRATERNITY", "RED", "GOLD" ]),
    ("-chap", [ "FRATERNITY", "CWRU" ]),
    ("-bnnologo", [ "FRATERNITY", "CWRU", "RED", "GOLD" ]),
    ("-frat", [ "BN", "CWRU"]),
    ("-nologo", [ "BN", "CWRU", "RED", "GOLD" ])
]), ("logomark", [
    ("-uni", [ ]),
    ("-chap", [ "CWRU" ]),
    ("-frat", [ "CWRU", "BN" ]),
    ("-notag", [ "CWRU", "BN", "TAG" ]),
    ("-nologo", [ "CWRU", "BN", "TAG", "RED", "GOLD" ])
]), ("stacked", [
    ("-uni", [ "TOP", "CENTER" ]),
    ("-chap", [ "CWRU", "TOP", "BOTTOM" ]),
    ("-frat", [ "CWRU", "BN", "CENTER", "BOTTOM" ]),
    ("-notag", [ "CWRU", "BN", "TOP", "CENTER", "BOTTOM" ]),
    ("-nologo", [ "CWRU", "BN", "RED", "GOLD", "TOP", "CENTER", "BOTTOM" ])
]), ("logo", [
    ("", [ ])
])]

script = '''
    set -euxo pipefail
    mkdir -p ./out
'''

def build(filename: str):
    return f"envsubst -i ./template.svg -o out/{filename} --no-unset"

for color in colors:
    script += f'''
        source ./colors/{color}.sh
        source ./style.sh
        envsubst -i ./_brand.yml -o out/_brand-{color}.yml
    '''

    for logo in logos:
        des = logo[0]

        for image in logo[1]:
            script += f'''
                source ./designs/{des}.sh
            '''
            for var in image[1]:
                script += f'''
                    export {var}=\"\"
                '''
            script += f'''
                source ./post.sh
                {build(f"{des}{image[0]}-{color}.svg")}
            '''

_ = subprocess.run(["bash", "-c", script], check=True)
