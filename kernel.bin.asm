00030400  BCE0630300        mov esp,0x363e0
00030405  C705EC7905000000  mov dword [dword 0x579ec],0x0
         -0000
0003040F  0F0105F0790500    sgdt [dword 0x579f0]
00030416  E80D030000        call dword 0x30728
0003041B  0F0115F0790500    lgdt [dword 0x579f0]
00030422  0F011DE0640300    lidt [dword 0x364e0]
00030429  EA300403000800    jmp dword 0x8:0x30430
00030430  31C0              xor eax,eax
00030432  66B82000          mov ax,0x20
00030436  0F00D8            ltr ax
00030439  E97F030000        jmp dword 0x307bd
0003043E  90                nop
0003043F  90                nop
00030440  E853020000        call dword 0x30698
00030445  E421              in al,0x21
00030447  0C01              or al,0x1
00030449  E621              out 0x21,al
0003044B  B020              mov al,0x20
0003044D  E620              out 0x20,al
0003044F  FB                sti
00030450  6A00              push byte +0x0
00030452  FF1520830500      call dword [dword 0x58320]
00030458  59                pop ecx
00030459  FA                cli
0003045A  E421              in al,0x21
0003045C  24FE              and al,0xfe
0003045E  E621              out 0x21,al
00030460  C3                ret
00030461  90                nop
00030462  90                nop
00030463  90                nop
00030464  90                nop
00030465  90                nop
00030466  90                nop
00030467  90                nop
00030468  90                nop
00030469  90                nop
0003046A  90                nop
0003046B  90                nop
0003046C  90                nop
0003046D  90                nop
0003046E  90                nop
0003046F  90                nop
00030470  E823020000        call dword 0x30698
00030475  E421              in al,0x21
00030477  0C02              or al,0x2
00030479  E621              out 0x21,al
0003047B  B020              mov al,0x20
0003047D  E620              out 0x20,al
0003047F  FB                sti
00030480  6A01              push byte +0x1
00030482  FF1524830500      call dword [dword 0x58324]
00030488  59                pop ecx
00030489  FA                cli
0003048A  E421              in al,0x21
0003048C  24FD              and al,0xfd
0003048E  E621              out 0x21,al
00030490  C3                ret
00030491  90                nop
00030492  90                nop
00030493  90                nop
00030494  90                nop
00030495  90                nop
00030496  90                nop
00030497  90                nop
00030498  90                nop
00030499  90                nop
0003049A  90                nop
0003049B  90                nop
0003049C  90                nop
0003049D  90                nop
0003049E  90                nop
0003049F  90                nop
000304A0  E8F3010000        call dword 0x30698
000304A5  E421              in al,0x21
000304A7  0C04              or al,0x4
000304A9  E621              out 0x21,al
000304AB  B020              mov al,0x20
000304AD  E620              out 0x20,al
000304AF  FB                sti
000304B0  6A02              push byte +0x2
000304B2  FF1528830500      call dword [dword 0x58328]
000304B8  59                pop ecx
000304B9  FA                cli
000304BA  E421              in al,0x21
000304BC  24FB              and al,0xfb
000304BE  E621              out 0x21,al
000304C0  C3                ret
000304C1  90                nop
000304C2  90                nop
000304C3  90                nop
000304C4  90                nop
000304C5  90                nop
000304C6  90                nop
000304C7  90                nop
000304C8  90                nop
000304C9  90                nop
000304CA  90                nop
000304CB  90                nop
000304CC  90                nop
000304CD  90                nop
000304CE  90                nop
000304CF  90                nop
000304D0  E8C3010000        call dword 0x30698
000304D5  E421              in al,0x21
000304D7  0C08              or al,0x8
000304D9  E621              out 0x21,al
000304DB  B020              mov al,0x20
000304DD  E620              out 0x20,al
000304DF  FB                sti
000304E0  6A03              push byte +0x3
000304E2  FF152C830500      call dword [dword 0x5832c]
000304E8  59                pop ecx
000304E9  FA                cli
000304EA  E421              in al,0x21
000304EC  24F7              and al,0xf7
000304EE  E621              out 0x21,al
000304F0  C3                ret
000304F1  90                nop
000304F2  90                nop
000304F3  90                nop
000304F4  90                nop
000304F5  90                nop
000304F6  90                nop
000304F7  90                nop
000304F8  90                nop
000304F9  90                nop
000304FA  90                nop
000304FB  90                nop
000304FC  90                nop
000304FD  90                nop
000304FE  90                nop
000304FF  90                nop
00030500  E893010000        call dword 0x30698
00030505  E421              in al,0x21
00030507  0C10              or al,0x10
00030509  E621              out 0x21,al
0003050B  B020              mov al,0x20
0003050D  E620              out 0x20,al
0003050F  FB                sti
00030510  6A04              push byte +0x4
00030512  FF1530830500      call dword [dword 0x58330]
00030518  59                pop ecx
00030519  FA                cli
0003051A  E421              in al,0x21
0003051C  24EF              and al,0xef
0003051E  E621              out 0x21,al
00030520  C3                ret
00030521  90                nop
00030522  90                nop
00030523  90                nop
00030524  90                nop
00030525  90                nop
00030526  90                nop
00030527  90                nop
00030528  90                nop
00030529  90                nop
0003052A  90                nop
0003052B  90                nop
0003052C  90                nop
0003052D  90                nop
0003052E  90                nop
0003052F  90                nop
00030530  E863010000        call dword 0x30698
00030535  E421              in al,0x21
00030537  0C20              or al,0x20
00030539  E621              out 0x21,al
0003053B  B020              mov al,0x20
0003053D  E620              out 0x20,al
0003053F  FB                sti
00030540  6A05              push byte +0x5
00030542  FF1534830500      call dword [dword 0x58334]
00030548  59                pop ecx
00030549  FA                cli
0003054A  E421              in al,0x21
0003054C  24DF              and al,0xdf
0003054E  E621              out 0x21,al
00030550  C3                ret
00030551  90                nop
00030552  90                nop
00030553  90                nop
00030554  90                nop
00030555  90                nop
00030556  90                nop
00030557  90                nop
00030558  90                nop
00030559  90                nop
0003055A  90                nop
0003055B  90                nop
0003055C  90                nop
0003055D  90                nop
0003055E  90                nop
0003055F  90                nop
00030560  E833010000        call dword 0x30698
00030565  E421              in al,0x21
00030567  0C40              or al,0x40
00030569  E621              out 0x21,al
0003056B  B020              mov al,0x20
0003056D  E620              out 0x20,al
0003056F  FB                sti
00030570  6A06              push byte +0x6
00030572  FF1538830500      call dword [dword 0x58338]
00030578  59                pop ecx
00030579  FA                cli
0003057A  E421              in al,0x21
0003057C  24BF              and al,0xbf
0003057E  E621              out 0x21,al
00030580  C3                ret
00030581  90                nop
00030582  90                nop
00030583  90                nop
00030584  90                nop
00030585  90                nop
00030586  90                nop
00030587  90                nop
00030588  90                nop
00030589  90                nop
0003058A  90                nop
0003058B  90                nop
0003058C  90                nop
0003058D  90                nop
0003058E  90                nop
0003058F  90                nop
00030590  E803010000        call dword 0x30698
00030595  E421              in al,0x21
00030597  0C80              or al,0x80
00030599  E621              out 0x21,al
0003059B  B020              mov al,0x20
0003059D  E620              out 0x20,al
0003059F  FB                sti
000305A0  6A07              push byte +0x7
000305A2  FF153C830500      call dword [dword 0x5833c]
000305A8  59                pop ecx
000305A9  FA                cli
000305AA  E421              in al,0x21
000305AC  247F              and al,0x7f
000305AE  E621              out 0x21,al
000305B0  C3                ret
000305B1  90                nop
000305B2  90                nop
000305B3  90                nop
000305B4  90                nop
000305B5  90                nop
000305B6  90                nop
000305B7  90                nop
000305B8  90                nop
000305B9  90                nop
000305BA  90                nop
000305BB  90                nop
000305BC  90                nop
000305BD  90                nop
000305BE  90                nop
000305BF  90                nop
000305C0  6A08              push byte +0x8
000305C2  E8F6060000        call dword 0x30cbd
000305C7  83C404            add esp,byte +0x4
000305CA  F4                hlt
000305CB  90                nop
000305CC  90                nop
000305CD  90                nop
000305CE  90                nop
000305CF  90                nop
000305D0  6A09              push byte +0x9
000305D2  E8E6060000        call dword 0x30cbd
000305D7  83C404            add esp,byte +0x4
000305DA  F4                hlt
000305DB  90                nop
000305DC  90                nop
000305DD  90                nop
000305DE  90                nop
000305DF  90                nop
000305E0  6A0A              push byte +0xa
000305E2  E8D6060000        call dword 0x30cbd
000305E7  83C404            add esp,byte +0x4
000305EA  F4                hlt
000305EB  90                nop
000305EC  90                nop
000305ED  90                nop
000305EE  90                nop
000305EF  90                nop
000305F0  6A0B              push byte +0xb
000305F2  E8C6060000        call dword 0x30cbd
000305F7  83C404            add esp,byte +0x4
000305FA  F4                hlt
000305FB  90                nop
000305FC  90                nop
000305FD  90                nop
000305FE  90                nop
000305FF  90                nop
00030600  6A0C              push byte +0xc
00030602  E8B6060000        call dword 0x30cbd
00030607  83C404            add esp,byte +0x4
0003060A  F4                hlt
0003060B  90                nop
0003060C  90                nop
0003060D  90                nop
0003060E  90                nop
0003060F  90                nop
00030610  6A0D              push byte +0xd
00030612  E8A6060000        call dword 0x30cbd
00030617  83C404            add esp,byte +0x4
0003061A  F4                hlt
0003061B  90                nop
0003061C  90                nop
0003061D  90                nop
0003061E  90                nop
0003061F  90                nop
00030620  6A0E              push byte +0xe
00030622  E896060000        call dword 0x30cbd
00030627  83C404            add esp,byte +0x4
0003062A  F4                hlt
0003062B  90                nop
0003062C  90                nop
0003062D  90                nop
0003062E  90                nop
0003062F  90                nop
00030630  6A0F              push byte +0xf
00030632  E886060000        call dword 0x30cbd
00030637  83C404            add esp,byte +0x4
0003063A  F4                hlt
0003063B  6AFF              push byte -0x1
0003063D  6A00              push byte +0x0
0003063F  EB4E              jmp short 0x3068f
00030641  6AFF              push byte -0x1
00030643  6A01              push byte +0x1
00030645  EB48              jmp short 0x3068f
00030647  6AFF              push byte -0x1
00030649  6A02              push byte +0x2
0003064B  EB42              jmp short 0x3068f
0003064D  6AFF              push byte -0x1
0003064F  6A03              push byte +0x3
00030651  EB3C              jmp short 0x3068f
00030653  6AFF              push byte -0x1
00030655  6A04              push byte +0x4
00030657  EB36              jmp short 0x3068f
00030659  6AFF              push byte -0x1
0003065B  6A05              push byte +0x5
0003065D  EB30              jmp short 0x3068f
0003065F  6AFF              push byte -0x1
00030661  6A06              push byte +0x6
00030663  EB2A              jmp short 0x3068f
00030665  6AFF              push byte -0x1
00030667  6A07              push byte +0x7
00030669  EB24              jmp short 0x3068f
0003066B  6A08              push byte +0x8
0003066D  EB20              jmp short 0x3068f
0003066F  6AFF              push byte -0x1
00030671  6A09              push byte +0x9
00030673  EB1A              jmp short 0x3068f
00030675  6A0A              push byte +0xa
00030677  EB16              jmp short 0x3068f
00030679  6A0B              push byte +0xb
0003067B  EB12              jmp short 0x3068f
0003067D  6A0C              push byte +0xc
0003067F  EB0E              jmp short 0x3068f
00030681  6A0D              push byte +0xd
00030683  EB0A              jmp short 0x3068f
00030685  6A0E              push byte +0xe
00030687  EB06              jmp short 0x3068f
00030689  6AFF              push byte -0x1
0003068B  6A10              push byte +0x10
0003068D  EB00              jmp short 0x3068f
0003068F  E84C0B0000        call dword 0x311e0
00030694  83C408            add esp,byte +0x8
00030697  F4                hlt
00030698  60                pushad
00030699  1E                push ds
0003069A  06                push es
0003069B  0FA0              push fs
0003069D  0FA8              push gs
0003069F  668CD2            mov dx,ss
000306A2  8EDA              mov ds,edx
000306A4  8EC2              mov es,edx
000306A6  89E6              mov esi,esp
000306A8  FF0500650500      inc dword [dword 0x56500]
000306AE  833D0065050000    cmp dword [dword 0x56500],byte +0x0
000306B5  750D              jnz 0x306c4
000306B7  BCE0630300        mov esp,0x363e0
000306BC  68E9060300        push dword 0x306e9
000306C1  FF6630            jmp dword [esi+0x30]
000306C4  68FD060300        push dword 0x306fd
000306C9  FF6630            jmp dword [esi+0x30]
000306CC  E8C7FFFFFF        call dword 0x30698
000306D1  FF3560830500      push dword [dword 0x58360]
000306D7  FB                sti
000306D8  51                push ecx
000306D9  53                push ebx
000306DA  FF148598550300    call dword [eax*4+0x35598]
000306E1  83C40C            add esp,byte +0xc
000306E4  89462C            mov [esi+0x2c],eax
000306E7  FA                cli
000306E8  C3                ret
000306E9  8B2560830500      mov esp,[dword 0x58360]
000306EF  0F00542448        lldt [esp+0x48]
000306F4  8D442448          lea eax,[esp+0x48]
000306F8  A384790500        mov [0x57984],eax
000306FD  FF0D00650500      dec dword [dword 0x56500]
00030703  0FA9              pop gs
00030705  0FA1              pop fs
00030707  07                pop es
00030708  1F                pop ds
00030709  61                popad
0003070A  83C404            add esp,byte +0x4
0003070D  CF                iretd
0003070E  6690              xchg ax,ax
00030710  B800000000        mov eax,0x0
00030715  CD90              int 0x90
00030717  C3                ret
00030718  B801000000        mov eax,0x1
0003071D  8B5C2404          mov ebx,[esp+0x4]
00030721  8B4C2408          mov ecx,[esp+0x8]
00030725  CD90              int 0x90
00030727  C3                ret
00030728  55                push ebp
00030729  89E5              mov ebp,esp
0003072B  83EC18            sub esp,byte +0x18
0003072E  83EC0C            sub esp,byte +0xc
00030731  6880350300        push dword 0x33580
00030736  E8B52B0000        call dword 0x332f0
0003073B  83C410            add esp,byte +0x10
0003073E  B8F0790500        mov eax,0x579f0
00030743  0FB700            movzx eax,word [eax]
00030746  0FB7C0            movzx eax,ax
00030749  83C001            add eax,byte +0x1
0003074C  BAF2790500        mov edx,0x579f2
00030751  8B12              mov edx,[edx]
00030753  83EC04            sub esp,byte +0x4
00030756  50                push eax
00030757  52                push edx
00030758  6820650500        push dword 0x56520
0003075D  E89E2D0000        call dword 0x33500
00030762  83C410            add esp,byte +0x10
00030765  C745F4F0790500    mov dword [ebp-0xc],0x579f0
0003076C  C745F0F2790500    mov dword [ebp-0x10],0x579f2
00030773  8B45F4            mov eax,[ebp-0xc]
00030776  66C700FF03        mov word [eax],0x3ff
0003077B  BA20650500        mov edx,0x56520
00030780  8B45F0            mov eax,[ebp-0x10]
00030783  8910              mov [eax],edx
00030785  C745ECE0640300    mov dword [ebp-0x14],0x364e0
0003078C  C745E8E2640300    mov dword [ebp-0x18],0x364e2
00030793  8B45EC            mov eax,[ebp-0x14]
00030796  66C700FF07        mov word [eax],0x7ff
0003079B  BA007A0500        mov edx,0x57a00
000307A0  8B45E8            mov eax,[ebp-0x18]
000307A3  8910              mov [eax],edx
000307A5  E86E050000        call dword 0x30d18
000307AA  83EC0C            sub esp,byte +0xc
000307AD  68AA350300        push dword 0x335aa
000307B2  E8392B0000        call dword 0x332f0
000307B7  83C410            add esp,byte +0x10
000307BA  90                nop
000307BB  C9                leave
000307BC  C3                ret
000307BD  55                push ebp
000307BE  89E5              mov ebp,esp
000307C0  83EC38            sub esp,byte +0x38
000307C3  83EC0C            sub esp,byte +0xc
000307C6  68C8350300        push dword 0x335c8
000307CB  E8202B0000        call dword 0x332f0
000307D0  83C410            add esp,byte +0x10
000307D3  C745F4E0540300    mov dword [ebp-0xc],0x354e0
000307DA  C745DC80830500    mov dword [ebp-0x24],0x58380
000307E1  C745F000650500    mov dword [ebp-0x10],0x56500
000307E8  66C745EE2800      mov word [ebp-0x12],0x28
000307EE  C745E800000000    mov dword [ebp-0x18],0x0
000307F5  E991000000        jmp dword 0x3088b
000307FA  837DE800          cmp dword [ebp-0x18],byte +0x0
000307FE  7F3B              jg 0x3083b
00030800  8B55E8            mov edx,[ebp-0x18]
00030803  89D0              mov eax,edx
00030805  C1E002            shl eax,byte 0x2
00030808  01D0              add eax,edx
0003080A  C1E003            shl eax,byte 0x3
0003080D  05E0540300        add eax,0x354e0
00030812  8945F4            mov [ebp-0xc],eax
00030815  8B4DE8            mov ecx,[ebp-0x18]
00030818  8B55E8            mov edx,[ebp-0x18]
0003081B  0FB745EE          movzx eax,word [ebp-0x12]
0003081F  6802120000        push dword 0x1202
00030824  6A01              push byte +0x1
00030826  6A01              push byte +0x1
00030828  51                push ecx
00030829  52                push edx
0003082A  50                push eax
0003082B  FF75F0            push dword [ebp-0x10]
0003082E  FF75F4            push dword [ebp-0xc]
00030831  E8D90B0000        call dword 0x3140f
00030836  83C420            add esp,byte +0x20
00030839  EB3C              jmp short 0x30877
0003083B  8B55E8            mov edx,[ebp-0x18]
0003083E  89D0              mov eax,edx
00030840  C1E002            shl eax,byte 0x2
00030843  01D0              add eax,edx
00030845  C1E003            shl eax,byte 0x3
00030848  83E828            sub eax,byte +0x28
0003084B  0520550300        add eax,0x35520
00030850  8945F4            mov [ebp-0xc],eax
00030853  8B4DE8            mov ecx,[ebp-0x18]
00030856  8B55E8            mov edx,[ebp-0x18]
00030859  0FB745EE          movzx eax,word [ebp-0x12]
0003085D  6802020000        push dword 0x202
00030862  6A03              push byte +0x3
00030864  6A03              push byte +0x3
00030866  51                push ecx
00030867  52                push edx
00030868  50                push eax
00030869  FF75F0            push dword [ebp-0x10]
0003086C  FF75F4            push dword [ebp-0xc]
0003086F  E89B0B0000        call dword 0x3140f
00030874  83C420            add esp,byte +0x20
00030877  8B45F4            mov eax,[ebp-0xc]
0003087A  8B4004            mov eax,[eax+0x4]
0003087D  F7D8              neg eax
0003087F  0145F0            add [ebp-0x10],eax
00030882  668345EE08        add word [ebp-0x12],byte +0x8
00030887  8345E801          add dword [ebp-0x18],byte +0x1
0003088B  837DE803          cmp dword [ebp-0x18],byte +0x3
0003088F  0F8E65FFFFFF      jng dword 0x307fa
00030895  A1DC830500        mov eax,[0x583dc]
0003089A  C740040F000000    mov dword [eax+0x4],0xf
000308A1  A15C840500        mov eax,[0x5845c]
000308A6  C7400413000000    mov dword [eax+0x4],0x13
000308AD  A1DC840500        mov eax,[0x584dc]
000308B2  C7400414000000    mov dword [eax+0x4],0x14
000308B9  A15C850500        mov eax,[0x5855c]
000308BE  C7400415000000    mov dword [eax+0x4],0x15
000308C5  C7057C8405000000  mov dword [dword 0x5847c],0x0
         -0000
000308CF  C705FC8405000100  mov dword [dword 0x584fc],0x1
         -0000
000308D9  C7057C8505000100  mov dword [dword 0x5857c],0x1
         -0000
000308E3  C705E06303000000  mov dword [dword 0x363e0],0x0
         -0000
000308ED  C745E400000000    mov dword [ebp-0x1c],0x0
000308F4  EB3B              jmp short 0x30931
000308F6  8B45E4            mov eax,[ebp-0x1c]
000308F9  C1E007            shl eax,byte 0x7
000308FC  05DC830500        add eax,0x583dc
00030901  8B00              mov eax,[eax]
00030903  8945D8            mov [ebp-0x28],eax
00030906  8B45D8            mov eax,[ebp-0x28]
00030909  8B4004            mov eax,[eax+0x4]
0003090C  8B048500360300    mov eax,[eax*4+0x33600]
00030913  89C2              mov edx,eax
00030915  8B45D8            mov eax,[ebp-0x28]
00030918  89500C            mov [eax+0xc],edx
0003091B  8B45D8            mov eax,[ebp-0x28]
0003091E  8B500C            mov edx,[eax+0xc]
00030921  A1E0630300        mov eax,[0x363e0]
00030926  01D0              add eax,edx
00030928  A3E0630300        mov [0x363e0],eax
0003092D  8345E401          add dword [ebp-0x1c],byte +0x1
00030931  837DE403          cmp dword [ebp-0x1c],byte +0x3
00030935  7EBF              jng 0x308f6
00030937  C745E000000000    mov dword [ebp-0x20],0x0
0003093E  EB65              jmp short 0x309a5
00030940  8B45E0            mov eax,[ebp-0x20]
00030943  C1E007            shl eax,byte 0x7
00030946  05DC830500        add eax,0x583dc
0003094B  8B00              mov eax,[eax]
0003094D  8945D4            mov [ebp-0x2c],eax
00030950  8B45D4            mov eax,[ebp-0x2c]
00030953  C70000000000      mov dword [eax],0x0
00030959  A1C0820500        mov eax,[0x582c0]
0003095E  89C2              mov edx,eax
00030960  8B45D4            mov eax,[ebp-0x2c]
00030963  895010            mov [eax+0x10],edx
00030966  8B45D4            mov eax,[ebp-0x2c]
00030969  C7400800000000    mov dword [eax+0x8],0x0
00030970  8B45E0            mov eax,[ebp-0x20]
00030973  C1E007            shl eax,byte 0x7
00030976  05DC830500        add eax,0x583dc
0003097B  8B10              mov edx,[eax]
0003097D  8B45D4            mov eax,[ebp-0x2c]
00030980  89502C            mov [eax+0x2c],edx
00030983  8B45D4            mov eax,[ebp-0x2c]
00030986  8B5008            mov edx,[eax+0x8]
00030989  8B45D4            mov eax,[ebp-0x2c]
0003098C  89501C            mov [eax+0x1c],edx
0003098F  8B45D4            mov eax,[ebp-0x2c]
00030992  83C018            add eax,byte +0x18
00030995  83EC0C            sub esp,byte +0xc
00030998  50                push eax
00030999  E8C70F0000        call dword 0x31965
0003099E  83C410            add esp,byte +0x10
000309A1  8345E001          add dword [ebp-0x20],byte +0x1
000309A5  837DE003          cmp dword [ebp-0x20],byte +0x3
000309A9  7E95              jng 0x30940
000309AB  6687DB            xchg bx,bx
000309AE  A1DC830500        mov eax,[0x583dc]
000309B3  83C018            add eax,byte +0x18
000309B6  83EC0C            sub esp,byte +0xc
000309B9  50                push eax
000309BA  E8C9120000        call dword 0x31c88
000309BF  83C410            add esp,byte +0x10
000309C2  C705006505000000  mov dword [dword 0x56500],0x0
         -0000
000309CC  C705C08205000000  mov dword [dword 0x582c0],0x0
         -0000
000309D6  E8B5010000        call dword 0x30b90
000309DB  E89F180000        call dword 0x3227f
000309E0  E804FDFFFF        call dword 0x306e9
000309E5  EBFE              jmp short 0x309e5
000309E7  55                push ebp
000309E8  89E5              mov ebp,esp
000309EA  83EC18            sub esp,byte +0x18
000309ED  C745F400000000    mov dword [ebp-0xc],0x0
000309F4  83EC0C            sub esp,byte +0xc
000309F7  68E8350300        push dword 0x335e8
000309FC  E8B6270000        call dword 0x331b7
00030A01  83C410            add esp,byte +0x10
00030A04  83EC0C            sub esp,byte +0xc
00030A07  6A64              push byte +0x64
00030A09  E848010000        call dword 0x30b56
00030A0E  83C410            add esp,byte +0x10
00030A11  EBE1              jmp short 0x309f4
00030A13  55                push ebp
00030A14  89E5              mov ebp,esp
00030A16  83EC18            sub esp,byte +0x18
00030A19  C745F400100000    mov dword [ebp-0xc],0x1000
00030A20  83EC0C            sub esp,byte +0xc
00030A23  68EA350300        push dword 0x335ea
00030A28  E88A270000        call dword 0x331b7
00030A2D  83C410            add esp,byte +0x10
00030A30  83EC0C            sub esp,byte +0xc
00030A33  6A64              push byte +0x64
00030A35  E81C010000        call dword 0x30b56
00030A3A  83C410            add esp,byte +0x10
00030A3D  EBE1              jmp short 0x30a20
00030A3F  55                push ebp
00030A40  89E5              mov ebp,esp
00030A42  83EC18            sub esp,byte +0x18
00030A45  C745F400200000    mov dword [ebp-0xc],0x2000
00030A4C  83EC0C            sub esp,byte +0xc
00030A4F  68EC350300        push dword 0x335ec
00030A54  E85E270000        call dword 0x331b7
00030A59  83C410            add esp,byte +0x10
00030A5C  83EC0C            sub esp,byte +0xc
00030A5F  6A64              push byte +0x64
00030A61  E8F0000000        call dword 0x30b56
00030A66  83C410            add esp,byte +0x10
00030A69  EBE1              jmp short 0x30a4c
00030A6B  55                push ebp
00030A6C  89E5              mov ebp,esp
00030A6E  83EC18            sub esp,byte +0x18
00030A71  A1C0820500        mov eax,[0x582c0]
00030A76  83C001            add eax,byte +0x1
00030A79  A3C0820500        mov [0x582c0],eax
00030A7E  A160830500        mov eax,[0x58360]
00030A83  8B405C            mov eax,[eax+0x5c]
00030A86  8B1560830500      mov edx,[dword 0x58360]
00030A8C  8B525C            mov edx,[edx+0x5c]
00030A8F  8B12              mov edx,[edx]
00030A91  81C2E8030000      add edx,0x3e8
00030A97  8910              mov [eax],edx
00030A99  A160830500        mov eax,[0x58360]
00030A9E  8B405C            mov eax,[eax+0x5c]
00030AA1  83EC08            sub esp,byte +0x8
00030AA4  50                push eax
00030AA5  68E8030000        push dword 0x3e8
00030AAA  E8C7080000        call dword 0x31376
00030AAF  83C410            add esp,byte +0x10
00030AB2  89C1              mov ecx,eax
00030AB4  A160830500        mov eax,[0x58360]
00030AB9  8B405C            mov eax,[eax+0x5c]
00030ABC  8B1560830500      mov edx,[dword 0x58360]
00030AC2  8B525C            mov edx,[edx+0x5c]
00030AC5  8B5208            mov edx,[edx+0x8]
00030AC8  01CA              add edx,ecx
00030ACA  895008            mov [eax+0x8],edx
00030ACD  A100650500        mov eax,[0x56500]
00030AD2  85C0              test eax,eax
00030AD4  7577              jnz 0x30b4d
00030AD6  A160830500        mov eax,[0x58360]
00030ADB  8B405C            mov eax,[eax+0x5c]
00030ADE  83EC0C            sub esp,byte +0xc
00030AE1  50                push eax
00030AE2  E853080000        call dword 0x3133a
00030AE7  83C410            add esp,byte +0x10
00030AEA  8945F4            mov [ebp-0xc],eax
00030AED  A160830500        mov eax,[0x58360]
00030AF2  8B405C            mov eax,[eax+0x5c]
00030AF5  8B00              mov eax,[eax]
00030AF7  3B45F4            cmp eax,[ebp-0xc]
00030AFA  7607              jna 0x30b03
00030AFC  E8A4080000        call dword 0x313a5
00030B01  EB51              jmp short 0x30b54
00030B03  A160830500        mov eax,[0x58360]
00030B08  8B405C            mov eax,[eax+0x5c]
00030B0B  8B10              mov edx,[eax]
00030B0D  A1A4550300        mov eax,[0x355a4]
00030B12  39C2              cmp edx,eax
00030B14  723A              jc 0x30b50
00030B16  E8730B0000        call dword 0x3168e
00030B1B  8945F0            mov [ebp-0x10],eax
00030B1E  A160830500        mov eax,[0x58360]
00030B23  8B405C            mov eax,[eax+0x5c]
00030B26  8B4008            mov eax,[eax+0x8]
00030B29  89C2              mov edx,eax
00030B2B  8B45F0            mov eax,[ebp-0x10]
00030B2E  8B4008            mov eax,[eax+0x8]
00030B31  29C2              sub edx,eax
00030B33  89D0              mov eax,edx
00030B35  8945EC            mov [ebp-0x14],eax
00030B38  837DEC00          cmp dword [ebp-0x14],byte +0x0
00030B3C  7815              js 0x30b53
00030B3E  8B45EC            mov eax,[ebp-0x14]
00030B41  3B45F4            cmp eax,[ebp-0xc]
00030B44  760E              jna 0x30b54
00030B46  E85A080000        call dword 0x313a5
00030B4B  EB07              jmp short 0x30b54
00030B4D  90                nop
00030B4E  EB04              jmp short 0x30b54
00030B50  90                nop
00030B51  EB01              jmp short 0x30b54
00030B53  90                nop
00030B54  C9                leave
00030B55  C3                ret
00030B56  55                push ebp
00030B57  89E5              mov ebp,esp
00030B59  83EC18            sub esp,byte +0x18
00030B5C  E8AFFBFFFF        call dword 0x30710
00030B61  8945F4            mov [ebp-0xc],eax
00030B64  90                nop
00030B65  E8A6FBFFFF        call dword 0x30710
00030B6A  2B45F4            sub eax,[ebp-0xc]
00030B6D  69C8E8030000      imul ecx,eax,dword 0x3e8
00030B73  BA1F85EB51        mov edx,0x51eb851f
00030B78  89C8              mov eax,ecx
00030B7A  F7EA              imul edx
00030B7C  C1FA05            sar edx,byte 0x5
00030B7F  89C8              mov eax,ecx
00030B81  C1F81F            sar eax,byte 0x1f
00030B84  29C2              sub edx,eax
00030B86  89D0              mov eax,edx
00030B88  3B4508            cmp eax,[ebp+0x8]
00030B8B  7CD8              jl 0x30b65
00030B8D  90                nop
00030B8E  C9                leave
00030B8F  C3                ret
00030B90  55                push ebp
00030B91  89E5              mov ebp,esp
00030B93  83EC08            sub esp,byte +0x8
00030B96  83EC08            sub esp,byte +0x8
00030B99  6A34              push byte +0x34
00030B9B  6A43              push byte +0x43
00030B9D  E8CB270000        call dword 0x3336d
00030BA2  83C410            add esp,byte +0x10
00030BA5  83EC08            sub esp,byte +0x8
00030BA8  689B000000        push dword 0x9b
00030BAD  6A40              push byte +0x40
00030BAF  E8B9270000        call dword 0x3336d
00030BB4  83C410            add esp,byte +0x10
00030BB7  83EC08            sub esp,byte +0x8
00030BBA  6A2E              push byte +0x2e
00030BBC  6A40              push byte +0x40
00030BBE  E8AA270000        call dword 0x3336d
00030BC3  83C410            add esp,byte +0x10
00030BC6  83EC08            sub esp,byte +0x8
00030BC9  686B0A0300        push dword 0x30a6b
00030BCE  6A00              push byte +0x0
00030BD0  E81F010000        call dword 0x30cf4
00030BD5  83C410            add esp,byte +0x10
00030BD8  83EC0C            sub esp,byte +0xc
00030BDB  6A00              push byte +0x0
00030BDD  E8D6270000        call dword 0x333b8
00030BE2  83C410            add esp,byte +0x10
00030BE5  90                nop
00030BE6  C9                leave
00030BE7  C3                ret
00030BE8  55                push ebp
00030BE9  89E5              mov ebp,esp
00030BEB  83EC18            sub esp,byte +0x18
00030BEE  83EC08            sub esp,byte +0x8
00030BF1  6A11              push byte +0x11
00030BF3  6A20              push byte +0x20
00030BF5  E873270000        call dword 0x3336d
00030BFA  83C410            add esp,byte +0x10
00030BFD  83EC08            sub esp,byte +0x8
00030C00  6A11              push byte +0x11
00030C02  68A0000000        push dword 0xa0
00030C07  E861270000        call dword 0x3336d
00030C0C  83C410            add esp,byte +0x10
00030C0F  83EC08            sub esp,byte +0x8
00030C12  6A20              push byte +0x20
00030C14  6A21              push byte +0x21
00030C16  E852270000        call dword 0x3336d
00030C1B  83C410            add esp,byte +0x10
00030C1E  83EC08            sub esp,byte +0x8
00030C21  6A28              push byte +0x28
00030C23  68A1000000        push dword 0xa1
00030C28  E840270000        call dword 0x3336d
00030C2D  83C410            add esp,byte +0x10
00030C30  83EC08            sub esp,byte +0x8
00030C33  6A04              push byte +0x4
00030C35  6A21              push byte +0x21
00030C37  E831270000        call dword 0x3336d
00030C3C  83C410            add esp,byte +0x10
00030C3F  83EC08            sub esp,byte +0x8
00030C42  6A02              push byte +0x2
00030C44  68A1000000        push dword 0xa1
00030C49  E81F270000        call dword 0x3336d
00030C4E  83C410            add esp,byte +0x10
00030C51  83EC08            sub esp,byte +0x8
00030C54  6A01              push byte +0x1
00030C56  6A21              push byte +0x21
00030C58  E810270000        call dword 0x3336d
00030C5D  83C410            add esp,byte +0x10
00030C60  83EC08            sub esp,byte +0x8
00030C63  6A01              push byte +0x1
00030C65  68A1000000        push dword 0xa1
00030C6A  E8FE260000        call dword 0x3336d
00030C6F  83C410            add esp,byte +0x10
00030C72  83EC08            sub esp,byte +0x8
00030C75  68FF000000        push dword 0xff
00030C7A  6A21              push byte +0x21
00030C7C  E8EC260000        call dword 0x3336d
00030C81  83C410            add esp,byte +0x10
00030C84  83EC08            sub esp,byte +0x8
00030C87  68FF000000        push dword 0xff
00030C8C  68A1000000        push dword 0xa1
00030C91  E8D7260000        call dword 0x3336d
00030C96  83C410            add esp,byte +0x10
00030C99  C745F400000000    mov dword [ebp-0xc],0x0
00030CA0  EB12              jmp short 0x30cb4
00030CA2  8B45F4            mov eax,[ebp-0xc]
00030CA5  C7048520830500BD  mov dword [eax*4+0x58320],0x30cbd
         -0C0300
00030CB0  8345F401          add dword [ebp-0xc],byte +0x1
00030CB4  837DF40F          cmp dword [ebp-0xc],byte +0xf
00030CB8  7EE8              jng 0x30ca2
00030CBA  90                nop
00030CBB  C9                leave
00030CBC  C3                ret
00030CBD  55                push ebp
00030CBE  89E5              mov ebp,esp
00030CC0  83EC08            sub esp,byte +0x8
00030CC3  83EC0C            sub esp,byte +0xc
00030CC6  68EE350300        push dword 0x335ee
00030CCB  E820260000        call dword 0x332f0
00030CD0  83C410            add esp,byte +0x10
00030CD3  83EC0C            sub esp,byte +0xc
00030CD6  FF7508            push dword [ebp+0x8]
00030CD9  E8A8270000        call dword 0x33486
00030CDE  83C410            add esp,byte +0x10
00030CE1  83EC0C            sub esp,byte +0xc
00030CE4  68FD350300        push dword 0x335fd
00030CE9  E802260000        call dword 0x332f0
00030CEE  83C410            add esp,byte +0x10
00030CF1  90                nop
00030CF2  C9                leave
00030CF3  C3                ret
00030CF4  55                push ebp
00030CF5  89E5              mov ebp,esp
00030CF7  83EC08            sub esp,byte +0x8
00030CFA  83EC0C            sub esp,byte +0xc
00030CFD  FF7508            push dword [ebp+0x8]
00030D00  E87E260000        call dword 0x33383
00030D05  83C410            add esp,byte +0x10
00030D08  8B4508            mov eax,[ebp+0x8]
00030D0B  8B550C            mov edx,[ebp+0xc]
00030D0E  89148520830500    mov [eax*4+0x58320],edx
00030D15  90                nop
00030D16  C9                leave
00030D17  C3                ret
00030D18  55                push ebp
00030D19  89E5              mov ebp,esp
00030D1B  83EC18            sub esp,byte +0x18
00030D1E  E8C5FEFFFF        call dword 0x30be8
00030D23  6A00              push byte +0x0
00030D25  683B060300        push dword 0x3063b
00030D2A  688E000000        push dword 0x8e
00030D2F  6A00              push byte +0x0
00030D31  E87D030000        call dword 0x310b3
00030D36  83C410            add esp,byte +0x10
00030D39  6A00              push byte +0x0
00030D3B  6841060300        push dword 0x30641
00030D40  688E000000        push dword 0x8e
00030D45  6A01              push byte +0x1
00030D47  E867030000        call dword 0x310b3
00030D4C  83C410            add esp,byte +0x10
00030D4F  6A00              push byte +0x0
00030D51  6847060300        push dword 0x30647
00030D56  688E000000        push dword 0x8e
00030D5B  6A02              push byte +0x2
00030D5D  E851030000        call dword 0x310b3
00030D62  83C410            add esp,byte +0x10
00030D65  6A03              push byte +0x3
00030D67  684D060300        push dword 0x3064d
00030D6C  688E000000        push dword 0x8e
00030D71  6A03              push byte +0x3
00030D73  E83B030000        call dword 0x310b3
00030D78  83C410            add esp,byte +0x10
00030D7B  6A03              push byte +0x3
00030D7D  6853060300        push dword 0x30653
00030D82  688E000000        push dword 0x8e
00030D87  6A04              push byte +0x4
00030D89  E825030000        call dword 0x310b3
00030D8E  83C410            add esp,byte +0x10
00030D91  6A00              push byte +0x0
00030D93  6859060300        push dword 0x30659
00030D98  688E000000        push dword 0x8e
00030D9D  6A05              push byte +0x5
00030D9F  E80F030000        call dword 0x310b3
00030DA4  83C410            add esp,byte +0x10
00030DA7  6A00              push byte +0x0
00030DA9  685F060300        push dword 0x3065f
00030DAE  688E000000        push dword 0x8e
00030DB3  6A06              push byte +0x6
00030DB5  E8F9020000        call dword 0x310b3
00030DBA  83C410            add esp,byte +0x10
00030DBD  6A00              push byte +0x0
00030DBF  6865060300        push dword 0x30665
00030DC4  688E000000        push dword 0x8e
00030DC9  6A07              push byte +0x7
00030DCB  E8E3020000        call dword 0x310b3
00030DD0  83C410            add esp,byte +0x10
00030DD3  6A00              push byte +0x0
00030DD5  686B060300        push dword 0x3066b
00030DDA  688E000000        push dword 0x8e
00030DDF  6A08              push byte +0x8
00030DE1  E8CD020000        call dword 0x310b3
00030DE6  83C410            add esp,byte +0x10
00030DE9  6A00              push byte +0x0
00030DEB  686F060300        push dword 0x3066f
00030DF0  688E000000        push dword 0x8e
00030DF5  6A09              push byte +0x9
00030DF7  E8B7020000        call dword 0x310b3
00030DFC  83C410            add esp,byte +0x10
00030DFF  6A00              push byte +0x0
00030E01  6875060300        push dword 0x30675
00030E06  688E000000        push dword 0x8e
00030E0B  6A0A              push byte +0xa
00030E0D  E8A1020000        call dword 0x310b3
00030E12  83C410            add esp,byte +0x10
00030E15  6A00              push byte +0x0
00030E17  6879060300        push dword 0x30679
00030E1C  688E000000        push dword 0x8e
00030E21  6A0B              push byte +0xb
00030E23  E88B020000        call dword 0x310b3
00030E28  83C410            add esp,byte +0x10
00030E2B  6A00              push byte +0x0
00030E2D  687D060300        push dword 0x3067d
00030E32  688E000000        push dword 0x8e
00030E37  6A0C              push byte +0xc
00030E39  E875020000        call dword 0x310b3
00030E3E  83C410            add esp,byte +0x10
00030E41  6A00              push byte +0x0
00030E43  6881060300        push dword 0x30681
00030E48  688E000000        push dword 0x8e
00030E4D  6A0D              push byte +0xd
00030E4F  E85F020000        call dword 0x310b3
00030E54  83C410            add esp,byte +0x10
00030E57  6A00              push byte +0x0
00030E59  6885060300        push dword 0x30685
00030E5E  688E000000        push dword 0x8e
00030E63  6A0E              push byte +0xe
00030E65  E849020000        call dword 0x310b3
00030E6A  83C410            add esp,byte +0x10
00030E6D  6A00              push byte +0x0
00030E6F  6889060300        push dword 0x30689
00030E74  688E000000        push dword 0x8e
00030E79  6A10              push byte +0x10
00030E7B  E833020000        call dword 0x310b3
00030E80  83C410            add esp,byte +0x10
00030E83  6A00              push byte +0x0
00030E85  6840040300        push dword 0x30440
00030E8A  688E000000        push dword 0x8e
00030E8F  6A20              push byte +0x20
00030E91  E81D020000        call dword 0x310b3
00030E96  83C410            add esp,byte +0x10
00030E99  6A00              push byte +0x0
00030E9B  6870040300        push dword 0x30470
00030EA0  688E000000        push dword 0x8e
00030EA5  6A21              push byte +0x21
00030EA7  E807020000        call dword 0x310b3
00030EAC  83C410            add esp,byte +0x10
00030EAF  6A00              push byte +0x0
00030EB1  68A0040300        push dword 0x304a0
00030EB6  688E000000        push dword 0x8e
00030EBB  6A22              push byte +0x22
00030EBD  E8F1010000        call dword 0x310b3
00030EC2  83C410            add esp,byte +0x10
00030EC5  6A00              push byte +0x0
00030EC7  68D0040300        push dword 0x304d0
00030ECC  688E000000        push dword 0x8e
00030ED1  6A23              push byte +0x23
00030ED3  E8DB010000        call dword 0x310b3
00030ED8  83C410            add esp,byte +0x10
00030EDB  6A00              push byte +0x0
00030EDD  6800050300        push dword 0x30500
00030EE2  688E000000        push dword 0x8e
00030EE7  6A24              push byte +0x24
00030EE9  E8C5010000        call dword 0x310b3
00030EEE  83C410            add esp,byte +0x10
00030EF1  6A00              push byte +0x0
00030EF3  6830050300        push dword 0x30530
00030EF8  688E000000        push dword 0x8e
00030EFD  6A25              push byte +0x25
00030EFF  E8AF010000        call dword 0x310b3
00030F04  83C410            add esp,byte +0x10
00030F07  6A00              push byte +0x0
00030F09  6860050300        push dword 0x30560
00030F0E  688E000000        push dword 0x8e
00030F13  6A26              push byte +0x26
00030F15  E899010000        call dword 0x310b3
00030F1A  83C410            add esp,byte +0x10
00030F1D  6A00              push byte +0x0
00030F1F  6890050300        push dword 0x30590
00030F24  688E000000        push dword 0x8e
00030F29  6A27              push byte +0x27
00030F2B  E883010000        call dword 0x310b3
00030F30  83C410            add esp,byte +0x10
00030F33  6A00              push byte +0x0
00030F35  68C0050300        push dword 0x305c0
00030F3A  688E000000        push dword 0x8e
00030F3F  6A28              push byte +0x28
00030F41  E86D010000        call dword 0x310b3
00030F46  83C410            add esp,byte +0x10
00030F49  6A00              push byte +0x0
00030F4B  68D0050300        push dword 0x305d0
00030F50  688E000000        push dword 0x8e
00030F55  6A29              push byte +0x29
00030F57  E857010000        call dword 0x310b3
00030F5C  83C410            add esp,byte +0x10
00030F5F  6A00              push byte +0x0
00030F61  68E0050300        push dword 0x305e0
00030F66  688E000000        push dword 0x8e
00030F6B  6A2A              push byte +0x2a
00030F6D  E841010000        call dword 0x310b3
00030F72  83C410            add esp,byte +0x10
00030F75  6A00              push byte +0x0
00030F77  68F0050300        push dword 0x305f0
00030F7C  688E000000        push dword 0x8e
00030F81  6A2B              push byte +0x2b
00030F83  E82B010000        call dword 0x310b3
00030F88  83C410            add esp,byte +0x10
00030F8B  6A00              push byte +0x0
00030F8D  6800060300        push dword 0x30600
00030F92  688E000000        push dword 0x8e
00030F97  6A2C              push byte +0x2c
00030F99  E815010000        call dword 0x310b3
00030F9E  83C410            add esp,byte +0x10
00030FA1  6A00              push byte +0x0
00030FA3  6810060300        push dword 0x30610
00030FA8  688E000000        push dword 0x8e
00030FAD  6A2D              push byte +0x2d
00030FAF  E8FF000000        call dword 0x310b3
00030FB4  83C410            add esp,byte +0x10
00030FB7  6A00              push byte +0x0
00030FB9  6820060300        push dword 0x30620
00030FBE  688E000000        push dword 0x8e
00030FC3  6A2E              push byte +0x2e
00030FC5  E8E9000000        call dword 0x310b3
00030FCA  83C410            add esp,byte +0x10
00030FCD  6A00              push byte +0x0
00030FCF  6830060300        push dword 0x30630
00030FD4  688E000000        push dword 0x8e
00030FD9  6A2F              push byte +0x2f
00030FDB  E8D3000000        call dword 0x310b3
00030FE0  83C410            add esp,byte +0x10
00030FE3  6A03              push byte +0x3
00030FE5  68CC060300        push dword 0x306cc
00030FEA  688E000000        push dword 0x8e
00030FEF  6890000000        push dword 0x90
00030FF4  E8BA000000        call dword 0x310b3
00030FF9  83C410            add esp,byte +0x10
00030FFC  83EC04            sub esp,byte +0x4
00030FFF  6A68              push byte +0x68
00031001  6A00              push byte +0x0
00031003  6880790500        push dword 0x57980
00031008  E81C250000        call dword 0x33529
0003100D  83C410            add esp,byte +0x10
00031010  C705887905001000  mov dword [dword 0x57988],0x10
         -0000
0003101A  83EC0C            sub esp,byte +0xc
0003101D  6A10              push byte +0x10
0003101F  E800010000        call dword 0x31124
00031024  83C410            add esp,byte +0x10
00031027  BA80790500        mov edx,0x57980
0003102C  01D0              add eax,edx
0003102E  6889000000        push dword 0x89
00031033  6A67              push byte +0x67
00031035  50                push eax
00031036  6840650500        push dword 0x56540
0003103B  E833010000        call dword 0x31173
00031040  83C410            add esp,byte +0x10
00031043  66C705E679050068  mov word [dword 0x579e6],0x68
         -00
0003104C  C745F080830500    mov dword [ebp-0x10],0x58380
00031053  66C745EE2800      mov word [ebp-0x12],0x28
00031059  C745F400000000    mov dword [ebp-0xc],0x0
00031060  EB48              jmp short 0x310aa
00031062  83EC0C            sub esp,byte +0xc
00031065  6A10              push byte +0x10
00031067  E8B8000000        call dword 0x31124
0003106C  83C410            add esp,byte +0x10
0003106F  89C2              mov edx,eax
00031071  8B45F0            mov eax,[ebp-0x10]
00031074  83C04A            add eax,byte +0x4a
00031077  01C2              add edx,eax
00031079  0FB745EE          movzx eax,word [ebp-0x12]
0003107D  66C1E803          shr ax,byte 0x3
00031081  0FB7C0            movzx eax,ax
00031084  C1E003            shl eax,byte 0x3
00031087  0520650500        add eax,0x56520
0003108C  6882000000        push dword 0x82
00031091  6A0F              push byte +0xf
00031093  52                push edx
00031094  50                push eax
00031095  E8D9000000        call dword 0x31173
0003109A  83C410            add esp,byte +0x10
0003109D  836DF080          sub dword [ebp-0x10],byte -0x80
000310A1  668345EE08        add word [ebp-0x12],byte +0x8
000310A6  8345F401          add dword [ebp-0xc],byte +0x1
000310AA  837DF403          cmp dword [ebp-0xc],byte +0x3
000310AE  7EB2              jng 0x31062
000310B0  90                nop
000310B1  C9                leave
000310B2  C3                ret
000310B3  55                push ebp
000310B4  89E5              mov ebp,esp
000310B6  83EC1C            sub esp,byte +0x1c
000310B9  8B4D08            mov ecx,[ebp+0x8]
000310BC  8B550C            mov edx,[ebp+0xc]
000310BF  8B4514            mov eax,[ebp+0x14]
000310C2  884DEC            mov [ebp-0x14],cl
000310C5  8855E8            mov [ebp-0x18],dl
000310C8  8845E4            mov [ebp-0x1c],al
000310CB  0FB645EC          movzx eax,byte [ebp-0x14]
000310CF  C1E003            shl eax,byte 0x3
000310D2  05007A0500        add eax,0x57a00
000310D7  8945FC            mov [ebp-0x4],eax
000310DA  8B4510            mov eax,[ebp+0x10]
000310DD  8945F8            mov [ebp-0x8],eax
000310E0  8B45F8            mov eax,[ebp-0x8]
000310E3  89C2              mov edx,eax
000310E5  8B45FC            mov eax,[ebp-0x4]
000310E8  668910            mov [eax],dx
000310EB  8B45FC            mov eax,[ebp-0x4]
000310EE  66C740020800      mov word [eax+0x2],0x8
000310F4  8B45FC            mov eax,[ebp-0x4]
000310F7  C6400400          mov byte [eax+0x4],0x0
000310FB  0FB645E4          movzx eax,byte [ebp-0x1c]
000310FF  C1E005            shl eax,byte 0x5
00031102  89C2              mov edx,eax
00031104  0FB645E8          movzx eax,byte [ebp-0x18]
00031108  09D0              or eax,edx
0003110A  89C2              mov edx,eax
0003110C  8B45FC            mov eax,[ebp-0x4]
0003110F  885005            mov [eax+0x5],dl
00031112  8B45F8            mov eax,[ebp-0x8]
00031115  C1E810            shr eax,byte 0x10
00031118  89C2              mov edx,eax
0003111A  8B45FC            mov eax,[ebp-0x4]
0003111D  66895006          mov [eax+0x6],dx
00031121  90                nop
00031122  C9                leave
00031123  C3                ret
00031124  55                push ebp
00031125  89E5              mov ebp,esp
00031127  83EC14            sub esp,byte +0x14
0003112A  8B4508            mov eax,[ebp+0x8]
0003112D  668945EC          mov [ebp-0x14],ax
00031131  0FB745EC          movzx eax,word [ebp-0x14]
00031135  66C1E803          shr ax,byte 0x3
00031139  0FB7C0            movzx eax,ax
0003113C  C1E003            shl eax,byte 0x3
0003113F  0520650500        add eax,0x56520
00031144  8945FC            mov [ebp-0x4],eax
00031147  8B45FC            mov eax,[ebp-0x4]
0003114A  0FB64007          movzx eax,byte [eax+0x7]
0003114E  0FB6C0            movzx eax,al
00031151  C1E018            shl eax,byte 0x18
00031154  89C2              mov edx,eax
00031156  8B45FC            mov eax,[ebp-0x4]
00031159  0FB64004          movzx eax,byte [eax+0x4]
0003115D  0FB6C0            movzx eax,al
00031160  C1E010            shl eax,byte 0x10
00031163  09C2              or edx,eax
00031165  8B45FC            mov eax,[ebp-0x4]
00031168  0FB74002          movzx eax,word [eax+0x2]
0003116C  0FB7C0            movzx eax,ax
0003116F  09D0              or eax,edx
00031171  C9                leave
00031172  C3                ret
00031173  55                push ebp
00031174  89E5              mov ebp,esp
00031176  83EC04            sub esp,byte +0x4
00031179  8B4514            mov eax,[ebp+0x14]
0003117C  668945FC          mov [ebp-0x4],ax
00031180  8B4510            mov eax,[ebp+0x10]
00031183  89C2              mov edx,eax
00031185  8B4508            mov eax,[ebp+0x8]
00031188  668910            mov [eax],dx
0003118B  8B450C            mov eax,[ebp+0xc]
0003118E  89C2              mov edx,eax
00031190  8B4508            mov eax,[ebp+0x8]
00031193  66895002          mov [eax+0x2],dx
00031197  8B450C            mov eax,[ebp+0xc]
0003119A  C1E810            shr eax,byte 0x10
0003119D  89C2              mov edx,eax
0003119F  8B4508            mov eax,[ebp+0x8]
000311A2  885004            mov [eax+0x4],dl
000311A5  0FB745FC          movzx eax,word [ebp-0x4]
000311A9  89C2              mov edx,eax
000311AB  8B4508            mov eax,[ebp+0x8]
000311AE  885005            mov [eax+0x5],dl
000311B1  8B4510            mov eax,[ebp+0x10]
000311B4  C1E810            shr eax,byte 0x10
000311B7  83E00F            and eax,byte +0xf
000311BA  89C2              mov edx,eax
000311BC  0FB745FC          movzx eax,word [ebp-0x4]
000311C0  66C1E808          shr ax,byte 0x8
000311C4  83E0F0            and eax,byte -0x10
000311C7  09C2              or edx,eax
000311C9  8B4508            mov eax,[ebp+0x8]
000311CC  885006            mov [eax+0x6],dl
000311CF  8B450C            mov eax,[ebp+0xc]
000311D2  C1E818            shr eax,byte 0x18
000311D5  89C2              mov edx,eax
000311D7  8B4508            mov eax,[ebp+0x8]
000311DA  885007            mov [eax+0x7],dl
000311DD  90                nop
000311DE  C9                leave
000311DF  C3                ret
000311E0  55                push ebp
000311E1  89E5              mov ebp,esp
000311E3  57                push edi
000311E4  56                push esi
000311E5  53                push ebx
000311E6  81EC1C050000      sub esp,0x51c
000311EC  C745E074000000    mov dword [ebp-0x20],0x74
000311F3  8D85E0FAFFFF      lea eax,[ebp-0x520]
000311F9  BBE0360300        mov ebx,0x336e0
000311FE  BA40010000        mov edx,0x140
00031203  89C7              mov edi,eax
00031205  89DE              mov esi,ebx
00031207  89D1              mov ecx,edx
00031209  F3A5              rep movsd
0003120B  C705EC7905000000  mov dword [dword 0x579ec],0x0
         -0000
00031215  C745E400000000    mov dword [ebp-0x1c],0x0
0003121C  EB14              jmp short 0x31232
0003121E  83EC0C            sub esp,byte +0xc
00031221  68A0360300        push dword 0x336a0
00031226  E8C5200000        call dword 0x332f0
0003122B  83C410            add esp,byte +0x10
0003122E  8345E401          add dword [ebp-0x1c],byte +0x1
00031232  817DE48F010000    cmp dword [ebp-0x1c],0x18f
00031239  7EE3              jng 0x3121e
0003123B  C705EC7905000000  mov dword [dword 0x579ec],0x0
         -0000
00031245  83EC08            sub esp,byte +0x8
00031248  FF75E0            push dword [ebp-0x20]
0003124B  68A2360300        push dword 0x336a2
00031250  E8D9200000        call dword 0x3332e
00031255  83C410            add esp,byte +0x10
00031258  8D85E0FAFFFF      lea eax,[ebp-0x520]
0003125E  8B5508            mov edx,[ebp+0x8]
00031261  C1E206            shl edx,byte 0x6
00031264  01D0              add eax,edx
00031266  83EC08            sub esp,byte +0x8
00031269  FF75E0            push dword [ebp-0x20]
0003126C  50                push eax
0003126D  E8BC200000        call dword 0x3332e
00031272  83C410            add esp,byte +0x10
00031275  83EC08            sub esp,byte +0x8
00031278  FF75E0            push dword [ebp-0x20]
0003127B  68B2360300        push dword 0x336b2
00031280  E8A9200000        call dword 0x3332e
00031285  83C410            add esp,byte +0x10
00031288  83EC08            sub esp,byte +0x8
0003128B  FF75E0            push dword [ebp-0x20]
0003128E  68B5360300        push dword 0x336b5
00031293  E896200000        call dword 0x3332e
00031298  83C410            add esp,byte +0x10
0003129B  83EC0C            sub esp,byte +0xc
0003129E  FF7518            push dword [ebp+0x18]
000312A1  E8E0210000        call dword 0x33486
000312A6  83C410            add esp,byte +0x10
000312A9  83EC08            sub esp,byte +0x8
000312AC  FF75E0            push dword [ebp-0x20]
000312AF  68BD360300        push dword 0x336bd
000312B4  E875200000        call dword 0x3332e
000312B9  83C410            add esp,byte +0x10
000312BC  83EC0C            sub esp,byte +0xc
000312BF  FF7514            push dword [ebp+0x14]
000312C2  E8BF210000        call dword 0x33486
000312C7  83C410            add esp,byte +0x10
000312CA  83EC08            sub esp,byte +0x8
000312CD  FF75E0            push dword [ebp-0x20]
000312D0  68C1360300        push dword 0x336c1
000312D5  E854200000        call dword 0x3332e
000312DA  83C410            add esp,byte +0x10
000312DD  83EC0C            sub esp,byte +0xc
000312E0  FF7510            push dword [ebp+0x10]
000312E3  E89E210000        call dword 0x33486
000312E8  83C410            add esp,byte +0x10
000312EB  837D0CFF          cmp dword [ebp+0xc],byte -0x1
000312EF  7421              jz 0x31312
000312F1  83EC08            sub esp,byte +0x8
000312F4  FF75E0            push dword [ebp-0x20]
000312F7  68C6360300        push dword 0x336c6
000312FC  E82D200000        call dword 0x3332e
00031301  83C410            add esp,byte +0x10
00031304  83EC0C            sub esp,byte +0xc
00031307  FF750C            push dword [ebp+0xc]
0003130A  E877210000        call dword 0x33486
0003130F  83C410            add esp,byte +0x10
00031312  90                nop
00031313  8D65F4            lea esp,[ebp-0xc]
00031316  5B                pop ebx
00031317  5E                pop esi
00031318  5F                pop edi
00031319  5D                pop ebp
0003131A  C3                ret
0003131B  55                push ebp
0003131C  89E5              mov ebp,esp
0003131E  A1A8550300        mov eax,[0x355a8]
00031323  394508            cmp [ebp+0x8],eax
00031326  760B              jna 0x31333
00031328  A1A4550300        mov eax,[0x355a4]
0003132D  0FAF4508          imul eax,[ebp+0x8]
00031331  EB05              jmp short 0x31338
00031333  A1A0550300        mov eax,[0x355a0]
00031338  5D                pop ebp
00031339  C3                ret
0003133A  55                push ebp
0003133B  89E5              mov ebp,esp
0003133D  83EC10            sub esp,byte +0x10
00031340  A1AC550300        mov eax,[0x355ac]
00031345  50                push eax
00031346  E8D0FFFFFF        call dword 0x3131b
0003134B  83C404            add esp,byte +0x4
0003134E  8945FC            mov [ebp-0x4],eax
00031351  8B4508            mov eax,[ebp+0x8]
00031354  8B400C            mov eax,[eax+0xc]
00031357  0FAF45FC          imul eax,[ebp-0x4]
0003135B  8B0DE0630300      mov ecx,[dword 0x363e0]
00031361  BA00000000        mov edx,0x0
00031366  F7F1              div ecx
00031368  BACDCCCCCC        mov edx,0xcccccccd
0003136D  F7E2              mul edx
0003136F  89D0              mov eax,edx
00031371  C1E803            shr eax,byte 0x3
00031374  C9                leave
00031375  C3                ret
00031376  55                push ebp
00031377  89E5              mov ebp,esp
00031379  53                push ebx
0003137A  8B450C            mov eax,[ebp+0xc]
0003137D  8B4004            mov eax,[eax+0x4]
00031380  83F814            cmp eax,byte +0x14
00031383  741A              jz 0x3139f
00031385  8B4508            mov eax,[ebp+0x8]
00031388  C1E00A            shl eax,byte 0xa
0003138B  89C1              mov ecx,eax
0003138D  8B450C            mov eax,[ebp+0xc]
00031390  8B580C            mov ebx,[eax+0xc]
00031393  89C8              mov eax,ecx
00031395  BA00000000        mov edx,0x0
0003139A  F7F3              div ebx
0003139C  894508            mov [ebp+0x8],eax
0003139F  8B4508            mov eax,[ebp+0x8]
000313A2  5B                pop ebx
000313A3  5D                pop ebp
000313A4  C3                ret
000313A5  55                push ebp
000313A6  89E5              mov ebp,esp
000313A8  83EC18            sub esp,byte +0x18
000313AB  A160830500        mov eax,[0x58360]
000313B0  8B405C            mov eax,[eax+0x5c]
000313B3  C70000000000      mov dword [eax],0x0
000313B9  A160830500        mov eax,[0x58360]
000313BE  8B405C            mov eax,[eax+0x5c]
000313C1  8B1560830500      mov edx,[dword 0x58360]
000313C7  8B525C            mov edx,[edx+0x5c]
000313CA  8B5208            mov edx,[edx+0x8]
000313CD  89501C            mov [eax+0x1c],edx
000313D0  A160830500        mov eax,[0x58360]
000313D5  8B405C            mov eax,[eax+0x5c]
000313D8  83C018            add eax,byte +0x18
000313DB  83EC0C            sub esp,byte +0xc
000313DE  50                push eax
000313DF  E881050000        call dword 0x31965
000313E4  83C410            add esp,byte +0x10
000313E7  E8A2020000        call dword 0x3168e
000313EC  8945F4            mov [ebp-0xc],eax
000313EF  8B45F4            mov eax,[ebp-0xc]
000313F2  83C018            add eax,byte +0x18
000313F5  83EC0C            sub esp,byte +0xc
000313F8  50                push eax
000313F9  E88A080000        call dword 0x31c88
000313FE  83C410            add esp,byte +0x10
00031401  8B45F4            mov eax,[ebp-0xc]
00031404  8B4014            mov eax,[eax+0x14]
00031407  A360830500        mov [0x58360],eax
0003140C  90                nop
0003140D  C9                leave
0003140E  C3                ret
0003140F  55                push ebp
00031410  89E5              mov ebp,esp
00031412  83EC28            sub esp,byte +0x28
00031415  8B4D10            mov ecx,[ebp+0x10]
00031418  8B551C            mov edx,[ebp+0x1c]
0003141B  8B4520            mov eax,[ebp+0x20]
0003141E  66894DE4          mov [ebp-0x1c],cx
00031422  8855E0            mov [ebp-0x20],dl
00031425  8845DC            mov [ebp-0x24],al
00031428  A1AC550300        mov eax,[0x355ac]
0003142D  83C001            add eax,byte +0x1
00031430  A3AC550300        mov [0x355ac],eax
00031435  8B4514            mov eax,[ebp+0x14]
00031438  C1E007            shl eax,byte 0x7
0003143B  0580830500        add eax,0x58380
00031440  8945F4            mov [ebp-0xc],eax
00031443  8B4508            mov eax,[ebp+0x8]
00031446  8D5008            lea edx,[eax+0x8]
00031449  8B45F4            mov eax,[ebp-0xc]
0003144C  83C064            add eax,byte +0x64
0003144F  83EC08            sub esp,byte +0x8
00031452  52                push edx
00031453  50                push eax
00031454  E8F1200000        call dword 0x3354a
00031459  83C410            add esp,byte +0x10
0003145C  8B45F4            mov eax,[ebp-0xc]
0003145F  8B5518            mov edx,[ebp+0x18]
00031462  895060            mov [eax+0x60],edx
00031465  8B5514            mov edx,[ebp+0x14]
00031468  89D0              mov eax,edx
0003146A  01C0              add eax,eax
0003146C  01D0              add eax,edx
0003146E  C1E004            shl eax,byte 0x4
00031471  8D9000820500      lea edx,[eax+0x58200]
00031477  8B45F4            mov eax,[ebp-0xc]
0003147A  89505C            mov [eax+0x5c],edx
0003147D  8B5514            mov edx,[ebp+0x14]
00031480  89D0              mov eax,edx
00031482  01C0              add eax,eax
00031484  01D0              add eax,edx
00031486  C1E004            shl eax,byte 0x4
00031489  8D9014820500      lea edx,[eax+0x58214]
0003148F  8B45F4            mov eax,[ebp-0xc]
00031492  8902              mov [edx],eax
00031494  8B45F4            mov eax,[ebp-0xc]
00031497  0FB755E4          movzx edx,word [ebp-0x1c]
0003149B  66895048          mov [eax+0x48],dx
0003149F  8B45F4            mov eax,[ebp-0xc]
000314A2  83C04A            add eax,byte +0x4a
000314A5  83EC04            sub esp,byte +0x4
000314A8  6A08              push byte +0x8
000314AA  6828650500        push dword 0x56528
000314AF  50                push eax
000314B0  E84B200000        call dword 0x33500
000314B5  83C410            add esp,byte +0x10
000314B8  0FB645E0          movzx eax,byte [ebp-0x20]
000314BC  C1E005            shl eax,byte 0x5
000314BF  83C898            or eax,byte -0x68
000314C2  89C2              mov edx,eax
000314C4  8B45F4            mov eax,[ebp-0xc]
000314C7  88504F            mov [eax+0x4f],dl
000314CA  8B45F4            mov eax,[ebp-0xc]
000314CD  83C052            add eax,byte +0x52
000314D0  83EC04            sub esp,byte +0x4
000314D3  6A08              push byte +0x8
000314D5  6830650500        push dword 0x56530
000314DA  50                push eax
000314DB  E820200000        call dword 0x33500
000314E0  83C410            add esp,byte +0x10
000314E3  0FB645E0          movzx eax,byte [ebp-0x20]
000314E7  C1E005            shl eax,byte 0x5
000314EA  83C892            or eax,byte -0x6e
000314ED  89C2              mov edx,eax
000314EF  8B45F4            mov eax,[ebp-0xc]
000314F2  885057            mov [eax+0x57],dl
000314F5  0FB645DC          movzx eax,byte [ebp-0x24]
000314F9  83C804            or eax,byte +0x4
000314FC  0FB6D0            movzx edx,al
000314FF  8B45F4            mov eax,[ebp-0xc]
00031502  895038            mov [eax+0x38],edx
00031505  0FB645DC          movzx eax,byte [ebp-0x24]
00031509  83C80C            or eax,byte +0xc
0003150C  0FB6D0            movzx edx,al
0003150F  8B45F4            mov eax,[ebp-0xc]
00031512  89500C            mov [eax+0xc],edx
00031515  0FB645DC          movzx eax,byte [ebp-0x24]
00031519  83C80C            or eax,byte +0xc
0003151C  0FB6D0            movzx edx,al
0003151F  8B45F4            mov eax,[ebp-0xc]
00031522  895008            mov [eax+0x8],edx
00031525  0FB645DC          movzx eax,byte [ebp-0x24]
00031529  83C80C            or eax,byte +0xc
0003152C  0FB6D0            movzx edx,al
0003152F  8B45F4            mov eax,[ebp-0xc]
00031532  895004            mov [eax+0x4],edx
00031535  0FB645DC          movzx eax,byte [ebp-0x24]
00031539  83C80C            or eax,byte +0xc
0003153C  0FB6D0            movzx edx,al
0003153F  8B45F4            mov eax,[ebp-0xc]
00031542  895044            mov [eax+0x44],edx
00031545  0FB645DC          movzx eax,byte [ebp-0x24]
00031549  83C818            or eax,byte +0x18
0003154C  0FB6D0            movzx edx,al
0003154F  8B45F4            mov eax,[ebp-0xc]
00031552  8910              mov [eax],edx
00031554  8B4508            mov eax,[ebp+0x8]
00031557  8B00              mov eax,[eax]
00031559  89C2              mov edx,eax
0003155B  8B45F4            mov eax,[ebp-0xc]
0003155E  895034            mov [eax+0x34],edx
00031561  8B550C            mov edx,[ebp+0xc]
00031564  8B45F4            mov eax,[ebp-0xc]
00031567  895040            mov [eax+0x40],edx
0003156A  8B5524            mov edx,[ebp+0x24]
0003156D  8B45F4            mov eax,[ebp-0xc]
00031570  89503C            mov [eax+0x3c],edx
00031573  A160830500        mov eax,[0x58360]
00031578  85C0              test eax,eax
0003157A  7520              jnz 0x3159c
0003157C  8B45F4            mov eax,[ebp-0xc]
0003157F  A360830500        mov [0x58360],eax
00031584  A160830500        mov eax,[0x58360]
00031589  8B55F4            mov edx,[ebp-0xc]
0003158C  895078            mov [eax+0x78],edx
0003158F  A160830500        mov eax,[0x58360]
00031594  8B55F4            mov edx,[ebp-0xc]
00031597  895074            mov [eax+0x74],edx
0003159A  EB34              jmp short 0x315d0
0003159C  A160830500        mov eax,[0x58360]
000315A1  8B4078            mov eax,[eax+0x78]
000315A4  8945F0            mov [ebp-0x10],eax
000315A7  8B45F0            mov eax,[ebp-0x10]
000315AA  8B55F4            mov edx,[ebp-0xc]
000315AD  895074            mov [eax+0x74],edx
000315B0  8B45F4            mov eax,[ebp-0xc]
000315B3  8B55F0            mov edx,[ebp-0x10]
000315B6  895078            mov [eax+0x78],edx
000315B9  A160830500        mov eax,[0x58360]
000315BE  8B55F4            mov edx,[ebp-0xc]
000315C1  895078            mov [eax+0x78],edx
000315C4  8B1560830500      mov edx,[dword 0x58360]
000315CA  8B45F4            mov eax,[ebp-0xc]
000315CD  895074            mov [eax+0x74],edx
000315D0  90                nop
000315D1  C9                leave
000315D2  C3                ret
000315D3  55                push ebp
000315D4  89E5              mov ebp,esp
000315D6  83EC10            sub esp,byte +0x10
000315D9  A1AC550300        mov eax,[0x355ac]
000315DE  83E801            sub eax,byte +0x1
000315E1  A3AC550300        mov [0x355ac],eax
000315E6  A160830500        mov eax,[0x58360]
000315EB  8945FC            mov [ebp-0x4],eax
000315EE  8B45FC            mov eax,[ebp-0x4]
000315F1  8B4060            mov eax,[eax+0x60]
000315F4  3B4508            cmp eax,[ebp+0x8]
000315F7  7552              jnz 0x3164b
000315F9  8B45FC            mov eax,[ebp-0x4]
000315FC  8B4074            mov eax,[eax+0x74]
000315FF  8945F8            mov [ebp-0x8],eax
00031602  8B45FC            mov eax,[ebp-0x4]
00031605  8B4078            mov eax,[eax+0x78]
00031608  8945F4            mov [ebp-0xc],eax
0003160B  8B45F8            mov eax,[ebp-0x8]
0003160E  8B55F4            mov edx,[ebp-0xc]
00031611  895078            mov [eax+0x78],edx
00031614  8B45F4            mov eax,[ebp-0xc]
00031617  8B55F8            mov edx,[ebp-0x8]
0003161A  895074            mov [eax+0x74],edx
0003161D  8B45F8            mov eax,[ebp-0x8]
00031620  3B45FC            cmp eax,[ebp-0x4]
00031623  750A              jnz 0x3162f
00031625  C705608305000000  mov dword [dword 0x58360],0x0
         -0000
0003162F  A160830500        mov eax,[0x58360]
00031634  3945FC            cmp [ebp-0x4],eax
00031637  7527              jnz 0x31660
00031639  8B45F8            mov eax,[ebp-0x8]
0003163C  3B45FC            cmp eax,[ebp-0x4]
0003163F  741F              jz 0x31660
00031641  8B45F8            mov eax,[ebp-0x8]
00031644  A360830500        mov [0x58360],eax
00031649  EB15              jmp short 0x31660
0003164B  8B45FC            mov eax,[ebp-0x4]
0003164E  8B4078            mov eax,[eax+0x78]
00031651  8945FC            mov [ebp-0x4],eax
00031654  A160830500        mov eax,[0x58360]
00031659  3945FC            cmp [ebp-0x4],eax
0003165C  7590              jnz 0x315ee
0003165E  EB01              jmp short 0x31661
00031660  90                nop
00031661  90                nop
00031662  C9                leave
00031663  C3                ret
00031664  55                push ebp
00031665  89E5              mov ebp,esp
00031667  A1C0820500        mov eax,[0x582c0]
0003166C  5D                pop ebp
0003166D  C3                ret
0003166E  55                push ebp
0003166F  89E5              mov ebp,esp
00031671  EB09              jmp short 0x3167c
00031673  8B4508            mov eax,[ebp+0x8]
00031676  8B4008            mov eax,[eax+0x8]
00031679  894508            mov [ebp+0x8],eax
0003167C  8B4508            mov eax,[ebp+0x8]
0003167F  8B4008            mov eax,[eax+0x8]
00031682  3DB0550300        cmp eax,0x355b0
00031687  75EA              jnz 0x31673
00031689  8B4508            mov eax,[ebp+0x8]
0003168C  5D                pop ebp
0003168D  C3                ret
0003168E  55                push ebp
0003168F  89E5              mov ebp,esp
00031691  83EC10            sub esp,byte +0x10
00031694  A1C8550300        mov eax,[0x355c8]
00031699  50                push eax
0003169A  E8CFFFFFFF        call dword 0x3166e
0003169F  83C404            add esp,byte +0x4
000316A2  8945FC            mov [ebp-0x4],eax
000316A5  817DFCB0550300    cmp dword [ebp-0x4],0x355b0
000316AC  7507              jnz 0x316b5
000316AE  B8FFFFFFFF        mov eax,0xffffffff
000316B3  EB06              jmp short 0x316bb
000316B5  8B45FC            mov eax,[ebp-0x4]
000316B8  8B4014            mov eax,[eax+0x14]
000316BB  C9                leave
000316BC  C3                ret
000316BD  55                push ebp
000316BE  89E5              mov ebp,esp
000316C0  83EC10            sub esp,byte +0x10
000316C3  8B4508            mov eax,[ebp+0x8]
000316C6  8B400C            mov eax,[eax+0xc]
000316C9  8945FC            mov [ebp-0x4],eax
000316CC  8B45FC            mov eax,[ebp-0x4]
000316CF  8B5008            mov edx,[eax+0x8]
000316D2  8B4508            mov eax,[ebp+0x8]
000316D5  89500C            mov [eax+0xc],edx
000316D8  8B45FC            mov eax,[ebp-0x4]
000316DB  8B4008            mov eax,[eax+0x8]
000316DE  3DB0550300        cmp eax,0x355b0
000316E3  740C              jz 0x316f1
000316E5  8B45FC            mov eax,[ebp-0x4]
000316E8  8B4008            mov eax,[eax+0x8]
000316EB  8B5508            mov edx,[ebp+0x8]
000316EE  895010            mov [eax+0x10],edx
000316F1  8B4508            mov eax,[ebp+0x8]
000316F4  8B5010            mov edx,[eax+0x10]
000316F7  8B45FC            mov eax,[ebp-0x4]
000316FA  895010            mov [eax+0x10],edx
000316FD  8B4508            mov eax,[ebp+0x8]
00031700  8B4010            mov eax,[eax+0x10]
00031703  3DB0550300        cmp eax,0x355b0
00031708  750A              jnz 0x31714
0003170A  8B45FC            mov eax,[ebp-0x4]
0003170D  A3C8550300        mov [0x355c8],eax
00031712  EB28              jmp short 0x3173c
00031714  8B4508            mov eax,[ebp+0x8]
00031717  8B4010            mov eax,[eax+0x10]
0003171A  8B4008            mov eax,[eax+0x8]
0003171D  3B4508            cmp eax,[ebp+0x8]
00031720  750E              jnz 0x31730
00031722  8B4508            mov eax,[ebp+0x8]
00031725  8B4010            mov eax,[eax+0x10]
00031728  8B55FC            mov edx,[ebp-0x4]
0003172B  895008            mov [eax+0x8],edx
0003172E  EB0C              jmp short 0x3173c
00031730  8B4508            mov eax,[ebp+0x8]
00031733  8B4010            mov eax,[eax+0x10]
00031736  8B55FC            mov edx,[ebp-0x4]
00031739  89500C            mov [eax+0xc],edx
0003173C  8B45FC            mov eax,[ebp-0x4]
0003173F  8B5508            mov edx,[ebp+0x8]
00031742  895008            mov [eax+0x8],edx
00031745  8B4508            mov eax,[ebp+0x8]
00031748  8B55FC            mov edx,[ebp-0x4]
0003174B  895010            mov [eax+0x10],edx
0003174E  90                nop
0003174F  C9                leave
00031750  C3                ret
00031751  55                push ebp
00031752  89E5              mov ebp,esp
00031754  83EC10            sub esp,byte +0x10
00031757  8B4508            mov eax,[ebp+0x8]
0003175A  8B4008            mov eax,[eax+0x8]
0003175D  8945FC            mov [ebp-0x4],eax
00031760  8B45FC            mov eax,[ebp-0x4]
00031763  8B500C            mov edx,[eax+0xc]
00031766  8B4508            mov eax,[ebp+0x8]
00031769  895008            mov [eax+0x8],edx
0003176C  8B45FC            mov eax,[ebp-0x4]
0003176F  8B400C            mov eax,[eax+0xc]
00031772  3DB0550300        cmp eax,0x355b0
00031777  740C              jz 0x31785
00031779  8B45FC            mov eax,[ebp-0x4]
0003177C  8B400C            mov eax,[eax+0xc]
0003177F  8B5508            mov edx,[ebp+0x8]
00031782  895010            mov [eax+0x10],edx
00031785  8B4508            mov eax,[ebp+0x8]
00031788  8B5010            mov edx,[eax+0x10]
0003178B  8B45FC            mov eax,[ebp-0x4]
0003178E  895010            mov [eax+0x10],edx
00031791  8B4508            mov eax,[ebp+0x8]
00031794  8B4010            mov eax,[eax+0x10]
00031797  3DB0550300        cmp eax,0x355b0
0003179C  750A              jnz 0x317a8
0003179E  8B45FC            mov eax,[ebp-0x4]
000317A1  A3C8550300        mov [0x355c8],eax
000317A6  EB28              jmp short 0x317d0
000317A8  8B4508            mov eax,[ebp+0x8]
000317AB  8B4010            mov eax,[eax+0x10]
000317AE  8B4008            mov eax,[eax+0x8]
000317B1  3B4508            cmp eax,[ebp+0x8]
000317B4  750E              jnz 0x317c4
000317B6  8B4508            mov eax,[ebp+0x8]
000317B9  8B4010            mov eax,[eax+0x10]
000317BC  8B55FC            mov edx,[ebp-0x4]
000317BF  895008            mov [eax+0x8],edx
000317C2  EB0C              jmp short 0x317d0
000317C4  8B4508            mov eax,[ebp+0x8]
000317C7  8B4010            mov eax,[eax+0x10]
000317CA  8B55FC            mov edx,[ebp-0x4]
000317CD  89500C            mov [eax+0xc],edx
000317D0  8B45FC            mov eax,[ebp-0x4]
000317D3  8B5508            mov edx,[ebp+0x8]
000317D6  89500C            mov [eax+0xc],edx
000317D9  8B4508            mov eax,[ebp+0x8]
000317DC  8B55FC            mov edx,[ebp-0x4]
000317DF  895010            mov [eax+0x10],edx
000317E2  90                nop
000317E3  C9                leave
000317E4  C3                ret
000317E5  55                push ebp
000317E6  89E5              mov ebp,esp
000317E8  83EC10            sub esp,byte +0x10
000317EB  E956010000        jmp dword 0x31946
000317F0  8B4508            mov eax,[ebp+0x8]
000317F3  8B5010            mov edx,[eax+0x10]
000317F6  8B4508            mov eax,[ebp+0x8]
000317F9  8B4010            mov eax,[eax+0x10]
000317FC  8B4010            mov eax,[eax+0x10]
000317FF  8B4008            mov eax,[eax+0x8]
00031802  39C2              cmp edx,eax
00031804  0F85A2000000      jnz dword 0x318ac
0003180A  8B4508            mov eax,[ebp+0x8]
0003180D  8B4010            mov eax,[eax+0x10]
00031810  8B4010            mov eax,[eax+0x10]
00031813  8B400C            mov eax,[eax+0xc]
00031816  8945FC            mov [ebp-0x4],eax
00031819  8B45FC            mov eax,[ebp-0x4]
0003181C  8B00              mov eax,[eax]
0003181E  83F801            cmp eax,byte +0x1
00031821  7535              jnz 0x31858
00031823  8B4508            mov eax,[ebp+0x8]
00031826  8B4010            mov eax,[eax+0x10]
00031829  C70000000000      mov dword [eax],0x0
0003182F  8B45FC            mov eax,[ebp-0x4]
00031832  C70000000000      mov dword [eax],0x0
00031838  8B4508            mov eax,[ebp+0x8]
0003183B  8B4010            mov eax,[eax+0x10]
0003183E  8B4010            mov eax,[eax+0x10]
00031841  C70001000000      mov dword [eax],0x1
00031847  8B4508            mov eax,[ebp+0x8]
0003184A  8B4010            mov eax,[eax+0x10]
0003184D  8B4010            mov eax,[eax+0x10]
00031850  894508            mov [ebp+0x8],eax
00031853  E9EE000000        jmp dword 0x31946
00031858  8B4508            mov eax,[ebp+0x8]
0003185B  8B4010            mov eax,[eax+0x10]
0003185E  8B400C            mov eax,[eax+0xc]
00031861  3B4508            cmp eax,[ebp+0x8]
00031864  7514              jnz 0x3187a
00031866  8B4508            mov eax,[ebp+0x8]
00031869  8B4010            mov eax,[eax+0x10]
0003186C  894508            mov [ebp+0x8],eax
0003186F  FF7508            push dword [ebp+0x8]
00031872  E846FEFFFF        call dword 0x316bd
00031877  83C404            add esp,byte +0x4
0003187A  8B4508            mov eax,[ebp+0x8]
0003187D  8B4010            mov eax,[eax+0x10]
00031880  C70000000000      mov dword [eax],0x0
00031886  8B4508            mov eax,[ebp+0x8]
00031889  8B4010            mov eax,[eax+0x10]
0003188C  8B4010            mov eax,[eax+0x10]
0003188F  C70001000000      mov dword [eax],0x1
00031895  8B4508            mov eax,[ebp+0x8]
00031898  8B4010            mov eax,[eax+0x10]
0003189B  8B4010            mov eax,[eax+0x10]
0003189E  50                push eax
0003189F  E8ADFEFFFF        call dword 0x31751
000318A4  83C404            add esp,byte +0x4
000318A7  E99A000000        jmp dword 0x31946
000318AC  8B4508            mov eax,[ebp+0x8]
000318AF  8B4010            mov eax,[eax+0x10]
000318B2  8B4010            mov eax,[eax+0x10]
000318B5  8B4008            mov eax,[eax+0x8]
000318B8  8945F8            mov [ebp-0x8],eax
000318BB  8B45F8            mov eax,[ebp-0x8]
000318BE  8B00              mov eax,[eax]
000318C0  83F801            cmp eax,byte +0x1
000318C3  7532              jnz 0x318f7
000318C5  8B4508            mov eax,[ebp+0x8]
000318C8  8B4010            mov eax,[eax+0x10]
000318CB  C70000000000      mov dword [eax],0x0
000318D1  8B45F8            mov eax,[ebp-0x8]
000318D4  C70000000000      mov dword [eax],0x0
000318DA  8B4508            mov eax,[ebp+0x8]
000318DD  8B4010            mov eax,[eax+0x10]
000318E0  8B4010            mov eax,[eax+0x10]
000318E3  C70001000000      mov dword [eax],0x1
000318E9  8B4508            mov eax,[ebp+0x8]
000318EC  8B4010            mov eax,[eax+0x10]
000318EF  8B4010            mov eax,[eax+0x10]
000318F2  894508            mov [ebp+0x8],eax
000318F5  EB4F              jmp short 0x31946
000318F7  8B4508            mov eax,[ebp+0x8]
000318FA  8B4010            mov eax,[eax+0x10]
000318FD  8B4008            mov eax,[eax+0x8]
00031900  3B4508            cmp eax,[ebp+0x8]
00031903  7514              jnz 0x31919
00031905  8B4508            mov eax,[ebp+0x8]
00031908  8B4010            mov eax,[eax+0x10]
0003190B  894508            mov [ebp+0x8],eax
0003190E  FF7508            push dword [ebp+0x8]
00031911  E83BFEFFFF        call dword 0x31751
00031916  83C404            add esp,byte +0x4
00031919  8B4508            mov eax,[ebp+0x8]
0003191C  8B4010            mov eax,[eax+0x10]
0003191F  C70000000000      mov dword [eax],0x0
00031925  8B4508            mov eax,[ebp+0x8]
00031928  8B4010            mov eax,[eax+0x10]
0003192B  8B4010            mov eax,[eax+0x10]
0003192E  C70001000000      mov dword [eax],0x1
00031934  8B4508            mov eax,[ebp+0x8]
00031937  8B4010            mov eax,[eax+0x10]
0003193A  8B4010            mov eax,[eax+0x10]
0003193D  50                push eax
0003193E  E87AFDFFFF        call dword 0x316bd
00031943  83C404            add esp,byte +0x4
00031946  8B4508            mov eax,[ebp+0x8]
00031949  8B4010            mov eax,[eax+0x10]
0003194C  8B00              mov eax,[eax]
0003194E  83F801            cmp eax,byte +0x1
00031951  0F8499FEFFFF      jz dword 0x317f0
00031957  A1C8550300        mov eax,[0x355c8]
0003195C  C70000000000      mov dword [eax],0x0
00031962  90                nop
00031963  C9                leave
00031964  C3                ret
00031965  55                push ebp
00031966  89E5              mov ebp,esp
00031968  83EC10            sub esp,byte +0x10
0003196B  C745FCB0550300    mov dword [ebp-0x4],0x355b0
00031972  A1C8550300        mov eax,[0x355c8]
00031977  8945F8            mov [ebp-0x8],eax
0003197A  EB2A              jmp short 0x319a6
0003197C  8B45F8            mov eax,[ebp-0x8]
0003197F  8945FC            mov [ebp-0x4],eax
00031982  8B4508            mov eax,[ebp+0x8]
00031985  8B5004            mov edx,[eax+0x4]
00031988  8B45F8            mov eax,[ebp-0x8]
0003198B  8B4004            mov eax,[eax+0x4]
0003198E  39C2              cmp edx,eax
00031990  730B              jnc 0x3199d
00031992  8B45F8            mov eax,[ebp-0x8]
00031995  8B4008            mov eax,[eax+0x8]
00031998  8945F8            mov [ebp-0x8],eax
0003199B  EB09              jmp short 0x319a6
0003199D  8B45F8            mov eax,[ebp-0x8]
000319A0  8B400C            mov eax,[eax+0xc]
000319A3  8945F8            mov [ebp-0x8],eax
000319A6  817DF8B0550300    cmp dword [ebp-0x8],0x355b0
000319AD  75CD              jnz 0x3197c
000319AF  8B4508            mov eax,[ebp+0x8]
000319B2  8B55FC            mov edx,[ebp-0x4]
000319B5  895010            mov [eax+0x10],edx
000319B8  817DFCB0550300    cmp dword [ebp-0x4],0x355b0
000319BF  750A              jnz 0x319cb
000319C1  8B4508            mov eax,[ebp+0x8]
000319C4  A3C8550300        mov [0x355c8],eax
000319C9  EB24              jmp short 0x319ef
000319CB  8B4508            mov eax,[ebp+0x8]
000319CE  8B5004            mov edx,[eax+0x4]
000319D1  8B45FC            mov eax,[ebp-0x4]
000319D4  8B4004            mov eax,[eax+0x4]
000319D7  39C2              cmp edx,eax
000319D9  730B              jnc 0x319e6
000319DB  8B45FC            mov eax,[ebp-0x4]
000319DE  8B5508            mov edx,[ebp+0x8]
000319E1  895008            mov [eax+0x8],edx
000319E4  EB09              jmp short 0x319ef
000319E6  8B45FC            mov eax,[ebp-0x4]
000319E9  8B5508            mov edx,[ebp+0x8]
000319EC  89500C            mov [eax+0xc],edx
000319EF  8B4508            mov eax,[ebp+0x8]
000319F2  C74008B0550300    mov dword [eax+0x8],0x355b0
000319F9  8B4508            mov eax,[ebp+0x8]
000319FC  C7400CB0550300    mov dword [eax+0xc],0x355b0
00031A03  8B4508            mov eax,[ebp+0x8]
00031A06  C70001000000      mov dword [eax],0x1
00031A0C  FF7508            push dword [ebp+0x8]
00031A0F  E8D1FDFFFF        call dword 0x317e5
00031A14  83C404            add esp,byte +0x4
00031A17  90                nop
00031A18  C9                leave
00031A19  C3                ret
00031A1A  55                push ebp
00031A1B  89E5              mov ebp,esp
00031A1D  8B4508            mov eax,[ebp+0x8]
00031A20  8B4010            mov eax,[eax+0x10]
00031A23  3DB0550300        cmp eax,0x355b0
00031A28  750A              jnz 0x31a34
00031A2A  8B450C            mov eax,[ebp+0xc]
00031A2D  A3C8550300        mov [0x355c8],eax
00031A32  EB28              jmp short 0x31a5c
00031A34  8B4508            mov eax,[ebp+0x8]
00031A37  8B4010            mov eax,[eax+0x10]
00031A3A  8B4008            mov eax,[eax+0x8]
00031A3D  3B4508            cmp eax,[ebp+0x8]
00031A40  750E              jnz 0x31a50
00031A42  8B4508            mov eax,[ebp+0x8]
00031A45  8B4010            mov eax,[eax+0x10]
00031A48  8B550C            mov edx,[ebp+0xc]
00031A4B  895008            mov [eax+0x8],edx
00031A4E  EB0C              jmp short 0x31a5c
00031A50  8B4508            mov eax,[ebp+0x8]
00031A53  8B4010            mov eax,[eax+0x10]
00031A56  8B550C            mov edx,[ebp+0xc]
00031A59  89500C            mov [eax+0xc],edx
00031A5C  817D0CB0550300    cmp dword [ebp+0xc],0x355b0
00031A63  740C              jz 0x31a71
00031A65  8B4508            mov eax,[ebp+0x8]
00031A68  8B5010            mov edx,[eax+0x10]
00031A6B  8B450C            mov eax,[ebp+0xc]
00031A6E  895010            mov [eax+0x10],edx
00031A71  90                nop
00031A72  5D                pop ebp
00031A73  C3                ret
00031A74  55                push ebp
00031A75  89E5              mov ebp,esp
00031A77  83EC10            sub esp,byte +0x10
00031A7A  E9E6010000        jmp dword 0x31c65
00031A7F  8B4508            mov eax,[ebp+0x8]
00031A82  8B4010            mov eax,[eax+0x10]
00031A85  8B4008            mov eax,[eax+0x8]
00031A88  3B4508            cmp eax,[ebp+0x8]
00031A8B  0F85EE000000      jnz dword 0x31b7f
00031A91  8B4508            mov eax,[ebp+0x8]
00031A94  8B4010            mov eax,[eax+0x10]
00031A97  8B400C            mov eax,[eax+0xc]
00031A9A  8945FC            mov [ebp-0x4],eax
00031A9D  8B45FC            mov eax,[ebp-0x4]
00031AA0  8B00              mov eax,[eax]
00031AA2  83F801            cmp eax,byte +0x1
00031AA5  7530              jnz 0x31ad7
00031AA7  8B45FC            mov eax,[ebp-0x4]
00031AAA  C70000000000      mov dword [eax],0x0
00031AB0  8B4508            mov eax,[ebp+0x8]
00031AB3  8B4010            mov eax,[eax+0x10]
00031AB6  C70001000000      mov dword [eax],0x1
00031ABC  8B4508            mov eax,[ebp+0x8]
00031ABF  8B4010            mov eax,[eax+0x10]
00031AC2  50                push eax
00031AC3  E8F5FBFFFF        call dword 0x316bd
00031AC8  83C404            add esp,byte +0x4
00031ACB  8B4508            mov eax,[ebp+0x8]
00031ACE  8B4010            mov eax,[eax+0x10]
00031AD1  8B400C            mov eax,[eax+0xc]
00031AD4  8945FC            mov [ebp-0x4],eax
00031AD7  8B45FC            mov eax,[ebp-0x4]
00031ADA  8B4008            mov eax,[eax+0x8]
00031ADD  8B00              mov eax,[eax]
00031ADF  85C0              test eax,eax
00031AE1  7523              jnz 0x31b06
00031AE3  8B45FC            mov eax,[ebp-0x4]
00031AE6  8B400C            mov eax,[eax+0xc]
00031AE9  8B00              mov eax,[eax]
00031AEB  85C0              test eax,eax
00031AED  7517              jnz 0x31b06
00031AEF  8B45FC            mov eax,[ebp-0x4]
00031AF2  C70001000000      mov dword [eax],0x1
00031AF8  8B4508            mov eax,[ebp+0x8]
00031AFB  8B4010            mov eax,[eax+0x10]
00031AFE  894508            mov [ebp+0x8],eax
00031B01  E95F010000        jmp dword 0x31c65
00031B06  8B45FC            mov eax,[ebp-0x4]
00031B09  8B400C            mov eax,[eax+0xc]
00031B0C  8B00              mov eax,[eax]
00031B0E  85C0              test eax,eax
00031B10  752C              jnz 0x31b3e
00031B12  8B45FC            mov eax,[ebp-0x4]
00031B15  8B4008            mov eax,[eax+0x8]
00031B18  C70000000000      mov dword [eax],0x0
00031B1E  8B45FC            mov eax,[ebp-0x4]
00031B21  C70001000000      mov dword [eax],0x1
00031B27  FF75FC            push dword [ebp-0x4]
00031B2A  E822FCFFFF        call dword 0x31751
00031B2F  83C404            add esp,byte +0x4
00031B32  8B4508            mov eax,[ebp+0x8]
00031B35  8B4010            mov eax,[eax+0x10]
00031B38  8B400C            mov eax,[eax+0xc]
00031B3B  8945FC            mov [ebp-0x4],eax
00031B3E  8B4508            mov eax,[ebp+0x8]
00031B41  8B4010            mov eax,[eax+0x10]
00031B44  8B10              mov edx,[eax]
00031B46  8B45FC            mov eax,[ebp-0x4]
00031B49  8910              mov [eax],edx
00031B4B  8B4508            mov eax,[ebp+0x8]
00031B4E  8B4010            mov eax,[eax+0x10]
00031B51  C70000000000      mov dword [eax],0x0
00031B57  8B45FC            mov eax,[ebp-0x4]
00031B5A  8B400C            mov eax,[eax+0xc]
00031B5D  C70000000000      mov dword [eax],0x0
00031B63  8B4508            mov eax,[ebp+0x8]
00031B66  8B4010            mov eax,[eax+0x10]
00031B69  50                push eax
00031B6A  E84EFBFFFF        call dword 0x316bd
00031B6F  83C404            add esp,byte +0x4
00031B72  A1C8550300        mov eax,[0x355c8]
00031B77  894508            mov [ebp+0x8],eax
00031B7A  E9E6000000        jmp dword 0x31c65
00031B7F  8B4508            mov eax,[ebp+0x8]
00031B82  8B4010            mov eax,[eax+0x10]
00031B85  8B4008            mov eax,[eax+0x8]
00031B88  8945F8            mov [ebp-0x8],eax
00031B8B  8B45F8            mov eax,[ebp-0x8]
00031B8E  8B00              mov eax,[eax]
00031B90  83F801            cmp eax,byte +0x1
00031B93  7530              jnz 0x31bc5
00031B95  8B45F8            mov eax,[ebp-0x8]
00031B98  C70000000000      mov dword [eax],0x0
00031B9E  8B4508            mov eax,[ebp+0x8]
00031BA1  8B4010            mov eax,[eax+0x10]
00031BA4  C70001000000      mov dword [eax],0x1
00031BAA  8B4508            mov eax,[ebp+0x8]
00031BAD  8B4010            mov eax,[eax+0x10]
00031BB0  50                push eax
00031BB1  E89BFBFFFF        call dword 0x31751
00031BB6  83C404            add esp,byte +0x4
00031BB9  8B4508            mov eax,[ebp+0x8]
00031BBC  8B4010            mov eax,[eax+0x10]
00031BBF  8B4008            mov eax,[eax+0x8]
00031BC2  8945F8            mov [ebp-0x8],eax
00031BC5  8B45F8            mov eax,[ebp-0x8]
00031BC8  8B400C            mov eax,[eax+0xc]
00031BCB  8B00              mov eax,[eax]
00031BCD  85C0              test eax,eax
00031BCF  7520              jnz 0x31bf1
00031BD1  8B45F8            mov eax,[ebp-0x8]
00031BD4  8B4008            mov eax,[eax+0x8]
00031BD7  8B00              mov eax,[eax]
00031BD9  85C0              test eax,eax
00031BDB  7514              jnz 0x31bf1
00031BDD  8B45F8            mov eax,[ebp-0x8]
00031BE0  C70001000000      mov dword [eax],0x1
00031BE6  8B4508            mov eax,[ebp+0x8]
00031BE9  8B4010            mov eax,[eax+0x10]
00031BEC  894508            mov [ebp+0x8],eax
00031BEF  EB74              jmp short 0x31c65
00031BF1  8B45F8            mov eax,[ebp-0x8]
00031BF4  8B4008            mov eax,[eax+0x8]
00031BF7  8B00              mov eax,[eax]
00031BF9  85C0              test eax,eax
00031BFB  752C              jnz 0x31c29
00031BFD  8B45F8            mov eax,[ebp-0x8]
00031C00  8B400C            mov eax,[eax+0xc]
00031C03  C70000000000      mov dword [eax],0x0
00031C09  8B45F8            mov eax,[ebp-0x8]
00031C0C  C70001000000      mov dword [eax],0x1
00031C12  FF75F8            push dword [ebp-0x8]
00031C15  E8A3FAFFFF        call dword 0x316bd
00031C1A  83C404            add esp,byte +0x4
00031C1D  8B4508            mov eax,[ebp+0x8]
00031C20  8B4010            mov eax,[eax+0x10]
00031C23  8B4008            mov eax,[eax+0x8]
00031C26  8945F8            mov [ebp-0x8],eax
00031C29  8B4508            mov eax,[ebp+0x8]
00031C2C  8B4010            mov eax,[eax+0x10]
00031C2F  8B10              mov edx,[eax]
00031C31  8B45F8            mov eax,[ebp-0x8]
00031C34  8910              mov [eax],edx
00031C36  8B4508            mov eax,[ebp+0x8]
00031C39  8B4010            mov eax,[eax+0x10]
00031C3C  C70000000000      mov dword [eax],0x0
00031C42  8B45F8            mov eax,[ebp-0x8]
00031C45  8B4008            mov eax,[eax+0x8]
00031C48  C70000000000      mov dword [eax],0x0
00031C4E  8B4508            mov eax,[ebp+0x8]
00031C51  8B4010            mov eax,[eax+0x10]
00031C54  50                push eax
00031C55  E8F7FAFFFF        call dword 0x31751
00031C5A  83C404            add esp,byte +0x4
00031C5D  A1C8550300        mov eax,[0x355c8]
00031C62  894508            mov [ebp+0x8],eax
00031C65  A1C8550300        mov eax,[0x355c8]
00031C6A  394508            cmp [ebp+0x8],eax
00031C6D  740D              jz 0x31c7c
00031C6F  8B4508            mov eax,[ebp+0x8]
00031C72  8B00              mov eax,[eax]
00031C74  85C0              test eax,eax
00031C76  0F8403FEFFFF      jz dword 0x31a7f
00031C7C  8B4508            mov eax,[ebp+0x8]
00031C7F  C70000000000      mov dword [eax],0x0
00031C85  90                nop
00031C86  C9                leave
00031C87  C3                ret
00031C88  55                push ebp
00031C89  89E5              mov ebp,esp
00031C8B  83EC10            sub esp,byte +0x10
00031C8E  8B4508            mov eax,[ebp+0x8]
00031C91  8945F4            mov [ebp-0xc],eax
00031C94  8B45F4            mov eax,[ebp-0xc]
00031C97  8B00              mov eax,[eax]
00031C99  8945FC            mov [ebp-0x4],eax
00031C9C  8B4508            mov eax,[ebp+0x8]
00031C9F  8B4008            mov eax,[eax+0x8]
00031CA2  3DB0550300        cmp eax,0x355b0
00031CA7  7520              jnz 0x31cc9
00031CA9  8B4508            mov eax,[ebp+0x8]
00031CAC  8B400C            mov eax,[eax+0xc]
00031CAF  8945F8            mov [ebp-0x8],eax
00031CB2  8B4508            mov eax,[ebp+0x8]
00031CB5  8B400C            mov eax,[eax+0xc]
00031CB8  50                push eax
00031CB9  FF7508            push dword [ebp+0x8]
00031CBC  E859FDFFFF        call dword 0x31a1a
00031CC1  83C408            add esp,byte +0x8
00031CC4  E9C0000000        jmp dword 0x31d89
00031CC9  8B4508            mov eax,[ebp+0x8]
00031CCC  8B400C            mov eax,[eax+0xc]
00031CCF  3DB0550300        cmp eax,0x355b0
00031CD4  7520              jnz 0x31cf6
00031CD6  8B4508            mov eax,[ebp+0x8]
00031CD9  8B4008            mov eax,[eax+0x8]
00031CDC  8945F8            mov [ebp-0x8],eax
00031CDF  8B4508            mov eax,[ebp+0x8]
00031CE2  8B4008            mov eax,[eax+0x8]
00031CE5  50                push eax
00031CE6  FF7508            push dword [ebp+0x8]
00031CE9  E82CFDFFFF        call dword 0x31a1a
00031CEE  83C408            add esp,byte +0x8
00031CF1  E993000000        jmp dword 0x31d89
00031CF6  8B4508            mov eax,[ebp+0x8]
00031CF9  8B400C            mov eax,[eax+0xc]
00031CFC  50                push eax
00031CFD  E86CF9FFFF        call dword 0x3166e
00031D02  83C404            add esp,byte +0x4
00031D05  8945F4            mov [ebp-0xc],eax
00031D08  8B45F4            mov eax,[ebp-0xc]
00031D0B  8B00              mov eax,[eax]
00031D0D  8945FC            mov [ebp-0x4],eax
00031D10  8B45F4            mov eax,[ebp-0xc]
00031D13  8B400C            mov eax,[eax+0xc]
00031D16  8945F8            mov [ebp-0x8],eax
00031D19  8B45F4            mov eax,[ebp-0xc]
00031D1C  8B4010            mov eax,[eax+0x10]
00031D1F  3B4508            cmp eax,[ebp+0x8]
00031D22  750B              jnz 0x31d2f
00031D24  8B45F8            mov eax,[ebp-0x8]
00031D27  8B55F4            mov edx,[ebp-0xc]
00031D2A  895010            mov [eax+0x10],edx
00031D2D  EB2A              jmp short 0x31d59
00031D2F  8B45F4            mov eax,[ebp-0xc]
00031D32  8B400C            mov eax,[eax+0xc]
00031D35  50                push eax
00031D36  FF75F4            push dword [ebp-0xc]
00031D39  E8DCFCFFFF        call dword 0x31a1a
00031D3E  83C408            add esp,byte +0x8
00031D41  8B4508            mov eax,[ebp+0x8]
00031D44  8B500C            mov edx,[eax+0xc]
00031D47  8B45F4            mov eax,[ebp-0xc]
00031D4A  89500C            mov [eax+0xc],edx
00031D4D  8B45F4            mov eax,[ebp-0xc]
00031D50  8B400C            mov eax,[eax+0xc]
00031D53  8B55F4            mov edx,[ebp-0xc]
00031D56  895010            mov [eax+0x10],edx
00031D59  FF75F4            push dword [ebp-0xc]
00031D5C  FF7508            push dword [ebp+0x8]
00031D5F  E8B6FCFFFF        call dword 0x31a1a
00031D64  83C408            add esp,byte +0x8
00031D67  8B4508            mov eax,[ebp+0x8]
00031D6A  8B5008            mov edx,[eax+0x8]
00031D6D  8B45F4            mov eax,[ebp-0xc]
00031D70  895008            mov [eax+0x8],edx
00031D73  8B45F4            mov eax,[ebp-0xc]
00031D76  8B4008            mov eax,[eax+0x8]
00031D79  8B55F4            mov edx,[ebp-0xc]
00031D7C  895010            mov [eax+0x10],edx
00031D7F  8B4508            mov eax,[ebp+0x8]
00031D82  8B10              mov edx,[eax]
00031D84  8B45F4            mov eax,[ebp-0xc]
00031D87  8910              mov [eax],edx
00031D89  837DFC00          cmp dword [ebp-0x4],byte +0x0
00031D8D  750B              jnz 0x31d9a
00031D8F  FF75F8            push dword [ebp-0x8]
00031D92  E8DDFCFFFF        call dword 0x31a74
00031D97  83C404            add esp,byte +0x4
00031D9A  90                nop
00031D9B  C9                leave
00031D9C  C3                ret
00031D9D  6690              xchg ax,ax
00031D9F  90                nop
00031DA0  55                push ebp
00031DA1  89E5              mov ebp,esp
00031DA3  8B4508            mov eax,[ebp+0x8]
00031DA6  53                push ebx
00031DA7  56                push esi
00031DA8  BE00002000        mov esi,0x200000
00031DAD  C1E816            shr eax,byte 0x16
00031DB0  BB04000000        mov ebx,0x4
00031DB5  F7E3              mul ebx
00031DB7  01C6              add esi,eax
00031DB9  8B0E              mov ecx,[esi]
00031DBB  89CA              mov edx,ecx
00031DBD  83E201            and edx,byte +0x1
00031DC0  83FA01            cmp edx,byte +0x1
00031DC3  753A              jnz 0x31dff
00031DC5  81E100F0FFFF      and ecx,0xfffff000
00031DCB  8B4508            mov eax,[ebp+0x8]
00031DCE  C1E80C            shr eax,byte 0xc
00031DD1  25FF030000        and eax,0x3ff
00031DD6  BB04000000        mov ebx,0x4
00031DDB  F7E3              mul ebx
00031DDD  89CE              mov esi,ecx
00031DDF  01C6              add esi,eax
00031DE1  8B16              mov edx,[esi]
00031DE3  89D1              mov ecx,edx
00031DE5  83E101            and ecx,byte +0x1
00031DE8  83F901            cmp ecx,byte +0x1
00031DEB  7512              jnz 0x31dff
00031DED  8B4508            mov eax,[ebp+0x8]
00031DF0  25FF0F0000        and eax,0xfff
00031DF5  81E200F0FFFF      and edx,0xfffff000
00031DFB  01D0              add eax,edx
00031DFD  EB09              jmp short 0x31e08
00031DFF  5E                pop esi
00031E00  5B                pop ebx
00031E01  5D                pop ebp
00031E02  B8FFFFFFFF        mov eax,0xffffffff
00031E07  C3                ret
00031E08  5E                pop esi
00031E09  5B                pop ebx
00031E0A  5D                pop ebp
00031E0B  C3                ret
00031E0C  55                push ebp
00031E0D  89E5              mov ebp,esp
00031E0F  8B7D0C            mov edi,[ebp+0xc]
00031E12  8B4508            mov eax,[ebp+0x8]
00031E15  57                push edi
00031E16  56                push esi
00031E17  53                push ebx
00031E18  3D00040000        cmp eax,0x400
00031E1D  7774              ja 0x31e93
00031E1F  BEE8630300        mov esi,0x363e8
00031E24  89C1              mov ecx,eax
00031E26  FC                cld
00031E27  3E8A06            mov al,[ds:esi]
00031E2A  50                push eax
00031E2B  B700              mov bh,0x0
00031E2D  B301              mov bl,0x1
00031E2F  58                pop eax
00031E30  50                push eax
00031E31  80FF00            cmp bh,0x0
00031E34  7402              jz 0x31e38
00031E36  D0E3              shl bl,1
00031E38  20D8              and al,bl
00031E3A  3C01              cmp al,0x1
00031E3C  742E              jz 0x31e6c
00031E3E  58                pop eax
00031E3F  08D8              or al,bl
00031E41  50                push eax
00031E42  89F2              mov edx,esi
00031E44  81EAE8630300      sub edx,0x363e8
00031E4A  89D0              mov eax,edx
00031E4C  BA08000000        mov edx,0x8
00031E51  F7E2              mul edx
00031E53  31D2              xor edx,edx
00031E55  88FA              mov dl,bh
00031E57  01D0              add eax,edx
00031E59  BA00100000        mov edx,0x1000
00031E5E  F7E2              mul edx
00031E60  0500003000        add eax,0x300000
00031E65  AB                stosd
00031E66  49                dec ecx
00031E67  83F900            cmp ecx,byte +0x0
00031E6A  7409              jz 0x31e75
00031E6C  FEC7              inc bh
00031E6E  80FF08            cmp bh,0x8
00031E71  7402              jz 0x31e75
00031E73  EBBA              jmp short 0x31e2f
00031E75  58                pop eax
00031E76  3E8806            mov [ds:esi],al
00031E79  46                inc esi
00031E7A  81FE80000000      cmp esi,0x80
00031E80  7411              jz 0x31e93
00031E82  83F900            cmp ecx,byte +0x0
00031E85  7402              jz 0x31e89
00031E87  EB9E              jmp short 0x31e27
00031E89  B800000000        mov eax,0x0
00031E8E  5B                pop ebx
00031E8F  5E                pop esi
00031E90  5F                pop edi
00031E91  5D                pop ebp
00031E92  C3                ret
00031E93  B8FFFFFFFF        mov eax,0xffffffff
00031E98  5B                pop ebx
00031E99  5E                pop esi
00031E9A  5F                pop edi
00031E9B  5D                pop ebp
00031E9C  C3                ret
00031E9D  53                push ebx
00031E9E  57                push edi
00031E9F  55                push ebp
00031EA0  56                push esi
00031EA1  89E5              mov ebp,esp
00031EA3  8B7518            mov esi,[ebp+0x18]
00031EA6  8B4514            mov eax,[ebp+0x14]
00031EA9  BFE8630300        mov edi,0x363e8
00031EAE  89C1              mov ecx,eax
00031EB0  AD                lodsd
00031EB1  2D00003000        sub eax,0x300000
00031EB6  BB00800000        mov ebx,0x8000
00031EBB  31D2              xor edx,edx
00031EBD  F7F3              div ebx
00031EBF  BFE8630300        mov edi,0x363e8
00031EC4  01C7              add edi,eax
00031EC6  89D0              mov eax,edx
00031EC8  BB00100000        mov ebx,0x1000
00031ECD  31D2              xor edx,edx
00031ECF  F7F3              div ebx
00031ED1  88C2              mov dl,al
00031ED3  8A07              mov al,[edi]
00031ED5  80FA00            cmp dl,0x0
00031ED8  7504              jnz 0x31ede
00031EDA  B3FE              mov bl,0xfe
00031EDC  EB38              jmp short 0x31f16
00031EDE  80FA01            cmp dl,0x1
00031EE1  7504              jnz 0x31ee7
00031EE3  B3FD              mov bl,0xfd
00031EE5  EB2F              jmp short 0x31f16
00031EE7  80FA02            cmp dl,0x2
00031EEA  7504              jnz 0x31ef0
00031EEC  B3FB              mov bl,0xfb
00031EEE  EB26              jmp short 0x31f16
00031EF0  80FA03            cmp dl,0x3
00031EF3  7504              jnz 0x31ef9
00031EF5  B3F7              mov bl,0xf7
00031EF7  EB1D              jmp short 0x31f16
00031EF9  80FA04            cmp dl,0x4
00031EFC  7504              jnz 0x31f02
00031EFE  B3EF              mov bl,0xef
00031F00  EB14              jmp short 0x31f16
00031F02  80FA05            cmp dl,0x5
00031F05  7504              jnz 0x31f0b
00031F07  B3DF              mov bl,0xdf
00031F09  EB0B              jmp short 0x31f16
00031F0B  80FA06            cmp dl,0x6
00031F0E  7504              jnz 0x31f14
00031F10  B3BF              mov bl,0xbf
00031F12  EB02              jmp short 0x31f16
00031F14  B37F              mov bl,0x7f
00031F16  20D8              and al,bl
00031F18  8807              mov [edi],al
00031F1A  E294              loop 0x31eb0
00031F1C  5E                pop esi
00031F1D  5D                pop ebp
00031F1E  5F                pop edi
00031F1F  5B                pop ebx
00031F20  C3                ret
00031F21  55                push ebp
00031F22  53                push ebx
00031F23  56                push esi
00031F24  89E5              mov ebp,esp
00031F26  8B5D14            mov ebx,[ebp+0x14]
00031F29  8B4510            mov eax,[ebp+0x10]
00031F2C  C1E816            shr eax,byte 0x16
00031F2F  BA00100000        mov edx,0x1000
00031F34  F7E2              mul edx
00031F36  89C1              mov ecx,eax
00031F38  8B4510            mov eax,[ebp+0x10]
00031F3B  C1E80C            shr eax,byte 0xc
00031F3E  25FF030000        and eax,0x3ff
00031F43  BA04000000        mov edx,0x4
00031F48  F7E2              mul edx
00031F4A  01C8              add eax,ecx
00031F4C  0500102000        add eax,0x201000
00031F51  89C6              mov esi,eax
00031F53  83CB07            or ebx,byte +0x7
00031F56  891E              mov [esi],ebx
00031F58  5E                pop esi
00031F59  5B                pop ebx
00031F5A  5D                pop ebp
00031F5B  C3                ret
00031F5C  55                push ebp
00031F5D  89E5              mov ebp,esp
00031F5F  8B4508            mov eax,[ebp+0x8]
00031F62  56                push esi
00031F63  C1E816            shr eax,byte 0x16
00031F66  BB00100000        mov ebx,0x1000
00031F6B  F7E3              mul ebx
00031F6D  89C1              mov ecx,eax
00031F6F  8B4508            mov eax,[ebp+0x8]
00031F72  C1E80C            shr eax,byte 0xc
00031F75  25FF030000        and eax,0x3ff
00031F7A  BB04000000        mov ebx,0x4
00031F7F  F7E3              mul ebx
00031F81  01C8              add eax,ecx
00031F83  0500102000        add eax,0x201000
00031F88  89C6              mov esi,eax
00031F8A  8B06              mov eax,[esi]
00031F8C  C70600000000      mov dword [esi],0x0
00031F92  5E                pop esi
00031F93  5D                pop ebp
00031F94  C3                ret
00031F95  57                push edi
00031F96  56                push esi
00031F97  55                push ebp
00031F98  89E5              mov ebp,esp
00031F9A  8B7D10            mov edi,[ebp+0x10]
00031F9D  BEE8630300        mov esi,0x363e8
00031FA2  B904000000        mov ecx,0x4
00031FA7  8B06              mov eax,[esi]
00031FA9  8907              mov [edi],eax
00031FAB  83C604            add esi,byte +0x4
00031FAE  83C704            add edi,byte +0x4
00031FB1  E2F4              loop 0x31fa7
00031FB3  5D                pop ebp
00031FB4  5E                pop esi
00031FB5  5F                pop edi
00031FB6  C3                ret
00031FB7  57                push edi
00031FB8  BFE8630300        mov edi,0x363e8
00031FBD  B980000000        mov ecx,0x80
00031FC2  C60700            mov byte [edi],0x0
00031FC5  47                inc edi
00031FC6  E2FA              loop 0x31fc2
00031FC8  5F                pop edi
00031FC9  C3                ret
00031FCA  55                push ebp
00031FCB  89E5              mov ebp,esp
00031FCD  83EC08            sub esp,byte +0x8
00031FD0  83EC0C            sub esp,byte +0xc
00031FD3  FF7508            push dword [ebp+0x8]
00031FD6  E8AB140000        call dword 0x33486
00031FDB  83C410            add esp,byte +0x10
00031FDE  83EC0C            sub esp,byte +0xc
00031FE1  68E03B0300        push dword 0x33be0
00031FE6  E805130000        call dword 0x332f0
00031FEB  83C410            add esp,byte +0x10
00031FEE  90                nop
00031FEF  C9                leave
00031FF0  C3                ret
00031FF1  55                push ebp
00031FF2  89E5              mov ebp,esp
00031FF4  53                push ebx
00031FF5  83EC34            sub esp,byte +0x34
00031FF8  E8BAFFFFFF        call dword 0x31fb7
00031FFD  83EC0C            sub esp,byte +0xc
00032000  8D45DC            lea eax,[ebp-0x24]
00032003  50                push eax
00032004  E88CFFFFFF        call dword 0x31f95
00032009  83C410            add esp,byte +0x10
0003200C  BB00000000        mov ebx,0x0
00032011  EB13              jmp short 0x32026
00032013  8B449DDC          mov eax,[ebp+ebx*4-0x24]
00032017  83EC0C            sub esp,byte +0xc
0003201A  50                push eax
0003201B  E8AAFFFFFF        call dword 0x31fca
00032020  83C410            add esp,byte +0x10
00032023  83C301            add ebx,byte +0x1
00032026  83FB03            cmp ebx,byte +0x3
00032029  7EE8              jng 0x32013
0003202B  C745F400104000    mov dword [ebp-0xc],0x401000
00032032  83EC0C            sub esp,byte +0xc
00032035  FF75F4            push dword [ebp-0xc]
00032038  E863FDFFFF        call dword 0x31da0
0003203D  83C410            add esp,byte +0x10
00032040  8945F0            mov [ebp-0x10],eax
00032043  83EC0C            sub esp,byte +0xc
00032046  FF75F0            push dword [ebp-0x10]
00032049  E838140000        call dword 0x33486
0003204E  83C410            add esp,byte +0x10
00032051  83EC0C            sub esp,byte +0xc
00032054  68E03B0300        push dword 0x33be0
00032059  E892120000        call dword 0x332f0
0003205E  83C410            add esp,byte +0x10
00032061  83EC0C            sub esp,byte +0xc
00032064  FF75F4            push dword [ebp-0xc]
00032067  E8F0FEFFFF        call dword 0x31f5c
0003206C  83C410            add esp,byte +0x10
0003206F  8945F0            mov [ebp-0x10],eax
00032072  83EC0C            sub esp,byte +0xc
00032075  FF75F0            push dword [ebp-0x10]
00032078  E809140000        call dword 0x33486
0003207D  83C410            add esp,byte +0x10
00032080  83EC0C            sub esp,byte +0xc
00032083  68E03B0300        push dword 0x33be0
00032088  E863120000        call dword 0x332f0
0003208D  83C410            add esp,byte +0x10
00032090  83EC0C            sub esp,byte +0xc
00032093  FF75F4            push dword [ebp-0xc]
00032096  E805FDFFFF        call dword 0x31da0
0003209B  83C410            add esp,byte +0x10
0003209E  8945F0            mov [ebp-0x10],eax
000320A1  83EC0C            sub esp,byte +0xc
000320A4  FF75F0            push dword [ebp-0x10]
000320A7  E8DA130000        call dword 0x33486
000320AC  83C410            add esp,byte +0x10
000320AF  83EC0C            sub esp,byte +0xc
000320B2  68E03B0300        push dword 0x33be0
000320B7  E834120000        call dword 0x332f0
000320BC  83C410            add esp,byte +0x10
000320BF  83EC08            sub esp,byte +0x8
000320C2  8D45D0            lea eax,[ebp-0x30]
000320C5  50                push eax
000320C6  6A03              push byte +0x3
000320C8  E83FFDFFFF        call dword 0x31e0c
000320CD  83C410            add esp,byte +0x10
000320D0  8945EC            mov [ebp-0x14],eax
000320D3  83EC0C            sub esp,byte +0xc
000320D6  8D45DC            lea eax,[ebp-0x24]
000320D9  50                push eax
000320DA  E8B6FEFFFF        call dword 0x31f95
000320DF  83C410            add esp,byte +0x10
000320E2  BB00000000        mov ebx,0x0
000320E7  EB13              jmp short 0x320fc
000320E9  8B449DDC          mov eax,[ebp+ebx*4-0x24]
000320ED  83EC0C            sub esp,byte +0xc
000320F0  50                push eax
000320F1  E8D4FEFFFF        call dword 0x31fca
000320F6  83C410            add esp,byte +0x10
000320F9  83C301            add ebx,byte +0x1
000320FC  83FB03            cmp ebx,byte +0x3
000320FF  7EE8              jng 0x320e9
00032101  837DEC00          cmp dword [ebp-0x14],byte +0x0
00032105  752F              jnz 0x32136
00032107  BB00000000        mov ebx,0x0
0003210C  EB23              jmp short 0x32131
0003210E  8B449DD0          mov eax,[ebp+ebx*4-0x30]
00032112  83EC0C            sub esp,byte +0xc
00032115  50                push eax
00032116  E86B130000        call dword 0x33486
0003211B  83C410            add esp,byte +0x10
0003211E  83EC0C            sub esp,byte +0xc
00032121  68E03B0300        push dword 0x33be0
00032126  E8C5110000        call dword 0x332f0
0003212B  83C410            add esp,byte +0x10
0003212E  83C301            add ebx,byte +0x1
00032131  83FB02            cmp ebx,byte +0x2
00032134  7ED8              jng 0x3210e
00032136  8B45D4            mov eax,[ebp-0x2c]
00032139  83EC08            sub esp,byte +0x8
0003213C  50                push eax
0003213D  FF75F4            push dword [ebp-0xc]
00032140  E8DCFDFFFF        call dword 0x31f21
00032145  83C410            add esp,byte +0x10
00032148  83EC0C            sub esp,byte +0xc
0003214B  FF75F4            push dword [ebp-0xc]
0003214E  E84DFCFFFF        call dword 0x31da0
00032153  83C410            add esp,byte +0x10
00032156  8945F0            mov [ebp-0x10],eax
00032159  83EC0C            sub esp,byte +0xc
0003215C  FF75F0            push dword [ebp-0x10]
0003215F  E822130000        call dword 0x33486
00032164  83C410            add esp,byte +0x10
00032167  83EC0C            sub esp,byte +0xc
0003216A  68E23B0300        push dword 0x33be2
0003216F  E87C110000        call dword 0x332f0
00032174  83C410            add esp,byte +0x10
00032177  83EC0C            sub esp,byte +0xc
0003217A  FF75F4            push dword [ebp-0xc]
0003217D  E8DAFDFFFF        call dword 0x31f5c
00032182  83C410            add esp,byte +0x10
00032185  83EC0C            sub esp,byte +0xc
00032188  FF75F4            push dword [ebp-0xc]
0003218B  E810FCFFFF        call dword 0x31da0
00032190  83C410            add esp,byte +0x10
00032193  8945F0            mov [ebp-0x10],eax
00032196  83EC0C            sub esp,byte +0xc
00032199  FF75F0            push dword [ebp-0x10]
0003219C  E8E5120000        call dword 0x33486
000321A1  83C410            add esp,byte +0x10
000321A4  83EC0C            sub esp,byte +0xc
000321A7  68E03B0300        push dword 0x33be0
000321AC  E83F110000        call dword 0x332f0
000321B1  83C410            add esp,byte +0x10
000321B4  83EC08            sub esp,byte +0x8
000321B7  8D45D0            lea eax,[ebp-0x30]
000321BA  83C004            add eax,byte +0x4
000321BD  50                push eax
000321BE  6A01              push byte +0x1
000321C0  E8D8FCFFFF        call dword 0x31e9d
000321C5  83C410            add esp,byte +0x10
000321C8  83EC0C            sub esp,byte +0xc
000321CB  8D45DC            lea eax,[ebp-0x24]
000321CE  50                push eax
000321CF  E8C1FDFFFF        call dword 0x31f95
000321D4  83C410            add esp,byte +0x10
000321D7  BB00000000        mov ebx,0x0
000321DC  EB13              jmp short 0x321f1
000321DE  8B449DDC          mov eax,[ebp+ebx*4-0x24]
000321E2  83EC0C            sub esp,byte +0xc
000321E5  50                push eax
000321E6  E8DFFDFFFF        call dword 0x31fca
000321EB  83C410            add esp,byte +0x10
000321EE  83C301            add ebx,byte +0x1
000321F1  83FB03            cmp ebx,byte +0x3
000321F4  7EE8              jng 0x321de
000321F6  83EC08            sub esp,byte +0x8
000321F9  8D45D0            lea eax,[ebp-0x30]
000321FC  83C004            add eax,byte +0x4
000321FF  50                push eax
00032200  6A01              push byte +0x1
00032202  E805FCFFFF        call dword 0x31e0c
00032207  83C410            add esp,byte +0x10
0003220A  8B45D4            mov eax,[ebp-0x2c]
0003220D  83EC0C            sub esp,byte +0xc
00032210  50                push eax
00032211  E870120000        call dword 0x33486
00032216  83C410            add esp,byte +0x10
00032219  90                nop
0003221A  8B5DFC            mov ebx,[ebp-0x4]
0003221D  C9                leave
0003221E  C3                ret
0003221F  55                push ebp
00032220  89E5              mov ebp,esp
00032222  83EC18            sub esp,byte +0x18
00032225  83EC0C            sub esp,byte +0xc
00032228  6A60              push byte +0x60
0003222A  E84A110000        call dword 0x33379
0003222F  83C410            add esp,byte +0x10
00032232  8845F7            mov [ebp-0x9],al
00032235  A188640300        mov eax,[0x36488]
0003223A  83F81F            cmp eax,byte +0x1f
0003223D  7F3D              jg 0x3227c
0003223F  A180640300        mov eax,[0x36480]
00032244  0FB655F7          movzx edx,byte [ebp-0x9]
00032248  8810              mov [eax],dl
0003224A  A180640300        mov eax,[0x36480]
0003224F  83C001            add eax,byte +0x1
00032252  A380640300        mov [0x36480],eax
00032257  A180640300        mov eax,[0x36480]
0003225C  BAAC640300        mov edx,0x364ac
00032261  39D0              cmp eax,edx
00032263  750A              jnz 0x3226f
00032265  C705806403008C64  mov dword [dword 0x36480],0x3648c
         -0300
0003226F  A188640300        mov eax,[0x36488]
00032274  83C001            add eax,byte +0x1
00032277  A388640300        mov [0x36488],eax
0003227C  90                nop
0003227D  C9                leave
0003227E  C3                ret
0003227F  55                push ebp
00032280  89E5              mov ebp,esp
00032282  83EC08            sub esp,byte +0x8
00032285  C705886403000000  mov dword [dword 0x36488],0x0
         -0000
0003228F  C705846403008C64  mov dword [dword 0x36484],0x3648c
         -0300
00032299  A184640300        mov eax,[0x36484]
0003229E  A380640300        mov [0x36480],eax
000322A3  C705B46403000000  mov dword [dword 0x364b4],0x0
         -0000
000322AD  A1B4640300        mov eax,[0x364b4]
000322B2  A3B0640300        mov [0x364b0],eax
000322B7  C705BC6403000000  mov dword [dword 0x364bc],0x0
         -0000
000322C1  A1BC640300        mov eax,[0x364bc]
000322C6  A3B8640300        mov [0x364b8],eax
000322CB  C705C46403000000  mov dword [dword 0x364c4],0x0
         -0000
000322D5  A1C4640300        mov eax,[0x364c4]
000322DA  A3C0640300        mov [0x364c0],eax
000322DF  C705C86403000000  mov dword [dword 0x364c8],0x0
         -0000
000322E9  C705CC6403000100  mov dword [dword 0x364cc],0x1
         -0000
000322F3  C705D06403000000  mov dword [dword 0x364d0],0x0
         -0000
000322FD  E844050000        call dword 0x32846
00032302  83EC08            sub esp,byte +0x8
00032305  681F220300        push dword 0x3221f
0003230A  6A01              push byte +0x1
0003230C  E8E3E9FFFF        call dword 0x30cf4
00032311  83C410            add esp,byte +0x10
00032314  83EC0C            sub esp,byte +0xc
00032317  6A01              push byte +0x1
00032319  E89A100000        call dword 0x333b8
0003231E  83C410            add esp,byte +0x10
00032321  90                nop
00032322  C9                leave
00032323  C3                ret
00032324  55                push ebp
00032325  89E5              mov ebp,esp
00032327  83EC38            sub esp,byte +0x38
0003232A  C745F000000000    mov dword [ebp-0x10],0x0
00032331  A188640300        mov eax,[0x36488]
00032336  85C0              test eax,eax
00032338  0F8E67040000      jng dword 0x327a5
0003233E  C705AC6403000000  mov dword [dword 0x364ac],0x0
         -0000
00032348  E85B040000        call dword 0x327a8
0003234D  8845F7            mov [ebp-0x9],al
00032350  807DF7E1          cmp byte [ebp-0x9],0xe1
00032354  7560              jnz 0x323b6
00032356  C645D0E1          mov byte [ebp-0x30],0xe1
0003235A  C645D11D          mov byte [ebp-0x2f],0x1d
0003235E  C645D245          mov byte [ebp-0x2e],0x45
00032362  C645D3E1          mov byte [ebp-0x2d],0xe1
00032366  C645D49D          mov byte [ebp-0x2c],0x9d
0003236A  C645D5C5          mov byte [ebp-0x2b],0xc5
0003236E  C745E801000000    mov dword [ebp-0x18],0x1
00032375  C745EC01000000    mov dword [ebp-0x14],0x1
0003237C  EB23              jmp short 0x323a1
0003237E  E825040000        call dword 0x327a8
00032383  89C1              mov ecx,eax
00032385  8D55D0            lea edx,[ebp-0x30]
00032388  8B45EC            mov eax,[ebp-0x14]
0003238B  01D0              add eax,edx
0003238D  0FB600            movzx eax,byte [eax]
00032390  38C1              cmp cl,al
00032392  7409              jz 0x3239d
00032394  C745E800000000    mov dword [ebp-0x18],0x0
0003239B  EB0A              jmp short 0x323a7
0003239D  8345EC01          add dword [ebp-0x14],byte +0x1
000323A1  837DEC05          cmp dword [ebp-0x14],byte +0x5
000323A5  7ED7              jng 0x3237e
000323A7  837DE800          cmp dword [ebp-0x18],byte +0x0
000323AB  7473              jz 0x32420
000323AD  C745F01E010000    mov dword [ebp-0x10],0x11e
000323B4  EB6A              jmp short 0x32420
000323B6  807DF7E0          cmp byte [ebp-0x9],0xe0
000323BA  7564              jnz 0x32420
000323BC  E8E7030000        call dword 0x327a8
000323C1  8845F7            mov [ebp-0x9],al
000323C4  807DF72A          cmp byte [ebp-0x9],0x2a
000323C8  7520              jnz 0x323ea
000323CA  E8D9030000        call dword 0x327a8
000323CF  3CE0              cmp al,0xe0
000323D1  7517              jnz 0x323ea
000323D3  E8D0030000        call dword 0x327a8
000323D8  3C37              cmp al,0x37
000323DA  750E              jnz 0x323ea
000323DC  C745F01D010000    mov dword [ebp-0x10],0x11d
000323E3  C745DC01000000    mov dword [ebp-0x24],0x1
000323EA  807DF7B7          cmp byte [ebp-0x9],0xb7
000323EE  7520              jnz 0x32410
000323F0  E8B3030000        call dword 0x327a8
000323F5  3CE0              cmp al,0xe0
000323F7  7517              jnz 0x32410
000323F9  E8AA030000        call dword 0x327a8
000323FE  3CAA              cmp al,0xaa
00032400  750E              jnz 0x32410
00032402  C745F01D010000    mov dword [ebp-0x10],0x11d
00032409  C745DC00000000    mov dword [ebp-0x24],0x0
00032410  837DF000          cmp dword [ebp-0x10],byte +0x0
00032414  750A              jnz 0x32420
00032416  C705AC6403000100  mov dword [dword 0x364ac],0x1
         -0000
00032420  817DF01E010000    cmp dword [ebp-0x10],0x11e
00032427  0F8478030000      jz dword 0x327a5
0003242D  817DF01D010000    cmp dword [ebp-0x10],0x11d
00032434  0F846B030000      jz dword 0x327a5
0003243A  0FB645F7          movzx eax,byte [ebp-0x9]
0003243E  F7D0              not eax
00032440  C0E807            shr al,byte 0x7
00032443  0FB6C0            movzx eax,al
00032446  8945DC            mov [ebp-0x24],eax
00032449  0FB645F7          movzx eax,byte [ebp-0x9]
0003244D  83E07F            and eax,byte +0x7f
00032450  89C2              mov edx,eax
00032452  89D0              mov eax,edx
00032454  01C0              add eax,eax
00032456  01D0              add eax,edx
00032458  C1E002            shl eax,byte 0x2
0003245B  05E0550300        add eax,0x355e0
00032460  8945D8            mov [ebp-0x28],eax
00032463  C705D46403000000  mov dword [dword 0x364d4],0x0
         -0000
0003246D  A1B0640300        mov eax,[0x364b0]
00032472  85C0              test eax,eax
00032474  7509              jnz 0x3247f
00032476  A1B4640300        mov eax,[0x364b4]
0003247B  85C0              test eax,eax
0003247D  7407              jz 0x32486
0003247F  B801000000        mov eax,0x1
00032484  EB05              jmp short 0x3248b
00032486  B800000000        mov eax,0x0
0003248B  8945E4            mov [ebp-0x1c],eax
0003248E  A1C8640300        mov eax,[0x364c8]
00032493  85C0              test eax,eax
00032495  7421              jz 0x324b8
00032497  8B45D8            mov eax,[ebp-0x28]
0003249A  8B00              mov eax,[eax]
0003249C  83F860            cmp eax,byte +0x60
0003249F  7617              jna 0x324b8
000324A1  8B45D8            mov eax,[ebp-0x28]
000324A4  8B00              mov eax,[eax]
000324A6  83F87A            cmp eax,byte +0x7a
000324A9  770D              ja 0x324b8
000324AB  837DE400          cmp dword [ebp-0x1c],byte +0x0
000324AF  0F94C0            setz al
000324B2  0FB6C0            movzx eax,al
000324B5  8945E4            mov [ebp-0x1c],eax
000324B8  837DE400          cmp dword [ebp-0x1c],byte +0x0
000324BC  740A              jz 0x324c8
000324BE  C705D46403000100  mov dword [dword 0x364d4],0x1
         -0000
000324C8  A1AC640300        mov eax,[0x364ac]
000324CD  85C0              test eax,eax
000324CF  740A              jz 0x324db
000324D1  C705D46403000200  mov dword [dword 0x364d4],0x2
         -0000
000324DB  A1D4640300        mov eax,[0x364d4]
000324E0  8D148500000000    lea edx,[eax*4+0x0]
000324E7  8B45D8            mov eax,[ebp-0x28]
000324EA  01D0              add eax,edx
000324EC  8B00              mov eax,[eax]
000324EE  8945F0            mov [ebp-0x10],eax
000324F1  8B45F0            mov eax,[ebp-0x10]
000324F4  2D08010000        sub eax,0x108
000324F9  83F808            cmp eax,byte +0x8
000324FC  0F87AB000000      ja dword 0x325ad
00032502  8B0485E43B0300    mov eax,[eax*4+0x33be4]
00032509  FFE0              jmp eax
0003250B  8B45DC            mov eax,[ebp-0x24]
0003250E  A3B0640300        mov [0x364b0],eax
00032513  E99F000000        jmp dword 0x325b7
00032518  8B45DC            mov eax,[ebp-0x24]
0003251B  A3B4640300        mov [0x364b4],eax
00032520  E992000000        jmp dword 0x325b7
00032525  8B45DC            mov eax,[ebp-0x24]
00032528  A3C0640300        mov [0x364c0],eax
0003252D  E985000000        jmp dword 0x325b7
00032532  8B45DC            mov eax,[ebp-0x24]
00032535  A3C4640300        mov [0x364c4],eax
0003253A  EB7B              jmp short 0x325b7
0003253C  8B45DC            mov eax,[ebp-0x24]
0003253F  A3B8640300        mov [0x364b8],eax
00032544  EB71              jmp short 0x325b7
00032546  8B45DC            mov eax,[ebp-0x24]
00032549  A3B8640300        mov [0x364b8],eax
0003254E  EB67              jmp short 0x325b7
00032550  837DDC00          cmp dword [ebp-0x24],byte +0x0
00032554  745A              jz 0x325b0
00032556  A1C8640300        mov eax,[0x364c8]
0003255B  85C0              test eax,eax
0003255D  0F94C0            setz al
00032560  0FB6C0            movzx eax,al
00032563  A3C8640300        mov [0x364c8],eax
00032568  E8D9020000        call dword 0x32846
0003256D  EB41              jmp short 0x325b0
0003256F  837DDC00          cmp dword [ebp-0x24],byte +0x0
00032573  743E              jz 0x325b3
00032575  A1CC640300        mov eax,[0x364cc]
0003257A  85C0              test eax,eax
0003257C  0F94C0            setz al
0003257F  0FB6C0            movzx eax,al
00032582  A3CC640300        mov [0x364cc],eax
00032587  E8BA020000        call dword 0x32846
0003258C  EB25              jmp short 0x325b3
0003258E  837DDC00          cmp dword [ebp-0x24],byte +0x0
00032592  7422              jz 0x325b6
00032594  A1D0640300        mov eax,[0x364d0]
00032599  85C0              test eax,eax
0003259B  0F94C0            setz al
0003259E  0FB6C0            movzx eax,al
000325A1  A3D0640300        mov [0x364d0],eax
000325A6  E89B020000        call dword 0x32846
000325AB  EB09              jmp short 0x325b6
000325AD  90                nop
000325AE  EB07              jmp short 0x325b7
000325B0  90                nop
000325B1  EB04              jmp short 0x325b7
000325B3  90                nop
000325B4  EB01              jmp short 0x325b7
000325B6  90                nop
000325B7  837DDC00          cmp dword [ebp-0x24],byte +0x0
000325BB  0F84E4010000      jz dword 0x327a5
000325C1  C745E000000000    mov dword [ebp-0x20],0x0
000325C8  817DF02B010000    cmp dword [ebp-0x10],0x12b
000325CF  0F861A010000      jna dword 0x326ef
000325D5  817DF03B010000    cmp dword [ebp-0x10],0x13b
000325DC  0F870D010000      ja dword 0x326ef
000325E2  C745E001000000    mov dword [ebp-0x20],0x1
000325E9  8B45F0            mov eax,[ebp-0x10]
000325EC  2D2C010000        sub eax,0x12c
000325F1  83F804            cmp eax,byte +0x4
000325F4  7745              ja 0x3263b
000325F6  8B0485083C0300    mov eax,[eax*4+0x33c08]
000325FD  FFE0              jmp eax
000325FF  C745F02F000000    mov dword [ebp-0x10],0x2f
00032606  E9E4000000        jmp dword 0x326ef
0003260B  C745F02A000000    mov dword [ebp-0x10],0x2a
00032612  E9D8000000        jmp dword 0x326ef
00032617  C745F02D000000    mov dword [ebp-0x10],0x2d
0003261E  E9CC000000        jmp dword 0x326ef
00032623  C745F02B000000    mov dword [ebp-0x10],0x2b
0003262A  E9C0000000        jmp dword 0x326ef
0003262F  C745F003010000    mov dword [ebp-0x10],0x103
00032636  E9B4000000        jmp dword 0x326ef
0003263B  A1CC640300        mov eax,[0x364cc]
00032640  85C0              test eax,eax
00032642  741E              jz 0x32662
00032644  817DF031010000    cmp dword [ebp-0x10],0x131
0003264B  7615              jna 0x32662
0003264D  817DF03B010000    cmp dword [ebp-0x10],0x13b
00032654  770C              ja 0x32662
00032656  816DF002010000    sub dword [ebp-0x10],0x102
0003265D  E98C000000        jmp dword 0x326ee
00032662  A1CC640300        mov eax,[0x364cc]
00032667  85C0              test eax,eax
00032669  7412              jz 0x3267d
0003266B  817DF031010000    cmp dword [ebp-0x10],0x131
00032672  7509              jnz 0x3267d
00032674  C745F02E000000    mov dword [ebp-0x10],0x2e
0003267B  EB71              jmp short 0x326ee
0003267D  8B45F0            mov eax,[ebp-0x10]
00032680  2D31010000        sub eax,0x131
00032685  83F80A            cmp eax,byte +0xa
00032688  7763              ja 0x326ed
0003268A  8B04851C3C0300    mov eax,[eax*4+0x33c1c]
00032691  FFE0              jmp eax
00032693  C745F021010000    mov dword [ebp-0x10],0x121
0003269A  EB52              jmp short 0x326ee
0003269C  C745F022010000    mov dword [ebp-0x10],0x122
000326A3  EB49              jmp short 0x326ee
000326A5  C745F023010000    mov dword [ebp-0x10],0x123
000326AC  EB40              jmp short 0x326ee
000326AE  C745F024010000    mov dword [ebp-0x10],0x124
000326B5  EB37              jmp short 0x326ee
000326B7  C745F01F010000    mov dword [ebp-0x10],0x11f
000326BE  EB2E              jmp short 0x326ee
000326C0  C745F025010000    mov dword [ebp-0x10],0x125
000326C7  EB25              jmp short 0x326ee
000326C9  C745F026010000    mov dword [ebp-0x10],0x126
000326D0  EB1C              jmp short 0x326ee
000326D2  C745F027010000    mov dword [ebp-0x10],0x127
000326D9  EB13              jmp short 0x326ee
000326DB  C745F028010000    mov dword [ebp-0x10],0x128
000326E2  EB0A              jmp short 0x326ee
000326E4  C745F020010000    mov dword [ebp-0x10],0x120
000326EB  EB01              jmp short 0x326ee
000326ED  90                nop
000326EE  90                nop
000326EF  A1B0640300        mov eax,[0x364b0]
000326F4  85C0              test eax,eax
000326F6  7407              jz 0x326ff
000326F8  B800020000        mov eax,0x200
000326FD  EB05              jmp short 0x32704
000326FF  B800000000        mov eax,0x0
00032704  0945F0            or [ebp-0x10],eax
00032707  A1B4640300        mov eax,[0x364b4]
0003270C  85C0              test eax,eax
0003270E  7407              jz 0x32717
00032710  B800040000        mov eax,0x400
00032715  EB05              jmp short 0x3271c
00032717  B800000000        mov eax,0x0
0003271C  0945F0            or [ebp-0x10],eax
0003271F  A1C0640300        mov eax,[0x364c0]
00032724  85C0              test eax,eax
00032726  7407              jz 0x3272f
00032728  B800080000        mov eax,0x800
0003272D  EB05              jmp short 0x32734
0003272F  B800000000        mov eax,0x0
00032734  0945F0            or [ebp-0x10],eax
00032737  A1C4640300        mov eax,[0x364c4]
0003273C  85C0              test eax,eax
0003273E  7407              jz 0x32747
00032740  B800100000        mov eax,0x1000
00032745  EB05              jmp short 0x3274c
00032747  B800000000        mov eax,0x0
0003274C  0945F0            or [ebp-0x10],eax
0003274F  A1B8640300        mov eax,[0x364b8]
00032754  85C0              test eax,eax
00032756  7407              jz 0x3275f
00032758  B800200000        mov eax,0x2000
0003275D  EB05              jmp short 0x32764
0003275F  B800000000        mov eax,0x0
00032764  0945F0            or [ebp-0x10],eax
00032767  A1BC640300        mov eax,[0x364bc]
0003276C  85C0              test eax,eax
0003276E  7407              jz 0x32777
00032770  B800400000        mov eax,0x4000
00032775  EB05              jmp short 0x3277c
00032777  B800000000        mov eax,0x0
0003277C  0945F0            or [ebp-0x10],eax
0003277F  837DE000          cmp dword [ebp-0x20],byte +0x0
00032783  7407              jz 0x3278c
00032785  B800800000        mov eax,0x8000
0003278A  EB05              jmp short 0x32791
0003278C  B800000000        mov eax,0x0
00032791  0945F0            or [ebp-0x10],eax
00032794  83EC08            sub esp,byte +0x8
00032797  FF75F0            push dword [ebp-0x10]
0003279A  FF7508            push dword [ebp+0x8]
0003279D  E8F4010000        call dword 0x32996
000327A2  83C410            add esp,byte +0x10
000327A5  90                nop
000327A6  C9                leave
000327A7  C3                ret
000327A8  55                push ebp
000327A9  89E5              mov ebp,esp
000327AB  83EC18            sub esp,byte +0x18
000327AE  90                nop
000327AF  A188640300        mov eax,[0x36488]
000327B4  85C0              test eax,eax
000327B6  7EF7              jng 0x327af
000327B8  E81A0C0000        call dword 0x333d7
000327BD  A184640300        mov eax,[0x36484]
000327C2  0FB600            movzx eax,byte [eax]
000327C5  8845F7            mov [ebp-0x9],al
000327C8  A184640300        mov eax,[0x36484]
000327CD  83C001            add eax,byte +0x1
000327D0  A384640300        mov [0x36484],eax
000327D5  A184640300        mov eax,[0x36484]
000327DA  BAAC640300        mov edx,0x364ac
000327DF  39D0              cmp eax,edx
000327E1  750A              jnz 0x327ed
000327E3  C705846403008C64  mov dword [dword 0x36484],0x3648c
         -0300
000327ED  A188640300        mov eax,[0x36488]
000327F2  83E801            sub eax,byte +0x1
000327F5  A388640300        mov [0x36488],eax
000327FA  E8DA0B0000        call dword 0x333d9
000327FF  0FB645F7          movzx eax,byte [ebp-0x9]
00032803  C9                leave
00032804  C3                ret
00032805  55                push ebp
00032806  89E5              mov ebp,esp
00032808  83EC18            sub esp,byte +0x18
0003280B  83EC0C            sub esp,byte +0xc
0003280E  6A64              push byte +0x64
00032810  E8640B0000        call dword 0x33379
00032815  83C410            add esp,byte +0x10
00032818  8845F7            mov [ebp-0x9],al
0003281B  0FB645F7          movzx eax,byte [ebp-0x9]
0003281F  83E002            and eax,byte +0x2
00032822  85C0              test eax,eax
00032824  75E5              jnz 0x3280b
00032826  90                nop
00032827  C9                leave
00032828  C3                ret
00032829  55                push ebp
0003282A  89E5              mov ebp,esp
0003282C  83EC18            sub esp,byte +0x18
0003282F  83EC0C            sub esp,byte +0xc
00032832  6A60              push byte +0x60
00032834  E8400B0000        call dword 0x33379
00032839  83C410            add esp,byte +0x10
0003283C  8845F7            mov [ebp-0x9],al
0003283F  C645F700          mov byte [ebp-0x9],0x0
00032843  90                nop
00032844  C9                leave
00032845  C3                ret
00032846  55                push ebp
00032847  89E5              mov ebp,esp
00032849  83EC18            sub esp,byte +0x18
0003284C  A1C8640300        mov eax,[0x364c8]
00032851  C1E002            shl eax,byte 0x2
00032854  89C2              mov edx,eax
00032856  A1CC640300        mov eax,[0x364cc]
0003285B  01C0              add eax,eax
0003285D  09C2              or edx,eax
0003285F  A1D0640300        mov eax,[0x364d0]
00032864  09D0              or eax,edx
00032866  8845F7            mov [ebp-0x9],al
00032869  E897FFFFFF        call dword 0x32805
0003286E  83EC08            sub esp,byte +0x8
00032871  68ED000000        push dword 0xed
00032876  6A60              push byte +0x60
00032878  E8F00A0000        call dword 0x3336d
0003287D  83C410            add esp,byte +0x10
00032880  E8A4FFFFFF        call dword 0x32829
00032885  E87BFFFFFF        call dword 0x32805
0003288A  0FB645F7          movzx eax,byte [ebp-0x9]
0003288E  83EC08            sub esp,byte +0x8
00032891  50                push eax
00032892  6A60              push byte +0x60
00032894  E8D40A0000        call dword 0x3336d
00032899  83C410            add esp,byte +0x10
0003289C  E888FFFFFF        call dword 0x32829
000328A1  90                nop
000328A2  C9                leave
000328A3  C3                ret
000328A4  55                push ebp
000328A5  89E5              mov ebp,esp
000328A7  83EC18            sub esp,byte +0x18
000328AA  E8D0F9FFFF        call dword 0x3227f
000328AF  C745F420690500    mov dword [ebp-0xc],0x56920
000328B6  EB15              jmp short 0x328cd
000328B8  83EC0C            sub esp,byte +0xc
000328BB  FF75F4            push dword [ebp-0xc]
000328BE  E859000000        call dword 0x3291c
000328C3  83C410            add esp,byte +0x10
000328C6  8145F414040000    add dword [ebp-0xc],0x414
000328CD  B870790500        mov eax,0x57970
000328D2  3945F4            cmp [ebp-0xc],eax
000328D5  72E1              jc 0x328b8
000328D7  83EC0C            sub esp,byte +0xc
000328DA  6A00              push byte +0x0
000328DC  E835080000        call dword 0x33116
000328E1  83C410            add esp,byte +0x10
000328E4  C745F420690500    mov dword [ebp-0xc],0x56920
000328EB  EB23              jmp short 0x32910
000328ED  83EC0C            sub esp,byte +0xc
000328F0  FF75F4            push dword [ebp-0xc]
000328F3  E82A020000        call dword 0x32b22
000328F8  83C410            add esp,byte +0x10
000328FB  83EC0C            sub esp,byte +0xc
000328FE  FF75F4            push dword [ebp-0xc]
00032901  E84C020000        call dword 0x32b52
00032906  83C410            add esp,byte +0x10
00032909  8145F414040000    add dword [ebp-0xc],0x414
00032910  B870790500        mov eax,0x57970
00032915  3945F4            cmp [ebp-0xc],eax
00032918  72D3              jc 0x328ed
0003291A  EBC8              jmp short 0x328e4
0003291C  55                push ebp
0003291D  89E5              mov ebp,esp
0003291F  83EC18            sub esp,byte +0x18
00032922  8B4508            mov eax,[ebp+0x8]
00032925  BA20690500        mov edx,0x56920
0003292A  29D0              sub eax,edx
0003292C  C1F802            sar eax,byte 0x2
0003292F  69C0CDA34525      imul eax,eax,dword 0x2545a3cd
00032935  8945F4            mov [ebp-0xc],eax
00032938  837DF403          cmp dword [ebp-0xc],byte +0x3
0003293C  750F              jnz 0x3294d
0003293E  8B4508            mov eax,[ebp+0x8]
00032941  C7800C0400000100  mov dword [eax+0x40c],0x1
         -0000
0003294B  EB0D              jmp short 0x3295a
0003294D  8B4508            mov eax,[ebp+0x8]
00032950  C7800C0400000000  mov dword [eax+0x40c],0x0
         -0000
0003295A  8B4508            mov eax,[ebp+0x8]
0003295D  C780080400000000  mov dword [eax+0x408],0x0
         -0000
00032967  8B5508            mov edx,[ebp+0x8]
0003296A  8B4508            mov eax,[ebp+0x8]
0003296D  899004040000      mov [eax+0x404],edx
00032973  8B4508            mov eax,[ebp+0x8]
00032976  8B9004040000      mov edx,[eax+0x404]
0003297C  8B4508            mov eax,[ebp+0x8]
0003297F  899000040000      mov [eax+0x400],edx
00032985  83EC0C            sub esp,byte +0xc
00032988  FF7508            push dword [ebp+0x8]
0003298B  E8C2020000        call dword 0x32c52
00032990  83C410            add esp,byte +0x10
00032993  90                nop
00032994  C9                leave
00032995  C3                ret
00032996  55                push ebp
00032997  89E5              mov ebp,esp
00032999  83EC18            sub esp,byte +0x18
0003299C  C645F200          mov byte [ebp-0xe],0x0
000329A0  C645F300          mov byte [ebp-0xd],0x0
000329A4  8B450C            mov eax,[ebp+0xc]
000329A7  2500010000        and eax,0x100
000329AC  85C0              test eax,eax
000329AE  7516              jnz 0x329c6
000329B0  83EC08            sub esp,byte +0x8
000329B3  FF750C            push dword [ebp+0xc]
000329B6  FF7508            push dword [ebp+0x8]
000329B9  E8F4000000        call dword 0x32ab2
000329BE  83C410            add esp,byte +0x10
000329C1  E9E9000000        jmp dword 0x32aaf
000329C6  8B450C            mov eax,[ebp+0xc]
000329C9  25FF010000        and eax,0x1ff
000329CE  8945F4            mov [ebp-0xc],eax
000329D1  8B45F4            mov eax,[ebp-0xc]
000329D4  2D03010000        sub eax,0x103
000329D9  83F823            cmp eax,byte +0x23
000329DC  0F87C3000000      ja dword 0x32aa5
000329E2  8B0485483C0300    mov eax,[eax*4+0x33c48]
000329E9  FFE0              jmp eax
000329EB  83EC08            sub esp,byte +0x8
000329EE  6A0A              push byte +0xa
000329F0  FF7508            push dword [ebp+0x8]
000329F3  E8BA000000        call dword 0x32ab2
000329F8  83C410            add esp,byte +0x10
000329FB  E9AF000000        jmp dword 0x32aaf
00032A00  83EC08            sub esp,byte +0x8
00032A03  6A08              push byte +0x8
00032A05  FF7508            push dword [ebp+0x8]
00032A08  E8A5000000        call dword 0x32ab2
00032A0D  83C410            add esp,byte +0x10
00032A10  E99A000000        jmp dword 0x32aaf
00032A15  8B450C            mov eax,[ebp+0xc]
00032A18  2500020000        and eax,0x200
00032A1D  85C0              test eax,eax
00032A1F  750C              jnz 0x32a2d
00032A21  8B450C            mov eax,[ebp+0xc]
00032A24  2500040000        and eax,0x400
00032A29  85C0              test eax,eax
00032A2B  747B              jz 0x32aa8
00032A2D  8B4508            mov eax,[ebp+0x8]
00032A30  8B8010040000      mov eax,[eax+0x410]
00032A36  83EC08            sub esp,byte +0x8
00032A39  6AFF              push byte -0x1
00032A3B  50                push eax
00032A3C  E80B070000        call dword 0x3314c
00032A41  83C410            add esp,byte +0x10
00032A44  EB62              jmp short 0x32aa8
00032A46  8B450C            mov eax,[ebp+0xc]
00032A49  2500020000        and eax,0x200
00032A4E  85C0              test eax,eax
00032A50  750C              jnz 0x32a5e
00032A52  8B450C            mov eax,[ebp+0xc]
00032A55  2500040000        and eax,0x400
00032A5A  85C0              test eax,eax
00032A5C  744D              jz 0x32aab
00032A5E  8B4508            mov eax,[ebp+0x8]
00032A61  8B8010040000      mov eax,[eax+0x410]
00032A67  83EC08            sub esp,byte +0x8
00032A6A  6A01              push byte +0x1
00032A6C  50                push eax
00032A6D  E8DA060000        call dword 0x3314c
00032A72  83C410            add esp,byte +0x10
00032A75  EB34              jmp short 0x32aab
00032A77  8B450C            mov eax,[ebp+0xc]
00032A7A  2500200000        and eax,0x2000
00032A7F  85C0              test eax,eax
00032A81  750C              jnz 0x32a8f
00032A83  8B450C            mov eax,[ebp+0xc]
00032A86  2500400000        and eax,0x4000
00032A8B  85C0              test eax,eax
00032A8D  741F              jz 0x32aae
00032A8F  8B45F4            mov eax,[ebp-0xc]
00032A92  2D11010000        sub eax,0x111
00032A97  83EC0C            sub esp,byte +0xc
00032A9A  50                push eax
00032A9B  E876060000        call dword 0x33116
00032AA0  83C410            add esp,byte +0x10
00032AA3  EB09              jmp short 0x32aae
00032AA5  90                nop
00032AA6  EB07              jmp short 0x32aaf
00032AA8  90                nop
00032AA9  EB04              jmp short 0x32aaf
00032AAB  90                nop
00032AAC  EB01              jmp short 0x32aaf
00032AAE  90                nop
00032AAF  90                nop
00032AB0  C9                leave
00032AB1  C3                ret
00032AB2  55                push ebp
00032AB3  89E5              mov ebp,esp
00032AB5  8B4508            mov eax,[ebp+0x8]
00032AB8  8B8008040000      mov eax,[eax+0x408]
00032ABE  3DFF000000        cmp eax,0xff
00032AC3  7F5A              jg 0x32b1f
00032AC5  8B4508            mov eax,[ebp+0x8]
00032AC8  8B8000040000      mov eax,[eax+0x400]
00032ACE  8B550C            mov edx,[ebp+0xc]
00032AD1  8910              mov [eax],edx
00032AD3  8B4508            mov eax,[ebp+0x8]
00032AD6  8B8000040000      mov eax,[eax+0x400]
00032ADC  8D5004            lea edx,[eax+0x4]
00032ADF  8B4508            mov eax,[ebp+0x8]
00032AE2  899000040000      mov [eax+0x400],edx
00032AE8  8B4508            mov eax,[ebp+0x8]
00032AEB  8B8000040000      mov eax,[eax+0x400]
00032AF1  8B5508            mov edx,[ebp+0x8]
00032AF4  81C200040000      add edx,0x400
00032AFA  39D0              cmp eax,edx
00032AFC  750C              jnz 0x32b0a
00032AFE  8B5508            mov edx,[ebp+0x8]
00032B01  8B4508            mov eax,[ebp+0x8]
00032B04  899000040000      mov [eax+0x400],edx
00032B0A  8B4508            mov eax,[ebp+0x8]
00032B0D  8B8008040000      mov eax,[eax+0x408]
00032B13  8D5001            lea edx,[eax+0x1]
00032B16  8B4508            mov eax,[ebp+0x8]
00032B19  899008040000      mov [eax+0x408],edx
00032B1F  90                nop
00032B20  5D                pop ebp
00032B21  C3                ret
00032B22  55                push ebp
00032B23  89E5              mov ebp,esp
00032B25  83EC08            sub esp,byte +0x8
00032B28  8B4508            mov eax,[ebp+0x8]
00032B2B  8B8010040000      mov eax,[eax+0x410]
00032B31  83EC0C            sub esp,byte +0xc
00032B34  50                push eax
00032B35  E859020000        call dword 0x32d93
00032B3A  83C410            add esp,byte +0x10
00032B3D  85C0              test eax,eax
00032B3F  740E              jz 0x32b4f
00032B41  83EC0C            sub esp,byte +0xc
00032B44  FF7508            push dword [ebp+0x8]
00032B47  E8D8F7FFFF        call dword 0x32324
00032B4C  83C410            add esp,byte +0x10
00032B4F  90                nop
00032B50  C9                leave
00032B51  C3                ret
00032B52  55                push ebp
00032B53  89E5              mov ebp,esp
00032B55  83EC18            sub esp,byte +0x18
00032B58  8B4508            mov eax,[ebp+0x8]
00032B5B  8B8008040000      mov eax,[eax+0x408]
00032B61  85C0              test eax,eax
00032B63  7474              jz 0x32bd9
00032B65  8B4508            mov eax,[ebp+0x8]
00032B68  8B8004040000      mov eax,[eax+0x404]
00032B6E  8B00              mov eax,[eax]
00032B70  8845F7            mov [ebp-0x9],al
00032B73  8B4508            mov eax,[ebp+0x8]
00032B76  8B8004040000      mov eax,[eax+0x404]
00032B7C  8D5004            lea edx,[eax+0x4]
00032B7F  8B4508            mov eax,[ebp+0x8]
00032B82  899004040000      mov [eax+0x404],edx
00032B88  8B4508            mov eax,[ebp+0x8]
00032B8B  8B8004040000      mov eax,[eax+0x404]
00032B91  8B5508            mov edx,[ebp+0x8]
00032B94  81C200040000      add edx,0x400
00032B9A  39D0              cmp eax,edx
00032B9C  750C              jnz 0x32baa
00032B9E  8B5508            mov edx,[ebp+0x8]
00032BA1  8B4508            mov eax,[ebp+0x8]
00032BA4  899004040000      mov [eax+0x404],edx
00032BAA  8B4508            mov eax,[ebp+0x8]
00032BAD  8B8008040000      mov eax,[eax+0x408]
00032BB3  8D50FF            lea edx,[eax-0x1]
00032BB6  8B4508            mov eax,[ebp+0x8]
00032BB9  899008040000      mov [eax+0x408],edx
00032BBF  0FBE55F7          movsx edx,byte [ebp-0x9]
00032BC3  8B4508            mov eax,[ebp+0x8]
00032BC6  8B8010040000      mov eax,[eax+0x410]
00032BCC  83EC08            sub esp,byte +0x8
00032BCF  52                push edx
00032BD0  50                push eax
00032BD1  E8D8010000        call dword 0x32dae
00032BD6  83C410            add esp,byte +0x10
00032BD9  90                nop
00032BDA  C9                leave
00032BDB  C3                ret
00032BDC  55                push ebp
00032BDD  89E5              mov ebp,esp
00032BDF  83EC18            sub esp,byte +0x18
00032BE2  8B450C            mov eax,[ebp+0xc]
00032BE5  8945F4            mov [ebp-0xc],eax
00032BE8  8B4510            mov eax,[ebp+0x10]
00032BEB  8945F0            mov [ebp-0x10],eax
00032BEE  EB29              jmp short 0x32c19
00032BF0  8B45F4            mov eax,[ebp-0xc]
00032BF3  8D5001            lea edx,[eax+0x1]
00032BF6  8955F4            mov [ebp-0xc],edx
00032BF9  0FB600            movzx eax,byte [eax]
00032BFC  0FBED0            movsx edx,al
00032BFF  8B4508            mov eax,[ebp+0x8]
00032C02  8B8010040000      mov eax,[eax+0x410]
00032C08  83EC08            sub esp,byte +0x8
00032C0B  52                push edx
00032C0C  50                push eax
00032C0D  E89C010000        call dword 0x32dae
00032C12  83C410            add esp,byte +0x10
00032C15  836DF001          sub dword [ebp-0x10],byte +0x1
00032C19  837DF000          cmp dword [ebp-0x10],byte +0x0
00032C1D  75D1              jnz 0x32bf0
00032C1F  90                nop
00032C20  C9                leave
00032C21  C3                ret
00032C22  55                push ebp
00032C23  89E5              mov ebp,esp
00032C25  83EC08            sub esp,byte +0x8
00032C28  8B4510            mov eax,[ebp+0x10]
00032C2B  8B407C            mov eax,[eax+0x7c]
00032C2E  69C014040000      imul eax,eax,dword 0x414
00032C34  0520690500        add eax,0x56920
00032C39  83EC04            sub esp,byte +0x4
00032C3C  FF750C            push dword [ebp+0xc]
00032C3F  FF7508            push dword [ebp+0x8]
00032C42  50                push eax
00032C43  E894FFFFFF        call dword 0x32bdc
00032C48  83C410            add esp,byte +0x10
00032C4B  B800000000        mov eax,0x0
00032C50  C9                leave
00032C51  C3                ret
00032C52  55                push ebp
00032C53  89E5              mov ebp,esp
00032C55  83EC18            sub esp,byte +0x18
00032C58  8B4508            mov eax,[ebp+0x8]
00032C5B  BA20690500        mov edx,0x56920
00032C60  29D0              sub eax,edx
00032C62  C1F802            sar eax,byte 0x2
00032C65  69C0CDA34525      imul eax,eax,dword 0x2545a3cd
00032C6B  8945F4            mov [ebp-0xc],eax
00032C6E  8B45F4            mov eax,[ebp-0xc]
00032C71  C1E004            shl eax,byte 0x4
00032C74  8D90E0820500      lea edx,[eax+0x582e0]
00032C7A  8B4508            mov eax,[ebp+0x8]
00032C7D  899010040000      mov [eax+0x410],edx
00032C83  C745F000400000    mov dword [ebp-0x10],0x4000
00032C8A  8B45F0            mov eax,[ebp-0x10]
00032C8D  8D5003            lea edx,[eax+0x3]
00032C90  85C0              test eax,eax
00032C92  0F48C2            cmovs eax,edx
00032C95  C1F802            sar eax,byte 0x2
00032C98  8945EC            mov [ebp-0x14],eax
00032C9B  8B4508            mov eax,[ebp+0x8]
00032C9E  8B8010040000      mov eax,[eax+0x410]
00032CA4  8B55F4            mov edx,[ebp-0xc]
00032CA7  0FAF55EC          imul edx,[ebp-0x14]
00032CAB  895004            mov [eax+0x4],edx
00032CAE  8B4508            mov eax,[ebp+0x8]
00032CB1  8B8010040000      mov eax,[eax+0x410]
00032CB7  8B55EC            mov edx,[ebp-0x14]
00032CBA  895008            mov [eax+0x8],edx
00032CBD  8B4508            mov eax,[ebp+0x8]
00032CC0  8B8010040000      mov eax,[eax+0x410]
00032CC6  8B5508            mov edx,[ebp+0x8]
00032CC9  8B9210040000      mov edx,[edx+0x410]
00032CCF  8B5204            mov edx,[edx+0x4]
00032CD2  8910              mov [eax],edx
00032CD4  8B4508            mov eax,[ebp+0x8]
00032CD7  8B8010040000      mov eax,[eax+0x410]
00032CDD  8B5508            mov edx,[ebp+0x8]
00032CE0  8B9210040000      mov edx,[edx+0x410]
00032CE6  8B5204            mov edx,[edx+0x4]
00032CE9  89500C            mov [eax+0xc],edx
00032CEC  8B4508            mov eax,[ebp+0x8]
00032CEF  8B800C040000      mov eax,[eax+0x40c]
00032CF5  85C0              test eax,eax
00032CF7  741D              jz 0x32d16
00032CF9  8B4508            mov eax,[ebp+0x8]
00032CFC  8B8010040000      mov eax,[eax+0x410]
00032D02  8B5508            mov edx,[ebp+0x8]
00032D05  8B9210040000      mov edx,[edx+0x410]
00032D0B  8B12              mov edx,[edx]
00032D0D  81C2CE070000      add edx,0x7ce
00032D13  89500C            mov [eax+0xc],edx
00032D16  837DF400          cmp dword [ebp-0xc],byte +0x0
00032D1A  7526              jnz 0x32d42
00032D1C  8B4508            mov eax,[ebp+0x8]
00032D1F  8B9010040000      mov edx,[eax+0x410]
00032D25  A1EC790500        mov eax,[0x579ec]
00032D2A  89C1              mov ecx,eax
00032D2C  C1E91F            shr ecx,byte 0x1f
00032D2F  01C8              add eax,ecx
00032D31  D1F8              sar eax,1
00032D33  89420C            mov [edx+0xc],eax
00032D36  C705EC7905000000  mov dword [dword 0x579ec],0x0
         -0000
00032D40  EB36              jmp short 0x32d78
00032D42  8B45F4            mov eax,[ebp-0xc]
00032D45  83C030            add eax,byte +0x30
00032D48  0FBED0            movsx edx,al
00032D4B  8B4508            mov eax,[ebp+0x8]
00032D4E  8B8010040000      mov eax,[eax+0x410]
00032D54  83EC08            sub esp,byte +0x8
00032D57  52                push edx
00032D58  50                push eax
00032D59  E850000000        call dword 0x32dae
00032D5E  83C410            add esp,byte +0x10
00032D61  8B4508            mov eax,[ebp+0x8]
00032D64  8B8010040000      mov eax,[eax+0x410]
00032D6A  83EC08            sub esp,byte +0x8
00032D6D  6A23              push byte +0x23
00032D6F  50                push eax
00032D70  E839000000        call dword 0x32dae
00032D75  83C410            add esp,byte +0x10
00032D78  8B4508            mov eax,[ebp+0x8]
00032D7B  8B8010040000      mov eax,[eax+0x410]
00032D81  8B400C            mov eax,[eax+0xc]
00032D84  83EC0C            sub esp,byte +0xc
00032D87  50                push eax
00032D88  E8B9020000        call dword 0x33046
00032D8D  83C410            add esp,byte +0x10
00032D90  90                nop
00032D91  C9                leave
00032D92  C3                ret
00032D93  55                push ebp
00032D94  89E5              mov ebp,esp
00032D96  A1E8790500        mov eax,[0x579e8]
00032D9B  C1E004            shl eax,byte 0x4
00032D9E  05E0820500        add eax,0x582e0
00032DA3  3B4508            cmp eax,[ebp+0x8]
00032DA6  0F94C0            setz al
00032DA9  0FB6C0            movzx eax,al
00032DAC  5D                pop ebp
00032DAD  C3                ret
00032DAE  55                push ebp
00032DAF  89E5              mov ebp,esp
00032DB1  83EC28            sub esp,byte +0x28
00032DB4  8B450C            mov eax,[ebp+0xc]
00032DB7  8845E4            mov [ebp-0x1c],al
00032DBA  8B4508            mov eax,[ebp+0x8]
00032DBD  8B400C            mov eax,[eax+0xc]
00032DC0  0500C00500        add eax,0x5c000
00032DC5  01C0              add eax,eax
00032DC7  8945F4            mov [ebp-0xc],eax
00032DCA  8B4508            mov eax,[ebp+0x8]
00032DCD  BAE0820500        mov edx,0x582e0
00032DD2  29D0              sub eax,edx
00032DD4  C1F804            sar eax,byte 0x4
00032DD7  8945F0            mov [ebp-0x10],eax
00032DDA  837DF003          cmp dword [ebp-0x10],byte +0x3
00032DDE  0F8504010000      jnz dword 0x32ee8
00032DE4  0FBE45E4          movsx eax,byte [ebp-0x1c]
00032DE8  83F808            cmp eax,byte +0x8
00032DEB  7457              jz 0x32e44
00032DED  83F80A            cmp eax,byte +0xa
00032DF0  0F8589000000      jnz dword 0x32e7f
00032DF6  8B4508            mov eax,[ebp+0x8]
00032DF9  8B500C            mov edx,[eax+0xc]
00032DFC  8B4508            mov eax,[ebp+0x8]
00032DFF  8B4004            mov eax,[eax+0x4]
00032E02  83C050            add eax,byte +0x50
00032E05  39C2              cmp edx,eax
00032E07  0F82AE000000      jc dword 0x32ebb
00032E0D  8B4508            mov eax,[ebp+0x8]
00032E10  8B4804            mov ecx,[eax+0x4]
00032E13  8B4508            mov eax,[ebp+0x8]
00032E16  8B500C            mov edx,[eax+0xc]
00032E19  8B4508            mov eax,[ebp+0x8]
00032E1C  8B4004            mov eax,[eax+0x4]
00032E1F  29C2              sub edx,eax
00032E21  89D0              mov eax,edx
00032E23  BACDCCCCCC        mov edx,0xcccccccd
00032E28  F7E2              mul edx
00032E2A  C1EA06            shr edx,byte 0x6
00032E2D  89D0              mov eax,edx
00032E2F  C1E002            shl eax,byte 0x2
00032E32  01D0              add eax,edx
00032E34  C1E004            shl eax,byte 0x4
00032E37  01C8              add eax,ecx
00032E39  8D50FF            lea edx,[eax-0x1]
00032E3C  8B4508            mov eax,[ebp+0x8]
00032E3F  89500C            mov [eax+0xc],edx
00032E42  EB77              jmp short 0x32ebb
00032E44  8B4508            mov eax,[ebp+0x8]
00032E47  8B500C            mov edx,[eax+0xc]
00032E4A  8B4508            mov eax,[ebp+0x8]
00032E4D  8B4804            mov ecx,[eax+0x4]
00032E50  8B4508            mov eax,[ebp+0x8]
00032E53  8B4008            mov eax,[eax+0x8]
00032E56  01C8              add eax,ecx
00032E58  39C2              cmp edx,eax
00032E5A  7362              jnc 0x32ebe
00032E5C  8B4508            mov eax,[ebp+0x8]
00032E5F  8B400C            mov eax,[eax+0xc]
00032E62  8D5001            lea edx,[eax+0x1]
00032E65  8B4508            mov eax,[ebp+0x8]
00032E68  89500C            mov [eax+0xc],edx
00032E6B  8B45F4            mov eax,[ebp-0xc]
00032E6E  83C002            add eax,byte +0x2
00032E71  C60020            mov byte [eax],0x20
00032E74  8B45F4            mov eax,[ebp-0xc]
00032E77  83C003            add eax,byte +0x3
00032E7A  C60007            mov byte [eax],0x7
00032E7D  EB3F              jmp short 0x32ebe
00032E7F  8B4508            mov eax,[ebp+0x8]
00032E82  8B500C            mov edx,[eax+0xc]
00032E85  8B4508            mov eax,[ebp+0x8]
00032E88  8B4004            mov eax,[eax+0x4]
00032E8B  39C2              cmp edx,eax
00032E8D  7232              jc 0x32ec1
00032E8F  8B45F4            mov eax,[ebp-0xc]
00032E92  8D50FF            lea edx,[eax-0x1]
00032E95  8955F4            mov [ebp-0xc],edx
00032E98  0FB655E4          movzx edx,byte [ebp-0x1c]
00032E9C  8810              mov [eax],dl
00032E9E  8B45F4            mov eax,[ebp-0xc]
00032EA1  8D50FF            lea edx,[eax-0x1]
00032EA4  8955F4            mov [ebp-0xc],edx
00032EA7  C60007            mov byte [eax],0x7
00032EAA  8B4508            mov eax,[ebp+0x8]
00032EAD  8B400C            mov eax,[eax+0xc]
00032EB0  8D50FF            lea edx,[eax-0x1]
00032EB3  8B4508            mov eax,[ebp+0x8]
00032EB6  89500C            mov [eax+0xc],edx
00032EB9  EB06              jmp short 0x32ec1
00032EBB  90                nop
00032EBC  EB16              jmp short 0x32ed4
00032EBE  90                nop
00032EBF  EB13              jmp short 0x32ed4
00032EC1  90                nop
00032EC2  EB10              jmp short 0x32ed4
00032EC4  83EC08            sub esp,byte +0x8
00032EC7  6A01              push byte +0x1
00032EC9  FF7508            push dword [ebp+0x8]
00032ECC  E87B020000        call dword 0x3314c
00032ED1  83C410            add esp,byte +0x10
00032ED4  8B4508            mov eax,[ebp+0x8]
00032ED7  8B500C            mov edx,[eax+0xc]
00032EDA  8B4508            mov eax,[ebp+0x8]
00032EDD  8B00              mov eax,[eax]
00032EDF  39C2              cmp edx,eax
00032EE1  76E1              jna 0x32ec4
00032EE3  E912010000        jmp dword 0x32ffa
00032EE8  0FBE45E4          movsx eax,byte [ebp-0x1c]
00032EEC  83F808            cmp eax,byte +0x8
00032EEF  7462              jz 0x32f53
00032EF1  83F80A            cmp eax,byte +0xa
00032EF4  0F858C000000      jnz dword 0x32f86
00032EFA  8B4508            mov eax,[ebp+0x8]
00032EFD  8B500C            mov edx,[eax+0xc]
00032F00  8B4508            mov eax,[ebp+0x8]
00032F03  8B4804            mov ecx,[eax+0x4]
00032F06  8B4508            mov eax,[ebp+0x8]
00032F09  8B4008            mov eax,[eax+0x8]
00032F0C  01C8              add eax,ecx
00032F0E  83E850            sub eax,byte +0x50
00032F11  39C2              cmp edx,eax
00032F13  0F83B4000000      jnc dword 0x32fcd
00032F19  8B4508            mov eax,[ebp+0x8]
00032F1C  8B4804            mov ecx,[eax+0x4]
00032F1F  8B4508            mov eax,[ebp+0x8]
00032F22  8B500C            mov edx,[eax+0xc]
00032F25  8B4508            mov eax,[ebp+0x8]
00032F28  8B4004            mov eax,[eax+0x4]
00032F2B  29C2              sub edx,eax
00032F2D  89D0              mov eax,edx
00032F2F  BACDCCCCCC        mov edx,0xcccccccd
00032F34  F7E2              mul edx
00032F36  89D0              mov eax,edx
00032F38  C1E806            shr eax,byte 0x6
00032F3B  8D5001            lea edx,[eax+0x1]
00032F3E  89D0              mov eax,edx
00032F40  C1E002            shl eax,byte 0x2
00032F43  01D0              add eax,edx
00032F45  C1E004            shl eax,byte 0x4
00032F48  8D1401            lea edx,[ecx+eax]
00032F4B  8B4508            mov eax,[ebp+0x8]
00032F4E  89500C            mov [eax+0xc],edx
00032F51  EB7A              jmp short 0x32fcd
00032F53  8B4508            mov eax,[ebp+0x8]
00032F56  8B500C            mov edx,[eax+0xc]
00032F59  8B4508            mov eax,[ebp+0x8]
00032F5C  8B4004            mov eax,[eax+0x4]
00032F5F  39C2              cmp edx,eax
00032F61  766D              jna 0x32fd0
00032F63  8B4508            mov eax,[ebp+0x8]
00032F66  8B400C            mov eax,[eax+0xc]
00032F69  8D50FF            lea edx,[eax-0x1]
00032F6C  8B4508            mov eax,[ebp+0x8]
00032F6F  89500C            mov [eax+0xc],edx
00032F72  8B45F4            mov eax,[ebp-0xc]
00032F75  83E802            sub eax,byte +0x2
00032F78  C60020            mov byte [eax],0x20
00032F7B  8B45F4            mov eax,[ebp-0xc]
00032F7E  83E801            sub eax,byte +0x1
00032F81  C60007            mov byte [eax],0x7
00032F84  EB4A              jmp short 0x32fd0
00032F86  8B4508            mov eax,[ebp+0x8]
00032F89  8B500C            mov edx,[eax+0xc]
00032F8C  8B4508            mov eax,[ebp+0x8]
00032F8F  8B4804            mov ecx,[eax+0x4]
00032F92  8B4508            mov eax,[ebp+0x8]
00032F95  8B4008            mov eax,[eax+0x8]
00032F98  01C8              add eax,ecx
00032F9A  83E801            sub eax,byte +0x1
00032F9D  39C2              cmp edx,eax
00032F9F  7332              jnc 0x32fd3
00032FA1  8B45F4            mov eax,[ebp-0xc]
00032FA4  8D5001            lea edx,[eax+0x1]
00032FA7  8955F4            mov [ebp-0xc],edx
00032FAA  0FB655E4          movzx edx,byte [ebp-0x1c]
00032FAE  8810              mov [eax],dl
00032FB0  8B45F4            mov eax,[ebp-0xc]
00032FB3  8D5001            lea edx,[eax+0x1]
00032FB6  8955F4            mov [ebp-0xc],edx
00032FB9  C60007            mov byte [eax],0x7
00032FBC  8B4508            mov eax,[ebp+0x8]
00032FBF  8B400C            mov eax,[eax+0xc]
00032FC2  8D5001            lea edx,[eax+0x1]
00032FC5  8B4508            mov eax,[ebp+0x8]
00032FC8  89500C            mov [eax+0xc],edx
00032FCB  EB06              jmp short 0x32fd3
00032FCD  90                nop
00032FCE  EB16              jmp short 0x32fe6
00032FD0  90                nop
00032FD1  EB13              jmp short 0x32fe6
00032FD3  90                nop
00032FD4  EB10              jmp short 0x32fe6
00032FD6  83EC08            sub esp,byte +0x8
00032FD9  6AFF              push byte -0x1
00032FDB  FF7508            push dword [ebp+0x8]
00032FDE  E869010000        call dword 0x3314c
00032FE3  83C410            add esp,byte +0x10
00032FE6  8B4508            mov eax,[ebp+0x8]
00032FE9  8B500C            mov edx,[eax+0xc]
00032FEC  8B4508            mov eax,[ebp+0x8]
00032FEF  8B00              mov eax,[eax]
00032FF1  05D0070000        add eax,0x7d0
00032FF6  39C2              cmp edx,eax
00032FF8  73DC              jnc 0x32fd6
00032FFA  83EC0C            sub esp,byte +0xc
00032FFD  FF7508            push dword [ebp+0x8]
00033000  E806000000        call dword 0x3300b
00033005  83C410            add esp,byte +0x10
00033008  90                nop
00033009  C9                leave
0003300A  C3                ret
0003300B  55                push ebp
0003300C  89E5              mov ebp,esp
0003300E  83EC08            sub esp,byte +0x8
00033011  FF7508            push dword [ebp+0x8]
00033014  E87AFDFFFF        call dword 0x32d93
00033019  83C404            add esp,byte +0x4
0003301C  85C0              test eax,eax
0003301E  7423              jz 0x33043
00033020  8B4508            mov eax,[ebp+0x8]
00033023  8B400C            mov eax,[eax+0xc]
00033026  83EC0C            sub esp,byte +0xc
00033029  50                push eax
0003302A  E817000000        call dword 0x33046
0003302F  83C410            add esp,byte +0x10
00033032  8B4508            mov eax,[ebp+0x8]
00033035  8B00              mov eax,[eax]
00033037  83EC0C            sub esp,byte +0xc
0003303A  50                push eax
0003303B  E86E000000        call dword 0x330ae
00033040  83C410            add esp,byte +0x10
00033043  90                nop
00033044  C9                leave
00033045  C3                ret
00033046  55                push ebp
00033047  89E5              mov ebp,esp
00033049  83EC08            sub esp,byte +0x8
0003304C  E886030000        call dword 0x333d7
00033051  83EC08            sub esp,byte +0x8
00033054  6A0E              push byte +0xe
00033056  68D4030000        push dword 0x3d4
0003305B  E80D030000        call dword 0x3336d
00033060  83C410            add esp,byte +0x10
00033063  8B4508            mov eax,[ebp+0x8]
00033066  C1E808            shr eax,byte 0x8
00033069  0FB6C0            movzx eax,al
0003306C  83EC08            sub esp,byte +0x8
0003306F  50                push eax
00033070  68D5030000        push dword 0x3d5
00033075  E8F3020000        call dword 0x3336d
0003307A  83C410            add esp,byte +0x10
0003307D  83EC08            sub esp,byte +0x8
00033080  6A0F              push byte +0xf
00033082  68D4030000        push dword 0x3d4
00033087  E8E1020000        call dword 0x3336d
0003308C  83C410            add esp,byte +0x10
0003308F  8B4508            mov eax,[ebp+0x8]
00033092  0FB6C0            movzx eax,al
00033095  83EC08            sub esp,byte +0x8
00033098  50                push eax
00033099  68D5030000        push dword 0x3d5
0003309E  E8CA020000        call dword 0x3336d
000330A3  83C410            add esp,byte +0x10
000330A6  E82E030000        call dword 0x333d9
000330AB  90                nop
000330AC  C9                leave
000330AD  C3                ret
000330AE  55                push ebp
000330AF  89E5              mov ebp,esp
000330B1  83EC08            sub esp,byte +0x8
000330B4  E81E030000        call dword 0x333d7
000330B9  83EC08            sub esp,byte +0x8
000330BC  6A0C              push byte +0xc
000330BE  68D4030000        push dword 0x3d4
000330C3  E8A5020000        call dword 0x3336d
000330C8  83C410            add esp,byte +0x10
000330CB  8B4508            mov eax,[ebp+0x8]
000330CE  C1E808            shr eax,byte 0x8
000330D1  0FB6C0            movzx eax,al
000330D4  83EC08            sub esp,byte +0x8
000330D7  50                push eax
000330D8  68D5030000        push dword 0x3d5
000330DD  E88B020000        call dword 0x3336d
000330E2  83C410            add esp,byte +0x10
000330E5  83EC08            sub esp,byte +0x8
000330E8  6A0D              push byte +0xd
000330EA  68D4030000        push dword 0x3d4
000330EF  E879020000        call dword 0x3336d
000330F4  83C410            add esp,byte +0x10
000330F7  8B4508            mov eax,[ebp+0x8]
000330FA  0FB6C0            movzx eax,al
000330FD  83EC08            sub esp,byte +0x8
00033100  50                push eax
00033101  68D5030000        push dword 0x3d5
00033106  E862020000        call dword 0x3336d
0003310B  83C410            add esp,byte +0x10
0003310E  E8C6020000        call dword 0x333d9
00033113  90                nop
00033114  C9                leave
00033115  C3                ret
00033116  55                push ebp
00033117  89E5              mov ebp,esp
00033119  83EC08            sub esp,byte +0x8
0003311C  837D0800          cmp dword [ebp+0x8],byte +0x0
00033120  7827              js 0x33149
00033122  837D0803          cmp dword [ebp+0x8],byte +0x3
00033126  7F21              jg 0x33149
00033128  8B4508            mov eax,[ebp+0x8]
0003312B  A3E8790500        mov [0x579e8],eax
00033130  8B4508            mov eax,[ebp+0x8]
00033133  C1E004            shl eax,byte 0x4
00033136  05E0820500        add eax,0x582e0
0003313B  83EC0C            sub esp,byte +0xc
0003313E  50                push eax
0003313F  E8C7FEFFFF        call dword 0x3300b
00033144  83C410            add esp,byte +0x10
00033147  EB01              jmp short 0x3314a
00033149  90                nop
0003314A  C9                leave
0003314B  C3                ret
0003314C  55                push ebp
0003314D  89E5              mov ebp,esp
0003314F  83EC08            sub esp,byte +0x8
00033152  837D0C01          cmp dword [ebp+0xc],byte +0x1
00033156  751E              jnz 0x33176
00033158  8B4508            mov eax,[ebp+0x8]
0003315B  8B10              mov edx,[eax]
0003315D  8B4508            mov eax,[ebp+0x8]
00033160  8B4004            mov eax,[eax+0x4]
00033163  39C2              cmp edx,eax
00033165  763F              jna 0x331a6
00033167  8B4508            mov eax,[ebp+0x8]
0003316A  8B00              mov eax,[eax]
0003316C  8D50B0            lea edx,[eax-0x50]
0003316F  8B4508            mov eax,[ebp+0x8]
00033172  8910              mov [eax],edx
00033174  EB30              jmp short 0x331a6
00033176  837D0CFF          cmp dword [ebp+0xc],byte -0x1
0003317A  752A              jnz 0x331a6
0003317C  8B4508            mov eax,[ebp+0x8]
0003317F  8B00              mov eax,[eax]
00033181  8D88D0070000      lea ecx,[eax+0x7d0]
00033187  8B4508            mov eax,[ebp+0x8]
0003318A  8B5004            mov edx,[eax+0x4]
0003318D  8B4508            mov eax,[ebp+0x8]
00033190  8B4008            mov eax,[eax+0x8]
00033193  01D0              add eax,edx
00033195  39C1              cmp ecx,eax
00033197  730D              jnc 0x331a6
00033199  8B4508            mov eax,[ebp+0x8]
0003319C  8B00              mov eax,[eax]
0003319E  8D5050            lea edx,[eax+0x50]
000331A1  8B4508            mov eax,[ebp+0x8]
000331A4  8910              mov [eax],edx
000331A6  83EC0C            sub esp,byte +0xc
000331A9  FF7508            push dword [ebp+0x8]
000331AC  E85AFEFFFF        call dword 0x3300b
000331B1  83C410            add esp,byte +0x10
000331B4  90                nop
000331B5  C9                leave
000331B6  C3                ret
000331B7  55                push ebp
000331B8  89E5              mov ebp,esp
000331BA  81EC18010000      sub esp,0x118
000331C0  8D450C            lea eax,[ebp+0xc]
000331C3  8945F4            mov [ebp-0xc],eax
000331C6  8B4508            mov eax,[ebp+0x8]
000331C9  83EC04            sub esp,byte +0x4
000331CC  FF75F4            push dword [ebp-0xc]
000331CF  50                push eax
000331D0  8D85F0FEFFFF      lea eax,[ebp-0x110]
000331D6  50                push eax
000331D7  E820000000        call dword 0x331fc
000331DC  83C410            add esp,byte +0x10
000331DF  8945F0            mov [ebp-0x10],eax
000331E2  83EC08            sub esp,byte +0x8
000331E5  FF75F0            push dword [ebp-0x10]
000331E8  8D85F0FEFFFF      lea eax,[ebp-0x110]
000331EE  50                push eax
000331EF  E824D5FFFF        call dword 0x30718
000331F4  83C410            add esp,byte +0x10
000331F7  8B45F0            mov eax,[ebp-0x10]
000331FA  C9                leave
000331FB  C3                ret
000331FC  55                push ebp
000331FD  89E5              mov ebp,esp
000331FF  81EC18010000      sub esp,0x118
00033205  8B4510            mov eax,[ebp+0x10]
00033208  8945F0            mov [ebp-0x10],eax
0003320B  8B4508            mov eax,[ebp+0x8]
0003320E  8945F4            mov [ebp-0xc],eax
00033211  E9B2000000        jmp dword 0x332c8
00033216  8B450C            mov eax,[ebp+0xc]
00033219  0FB600            movzx eax,byte [eax]
0003321C  3C25              cmp al,0x25
0003321E  7416              jz 0x33236
00033220  8B45F4            mov eax,[ebp-0xc]
00033223  8D5001            lea edx,[eax+0x1]
00033226  8955F4            mov [ebp-0xc],edx
00033229  8B550C            mov edx,[ebp+0xc]
0003322C  0FB612            movzx edx,byte [edx]
0003322F  8810              mov [eax],dl
00033231  E98E000000        jmp dword 0x332c4
00033236  83450C01          add dword [ebp+0xc],byte +0x1
0003323A  8B450C            mov eax,[ebp+0xc]
0003323D  0FB600            movzx eax,byte [eax]
00033240  0FBEC0            movsx eax,al
00033243  83F873            cmp eax,byte +0x73
00033246  744F              jz 0x33297
00033248  83F878            cmp eax,byte +0x78
0003324B  7402              jz 0x3324f
0003324D  EB75              jmp short 0x332c4
0003324F  8B45F0            mov eax,[ebp-0x10]
00033252  8B00              mov eax,[eax]
00033254  83EC08            sub esp,byte +0x8
00033257  50                push eax
00033258  8D85F0FEFFFF      lea eax,[ebp-0x110]
0003325E  50                push eax
0003325F  E877010000        call dword 0x333db
00033264  83C410            add esp,byte +0x10
00033267  83EC08            sub esp,byte +0x8
0003326A  8D85F0FEFFFF      lea eax,[ebp-0x110]
00033270  50                push eax
00033271  FF75F4            push dword [ebp-0xc]
00033274  E8D1020000        call dword 0x3354a
00033279  83C410            add esp,byte +0x10
0003327C  8345F004          add dword [ebp-0x10],byte +0x4
00033280  83EC0C            sub esp,byte +0xc
00033283  8D85F0FEFFFF      lea eax,[ebp-0x110]
00033289  50                push eax
0003328A  E8D3020000        call dword 0x33562
0003328F  83C410            add esp,byte +0x10
00033292  0145F4            add [ebp-0xc],eax
00033295  EB2D              jmp short 0x332c4
00033297  8B45F0            mov eax,[ebp-0x10]
0003329A  8B00              mov eax,[eax]
0003329C  83EC08            sub esp,byte +0x8
0003329F  50                push eax
000332A0  FF75F4            push dword [ebp-0xc]
000332A3  E8A2020000        call dword 0x3354a
000332A8  83C410            add esp,byte +0x10
000332AB  8B45F0            mov eax,[ebp-0x10]
000332AE  8B00              mov eax,[eax]
000332B0  83EC0C            sub esp,byte +0xc
000332B3  50                push eax
000332B4  E8A9020000        call dword 0x33562
000332B9  83C410            add esp,byte +0x10
000332BC  0145F4            add [ebp-0xc],eax
000332BF  8345F004          add dword [ebp-0x10],byte +0x4
000332C3  90                nop
000332C4  83450C01          add dword [ebp+0xc],byte +0x1
000332C8  8B450C            mov eax,[ebp+0xc]
000332CB  0FB600            movzx eax,byte [eax]
000332CE  84C0              test al,al
000332D0  0F8540FFFFFF      jnz dword 0x33216
000332D6  8B55F4            mov edx,[ebp-0xc]
000332D9  8B4508            mov eax,[ebp+0x8]
000332DC  29C2              sub edx,eax
000332DE  89D0              mov eax,edx
000332E0  C9                leave
000332E1  C3                ret
000332E2  6690              xchg ax,ax
000332E4  6690              xchg ax,ax
000332E6  6690              xchg ax,ax
000332E8  6690              xchg ax,ax
000332EA  6690              xchg ax,ax
000332EC  6690              xchg ax,ax
000332EE  6690              xchg ax,ax
000332F0  55                push ebp
000332F1  89E5              mov ebp,esp
000332F3  8B7508            mov esi,[ebp+0x8]
000332F6  8B3DEC790500      mov edi,[dword 0x579ec]
000332FC  B40F              mov ah,0xf
000332FE  AC                lodsb
000332FF  84C0              test al,al
00033301  7423              jz 0x33326
00033303  3C0A              cmp al,0xa
00033305  7516              jnz 0x3331d
00033307  50                push eax
00033308  89F8              mov eax,edi
0003330A  B3A0              mov bl,0xa0
0003330C  F6F3              div bl
0003330E  25FF000000        and eax,0xff
00033313  40                inc eax
00033314  B3A0              mov bl,0xa0
00033316  F6E3              mul bl
00033318  89C7              mov edi,eax
0003331A  58                pop eax
0003331B  EBE1              jmp short 0x332fe
0003331D  65668907          mov [gs:edi],ax
00033321  83C702            add edi,byte +0x2
00033324  EBD8              jmp short 0x332fe
00033326  893DEC790500      mov [dword 0x579ec],edi
0003332C  5D                pop ebp
0003332D  C3                ret
0003332E  55                push ebp
0003332F  89E5              mov ebp,esp
00033331  8B7508            mov esi,[ebp+0x8]
00033334  8B3DEC790500      mov edi,[dword 0x579ec]
0003333A  8A650C            mov ah,[ebp+0xc]
0003333D  AC                lodsb
0003333E  84C0              test al,al
00033340  7423              jz 0x33365
00033342  3C0A              cmp al,0xa
00033344  7516              jnz 0x3335c
00033346  50                push eax
00033347  89F8              mov eax,edi
00033349  B3A0              mov bl,0xa0
0003334B  F6F3              div bl
0003334D  25FF000000        and eax,0xff
00033352  40                inc eax
00033353  B3A0              mov bl,0xa0
00033355  F6E3              mul bl
00033357  89C7              mov edi,eax
00033359  58                pop eax
0003335A  EBE1              jmp short 0x3333d
0003335C  65668907          mov [gs:edi],ax
00033360  83C702            add edi,byte +0x2
00033363  EBD8              jmp short 0x3333d
00033365  893DEC790500      mov [dword 0x579ec],edi
0003336B  5D                pop ebp
0003336C  C3                ret
0003336D  8B542404          mov edx,[esp+0x4]
00033371  8A442408          mov al,[esp+0x8]
00033375  EE                out dx,al
00033376  90                nop
00033377  90                nop
00033378  C3                ret
00033379  8B542404          mov edx,[esp+0x4]
0003337D  31C0              xor eax,eax
0003337F  EC                in al,dx
00033380  90                nop
00033381  90                nop
00033382  C3                ret
00033383  8B4C2404          mov ecx,[esp+0x4]
00033387  9C                pushfd
00033388  FA                cli
00033389  B401              mov ah,0x1
0003338B  D2C4              rol ah,cl
0003338D  80F908            cmp cl,0x8
00033390  7311              jnc 0x333a3
00033392  E421              in al,0x21
00033394  84E0              test al,ah
00033396  751C              jnz 0x333b4
00033398  08E0              or al,ah
0003339A  E621              out 0x21,al
0003339C  9D                popfd
0003339D  B801000000        mov eax,0x1
000333A2  C3                ret
000333A3  E4A1              in al,0xa1
000333A5  84E0              test al,ah
000333A7  750B              jnz 0x333b4
000333A9  08E0              or al,ah
000333AB  E6A1              out 0xa1,al
000333AD  9D                popfd
000333AE  B801000000        mov eax,0x1
000333B3  C3                ret
000333B4  9D                popfd
000333B5  31C0              xor eax,eax
000333B7  C3                ret
000333B8  8B4C2404          mov ecx,[esp+0x4]
000333BC  9C                pushfd
000333BD  FA                cli
000333BE  B4FE              mov ah,0xfe
000333C0  D2C4              rol ah,cl
000333C2  80F908            cmp cl,0x8
000333C5  7308              jnc 0x333cf
000333C7  E421              in al,0x21
000333C9  20E0              and al,ah
000333CB  E621              out 0x21,al
000333CD  9D                popfd
000333CE  C3                ret
000333CF  E4A1              in al,0xa1
000333D1  20E0              and al,ah
000333D3  E6A1              out 0xa1,al
000333D5  9D                popfd
000333D6  C3                ret
000333D7  FA                cli
000333D8  C3                ret
000333D9  FB                sti
000333DA  C3                ret
000333DB  55                push ebp
000333DC  89E5              mov ebp,esp
000333DE  83EC10            sub esp,byte +0x10
000333E1  8B4508            mov eax,[ebp+0x8]
000333E4  8945FC            mov [ebp-0x4],eax
000333E7  C745F000000000    mov dword [ebp-0x10],0x0
000333EE  8B45FC            mov eax,[ebp-0x4]
000333F1  8D5001            lea edx,[eax+0x1]
000333F4  8955FC            mov [ebp-0x4],edx
000333F7  C60030            mov byte [eax],0x30
000333FA  8B45FC            mov eax,[ebp-0x4]
000333FD  8D5001            lea edx,[eax+0x1]
00033400  8955FC            mov [ebp-0x4],edx
00033403  C60078            mov byte [eax],0x78
00033406  837D0C00          cmp dword [ebp+0xc],byte +0x0
0003340A  750E              jnz 0x3341a
0003340C  8B45FC            mov eax,[ebp-0x4]
0003340F  8D5001            lea edx,[eax+0x1]
00033412  8955FC            mov [ebp-0x4],edx
00033415  C60030            mov byte [eax],0x30
00033418  EB61              jmp short 0x3347b
0003341A  C745F41C000000    mov dword [ebp-0xc],0x1c
00033421  EB52              jmp short 0x33475
00033423  8B45F4            mov eax,[ebp-0xc]
00033426  8B550C            mov edx,[ebp+0xc]
00033429  89C1              mov ecx,eax
0003342B  D3FA              sar edx,cl
0003342D  89D0              mov eax,edx
0003342F  83E00F            and eax,byte +0xf
00033432  8845FB            mov [ebp-0x5],al
00033435  837DF000          cmp dword [ebp-0x10],byte +0x0
00033439  7506              jnz 0x33441
0003343B  807DFB00          cmp byte [ebp-0x5],0x0
0003343F  7E30              jng 0x33471
00033441  C745F001000000    mov dword [ebp-0x10],0x1
00033448  0FB645FB          movzx eax,byte [ebp-0x5]
0003344C  83C030            add eax,byte +0x30
0003344F  8845FB            mov [ebp-0x5],al
00033452  807DFB39          cmp byte [ebp-0x5],0x39
00033456  7E0A              jng 0x33462
00033458  0FB645FB          movzx eax,byte [ebp-0x5]
0003345C  83C007            add eax,byte +0x7
0003345F  8845FB            mov [ebp-0x5],al
00033462  8B45FC            mov eax,[ebp-0x4]
00033465  8D5001            lea edx,[eax+0x1]
00033468  8955FC            mov [ebp-0x4],edx
0003346B  0FB655FB          movzx edx,byte [ebp-0x5]
0003346F  8810              mov [eax],dl
00033471  836DF404          sub dword [ebp-0xc],byte +0x4
00033475  837DF400          cmp dword [ebp-0xc],byte +0x0
00033479  79A8              jns 0x33423
0003347B  8B45FC            mov eax,[ebp-0x4]
0003347E  C60000            mov byte [eax],0x0
00033481  8B4508            mov eax,[ebp+0x8]
00033484  C9                leave
00033485  C3                ret
00033486  55                push ebp
00033487  89E5              mov ebp,esp
00033489  83EC18            sub esp,byte +0x18
0003348C  FF7508            push dword [ebp+0x8]
0003348F  8D45E8            lea eax,[ebp-0x18]
00033492  50                push eax
00033493  E843FFFFFF        call dword 0x333db
00033498  83C408            add esp,byte +0x8
0003349B  83EC0C            sub esp,byte +0xc
0003349E  8D45E8            lea eax,[ebp-0x18]
000334A1  50                push eax
000334A2  E849FEFFFF        call dword 0x332f0
000334A7  83C410            add esp,byte +0x10
000334AA  90                nop
000334AB  C9                leave
000334AC  C3                ret
000334AD  55                push ebp
000334AE  89E5              mov ebp,esp
000334B0  83EC10            sub esp,byte +0x10
000334B3  C745F400000000    mov dword [ebp-0xc],0x0
000334BA  EB2D              jmp short 0x334e9
000334BC  C745FC00000000    mov dword [ebp-0x4],0x0
000334C3  EB1A              jmp short 0x334df
000334C5  C745F800000000    mov dword [ebp-0x8],0x0
000334CC  EB04              jmp short 0x334d2
000334CE  8345F801          add dword [ebp-0x8],byte +0x1
000334D2  817DF80F270000    cmp dword [ebp-0x8],0x270f
000334D9  7EF3              jng 0x334ce
000334DB  8345FC01          add dword [ebp-0x4],byte +0x1
000334DF  837DFC09          cmp dword [ebp-0x4],byte +0x9
000334E3  7EE0              jng 0x334c5
000334E5  8345F401          add dword [ebp-0xc],byte +0x1
000334E9  8B45F4            mov eax,[ebp-0xc]
000334EC  3B4508            cmp eax,[ebp+0x8]
000334EF  7CCB              jl 0x334bc
000334F1  90                nop
000334F2  C9                leave
000334F3  C3                ret
000334F4  6690              xchg ax,ax
000334F6  6690              xchg ax,ax
000334F8  6690              xchg ax,ax
000334FA  6690              xchg ax,ax
000334FC  6690              xchg ax,ax
000334FE  6690              xchg ax,ax
00033500  55                push ebp
00033501  89E5              mov ebp,esp
00033503  56                push esi
00033504  57                push edi
00033505  51                push ecx
00033506  8B7D08            mov edi,[ebp+0x8]
00033509  8B750C            mov esi,[ebp+0xc]
0003350C  8B4D10            mov ecx,[ebp+0x10]
0003350F  83F900            cmp ecx,byte +0x0
00033512  740B              jz 0x3351f
00033514  3E8A06            mov al,[ds:esi]
00033517  46                inc esi
00033518  268807            mov [es:edi],al
0003351B  47                inc edi
0003351C  49                dec ecx
0003351D  EBF0              jmp short 0x3350f
0003351F  8B4508            mov eax,[ebp+0x8]
00033522  59                pop ecx
00033523  5F                pop edi
00033524  5E                pop esi
00033525  89EC              mov esp,ebp
00033527  5D                pop ebp
00033528  C3                ret
00033529  55                push ebp
0003352A  89E5              mov ebp,esp
0003352C  56                push esi
0003352D  57                push edi
0003352E  51                push ecx
0003352F  8B7D08            mov edi,[ebp+0x8]
00033532  8B550C            mov edx,[ebp+0xc]
00033535  8B4D10            mov ecx,[ebp+0x10]
00033538  83F900            cmp ecx,byte +0x0
0003353B  7406              jz 0x33543
0003353D  8817              mov [edi],dl
0003353F  47                inc edi
00033540  49                dec ecx
00033541  EBF5              jmp short 0x33538
00033543  59                pop ecx
00033544  5F                pop edi
00033545  5E                pop esi
00033546  89EC              mov esp,ebp
00033548  5D                pop ebp
00033549  C3                ret
0003354A  55                push ebp
0003354B  89E5              mov ebp,esp
0003354D  8B750C            mov esi,[ebp+0xc]
00033550  8B7D08            mov edi,[ebp+0x8]
00033553  8A06              mov al,[esi]
00033555  46                inc esi
00033556  8807              mov [edi],al
00033558  47                inc edi
00033559  3C00              cmp al,0x0
0003355B  75F6              jnz 0x33553
0003355D  8B4508            mov eax,[ebp+0x8]
00033560  5D                pop ebp
00033561  C3                ret
00033562  55                push ebp
00033563  89E5              mov ebp,esp
00033565  B800000000        mov eax,0x0
0003356A  8B7508            mov esi,[ebp+0x8]
0003356D  803E00            cmp byte [esi],0x0
00033570  7404              jz 0x33576
00033572  46                inc esi
00033573  40                inc eax
00033574  EBF7              jmp short 0x3356d
00033576  5D                pop ebp
00033577  C3                ret
00033578  0000              add [eax],al
0003357A  0000              add [eax],al
0003357C  0000              add [eax],al
0003357E  0000              add [eax],al
00033580  0A0A              or cl,[edx]
00033582  0A0A              or cl,[edx]
00033584  0A0A              or cl,[edx]
00033586  0A0A              or cl,[edx]
00033588  0A0A              or cl,[edx]
0003358A  0A0A              or cl,[edx]
0003358C  0A0A              or cl,[edx]
0003358E  0A2D2D2D2D2D      or ch,[dword 0x2d2d2d2d]
00033594  226373            and ah,[ebx+0x73]
00033597  7461              jz 0x335fa
00033599  7274              jc 0x3360f
0003359B  2220              and ah,[eax]
0003359D  626567            bound esp,[ebp+0x67]
000335A0  696E732D2D2D2D    imul ebp,[esi+0x73],dword 0x2d2d2d2d
000335A7  2D0A002D2D        sub eax,0x2d2d000a
000335AC  2D2D2D2263        sub eax,0x63222d2d
000335B1  7374              jnc 0x33627
000335B3  61                popad
000335B4  7274              jc 0x3362a
000335B6  2220              and ah,[eax]
000335B8  66696E697368      imul bp,[esi+0x69],word 0x6873
000335BE  65642D2D2D2D2D    fs sub eax,0x2d2d2d2d
000335C5  0A00              or al,[eax]
000335C7  002D2D2D2D2D      add [dword 0x2d2d2d2d],ch
000335CD  226B65            and ch,[ebx+0x65]
000335D0  726E              jc 0x33640
000335D2  656C              gs insb
000335D4  5F                pop edi
000335D5  6D                insd
000335D6  61                popad
000335D7  696E2220626567    imul ebp,[esi+0x22],dword 0x67656220
000335DE  696E732D2D2D2D    imul ebp,[esi+0x73],dword 0x2d2d2d2d
000335E5  2D0A004100        sub eax,0x41000a
000335EA  42                inc edx
000335EB  004300            add [ebx+0x0],al
000335EE  7370              jnc 0x33660
000335F0  7572              jnz 0x33664
000335F2  696F75735F6972    imul ebp,[edi+0x75],dword 0x72695f73
000335F9  713A              jno 0x33635
000335FB  2000              and [eax],al
000335FD  0A00              or al,[eax]
000335FF  00B95A01004B      add [ecx+0x4b00015a],bh
00033605  1801              sbb [ecx],al
00033607  00A3DC0000C1      add [ebx-0x3effff24],ah
0003360D  B400              mov ah,0x0
0003360F  00C3              add bl,al
00033611  8D00              lea eax,[eax]
00033613  00E2              add dl,ah
00033615  7100              jno 0x33617
00033617  00D6              add dh,dl
00033619  5A                pop edx
0003361A  0000              add [eax],al
0003361C  114900            adc [ecx+0x0],ecx
0003361F  00653A            add [ebp+0x3a],ah
00033622  0000              add [eax],al
00033624  8C2E              mov [esi],gs
00033626  0000              add [eax],al
00033628  4C                dec esp
00033629  250000C41D        and eax,0x1dc40000
0003362E  0000              add [eax],al
00033630  D417              aam 0x17
00033632  0000              add [eax],al
00033634  2813              sub [ebx],dl
00033636  0000              add [eax],al
00033638  42                inc edx
00033639  0F0000            sldt [eax]
0003363C  310C00            xor [eax+eax],ecx
0003363F  00C5              add ch,al
00033641  0900              or [eax],eax
00033643  00C7              add bh,al
00033645  07                pop es
00033646  0000              add [eax],al
00033648  3206              xor al,[esi]
0003364A  0000              add [eax],al
0003364C  FD                std
0003364D  0400              add al,0x0
0003364F  0000              add [eax],al
00033651  0400              add al,0x0
00033653  003403            add [ebx+eax],dh
00033656  0000              add [eax],al
00033658  8F02              pop dword [edx]
0003365A  0000              add [eax],al
0003365C  0E                push cs
0003365D  0200              add al,[eax]
0003365F  00A70100004F      add [edi+0x4f000001],ah
00033665  0100              add [eax],eax
00033667  0010              add [eax],dl
00033669  0100              add [eax],eax
0003366B  00D7              add bh,dl
0003366D  0000              add [eax],al
0003366F  00AC0000008900    add [eax+eax+0x890000],ch
00033676  0000              add [eax],al
00033678  6E                outsb
00033679  0000              add [eax],al
0003367B  005700            add [edi+0x0],dl
0003367E  0000              add [eax],al
00033680  46                inc esi
00033681  0000              add [eax],al
00033683  0038              add [eax],bh
00033685  0000              add [eax],al
00033687  002D00000024      add [dword 0x24000000],ch
0003368D  0000              add [eax],al
0003368F  001D00000017      add [dword 0x17000000],bl
00033695  0000              add [eax],al
00033697  0012              add [edx],dl
00033699  0000              add [eax],al
0003369B  000F              add [edi],cl
0003369D  0000              add [eax],al
0003369F  0020              add [eax],ah
000336A1  004578            add [ebp+0x78],al
000336A4  636570            arpl [ebp+0x70],sp
000336A7  7469              jz 0x33712
000336A9  6F                outsd
000336AA  6E                outsb
000336AB  2120              and [eax],esp
000336AD  2D2D3E2000        sub eax,0x203e2d
000336B2  0A0A              or cl,[edx]
000336B4  004546            add [ebp+0x46],al
000336B7  4C                dec esp
000336B8  41                inc ecx
000336B9  47                inc edi
000336BA  53                push ebx
000336BB  3A00              cmp al,[eax]
000336BD  43                inc ebx
000336BE  53                push ebx
000336BF  3A00              cmp al,[eax]
000336C1  45                inc ebp
000336C2  49                dec ecx
000336C3  50                push eax
000336C4  3A00              cmp al,[eax]
000336C6  45                inc ebp
000336C7  7272              jc 0x3373b
000336C9  6F                outsd
000336CA  7220              jc 0x336ec
000336CC  636F64            arpl [edi+0x64],bp
000336CF  653A00            cmp al,[gs:eax]
000336D2  0000              add [eax],al
000336D4  0000              add [eax],al
000336D6  0000              add [eax],al
000336D8  0000              add [eax],al
000336DA  0000              add [eax],al
000336DC  0000              add [eax],al
000336DE  0000              add [eax],al
000336E0  23444520          and eax,[ebp+eax*2+0x20]
000336E4  44                inc esp
000336E5  69766964652045    imul esi,[esi+0x69],dword 0x45206564
000336EC  7272              jc 0x33760
000336EE  6F                outsd
000336EF  7200              jc 0x336f1
000336F1  0000              add [eax],al
000336F3  0000              add [eax],al
000336F5  0000              add [eax],al
000336F7  0000              add [eax],al
000336F9  0000              add [eax],al
000336FB  0000              add [eax],al
000336FD  0000              add [eax],al
000336FF  0000              add [eax],al
00033701  0000              add [eax],al
00033703  0000              add [eax],al
00033705  0000              add [eax],al
00033707  0000              add [eax],al
00033709  0000              add [eax],al
0003370B  0000              add [eax],al
0003370D  0000              add [eax],al
0003370F  0000              add [eax],al
00033711  0000              add [eax],al
00033713  0000              add [eax],al
00033715  0000              add [eax],al
00033717  0000              add [eax],al
00033719  0000              add [eax],al
0003371B  0000              add [eax],al
0003371D  0000              add [eax],al
0003371F  0023              add [ebx],ah
00033721  44                inc esp
00033722  42                inc edx
00033723  205245            and [edx+0x45],dl
00033726  53                push ebx
00033727  45                inc ebp
00033728  52                push edx
00033729  56                push esi
0003372A  45                inc ebp
0003372B  44                inc esp
0003372C  0000              add [eax],al
0003372E  0000              add [eax],al
00033730  0000              add [eax],al
00033732  0000              add [eax],al
00033734  0000              add [eax],al
00033736  0000              add [eax],al
00033738  0000              add [eax],al
0003373A  0000              add [eax],al
0003373C  0000              add [eax],al
0003373E  0000              add [eax],al
00033740  0000              add [eax],al
00033742  0000              add [eax],al
00033744  0000              add [eax],al
00033746  0000              add [eax],al
00033748  0000              add [eax],al
0003374A  0000              add [eax],al
0003374C  0000              add [eax],al
0003374E  0000              add [eax],al
00033750  0000              add [eax],al
00033752  0000              add [eax],al
00033754  0000              add [eax],al
00033756  0000              add [eax],al
00033758  0000              add [eax],al
0003375A  0000              add [eax],al
0003375C  0000              add [eax],al
0003375E  0000              add [eax],al
00033760  E280              loop 0x336e2
00033762  94                xchg eax,esp
00033763  2020              and [eax],ah
00033765  4E                dec esi
00033766  4D                dec ebp
00033767  49                dec ecx
00033768  20496E            and [ecx+0x6e],cl
0003376B  7465              jz 0x337d2
0003376D  7272              jc 0x337e1
0003376F  7570              jnz 0x337e1
00033771  7400              jz 0x33773
00033773  0000              add [eax],al
00033775  0000              add [eax],al
00033777  0000              add [eax],al
00033779  0000              add [eax],al
0003377B  0000              add [eax],al
0003377D  0000              add [eax],al
0003377F  0000              add [eax],al
00033781  0000              add [eax],al
00033783  0000              add [eax],al
00033785  0000              add [eax],al
00033787  0000              add [eax],al
00033789  0000              add [eax],al
0003378B  0000              add [eax],al
0003378D  0000              add [eax],al
0003378F  0000              add [eax],al
00033791  0000              add [eax],al
00033793  0000              add [eax],al
00033795  0000              add [eax],al
00033797  0000              add [eax],al
00033799  0000              add [eax],al
0003379B  0000              add [eax],al
0003379D  0000              add [eax],al
0003379F  0023              add [ebx],ah
000337A1  42                inc edx
000337A2  50                push eax
000337A3  204272            and [edx+0x72],al
000337A6  6561              gs popad
000337A8  6B706F69          imul esi,[eax+0x6f],byte +0x69
000337AC  6E                outsb
000337AD  7400              jz 0x337af
000337AF  0000              add [eax],al
000337B1  0000              add [eax],al
000337B3  0000              add [eax],al
000337B5  0000              add [eax],al
000337B7  0000              add [eax],al
000337B9  0000              add [eax],al
000337BB  0000              add [eax],al
000337BD  0000              add [eax],al
000337BF  0000              add [eax],al
000337C1  0000              add [eax],al
000337C3  0000              add [eax],al
000337C5  0000              add [eax],al
000337C7  0000              add [eax],al
000337C9  0000              add [eax],al
000337CB  0000              add [eax],al
000337CD  0000              add [eax],al
000337CF  0000              add [eax],al
000337D1  0000              add [eax],al
000337D3  0000              add [eax],al
000337D5  0000              add [eax],al
000337D7  0000              add [eax],al
000337D9  0000              add [eax],al
000337DB  0000              add [eax],al
000337DD  0000              add [eax],al
000337DF  0023              add [ebx],ah
000337E1  4F                dec edi
000337E2  46                inc esi
000337E3  204F76            and [edi+0x76],cl
000337E6  657266            gs jc 0x3384f
000337E9  6C                insb
000337EA  6F                outsd
000337EB  7700              ja 0x337ed
000337ED  0000              add [eax],al
000337EF  0000              add [eax],al
000337F1  0000              add [eax],al
000337F3  0000              add [eax],al
000337F5  0000              add [eax],al
000337F7  0000              add [eax],al
000337F9  0000              add [eax],al
000337FB  0000              add [eax],al
000337FD  0000              add [eax],al
000337FF  0000              add [eax],al
00033801  0000              add [eax],al
00033803  0000              add [eax],al
00033805  0000              add [eax],al
00033807  0000              add [eax],al
00033809  0000              add [eax],al
0003380B  0000              add [eax],al
0003380D  0000              add [eax],al
0003380F  0000              add [eax],al
00033811  0000              add [eax],al
00033813  0000              add [eax],al
00033815  0000              add [eax],al
00033817  0000              add [eax],al
00033819  0000              add [eax],al
0003381B  0000              add [eax],al
0003381D  0000              add [eax],al
0003381F  0023              add [ebx],ah
00033821  42                inc edx
00033822  52                push edx
00033823  20424F            and [edx+0x4f],al
00033826  55                push ebp
00033827  4E                dec esi
00033828  44                inc esp
00033829  205261            and [edx+0x61],dl
0003382C  6E                outsb
0003382D  6765204578        and [gs:di+0x78],al
00033832  636565            arpl [ebp+0x65],sp
00033835  6465640000        add [fs:eax],al
0003383A  0000              add [eax],al
0003383C  0000              add [eax],al
0003383E  0000              add [eax],al
00033840  0000              add [eax],al
00033842  0000              add [eax],al
00033844  0000              add [eax],al
00033846  0000              add [eax],al
00033848  0000              add [eax],al
0003384A  0000              add [eax],al
0003384C  0000              add [eax],al
0003384E  0000              add [eax],al
00033850  0000              add [eax],al
00033852  0000              add [eax],al
00033854  0000              add [eax],al
00033856  0000              add [eax],al
00033858  0000              add [eax],al
0003385A  0000              add [eax],al
0003385C  0000              add [eax],al
0003385E  0000              add [eax],al
00033860  235544            and edx,[ebp+0x44]
00033863  20496E            and [ecx+0x6e],cl
00033866  7661              jna 0x338c9
00033868  6C                insb
00033869  6964204F70636F64  imul esp,[eax+0x4f],dword 0x646f6370
00033871  652028            and [gs:eax],ch
00033874  55                push ebp
00033875  6E                outsb
00033876  646566696E656420  imul bp,[gs:esi+0x65],word 0x2064
0003387E  4F                dec edi
0003387F  7063              jo 0x338e4
00033881  6F                outsd
00033882  64652900          sub [gs:eax],eax
00033886  0000              add [eax],al
00033888  0000              add [eax],al
0003388A  0000              add [eax],al
0003388C  0000              add [eax],al
0003388E  0000              add [eax],al
00033890  0000              add [eax],al
00033892  0000              add [eax],al
00033894  0000              add [eax],al
00033896  0000              add [eax],al
00033898  0000              add [eax],al
0003389A  0000              add [eax],al
0003389C  0000              add [eax],al
0003389E  0000              add [eax],al
000338A0  234E4D            and ecx,[esi+0x4d]
000338A3  20446576          and [ebp+0x76],al
000338A7  696365204E6F74    imul esp,[ebx+0x65],dword 0x746f4e20
000338AE  204176            and [ecx+0x76],al
000338B1  61                popad
000338B2  696C61626C652028  imul ebp,[ecx+0x62],dword 0x2820656c
000338BA  4E                dec esi
000338BB  6F                outsd
000338BC  204D61            and [ebp+0x61],cl
000338BF  7468              jz 0x33929
000338C1  20436F            and [ebx+0x6f],al
000338C4  7072              jo 0x33938
000338C6  6F                outsd
000338C7  636573            arpl [ebp+0x73],sp
000338CA  736F              jnc 0x3393b
000338CC  7229              jc 0x338f7
000338CE  0000              add [eax],al
000338D0  0000              add [eax],al
000338D2  0000              add [eax],al
000338D4  0000              add [eax],al
000338D6  0000              add [eax],al
000338D8  0000              add [eax],al
000338DA  0000              add [eax],al
000338DC  0000              add [eax],al
000338DE  0000              add [eax],al
000338E0  23444620          and eax,[esi+eax*2+0x20]
000338E4  44                inc esp
000338E5  6F                outsd
000338E6  7562              jnz 0x3394a
000338E8  6C                insb
000338E9  65204661          and [gs:esi+0x61],al
000338ED  756C              jnz 0x3395b
000338EF  7400              jz 0x338f1
000338F1  0000              add [eax],al
000338F3  0000              add [eax],al
000338F5  0000              add [eax],al
000338F7  0000              add [eax],al
000338F9  0000              add [eax],al
000338FB  0000              add [eax],al
000338FD  0000              add [eax],al
000338FF  0000              add [eax],al
00033901  0000              add [eax],al
00033903  0000              add [eax],al
00033905  0000              add [eax],al
00033907  0000              add [eax],al
00033909  0000              add [eax],al
0003390B  0000              add [eax],al
0003390D  0000              add [eax],al
0003390F  0000              add [eax],al
00033911  0000              add [eax],al
00033913  0000              add [eax],al
00033915  0000              add [eax],al
00033917  0000              add [eax],al
00033919  0000              add [eax],al
0003391B  0000              add [eax],al
0003391D  0000              add [eax],al
0003391F  0020              add [eax],ah
00033921  2020              and [eax],ah
00033923  20436F            and [ebx+0x6f],al
00033926  7072              jo 0x3399a
00033928  6F                outsd
00033929  636573            arpl [ebp+0x73],sp
0003392C  736F              jnc 0x3399d
0003392E  7220              jc 0x33950
00033930  53                push ebx
00033931  65676D            gs a16 insd
00033934  656E              gs outsb
00033936  7420              jz 0x33958
00033938  4F                dec edi
00033939  7665              jna 0x339a0
0003393B  7272              jc 0x339af
0003393D  756E              jnz 0x339ad
0003393F  2028              and [eax],ch
00033941  7265              jc 0x339a8
00033943  7365              jnc 0x339aa
00033945  7276              jc 0x339bd
00033947  65642900          sub [fs:eax],eax
0003394B  0000              add [eax],al
0003394D  0000              add [eax],al
0003394F  0000              add [eax],al
00033951  0000              add [eax],al
00033953  0000              add [eax],al
00033955  0000              add [eax],al
00033957  0000              add [eax],al
00033959  0000              add [eax],al
0003395B  0000              add [eax],al
0003395D  0000              add [eax],al
0003395F  0023              add [ebx],ah
00033961  54                push esp
00033962  53                push ebx
00033963  20496E            and [ecx+0x6e],cl
00033966  7661              jna 0x339c9
00033968  6C                insb
00033969  6964205453530000  imul esp,[eax+0x54],dword 0x5353
00033971  0000              add [eax],al
00033973  0000              add [eax],al
00033975  0000              add [eax],al
00033977  0000              add [eax],al
00033979  0000              add [eax],al
0003397B  0000              add [eax],al
0003397D  0000              add [eax],al
0003397F  0000              add [eax],al
00033981  0000              add [eax],al
00033983  0000              add [eax],al
00033985  0000              add [eax],al
00033987  0000              add [eax],al
00033989  0000              add [eax],al
0003398B  0000              add [eax],al
0003398D  0000              add [eax],al
0003398F  0000              add [eax],al
00033991  0000              add [eax],al
00033993  0000              add [eax],al
00033995  0000              add [eax],al
00033997  0000              add [eax],al
00033999  0000              add [eax],al
0003399B  0000              add [eax],al
0003399D  0000              add [eax],al
0003399F  0023              add [ebx],ah
000339A1  4E                dec esi
000339A2  50                push eax
000339A3  205365            and [ebx+0x65],dl
000339A6  676D              a16 insd
000339A8  656E              gs outsb
000339AA  7420              jz 0x339cc
000339AC  4E                dec esi
000339AD  6F                outsd
000339AE  7420              jz 0x339d0
000339B0  50                push eax
000339B1  7265              jc 0x33a18
000339B3  7365              jnc 0x33a1a
000339B5  6E                outsb
000339B6  7400              jz 0x339b8
000339B8  0000              add [eax],al
000339BA  0000              add [eax],al
000339BC  0000              add [eax],al
000339BE  0000              add [eax],al
000339C0  0000              add [eax],al
000339C2  0000              add [eax],al
000339C4  0000              add [eax],al
000339C6  0000              add [eax],al
000339C8  0000              add [eax],al
000339CA  0000              add [eax],al
000339CC  0000              add [eax],al
000339CE  0000              add [eax],al
000339D0  0000              add [eax],al
000339D2  0000              add [eax],al
000339D4  0000              add [eax],al
000339D6  0000              add [eax],al
000339D8  0000              add [eax],al
000339DA  0000              add [eax],al
000339DC  0000              add [eax],al
000339DE  0000              add [eax],al
000339E0  235353            and edx,[ebx+0x53]
000339E3  205374            and [ebx+0x74],dl
000339E6  61                popad
000339E7  636B2D            arpl [ebx+0x2d],bp
000339EA  53                push ebx
000339EB  65676D            gs a16 insd
000339EE  656E              gs outsb
000339F0  7420              jz 0x33a12
000339F2  46                inc esi
000339F3  61                popad
000339F4  756C              jnz 0x33a62
000339F6  7400              jz 0x339f8
000339F8  0000              add [eax],al
000339FA  0000              add [eax],al
000339FC  0000              add [eax],al
000339FE  0000              add [eax],al
00033A00  0000              add [eax],al
00033A02  0000              add [eax],al
00033A04  0000              add [eax],al
00033A06  0000              add [eax],al
00033A08  0000              add [eax],al
00033A0A  0000              add [eax],al
00033A0C  0000              add [eax],al
00033A0E  0000              add [eax],al
00033A10  0000              add [eax],al
00033A12  0000              add [eax],al
00033A14  0000              add [eax],al
00033A16  0000              add [eax],al
00033A18  0000              add [eax],al
00033A1A  0000              add [eax],al
00033A1C  0000              add [eax],al
00033A1E  0000              add [eax],al
00033A20  234750            and eax,[edi+0x50]
00033A23  204765            and [edi+0x65],al
00033A26  6E                outsb
00033A27  657261            gs jc 0x33a8b
00033A2A  6C                insb
00033A2B  205072            and [eax+0x72],dl
00033A2E  6F                outsd
00033A2F  7465              jz 0x33a96
00033A31  6374696F          arpl [ecx+ebp*2+0x6f],si
00033A35  6E                outsb
00033A36  0000              add [eax],al
00033A38  0000              add [eax],al
00033A3A  0000              add [eax],al
00033A3C  0000              add [eax],al
00033A3E  0000              add [eax],al
00033A40  0000              add [eax],al
00033A42  0000              add [eax],al
00033A44  0000              add [eax],al
00033A46  0000              add [eax],al
00033A48  0000              add [eax],al
00033A4A  0000              add [eax],al
00033A4C  0000              add [eax],al
00033A4E  0000              add [eax],al
00033A50  0000              add [eax],al
00033A52  0000              add [eax],al
00033A54  0000              add [eax],al
00033A56  0000              add [eax],al
00033A58  0000              add [eax],al
00033A5A  0000              add [eax],al
00033A5C  0000              add [eax],al
00033A5E  0000              add [eax],al
00033A60  235046            and edx,[eax+0x46]
00033A63  205061            and [eax+0x61],dl
00033A66  6765204661        and [gs:bp+0x61],al
00033A6B  756C              jnz 0x33ad9
00033A6D  7400              jz 0x33a6f
00033A6F  0000              add [eax],al
00033A71  0000              add [eax],al
00033A73  0000              add [eax],al
00033A75  0000              add [eax],al
00033A77  0000              add [eax],al
00033A79  0000              add [eax],al
00033A7B  0000              add [eax],al
00033A7D  0000              add [eax],al
00033A7F  0000              add [eax],al
00033A81  0000              add [eax],al
00033A83  0000              add [eax],al
00033A85  0000              add [eax],al
00033A87  0000              add [eax],al
00033A89  0000              add [eax],al
00033A8B  0000              add [eax],al
00033A8D  0000              add [eax],al
00033A8F  0000              add [eax],al
00033A91  0000              add [eax],al
00033A93  0000              add [eax],al
00033A95  0000              add [eax],al
00033A97  0000              add [eax],al
00033A99  0000              add [eax],al
00033A9B  0000              add [eax],al
00033A9D  0000              add [eax],al
00033A9F  00E2              add dl,ah
00033AA1  8094202028496E74  adc byte [eax+0x6e492820],0x74
00033AA9  656C              gs insb
00033AAB  207265            and [edx+0x65],dh
00033AAE  7365              jnc 0x33b15
00033AB0  7276              jc 0x33b28
00033AB2  65642E20446F20    and [cs:edi+ebp*2+0x20],al
00033AB9  6E                outsb
00033ABA  6F                outsd
00033ABB  7420              jz 0x33add
00033ABD  7573              jnz 0x33b32
00033ABF  652E2900          sub [cs:eax],eax
00033AC3  0000              add [eax],al
00033AC5  0000              add [eax],al
00033AC7  0000              add [eax],al
00033AC9  0000              add [eax],al
00033ACB  0000              add [eax],al
00033ACD  0000              add [eax],al
00033ACF  0000              add [eax],al
00033AD1  0000              add [eax],al
00033AD3  0000              add [eax],al
00033AD5  0000              add [eax],al
00033AD7  0000              add [eax],al
00033AD9  0000              add [eax],al
00033ADB  0000              add [eax],al
00033ADD  0000              add [eax],al
00033ADF  0023              add [ebx],ah
00033AE1  4D                dec ebp
00033AE2  46                inc esi
00033AE3  207838            and [eax+0x38],bh
00033AE6  37                aaa
00033AE7  204650            and [esi+0x50],al
00033AEA  55                push ebp
00033AEB  20466C            and [esi+0x6c],al
00033AEE  6F                outsd
00033AEF  61                popad
00033AF0  7469              jz 0x33b5b
00033AF2  6E                outsb
00033AF3  672D506F696E      sub eax,0x6e696f50
00033AF9  7420              jz 0x33b1b
00033AFB  45                inc ebp
00033AFC  7272              jc 0x33b70
00033AFE  6F                outsd
00033AFF  7220              jc 0x33b21
00033B01  284D61            sub [ebp+0x61],cl
00033B04  7468              jz 0x33b6e
00033B06  204661            and [esi+0x61],al
00033B09  756C              jnz 0x33b77
00033B0B  7429              jz 0x33b36
00033B0D  0000              add [eax],al
00033B0F  0000              add [eax],al
00033B11  0000              add [eax],al
00033B13  0000              add [eax],al
00033B15  0000              add [eax],al
00033B17  0000              add [eax],al
00033B19  0000              add [eax],al
00033B1B  0000              add [eax],al
00033B1D  0000              add [eax],al
00033B1F  0023              add [ebx],ah
00033B21  41                inc ecx
00033B22  43                inc ebx
00033B23  20416C            and [ecx+0x6c],al
00033B26  69676E6D656E74    imul esp,[edi+0x6e],dword 0x746e656d
00033B2D  204368            and [ebx+0x68],al
00033B30  65636B00          arpl [gs:ebx+0x0],bp
00033B34  0000              add [eax],al
00033B36  0000              add [eax],al
00033B38  0000              add [eax],al
00033B3A  0000              add [eax],al
00033B3C  0000              add [eax],al
00033B3E  0000              add [eax],al
00033B40  0000              add [eax],al
00033B42  0000              add [eax],al
00033B44  0000              add [eax],al
00033B46  0000              add [eax],al
00033B48  0000              add [eax],al
00033B4A  0000              add [eax],al
00033B4C  0000              add [eax],al
00033B4E  0000              add [eax],al
00033B50  0000              add [eax],al
00033B52  0000              add [eax],al
00033B54  0000              add [eax],al
00033B56  0000              add [eax],al
00033B58  0000              add [eax],al
00033B5A  0000              add [eax],al
00033B5C  0000              add [eax],al
00033B5E  0000              add [eax],al
00033B60  234D43            and ecx,[ebp+0x43]
00033B63  204D61            and [ebp+0x61],cl
00033B66  636869            arpl [eax+0x69],bp
00033B69  6E                outsb
00033B6A  65204368          and [gs:ebx+0x68],al
00033B6E  65636B00          arpl [gs:ebx+0x0],bp
00033B72  0000              add [eax],al
00033B74  0000              add [eax],al
00033B76  0000              add [eax],al
00033B78  0000              add [eax],al
00033B7A  0000              add [eax],al
00033B7C  0000              add [eax],al
00033B7E  0000              add [eax],al
00033B80  0000              add [eax],al
00033B82  0000              add [eax],al
00033B84  0000              add [eax],al
00033B86  0000              add [eax],al
00033B88  0000              add [eax],al
00033B8A  0000              add [eax],al
00033B8C  0000              add [eax],al
00033B8E  0000              add [eax],al
00033B90  0000              add [eax],al
00033B92  0000              add [eax],al
00033B94  0000              add [eax],al
00033B96  0000              add [eax],al
00033B98  0000              add [eax],al
00033B9A  0000              add [eax],al
00033B9C  0000              add [eax],al
00033B9E  0000              add [eax],al
00033BA0  235846            and ebx,[eax+0x46]
00033BA3  205349            and [ebx+0x49],dl
00033BA6  4D                dec ebp
00033BA7  44                inc esp
00033BA8  20466C            and [esi+0x6c],al
00033BAB  6F                outsd
00033BAC  61                popad
00033BAD  7469              jz 0x33c18
00033BAF  6E                outsb
00033BB0  672D506F696E      sub eax,0x6e696f50
00033BB6  7420              jz 0x33bd8
00033BB8  45                inc ebp
00033BB9  7863              js 0x33c1e
00033BBB  657074            gs jo 0x33c32
00033BBE  696F6E00000000    imul ebp,[edi+0x6e],dword 0x0
00033BC5  0000              add [eax],al
00033BC7  0000              add [eax],al
00033BC9  0000              add [eax],al
00033BCB  0000              add [eax],al
00033BCD  0000              add [eax],al
00033BCF  0000              add [eax],al
00033BD1  0000              add [eax],al
00033BD3  0000              add [eax],al
00033BD5  0000              add [eax],al
00033BD7  0000              add [eax],al
00033BD9  0000              add [eax],al
00033BDB  0000              add [eax],al
00033BDD  0000              add [eax],al
00033BDF  0020              add [eax],ah
00033BE1  000A              add [edx],cl
00033BE3  000B              add [ebx],cl
00033BE5  2503001825        and eax,0x25180003
00033BEA  0300              add eax,[eax]
00033BEC  2525030032        and eax,0x32000325
00033BF1  2503003C25        and eax,0x253c0003
00033BF6  0300              add eax,[eax]
00033BF8  46                inc esi
00033BF9  2503005025        and eax,0x25500003
00033BFE  0300              add eax,[eax]
00033C00  6F                outsd
00033C01  2503008E25        and eax,0x258e0003
00033C06  0300              add eax,[eax]
00033C08  FF2503000B26      jmp dword [dword 0x260b0003]
00033C0E  0300              add eax,[eax]
00033C10  17                pop ss
00033C11  260300            add eax,[es:eax]
00033C14  2326              and esp,[esi]
00033C16  0300              add eax,[eax]
00033C18  2F                das
00033C19  260300            add eax,[es:eax]
00033C1C  E426              in al,0x26
00033C1E  0300              add eax,[eax]
00033C20  B726              mov bh,0x26
00033C22  0300              add eax,[eax]
00033C24  9C                pushfd
00033C25  260300            add eax,[es:eax]
00033C28  C9                leave
00033C29  260300            add eax,[es:eax]
00033C2C  AE                scasb
00033C2D  260300            add eax,[es:eax]
00033C30  D226              shl byte [esi],cl
00033C32  0300              add eax,[eax]
00033C34  ED                in eax,dx
00033C35  260300            add eax,[es:eax]
00033C38  DB                db 0xdb
00033C39  260300            add eax,[es:eax]
00033C3C  93                xchg eax,ebx
00033C3D  260300            add eax,[es:eax]
00033C40  C02603            shl byte [esi],byte 0x3
00033C43  00A5260300EB      add [ebp-0x14fffcda],ah
00033C49  2903              sub [ebx],eax
00033C4B  0000              add [eax],al
00033C4D  2A03              sub al,[ebx]
00033C4F  00A52A0300A5      add [ebp-0x5afffcd6],ah
00033C55  2A03              sub al,[ebx]
00033C57  00A52A0300A5      add [ebp-0x5afffcd6],ah
00033C5D  2A03              sub al,[ebx]
00033C5F  00A52A0300A5      add [ebp-0x5afffcd6],ah
00033C65  2A03              sub al,[ebx]
00033C67  00A52A0300A5      add [ebp-0x5afffcd6],ah
00033C6D  2A03              sub al,[ebx]
00033C6F  00A52A0300A5      add [ebp-0x5afffcd6],ah
00033C75  2A03              sub al,[ebx]
00033C77  00A52A0300A5      add [ebp-0x5afffcd6],ah
00033C7D  2A03              sub al,[ebx]
00033C7F  00772A            add [edi+0x2a],dh
00033C82  0300              add eax,[eax]
00033C84  772A              ja 0x33cb0
00033C86  0300              add eax,[eax]
00033C88  772A              ja 0x33cb4
00033C8A  0300              add eax,[eax]
00033C8C  772A              ja 0x33cb8
00033C8E  0300              add eax,[eax]
00033C90  772A              ja 0x33cbc
00033C92  0300              add eax,[eax]
00033C94  772A              ja 0x33cc0
00033C96  0300              add eax,[eax]
00033C98  772A              ja 0x33cc4
00033C9A  0300              add eax,[eax]
00033C9C  772A              ja 0x33cc8
00033C9E  0300              add eax,[eax]
00033CA0  772A              ja 0x33ccc
00033CA2  0300              add eax,[eax]
00033CA4  772A              ja 0x33cd0
00033CA6  0300              add eax,[eax]
00033CA8  772A              ja 0x33cd4
00033CAA  0300              add eax,[eax]
00033CAC  772A              ja 0x33cd8
00033CAE  0300              add eax,[eax]
00033CB0  A5                movsd
00033CB1  2A03              sub al,[ebx]
00033CB3  00A52A0300A5      add [ebp-0x5afffcd6],ah
00033CB9  2A03              sub al,[ebx]
00033CBB  00A52A0300A5      add [ebp-0x5afffcd6],ah
00033CC1  2A03              sub al,[ebx]
00033CC3  00A52A0300A5      add [ebp-0x5afffcd6],ah
00033CC9  2A03              sub al,[ebx]
00033CCB  00A52A030015      add [ebp+0x1500032a],ah
00033CD1  2A03              sub al,[ebx]
00033CD3  00462A            add [esi+0x2a],al
00033CD6  0300              add eax,[eax]
00033CD8  1400              adc al,0x0
00033CDA  0000              add [eax],al
00033CDC  0000              add [eax],al
00033CDE  0000              add [eax],al
00033CE0  017A52            add [edx+0x52],edi
00033CE3  0001              add [ecx],al
00033CE5  7C08              jl 0x33cef
00033CE7  011B              add [ebx],ebx
00033CE9  0C04              or al,0x4
00033CEB  0488              add al,0x88
00033CED  0100              add [eax],eax
00033CEF  001C00            add [eax+eax],bl
00033CF2  0000              add [eax],al
00033CF4  1C00              sbb al,0x0
00033CF6  0000              add [eax],al
00033CF8  30CA              xor dl,cl
00033CFA  FF                db 0xff
00033CFB  FF9500000000      call dword [ebp+0x0]
00033D01  41                inc ecx
00033D02  0E                push cs
00033D03  088502420D05      or [ebp+0x50d4202],al
00033D09  0291C50C0404      add dl,[ecx+0x4040cc5]
00033D0F  0018              add [eax],bl
00033D11  0000              add [eax],al
00033D13  003C00            add [eax+eax],bh
00033D16  0000              add [eax],al
00033D18  A5                movsd
00033D19  CAFFFF            retf 0xffff
00033D1C  2A02              sub al,[edx]
00033D1E  0000              add [eax],al
00033D20  00410E            add [ecx+0xe],al
00033D23  088502420D05      or [ebp+0x50d4202],al
00033D29  0000              add [eax],al
00033D2B  0018              add [eax],bl
00033D2D  0000              add [eax],al
00033D2F  005800            add [eax+0x0],bl
00033D32  0000              add [eax],al
00033D34  B3CC              mov bl,0xcc
00033D36  FF                db 0xff
00033D37  FF2C00            jmp dword far [eax+eax]
00033D3A  0000              add [eax],al
00033D3C  00410E            add [ecx+0xe],al
00033D3F  088502420D05      or [ebp+0x50d4202],al
00033D45  0000              add [eax],al
00033D47  0018              add [eax],bl
00033D49  0000              add [eax],al
00033D4B  00740000          add [eax+eax+0x0],dh
00033D4F  00C3              add bl,al
00033D51  CC                int3
00033D52  FF                db 0xff
00033D53  FF2C00            jmp dword far [eax+eax]
00033D56  0000              add [eax],al
00033D58  00410E            add [ecx+0xe],al
00033D5B  088502420D05      or [ebp+0x50d4202],al
00033D61  0000              add [eax],al
00033D63  0018              add [eax],bl
00033D65  0000              add [eax],al
00033D67  0090000000D3      add [eax-0x2d000000],dl
00033D6D  CC                int3
00033D6E  FF                db 0xff
00033D6F  FF2C00            jmp dword far [eax+eax]
00033D72  0000              add [eax],al
00033D74  00410E            add [ecx+0xe],al
00033D77  088502420D05      or [ebp+0x50d4202],al
00033D7D  0000              add [eax],al
00033D7F  001C00            add [eax+eax],bl
00033D82  0000              add [eax],al
00033D84  AC                lodsb
00033D85  0000              add [eax],al
00033D87  00E3              add bl,ah
00033D89  CC                int3
00033D8A  FF                db 0xff
00033D8B  FF                db 0xff
00033D8C  EB00              jmp short 0x33d8e
00033D8E  0000              add [eax],al
00033D90  00410E            add [ecx+0xe],al
00033D93  088502420D05      or [ebp+0x50d4202],al
00033D99  02E7              add ah,bh
00033D9B  C50C04            lds ecx,[esp+eax]
00033D9E  0400              add al,0x0
00033DA0  1C00              sbb al,0x0
00033DA2  0000              add [eax],al
00033DA4  CC                int3
00033DA5  0000              add [eax],al
00033DA7  00AECDFFFF3A      add [esi+0x3affffcd],ch
00033DAD  0000              add [eax],al
00033DAF  0000              add [eax],al
00033DB1  41                inc ecx
00033DB2  0E                push cs
00033DB3  088502420D05      or [ebp+0x50d4202],al
00033DB9  76C5              jna 0x33d80
00033DBB  0C04              or al,0x4
00033DBD  0400              add al,0x0
00033DBF  001C00            add [eax+eax],bl
00033DC2  0000              add [eax],al
00033DC4  EC                in al,dx
00033DC5  0000              add [eax],al
00033DC7  00C8              add al,cl
00033DC9  CDFF              int 0xff
00033DCB  FF5800            call dword far [eax+0x0]
00033DCE  0000              add [eax],al
00033DD0  00410E            add [ecx+0xe],al
00033DD3  088502420D05      or [ebp+0x50d4202],al
00033DD9  0254C50C          add dl,[ebp+eax*8+0xc]
00033DDD  0404              add al,0x4
00033DDF  001C00            add [eax+eax],bl
00033DE2  0000              add [eax],al
00033DE4  0C01              or al,0x1
00033DE6  0000              add [eax],al
00033DE8  00CE              add dh,cl
00033DEA  FF                db 0xff
00033DEB  FFD5              call ebp
00033DED  0000              add [eax],al
00033DEF  0000              add [eax],al
00033DF1  41                inc ecx
00033DF2  0E                push cs
00033DF3  088502420D05      or [ebp+0x50d4202],al
00033DF9  02D1              add dl,cl
00033DFB  C50C04            lds ecx,[esp+eax]
00033DFE  0400              add al,0x0
00033E00  1C00              sbb al,0x0
00033E02  0000              add [eax],al
00033E04  2C01              sub al,0x1
00033E06  0000              add [eax],al
00033E08  B5CE              mov ch,0xce
00033E0A  FF                db 0xff
00033E0B  FF37              push dword [edi]
00033E0D  0000              add [eax],al
00033E0F  0000              add [eax],al
00033E11  41                inc ecx
00033E12  0E                push cs
00033E13  088502420D05      or [ebp+0x50d4202],al
00033E19  73C5              jnc 0x33de0
00033E1B  0C04              or al,0x4
00033E1D  0400              add al,0x0
00033E1F  001C00            add [eax+eax],bl
00033E22  0000              add [eax],al
00033E24  4C                dec esp
00033E25  0100              add [eax],eax
00033E27  00CC              add ah,cl
00033E29  CE                into
00033E2A  FF                db 0xff
00033E2B  FF2400            jmp dword [eax+eax]
00033E2E  0000              add [eax],al
00033E30  00410E            add [ecx+0xe],al
00033E33  088502420D05      or [ebp+0x50d4202],al
00033E39  60                pushad
00033E3A  C50C04            lds ecx,[esp+eax]
00033E3D  0400              add al,0x0
00033E3F  001C00            add [eax+eax],bl
00033E42  0000              add [eax],al
00033E44  6C                insb
00033E45  0100              add [eax],eax
00033E47  00D0              add al,dl
00033E49  CE                into
00033E4A  FF                db 0xff
00033E4B  FF9B03000000      call dword far [ebx+0x3]
00033E51  41                inc ecx
00033E52  0E                push cs
00033E53  088502420D05      or [ebp+0x50d4202],al
00033E59  039703C50C04      add edx,[edi+0x40cc503]
00033E5F  041C              add al,0x1c
00033E61  0000              add [eax],al
00033E63  008C0100004BD2    add [ecx+eax-0x2db50000],cl
00033E6A  FF                db 0xff
00033E6B  FF7100            push dword [ecx+0x0]
00033E6E  0000              add [eax],al
00033E70  00410E            add [ecx+0xe],al
00033E73  088502420D05      or [ebp+0x50d4202],al
00033E79  026DC5            add ch,[ebp-0x3b]
00033E7C  0C04              or al,0x4
00033E7E  0400              add al,0x0
00033E80  1C00              sbb al,0x0
00033E82  0000              add [eax],al
00033E84  AC                lodsb
00033E85  0100              add [eax],eax
00033E87  009CD2FFFF4F00    add [edx+edx*8+0x4fffff],bl
00033E8E  0000              add [eax],al
00033E90  00410E            add [ecx+0xe],al
00033E93  088502420D05      or [ebp+0x50d4202],al
00033E99  024BC5            add cl,[ebx-0x3b]
00033E9C  0C04              or al,0x4
00033E9E  0400              add al,0x0
00033EA0  1C00              sbb al,0x0
00033EA2  0000              add [eax],al
00033EA4  CC                int3
00033EA5  0100              add [eax],eax
00033EA7  00CB              add bl,cl
00033EA9  D2FF              sar bh,cl
00033EAB  FF6D00            jmp dword far [ebp+0x0]
00033EAE  0000              add [eax],al
00033EB0  00410E            add [ecx+0xe],al
00033EB3  088502420D05      or [ebp+0x50d4202],al
00033EB9  0269C5            add ch,[ecx-0x3b]
00033EBC  0C04              or al,0x4
00033EBE  0400              add al,0x0
00033EC0  2C00              sub al,0x0
00033EC2  0000              add [eax],al
00033EC4  EC                in al,dx
00033EC5  0100              add [eax],eax
00033EC7  0018              add [eax],bl
00033EC9  D3FF              sar edi,cl
00033ECB  FF                db 0xff
00033ECC  3B01              cmp eax,[ecx]
00033ECE  0000              add [eax],al
00033ED0  00410E            add [ecx+0xe],al
00033ED3  088502420D05      or [ebp+0x50d4202],al
00033ED9  49                dec ecx
00033EDA  8703              xchg eax,[ebx]
00033EDC  860483            xchg al,[ebx+eax*4]
00033EDF  05032B01C3        add eax,0xc3012b03
00033EE4  41                inc ecx
00033EE5  C641C741          mov byte [ecx-0x39],0x41
00033EE9  C50C04            lds ecx,[esp+eax]
00033EEC  0400              add al,0x0
00033EEE  0000              add [eax],al
00033EF0  1C00              sbb al,0x0
00033EF2  0000              add [eax],al
00033EF4  1C02              sbb al,0x2
00033EF6  0000              add [eax],al
00033EF8  23D4              and edx,esp
00033EFA  FF                db 0xff
00033EFB  FF1F              call dword far [edi]
00033EFD  0000              add [eax],al
00033EFF  0000              add [eax],al
00033F01  41                inc ecx
00033F02  0E                push cs
00033F03  088502420D05      or [ebp+0x50d4202],al
00033F09  5B                pop ebx
00033F0A  C50C04            lds ecx,[esp+eax]
00033F0D  0400              add al,0x0
00033F0F  001C00            add [eax+eax],bl
00033F12  0000              add [eax],al
00033F14  3C02              cmp al,0x2
00033F16  0000              add [eax],al
00033F18  22D4              and dl,ah
00033F1A  FF                db 0xff
00033F1B  FF                db 0xff
00033F1C  3C00              cmp al,0x0
00033F1E  0000              add [eax],al
00033F20  00410E            add [ecx+0xe],al
00033F23  088502420D05      or [ebp+0x50d4202],al
00033F29  78C5              js 0x33ef0
00033F2B  0C04              or al,0x4
00033F2D  0400              add al,0x0
00033F2F  0020              add [eax],ah
00033F31  0000              add [eax],al
00033F33  005C0200          add [edx+eax+0x0],bl
00033F37  003E              add [esi],bh
00033F39  D4FF              aam 0xff
00033F3B  FF2F              jmp dword far [edi]
00033F3D  0000              add [eax],al
00033F3F  0000              add [eax],al
00033F41  41                inc ecx
00033F42  0E                push cs
00033F43  088502420D05      or [ebp+0x50d4202],al
00033F49  41                inc ecx
00033F4A  830369            add dword [ebx],byte +0x69
00033F4D  C3                ret
00033F4E  41                inc ecx
00033F4F  C50C04            lds ecx,[esp+eax]
00033F52  0400              add al,0x0
00033F54  1C00              sbb al,0x0
00033F56  0000              add [eax],al
00033F58  800200            add byte [edx],0x0
00033F5B  0049D4            add [ecx-0x2c],cl
00033F5E  FF                db 0xff
00033F5F  FF6A00            jmp dword far [edx+0x0]
00033F62  0000              add [eax],al
00033F64  00410E            add [ecx+0xe],al
00033F67  088502420D05      or [ebp+0x50d4202],al
00033F6D  0266C5            add ah,[esi-0x3b]
00033F70  0C04              or al,0x4
00033F72  0400              add al,0x0
00033F74  1C00              sbb al,0x0
00033F76  0000              add [eax],al
00033F78  A002000093        mov al,[0x93000002]
00033F7D  D4FF              aam 0xff
00033F7F  FFC4              inc esp
00033F81  0100              add [eax],eax
00033F83  0000              add [eax],al
00033F85  41                inc ecx
00033F86  0E                push cs
00033F87  088502420D05      or [ebp+0x50d4202],al
00033F8D  03C0              add eax,eax
00033F8F  01C5              add ebp,eax
00033F91  0C04              or al,0x4
00033F93  041C              add al,0x1c
00033F95  0000              add [eax],al
00033F97  00C0              add al,al
00033F99  0200              add al,[eax]
00033F9B  0037              add [edi],dh
00033F9D  D6                salc
00033F9E  FF                db 0xff
00033F9F  FF9100000000      call dword [ecx+0x0]
00033FA5  41                inc ecx
00033FA6  0E                push cs
00033FA7  088502420D05      or [ebp+0x50d4202],al
00033FAD  028DC50C0404      add cl,[ebp+0x4040cc5]
00033FB3  001C00            add [eax+eax],bl
00033FB6  0000              add [eax],al
00033FB8  E002              loopne 0x33fbc
00033FBA  0000              add [eax],al
00033FBC  A8D6              test al,0xd6
00033FBE  FF                db 0xff
00033FBF  FF0A              dec dword [edx]
00033FC1  0000              add [eax],al
00033FC3  0000              add [eax],al
00033FC5  41                inc ecx
00033FC6  0E                push cs
00033FC7  088502420D05      or [ebp+0x50d4202],al
00033FCD  46                inc esi
00033FCE  C50C04            lds ecx,[esp+eax]
00033FD1  0400              add al,0x0
00033FD3  001C00            add [eax+eax],bl
00033FD6  0000              add [eax],al
00033FD8  0003              add [ebx],al
00033FDA  0000              add [eax],al
00033FDC  92                xchg eax,edx
00033FDD  D6                salc
00033FDE  FF                db 0xff
00033FDF  FF20              jmp dword [eax]
00033FE1  0000              add [eax],al
00033FE3  0000              add [eax],al
00033FE5  41                inc ecx
00033FE6  0E                push cs
00033FE7  088502420D05      or [ebp+0x50d4202],al
00033FED  5C                pop esp
00033FEE  C50C04            lds ecx,[esp+eax]
00033FF1  0400              add al,0x0
00033FF3  001C00            add [eax+eax],bl
00033FF6  0000              add [eax],al
00033FF8  2003              and [ebx],al
00033FFA  0000              add [eax],al
00033FFC  92                xchg eax,edx
00033FFD  D6                salc
00033FFE  FF                db 0xff
00033FFF  FF2F              jmp dword far [edi]
00034001  0000              add [eax],al
00034003  0000              add [eax],al
00034005  41                inc ecx
00034006  0E                push cs
00034007  088502420D05      or [ebp+0x50d4202],al
0003400D  6BC50C            imul eax,ebp,byte +0xc
00034010  0404              add al,0x4
00034012  0000              add [eax],al
00034014  1C00              sbb al,0x0
00034016  0000              add [eax],al
00034018  40                inc eax
00034019  0300              add eax,[eax]
0003401B  00A1D6FFFF94      add [ecx-0x6b00002a],ah
00034021  0000              add [eax],al
00034023  0000              add [eax],al
00034025  41                inc ecx
00034026  0E                push cs
00034027  088502420D05      or [ebp+0x50d4202],al
0003402D  0290C50C0404      add dl,[eax+0x4040cc5]
00034033  001C00            add [eax+eax],bl
00034036  0000              add [eax],al
00034038  60                pushad
00034039  0300              add eax,[eax]
0003403B  0015D7FFFF94      add [dword 0x94ffffd7],dl
00034041  0000              add [eax],al
00034043  0000              add [eax],al
00034045  41                inc ecx
00034046  0E                push cs
00034047  088502420D05      or [ebp+0x50d4202],al
0003404D  0290C50C0404      add dl,[eax+0x4040cc5]
00034053  001C00            add [eax+eax],bl
00034056  0000              add [eax],al
00034058  800300            add byte [ebx],0x0
0003405B  0089D7FFFF80      add [ecx-0x7f000029],cl
00034061  0100              add [eax],eax
00034063  0000              add [eax],al
00034065  41                inc ecx
00034066  0E                push cs
00034067  088502420D05      or [ebp+0x50d4202],al
0003406D  037C01C5          add edi,[ecx+eax-0x3b]
00034071  0C04              or al,0x4
00034073  041C              add al,0x1c
00034075  0000              add [eax],al
00034077  00A0030000E9      add [eax-0x16fffffd],ah
0003407D  D8FF              fdivr st7
0003407F  FFB500000000      push dword [ebp+0x0]
00034085  41                inc ecx
00034086  0E                push cs
00034087  088502420D05      or [ebp+0x50d4202],al
0003408D  02B1C50C0404      add dh,[ecx+0x4040cc5]
00034093  001C00            add [eax+eax],bl
00034096  0000              add [eax],al
00034098  C00300            rol byte [ebx],byte 0x0
0003409B  007ED9            add [esi-0x27],bh
0003409E  FF                db 0xff
0003409F  FF5A00            call dword far [edx+0x0]
000340A2  0000              add [eax],al
000340A4  00410E            add [ecx+0xe],al
000340A7  088502420D05      or [ebp+0x50d4202],al
000340AD  0256C5            add dl,[esi-0x3b]
000340B0  0C04              or al,0x4
000340B2  0400              add al,0x0
000340B4  1C00              sbb al,0x0
000340B6  0000              add [eax],al
000340B8  E003              loopne 0x340bd
000340BA  0000              add [eax],al
000340BC  B8D9FFFF14        mov eax,0x14ffffd9
000340C1  0200              add al,[eax]
000340C3  0000              add [eax],al
000340C5  41                inc ecx
000340C6  0E                push cs
000340C7  088502420D05      or [ebp+0x50d4202],al
000340CD  0310              add edx,[eax]
000340CF  02C5              add al,ch
000340D1  0C04              or al,0x4
000340D3  041C              add al,0x1c
000340D5  0000              add [eax],al
000340D7  0000              add [eax],al
000340D9  0400              add al,0x0
000340DB  00ACDBFFFF1501    add [ebx+ebx*8+0x115ffff],ch
000340E2  0000              add [eax],al
000340E4  00410E            add [ecx+0xe],al
000340E7  088502420D05      or [ebp+0x50d4202],al
000340ED  0311              add edx,[ecx]
000340EF  01C5              add ebp,eax
000340F1  0C04              or al,0x4
000340F3  041C              add al,0x1c
000340F5  0000              add [eax],al
000340F7  0020              add [eax],ah
000340F9  0400              add al,0x0
000340FB  00CE              add dh,cl
000340FD  DEFF              fdivp st7
000340FF  FF27              jmp dword [edi]
00034101  0000              add [eax],al
00034103  0000              add [eax],al
00034105  41                inc ecx
00034106  0E                push cs
00034107  088502420D05      or [ebp+0x50d4202],al
0003410D  63C5              arpl bp,ax
0003410F  0C04              or al,0x4
00034111  0400              add al,0x0
00034113  0020              add [eax],ah
00034115  0000              add [eax],al
00034117  004004            add [eax+0x4],al
0003411A  0000              add [eax],al
0003411C  D5DE              aad 0xde
0003411E  FF                db 0xff
0003411F  FF2E              jmp dword far [esi]
00034121  0200              add al,[eax]
00034123  0000              add [eax],al
00034125  41                inc ecx
00034126  0E                push cs
00034127  088502420D05      or [ebp+0x50d4202],al
0003412D  44                inc esp
0003412E  830303            add dword [ebx],byte +0x3
00034131  2602C5            es add al,ch
00034134  C3                ret
00034135  0C04              or al,0x4
00034137  041C              add al,0x1c
00034139  0000              add [eax],al
0003413B  00640400          add [esp+eax+0x0],ah
0003413F  00DF              add bh,bl
00034141  E0FF              loopne 0x34142
00034143  FF6000            jmp dword [eax+0x0]
00034146  0000              add [eax],al
00034148  00410E            add [ecx+0xe],al
0003414B  088502420D05      or [ebp+0x50d4202],al
00034151  025CC50C          add bl,[ebp+eax*8+0xc]
00034155  0404              add al,0x4
00034157  001C00            add [eax+eax],bl
0003415A  0000              add [eax],al
0003415C  840400            test [eax+eax],al
0003415F  001F              add [edi],bl
00034161  E1FF              loope 0x34162
00034163  FFA500000000      jmp dword [ebp+0x0]
00034169  41                inc ecx
0003416A  0E                push cs
0003416B  088502420D05      or [ebp+0x50d4202],al
00034171  02A1C50C0404      add ah,[ecx+0x4040cc5]
00034177  001C00            add [eax+eax],bl
0003417A  0000              add [eax],al
0003417C  A4                movsb
0003417D  0400              add al,0x0
0003417F  00A4E1FFFF8404    add [ecx+0x484ffff],ah
00034186  0000              add [eax],al
00034188  00410E            add [ecx+0xe],al
0003418B  088502420D05      or [ebp+0x50d4202],al
00034191  038004C50C04      add eax,[eax+0x40cc504]
00034197  041C              add al,0x1c
00034199  0000              add [eax],al
0003419B  00C4              add ah,al
0003419D  0400              add al,0x0
0003419F  0008              add [eax],cl
000341A1  E6FF              out 0xff,al
000341A3  FF5D00            call dword far [ebp+0x0]
000341A6  0000              add [eax],al
000341A8  00410E            add [ecx+0xe],al
000341AB  088502420D05      or [ebp+0x50d4202],al
000341B1  0259C5            add bl,[ecx-0x3b]
000341B4  0C04              or al,0x4
000341B6  0400              add al,0x0
000341B8  1C00              sbb al,0x0
000341BA  0000              add [eax],al
000341BC  E404              in al,0x4
000341BE  0000              add [eax],al
000341C0  45                inc ebp
000341C1  E6FF              out 0xff,al
000341C3  FF2400            jmp dword [eax+eax]
000341C6  0000              add [eax],al
000341C8  00410E            add [ecx+0xe],al
000341CB  088502420D05      or [ebp+0x50d4202],al
000341D1  60                pushad
000341D2  C50C04            lds ecx,[esp+eax]
000341D5  0400              add al,0x0
000341D7  001C00            add [eax+eax],bl
000341DA  0000              add [eax],al
000341DC  0405              add al,0x5
000341DE  0000              add [eax],al
000341E0  49                dec ecx
000341E1  E6FF              out 0xff,al
000341E3  FF1D00000000      call dword far [dword 0x0]
000341E9  41                inc ecx
000341EA  0E                push cs
000341EB  088502420D05      or [ebp+0x50d4202],al
000341F1  59                pop ecx
000341F2  C50C04            lds ecx,[esp+eax]
000341F5  0400              add al,0x0
000341F7  001C00            add [eax+eax],bl
000341FA  0000              add [eax],al
000341FC  2405              and al,0x5
000341FE  0000              add [eax],al
00034200  46                inc esi
00034201  E6FF              out 0xff,al
00034203  FF5E00            call dword far [esi+0x0]
00034206  0000              add [eax],al
00034208  00410E            add [ecx+0xe],al
0003420B  088502420D05      or [ebp+0x50d4202],al
00034211  025AC5            add bl,[edx-0x3b]
00034214  0C04              or al,0x4
00034216  0400              add al,0x0
00034218  1800              sbb [eax],al
0003421A  0000              add [eax],al
0003421C  44                inc esp
0003421D  05000084E6        add eax,0xe6840000
00034222  FF                db 0xff
00034223  FF                db 0xff
00034224  7800              js 0x34226
00034226  0000              add [eax],al
00034228  00410E            add [ecx+0xe],al
0003422B  088502420D05      or [ebp+0x50d4202],al
00034231  0000              add [eax],al
00034233  001C00            add [eax+eax],bl
00034236  0000              add [eax],al
00034238  60                pushad
00034239  050000E0E6        add eax,0xe6e00000
0003423E  FF                db 0xff
0003423F  FF                db 0xff
00034240  7A00              jpe 0x34242
00034242  0000              add [eax],al
00034244  00410E            add [ecx+0xe],al
00034247  088502420D05      or [ebp+0x50d4202],al
0003424D  0276C5            add dh,[esi-0x3b]
00034250  0C04              or al,0x4
00034252  0400              add al,0x0
00034254  1C00              sbb al,0x0
00034256  0000              add [eax],al
00034258  800500003AE7FF    add byte [dword 0xe73a0000],0xff
0003425F  FF1C01            call dword far [ecx+eax]
00034262  0000              add [eax],al
00034264  00410E            add [ecx+0xe],al
00034267  088502420D05      or [ebp+0x50d4202],al
0003426D  0318              add ebx,[eax]
0003426F  01C5              add ebp,eax
00034271  0C04              or al,0x4
00034273  041C              add al,0x1c
00034275  0000              add [eax],al
00034277  00A005000036      add [eax+0x36000005],ah
0003427D  E8FFFF7000        call dword 0x744281
00034282  0000              add [eax],al
00034284  00410E            add [ecx+0xe],al
00034287  088502420D05      or [ebp+0x50d4202],al
0003428D  026CC50C          add ch,[ebp+eax*8+0xc]
00034291  0404              add al,0x4
00034293  001C00            add [eax+eax],bl
00034296  0000              add [eax],al
00034298  C005000086E8FF    rol byte [dword 0xe8860000],byte 0xff
0003429F  FF30              push dword [eax]
000342A1  0000              add [eax],al
000342A3  0000              add [eax],al
000342A5  41                inc ecx
000342A6  0E                push cs
000342A7  088502420D05      or [ebp+0x50d4202],al
000342AD  6C                insb
000342AE  C50C04            lds ecx,[esp+eax]
000342B1  0400              add al,0x0
000342B3  001C00            add [eax+eax],bl
000342B6  0000              add [eax],al
000342B8  E005              loopne 0x342bf
000342BA  0000              add [eax],al
000342BC  96                xchg eax,esi
000342BD  E8FFFF8A00        call dword 0x8e42c1
000342C2  0000              add [eax],al
000342C4  00410E            add [ecx+0xe],al
000342C7  088502420D05      or [ebp+0x50d4202],al
000342CD  0286C50C0404      add al,[esi+0x4040cc5]
000342D3  001C00            add [eax+eax],bl
000342D6  0000              add [eax],al
000342D8  0006              add [esi],al
000342DA  0000              add [eax],al
000342DC  00E9              add cl,ch
000342DE  FF                db 0xff
000342DF  FF4600            inc dword [esi+0x0]
000342E2  0000              add [eax],al
000342E4  00410E            add [ecx+0xe],al
000342E7  088502420D05      or [ebp+0x50d4202],al
000342ED  0242C5            add al,[edx-0x3b]
000342F0  0C04              or al,0x4
000342F2  0400              add al,0x0
000342F4  1C00              sbb al,0x0
000342F6  0000              add [eax],al
000342F8  2006              and [esi],al
000342FA  0000              add [eax],al
000342FC  26E9FFFF3000      es jmp dword 0x344301
00034302  0000              add [eax],al
00034304  00410E            add [ecx+0xe],al
00034307  088502420D05      or [ebp+0x50d4202],al
0003430D  6C                insb
0003430E  C50C04            lds ecx,[esp+eax]
00034311  0400              add al,0x0
00034313  001C00            add [eax+eax],bl
00034316  0000              add [eax],al
00034318  40                inc eax
00034319  06                push es
0003431A  0000              add [eax],al
0003431C  36E9FFFF4101      ss jmp dword 0x1454321
00034322  0000              add [eax],al
00034324  00410E            add [ecx+0xe],al
00034327  088502420D05      or [ebp+0x50d4202],al
0003432D  033D01C50C04      add edi,[dword 0x40cc501]
00034333  041C              add al,0x1c
00034335  0000              add [eax],al
00034337  006006            add [eax+0x6],ah
0003433A  0000              add [eax],al
0003433C  57                push edi
0003433D  EAFFFF1B000000    jmp dword 0x0:0x1bffff
00034344  00410E            add [ecx+0xe],al
00034347  088502420D05      or [ebp+0x50d4202],al
0003434D  57                push edi
0003434E  C50C04            lds ecx,[esp+eax]
00034351  0400              add al,0x0
00034353  001C00            add [eax+eax],bl
00034356  0000              add [eax],al
00034358  800600            add byte [esi],0x0
0003435B  0052EA            add [edx-0x16],dl
0003435E  FF                db 0xff
0003435F  FF5D02            call dword far [ebp+0x2]
00034362  0000              add [eax],al
00034364  00410E            add [ecx+0xe],al
00034367  088502420D05      or [ebp+0x50d4202],al
0003436D  035902            add ebx,[ecx+0x2]
00034370  C50C04            lds ecx,[esp+eax]
00034373  041C              add al,0x1c
00034375  0000              add [eax],al
00034377  00A00600008F      add [eax-0x70fffffa],ah
0003437D  EC                in al,dx
0003437E  FF                db 0xff
0003437F  FF                db 0xff
00034380  3B00              cmp eax,[eax]
00034382  0000              add [eax],al
00034384  00410E            add [ecx+0xe],al
00034387  088502420D05      or [ebp+0x50d4202],al
0003438D  77C5              ja 0x34354
0003438F  0C04              or al,0x4
00034391  0400              add al,0x0
00034393  001C00            add [eax+eax],bl
00034396  0000              add [eax],al
00034398  C00600            rol byte [esi],byte 0x0
0003439B  00AAECFFFF68      add [edx+0x68ffffec],ch
000343A1  0000              add [eax],al
000343A3  0000              add [eax],al
000343A5  41                inc ecx
000343A6  0E                push cs
000343A7  088502420D05      or [ebp+0x50d4202],al
000343AD  0264C50C          add ah,[ebp+eax*8+0xc]
000343B1  0404              add al,0x4
000343B3  001C00            add [eax+eax],bl
000343B6  0000              add [eax],al
000343B8  E006              loopne 0x343c0
000343BA  0000              add [eax],al
000343BC  F2EC              repne in al,dx
000343BE  FF                db 0xff
000343BF  FF6800            jmp dword far [eax+0x0]
000343C2  0000              add [eax],al
000343C4  00410E            add [ecx+0xe],al
000343C7  088502420D05      or [ebp+0x50d4202],al
000343CD  0264C50C          add ah,[ebp+eax*8+0xc]
000343D1  0404              add al,0x4
000343D3  001C00            add [eax+eax],bl
000343D6  0000              add [eax],al
000343D8  0007              add [edi],al
000343DA  0000              add [eax],al
000343DC  3AED              cmp ch,ch
000343DE  FF                db 0xff
000343DF  FF36              push dword [esi]
000343E1  0000              add [eax],al
000343E3  0000              add [eax],al
000343E5  41                inc ecx
000343E6  0E                push cs
000343E7  088502420D05      or [ebp+0x50d4202],al
000343ED  72C5              jc 0x343b4
000343EF  0C04              or al,0x4
000343F1  0400              add al,0x0
000343F3  001C00            add [eax+eax],bl
000343F6  0000              add [eax],al
000343F8  2007              and [edi],al
000343FA  0000              add [eax],al
000343FC  50                push eax
000343FD  ED                in eax,dx
000343FE  FF                db 0xff
000343FF  FF6B00            jmp dword far [ebx+0x0]
00034402  0000              add [eax],al
00034404  00410E            add [ecx+0xe],al
00034407  088502420D05      or [ebp+0x50d4202],al
0003440D  0267C5            add ah,[edi-0x3b]
00034410  0C04              or al,0x4
00034412  0400              add al,0x0
00034414  1C00              sbb al,0x0
00034416  0000              add [eax],al
00034418  40                inc eax
00034419  07                pop es
0003441A  0000              add [eax],al
0003441C  9BED              wait in eax,dx
0003441E  FF                db 0xff
0003441F  FF4500            inc dword [ebp+0x0]
00034422  0000              add [eax],al
00034424  00410E            add [ecx+0xe],al
00034427  088502420D05      or [ebp+0x50d4202],al
0003442D  0241C5            add al,[ecx-0x3b]
00034430  0C04              or al,0x4
00034432  0400              add al,0x0
00034434  1C00              sbb al,0x0
00034436  0000              add [eax],al
00034438  60                pushad
00034439  07                pop es
0003443A  0000              add [eax],al
0003443C  C0EDFF            shr ch,byte 0xff
0003443F  FFE6              jmp esi
00034441  0000              add [eax],al
00034443  0000              add [eax],al
00034445  41                inc ecx
00034446  0E                push cs
00034447  088502420D05      or [ebp+0x50d4202],al
0003444D  02E2              add ah,dl
0003444F  C50C04            lds ecx,[esp+eax]
00034452  0400              add al,0x0
00034454  1C00              sbb al,0x0
00034456  0000              add [eax],al
00034458  800700            add byte [edi],0x0
0003445B  007FEF            add [edi-0x11],bh
0003445E  FF                db 0xff
0003445F  FFAB00000000      jmp dword far [ebx+0x0]
00034465  41                inc ecx
00034466  0E                push cs
00034467  088502420D05      or [ebp+0x50d4202],al
0003446D  02A7C50C0404      add ah,[edi+0x4040cc5]
00034473  001C00            add [eax+eax],bl
00034476  0000              add [eax],al
00034478  A00700000A        mov al,[0xa000007]
0003447D  F0                lock
0003447E  FF                db 0xff
0003447F  FF27              jmp dword [edi]
00034481  0000              add [eax],al
00034483  0000              add [eax],al
00034485  41                inc ecx
00034486  0E                push cs
00034487  088502420D05      or [ebp+0x50d4202],al
0003448D  63C5              arpl bp,ax
0003448F  0C04              or al,0x4
00034491  0400              add al,0x0
00034493  001C00            add [eax+eax],bl
00034496  0000              add [eax],al
00034498  C00700            rol byte [edi],byte 0x0
0003449B  0011              add [ecx],dl
0003449D  F0                lock
0003449E  FF                db 0xff
0003449F  FF4700            inc dword [edi+0x0]
000344A2  0000              add [eax],al
000344A4  00410E            add [ecx+0xe],al
000344A7  088502420D05      or [ebp+0x50d4202],al
000344AD  0243C5            add al,[ebx-0x3b]
000344B0  0C04              or al,0x4
000344B2  0400              add al,0x0
000344B4  0000              add [eax],al
000344B6  0000              add [eax],al
000344B8  0000              add [eax],al
000344BA  0000              add [eax],al
000344BC  0000              add [eax],al
000344BE  0000              add [eax],al
000344C0  5E                pop esi
000344C1  0000              add [eax],al
000344C3  0000              add [eax],al
000344C5  0000              add [eax],al
000344C7  0000              add [eax],al
000344C9  0000              add [eax],al
000344CB  0000              add [eax],al
000344CD  0000              add [eax],al
000344CF  0000              add [eax],al
000344D1  0000              add [eax],al
000344D3  0000              add [eax],al
000344D5  0000              add [eax],al
000344D7  0000              add [eax],al
000344D9  0000              add [eax],al
000344DB  0000              add [eax],al
000344DD  0000              add [eax],al
000344DF  00A42803000080    add [eax+ebp-0x7ffffffd],ah
000344E6  0000              add [eax],al
000344E8  7474              jz 0x3455e
000344EA  7900              jns 0x344ec
000344EC  0000              add [eax],al
000344EE  0000              add [eax],al
000344F0  0000              add [eax],al
000344F2  0000              add [eax],al
000344F4  0000              add [eax],al
000344F6  0000              add [eax],al
000344F8  0000              add [eax],al
000344FA  0000              add [eax],al
000344FC  0000              add [eax],al
000344FE  0000              add [eax],al
00034500  0000              add [eax],al
00034502  0000              add [eax],al
00034504  0000              add [eax],al
00034506  0000              add [eax],al
00034508  0000              add [eax],al
0003450A  0000              add [eax],al
0003450C  0000              add [eax],al
0003450E  0000              add [eax],al
00034510  0000              add [eax],al
00034512  0000              add [eax],al
00034514  0000              add [eax],al
00034516  0000              add [eax],al
00034518  0000              add [eax],al
0003451A  0000              add [eax],al
0003451C  0000              add [eax],al
0003451E  0000              add [eax],al
00034520  E709              out 0x9,eax
00034522  0300              add eax,[eax]
00034524  008000005465      add [eax+0x65540000],al
0003452A  7374              jnc 0x345a0
0003452C  41                inc ecx
0003452D  0000              add [eax],al
0003452F  0000              add [eax],al
00034531  0000              add [eax],al
00034533  0000              add [eax],al
00034535  0000              add [eax],al
00034537  0000              add [eax],al
00034539  0000              add [eax],al
0003453B  0000              add [eax],al
0003453D  0000              add [eax],al
0003453F  0000              add [eax],al
00034541  0000              add [eax],al
00034543  0000              add [eax],al
00034545  0000              add [eax],al
00034547  0013              add [ebx],dl
00034549  0A03              or al,[ebx]
0003454B  0000              add [eax],al
0003454D  800000            add byte [eax],0x0
00034550  54                push esp
00034551  657374            gs jnc 0x345c8
00034554  42                inc edx
00034555  0000              add [eax],al
00034557  0000              add [eax],al
00034559  0000              add [eax],al
0003455B  0000              add [eax],al
0003455D  0000              add [eax],al
0003455F  0000              add [eax],al
00034561  0000              add [eax],al
00034563  0000              add [eax],al
00034565  0000              add [eax],al
00034567  0000              add [eax],al
00034569  0000              add [eax],al
0003456B  0000              add [eax],al
0003456D  0000              add [eax],al
0003456F  003F              add [edi],bh
00034571  0A03              or al,[ebx]
00034573  0000              add [eax],al
00034575  800000            add byte [eax],0x0
00034578  54                push esp
00034579  657374            gs jnc 0x345f0
0003457C  43                inc ebx
0003457D  0000              add [eax],al
0003457F  0000              add [eax],al
00034581  0000              add [eax],al
00034583  0000              add [eax],al
00034585  0000              add [eax],al
00034587  0000              add [eax],al
00034589  0000              add [eax],al
0003458B  0000              add [eax],al
0003458D  0000              add [eax],al
0003458F  0000              add [eax],al
00034591  0000              add [eax],al
00034593  0000              add [eax],al
00034595  0000              add [eax],al
00034597  00641603          add [esi+edx+0x3],ah
0003459B  0022              add [edx],ah
0003459D  2C03              sub al,0x3
0003459F  0060EA            add [eax-0x16],ah
000345A2  0000              add [eax],al
000345A4  4C                dec esp
000345A5  1D00000800        sbb eax,0x80000
000345AA  0000              add [eax],al
000345AC  0300              add eax,[eax]
000345AE  0000              add [eax],al
000345B0  0000              add [eax],al
000345B2  0000              add [eax],al
000345B4  0000              add [eax],al
000345B6  0000              add [eax],al
000345B8  B055              mov al,0x55
000345BA  0300              add eax,[eax]
000345BC  B055              mov al,0x55
000345BE  0300              add eax,[eax]
000345C0  0000              add [eax],al
000345C2  0000              add [eax],al
000345C4  0000              add [eax],al
000345C6  0000              add [eax],al
000345C8  B055              mov al,0x55
000345CA  0300              add eax,[eax]
000345CC  0000              add [eax],al
000345CE  0000              add [eax],al
000345D0  0000              add [eax],al
000345D2  0000              add [eax],al
000345D4  0000              add [eax],al
000345D6  0000              add [eax],al
000345D8  0000              add [eax],al
000345DA  0000              add [eax],al
000345DC  0000              add [eax],al
000345DE  0000              add [eax],al
000345E0  0000              add [eax],al
000345E2  0000              add [eax],al
000345E4  0000              add [eax],al
000345E6  0000              add [eax],al
000345E8  0000              add [eax],al
000345EA  0000              add [eax],al
000345EC  0101              add [ecx],eax
000345EE  0000              add [eax],al
000345F0  0101              add [ecx],eax
000345F2  0000              add [eax],al
000345F4  0000              add [eax],al
000345F6  0000              add [eax],al
000345F8  3100              xor [eax],eax
000345FA  0000              add [eax],al
000345FC  2100              and [eax],eax
000345FE  0000              add [eax],al
00034600  0000              add [eax],al
00034602  0000              add [eax],al
00034604  3200              xor al,[eax]
00034606  0000              add [eax],al
00034608  40                inc eax
00034609  0000              add [eax],al
0003460B  0000              add [eax],al
0003460D  0000              add [eax],al
0003460F  0033              add [ebx],dh
00034611  0000              add [eax],al
00034613  0023              add [ebx],ah
00034615  0000              add [eax],al
00034617  0000              add [eax],al
00034619  0000              add [eax],al
0003461B  003400            add [eax+eax],dh
0003461E  0000              add [eax],al
00034620  2400              and al,0x0
00034622  0000              add [eax],al
00034624  0000              add [eax],al
00034626  0000              add [eax],al
00034628  3500000025        xor eax,0x25000000
0003462D  0000              add [eax],al
0003462F  0000              add [eax],al
00034631  0000              add [eax],al
00034633  0036              add [esi],dh
00034635  0000              add [eax],al
00034637  005E00            add [esi+0x0],bl
0003463A  0000              add [eax],al
0003463C  0000              add [eax],al
0003463E  0000              add [eax],al
00034640  37                aaa
00034641  0000              add [eax],al
00034643  0026              add [esi],ah
00034645  0000              add [eax],al
00034647  0000              add [eax],al
00034649  0000              add [eax],al
0003464B  0038              add [eax],bh
0003464D  0000              add [eax],al
0003464F  002A              add [edx],ch
00034651  0000              add [eax],al
00034653  0000              add [eax],al
00034655  0000              add [eax],al
00034657  0039              add [ecx],bh
00034659  0000              add [eax],al
0003465B  0028              add [eax],ch
0003465D  0000              add [eax],al
0003465F  0000              add [eax],al
00034661  0000              add [eax],al
00034663  0030              add [eax],dh
00034665  0000              add [eax],al
00034667  0029              add [ecx],ch
00034669  0000              add [eax],al
0003466B  0000              add [eax],al
0003466D  0000              add [eax],al
0003466F  002D0000005F      add [dword 0x5f000000],ch
00034675  0000              add [eax],al
00034677  0000              add [eax],al
00034679  0000              add [eax],al
0003467B  003D0000002B      add [dword 0x2b000000],bh
00034681  0000              add [eax],al
00034683  0000              add [eax],al
00034685  0000              add [eax],al
00034687  000401            add [ecx+eax],al
0003468A  0000              add [eax],al
0003468C  0401              add al,0x1
0003468E  0000              add [eax],al
00034690  0000              add [eax],al
00034692  0000              add [eax],al
00034694  0201              add al,[ecx]
00034696  0000              add [eax],al
00034698  0201              add al,[ecx]
0003469A  0000              add [eax],al
0003469C  0000              add [eax],al
0003469E  0000              add [eax],al
000346A0  7100              jno 0x346a2
000346A2  0000              add [eax],al
000346A4  51                push ecx
000346A5  0000              add [eax],al
000346A7  0000              add [eax],al
000346A9  0000              add [eax],al
000346AB  007700            add [edi+0x0],dh
000346AE  0000              add [eax],al
000346B0  57                push edi
000346B1  0000              add [eax],al
000346B3  0000              add [eax],al
000346B5  0000              add [eax],al
000346B7  006500            add [ebp+0x0],ah
000346BA  0000              add [eax],al
000346BC  45                inc ebp
000346BD  0000              add [eax],al
000346BF  0000              add [eax],al
000346C1  0000              add [eax],al
000346C3  007200            add [edx+0x0],dh
000346C6  0000              add [eax],al
000346C8  52                push edx
000346C9  0000              add [eax],al
000346CB  0000              add [eax],al
000346CD  0000              add [eax],al
000346CF  00740000          add [eax+eax+0x0],dh
000346D3  00540000          add [eax+eax+0x0],dl
000346D7  0000              add [eax],al
000346D9  0000              add [eax],al
000346DB  007900            add [ecx+0x0],bh
000346DE  0000              add [eax],al
000346E0  59                pop ecx
000346E1  0000              add [eax],al
000346E3  0000              add [eax],al
000346E5  0000              add [eax],al
000346E7  007500            add [ebp+0x0],dh
000346EA  0000              add [eax],al
000346EC  55                push ebp
000346ED  0000              add [eax],al
000346EF  0000              add [eax],al
000346F1  0000              add [eax],al
000346F3  006900            add [ecx+0x0],ch
000346F6  0000              add [eax],al
000346F8  49                dec ecx
000346F9  0000              add [eax],al
000346FB  0000              add [eax],al
000346FD  0000              add [eax],al
000346FF  006F00            add [edi+0x0],ch
00034702  0000              add [eax],al
00034704  4F                dec edi
00034705  0000              add [eax],al
00034707  0000              add [eax],al
00034709  0000              add [eax],al
0003470B  007000            add [eax+0x0],dh
0003470E  0000              add [eax],al
00034710  50                push eax
00034711  0000              add [eax],al
00034713  0000              add [eax],al
00034715  0000              add [eax],al
00034717  005B00            add [ebx+0x0],bl
0003471A  0000              add [eax],al
0003471C  7B00              jpo 0x3471e
0003471E  0000              add [eax],al
00034720  0000              add [eax],al
00034722  0000              add [eax],al
00034724  5D                pop ebp
00034725  0000              add [eax],al
00034727  007D00            add [ebp+0x0],bh
0003472A  0000              add [eax],al
0003472C  0000              add [eax],al
0003472E  0000              add [eax],al
00034730  0301              add eax,[ecx]
00034732  0000              add [eax],al
00034734  0301              add eax,[ecx]
00034736  0000              add [eax],al
00034738  3001              xor [ecx],al
0003473A  0000              add [eax],al
0003473C  0A01              or al,[ecx]
0003473E  0000              add [eax],al
00034740  0A01              or al,[ecx]
00034742  0000              add [eax],al
00034744  0B01              or eax,[ecx]
00034746  0000              add [eax],al
00034748  61                popad
00034749  0000              add [eax],al
0003474B  004100            add [ecx+0x0],al
0003474E  0000              add [eax],al
00034750  0000              add [eax],al
00034752  0000              add [eax],al
00034754  7300              jnc 0x34756
00034756  0000              add [eax],al
00034758  53                push ebx
00034759  0000              add [eax],al
0003475B  0000              add [eax],al
0003475D  0000              add [eax],al
0003475F  00640000          add [eax+eax+0x0],ah
00034763  00440000          add [eax+eax+0x0],al
00034767  0000              add [eax],al
00034769  0000              add [eax],al
0003476B  006600            add [esi+0x0],ah
0003476E  0000              add [eax],al
00034770  46                inc esi
00034771  0000              add [eax],al
00034773  0000              add [eax],al
00034775  0000              add [eax],al
00034777  006700            add [edi+0x0],ah
0003477A  0000              add [eax],al
0003477C  47                inc edi
0003477D  0000              add [eax],al
0003477F  0000              add [eax],al
00034781  0000              add [eax],al
00034783  006800            add [eax+0x0],ch
00034786  0000              add [eax],al
00034788  48                dec eax
00034789  0000              add [eax],al
0003478B  0000              add [eax],al
0003478D  0000              add [eax],al
0003478F  006A00            add [edx+0x0],ch
00034792  0000              add [eax],al
00034794  4A                dec edx
00034795  0000              add [eax],al
00034797  0000              add [eax],al
00034799  0000              add [eax],al
0003479B  006B00            add [ebx+0x0],ch
0003479E  0000              add [eax],al
000347A0  4B                dec ebx
000347A1  0000              add [eax],al
000347A3  0000              add [eax],al
000347A5  0000              add [eax],al
000347A7  006C0000          add [eax+eax+0x0],ch
000347AB  004C0000          add [eax+eax+0x0],cl
000347AF  0000              add [eax],al
000347B1  0000              add [eax],al
000347B3  003B              add [ebx],bh
000347B5  0000              add [eax],al
000347B7  003A              add [edx],bh
000347B9  0000              add [eax],al
000347BB  0000              add [eax],al
000347BD  0000              add [eax],al
000347BF  0027              add [edi],ah
000347C1  0000              add [eax],al
000347C3  0022              add [edx],ah
000347C5  0000              add [eax],al
000347C7  0000              add [eax],al
000347C9  0000              add [eax],al
000347CB  006000            add [eax+0x0],ah
000347CE  0000              add [eax],al
000347D0  7E00              jng 0x347d2
000347D2  0000              add [eax],al
000347D4  0000              add [eax],al
000347D6  0000              add [eax],al
000347D8  0801              or [ecx],al
000347DA  0000              add [eax],al
000347DC  0801              or [ecx],al
000347DE  0000              add [eax],al
000347E0  0000              add [eax],al
000347E2  0000              add [eax],al
000347E4  5C                pop esp
000347E5  0000              add [eax],al
000347E7  007C0000          add [eax+eax+0x0],bh
000347EB  0000              add [eax],al
000347ED  0000              add [eax],al
000347EF  007A00            add [edx+0x0],bh
000347F2  0000              add [eax],al
000347F4  5A                pop edx
000347F5  0000              add [eax],al
000347F7  0000              add [eax],al
000347F9  0000              add [eax],al
000347FB  007800            add [eax+0x0],bh
000347FE  0000              add [eax],al
00034800  58                pop eax
00034801  0000              add [eax],al
00034803  0000              add [eax],al
00034805  0000              add [eax],al
00034807  006300            add [ebx+0x0],ah
0003480A  0000              add [eax],al
0003480C  43                inc ebx
0003480D  0000              add [eax],al
0003480F  0000              add [eax],al
00034811  0000              add [eax],al
00034813  007600            add [esi+0x0],dh
00034816  0000              add [eax],al
00034818  56                push esi
00034819  0000              add [eax],al
0003481B  0000              add [eax],al
0003481D  0000              add [eax],al
0003481F  006200            add [edx+0x0],ah
00034822  0000              add [eax],al
00034824  42                inc edx
00034825  0000              add [eax],al
00034827  0000              add [eax],al
00034829  0000              add [eax],al
0003482B  006E00            add [esi+0x0],ch
0003482E  0000              add [eax],al
00034830  4E                dec esi
00034831  0000              add [eax],al
00034833  0000              add [eax],al
00034835  0000              add [eax],al
00034837  006D00            add [ebp+0x0],ch
0003483A  0000              add [eax],al
0003483C  4D                dec ebp
0003483D  0000              add [eax],al
0003483F  0000              add [eax],al
00034841  0000              add [eax],al
00034843  002C00            add [eax+eax],ch
00034846  0000              add [eax],al
00034848  3C00              cmp al,0x0
0003484A  0000              add [eax],al
0003484C  0000              add [eax],al
0003484E  0000              add [eax],al
00034850  2E0000            add [cs:eax],al
00034853  003E              add [esi],bh
00034855  0000              add [eax],al
00034857  0000              add [eax],al
00034859  0000              add [eax],al
0003485B  002F              add [edi],ch
0003485D  0000              add [eax],al
0003485F  003F              add [edi],bh
00034861  0000              add [eax],al
00034863  002C01            add [ecx+eax],ch
00034866  0000              add [eax],al
00034868  0901              or [ecx],eax
0003486A  0000              add [eax],al
0003486C  0901              or [ecx],eax
0003486E  0000              add [eax],al
00034870  0000              add [eax],al
00034872  0000              add [eax],al
00034874  2A00              sub al,[eax]
00034876  0000              add [eax],al
00034878  2A00              sub al,[eax]
0003487A  0000              add [eax],al
0003487C  0000              add [eax],al
0003487E  0000              add [eax],al
00034880  0C01              or al,0x1
00034882  0000              add [eax],al
00034884  0C01              or al,0x1
00034886  0000              add [eax],al
00034888  0D01000020        or eax,0x20000001
0003488D  0000              add [eax],al
0003488F  0020              add [eax],ah
00034891  0000              add [eax],al
00034893  0000              add [eax],al
00034895  0000              add [eax],al
00034897  000E              add [esi],cl
00034899  0100              add [eax],eax
0003489B  000E              add [esi],cl
0003489D  0100              add [eax],eax
0003489F  0000              add [eax],al
000348A1  0000              add [eax],al
000348A3  0011              add [ecx],dl
000348A5  0100              add [eax],eax
000348A7  0011              add [ecx],dl
000348A9  0100              add [eax],eax
000348AB  0000              add [eax],al
000348AD  0000              add [eax],al
000348AF  0012              add [edx],dl
000348B1  0100              add [eax],eax
000348B3  0012              add [edx],dl
000348B5  0100              add [eax],eax
000348B7  0000              add [eax],al
000348B9  0000              add [eax],al
000348BB  0013              add [ebx],dl
000348BD  0100              add [eax],eax
000348BF  0013              add [ebx],dl
000348C1  0100              add [eax],eax
000348C3  0000              add [eax],al
000348C5  0000              add [eax],al
000348C7  001401            add [ecx+eax],dl
000348CA  0000              add [eax],al
000348CC  1401              adc al,0x1
000348CE  0000              add [eax],al
000348D0  0000              add [eax],al
000348D2  0000              add [eax],al
000348D4  1501000015        adc eax,0x15000001
000348D9  0100              add [eax],eax
000348DB  0000              add [eax],al
000348DD  0000              add [eax],al
000348DF  0016              add [esi],dl
000348E1  0100              add [eax],eax
000348E3  0016              add [esi],dl
000348E5  0100              add [eax],eax
000348E7  0000              add [eax],al
000348E9  0000              add [eax],al
000348EB  0017              add [edi],dl
000348ED  0100              add [eax],eax
000348EF  0017              add [edi],dl
000348F1  0100              add [eax],eax
000348F3  0000              add [eax],al
000348F5  0000              add [eax],al
000348F7  0018              add [eax],bl
000348F9  0100              add [eax],eax
000348FB  0018              add [eax],bl
000348FD  0100              add [eax],eax
000348FF  0000              add [eax],al
00034901  0000              add [eax],al
00034903  0019              add [ecx],bl
00034905  0100              add [eax],eax
00034907  0019              add [ecx],bl
00034909  0100              add [eax],eax
0003490B  0000              add [eax],al
0003490D  0000              add [eax],al
0003490F  001A              add [edx],bl
00034911  0100              add [eax],eax
00034913  001A              add [edx],bl
00034915  0100              add [eax],eax
00034917  0000              add [eax],al
00034919  0000              add [eax],al
0003491B  000F              add [edi],cl
0003491D  0100              add [eax],eax
0003491F  000F              add [edi],cl
00034921  0100              add [eax],eax
00034923  0000              add [eax],al
00034925  0000              add [eax],al
00034927  0010              add [eax],dl
00034929  0100              add [eax],eax
0003492B  0010              add [eax],dl
0003492D  0100              add [eax],eax
0003492F  0000              add [eax],al
00034931  0000              add [eax],al
00034933  0039              add [ecx],bh
00034935  0100              add [eax],eax
00034937  0037              add [edi],dh
00034939  0000              add [eax],al
0003493B  0021              add [ecx],ah
0003493D  0100              add [eax],eax
0003493F  003A              add [edx],bh
00034941  0100              add [eax],eax
00034943  0038              add [eax],bh
00034945  0000              add [eax],al
00034947  00250100003B      add [dword 0x3b000001],ah
0003494D  0100              add [eax],eax
0003494F  0039              add [ecx],bh
00034951  0000              add [eax],al
00034953  0023              add [ebx],ah
00034955  0100              add [eax],eax
00034957  002E              add [esi],ch
00034959  0100              add [eax],eax
0003495B  002D00000000      add [dword 0x0],ch
00034961  0000              add [eax],al
00034963  0036              add [esi],dh
00034965  0100              add [eax],eax
00034967  003400            add [eax+eax],dh
0003496A  0000              add [eax],al
0003496C  27                daa
0003496D  0100              add [eax],eax
0003496F  0037              add [edi],dh
00034971  0100              add [eax],eax
00034973  003500000000      add [dword 0x0],dh
00034979  0000              add [eax],al
0003497B  0038              add [eax],bh
0003497D  0100              add [eax],eax
0003497F  0036              add [esi],dh
00034981  0000              add [eax],al
00034983  0028              add [eax],ch
00034985  0100              add [eax],eax
00034987  002F              add [edi],ch
00034989  0100              add [eax],eax
0003498B  002B              add [ebx],ch
0003498D  0000              add [eax],al
0003498F  0000              add [eax],al
00034991  0000              add [eax],al
00034993  0033              add [ebx],dh
00034995  0100              add [eax],eax
00034997  0031              add [ecx],dh
00034999  0000              add [eax],al
0003499B  0022              add [edx],ah
0003499D  0100              add [eax],eax
0003499F  003401            add [ecx+eax],dh
000349A2  0000              add [eax],al
000349A4  3200              xor al,[eax]
000349A6  0000              add [eax],al
000349A8  260100            add [es:eax],eax
000349AB  003501000033      add [dword 0x33000001],dh
000349B1  0000              add [eax],al
000349B3  002401            add [ecx+eax],ah
000349B6  0000              add [eax],al
000349B8  3201              xor al,[ecx]
000349BA  0000              add [eax],al
000349BC  3000              xor [eax],al
000349BE  0000              add [eax],al
000349C0  1F                pop ds
000349C1  0100              add [eax],eax
000349C3  0031              add [ecx],dh
000349C5  0100              add [eax],eax
000349C7  002E              add [esi],ch
000349C9  0000              add [eax],al
000349CB  0020              add [eax],ah
000349CD  0100              add [eax],eax
000349CF  0000              add [eax],al
000349D1  0000              add [eax],al
000349D3  0000              add [eax],al
000349D5  0000              add [eax],al
000349D7  0000              add [eax],al
000349D9  0000              add [eax],al
000349DB  0000              add [eax],al
000349DD  0000              add [eax],al
000349DF  0000              add [eax],al
000349E1  0000              add [eax],al
000349E3  0000              add [eax],al
000349E5  0000              add [eax],al
000349E7  0000              add [eax],al
000349E9  0000              add [eax],al
000349EB  0000              add [eax],al
000349ED  0000              add [eax],al
000349EF  0000              add [eax],al
000349F1  0000              add [eax],al
000349F3  001B              add [ebx],bl
000349F5  0100              add [eax],eax
000349F7  001B              add [ebx],bl
000349F9  0100              add [eax],eax
000349FB  0000              add [eax],al
000349FD  0000              add [eax],al
000349FF  001C01            add [ecx+eax],bl
00034A02  0000              add [eax],al
00034A04  1C01              sbb al,0x1
00034A06  0000              add [eax],al
00034A08  0000              add [eax],al
00034A0A  0000              add [eax],al
00034A0C  0000              add [eax],al
00034A0E  0000              add [eax],al
00034A10  0000              add [eax],al
00034A12  0000              add [eax],al
00034A14  0000              add [eax],al
00034A16  0000              add [eax],al
00034A18  0000              add [eax],al
00034A1A  0000              add [eax],al
00034A1C  0000              add [eax],al
00034A1E  0000              add [eax],al
00034A20  0000              add [eax],al
00034A22  0000              add [eax],al
00034A24  0000              add [eax],al
00034A26  0000              add [eax],al
00034A28  0000              add [eax],al
00034A2A  0000              add [eax],al
00034A2C  0501000000        add eax,0x1
00034A31  0000              add [eax],al
00034A33  0000              add [eax],al
00034A35  0000              add [eax],al
00034A37  0006              add [esi],al
00034A39  0100              add [eax],eax
00034A3B  0000              add [eax],al
00034A3D  0000              add [eax],al
00034A3F  0000              add [eax],al
00034A41  0000              add [eax],al
00034A43  0007              add [edi],al
00034A45  0100              add [eax],eax
00034A47  0000              add [eax],al
00034A49  0000              add [eax],al
00034A4B  0000              add [eax],al
00034A4D  0000              add [eax],al
00034A4F  0000              add [eax],al
00034A51  0000              add [eax],al
00034A53  0000              add [eax],al
00034A55  0000              add [eax],al
00034A57  0000              add [eax],al
00034A59  0000              add [eax],al
00034A5B  0000              add [eax],al
00034A5D  0000              add [eax],al
00034A5F  0000              add [eax],al
00034A61  0000              add [eax],al
00034A63  0000              add [eax],al
00034A65  0000              add [eax],al
00034A67  0000              add [eax],al
00034A69  0000              add [eax],al
00034A6B  0000              add [eax],al
00034A6D  0000              add [eax],al
00034A6F  0000              add [eax],al
00034A71  0000              add [eax],al
00034A73  0000              add [eax],al
00034A75  0000              add [eax],al
00034A77  0000              add [eax],al
00034A79  0000              add [eax],al
00034A7B  0000              add [eax],al
00034A7D  0000              add [eax],al
00034A7F  0000              add [eax],al
00034A81  0000              add [eax],al
00034A83  0000              add [eax],al
00034A85  0000              add [eax],al
00034A87  0000              add [eax],al
00034A89  0000              add [eax],al
00034A8B  0000              add [eax],al
00034A8D  0000              add [eax],al
00034A8F  0000              add [eax],al
00034A91  0000              add [eax],al
00034A93  0000              add [eax],al
00034A95  0000              add [eax],al
00034A97  0000              add [eax],al
00034A99  0000              add [eax],al
00034A9B  0000              add [eax],al
00034A9D  0000              add [eax],al
00034A9F  0000              add [eax],al
00034AA1  0000              add [eax],al
00034AA3  0000              add [eax],al
00034AA5  0000              add [eax],al
00034AA7  0000              add [eax],al
00034AA9  0000              add [eax],al
00034AAB  0000              add [eax],al
00034AAD  0000              add [eax],al
00034AAF  0000              add [eax],al
00034AB1  0000              add [eax],al
00034AB3  0000              add [eax],al
00034AB5  0000              add [eax],al
00034AB7  0000              add [eax],al
00034AB9  0000              add [eax],al
00034ABB  0000              add [eax],al
00034ABD  0000              add [eax],al
00034ABF  0000              add [eax],al
00034AC1  0000              add [eax],al
00034AC3  0000              add [eax],al
00034AC5  0000              add [eax],al
00034AC7  0000              add [eax],al
00034AC9  0000              add [eax],al
00034ACB  0000              add [eax],al
00034ACD  0000              add [eax],al
00034ACF  0000              add [eax],al
00034AD1  0000              add [eax],al
00034AD3  0000              add [eax],al
00034AD5  0000              add [eax],al
00034AD7  0000              add [eax],al
00034AD9  0000              add [eax],al
00034ADB  0000              add [eax],al
00034ADD  0000              add [eax],al
00034ADF  0000              add [eax],al
00034AE1  0000              add [eax],al
00034AE3  0000              add [eax],al
00034AE5  0000              add [eax],al
00034AE7  0000              add [eax],al
00034AE9  0000              add [eax],al
00034AEB  0000              add [eax],al
00034AED  0000              add [eax],al
00034AEF  0000              add [eax],al
00034AF1  0000              add [eax],al
00034AF3  0000              add [eax],al
00034AF5  0000              add [eax],al
00034AF7  0000              add [eax],al
00034AF9  0000              add [eax],al
00034AFB  0000              add [eax],al
00034AFD  0000              add [eax],al
00034AFF  0000              add [eax],al
00034B01  0000              add [eax],al
00034B03  0000              add [eax],al
00034B05  0000              add [eax],al
00034B07  0000              add [eax],al
00034B09  0000              add [eax],al
00034B0B  0000              add [eax],al
00034B0D  0000              add [eax],al
00034B0F  0000              add [eax],al
00034B11  0000              add [eax],al
00034B13  0000              add [eax],al
00034B15  0000              add [eax],al
00034B17  0000              add [eax],al
00034B19  0000              add [eax],al
00034B1B  0000              add [eax],al
00034B1D  0000              add [eax],al
00034B1F  0000              add [eax],al
00034B21  0000              add [eax],al
00034B23  0000              add [eax],al
00034B25  0000              add [eax],al
00034B27  0000              add [eax],al
00034B29  0000              add [eax],al
00034B2B  0000              add [eax],al
00034B2D  0000              add [eax],al
00034B2F  0000              add [eax],al
00034B31  0000              add [eax],al
00034B33  0000              add [eax],al
00034B35  0000              add [eax],al
00034B37  0000              add [eax],al
00034B39  0000              add [eax],al
00034B3B  0000              add [eax],al
00034B3D  0000              add [eax],al
00034B3F  0000              add [eax],al
00034B41  0000              add [eax],al
00034B43  0000              add [eax],al
00034B45  0000              add [eax],al
00034B47  0000              add [eax],al
00034B49  0000              add [eax],al
00034B4B  0000              add [eax],al
00034B4D  0000              add [eax],al
00034B4F  0000              add [eax],al
00034B51  0000              add [eax],al
00034B53  0000              add [eax],al
00034B55  0000              add [eax],al
00034B57  0000              add [eax],al
00034B59  0000              add [eax],al
00034B5B  0000              add [eax],al
00034B5D  0000              add [eax],al
00034B5F  0000              add [eax],al
00034B61  0000              add [eax],al
00034B63  0000              add [eax],al
00034B65  0000              add [eax],al
00034B67  0000              add [eax],al
00034B69  0000              add [eax],al
00034B6B  0000              add [eax],al
00034B6D  0000              add [eax],al
00034B6F  0000              add [eax],al
00034B71  0000              add [eax],al
00034B73  0000              add [eax],al
00034B75  0000              add [eax],al
00034B77  0000              add [eax],al
00034B79  0000              add [eax],al
00034B7B  0000              add [eax],al
00034B7D  0000              add [eax],al
00034B7F  0000              add [eax],al
00034B81  0000              add [eax],al
00034B83  0000              add [eax],al
00034B85  0000              add [eax],al
00034B87  0000              add [eax],al
00034B89  0000              add [eax],al
00034B8B  0000              add [eax],al
00034B8D  0000              add [eax],al
00034B8F  0000              add [eax],al
00034B91  0000              add [eax],al
00034B93  0000              add [eax],al
00034B95  0000              add [eax],al
00034B97  0000              add [eax],al
00034B99  0000              add [eax],al
00034B9B  0000              add [eax],al
00034B9D  0000              add [eax],al
00034B9F  0000              add [eax],al
00034BA1  0000              add [eax],al
00034BA3  0000              add [eax],al
00034BA5  0000              add [eax],al
00034BA7  0000              add [eax],al
00034BA9  0000              add [eax],al
00034BAB  0000              add [eax],al
00034BAD  0000              add [eax],al
00034BAF  0000              add [eax],al
00034BB1  0000              add [eax],al
00034BB3  0000              add [eax],al
00034BB5  0000              add [eax],al
00034BB7  0000              add [eax],al
00034BB9  0000              add [eax],al
00034BBB  0000              add [eax],al
00034BBD  0000              add [eax],al
00034BBF  0000              add [eax],al
00034BC1  0000              add [eax],al
00034BC3  0000              add [eax],al
00034BC5  0000              add [eax],al
00034BC7  0000              add [eax],al
00034BC9  0000              add [eax],al
00034BCB  0000              add [eax],al
00034BCD  0000              add [eax],al
00034BCF  0000              add [eax],al
00034BD1  0000              add [eax],al
00034BD3  0000              add [eax],al
00034BD5  0000              add [eax],al
00034BD7  0000              add [eax],al
00034BD9  0000              add [eax],al
00034BDB  0000              add [eax],al
00034BDD  0000              add [eax],al
00034BDF  004743            add [edi+0x43],al
00034BE2  43                inc ebx
00034BE3  3A20              cmp ah,[eax]
00034BE5  285562            sub [ebp+0x62],dl
00034BE8  756E              jnz 0x34c58
00034BEA  7475              jz 0x34c61
00034BEC  20352E342E30      and [dword 0x302e342e],dh
00034BF2  2D36756275        sub eax,0x75627536
00034BF7  6E                outsb
00034BF8  7475              jz 0x34c6f
00034BFA  317E31            xor [esi+0x31],edi
00034BFD  362E30342E        xor [cs:esi+ebp],dh
00034C02  3132              xor [edx],esi
00034C04  2920              sub [eax],esp
00034C06  352E342E30        xor eax,0x302e342e
00034C0B  2032              and [edx],dh
00034C0D  3031              xor [ecx],dh
00034C0F  363036            xor [ss:esi],dh
00034C12  3039              xor [ecx],bh
00034C14  0000              add [eax],al
00034C16  2E7368            cs jnc 0x34c81
00034C19  7374              jnc 0x34c8f
00034C1B  7274              jc 0x34c91
00034C1D  61                popad
00034C1E  6200              bound eax,[eax]
00034C20  2E7465            cs jz 0x34c88
00034C23  7874              js 0x34c99
00034C25  002E              add [esi],ch
00034C27  726F              jc 0x34c98
00034C29  6461              fs popad
00034C2B  7461              jz 0x34c8e
00034C2D  002E              add [esi],ch
00034C2F  65685F667261      gs push dword 0x6172665f
00034C35  6D                insd
00034C36  65002E            add [gs:esi],ch
00034C39  6461              fs popad
00034C3B  7461              jz 0x34c9e
00034C3D  002E              add [esi],ch
00034C3F  62                db 0x62
00034C40  7373              jnc 0x34cb5
00034C42  002E              add [esi],ch
00034C44  636F6D            arpl [edi+0x6d],bp
00034C47  6D                insd
00034C48  656E              gs outsb
00034C4A  7400              jz 0x34c4c
00034C4C  0000              add [eax],al
00034C4E  0000              add [eax],al
00034C50  0000              add [eax],al
00034C52  0000              add [eax],al
00034C54  0000              add [eax],al
00034C56  0000              add [eax],al
00034C58  0000              add [eax],al
00034C5A  0000              add [eax],al
00034C5C  0000              add [eax],al
00034C5E  0000              add [eax],al
00034C60  0000              add [eax],al
00034C62  0000              add [eax],al
00034C64  0000              add [eax],al
00034C66  0000              add [eax],al
00034C68  0000              add [eax],al
00034C6A  0000              add [eax],al
00034C6C  0000              add [eax],al
00034C6E  0000              add [eax],al
00034C70  0000              add [eax],al
00034C72  0000              add [eax],al
00034C74  0B00              or eax,[eax]
00034C76  0000              add [eax],al
00034C78  0100              add [eax],eax
00034C7A  0000              add [eax],al
00034C7C  06                push es
00034C7D  0000              add [eax],al
00034C7F  0000              add [eax],al
00034C81  0403              add al,0x3
00034C83  0000              add [eax],al
00034C85  0400              add al,0x0
00034C87  007831            add [eax+0x31],bh
00034C8A  0000              add [eax],al
00034C8C  0000              add [eax],al
00034C8E  0000              add [eax],al
00034C90  0000              add [eax],al
00034C92  0000              add [eax],al
00034C94  1000              adc [eax],al
00034C96  0000              add [eax],al
00034C98  0000              add [eax],al
00034C9A  0000              add [eax],al
00034C9C  1100              adc [eax],eax
00034C9E  0000              add [eax],al
00034CA0  0100              add [eax],eax
00034CA2  0000              add [eax],al
00034CA4  0200              add al,[eax]
00034CA6  0000              add [eax],al
00034CA8  80350300803500    xor byte [dword 0x35800003],0x0
00034CAF  005807            add [eax+0x7],bl
00034CB2  0000              add [eax],al
00034CB4  0000              add [eax],al
00034CB6  0000              add [eax],al
00034CB8  0000              add [eax],al
00034CBA  0000              add [eax],al
00034CBC  2000              and [eax],al
00034CBE  0000              add [eax],al
00034CC0  0000              add [eax],al
00034CC2  0000              add [eax],al
00034CC4  1900              sbb [eax],eax
00034CC6  0000              add [eax],al
00034CC8  0100              add [eax],eax
00034CCA  0000              add [eax],al
00034CCC  0200              add al,[eax]
00034CCE  0000              add [eax],al
00034CD0  D83C03            fdivr dword [ebx+eax]
00034CD3  00D8              add al,bl
00034CD5  3C00              cmp al,0x0
00034CD7  00DC              add ah,bl
00034CD9  07                pop es
00034CDA  0000              add [eax],al
00034CDC  0000              add [eax],al
00034CDE  0000              add [eax],al
00034CE0  0000              add [eax],al
00034CE2  0000              add [eax],al
00034CE4  0400              add al,0x0
00034CE6  0000              add [eax],al
00034CE8  0000              add [eax],al
00034CEA  0000              add [eax],al
00034CEC  2300              and eax,[eax]
00034CEE  0000              add [eax],al
00034CF0  0100              add [eax],eax
00034CF2  0000              add [eax],al
00034CF4  0300              add eax,[eax]
00034CF6  0000              add [eax],al
00034CF8  C0540300C0        rcl byte [ebx+eax+0x0],byte 0xc0
00034CFD  44                inc esp
00034CFE  0000              add [eax],al
00034D00  2007              and [edi],al
00034D02  0000              add [eax],al
00034D04  0000              add [eax],al
00034D06  0000              add [eax],al
00034D08  0000              add [eax],al
00034D0A  0000              add [eax],al
00034D0C  2000              and [eax],al
00034D0E  0000              add [eax],al
00034D10  0000              add [eax],al
00034D12  0000              add [eax],al
00034D14  2900              sub [eax],eax
00034D16  0000              add [eax],al
00034D18  0800              or [eax],al
00034D1A  0000              add [eax],al
00034D1C  0300              add eax,[eax]
00034D1E  0000              add [eax],al
00034D20  E05B              loopne 0x34d7d
00034D22  0300              add eax,[eax]
00034D24  E04B              loopne 0x34d71
00034D26  0000              add [eax],al
00034D28  A029020000        mov al,[0x229]
00034D2D  0000              add [eax],al
00034D2F  0000              add [eax],al
00034D31  0000              add [eax],al
00034D33  0020              add [eax],ah
00034D35  0000              add [eax],al
00034D37  0000              add [eax],al
00034D39  0000              add [eax],al
00034D3B  002E              add [esi],ch
00034D3D  0000              add [eax],al
00034D3F  0001              add [ecx],al
00034D41  0000              add [eax],al
00034D43  0030              add [eax],dh
00034D45  0000              add [eax],al
00034D47  0000              add [eax],al
00034D49  0000              add [eax],al
00034D4B  00E0              add al,ah
00034D4D  4B                dec ebx
00034D4E  0000              add [eax],al
00034D50  3500000000        xor eax,0x0
00034D55  0000              add [eax],al
00034D57  0000              add [eax],al
00034D59  0000              add [eax],al
00034D5B  0001              add [ecx],al
00034D5D  0000              add [eax],al
00034D5F  0001              add [ecx],al
00034D61  0000              add [eax],al
00034D63  0001              add [ecx],al
00034D65  0000              add [eax],al
00034D67  0003              add [ebx],al
00034D69  0000              add [eax],al
00034D6B  0000              add [eax],al
00034D6D  0000              add [eax],al
00034D6F  0000              add [eax],al
00034D71  0000              add [eax],al
00034D73  00154C000037      add [dword 0x3700004c],dl
00034D79  0000              add [eax],al
00034D7B  0000              add [eax],al
00034D7D  0000              add [eax],al
00034D7F  0000              add [eax],al
00034D81  0000              add [eax],al
00034D83  0001              add [ecx],al
00034D85  0000              add [eax],al
00034D87  0000              add [eax],al
00034D89  0000              add [eax],al
00034D8B  00                db 0x00
