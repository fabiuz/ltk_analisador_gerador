#PBFORMS CREATED V2.00
'------------------------------------------------------------------------------
' The first line in this file is a PB/Forms metastatement.
' It should ALWAYS be the first line of the file. Other
' PB/Forms metastatements are placed at the beginning and
' end of "Named Blocks" of code that should be edited
' with PBForms only. Do not manually edit or delete these
' metastatements or PB/Forms will not be able to reread
' the file correctly.  See the PB/Forms documentation for
' more information.
' Named blocks begin like this:    #PBFORMS BEGIN ...
' Named blocks end like this:      #PBFORMS END ...
' Other PB/Forms metastatements such as:
'     #PBFORMS DECLARATIONS
' are used by PB/Forms to insert additional code.
' Feel free to make changes anywhere else in the file.
'------------------------------------------------------------------------------

#COMPILE EXE
#DIM ALL
#OPTIMIZE CODE ON
#OPTIMIZE SIZE

'------------------------------------------------------------------------------
'   ** Includes **
'------------------------------------------------------------------------------
#PBFORMS BEGIN INCLUDES
#RESOURCE "Analisador_Gerador_LTK.pbr"
#INCLUDE ONCE "WIN32API.INC"
#INCLUDE ONCE "COMMCTRL.INC"
#INCLUDE ONCE "PBForms.INC"
#PBFORMS END INCLUDES
'------------------------------------------------------------------------------

'------------------------------------------------------------------------------
'   ** Constants **
'------------------------------------------------------------------------------
#PBFORMS BEGIN CONSTANTS
%IDC_BTN_GERAR_INSERT         = 1020
%IDC_BTN_GERAR_TODAS          = 1009
%IDC_BTN_PARAR_INSERT         = 1022
%IDC_BTN_PARAR_TODAS          = 1021
%IDC_BTN_PAUSAR_TODAS         = 1023    '*
%IDC_BUTTON1                  = 1019    '*
%IDC_CHK_ATUALIZAR_TODAS      = 1010
%IDC_CHK_PAUSAR_INSERT        = 1025
%IDC_CHK_PAUSAR_TODAS         = 1024
%IDC_CHK_STATUS_INSERT        = 1017
%IDC_CMB_APOSTAR_COM_TODAS    = 1005
%IDC_CMB_JOGO_TIPO_TODAS      = 1002
%IDC_FRAME1                   = 1001
%IDC_FRAME2                   = 1012
%IDC_LABEL1                   = 1003
%IDC_LABEL2                   = 1004
%IDC_LABEL3                   = 1006
%IDC_LABEL4                   = 1013
%IDC_LABEL5                   = 1015
%IDC_LBL_LOG_TODAS            = 1011
%IDC_LOG_INSERT               = 1018
%IDC_TEXTBOX1                 = 1007    '*
%IDC_TXT_ARQUIVO_ORIGEM       = 1014
%IDC_TXT_PASTA_DESTINO_INSERT = 1016
%IDC_TXT_PASTA_DESTINO_TODAS  = 1008
%IDD_DIALOG1                  =  101
#PBFORMS END CONSTANTS
'------------------------------------------------------------------------------

'------------------------------------------------------------------------------
'   ** Declarations **
'------------------------------------------------------------------------------
DECLARE CALLBACK FUNCTION Janela_Principal_CBK()
DECLARE FUNCTION Exibir_Janela_Principal(BYVAL hParent AS DWORD) AS LONG
#PBFORMS DECLARATIONS
'------------------------------------------------------------------------------

'------------------------------------------------------------------------------
' ** DECLARA��ES GLOBAIS **
'------------------------------------------------------------------------------
GLOBAL hJanela_Principal AS DWORD
GLOBAL uAtualizarTodas AS LONG
GLOBAL uSairTodas AS LONG
GLOBAL uPausarTodas AS LONG


GLOBAL uPausarInsert AS LONG
GLOBAL uPararInsert AS LONG
GLOBAL uAtualizarInsert AS LONG


ENUM TIPO_DE_JOGO SINGULAR
    QUINA_COM_5_NUMEROS
    QUINA_COM_6_NUMEROS
    QUINA_COM_7_NUMEROS
    MEGASENA_COM_6_NUMEROS
    MEGASENA_COM_7_NUMEROS
    MEGASENA_COM_8_NUMEROS
    MEGASENA_COM_9_NUMEROS
    MEGASENA_COM_10_NUMEROS
    MEGASENA_COM_11_NUMEROS
    MEGASENA_COM_12_NUMEROS
    MEGASENA_COM_13_NUMEROS
    MEGASENA_COM_14_NUMEROS
    MEGASENA_COM_15_NUMEROS
    LOTOFACIL_COM_15_NUMEROS
    LOTOFACIL_COM_16_NUMEROS
    LOTOFACIL_COM_17_NUMEROS
    LOTOFACIL_COM_18_NUMEROS
END ENUM



FUNCTION Carregar_Lista(BYVAL strJogo AS STRING) AS LONG
    COMBOBOX RESET hJanela_Principal, %IDC_CMB_APOSTAR_COM_TODAS

    strJogo = UCASE$(strJogo)
    SELECT CASE strJogo
        CASE "QUINA"
            COMBOBOX ADD hJanela_Principal, %IDC_CMB_APOSTAR_COM_TODAS, "5 n�meros"
            COMBOBOX ADD hJanela_Principal, %IDC_CMB_APOSTAR_COM_TODAS, "6 n�meros"
            COMBOBOX ADD hJanela_Principal, %IDC_CMB_APOSTAR_COM_TODAS, "7 n�meros"

        CASE "MEGASENA
            COMBOBOX ADD hJanela_Principal, %IDC_CMB_APOSTAR_COM_TODAS, "6 n�meros"
            COMBOBOX ADD hJanela_Principal, %IDC_CMB_APOSTAR_COM_TODAS, "7 n�meros"
            COMBOBOX ADD hJanela_Principal, %IDC_CMB_APOSTAR_COM_TODAS, "8 n�meros"
            COMBOBOX ADD hJanela_Principal, %IDC_CMB_APOSTAR_COM_TODAS, "9 n�meros"
            COMBOBOX ADD hJanela_Principal, %IDC_CMB_APOSTAR_COM_TODAS, "10 n�meros"
            COMBOBOX ADD hJanela_Principal, %IDC_CMB_APOSTAR_COM_TODAS, "11 n�meros"
            COMBOBOX ADD hJanela_Principal, %IDC_CMB_APOSTAR_COM_TODAS, "12 n�meros"
            COMBOBOX ADD hJanela_Principal, %IDC_CMB_APOSTAR_COM_TODAS, "14 n�meros"
            COMBOBOX ADD hJanela_Principal, %IDC_CMB_APOSTAR_COM_TODAS, "15 n�meros"

        CASE "LOTOFACIL"
            COMBOBOX ADD hJanela_Principal, %IDC_CMB_APOSTAR_COM_TODAS, "15 n�meros"
            COMBOBOX ADD hJanela_Principal, %IDC_CMB_APOSTAR_COM_TODAS, "16 n�meros"
            COMBOBOX ADD hJanela_Principal, %IDC_CMB_APOSTAR_COM_TODAS, "17 n�meros"
            COMBOBOX ADD hJanela_Principal, %IDC_CMB_APOSTAR_COM_TODAS, "18 n�meros"

        CASE "LOTOMANIA"
            COMBOBOX ADD hJanela_Principal, %IDC_CMB_APOSTAR_COM_TODAS, "50 n�meros"
    END SELECT

    COMBOBOX SELECT hJanela_Principal, %IDC_CMB_APOSTAR_COM_TODAS, 1

END FUNCTION

'
' Carrega as caixas de combina��o 'TIPO DE JOGO' e 'APOSTAR COM'
'
SUB Carregar_Lista_Inicial()
    COMBOBOX RESET hJanela_Principal, %IDC_CMB_JOGO_TIPO_TODAS
    COMBOBOX RESET hJanela_Principal, %IDC_CMB_APOSTAR_COM_TODAS
    '
    COMBOBOX ADD hJanela_Principal, %IDC_CMB_JOGO_TIPO_TODAS, "QUINA"
    COMBOBOX ADD hJanela_Principal, %IDC_CMB_JOGO_TIPO_TODAS, "MEGASENA"
    COMBOBOX ADD hJanela_Principal, %IDC_CMB_JOGO_TIPO_TODAS, "LOTOFACIL"
    COMBOBOX ADD hJanela_Principal, %IDC_CMB_JOGO_TIPO_TODAS, "LOTOMANIA"

    '
    COMBOBOX ADD hJanela_Principal, %IDC_CMB_APOSTAR_COM_TODAS, "5 n�meros"
    COMBOBOX ADD hJanela_Principal, %IDC_CMB_APOSTAR_COM_TODAS, "6 n�meros"
    COMBOBOX ADD hJanela_Principal, %IDC_CMB_APOSTAR_COM_TODAS, "7 n�meros"

    '
    COMBOBOX SELECT hJanela_Principal, %IDC_CMB_JOGO_TIPO_TODAS, 1
    COMBOBOX SELECT hJanela_Principal, %IDC_CMB_APOSTAR_COM_TODAS, 1
END SUB


'
'   Esta fun��o verifica se o tipo de jogo e a quantidade de n�meros apostados
'   � permitido na loteria
'   Retorna -1 se h� algo errado
'
FUNCTION Validar_Tipo_de_Jogo(BYVAL strJogo AS STRING, BYVAL uBolasApostadas AS LONG, BYREF strErro AS STRING) AS LONG
    ' Vamos verificar se o jogo j� foi implementado
    strJogo = UCASE$(strJogo)
    IF strJogo <> "QUINA" AND strJogo <> "MEGASENA" AND strJogo <> "LOTOFACIL" THEN
        strErro = "O jogo solicitado: '" & strJogo & "' ainda n�o foi implementado."
        FUNCTION = -1
        EXIT FUNCTION
    END IF

    ' Verificar se a quantidade de bolas coincide para cada tipo de jogo, por exemplo,
    ' na quina, voc� pode selecionar, 5, 6 ou 7 n�meros
    SELECT CASE strJogo
        CASE "QUINA"
            ' Se a quantidade de bolas for diferente de 5, 6 ou 7
            IF ISFALSE(uBolasApostadas >= 5 AND uBolasApostadas <= 7) THEN
                strErro = "Para o jogo 'QUINA' voc� pode apostar com 5, 6 ou 7 n�meros, entretanto, voc� selecionou " & _
                          " um outro n�mero."
                FUNCTION = -1
                EXIT FUNCTION
            END IF
        CASE "MEGASENA"
            ' Se a quantidade de bolas for diferente de 6 A 15
            IF ISFALSE(uBolasApostadas >= 6 AND uBolasApostadas <= 15) THEN
                strErro = "Para o jogo 'MEGASENA' voc� pode apostar de 6 a 15 n�meros, entretanto, voc� selecionou " & _
                          " um outro n�mero."
                FUNCTION = -1
                EXIT FUNCTION
            END IF

        CASE "LOTOFACIL"
            ' Se a quantidade de bolas for diferente de 6 A 15
            IF ISFALSE(uBolasApostadas >= 15 AND uBolasApostadas <= 18) THEN
                strErro = "Para o jogo 'LOTOFACIL' voc� pode apostar de 15 a 18 n�meros, entretanto, voc� selecionou " & _
                          " um outro n�mero."
                FUNCTION = -1
                EXIT FUNCTION
            END IF
    END SELECT
    '
    FUNCTION = 0
END FUNCTION

'
'   Esta fun��o gera o nome do arquivo de acordo com o tipo do jogo e quantidade de n�meros apostados
'   A fun��o retorna um string vazio se algo ocorreu de errado
'
FUNCTION Gerar_Nome_do_Arquivo(BYVAL strPastaDestino AS STRING, BYVAL strJogo AS STRING, _
                                BYVAL uBolasApostadas AS LONG, BYREF strErro AS STRING) AS STRING
    ' Vamos verificar se a pasta existe
    IF DIR$(strPastaDestino, %SUBDIR) = "" THEN
        strErro = "A pasta de destino especificada n�o existe: '" & strPastaDestino & "'."
        FUNCTION = ""
        EXIT FUNCTION
    END IF

    ' Vamos verificar se a pasta tem o �ltimo caractere � direita, o caractere '\'
    IF RIGHT$(strPastaDestino, 1) <> "\" THEN
        strPastaDestino &= "\"
    END IF

    ' Vamos o nome do arquivo com a nomenclatura abaixo:
    ' <JOGO>_COM_<uBolasApostadas>_N�MEROS_DATA_HORA
    DIM objDataHora AS IPOWERTIME
    LET objDataHora = CLASS "POWERTIME"
    IF ISNOTHING(objDataHora) THEN
        strErro = "N�o foi poss�vel instanciar a classe 'POWERTIME', interface 'IPOWERTIME'."
        FUNCTION = ""
        EXIT FUNCTION
    END IF

    DIM strArquivoDestino AS STRING
    strArquivoDestino = strJogo & "_COM_" & FORMAT$(uBolasApostadas) & "_N�MEROS_"

    objDataHora.Now()
    strArquivoDestino &= FORMAT$(objDataHora.Year(), "0000") & "_" & FORMAT$(objDataHora.Month(), "00") & "_"
    strArquivoDestino &= FORMAT$(objDataHora.Day(), "00") & "_" & FORMAT$(objDataHora.Hour(), "00") & "-"
    strArquivoDestino &= FORMAT$(objDataHora.Minute(), "00") & "-" & FORMAT$(objDataHora.Second(), "00")
    strArquivoDestino = strPastaDestino & strArquivoDestino & ".txt"

    FUNCTION = strArquivoDestino
END FUNCTION

FUNCTION Carregar_Arranjo(BYVAL strJogo AS STRING, BYREF strBolas() AS STRING, BYREF strErro AS STRING) AS LONG
    SELECT CASE strJogo
        CASE "QUINA"
            REDIM strBolas(1 TO 80)
        CASE "MEGASENA"
            REDIM strBolas(1 TO 60)
        CASE "LOTOFACIL"
            REDIM strBolas(1 TO 25)
    END SELECT


    DIM iA AS LONG
    DIM uLimiteInferior AS LONG
    DIM uLimiteSuperior AS LONG
    '
    ERRCLEAR
    uLimiteInferior = LBOUND(strBolas, 1)
    uLimiteSuperior = UBOUND(strBolas, 1)

    FOR iA = uLimiteInferior TO uLimiteSuperior
        strBolas(iA) = FORMAT$(iA, "00")
    NEXT iA

    IF ERR <> 0 THEN
        strErro = "Erro: '" & FORMAT$(ERR) & "', " & ERROR$(ERR)
        FUNCTION = -1
    ELSE
        FUNCTION = 0
    END IF
END FUNCTION


FUNCTION Gerar_Todas_Combinacoes ALIAS "Gerar_Todas_Combinacoes" (BYVAL strJogo AS STRING, _
    BYVAL uBolasApostadas AS LONG, _       ' Quantidade de bolas apostadas
    BYVAL strPastaDestino AS STRING, _
     BYREF strErro AS STRING) EXPORT AS LONG

     ' Validar dados informados pelo usu�rio
     ' Se h� erro, retorna -1
     IF Validar_Tipo_de_Jogo(strJogo, uBolasApostadas, strErro) = -1 THEN
         FUNCTION = -1
         EXIT FUNCTION
     END IF

     ' Vamos gerar nome do arquivo
     DIM strArquivoDestino AS STRING
     strArquivoDestino = Gerar_Nome_do_Arquivo(strPastaDestino, strJogo, uBolasApostadas, strErro)
     ' Se n�o conseguir criar o nome do arquivo, sair ent�o
     IF strArquivoDestino = "" THEN
         FUNCTION = -1
         EXIT FUNCTION
     END IF

    ' Vamos tentar abrir o arquivo, se n�o conseguirmos sair da fun��o
    DIM uArquivoDestino AS LONG
    uArquivoDestino = FREEFILE
    OPEN strArquivoDestino FOR OUTPUT AS uArquivoDestino
    IF ERR <> 0 THEN
        strErro = "Erro: " & ERROR$(ERR)
        FUNCTION = -1
        EXIT FUNCTION
    END IF

    ' Vamos carregar o arranjo que criamos
    DIM strBolas() AS STRING
    IF Carregar_Arranjo(strJogo, strBolas(), strErro) = -1 THEN
        FUNCTION = -1
        EXIT FUNCTION
    END IF

    IF Gerar_Combinacao_Por_Jogo(strJogo, uBolasApostadas, strBolas(), uArquivoDestino, strErro) = -1 THEN
        EXIT FUNCTION
    END IF


END FUNCTION







FUNCTION Gerar_Combinacao_Por_Jogo(BYVAL strJogo AS STRING, BYVAL uBolasApostadas AS LONG, _
    BYREF strBolas() AS STRING, BYVAL uArquivoDestino AS LONG, BYREF strErro AS STRING) AS LONG
        ' Vari�veis serve para guardar o tipo do jogo
    DIM uJogoTipo AS LONG
    SELECT CASE strJogo
        CASE "QUINA"
        '
            SELECT CASE uBolasApostadas
                CASE 5
                    uJogoTipo = %QUINA_COM_5_NUMEROS
                CASE 6
                    uJogoTipo = %QUINA_COM_6_NUMEROS
                CASE 7
                    uJogoTipo = %QUINA_COM_7_NUMEROS
            END SELECT
        '
        CASE "MEGASENA"
        '
            SELECT CASE uBolasApostadas
                CASE 6
                    uJogoTipo = %MEGASENA_COM_6_NUMEROS
                CASE 7
                    uJogoTipo = %MEGASENA_COM_7_NUMEROS
                CASE 8
                    uJogoTipo = %MEGASENA_COM_8_NUMEROS
                CASE 9
                    uJogoTipo = %MEGASENA_COM_9_NUMEROS
                CASE 10
                    uJogoTipo = %MEGASENA_COM_10_NUMEROS
                CASE 11
                    uJogoTipo = %MEGASENA_COM_11_NUMEROS
                CASE 12
                    uJogoTipo = %MEGASENA_COM_12_NUMEROS
                CASE 13
                    uJogoTipo = %MEGASENA_COM_13_NUMEROS
                CASE 14
                    uJogoTipo = %MEGASENA_COM_14_NUMEROS
                CASE 15
                    uJogoTipo = %MEGASENA_COM_15_NUMEROS
            END SELECT
        '
        CASE "LOTOFACIL"
            SELECT CASE uBolasApostadas
                CASE 15
                    uJogoTipo = %LOTOFACIL_COM_15_NUMEROS
                CASE 16
                    uJogoTipo = %LOTOFACIL_COM_16_NUMEROS
                CASE 17
                    uJogoTipo = %LOTOFACIL_COM_17_NUMEROS
                CASE 18
                    uJogoTipo = %LOTOFACIL_COM_18_NUMEROS
            END SELECT
    END SELECT


    REGISTER uColuna1 AS LONG, uColuna2 AS LONG, uColuna3 AS LONG, uColuna4 AS LONG
    REGISTER uColuna5 AS LONG, uColuna6 AS LONG, uColuna7 AS LONG, uColuna8 AS LONG
    REGISTER uColuna9 AS LONG, uColuna10 AS LONG, uColuna11 AS LONG, uColuna12 AS LONG
    REGISTER uColuna13 AS LONG, uColuna14 AS LONG, uColuna15 AS LONG

    ' Para os jogos 'MEGASENA' e 'LOTOFACIL', o limite inferior � sempre '1' (um)
    ' entretanto, para o jogo, 'LOTOMANIA', o limite inferior � sempre '0' (zero)
    ' ent�o, devemos definir uColuna1 como o limite inferior do jogo solicitado
    DIM uLimiteInferior AS LONG
    DIM uLimiteSuperior AS LONG
    uLimiteInferior = LBOUND(strBolas(), 1)
    uLimiteSuperior = UBOUND(strBolas(), 1)


    DIM strTexto AS STRING
    strTexto = ""

    DIM uContador AS DWORD
    uContador = 0

    ' Para otimizar cada jogo, irei fazer o loop separado para cada tipo de jogo
    strErro = ""
    SELECT CASE uJogoTipo
        CASE %QUINA_COM_5_NUMEROS
            GOSUB GERAR_QUINA_COM_5_NUMEROS
        '
        CASE %QUINA_COM_6_NUMEROS
            GOSUB GERAR_QUINA_COM_6_NUMEROS
        '
        CASE %QUINA_COM_7_NUMEROS
            GOSUB GERAR_QUINA_COM_7_NUMEROS
        '
        CASE %MEGASENA_COM_6_NUMEROS
            GOSUB GERAR_MEGASENA_COM_6_NUMEROS
        '
        CASE %MEGASENA_COM_7_NUMEROS
            GOSUB GERAR_MEGASENA_COM_7_NUMEROS
        '
        CASE %MEGASENA_COM_8_NUMEROS
            GOSUB GERAR_MEGASENA_COM_8_NUMEROS
        '
        CASE %MEGASENA_COM_9_NUMEROS
            GOSUB GERAR_MEGASENA_COM_9_NUMEROS
        '
        CASE %MEGASENA_COM_10_NUMEROS
            GOSUB GERAR_MEGASENA_COM_10_NUMEROS
        '
        CASE %MEGASENA_COM_11_NUMEROS
            GOSUB GERAR_MEGASENA_COM_11_NUMEROS
        '
        CASE %MEGASENA_COM_12_NUMEROS
            GOSUB GERAR_MEGASENA_COM_12_NUMEROS
        '
        CASE %MEGASENA_COM_13_NUMEROS
            GOSUB GERAR_MEGASENA_COM_13_NUMEROS
        '
        CASE %MEGASENA_COM_14_NUMEROS
            GOSUB GERAR_MEGASENA_COM_14_NUMEROS
        '
        CASE %MEGASENA_COM_15_NUMEROS
            GOSUB GERAR_MEGASENA_COM_15_NUMEROS
    END SELECT

    uSairTodas = 0


    IF strErro <> "" THEN
        MSGBOX strErro, %MB_ICONERROR
    ELSE
        MSGBOX "Executado com sucesso!!!"
    END IF

    EXIT FUNCTION


GERAR_QUINA_COM_5_NUMEROS:
    FOR uColuna1 = uLimiteInferior TO uLimiteSuperior
        FOR uColuna2 = uColuna1 + 1 TO uLimiteSuperior
            FOR uColuna3 = uColuna2 + 1 TO uLimiteSuperior
                FOR uColuna4 = uColuna3 + 1 TO uLimiteSuperior
                    FOR uColuna5 = uColuna4 + 1 TO uLimiteSuperior
                        DIALOG DOEVENTS
                        strTexto = "QUINA_COM_5_NUMEROS;" & strBolas(uColuna1) & ";" & strBolas(uColuna2) & ";" & strBolas(uColuna3) & ";"
                        strTexto = strTexto & strBolas(uColuna4) & ";" & strBolas(uColuna5)
                        PRINT #uArquivoDestino, strTexto
                        IF ERR <> 0 THEN
                            strErro = "Erro: " & ERROR$(ERR)
                            FUNCTION = -1
                            RETURN
                        END IF
                        uContador += 1
                        IF uAtualizarTodas = 1 THEN
                            strTexto = "Qt: " & FORMAT$(uContador, "###,#") & ", " & strTexto
                            CONTROL SET TEXT hJanela_Principal, %IDC_LBL_LOG_TODAS, strTexto
                        END IF

                        ' Se o usu�rio clicou em 'Parar' ou  'Fechou a janela' a vari�vel abaixo deve estar com o valor 1
                        ' para podermos sair do loop
                        IF uSairTodas = 1 THEN
                            strErro = "A gera��o foi interrompida por solicita��o do usu�rio."
                            RETURN
                        END IF

                        ' Se o usu�rio clicar no bot�o 'Pausar' ficar no loop at� que 'Pausar' seja igual a '0' zero
                        ' ou o usu�rio clicou no bot�o 'Parar'
                        DO WHILE uPausarTodas = 1
                            DIALOG DOEVENTS
                        LOOP
                    NEXT uColuna5
                NEXT uColuna4
            NEXT uColuna3
        NEXT uColuna2
    NEXT uColuna1
    '
    RETURN

GERAR_QUINA_COM_6_NUMEROS:
    FOR uColuna1 = uLimiteInferior TO uLimiteSuperior
        FOR uColuna2 = uColuna1 + 1 TO uLimiteSuperior
            FOR uColuna3 = uColuna2 + 1 TO uLimiteSuperior
                FOR uColuna4 = uColuna3 + 1 TO uLimiteSuperior
                    FOR uColuna5 = uColuna4 + 1 TO uLimiteSuperior
                        FOR uColuna6 = uColuna5 + 1 TO uLimiteSuperior
                            DIALOG DOEVENTS
                            strTexto = "QUINA_COM_6_NUMEROS;" & strBolas(uColuna1) & ";" & strBolas(uColuna2) & ";" & strBolas(uColuna3) & ";"
                            strTexto = strTexto & strBolas(uColuna4) & ";" & strBolas(uColuna5) & ";" & strBolas(uColuna6)
                            PRINT #uArquivoDestino, strTexto
                            IF ERR <> 0 THEN
                                strErro = "Erro: " & ERROR$(ERR)
                                FUNCTION = -1
                                RETURN
                            END IF
                            uContador += 1
                            IF uAtualizarTodas = 1 THEN
                                strTexto = "Qt: " & FORMAT$(uContador, "###,#") & ", " & strTexto
                                CONTROL SET TEXT hJanela_Principal, %IDC_LBL_LOG_TODAS, strTexto
                            END IF

                            ' Se o usu�rio clicou em 'Parar' ou  'Fechou a janela' a vari�vel abaixo deve estar com o valor 1
                            ' para podermos sair do loop
                            IF uSairTodas = 1 THEN
                                strErro = "A gera��o foi interrompida por solicita��o do usu�rio."
                                RETURN
                            END IF

                            ' Se o usu�rio clicar no bot�o 'Pausar' ficar no loop at� que 'Pausar' seja igual a '0' zero
                            ' ou o usu�rio clicou no bot�o 'Parar'
                            DO WHILE uPausarTodas = 1
                                DIALOG DOEVENTS
                            LOOP
                        NEXT uColuna6
                    NEXT uColuna5
                NEXT uColuna4
            NEXT uColuna3
        NEXT uColuna2
    NEXT uColuna1
    '
    RETURN

GERAR_QUINA_COM_7_NUMEROS:
    FOR uColuna1 = uLimiteInferior TO uLimiteSuperior
        FOR uColuna2 = uColuna1 + 1 TO uLimiteSuperior
            FOR uColuna3 = uColuna2 + 1 TO uLimiteSuperior
                FOR uColuna4 = uColuna3 + 1 TO uLimiteSuperior
                    FOR uColuna5 = uColuna4 + 1 TO uLimiteSuperior
                        FOR uColuna6 = uColuna5 + 1 TO uLimiteSuperior
                            FOR uColuna7 = uColuna6 + 1 TO uLimiteSuperior
                                DIALOG DOEVENTS
                                strTexto = "QUINA_COM_7_NUMEROS;" & strBolas(uColuna1) & ";" & strBolas(uColuna2) & ";" & strBolas(uColuna3) & ";"
                                strTexto = strTexto & strBolas(uColuna4) & ";" & strBolas(uColuna5) & ";" & strBolas(uColuna6) & ";" & strBolas(uColuna7)
                                PRINT #uArquivoDestino, strTexto
                                IF ERR <> 0 THEN
                                    strErro = "Erro: " & ERROR$(ERR)
                                    FUNCTION = -1
                                    RETURN
                                END IF
                                uContador += 1
                                IF uAtualizarTodas = 1 THEN
                                    strTexto = "Qt: " & FORMAT$(uContador, "###,#") & ", " & strTexto
                                    CONTROL SET TEXT hJanela_Principal, %IDC_LBL_LOG_TODAS, strTexto
                                END IF

                                ' Se o usu�rio clicou em 'Parar' ou  'Fechou a janela' a vari�vel abaixo deve estar com o valor 1
                                ' para podermos sair do loop
                                IF uSairTodas = 1 THEN
                                    strErro = "A gera��o foi interrompida por solicita��o do usu�rio."
                                    RETURN
                                END IF

                                ' Se o usu�rio clicar no bot�o 'Pausar' ficar no loop at� que 'Pausar' seja igual a '0' zero
                                ' ou o usu�rio clicou no bot�o 'Parar'
                                DO WHILE uPausarTodas = 1
                                    DIALOG DOEVENTS
                                LOOP
                            NEXT uColuna7
                        NEXT uColuna6
                    NEXT uColuna5
                NEXT uColuna4
            NEXT uColuna3
        NEXT uColuna2
    NEXT uColuna1
    '
    RETURN

GERAR_MEGASENA_COM_6_NUMEROS:
    FOR uColuna1 = uLimiteInferior TO uLimiteSuperior
        FOR uColuna2 = uColuna1 + 1 TO uLimiteSuperior
            FOR uColuna3 = uColuna2 + 1 TO uLimiteSuperior
                FOR uColuna4 = uColuna3 + 1 TO uLimiteSuperior
                    FOR uColuna5 = uColuna4 + 1 TO uLimiteSuperior
                        FOR uColuna6 = uColuna5 + 1 TO uLimiteSuperior
                            DIALOG DOEVENTS
                            strTexto = "MEGASENA_COM_6_NUMEROS;" & strBolas(uColuna1) & ";" & strBolas(uColuna2) & ";" & strBolas(uColuna3) & ";"
                            strTexto = strTexto & strBolas(uColuna4) & ";" & strBolas(uColuna5) & ";" & strBolas(uColuna6)
                            PRINT #uArquivoDestino, strTexto
                            IF ERR <> 0 THEN
                                strErro = "Erro: " & ERROR$(ERR)
                                FUNCTION = -1
                                RETURN
                            END IF
                            uContador += 1
                            IF uAtualizarTodas = 1 THEN
                                strTexto = "Qt: " & FORMAT$(uContador, "###,#") & ", " & strTexto
                                CONTROL SET TEXT hJanela_Principal, %IDC_LBL_LOG_TODAS, strTexto
                            END IF

                            ' Se o usu�rio clicou em 'Parar' ou  'Fechou a janela' a vari�vel abaixo deve estar com o valor 1
                            ' para podermos sair do loop
                            IF uSairTodas = 1 THEN
                                strErro = "A gera��o foi interrompida por solicita��o do usu�rio."
                                RETURN
                            END IF

                            ' Se o usu�rio clicar no bot�o 'Pausar' ficar no loop at� que 'Pausar' seja igual a '0' zero
                            ' ou o usu�rio clicou no bot�o 'Parar'
                            DO WHILE uPausarTodas = 1
                                DIALOG DOEVENTS
                            LOOP
                        NEXT uColuna6
                    NEXT uColuna5
                NEXT uColuna4
            NEXT uColuna3
        NEXT uColuna2
    NEXT uColuna1
    '
    RETURN

GERAR_MEGASENA_COM_7_NUMEROS:
    FOR uColuna1 = uLimiteInferior TO uLimiteSuperior
        FOR uColuna2 = uColuna1 + 1 TO uLimiteSuperior
            FOR uColuna3 = uColuna2 + 1 TO uLimiteSuperior
                FOR uColuna4 = uColuna3 + 1 TO uLimiteSuperior
                    FOR uColuna5 = uColuna4 + 1 TO uLimiteSuperior
                        FOR uColuna6 = uColuna5 + 1 TO uLimiteSuperior
                            FOR uColuna7 = uColuna6 + 1 TO uLimiteSuperior
                                DIALOG DOEVENTS
                                strTexto = "MEGASENA_COM_7_NUMEROS;" & strBolas(uColuna1) & ";" & strBolas(uColuna2) & ";" & strBolas(uColuna3) & ";"
                                strTexto = strTexto & strBolas(uColuna4) & ";" & strBolas(uColuna5) & ";" & strBolas(uColuna6) & ";" & strBolas(uColuna7)
                                PRINT #uArquivoDestino, strTexto
                                IF ERR <> 0 THEN
                                    strErro = "Erro: " & ERROR$(ERR)
                                    FUNCTION = -1
                                    RETURN
                                END IF
                                uContador += 1
                                IF uAtualizarTodas = 1 THEN
                                    strTexto = "Qt: " & FORMAT$(uContador, "###,#") & ", " & strTexto
                                    CONTROL SET TEXT hJanela_Principal, %IDC_LBL_LOG_TODAS, strTexto
                                END IF

                                ' Se o usu�rio clicar no bot�o 'Pausar' ficar no loop at� que 'Pausar' seja igual a '0' zero
                                ' ou o usu�rio clicou no bot�o 'Parar'
                                DO WHILE uPausarTodas = 1
                                    DIALOG DOEVENTS
                                LOOP
                            NEXT uColuna7
                        NEXT uColuna6
                    NEXT uColuna5
                NEXT uColuna4
            NEXT uColuna3
        NEXT uColuna2
    NEXT uColuna1
    '
    RETURN

GERAR_MEGASENA_COM_8_NUMEROS:
    FOR uColuna1 = uLimiteInferior TO uLimiteSuperior
        FOR uColuna2 = uColuna1 + 1 TO uLimiteSuperior
            FOR uColuna3 = uColuna2 + 1 TO uLimiteSuperior
                FOR uColuna4 = uColuna3 + 1 TO uLimiteSuperior
                    FOR uColuna5 = uColuna4 + 1 TO uLimiteSuperior
                        FOR uColuna6 = uColuna5 + 1 TO uLimiteSuperior
                            FOR uColuna7 = uColuna6 + 1 TO uLimiteSuperior
                                FOR uColuna8 = uColuna7 + 1 TO uLimiteSuperior
                                    DIALOG DOEVENTS
                                    strTexto = "MEGASENA_COM_8_NUMEROS;" & strBolas(uColuna1) & ";" & strBolas(uColuna2) & ";" & strBolas(uColuna3) & ";"
                                    strTexto = strTexto & strBolas(uColuna4) & ";" & strBolas(uColuna5) & ";" & strBolas(uColuna6) & ";" & strBolas(uColuna7) & ";"
                                    strTexto = strTexto & strBolas(uColuna8)
                                    PRINT #uArquivoDestino, strTexto
                                    IF ERR <> 0 THEN
                                        strErro = "Erro: " & ERROR$(ERR)
                                        FUNCTION = -1
                                        RETURN
                                    END IF
                                    uContador += 1
                                    IF uAtualizarTodas = 1 THEN
                                        strTexto = "Qt: " & FORMAT$(uContador, "###,#") & ", " & strTexto
                                        CONTROL SET TEXT hJanela_Principal, %IDC_LBL_LOG_TODAS, strTexto
                                    END IF

                                    ' Se o usu�rio clicou em 'Parar' ou  'Fechou a janela' a vari�vel abaixo deve estar com o valor 1
                                    ' para podermos sair do loop
                                    IF uSairTodas = 1 THEN
                                        strErro = "A gera��o foi interrompida por solicita��o do usu�rio."
                                        RETURN
                                    END IF

                                    ' Se o usu�rio clicar no bot�o 'Pausar' ficar no loop at� que 'Pausar' seja igual a '0' zero
                                    ' ou o usu�rio clicou no bot�o 'Parar'
                                    DO WHILE uPausarTodas = 1
                                        DIALOG DOEVENTS
                                    LOOP
                                NEXT uColuna8
                            NEXT uColuna7
                        NEXT uColuna6
                    NEXT uColuna5
                NEXT uColuna4
            NEXT uColuna3
        NEXT uColuna2
    NEXT uColuna1
    '
    RETURN

GERAR_MEGASENA_COM_9_NUMEROS:
    FOR uColuna1 = uLimiteInferior TO uLimiteSuperior
        FOR uColuna2 = uColuna1 + 1 TO uLimiteSuperior
            FOR uColuna3 = uColuna2 + 1 TO uLimiteSuperior
                FOR uColuna4 = uColuna3 + 1 TO uLimiteSuperior
                    FOR uColuna5 = uColuna4 + 1 TO uLimiteSuperior
                        FOR uColuna6 = uColuna5 + 1 TO uLimiteSuperior
                            FOR uColuna7 = uColuna6 + 1 TO uLimiteSuperior
                                FOR uColuna8 = uColuna7 + 1 TO uLimiteSuperior
                                    FOR uColuna9 = uColuna8 + 1 TO uLimiteSuperior
                                        DIALOG DOEVENTS
                                        strTexto = "MEGASENA_COM_9_NUMEROS;" & strBolas(uColuna1) & ";" & strBolas(uColuna2) & ";" & strBolas(uColuna3) & ";"
                                        strTexto = strTexto & strBolas(uColuna4) & ";" & strBolas(uColuna5) & ";" & strBolas(uColuna6) & ";" & strBolas(uColuna7) & ";"
                                        strTexto = strTexto & strBolas(uColuna8) & ";" & strBolas(uColuna9)
                                        PRINT #uArquivoDestino, strTexto
                                        IF ERR <> 0 THEN
                                            strErro = "Erro: " & ERROR$(ERR)
                                            FUNCTION = -1
                                            RETURN
                                        END IF
                                        uContador += 1
                                        IF uAtualizarTodas = 1 THEN
                                            strTexto = "Qt: " & FORMAT$(uContador, "###,#") & ", " & strTexto
                                            CONTROL SET TEXT hJanela_Principal, %IDC_LBL_LOG_TODAS, strTexto
                                        END IF
                                        ' Se o usu�rio clicou em 'Parar' ou  'Fechou a janela' a vari�vel abaixo deve estar com o valor 1
                                        ' para podermos sair do loop
                                        IF uSairTodas = 1 THEN
                                            strErro = "A gera��o foi interrompida por solicita��o do usu�rio."
                                            RETURN
                                        END IF

                                        ' Se o usu�rio clicar no bot�o 'Pausar' ficar no loop at� que 'Pausar' seja igual a '0' zero
                                        ' ou o usu�rio clicou no bot�o 'Parar'
                                        DO WHILE uPausarTodas = 1
                                            DIALOG DOEVENTS
                                        LOOP
                                    NEXT uColuna9
                                NEXT uColuna8
                            NEXT uColuna7
                        NEXT uColuna6
                    NEXT uColuna5
                NEXT uColuna4
            NEXT uColuna3
        NEXT uColuna2
    NEXT uColuna1
    '
    RETURN

GERAR_MEGASENA_COM_10_NUMEROS:
    FOR uColuna1 = uLimiteInferior TO uLimiteSuperior
        FOR uColuna2 = uColuna1 + 1 TO uLimiteSuperior
            FOR uColuna3 = uColuna2 + 1 TO uLimiteSuperior
                FOR uColuna4 = uColuna3 + 1 TO uLimiteSuperior
                    FOR uColuna5 = uColuna4 + 1 TO uLimiteSuperior
                        FOR uColuna6 = uColuna5 + 1 TO uLimiteSuperior
                            FOR uColuna7 = uColuna6 + 1 TO uLimiteSuperior
                                FOR uColuna8 = uColuna7 + 1 TO uLimiteSuperior
                                    FOR uColuna9 = uColuna8 + 1 TO uLimiteSuperior
                                        FOR uColuna10 = uColuna9 + 1 TO uLimiteSuperior
                                            DIALOG DOEVENTS
                                            strTexto = "MEGASENA_COM_10_NUMEROS;" & strBolas(uColuna1) & ";" & strBolas(uColuna2) & ";" & strBolas(uColuna3) & ";"
                                            strTexto = strTexto & strBolas(uColuna4) & ";" & strBolas(uColuna5) & ";" & strBolas(uColuna6) & ";" & strBolas(uColuna7) & ";"
                                            strTexto = strTexto & strBolas(uColuna8) & ";" & strBolas(uColuna9) & ";" & strBolas(uColuna10)
                                            PRINT #uArquivoDestino, strTexto
                                            IF ERR <> 0 THEN
                                                strErro = "Erro: " & ERROR$(ERR)
                                                FUNCTION = -1
                                                RETURN
                                            END IF
                                            uContador += 1
                                            IF uAtualizarTodas = 1 THEN
                                                strTexto = "Qt: " & FORMAT$(uContador, "###,#") & ", " & strTexto
                                                CONTROL SET TEXT hJanela_Principal, %IDC_LBL_LOG_TODAS, strTexto
                                            END IF
                                            ' Se o usu�rio clicou em 'Parar' ou  'Fechou a janela' a vari�vel abaixo deve estar com o valor 1
                                            ' para podermos sair do loop
                                            IF uSairTodas = 1 THEN
                                                strErro = "A gera��o foi interrompida por solicita��o do usu�rio."
                                                RETURN
                                            END IF

                                            ' Se o usu�rio clicar no bot�o 'Pausar' ficar no loop at� que 'Pausar' seja igual a '0' zero
                                            ' ou o usu�rio clicou no bot�o 'Parar'
                                            DO WHILE uPausarTodas = 1
                                                DIALOG DOEVENTS
                                            LOOP
                                        NEXT uColuna10
                                    NEXT uColuna9
                                NEXT uColuna8
                            NEXT uColuna7
                        NEXT uColuna6
                    NEXT uColuna5
                NEXT uColuna4
            NEXT uColuna3
        NEXT uColuna2
    NEXT uColuna1
    '
    RETURN

GERAR_MEGASENA_COM_11_NUMEROS:
    FOR uColuna1 = uLimiteInferior TO uLimiteSuperior
        FOR uColuna2 = uColuna1 + 1 TO uLimiteSuperior
            FOR uColuna3 = uColuna2 + 1 TO uLimiteSuperior
                FOR uColuna4 = uColuna3 + 1 TO uLimiteSuperior
                    FOR uColuna5 = uColuna4 + 1 TO uLimiteSuperior
                        FOR uColuna6 = uColuna5 + 1 TO uLimiteSuperior
                            FOR uColuna7 = uColuna6 + 1 TO uLimiteSuperior
                                FOR uColuna8 = uColuna7 + 1 TO uLimiteSuperior
                                    FOR uColuna9 = uColuna8 + 1 TO uLimiteSuperior
                                        FOR uColuna10 = uColuna9 + 1 TO uLimiteSuperior
                                            FOR uColuna11 = uColuna10 + 1 TO uLimiteSuperior
                                                DIALOG DOEVENTS
                                                strTexto = "MEGASENA_COM_11_NUMEROS;" & strBolas(uColuna1) & ";" & strBolas(uColuna2) & ";" & strBolas(uColuna3) & ";"
                                                strTexto = strTexto & strBolas(uColuna4) & ";" & strBolas(uColuna5) & ";" & strBolas(uColuna6) & ";" & strBolas(uColuna7) & ";"
                                                strTexto = strTexto & strBolas(uColuna8) & ";" & strBolas(uColuna9) & ";" & strBolas(uColuna10) & ";" & strBolas(uColuna11) & ";"
                                                PRINT #uArquivoDestino, strTexto
                                                IF ERR <> 0 THEN
                                                    strErro = "Erro: " & ERROR$(ERR)
                                                    FUNCTION = -1
                                                    RETURN
                                                END IF
                                                uContador += 1
                                                IF uAtualizarTodas = 1 THEN
                                                    strTexto = "Qt: " & FORMAT$(uContador, "###,#") & ", " & strTexto
                                                    CONTROL SET TEXT hJanela_Principal, %IDC_LBL_LOG_TODAS, strTexto
                                                END IF

                                                ' Se o usu�rio clicou em 'Parar' ou  'Fechou a janela' a vari�vel abaixo deve estar com o valor 1
                                                ' para podermos sair do loop
                                                IF uSairTodas = 1 THEN
                                                    strErro = "A gera��o foi interrompida por solicita��o do usu�rio."
                                                    RETURN
                                                END IF

                                                ' Se o usu�rio clicar no bot�o 'Pausar' ficar no loop at� que 'Pausar' seja igual a '0' zero
                                                ' ou o usu�rio clicou no bot�o 'Parar'
                                                DO WHILE uPausarTodas = 1
                                                    DIALOG DOEVENTS
                                                LOOP
                                            NEXT uColuna11
                                        NEXT uColuna10
                                    NEXT uColuna9
                                NEXT uColuna8
                            NEXT uColuna7
                        NEXT uColuna6
                    NEXT uColuna5
                NEXT uColuna4
            NEXT uColuna3
        NEXT uColuna2
    NEXT uColuna1
    '
    RETURN

GERAR_MEGASENA_COM_12_NUMEROS:
    FOR uColuna1 = uLimiteInferior TO uLimiteSuperior
        FOR uColuna2 = uColuna1 + 1 TO uLimiteSuperior
            FOR uColuna3 = uColuna2 + 1 TO uLimiteSuperior
                FOR uColuna4 = uColuna3 + 1 TO uLimiteSuperior
                    FOR uColuna5 = uColuna4 + 1 TO uLimiteSuperior
                        FOR uColuna6 = uColuna5 + 1 TO uLimiteSuperior
                            FOR uColuna7 = uColuna6 + 1 TO uLimiteSuperior
                                FOR uColuna8 = uColuna7 + 1 TO uLimiteSuperior
                                    FOR uColuna9 = uColuna8 + 1 TO uLimiteSuperior
                                        FOR uColuna10 = uColuna9 + 1 TO uLimiteSuperior
                                            FOR uColuna11 = uColuna10 + 1 TO uLimiteSuperior
                                                FOR uColuna12 = uColuna11 + 1 TO uLimiteSuperior
                                                    DIALOG DOEVENTS
                                                    strTexto = "MEGASENA_COM_12_NUMEROS;" & strBolas(uColuna1) & ";" & strBolas(uColuna2) & ";" & strBolas(uColuna3) & ";"
                                                    strTexto = strTexto & strBolas(uColuna4) & ";" & strBolas(uColuna5) & ";" & strBolas(uColuna6) & ";" & strBolas(uColuna7) & ";"
                                                    strTexto = strTexto & strBolas(uColuna8) & ";" & strBolas(uColuna9) & ";" & strBolas(uColuna10) & ";" & strBolas(uColuna11) & ";"
                                                    strTexto = strTexto & strBolas(uColuna12)
                                                    PRINT #uArquivoDestino, strTexto
                                                    IF ERR <> 0 THEN
                                                        strErro = "Erro: " & ERROR$(ERR)
                                                        FUNCTION = -1
                                                        RETURN
                                                    END IF
                                                    uContador += 1
                                                    IF uAtualizarTodas = 1 THEN
                                                        strTexto = "Qt: " & FORMAT$(uContador, "###,#") & ", " & strTexto
                                                        CONTROL SET TEXT hJanela_Principal, %IDC_LBL_LOG_TODAS, strTexto
                                                    END IF

                                                    ' Se o usu�rio clicou em 'Parar' ou  'Fechou a janela' a vari�vel abaixo deve estar com o valor 1
                                                    ' para podermos sair do loop
                                                    IF uSairTodas = 1 THEN
                                                        strErro = "A gera��o foi interrompida por solicita��o do usu�rio."
                                                        RETURN
                                                    END IF

                                                    ' Se o usu�rio clicar no bot�o 'Pausar' ficar no loop at� que 'Pausar' seja igual a '0' zero
                                                    ' ou o usu�rio clicou no bot�o 'Parar'
                                                    DO WHILE uPausarTodas = 1
                                                        DIALOG DOEVENTS
                                                    LOOP
                                                NEXT uColuna12
                                            NEXT uColuna11
                                        NEXT uColuna10
                                    NEXT uColuna9
                                NEXT uColuna8
                            NEXT uColuna7
                        NEXT uColuna6
                    NEXT uColuna5
                NEXT uColuna4
            NEXT uColuna3
        NEXT uColuna2
    NEXT uColuna1
    '
    RETURN

GERAR_MEGASENA_COM_13_NUMEROS:
    FOR uColuna1 = uLimiteInferior TO uLimiteSuperior
        FOR uColuna2 = uColuna1 + 1 TO uLimiteSuperior
            FOR uColuna3 = uColuna2 + 1 TO uLimiteSuperior
                FOR uColuna4 = uColuna3 + 1 TO uLimiteSuperior
                    FOR uColuna5 = uColuna4 + 1 TO uLimiteSuperior
                        FOR uColuna6 = uColuna5 + 1 TO uLimiteSuperior
                            FOR uColuna7 = uColuna6 + 1 TO uLimiteSuperior
                                FOR uColuna8 = uColuna7 + 1 TO uLimiteSuperior
                                    FOR uColuna9 = uColuna8 + 1 TO uLimiteSuperior
                                        FOR uColuna10 = uColuna9 + 1 TO uLimiteSuperior
                                            FOR uColuna11 = uColuna10 + 1 TO uLimiteSuperior
                                                FOR uColuna12 = uColuna11 + 1 TO uLimiteSuperior
                                                    FOR uColuna13 = uColuna12 + 1 TO uLimiteSuperior
                                                        DIALOG DOEVENTS
                                                        strTexto = "MEGASENA_COM_13_NUMEROS;" & strBolas(uColuna1) & ";" & strBolas(uColuna2) & ";" & strBolas(uColuna3) & ";"
                                                        strTexto = strTexto & strBolas(uColuna4) & ";" & strBolas(uColuna5) & ";" & strBolas(uColuna6) & ";" & strBolas(uColuna7) & ";"
                                                        strTexto = strTexto & strBolas(uColuna8) & ";" & strBolas(uColuna9) & ";" & strBolas(uColuna10) & ";" & strBolas(uColuna11) & ";"
                                                        strTexto = strTexto & strBolas(uColuna12) & ";" & strBolas(uColuna13)
                                                        PRINT #uArquivoDestino, strTexto
                                                        IF ERR <> 0 THEN
                                                            strErro = "Erro: " & ERROR$(ERR)
                                                            FUNCTION = -1
                                                            RETURN
                                                        END IF
                                                        uContador += 1
                                                        IF uAtualizarTodas = 1 THEN
                                                            strTexto = "Qt: " & FORMAT$(uContador, "###,#") & ", " & strTexto
                                                            CONTROL SET TEXT hJanela_Principal, %IDC_LBL_LOG_TODAS, strTexto
                                                        END IF

                                                        ' Se o usu�rio clicou em 'Parar' ou  'Fechou a janela' a vari�vel abaixo deve estar com o valor 1
                                                        ' para podermos sair do loop
                                                        IF uSairTodas = 1 THEN
                                                            strErro = "A gera��o foi interrompida por solicita��o do usu�rio."
                                                            RETURN
                                                        END IF

                                                        ' Se o usu�rio clicar no bot�o 'Pausar' ficar no loop at� que 'Pausar' seja igual a '0' zero
                                                        ' ou o usu�rio clicou no bot�o 'Parar'
                                                        DO WHILE uPausarTodas = 1
                                                            DIALOG DOEVENTS
                                                        LOOP
                                                    NEXT uColuna13
                                                NEXT uColuna12
                                            NEXT uColuna11
                                        NEXT uColuna10
                                    NEXT uColuna9
                                NEXT uColuna8
                            NEXT uColuna7
                        NEXT uColuna6
                    NEXT uColuna5
                NEXT uColuna4
            NEXT uColuna3
        NEXT uColuna2
    NEXT uColuna1
    '
    RETURN

GERAR_MEGASENA_COM_14_NUMEROS:
    FOR uColuna1 = uLimiteInferior TO uLimiteSuperior
        FOR uColuna2 = uColuna1 + 1 TO uLimiteSuperior
            FOR uColuna3 = uColuna2 + 1 TO uLimiteSuperior
                FOR uColuna4 = uColuna3 + 1 TO uLimiteSuperior
                    FOR uColuna5 = uColuna4 + 1 TO uLimiteSuperior
                        FOR uColuna6 = uColuna5 + 1 TO uLimiteSuperior
                            FOR uColuna7 = uColuna6 + 1 TO uLimiteSuperior
                                FOR uColuna8 = uColuna7 + 1 TO uLimiteSuperior
                                    FOR uColuna9 = uColuna8 + 1 TO uLimiteSuperior
                                        FOR uColuna10 = uColuna9 + 1 TO uLimiteSuperior
                                            FOR uColuna11 = uColuna10 + 1 TO uLimiteSuperior
                                                FOR uColuna12 = uColuna11 + 1 TO uLimiteSuperior
                                                    FOR uColuna13 = uColuna12 + 1 TO uLimiteSuperior
                                                        FOR uColuna14 = uColuna13 + 1 TO uLimiteSuperior
                                                            DIALOG DOEVENTS
                                                            strTexto = "MEGASENA_COM_14_NUMEROS;" & strBolas(uColuna1) & ";" & strBolas(uColuna2) & ";" & strBolas(uColuna3) & ";"
                                                            strTexto = strTexto & strBolas(uColuna4) & ";" & strBolas(uColuna5) & ";" & strBolas(uColuna6) & ";" & strBolas(uColuna7) & ";"
                                                            strTexto = strTexto & strBolas(uColuna8) & ";" & strBolas(uColuna9) & ";" & strBolas(uColuna10) & ";" & strBolas(uColuna11) & ";"
                                                            strTexto = strTexto & strBolas(uColuna12) & ";" & strBolas(uColuna13) & ";" & strBolas(uColuna14)
                                                            PRINT #uArquivoDestino, strTexto
                                                            IF ERR <> 0 THEN
                                                                strErro = "Erro: " & ERROR$(ERR)
                                                                FUNCTION = -1
                                                                RETURN
                                                            END IF
                                                            uContador += 1
                                                            IF uAtualizarTodas = 1 THEN
                                                                strTexto = "Qt: " & FORMAT$(uContador, "###,#") & ", " & strTexto
                                                                CONTROL SET TEXT hJanela_Principal, %IDC_LBL_LOG_TODAS, strTexto
                                                            END IF
                                                            ' Se o usu�rio clicou em 'Parar' ou  'Fechou a janela' a vari�vel abaixo deve estar com o valor 1
                                                            ' para podermos sair do loop
                                                            IF uSairTodas = 1 THEN
                                                                strErro = "A gera��o foi interrompida por solicita��o do usu�rio."
                                                                RETURN
                                                            END IF

                                                            ' Se o usu�rio clicar no bot�o 'Pausar' ficar no loop at� que 'Pausar' seja igual a '0' zero
                                                            ' ou o usu�rio clicou no bot�o 'Parar'
                                                            DO WHILE uPausarTodas = 1
                                                                DIALOG DOEVENTS
                                                            LOOP
                                                        NEXT uColuna14
                                                    NEXT uColuna13
                                                NEXT uColuna12
                                            NEXT uColuna11
                                        NEXT uColuna10
                                    NEXT uColuna9
                                NEXT uColuna8
                            NEXT uColuna7
                        NEXT uColuna6
                    NEXT uColuna5
                NEXT uColuna4
            NEXT uColuna3
        NEXT uColuna2
    NEXT uColuna1
    '
    RETURN

GERAR_MEGASENA_COM_15_NUMEROS:
    FOR uColuna1 = uLimiteInferior TO uLimiteSuperior
        FOR uColuna2 = uColuna1 + 1 TO uLimiteSuperior
            FOR uColuna3 = uColuna2 + 1 TO uLimiteSuperior
                FOR uColuna4 = uColuna3 + 1 TO uLimiteSuperior
                    FOR uColuna5 = uColuna4 + 1 TO uLimiteSuperior
                        FOR uColuna6 = uColuna5 + 1 TO uLimiteSuperior
                            FOR uColuna7 = uColuna6 + 1 TO uLimiteSuperior
                                FOR uColuna8 = uColuna7 + 1 TO uLimiteSuperior
                                    FOR uColuna9 = uColuna8 + 1 TO uLimiteSuperior
                                        FOR uColuna10 = uColuna9 + 1 TO uLimiteSuperior
                                            FOR uColuna11 = uColuna10 + 1 TO uLimiteSuperior
                                                FOR uColuna12 = uColuna11 + 1 TO uLimiteSuperior
                                                    FOR uColuna13 = uColuna12 + 1 TO uLimiteSuperior
                                                        FOR uColuna14 = uColuna13 + 1 TO uLimiteSuperior
                                                            FOR uColuna15 = uColuna14 + 1 TO uLimiteSuperior
                                                                DIALOG DOEVENTS
                                                                strTexto = "MEGASENA_COM_15_NUMEROS;" & strBolas(uColuna1) & ";" & strBolas(uColuna2) & ";" & strBolas(uColuna3) & ";"
                                                                strTexto = strTexto & strBolas(uColuna4) & ";" & strBolas(uColuna5) & ";" & strBolas(uColuna6) & ";" & strBolas(uColuna7) & ";"
                                                                strTexto = strTexto & strBolas(uColuna8) & ";" & strBolas(uColuna9) & ";" & strBolas(uColuna10) & ";" & strBolas(uColuna11) & ";"
                                                                strTexto = strTexto & strBolas(uColuna12) & ";" & strBolas(uColuna13) & ";" & strBolas(uColuna14) & ";" & strBolas(uColuna15)
                                                                PRINT #uArquivoDestino, strTexto
                                                                IF ERR <> 0 THEN
                                                                    strErro = "Erro: " & ERROR$(ERR)
                                                                    FUNCTION = -1
                                                                    RETURN
                                                                END IF
                                                                '
                                                                uContador += 1
                                                                IF uAtualizarTodas = 1 THEN
                                                                    strTexto = "Qt: " & FORMAT$(uContador, "###,#") & ", " & strTexto
                                                                    CONTROL SET TEXT hJanela_Principal, %IDC_LBL_LOG_TODAS, strTexto
                                                                END IF
                                                                ' Se o usu�rio clicou em 'Parar' ou  'Fechou a janela' a vari�vel abaixo deve estar com o valor 1
                                                                ' para podermos sair do loop
                                                                IF uSairTodas = 1 THEN
                                                                    strErro = "A gera��o foi interrompida por solicita��o do usu�rio."
                                                                    RETURN
                                                                END IF

                                                                ' Se o usu�rio clicar no bot�o 'Pausar' ficar no loop at� que 'Pausar' seja igual a '0' zero
                                                                ' ou o usu�rio clicou no bot�o 'Parar'
                                                                DO WHILE uPausarTodas = 1
                                                                    DIALOG DOEVENTS
                                                                LOOP
                                                            NEXT uColuna15
                                                        NEXT uColuna14
                                                    NEXT uColuna13
                                                NEXT uColuna12
                                            NEXT uColuna11
                                        NEXT uColuna10
                                    NEXT uColuna9
                                NEXT uColuna8
                            NEXT uColuna7
                        NEXT uColuna6
                    NEXT uColuna5
                NEXT uColuna4
            NEXT uColuna3
        NEXT uColuna2
    NEXT uColuna1
    '
    RETURN










END FUNCTION

'------------------------------------------------------------------------------
'   ** Main Application Entry Point **
'------------------------------------------------------------------------------
FUNCTION PBMAIN()
    PBFormsInitComCtls (%ICC_WIN95_CLASSES OR %ICC_DATE_CLASSES OR _
        %ICC_INTERNET_CLASSES)

    Exibir_Janela_Principal %HWND_DESKTOP
END FUNCTION
'------------------------------------------------------------------------------

'------------------------------------------------------------------------------
'   ** CallBacks **
'------------------------------------------------------------------------------
CALLBACK FUNCTION Janela_Principal_CBK()
    STATIC strErro AS STRING

    SELECT CASE AS LONG CB.MSG
        CASE %WM_INITDIALOG
            ' Initialization handler
            ' Preencher as caixas de combina��o 'JOGO_TIPO' e 'APOSTAR COM'
            Carregar_Lista_Inicial()


        CASE %WM_NCACTIVATE
            STATIC hWndSaveFocus AS DWORD
            IF ISFALSE CB.WPARAM THEN
                ' Save control focus
                hWndSaveFocus = GetFocus()
            ELSEIF hWndSaveFocus THEN
                ' Restore control focus
                SetFocus(hWndSaveFocus)
                hWndSaveFocus = 0
            END IF

        CASE %WM_CLOSE
            IF MSGBOX("Deseja realmente sair, pois se houver gera��o de combina��es, o arquivo ficar� incompleto???", %MB_YESNO, "SAIR???") = %IDYES THEN
                uSairTodas = 1
            END IF
            FUNCTION = 1

        CASE %WM_COMMAND
            ' Process control notifications
            SELECT CASE AS LONG CB.CTL
                ' Se o usu�rio clicar no tipo do jogo, alterar, a caixa de combina��o "QT DE APOSTAS"
                CASE %IDC_CMB_JOGO_TIPO_TODAS
                    IF CB.CTLMSG = %CBN_SELCHANGE THEN
                        DIM strTexto AS STRING
                        DIM uIndice AS LONG

                        COMBOBOX GET SELECT hJanela_Principal, %IDC_CMB_JOGO_TIPO_TODAS TO uIndice
                        COMBOBOX GET TEXT hJanela_Principal, %IDC_CMB_JOGO_TIPO_TODAS, uIndice TO strTexto
                        Carregar_Lista(strTexto)
                    END IF

                ' Se o usu�rio pressionou o bot�o Gerar, verificar ent�o qual
                ' jogo o usu�rio selecionou e a quantidade de bolas apostadas
                CASE %IDC_BTN_GERAR_TODAS
                    IF CB.CTLMSG = %BN_CLICKED THEN


                        ' Verificar qual jogo foi selecionado
                        DIM strJogoSelecionado AS STRING
                        DIM uJogoIndiceSelecionado AS LONG

                        COMBOBOX GET SELECT hJanela_Principal, %IDC_CMB_JOGO_TIPO_TODAS TO uJogoIndiceSelecionado
                        COMBOBOX GET TEXT hJanela_Principal, %IDC_CMB_JOGO_TIPO_TODAS, uIndice TO strJogoSelecionado
                        '
                        ' Verificar qual o tipo de aposta foi selecionado
                        DIM strApostaSelecionado AS STRING
                        DIM uApostaIndiceSelecionado AS LONG

                        COMBOBOX GET SELECT hJanela_Principal, %IDC_CMB_APOSTAR_COM_TODAS TO uApostaIndiceSelecionado
                        COMBOBOX GET TEXT hJanela_Principal, %IDC_CMB_APOSTAR_COM_TODAS, uIndice TO strApostaSelecionado

                        ' A caixa de combina��o come�a com n�meros e depois h� sequ�ncia alfab�ticas, por exemplo
                        ' '5 n�meros', '6 n�meros', ent�o devemos pegar a parte mais a esquerda composta somente de
                        ' n�meros
                        DIM uEspaco AS LONG
                        uEspaco = INSTR(strApostaSelecionado, ANY " ")
                        strApostaSelecionado = LEFT$(strApostaSelecionado, uEspaco - 1)

                        ' Verificar se h� algum pasta v�lida
                        DIM strPastaDestino AS STRING

                        CONTROL GET TEXT hJanela_Principal, %IDC_TXT_PASTA_DESTINO_TODAS TO strPastaDestino
                        IF ISFALSE(ISFOLDER(strPastaDestino)) THEN
                            MSGBOX "A pasta '" & strPastaDestino & "' n�o existe!!!", %MB_ICONERROR
                            EXIT FUNCTION
                        END IF

                        ' Desativar controle
                        CONTROL DISABLE hJanela_Principal, %IDC_BTN_GERAR_TODAS

                        ' Ativar Controle de Parada
                        CONTROL ENABLE hJanela_Principal, %IDC_BTN_PARAR_TODAS

                        IF Gerar_Todas_Combinacoes(strJogoSelecionado, VAL(strApostaSelecionado), strPastaDestino, strErro) = -1 THEN
                            MSGBOX "Um erro ocorreu: '" & strErro & "'.", %MB_ICONERROR
                        END IF

                        ' Ativar controle
                        CONTROL ENABLE hJanela_Principal, %IDC_BTN_GERAR_TODAS

                        ' Desativar Controle de Parada
                        CONTROL DISABLE hJanela_Principal, %IDC_BTN_PARAR_TODAS

                    END IF

                ' Se o usu�rio digita na caixa de texto, ativa ou desativar bot�o gerar
                CASE %IDC_TXT_PASTA_DESTINO_TODAS
                    IF CB.CTLMSG = %EN_CHANGE THEN
                        DIM strTextoDestino AS STRING
                        CONTROL GET TEXT hJanela_Principal, %IDC_TXT_PASTA_DESTINO_TODAS TO strTextoDestino
                        IF strTextoDestino = "" THEN
                            CONTROL DISABLE hJanela_Principal, %IDC_BTN_GERAR_TODAS
                        ELSE
                            CONTROL ENABLE hJanela_Principal, %IDC_BTN_GERAR_TODAS
                        END IF
                    END IF


                ' Se o usu�rio clica no bot�o 'Verificar status da gera��o'
                CASE %IDC_CHK_ATUALIZAR_TODAS
                    IF CB.CTLMSG = %BN_CLICKED THEN
                        CONTROL GET CHECK hJanela_Principal, %IDC_CHK_ATUALIZAR_TODAS TO uAtualizarTodas
                    END IF

                ' Se o usu�rio clicar no bot�o 'PARAR', definir a vari�vel uSairTodas = 1
                CASE %IDC_BTN_PARAR_TODAS
                    IF CB.CTLMSG = %BN_CLICKED THEN
                        uSairTodas = 1
                    END IF

                ' Se o usu�rio clicar no bot�o 'PAUSAR', definir a vari�vel para o valor do checkBox
                CASE %IDC_CHK_PAUSAR_TODAS
                    IF CB.CTLMSG = %BN_CLICKED THEN
                        CONTROL GET CHECK hJanela_Principal, %IDC_CHK_PAUSAR_TODAS TO uPausarTodas
                    END IF

               ' ---------------------------------------------------------------------------------
               ' Vamos analisar a parte referente ao Insert e Where que queremos processar
               ' ---------------------------------------------------------------------------------

               ' Se o usu�rio digita na caixa de texto, verificar se a caixa de texto est�
               ' vazia, se sim, desabilitar controles
               CASE %IDC_TXT_ARQUIVO_ORIGEM, %IDC_TXT_PASTA_DESTINO_INSERT
                   IF CB.CTLMSG = %EN_CHANGE THEN
                       LOCAL strArquivoOrigem AS STRING
                       DIM strPastaDestinoInsert AS STRING

                       CONTROL GET TEXT hJanela_Principal, %IDC_TXT_ARQUIVO_ORIGEM TO strArquivoOrigem
                       CONTROL GET TEXT hJanela_Principal, %IDC_TXT_PASTA_DESTINO_INSERT TO strPastaDestinoInsert

                       ' Se um ou ambos controles que est�o vazios desabilitar outros controles
                       IF strArquivoOrigem = "" OR strPastaDestinoInsert = "" THEN
                           CONTROL DISABLE hJanela_Principal, %IDC_CHK_STATUS_INSERT
                           CONTROL DISABLE hJanela_Principal, %IDC_CHK_PAUSAR_INSERT
                           CONTROL DISABLE hJanela_Principal, %IDC_BTN_PARAR_INSERT
                           CONTROL DISABLE hJanela_Principal, %IDC_BTN_GERAR_INSERT
                       ELSE
                           CONTROL ENABLE hJanela_Principal, %IDC_CHK_STATUS_INSERT
                           CONTROL ENABLE hJanela_Principal, %IDC_CHK_PAUSAR_INSERT
                           CONTROL ENABLE hJanela_Principal, %IDC_BTN_PARAR_INSERT
                           CONTROL ENABLE hJanela_Principal, %IDC_BTN_GERAR_INSERT
                       END IF
                    END IF


                ' Se o usu�rio clicar no bot�o 'Verificar status da Gera��o' definir a vari�vel global
                ' uPausarInsert
                CASE %IDC_CHK_STATUS_INSERT
                    CONTROL GET CHECK hJanela_Principal, %IDC_CHK_STATUS_INSERT TO uAtualizarInsert

                CASE %IDC_CHK_PAUSAR_INSERT
                    CONTROL GET CHECK hJanela_Principal, %IDC_CHK_PAUSAR_INSERT TO uPausarInsert

                CASE %IDC_BTN_GERAR_INSERT
                    LOCAL strArquivoOrigemInsert AS STRING
                    'local strPastaDestinoInsert as string
                    IF CB.CTLMSG = %BN_CLICKED THEN
                        CONTROL GET TEXT hJanela_Principal, %IDC_TXT_ARQUIVO_ORIGEM TO strArquivoOrigemInsert
                        CONTROL GET TEXT hJanela_Principal, %IDC_TXT_PASTA_DESTINO_INSERT TO strPastaDestinoInsert
                    END IF

                    IF Gerar_Insert_Where_Todas_Combinacoes(strArquivoOrigemInsert, strPastaDestinoInsert, strErro) = -1 THEN
                        MSGBOX strErro, %MB_ICONERROR
                        EXIT FUNCTION
                    ELSE
                        MSGBOX "Executado com sucesso!!!"
                        EXIT FUNCTION
                    END IF

                CASE %IDC_BTN_PARAR_INSERT
                    IF MSGBOX("Voc� desejar parar o processamento dos n�meros???", %MB_YESNO, "PARAR") = %IDYES THEN
                        uPararInsert = 1
                    ELSE
                        uPararInsert = 0
                    END IF







            END SELECT
    END SELECT
END FUNCTION
'------------------------------------------------------------------------------

GLOBAL uLinhaInsert AS QUAD
GLOBAL uCombinacoesInsert AS LONG

GLOBAL uMinutoInsert, uSegundoInsert AS LONG
GLOBAL uMiSegundoInsert AS QUAD

GLOBAL uHoraInsertDecorrido, uMinutoInsertDecorrido, uSegundoInsertDecorrido AS LONG
GLOBAL uMiSegundoInsertDecorrido, uTickInsertDecorrido AS QUAD

GLOBAL objRelatorioInicio AS IPOWERTIME


FUNCTION Gerar_Insert_Where_Todas_Combinacoes(BYVAL strArquivoOrigem AS STRING, BYVAL strPastaDestino AS STRING, BYREF strErro AS STRING) AS LONG
    ' Vamos verificar se arquivo de origem existe
    IF ISFALSE(ISFILE(strArquivoOrigem)) THEN
        strErro = "Arquivo '" & strArquivoOrigem & "' n�o existe."
        FUNCTION = -1
        EXIT FUNCTION
    END IF

    ' Vamos verificar se pasta existe
    IF ISFALSE(ISFOLDER(strPastaDestino)) THEN
        strErro = "A pasta '" & strPastaDestino & "' n�o existe."
        FUNCTION = -1
        EXIT FUNCTION
    END IF

    DIM uArquivoOrigem AS LONG
    DIM uArquivoInsert AS LONG
    DIM uArquivoWhere AS LONG

    ' Vamos tentar detectar que tipo de jogo �, abrindo-o e lendo o layout da primeira linha
    uArquivoOrigem = FREEFILE
    OPEN strArquivoOrigem FOR INPUT AS #uArquivoOrigem BASE = 1
    IF ERR <> 0 THEN
        strErro = ERROR$(ERR)
        FUNCTION = -1
        EXIT FUNCTION
    END IF

    ' Se o arquivo est� vazio quer dizer que o arquivo j� est� no fim
    IF ISTRUE(EOF(uArquivoOrigem)) THEN
        strErro = "Arquivo est� vazio."
        FUNCTION = -1
        EXIT FUNCTION
    END IF

    ' Vamos ler a primeira linha para definir as vari�veis que ser�o utilizadas no jogo
    DIM strLinha AS STRING
    LINE INPUT #uArquivoOrigem, strLinha

    ' Vari�vel arranjo para guardar todos os campos
    DIM strCampos() AS STRING
    DIM uCampos AS LONG

    uCampos = PARSECOUNT(strLinha, ANY "_;")
    REDIM strCampos(1 TO uCampos)

    ' Verificar se uCampos � maior que 4 campos
    IF uCampos < 4 THEN
        strErro = "Layout de arquivo inv�lido
        FUNCTION = -1
        EXIT FUNCTION
    END IF

    ' Vamos preencher o arranjo
    PARSE strLinha, strCampos(), ANY "_;"

    ' Verificar se jogo � v�lido
    IF  strCampos(1) <> "QUINA" AND _
        strCampos(1) <> "MEGASENA" AND _
        strCampos(1) <> "LOTOFACIL" AND _
        strCampos(1) <> "LOTOMANIA" THEN
            strErro = "Jogo '" & strCampos(1) & "' inv�lido."
            FUNCTION = -1
            EXIT FUNCTION
    END IF

    ' Verificar se o campo 2 e 4 contenha, respectivamente, as palavras
    ' 'COM' e 'NUMEROS'
    IF (strCampos(2) + strCampos(4)) <> "COMNUMEROS" THEN
        strErro = "Campo 2, deve ter a palavra 'COM' e campo 4, a palavra 'NUMEROS'."
        FUNCTION = -1
        EXIT FUNCTION
    END IF

    ' Vamos verificar a quantidade de bolas apostadas
    ' que fica no campo 3
    DIM uBolasApostadas AS LONG
    uBolasApostadas = VAL(strCampos(3))

    ' De acordo com o jogo, vamos verificar a quantidade de bolas apostadas
    SELECT CASE strCampos(1)
        CASE "QUINA"
            IF uBolasApostadas < 5 AND uBolasApostadas > 7 THEN
                strErro = "No campo 3, a quantidade informada '" & strCampos(3) & _
                "' n�o coincide com a quantidade de n�meros a apostar para o jogo 'QUINA'."
                FUNCTION = -1
                EXIT FUNCTION
            END IF

        CASE "MEGASENA"
            IF uBolasApostadas < 6 AND uBolasApostadas > 15 THEN
                strErro = "No campo 3, a quantidade informada '" & strCampos(3) & _
                "' n�o coincide com a quantidade de n�meros a apostar para o jogo 'MEGASENA'."
                FUNCTION = -1
                EXIT FUNCTION
            END IF

        CASE "LOTOFACIL
            IF uBolasApostadas < 15 AND uBolasApostadas > 18 THEN
                strErro = "No campo 3, a quantidade informada '" & strCampos(3) & _
                "' n�o coincide com a quantidadde de n�meros a apostar para o jogo 'LOTOFACIL'."
                FUNCTION = -1
                EXIT FUNCTION
            END IF

        CASE "LOTOMANIA"
            IF uBolasApostadas <> 50 THEN
                strErro = "No campo 3, a quantidade informada '" & strCampos(3) & _
                "' n�o coincide com a quantidade de n�meros a apostar para o jogo 'LOTOMANIA'."
                FUNCTION = -1
                EXIT FUNCTION
            END IF
    END SELECT

    ' Vamos verificar se a quantidade de campos coincide com a quantidade de bolas apostadas
    IF uCampos - 4 <> uBolasApostadas THEN
        strErro = "A quantidade de bolas n�o corresponde � quantidade de n�meros apostadas."
        FUNCTION = -1
        EXIT FUNCTION
    END IF

    ' Para cada tipo de jogo, h� n�meros diferentes para o limite inferior e superior
    DIM uLimiteInferior  AS LONG
    DIM uLimiteSuperior AS LONG

    SELECT CASE strCampos(1)
        CASE "QUINA"
            uLimiteInferior = 1
            uLimiteSuperior = 80
        CASE "MEGASENA"
            uLimiteInferior = 1
            uLimiteSuperior = 60
        CASE "LOTOFACIL"
            uLimiteInferior = 1
            uLimiteSuperior = 25
        CASE "LOTOMANIA"
            uLimiteInferior = 0
            uLimiteSuperior = 99
    END SELECT

    '
    ' Vamos abrir o arquivo para grava��o posteriormente, mas primeiro criar um arquivo
    '
    DIM objTempo AS IPOWERTIME
    LET objTempo = CLASS "POWERTIME"
    objTempo.Now()

    DIM strTempo AS STRING
    strTempo =  "_" & FORMAT$(objTempo.Day, "00") & "_" & FORMAT$(objTempo.Month, "00") & "_" & FORMAT$(objTempo.Year, "00") & _
                "_" & FORMAT$(objTempo.Hour, "00") & "_" & FORMAT$(objTempo.Minute, "00") & "_" & FORMAT$(objTempo.Second, "00") & _
                "_" & FORMAT$(objTempo.mSecond, "000")

    DIM uWhere AS LONG
    DIM uInsert AS LONG
    DIM strWhere AS STRING
    DIM strInsert AS STRING

    ' Vamos verificar a pasta de destino, se tem o caractere '\'
    IF RIGHT$(strPastaDestino, 1) <> "\" THEN
        strPastaDestino &= "\"
    END IF

    uWhere = FREEFILE
    uInsert = FREEFILE
    strWhere = strPastaDestino &  "WHERE_" & strCampos(1) & "_COM_" & strCampos(3) & "_NUMEROS_" & strTempo & ".txt"
    strInsert = strPastaDestino &  "_INSERT" & strCampos(1) & "_COM_" & strCampos(3) & "_NUMEROS_" & strTempo & ".txt"

    OPEN strWhere FOR OUTPUT AS #uWhere
    IF ERR <> 0 THEN
        strErro = ERROR$(ERR)
        FUNCTION = -1
        EXIT FUNCTION
    END IF

    OPEN strInsert FOR OUTPUT AS #uInsert
    IF ERR <> 0 THEN
        strErro = ERROR$(ERR)
        FUNCTION = -1
        EXIT FUNCTION
    END IF
    '
    '---------------------------------------------------------------------------------------------------------------------------
    '

    ' Como verificamos todos os campos, vamos definir as vari�veis
    DIM strJogo AS STRING           ' Por exemplo, QUINA
    DIM strJogoSubTipo AS STRING    ' Por exemplo, QUINA_COM_5_NUMEROS
    DIM uLimite AS LONG             ' Quantidade de bolas apostadas

    DIM uIndice() AS LONG           ' Guarda as posi��es dos �ndice do arranjo
    DIM uBolas() AS LONG            ' Guarda todas as bolas

    uCombinacoesInsert = 1

    strJogo = strCampos(1)
    strJogoSubTipo = strCampos(1) & "_COM_" & strCampos(3) & "_NUMEROS"
    uBolasApostadas = VAL(strCampos(3))
    REDIM uIndice(1 TO uBolasApostadas)
    REDIM uBolas(1 TO uBolasApostadas)


    LOCAL uColuna1, uColuna2, uColuna3, uColuna4, uColuna5, uColuna6, uColuna7 AS LONG
    LOCAL uColuna8, uColuna9, uColuna10, uColuna11, uColuna12, uColuna13, uColuna14 AS LONG
    LOCAL uColuna15 AS LONG


    ' Vamos definir vari�vel que guardar� o hor�rio de in�cio
    'Dim objRelatorioInicio as ipowertime
    LET objRelatorioInicio = CLASS "POWERTIME"
    objRelatorioInicio.Now()

    ' Vamos para o in�cio do arquivo
    SEEK #uArquivoOrigem, 1
    DO WHILE ISFALSE EOF(uArquivoOrigem)
        ' Ler linha
        LINE INPUT #uArquivoOrigem, strLinha
        IF ERR <> 0 THEN
            strErro = ERROR$(ERR)
            CLOSE
            FUNCTION = -1
            EXIT FUNCTION
        END IF

        uLinhaInsert += 1

        ' Cada campo � separado por '_' e ';'
        ' por exemplo, QUINA_COM_5_NUMEROS;1;2;3;4;5
        ' Vamos validar sempre cada linha lida
        ' Como abrirmos o arquivo anterior, todas os 4 primeiros campos tem que sempre
        ' coincidir, pois isto quer dizer, que refere-se ao mesmo jogo
        DIM uCamposQuantidade AS LONG
        uCamposQuantidade = PARSECOUNT(strLinha, ANY "_;")
        IF uCamposQuantidade <> uCampos THEN
            strErro = "Erro, Linha: " & FORMAT$(uLinhaInsert) & ", quantidade de campos n�o coincide com as quantidade de campos anteriores
            CLOSE
            FUNCTION = -1
            EXIT FUNCTION
        END IF

        ' Colocar campos na vari�vel de arranjo
        PARSE strLinha, strCampos(), ANY "_;"

        ' Verificar se refere-se ao mesmo jogo
        IF ISFALSE(strCampos(1) & "_" & strCampos(2) & "_" & strCampos(3)  & "_NUMEROS" = strJogoSubTipo) THEN
            strErro =   "Erro, linha: " & FORMAT$(uLinhaInsert) & ", o jogo '" & strCampos(1) & "_" & strCampos(2) & "_" & strCampos(3) & _
                        "' n�o se refere ao jogo '" & strJogoSubTipo
            CLOSE
            FUNCTION = -1
            EXIT FUNCTION
        END IF

        ' Verificar se a quantidade de bolas � igual � quantidade de n�meros apostados
        ' Quantidade de n�meros apostados, fica no campo 3 do arranjo 'strCampos'
        IF VAL(strCampos(3)) <> uCamposQuantidade - 4 THEN
            strErro =   "Erro, linha: " & FORMAT$(uLinhaInsert) & ", a quantidade de n�meros apostados: '" & strCampos(3) & _
                        "' n�o coincide com a quantidade de n�meros no campos correspondente desta linha."
            CLOSE
            FUNCTION = -1
            EXIT FUNCTION
        END IF

#IF 0
        ' Quando os strings s�o gravados no arquivo, cada bola deve ter 2 caracteres, pois s�o gravados como string
        ' Verificar se a quantidade de caracteres de cada bola tem 2 caracteres
        DIM uB AS LONG
        FOR uB = 1 TO uBolasApostadas
            IF LEN(strCampos(4 + uB)) <> 2 THEN
                strErro =   "Erro, linha: " & FORMAT$(uLinhaInsert) & ", campo: '" & FORMAT$(4 + uB) & "', cada bola deve ter " & _
                            "2 caracteres, pois os n�meros s�o gravados como sequ�ncia."
                CLOSE
                FUNCTION = -1
                EXIT FUNCTION
            END IF
        NEXT uB

#ENDIF


        DIM strBolas_Combinadas_Conjunto AS STRING
        strBolas_Combinadas_Conjunto = ""

        ' Se chegamos at� aqui, quer dizer, que todos os campos est�o ok
        ' Ent�o vamos atribuir os valores dos campos � vari�vel uBolas()
        DIM uA AS LONG
        FOR uA = 1 TO uBolasApostadas
            uBolas(uA) = VAL(strCampos(4 + uA))
            strBolas_Combinadas_Conjunto += "_" & FORMAT$(uBolas(uA), "00")
        NEXT uA

        ' Vamos verificar se as bolas est�o dentro da faixa
        DIM uVerificarFaixa AS LONG
        ARRAY SCAN uBolas(), < uLimiteInferior , TO uVerificarFaixa
        '
        ' Se encontramos algo, fora da faixa, uVerificarFaixa ser� diferente de zero '0'
        IF uVerificarFaixa <> 0 THEN
            strErro =   "Erro, linha: " & FORMAT$(uLinhaInsert) & ", o valor " & FORMAT$(uBolas(uVerificarFaixa)) & " do campo " & _
                        FORMAT$(uVerificarFaixa + 4) & " est� fora da faixa, a faixa permitida �: " & FORMAT$(uLimiteInferior) & _
                        "-" & FORMAT$(uLimiteSuperior)
            FUNCTION = -1
            EXIT FUNCTION
        END IF

        ARRAY SCAN uBolas(), > uLimiteSuperior , TO uVerificarFaixa
        '
        ' Se encontramos algo, fora da faixa, uVerificarFaixa ser� diferente de zero '0'
        IF uVerificarFaixa <> 0 THEN
            strErro =   "Erro, linha: " & FORMAT$(uLinhaInsert) & ", o valor " & FORMAT$(uBolas(uVerificarFaixa)) & " do campo " & _
                        FORMAT$(uVerificarFaixa + 4) & " est� fora da faixa, a faixa permitida �: " & FORMAT$(uLimiteInferior) & _
                        "-" & FORMAT$(uLimiteSuperior)
            FUNCTION = -1
            EXIT FUNCTION
        END IF


        ' Vamos come�ar a gerar todas as combina��es poss�veis para o jogo especificado
        ' Primeiro vamos classificar o arranjo
        ARRAY SORT uBolas()

        ' O loop abaixo gera todas as combina��es para um conjunto de n�meros, por exemplo, para os n�meros:
        '               *********************
        ' INDICE -->    * 1   *     2    *  3 *  4  *
        ' uBolas -->    * 5     6    *  7 *  8  *
        ' Ent�o fica
        '               * 5                 *
        '               * 5 6
        '               * 5 6 7
        '               * 5 6 7 8
        '               * 5 6 8
        '               * 5 7
        '               * 5 7 8
        '               * 6
        '               * 6 7
        '               * 6 7 8
        '               * 6 8
        '               * 7
        '               * 7 8
        '               * 8

        IF uPararInsert = 1 THEN
            strErro = "Processamento cancelado por solicitacao do usu�rio"
            CLOSE
            FUNCTION = -1
            EXIT FUNCTION
        END IF


        DIM objAgora AS IPOWERTIME
        LET objAgora = CLASS "POWERTIME"
        objAgora.now()

        FOR uColuna1 = 1 TO uBolasApostadas
            uIndice(1) = uColuna1
            Gerar_Arquivo_Insert_Where_Todas_Combinacoes(strJogo, strJogoSubTipo, strBolas_Combinadas_Conjunto, uBolasApostadas, uInsert, uWhere, uBolas(), uIndice(), 1)
            '
            FOR uColuna2 = uColuna1 + 1 TO uBolasApostadas
                uIndice(2) = uColuna2
                Gerar_Arquivo_Insert_Where_Todas_Combinacoes(strJogo, strJogoSubTipo, strBolas_Combinadas_Conjunto, uBolasApostadas, uInsert, uWhere, uBolas(), uIndice(), 2)
                '
                FOR uColuna3 = uColuna2 + 1 TO uBolasApostadas
                    uIndice(3) = uColuna3
                    Gerar_Arquivo_Insert_Where_Todas_Combinacoes(strJogo, strJogoSubTipo, strBolas_Combinadas_Conjunto, uBolasApostadas, uInsert, uWhere, uBolas(), uIndice(), 3)
                    '
                    FOR uColuna4 = uColuna3 + 1 TO uBolasApostadas
                        uIndice(4) = uColuna4
                        Gerar_Arquivo_Insert_Where_Todas_Combinacoes(strJogo, strJogoSubTipo, strBolas_Combinadas_Conjunto, uBolasApostadas, uInsert, uWhere, uBolas(), uIndice(), 4)
                        '
                        FOR uColuna5 = uColuna4 + 1 TO uBolasApostadas
                            uIndice(5) = uColuna5
                            Gerar_Arquivo_Insert_Where_Todas_Combinacoes(strJogo, strJogoSubTipo, strBolas_Combinadas_Conjunto, uBolasApostadas, uInsert, uWhere, uBolas(), uIndice(), 5)
                            '
                            FOR uColuna6 = uColuna5 + 1 TO uBolasApostadas
                                uIndice(6) = uColuna6
                                Gerar_Arquivo_Insert_Where_Todas_Combinacoes(strJogo, strJogoSubTipo, strBolas_Combinadas_Conjunto, uBolasApostadas, uInsert, uWhere, uBolas(), uIndice(), 6)
                                '
                                FOR uColuna7 = uColuna6 + 1 TO uBolasApostadas
                                    uIndice(7) = uColuna7
                                    Gerar_Arquivo_Insert_Where_Todas_Combinacoes(strJogo, strJogoSubTipo, strBolas_Combinadas_Conjunto, uBolasApostadas, uInsert, uWhere, uBolas(), uIndice(), 7)
                                    '
                                    FOR uColuna8 = uColuna7 + 1 TO uBolasApostadas
                                        uIndice(8) = uColuna8
                                        Gerar_Arquivo_Insert_Where_Todas_Combinacoes(strJogo, strJogoSubTipo, strBolas_Combinadas_Conjunto, uBolasApostadas, uInsert, uWhere, uBolas(), uIndice(), 8)
                                        '
                                        FOR uColuna9 = uColuna8 + 1 TO uBolasApostadas
                                            uIndice(9) = uColuna9
                                            Gerar_Arquivo_Insert_Where_Todas_Combinacoes(strJogo, strJogoSubTipo, strBolas_Combinadas_Conjunto, uBolasApostadas, uInsert, uWhere, uBolas(), uIndice(), 9)
                                            '
                                            FOR uColuna10 = uColuna9 + 1 TO uBolasApostadas
                                                uIndice(10) = uColuna10
                                                Gerar_Arquivo_Insert_Where_Todas_Combinacoes(strJogo, strJogoSubTipo, strBolas_Combinadas_Conjunto, uBolasApostadas, uInsert, uWhere, uBolas(), uIndice(), 10)
                                                '
                                                FOR uColuna11 = uColuna10 + 1 TO uBolasApostadas
                                                    uIndice(11) = uColuna11
                                                    Gerar_Arquivo_Insert_Where_Todas_Combinacoes(strJogo, strJogoSubTipo, strBolas_Combinadas_Conjunto, uBolasApostadas, uInsert, uWhere, uBolas(), uIndice(), 11)
                                                    '
                                                    FOR uColuna12 = uColuna11 + 1 TO uBolasApostadas
                                                        uIndice(12) = uColuna12
                                                        Gerar_Arquivo_Insert_Where_Todas_Combinacoes(strJogo, strJogoSubTipo, strBolas_Combinadas_Conjunto, uBolasApostadas, uInsert, uWhere, uBolas(), uIndice(), 12)
                                                        '
                                                        FOR uColuna13 = uColuna12 + 1 TO uBolasApostadas
                                                            uIndice(13) = uColuna13
                                                            Gerar_Arquivo_Insert_Where_Todas_Combinacoes(strJogo, strJogoSubTipo, strBolas_Combinadas_Conjunto, uBolasApostadas, uInsert, uWhere, uBolas(), uIndice(), 13)
                                                            '
                                                            FOR uColuna14 = uColuna13 + 1 TO uBolasApostadas
                                                                uIndice(14) = uColuna14
                                                                Gerar_Arquivo_Insert_Where_Todas_Combinacoes(strJogo, strJogoSubTipo, strBolas_Combinadas_Conjunto, uBolasApostadas, uInsert, uWhere, uBolas(), uIndice(), 14)
                                                                '
                                                                FOR uColuna15 = uColuna14 + 1 TO uBolasApostadas
                                                                    uIndice(15) = uColuna15
                                                                    Gerar_Arquivo_Insert_Where_Todas_Combinacoes(strJogo, strJogoSubTipo, strBolas_Combinadas_Conjunto, uBolasApostadas, uInsert, uWhere, uBolas(), uIndice(), 8)
                                                                NEXT uColuna15
                                                            NEXT uColuna14
                                                        NEXT uColuna13
                                                    NEXT uColuna12
                                                NEXT uColuna11
                                            NEXT uColuna10
                                        NEXT uColuna9
                                    NEXT uColuna8
                                NEXT uColuna7
                            NEXT uColuna6
                        NEXT uColuna5
                    NEXT uColuna4
                NEXT uColuna3
            NEXT uColuna2
        NEXT uColuna1

        CLOSE

        LOCAL uSinal AS LONG
        LOCAL objDepois AS IPOWERTIME
        objDepois = CLASS "POWERTIME"
        objDepois.now()
        objDepois.TimeDiff(objAgora, uSinal, BYVAL 0, BYVAL 0, uMinutoInsert, uSegundoInsert, uMiSegundoInsert)
    LOOP

    LOCAL objRelatorioFinal AS IPOWERTIME
    LET objRelatorioFinal = CLASS "POWERTIME"
    LOCAL uSinalFinal AS LONG

    objRelatorioFinal.Now()
    objRelatorioFinal.TimeDiff(objRelatorioInicio, uSinalFinal, BYVAL 0, uHoraInsertDecorrido, uMinutoInsertDecorrido, _
                                uSegundoInsertDecorrido, uMiSegundoInsertDecorrido, uTickInsertDecorrido)

    DIM strFinal AS STRING
    strFinal =      "Tempo_Decorrido: " + FORMAT$(uHoraInsertDecorrido, "00") + "h," + FORMAT$(uMinutoInsertDecorrido, "00") + "min," + _
                    FORMAT$(uSegundoInsertDecorrido, "00") + "sec," + FORMAT$(uMiSegundoInsertDecorrido, "000") + "msec," + _
                    FORMAT$(uTickInsertDecorrido, "000") + "tick, "

    MSGBOX strFinal





END FUNCTION

'
' Grava no arquivo em um formato que podemos utilizar futuramente em um banco de dados
' os par�metros da fun��o s�o:
'
'   strJogo:                            O nome do jogo, por exemplo, "QUINA"
'   strBolas_Combinadas_Conjunto:       Um string que representa todas as bolas do conjunto
'   uInsert:                            Identificador utilizado pela senten�a OPEN para gravar o arquivo
'   uWhere:                             Identificador utilizado pela senten�a OPEN para gravar o arquivo
'   uBolas():                           Vari�vel arranjo que guarda todas as bolas
'   uIndice():                          Est� vari�vel indica em qual �ndice deve pegar no arranjo uBolas
'   uLimite:                            Vari�vel que indica quantos �tens ser� composto o subconjunto dos n�meros
'
SUB Gerar_Arquivo_Insert_Where_Todas_Combinacoes(BYVAL strJogo AS STRING,  BYVAL strJogoSubTipo AS STRING, _
                                                BYVAL strBolas_Combinadas_Conjunto AS STRING, BYVAL uBolasApostadas AS LONG, _
                                                BYVAL uInsert AS LONG, BYVAL uWhere AS LONG, _
                                                BYREF uBolas() AS LONG, BYREF uIndice() AS LONG, _
                                                BYVAL uLimite AS LONG)
    DIALOG DOEVENTS

    DIM lngA AS LONG
    DIM strBolas_Combinadas AS STRING

    uCombinacoesInsert += 1



    strBolas_Combinadas = ""
    FOR lngA = 1 TO uLimite
        strBolas_Combinadas = strBolas_Combinadas & "_" & FORMAT$(uBolas(uIndice(lngA)), "00")
    NEXT

    ' Gerar Insert para colocar na tabela
    DIM strInsert AS STRING
    strInsert = "Insert into JOGO_BOLAS_COMBINADAS (JOGO_TIPO, JOGO_SUB_TIPO, BOLAS_COMBINADAS_BASE, BOLAS_COMBINADAS_BASE_QT, BOLAS_COMBINADAS, BOLAS_QUANTIDADE) VALUES ("
    strInsert &= "'" & strJogo & "', "
    strInsert &= "'" & strJogoSubTipo & "', "
    strInsert &= "'" & strBolas_Combinadas_Conjunto & "', "
    strInsert &= FORMAT$(uBolasApostadas) & ", "
    strInsert &= "'" & strBolas_Combinadas & "', "
    strInsert &= FORMAT$(uLimite) & ")"

    PRINT #uInsert, strInsert

    ' Gerar Select para verificar se j� foi inserido
    DIM strWhere AS STRING
    strWhere =  "Select * from JOGO_BOLAS_COMBINADAS WHERE JOGO_TIPO = '" & strJogo & "' "
    strWhere &= "AND JOGO_SUB_TIPO = '" & strJogoSubTipo & "' "
    strWhere &= "AND BOLAS_COMBINADAS_BASE = '" & strBolas_Combinadas_Conjunto & "' "
    strWhere &= "AND BOLAS_COMBINADAS = '" & strBolas_Combinadas & "'"
    PRINT #uWhere, strWhere

    DIM strTexto AS STRING
    IF uAtualizarInsert = 1 THEN
        ' Se atualizaremos a tela, ent�o devemos, verificar o tempo decorrido
        DIM uSinal AS LONG
        DIM objRelatorioDecorrido AS IPOWERTIME
        objRelatorioDecorrido = CLASS "POWERTIME"
        objRelatorioDecorrido.Now()
        objRelatorioDecorrido.TimeDiff(objRelatorioInicio, uSinal, BYVAL 0, uHoraInsertDecorrido, uMinutoInsertDecorrido, _
                                        uSegundoInsertDecorrido, uMiSegundoInsertDecorrido, uTickInsertDecorrido)


        strTexto =  "Linha: " & FORMAT$(uLinhaInsert, "000000000,") & $CRLF & _
                    FORMAT$(uCombinacoesInsert, "000000000,") & " j� processadas. " & $CRLF & _
                    "Tempo_An�lise_Linha: " + FORMAT$(uMinutoInsert, "00") & "min," & FORMAT$(uSegundoInsert, "00") & "sec," & _
                    FORMAT$(uMiSegundoInsert, "00") & "msec " & $CRLF & _
                    "Tempo_Decorrido: " + FORMAT$(uHoraInsertDecorrido, "00") + "h," + FORMAT$(uMinutoInsertDecorrido, "00") + "min," + _
                    FORMAT$(uSegundoInsertDecorrido, "00") + "sec," + FORMAT$(uMiSegundoInsertDecorrido, "000") + "msec," + _
                    FORMAT$(uTickInsertDecorrido, "000") + "tick, " + _
                    "BOLAS_CONJUNTO: '" & _
                    strBolas_Combinadas_Conjunto & "', BOLAS_COMBINADAS: '" & strBolas_Combinadas & "', " & _
                    FORMAT$(uCombinacoesInsert, "###,") & "."
        CONTROL SET TEXT hJanela_Principal, %IDC_LOG_INSERT, strTexto
    END IF

END SUB

'------------------------------------------------------------------------------
'   ** Dialogs **
'------------------------------------------------------------------------------
FUNCTION Exibir_Janela_Principal(BYVAL hParent AS DWORD) AS LONG
    LOCAL lRslt AS LONG

#PBFORMS BEGIN DIALOG %IDD_DIALOG1->->
    LOCAL hDlg  AS DWORD

    DIALOG NEW hParent, "Analisador e Gerador - LTK", 168, 211, 563, 166, _
        %WS_POPUP OR %WS_BORDER OR %WS_DLGFRAME OR %WS_SYSMENU OR _
        %WS_MINIMIZEBOX OR %WS_CLIPSIBLINGS OR %WS_VISIBLE OR %DS_MODALFRAME _
        OR %DS_3DLOOK OR %DS_NOFAILCREATE OR %DS_SETFONT, _
        %WS_EX_CONTROLPARENT OR %WS_EX_LEFT OR %WS_EX_LTRREADING OR _
        %WS_EX_RIGHTSCROLLBAR, TO hDlg
    CONTROL ADD FRAME,    hDlg, %IDC_FRAME1, "Gerar todas as combina��es", 5, _
        5, 275, 95
    CONTROL ADD COMBOBOX, hDlg, %IDC_CMB_JOGO_TIPO_TODAS, , 10, 25, 95, 40, _
        %WS_CHILD OR %WS_VISIBLE OR %WS_TABSTOP OR %WS_VSCROLL OR _
        %CBS_DROPDOWNLIST, %WS_EX_LEFT OR %WS_EX_LTRREADING OR _
        %WS_EX_RIGHTSCROLLBAR
    CONTROL ADD COMBOBOX, hDlg, %IDC_CMB_APOSTAR_COM_TODAS, , 115, 25, 100, _
        40, %WS_CHILD OR %WS_VISIBLE OR %WS_TABSTOP OR %WS_VSCROLL OR _
        %CBS_DROPDOWNLIST, %WS_EX_LEFT OR %WS_EX_LTRREADING OR _
        %WS_EX_RIGHTSCROLLBAR
    CONTROL ADD TEXTBOX,  hDlg, %IDC_TXT_PASTA_DESTINO_TODAS, "C:\TMP\", 10, _
        50, 265, 15
    CONTROL ADD CHECKBOX, hDlg, %IDC_CHK_ATUALIZAR_TODAS, "Verificar status " + _
        "da gera��o", 10, 85, 100, 10
    CONTROL ADD BUTTON,   hDlg, %IDC_BTN_GERAR_TODAS, "Gerar", 225, 80, 50, _
        15
    CONTROL ADD LABEL,    hDlg, %IDC_LABEL1, "Jogo:", 10, 15, 75, 10
    CONTROL ADD LABEL,    hDlg, %IDC_LABEL2, "&Apostas com:", 115, 15, 75, 10
    CONTROL ADD LABEL,    hDlg, %IDC_LABEL3, "Pasta de destino (nome do " + _
        "arquivo gerado automaticamente):", 10, 40, 200, 10
    CONTROL ADD LABEL,    hDlg, %IDC_LBL_LOG_TODAS, "", 10, 65, 265, 15
    CONTROL ADD FRAME,    hDlg, %IDC_FRAME2, "Gerar Insert e Where para todas " + _
        "as combina��es", 284, 5, 271, 145
    CONTROL ADD LABEL,    hDlg, %IDC_LABEL4, "Nome do arquivo:", 290, 15, _
        100, 10
    CONTROL ADD TEXTBOX,  hDlg, %IDC_TXT_ARQUIVO_ORIGEM, "", 290, 25, 260, 13
    CONTROL ADD TEXTBOX,  hDlg, %IDC_TXT_PASTA_DESTINO_INSERT, "C:\TMP\", _
        290, 50, 260, 15
    CONTROL ADD LABEL,    hDlg, %IDC_LABEL5, "&Pasta de destino", 290, 40, _
        100, 10
    CONTROL ADD CHECKBOX, hDlg, %IDC_CHK_STATUS_INSERT, "Verificar status da " + _
        "gera��o", 290, 135, 100, 10
    CONTROL ADD BUTTON,   hDlg, %IDC_BTN_GERAR_INSERT, "Gerar", 500, 130, 50, _
        15
    CONTROL ADD LABEL,    hDlg, %IDC_LOG_INSERT, "", 290, 65, 260, 45
    CONTROL ADD BUTTON,   hDlg, %IDC_BTN_PARAR_TODAS, "&Parar", 170, 80, 50, _
        15, %WS_CHILD OR %WS_VISIBLE OR %WS_DISABLED OR %WS_TABSTOP OR _
        %BS_TEXT OR %BS_PUSHBUTTON OR %BS_CENTER OR %BS_VCENTER, %WS_EX_LEFT _
        OR %WS_EX_LTRREADING
    CONTROL ADD BUTTON,   hDlg, %IDC_BTN_PARAR_INSERT, "&Parar", 440, 130, _
        50, 15, %WS_CHILD OR %WS_VISIBLE OR %WS_DISABLED OR %WS_TABSTOP OR _
        %BS_TEXT OR %BS_PUSHBUTTON OR %BS_CENTER OR %BS_VCENTER, %WS_EX_LEFT _
        OR %WS_EX_LTRREADING
    CONTROL ADD CHECKBOX, hDlg, %IDC_CHK_PAUSAR_TODAS, "PAUSA&R", 115, 84, _
        50, 10
    CONTROL ADD CHECKBOX, hDlg, %IDC_CHK_PAUSAR_INSERT, "PAUSA&R", 390, 135, _
        50, 10
#PBFORMS END DIALOG

        hJanela_Principal = hDlg

    DIALOG SHOW MODAL hDlg, CALL Janela_Principal_CBK TO lRslt


#PBFORMS BEGIN CLEANUP %IDD_DIALOG1
#PBFORMS END CLEANUP

    FUNCTION = lRslt
END FUNCTION
'------------------------------------------------------------------------------
