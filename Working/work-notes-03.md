sudo ln -vsT ${DNETCORE_PATH}/dotnet ${PUBLIC_BIN_LOCN}/dotnet;

containerd.io_1.6.31-1_amd64.deb
liberror-perl
docker-ce-rootless-extras
tigervnc-common
libfile-readbackwards-perl


code-cli --install-extension  jsynowiec.vscode-insertdatestring;
code-cli --install-extension  yzhang.markdown-all-in-one;
code-cli --install-extension  bierner.markdown-preview-github-styles;
code-cli --install-extension  pharndt.vscode-markdown-table;
code-cli --install-extension  ms-dotnettools.vscode-dotnet-runtime;
code-cli --install-extension  ms-dotnettools.csharp;
code-cli --install-extension  mechatroner.rainbow-csv;
code-cli --install-extension  volkerdobler.insertnums;
code-cli --install-extension  renesaarsoo.sql-formatter-vsc;
code-cli --install-extension  tuxtina.json2yaml;

***

    echo;
    echo "Install Browsers";
    sudo snap install chromium;
    sudo dpkg -i \
        ${RESOURCE_FOLDER}/Install/google-chrome-stable_current_amd64.deb \
        ;

