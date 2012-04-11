Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([88.190.12.23]:51205 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754172Ab2DKITc (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 11 Apr 2012 04:19:32 -0400
Message-ID: <4F853E84.2030708@free-electrons.com>
Date: Wed, 11 Apr 2012 10:19:16 +0200
From: Maxime Ripard <maxime.ripard@free-electrons.com>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>
CC: linux-iio@vger.kernel.org, jbrenner@TAOSinc.com
Subject: Re: [PATCH 2/4] staging:iio:Documentation: Fix a cut and paste error.
References: <1334089052-22304-1-git-send-email-jic23@kernel.org> <1334089052-22304-3-git-send-email-jic23@kernel.org>
In-Reply-To: <1334089052-22304-3-git-send-email-jic23@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi,

Le 10/04/2012 22:17, Jonathan Cameron a =E9crit :
> falling is repeated in some entries instead of 1x falling and 1x risi=
ng
> for the entry.
>=20
> Signed-off-by: Jonathan Cameron <jic23@kernel.org>
> ---
>  drivers/staging/iio/Documentation/gb            |  Bin 0 -> 33746 by=
tes

I'm not sure you intended to add this file as well :)

Maxime

>  drivers/staging/iio/Documentation/sysfs-bus-iio |    8 ++++----
>  2 files changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/staging/iio/Documentation/gb b/drivers/staging/i=
io/Documentation/gb
> new file mode 100755
> index 0000000000000000000000000000000000000000..38b75e35addda5993d1cf=
f78caa63cbc8e77a005
> GIT binary patch
> literal 33746
> zcmeI54}4rlb?@iyN{)~edu1z$V;gcE%f%F1TFHuI977b_0Vh$2|AnR`bS+COTS1nD
> zR?0t8BH0E4I3y(LBZYw1B&8uui%8Qz1EI<vXdVRWl+Z$(*Y2*Y);OV<(w0zC^uE8j
> zcchVG8+f0-&nJA!wMR2&&Y3f3&N*}L+`0Gez3IZ%HwQsr+>tQLjG&PZ7}HGtK!-62
> zW6GONXez+{hFKzf-%~BdJT)4n3h0!|;xvm~ZJURpWEs+^JjN%518yFU(mY@#wWr!9
> zGGm6Kbg0D`CAC+bXrj7+JTQ4G?jxyR;gQ!o*P;~IbOcyQc=3De&Q5&Dh8Q3`>T9B%XY
> zKnLK<4%fb+yK6^7cgKqEuAaf`>T|vIE2Fk4TEN!4<*k?7wvt0_RKJw;8>Eo5g!F3C
> z@ea|uLv0quz#{T9NvDx&NUtH)k#w9IWoAK~yR3@Bt4MR=3D3h7wKVp6Rw8FN;gyG%0A
> zJgnZSlz!ZyaaKAY&gBEuarqSTxp7(cK0Pigo9&fVJcBept~;At`a0ery_uUMjCgM*
> zReSJvf#-X0HA2>T@F&5iJy>IKM@S(}+UVgQ0^a7q7XfegV9DC;!T$k#od>^$4)%HQ
> zd%@r4!5;*^+k<xl-{--%13%=3D!Uj!cY;GY3M?ZICI{*DJ90zT})e+GQagIj=3DK^57z=
H
> z1@m5q^!s0=3DS`Yp$;LwAg0AB9FzYo0HgMSBjg9m4UH+k@9fv@u59{~5Q3#^~j;4#a9
> zcX@dE_kahNqu(J99ss}JgP#Gu%Y**}_+Ae-nas}Jy*-)SKwJMnCS#b^?V8T3On<hm
> zqob?eboTaTdrWSizo&h7ALL!R-u5@VA(P9sxAk<I_U_(XR%CsH1MR!o`c2!8-u?lR
> zcMSF^8|Zzf$z`+e6b)cEyfT?=3De}7MJrn|SjZJ?{S$983VP@A3Ef!@9W)7RVGJ=3DI%=
h
> z)LSRL<V>gSG-5v3ZFaYH!^!lwb>*_AE!WrI)icm(B(?g?WZDO=3D@5^R(s5@#I=3DT0-=
2
> z>&|BTOlM4sT+!Gx`dAga+q!y8XMZ+p-qL!}y7if+`g12s3hYGK=3D$~eGauRa2zf2y`
> zTJzn_`7^q@2xm#N1ly{v*1`$10$9g({Npr&r2M3o;C1MNz?=3D^5S>*(;?<hyC=3Dadt=
$
> z3d#v!hn3Urh;o9{3(6~)56WL<%)coopuMP^!1<DL1vC0N9f``66Syjr6Hu#_BVbB7
> z0l8K=3DlV-kh0_`H@1ldqILAy>lL2#LJ0^V}v1iiF!0(-M^9DKEMg8o|N1pOA}oGdmd
> zC+Kff9vaiCd@=3DJ$Ie}=3DKasuQP$~iGyrF<#!wygNxkTK6!3_W_JtgvFdtZ-m_cH!1=
S
> z#j!7sKlSH~@2j_#s=3Dl_r^wdwjH15iyUik}NdBiK<=3Dautb`7W<~n^(TsD-U_)>%4N=
G
> zSKj57w|nI)yz(ZmywNMSc;(ezIqj8~dF9Y6&-cnHuUz4kjaPp0#VNfV^U6oOa=3D|Nq
> z$15N5%1?RaQLp?3uRNmiNPf%|@?&MGPaHlq%ooc-Y-(1Fr$!HqmyNC%uQmt9tJ4R@
> zKQb}#{0B+lqxiySIB$FjAEmxFJTRV2-&#n7cl@(4TgF~9(GcvPm^k{>=3DQ$VQ4k>6%
> z_^ol_f^bj5gin-1QyjpbLU_xcO!_wPTgRAYm6o0|O)FPICqMg6OFUUOuJ~Tr$StM$
> zhb}G6H&x?{QdQ&g&BF1|AeTw!i>Y+g_>=3DUPqAr=3Dr7ayR$7P{K>!tn}l%Bz(dbM$}=
3
> zZA^FvbqmK$`dj0B;gL-5DU77QRZN_hEJ-G&_yUV(3>BgapRjq5-dhq+;Zzo1$4Bk{
> zX<}kQM2~)HQ;SSD#eF8x^CHV@ua$L6RL}U)|Dj7tX5*trq@#`KI>neP7;`IQUd>q6
> zrmDtU!m9BN^v9UTmXn9+OG;|{(p+p6eti6G@Jm6PQXj}d7`wkJT^N&oKF8SWV){eS
> zr=3DY+1B=3DnzxepyVPhrSm2H=3DTt34(LPrl{^7-PXChQ26Xw`)X7#ReFyTlmn73($r=
LUe
> zpHI6gbeW*7?01Qyr7fYga@lcc)_FAT@DDwj<*7?btmca^)EpSEf$l^)X`}z;k~z#5
> zpKLrZ?)v|ypG`c!2t8U`Ap_xj!F`JljEmOM{5v#tP6lsGZ-(a({nm$<lvbd>7VK}#
> zE#uARl2RG@2H*<vMdXjd!<UVDaR0^tIV3ZET?nuG^p)c~kimrcc|n*@R-`|UFYX<0
> z27k}ud~q$g;1=3Db`(E=3D@}s|97)%V2xcQW%?W_8j3<b=3D1+oXKe0D?37+#dg3z8{f=
{%B
> z_8eJ3Upd+%$AZ=3DH6P<YDM@I!CgM}sgN0Hs?4n5~7JD+6!9yQd-@BfB+%~#o1ez2Fh
> zp*FE^R=3DW1LK_~hL$d`ea4}FMoU0lAIvh%I?QkHH+Q*r2$QYxM^t<0J2q+O&w(g5jZ
> z(p@AI$B#5~X&Le?PgRYl!zy$b&83ihe(dW{VY}vVp|$lM`l^85&S&Iz^GWj`pF6rJ
> zZgVGXq(hBo@FZ=3Dv(k9I~-vCWDe5;|CF3v;WAEC~lAL?TR^z)HL<MrpqUPnt?&5uRL
> zp}E1M;WWO$@d)ut`S9V?0d%l%{37U1G{&>(-|9Wg7r#J!b-w=3D^+W7Ok9R6*tzj!X#
> z7)kqmw3BT$uQiVibi`KcBh}Pj3hd8;$MF&M>3qc5{S@d#zl2=3D#Qua?!mT##%@n4K1
> zF8i@`6#F}$c#3kWB086B#1}SVgVt2!1Cn=3D#<RZ2zrgM#Qbfe@*ah^c#1hH#xqs|jM
> z3Q;~>NP)97COVe{Au;S_bVG#{I!T(%#q*8%*d$MQAD@1>uwj(A-jXlQF%KP?V;&$)
> z&y(iPBT2LW$j{}K8ZJ!Acib@y6@pR5^vm>hTt35vBz!isTvD1TtAm})@_BdOY_&RA
> z&pA{!+*171#KhMsV!Z58L0_T~?yiZ6M`YJjMRbl#GpDOLKW>_Fer$o>#i`}-{M>l@
> zf$`Pw`Y=3DACIkpVm%S7kRY1Qow;`4#Y7dJuc$F7U<@%!TT?i{8zIoik{t6KJ!Y|eR1
> z{@4-ICW*1h^uB`Xo;>Zq_??aieXoM&a^!OD(y8dYm4~i9raO_WTj@6~-Guq#z&TTM
> z^IY16__dou#D@hpxIW{#DW0}1GBtu@nRT>z=3D>c?dNhvh=3DI&)QgPXi}C1<0y%iq$P=
V
> z<hPNY_l}Fc7COi8)#@vr-&&(x4(y*x|CIUd_^6MU%@<@^B_7yG__eYV=3DOCL){>Wwv
> zw64)OYLH$1m{fjDW6}K8+M<9AR<ASc^0Sv>-kx2S*K)p&`xJk!_ZQgyQg^UUI{w_R
> zqYuSY`Lg;uo*ln4@4)yE<Nka*mdEQd)kQqkTOMCQW~)cWonJX+)5qa4)22?}kAX`#
> z***I{2(Rr+4vgy@nnp(7t_Li?h2x(lkMNORwdQqv{|KBf+kW_oHU-ZL?4fc6<!Z{u
> z)APNww>Cu2W!O~l|87^u_|#r@wRvn;^fKB1hoE&fzA5foYj)9>d27WV$2@)gvVN&_
> z<G3DtFYRR?*O!}Tt*mQ5aGdtCk89uM$?*>O*m~qQO;h%HJ2bM-G1iFcBQ-<c>n(oa
> z_{HRo?^ep9MVBQfS6zy+r9Of$-(t_TBdjYFx4s$M*B|4##yp~S=3D>LT62jcc$K2H1B
> z#qF1ysC{iJ%IC-Y7BPmp(S_sTru{Zw))M8WaQC?C%SP`WH=3DAx5FKfAFe02-sAg?am
> z!u8`V<A252T%6V1+y?B&fceA#)u*X<v0yE*eB^Y_>6*iANgUNW(#4V#W7T@KmN~;V
> z%278zYs2HuPsM1(+@JiEwTjnPWzF$_nV7iW@`&kv0G(v2LZ;=3D=3DsO?ee6#rDN=3DG=
>F^
> z)|yXy>xx5^*+Jy=3D&i)bQ0_h0JzlL*bjcxdilkM~H_t!o{`2T9~>hJ%6n@fy)FJqO=3D
> zTK}nj5k8xY^{a7QgRlE|1OBJ9mHvhAnSuYZa4q>_D`Wj)OqVp<iXE&?ET5LWCE*^5
> zahkiWspvfOj~?GEkkzNZ&+$s_D-79r5S`21x#VW>I-mM&KCU)lzG&BQTz~64sXc=3DY
> zjndJ#(8HGEn~*=3DWaAeO9t4%Ebhg_fGzJlX1E7sE=3D#JENHi{g`X5g@Z-N*bLWX8+<=
T
> z)~2$B=3DAGu8u4|mUT6cUF9$H&}$y@tosPkhnTXL0Zr~13#xnagRbOZIO+X#*P`%YkI
> z8_8qmF!CrquLH+5#&o}@ejoMzdiw_Ek9<S^;9moEv$t{#zpMQ+`-h}Oq>xlc(lt?<
> z-1%f3>n4q(F2!0X<ot!6>ga2g<U_xbXJss_?2?G}dRbhjc_>@@dc7Fgo3WK!@9Ww=3D
> zgytQRpYkGb31pTYPNmLYU$J$%z<}47YO%+w!MDbJx%HOLv-R}x9QM#$6(3zw)LC8&
> z$N%*|qq!@Y>g4y}9`bB=3D4E)SK_k(wR8u&CEr%$$JkM6>@y53X2&PTohKlw)#BeoQ|
> z#;)8L^IOIk-1v_|r)zP^FWo!~tavule!5O+#zwk!mF;A+)#UE_HHFP|tyZ04-GI$1
> z;8jgOTB9gtzCYfN5MTcq=3Doe`p(Ei#Jw0AzU{5U?Nel;%n&L3)=3DvG3e#$BeB#-x-b=
T
> zeBa?*y`Y6XkFS8!+`Q-nKJ+yBnLczQbu;bh`_O*yUnJT2rZq;q@3ewGmLczabob|$
> z$HMV;a>af5&eGU-{A=3DDeOE<Nbfvp$Z%|7Nwss9vdW*^#X9P<2BvR?q5>@VNA-L;`V
> ze82JvXtjrB!doW&(fT$rz1`AI`OgO6<M~eqzT$jnDE6N_$u;jEBK@L%u;&DR@QbvU
> zKlGoVz4N0*o*&6?&eZr~zd1eDi|;p0ah?23<Ccxer2lxX%>^&t;Wo}u&1bg{?B?Ga
> z!E25TfOGNZ`#+f;Q_JC(j{9-(W<LGdeKY31_J?FUH}}73+b<mdHo5xyM{>6p;m2fW
> z6V2t9uz}OT%=3Dmjua>w&XJe@xNT4m1VzCQjXuJh-S^f40aL$XO9OVCH2x|#9#C*b9e
> zH+%Z{40Zlo(skntaX(HUiYxCbH&!0Ws(l>AJ3kiRZ22r4zg2ypm)|Fsem*oSYBw|H
> z;g!bMk@*Y!HNLi2ypv4Y@0VYxPvsi-rSzR*9%&p2^yBZ%XwOXh`L)dX0GV~3_=3DBW*
> zo)~A>L^{`;tet$NnQIgI(+TNX_7qZ^h`qmr4Etgk%2Vxy6Y`DaPNs(o&FOt79ba?m
> zj+5dwe({msbgtI5s`VMhr!|q*SAWdDii;)w8n+J{q}X4n_2(*WmMM-h|5$@p>fHWt
> z<0Zw18?P)bX-3bh^Tj2ki7;7GUDB(=3D9!2f567P?yougHq)<BEktN6EteQ8&>JnoDA
> zQQOxS=3Du5Qosn_1L_OKlvT^qRaWFE3_DLK-Kg4({g_{z!lDb59cd$n1=3DEV?cgf8iy=
I
> z+AV84F#h7^D~m6R7ydL-hA+e0uHB$@F=3Dd15HCJO?g@^m5!_mGnE(b07;w<2D{8Mep
> zX#0;ZPCWnmSVxciGUG+|N8+)%@vD8`rUT=3D)o_>Z-AUF57PbhcZ;b{LH{;Tmx?s8x!
> z^MlBoI&?{?FTOr1V-8o7oDV71En^<LeRs`a#a5m}vHROI=3DdZ5S-TY19YpjVYE6C3v
> z|0CMy{HZy9qIS*bU4F0od7Aqtqjm9N9p|h&e~vuPA3uN`zo-n=3D=3D8hwEtkvv2hLgx=
=46
> zp9{nFrI4|0p359C?WJ&(d4ZmFy}fol{?Rf-{NjFUOa7ppD_bL<3DU{Z1WEIfTmF?N
> z8*iA>b>v5m=3Dw6^?L$`%wDkz+^4ROQLh6UzQp=3DiQA+&kJ^{6)s4IiNXHSHoUd>`Ri=
9
> zM;lHmXLa1}Sn9wyCwuF6YFAFX0_PmdGakcS{BJ3?dwM(jFDcy<{m7AT$ya}l?bU~~
> z|K+i7|2%)ucwC$Bx;BjOG?hc$Q;X*G_kYZJ8=3D16+p>=3D^`uY6v5P6I3Uo=3D@zpH2=
JZ=3D
> zgw~%wZZDxWo=3D0xo)yF*QV;&8ps^t4)74Um#mG0A5jSqR}$4$VRW7?xc9=3DlH}Sl4)=
0
> zBa`|+pLn?%eI|c+;G<dUHZifTcm<{J+#kvFbetbgwq>!r_nv^}A+O#*yPth>d%cey
> zmNDiVW7z3S`)g-YFP%wOI{#l0(<s($$KMjzQ$AA3`R85OP1j@W0US-Agl;Evy5Cm?
> zUByZ0-XTALj(q{{LlwrF*xT+itXqi*&(<9n-vT}jUiJ%2Zj9$G?EZn~h4vEEW+`p7
> zroN9o?cd>Awi)_n=3DtaYN?fyHP<GBOR4e--Gg4P5)`*ifi7}pH$jo|u#rLS%AJ;M%o
> zN)O_99{5c$UmkB-unFC0PHuok>u%9BLF4aR5Nqu72<q=3DY8Kc^(O)YJ-*RUE{SI0bA
> zci(RqvuK>o=3DX>%Vru|{|$kl#zYT<YdxNYPe$l8i5nxk&5p0jJwsr?FgS3Z#Beg|#t
> zV-I_q*T=3D+vOg#S$cn`o^W4|IE`#$#a-Pm7(=3D0xLSiGTDeXt$vQ$?nT>gm$ieE&V(=
B
> z?qWZ0CchB8LB2nP-xcsm!7JspvHP0ntCo7%_G9elUP1X-0y*(dt&fhOQ=3Dc!-XgtyZ
> zFYRqPoi1T-crARi7pisd?a8FQSM_aVC1w;`u$A4Tr4Q_9_s?X%VU07k`4D@K&9r^^
> zBzoz#^pU+23%N#wb_4xxpkMiNCA`<3ePH}5Pqw?E`Fbpey9QC;SHes2OnZARl-+eZ
> zkJB*+@?+i9E8j&f{(?29zp(0(Vs|WakkYdZg|Sb<U%J)#S!+|>WA37^1$xzKt-3bW
> z%LZ^QDaH`yi=3DEJDPj@5uD&&`LhS<lrgL)pvv+^n4vre{q)r$MlZ3}rawWr|h;QPme
> z*up<oXwPsh{k@0h?ii0<Zwaq+$M?8bsx`dMD|U|)z7;X<k%@^l@`c0fPskTIFOBV<
> z;S1&Xg8crWnC2<2ac5~?S+X;CG}a5H2l8d)vWw>0Qp$|g(l}c6CERPkX)jFv2u-E@
> zU-k2;m!GQa?@P6;n`589T*P^98L64nO42@NANdezKj}`=3DL!{?O6{GBLl9rR2Nv)&-
> z(v75jq`OEDkVZ*CxVfa~(zp&@6PQiK1?+JrOifX1q?+@4i>Zd*Vj^5$kZ;tm=3D9<?O
> z=3D}NSLX$h0zp2Y_#AEbN_<;B6K;^LqsT(X#Y$_FXmLz$;1$CfmW)GVHxulWHnS#wLz
> zaba6rDnC!<8u~gb+)+v=3DBAnW=3D^qTivLb}{M_Ma0Il}Vn7dxmxBtd>WQ+-{hMsS65=
f
> zD?EGFmBDCOFsZh68rNCCCOyLQRC<ziYw<Pl*g}nszUIy8rQN!M;y?{PFgIjuCO;-x
> zu9d=3Ds8DeZ(iw7xxit^%MYjJVo`ta<4dddeWe~PkfdG^^;W8*16<leq6l4~tIT{*w<
> z=3D{flzFhfayyrN&pn5XDAjU|G@6Nw=3DIr=3DN(&{*!p@Up>y)6E%xV27gO5E-9ta&u=
|OZ
> z`kQq9(OgWJbYMpBtVxXiUd@wVJ67`*()Eo0-ix{3fBQheY|1{!Iq&bvTiCx2L+&pu
> zE*NumAxJHmgjbo%$I?TO-kb<(#)8v{n_uPL)9L%MonA}mE16WWlnCaHC0B86yDF{^
> z`%5N0R+0=3DnCsG--Y$%0=3DL16R9+;8TKP35;?r-P+=3Dvu`VGJ?(P^WH=3Dgbx)7QV=
mjc%B
> z^PowL?q9MMx+l*1Tp_VJU|nI}ZbolptjBDh!K}?=3DJSMy*K~DQM2U8=3D(?PjFdJ*w-=
k
> zeWiWBNnYMRcDXUXnFy{L%a4vA@<^#{!NEd#YPiUlj_e=3DBKg<Z@Jy-~4F+Sw{5&mgR
> z<Csb1q0c8Z55n}`L>247Fx*<=3D+<1R=3DczcQcq`#{j-BYT@XKSi?PJsDA9s41BxGvf=
8
> z*P1WsMZ?de68UG6E!zrZ3x@ObdyszbD{Cnf&uZCLBKF;1-Eyb&^0iuI4#SR8x-4I;
> zNemSmYu{^StZwOu>hY19vLSmdEZG~O({-`R%=3DEEf)sj+h`r-s*PXwDToO_UGO|f}V
> zHYeUzI)7loRpJv`qXh}x=3Du!KmX)H2cE;;h^fal-)wUHup3x?2VkV5}8!%IXLTzDsa
> z3^!3;Et}j_``)oRrw`-rdHKi@^#|V?_{!G;;zkXzwI+D;ZN=3Do<ZV%`uNSraOK9D&r
> z9cwNG^4s8&{8$q@Fq=3D5<aPIj8@}Gz%u{nhwY+on3JD?j1M~aWv<cn?SBQcx(mFBr~
> zC(2gNn>}ywT=3D;W)qG?R9>udI<`7!HLHIM0;yQ4vPo8pm`L;cGi{kp{F8vGLfi~Zfn
> zy7=3DoO#j7+oi6IX>hR(u0b0_n~dkSHCM=3DA9LHj?d<*c6{gFxM`l&qNS12IejESMm?=
1
> zM{1I$sb<~N$7<G-)?%l#moul<_7~tg8l=3DKeV-`nwy8Xd3i95(VoCs25iSi-FH>$WZ
> zSMxM++VI#!?PKV%Z7w{EOEd?=3Db*0V8+mNZfR5K4b8cj5&)Vq+QP)d|<8e{#vCMes)
> z<)m4Y$M(`E&nB0C#++PX=3Dh5b|JyrPvK_!_qLpFvFGw-l}AyJ+hQy>4%{7L;)Z?R&u
> zmASE{kYaA^sT#_gaL0qRIhaoD{Ty=3DBrU^M0({G3>_9Te8bH9yVhST{XIw(p9x(1f~
> z3HdDaoG${k4NO{n%APe7Wpkso1@b0>p(Vm6>TZYcP!r`wjq|3my;euUty_MK_W7Fi
> zYmWu^Pt8yrx^EsKE~kT_e8`@QOj_pw#njl(Mn|lFT++N(zNx;)SW8X%i0GNalW?MO
> zhQH9>j1o`cm~th2f~NI}#5wCri#Qimgj-5`&RefI_()CD-a_i}d@&@hC~l<__gH;P
> z_7Gdt#JK(Dwqhf=3D2j+}golK18$MUaVR5*CvqEt10RBcw)yh-{C_Y`zq94cd+wIemW
> zN>Q0u32kC;@!;IO#oHQ(3yGi_eQh2aPURc#IcvCaZ#v(|d8&9*_;~5Rusvh_U?SK$
> zX?w|{xtVyZx-?vy5AtREiwB8KH!+ThbpPYn`!Q%9lV4h0QhyFH?o89qxy}4FxM%Q(
> z(h$C*Iiay?%x%~Z-In&J?<l%)SwDHql!mZ9K9<DC5<g|mRU@A<E0G~6Avd_1Bt8`3
> zi0`BL(!ukp3+SRKU0|Qe#AAn`e`X$Q!v%o}8Mo2;CmKtTo+tkz_RmWMjq`}j^wET`
> z5C`!Q?TN!jzPJE?p*~;3JelNkQ`yj@kExtw?BabqyR5NxS!eBnP1twjxdrNiCeE$c
> zBy8G?FIShe7LhG}H~ds7@s+8y31gpJn>^sHO_qCWlLsg#n?{PuA0MeX#&~5%V(JIQ
> z)6HSYCmYIsH*rook?n3pm;bMJc+#^2Hn6&U7<r`2&ssa=3Diw{C0I2r5qqu3Yy>OF;{
> z&Sw7rZDR4EF`j{3kZ62n?8D^uO0Lm@=3DKoQi(;QPgRj&6lhFH%Hd$EM`c4gV2TT1tg
> z-j40k#M&*J9-EUNer!%bzHaBe;*PcVlhOH)7*zZr{R{)MZe?5g6Njz8XpMn<)x?4c
> zWSGPGtDt*&cFo$ieh%liio%NV7pa4eVddvl9Q(v!)v>-%-Ad|~xH_J-QQaNX?R9nI
> z$Ei~ve%m3&cvIOHJ>$IQlf<C2mv1dF&W{=3DHD<m3;d7K;KwWZF3_<7#?WE=3DC)`L+B=
R
> zI$}*B>C+?_Qw8+1e#G?*<9YGI72j)Rue>$Sb@z7G9-D40ROW9jlyADa5cJXCP`>!+
> zzfL@V;pUMd@>H4@?9lkJf7br}Dd?#JS+y?HyDQ~9PxE80!Crjtqeoua%R6Bt^{sba
> z^j?eJRcpvypKI7Lm}}_j>TT%AUenc{%{5@)3~6buL9gm%vfbI;*&bfjvvnE0f+yTk
> zRrHfO+q$~59pON4s2BCZr8&+bOWU(+mbNb)Y*;$@rZ+7e^l19pa=3DB1^Loo_FvbpyD
> zu0H$jV8q|@UD}BZykAJusIN>{Pe=3DATL&NSYbiJLOx$J;3Z|x014D!}rS6g>iFYN3P
> z!nSJ=3Ds%?j*<yj3=3D&!43o7|`~yG`F;)p{H%P#$n90)NSg`<+>mbHJHKvEL{0N5MJB=
g
> zHINOL+R@QULo=3D6VclY*RAKF(H?MsigQ5NpTtnVG{?g)E&2RvQ0Pp|7lTT<3F+5WCh
> zt`m;iw+7U+Gw!~(6Qzb*cUe9=3D5GQ9511K9lPAtY(X_j`9(&u!BA>&mJ|8Qw{w}k6n
> zbM2b;HQ9kRJ!=3Df+UK8ocm^V+_uM=3DH{1H04%1BE8mXV^2idq=3DiE+>w<~gS;ggcI=
D6t
> zedVS&Nxw^TD`2Y<*Tel?J9lRLkH<eoP4(j{PS_FrHud*nq1~b0W|bV)iDKu(Se?E7
> zyQ6ndq3!5u+Zl0}OumeGduJz7sXn5J`)+6-?C;0VGcT7r@`4%oP=3D<t!;XT-$1G|jL
> z_CyY+d8GLiE7&SyO2<=3Dk1TWd8arnOa*2`O4#q-Eh6E_h%%<>N!lOpL5%(}w9lU{g#
> z^qzbj_w#w((&%>s*iSHJBrdGXv%s9|EUda+!_n^zytFTRhyU(93LeIs3scskmM{Cq
> z_8^d&CofQRz<0p&42gY5pZi{B^nFozgnTZr<e5hz7V%2OMDGyw#Ohwj%K5Oj8Tgky
> z^g9Rcc!6=3Dgl9H24c^chcu#7@mwrxk33E2BE<>zd>(99~U2woM;EvpSq3(iQ+56%o0
> zB;K-q{hDwYKc(=3Dxu(|%6`sT1H-Po9ZL*u#OvcCRoKW^NX%f8OqEMa7DS&coX5q^`x
> zmZCqhDN!5KMEI*d$MYO7!#|4&Bm5N)8uJAiG(MvC*Re#1@TrHHS2FZ8{31?o5q|p@
> zc!&69_)*Lq^Z(-U`X?~N_-$We=3DfyE6kNU4*t3GN!0$x7kjtKw9EDIyN-t+8mNb<#`
> zNF3=3D%vp93nWxVE1K*%UAQDF=3D(G(aRKug8;Ep7Z9oeI2|#H^_OUYrr72Uq{^QqQ)3=
`
> zYs9|H`e4AK#jvI}FL1L}Nk<~6IHoLd%Gt`wP8o}`f3Ub&|7vmNqh!gla!w*9QBnRg
> zRaTtxU1eqENw~u0CqQLi<4<trKK(6EF2|+HFQaS@io~p=3DR2ICJzj6c_yJ1)F?rg)=3D
> zUF}UP8*=3D^a4ZYb0PK1MfE27h=3DPUc<R9SsA!`&P8|?Bq1kyE}ucr8C#9$nKO98m{f=
_
> zf9HxE@Aqdr8g{m~ufQEw^f#}3eeRl`{>F1xzX8U!I&;p79sO-R?Ys2*Ak;L}*9+0m
> z-rLjJwX>nEf42~gor68?x%#%;?*Asy#Q2(X2C|dlN54z5VrS2wrkRzky`R(dFCe(p
> zMg4WFS7lZ;$3JfZ_Y-kG2`bWnehDSKU~AY^-;}OzG{I10q_<fk>8*VkNHgx&M#8UN
> zDMrfMnRK-^5_@LWKni=3DWC?j=3Dcv)OacX<pIMS-<taNwQz1i4@uBJ=3DR9QMdX)#bn=
1CU
> z+9>xw*+#cp8$HGXLiV|W6X~yQ^h%3$pSCt?Wf3R)XbJXf8@<wO^oX_5Cs|0#K3WF<
> z+D5M&8$}DdZ(19@hdpW8N0%b6C>#AxUwyyUF6>IyNc=3DH@epE{rYqFF!MlRzrl&dXW
> zf+cH2{H=3D3ETxKuW%7a%^6?6rn4x!d@4{6qXTfdZIDDYht6h>E)v-B%`L6^X*NT*yP
> z@CKGEb_>M3ihY20F9*7Tq`mOZ*uS6UZ&`G~S0!w9(57~K19dD>6TfRt)kWpsk!G7Y
> zfyya~kWx?f56pzES*@1m{T0O^sM#dojWKXSj0tLjrL*T%C1)?3T@%a=3DQnTo>&Qw*s
> zi7GBr<D#zWn@w`|nyT}vE}D0KbprjB|Ax6p8$3acNzGE*WW~aYr4{p70KCHLPB=3Dn_
> zl{|fNSd4LM<mL6j`PI>YUt6uwwaf|_?X2=3Di@&u|nWlAZSxhlAvx>r$G5h+R}m2=3DR=
h
> z6jc@JtGeFIV2mzL4T6j2iT~`yXm8GG!E37prOK^}Yo>ZRzj`e@BxVUIVSidP5&U%a
> zsn|Qf+(srh+Qz7F2hu}XBIDANJ%t%$ucUazM(MQe0u9BKC$zDV96KdQH|R)C+*qG{
> z-QOgiOH>?gXl!Umw>C5-XLnj$Lqj5g4u1SAJzQ-OBwwfq8qylD9dz;s@3v!pAz5)a
> zt@=3Di)8F*Sl-{TK`9ha{O^Vloj($g+yG4ydQubq<QUz(s{<tka)>Y^!9i3Yv0ERp;-
> zQ(qP&KXOyOt&l@BtmI#l3htm?Q^PqzG*|*~=3DZF{0Q))eE8#g3hT`#p-vL>}{O4Euz
> z(0%D95&myuDJ^d*AF!3*jVgifv2Y0(;1d@39)P-nOJp`M6YmkPeL;Pb=3DzeUWTLN)T
> z1OJPK?+oe%9JRn*A{A}Pg7<-wocd4Y)3)+2Y^8c?SfviZQc|Xb$Ea%6ImycU#)g$~
> zMrHC<_54LRO9zRaK%E#QVVHKW^myUC$X;;A;X*qD$!2_pu~|(-9+O^~Mh8|KO$|-x
> z6FoSOXvEH7tkIKa$`W`>b9$vEZ$x``#-Y%NLqr<07sq5(eZ$IhTKn}4Xc*^Osib<)
> zs)T9mxUr_wk*44OtE_2V-zT3)5~<KZQ{zfy4axcSw$zBO<XN%y?aXUJ71j}<lYVT2
> z$SBgj)v_!T*NdGv$Sx%LYSfc8R6`?^N<H}h8{<CXx|jE1dAdK=3DvH;fU-)c?q*sq?`
> zA3t<*U7!4;SpkZR9UuLsn_MKY8c0@0uAXipjQrpRMWv6GOUDW|7W@MT{;dT^9Qd>a
> zzv#fnEcjIiK72#H)#!8fJp3yfMs(4g{QFY^t0_6{WRO(Bj_(_Ge7~y8DqXQAKT^p6
> zlYe_{WUzDW6wsB$|A%!V&yn=3D^_73D4{JSj;gSmeD>+&bRr&F){P0{TFuGO;ryZIIB
> zwt=3Dj@+jNqfGWI@dLsw6G_h3hs+wa|-E2dV(+!E}_cGmCGYFW!nUF9XeX9Cs)$-ay2
> z-_GRhiyOH>Ow792{%z3TVg0eC70Fk9a)I>(7-%`peeH?B1UJsEKGnivtkvs%C%}i)
> zYq_V1GSxm|+Y8r1l33fx*Ub*seK`1F;^yT0%idT1-dX!j*{hqRmPXfz?1|gEPwP*5
> z_c*tUAM6eXdvaYnd-RM37ry^JR{%fnUP5$haYa*oW7CTMrgIw{oM~*5{kdtF8#Ix0
> z5^Bah+wNYTg0O$4i9QL~A0wY45{GQhHT)!b*A3asfZ<ob+x@$__71P-4gAhI7fYG8
> z{{FV>qhAEKEotJ_^9$oX4|_)##@C?tNc#!%yVeTZfhmV%lZS55^0tPu?Y8(f{!Shd
> zcJmbWw<b{(BJ7qa>=3Dh2Xj6yRhVbTX$$+wXL`<FuW*#WKxI6i3qMh}8a-S=3DKjZLA^=
T
> z<w5c&aotWzkrt6AkNVv8y9e5Kn0js+NBJ&Sva_<!)bqqjw*G>37p)j*+iB`|wdHo1
> z`i|>+Xc*-K{idG#wDmmNl+%yF`#=3DU9k2#1wD)e;^n0jlg`ho0ql&#L|`+Gau2HH&h
> z1zRqy&tBKnaa}|dnJ*%8<*VD_3BR`8UG4PM3y-Mnj$AHc&^ExsJUa#lvcT=3DVyY(0w
> zG}#@4JK@3oan(m)-{1~C5H<<xc_N2v+p(iRdyRwmOh(p~JNxwzS<C`$xuSlbeu}Xk
> zbem)xcRQ)}pI=3DxAiK3W{-8@VJVB28wun`Vu3F#D)=3Dr%&P5kyGY9r6GjjU;W~h)&N=
1
> z?Sf7`9bUPTHp}#Ekm&Th(A^ZalkC<Hb)u0Moli=3DVM5pJAUIL-#irnFfZ=3DpiZ28mA=
3
> z1vRs8BEJ?N9jaH7pX*s7mGwN)5OitEe!qaGoy6X(ZKLOrMxc{Cj-PV&eoQyX(Tzek
> z3SAhFSL1VZJZfn54BF`VsshT?jB$tK+ed}QBs%+S5_C_xK~g6=3DrFWAYoxVRaf)E2M
> zsf-WDZy4CoX)mzujqzsU3_3)zbkd6+6j=3D`4-BNsfIDWSR!>?}-`BS5$mWZDli=3D+D=
(
> zcy|A+?ezTEA?O^A>dEq_DbFFPD?L~CY|9jms!2L7=3DdFCA({HAKr)3I9)g;~LDNA>v
> zi@s?Sea}Yr)gc*Vw^5SxB04>f_T&Y|<SDyDbV^?#Il7K@f$3Oxe7k)eI`I|1KIr<O
> z6YLH*_Cr)aBQx7Wbgy#&x%$#kAgP=3Dt>G*x<UK<tdU*VL#7w5K;KcmovjtQ`n;l&wr
> zh4nn7<QjRn3fg+j&G{S9w+tB{4p%#a?u@O*JnWFry5iY0=3D)S=3DOyjc??J{(>B47w|=
}
> z^RA;KB6s>bFQ#*Pc@Da3924kNRC;qvN6{WzcA!HCkh><EXV5(lUBhwc?3TJ$zo6Zi
> z(1RVn8tUW&?pOnzePA)JaCFKOj)?s3tFd*8=3DSC?Hku+XF8(VySPv3xlGuPeW_&M0m
> z70-1f<IyT^M{v}$;&TK?Jtz)GaHMU;+X#+kk9*!SX=3DfO6zR%$aQXGntI+C&1DIP{}
> zB(UOM1hZewq4=3DgFY0m_-|A2#|Xrg$fBN>0SNpUHHBZpM{iC{&L=3DsDF0mgb^(62Y=3D=
c
> z6gMJxu7%yRpvm}*r#KMdYi+Li9>LMmtD4sle7eoupQQaNlY=3DDh{3(D^(mq8yRh6_)
> z(fY8?!c#|b`r3*1ubx6uN}AWqfX|u%hcn>CGvKqWN4RGW713mI2Pc4~feN?w1J=3Dl$
> z{q%INU}qmaEi8KHU-E3>ojt{0cxNv~e8Gj--ol>&?2a<?!wKP?y>%uLzaz1~xc-;L
> z{-FMSji~+Wpm*Qa2zZ)U{C36m)0e@-&prFB{#SXh8~-wI{H@^iT@SV6YcZCe&R5Y<
> zW3Hs&;D9HZh0*iX(NS$QwH)mDZ}aeyPv^<#NSP0NFfX0i{?vbToNoR&E-7>R(lf)+
> zG27DX9rNgj#(S05-<LrM{x@<bPwR(b^4Q*+JXrD#Nho_n{&2Sk3xC&bF*<I4p9c&7
> z!d=3DtxwUYrk@{fHVpN_xJgVlb+C#K`C@?hcj9hi>4*Mo(he{ec}nFkBM`cu>KtsX3V
> z^{1!fYdu)_*3V4G>svC>5sh!ugJl{0ri+hn9+`rL*Y$sNRGV+lfYo0r#_9`qR=3D!F2
> zOzVHzABc`>^L+{(9xVEFjCJjoPr^}q-9w3vNPf+M=3D!o#zE{~1~-|ax+o#fXhZ*)ZX
> z{SJ)rdVt8sKj6R^uYEKh|Fi>Rytbiy{0j~QA3b6nRcL-l9_@!jM<mbu$@vobv%696
> z;?*Wcj(%sx7wON%7rm`8hYlR9c(V}Lolk;9t<kgIE<Tt<%4lj%&UfI;f!+BiNX)bP
> zbLU50DXG7gCgWd~#haU*fK}#qXz$KfA@QvXcoFuwjeKsRI$9&e^g8>!k9z5UfU@u(
> z2G)FUWhpS1`I`s!zZdv9;JQ4qhFth3$lczN;BNu@-xK^NU>E;||32_x=3D3|Tc1J>fF
> z&XecWz;3@w^1K!}?cvt}zxe0)6nuog4EXLpo09(>z{|0(^dx*Y@L?_nZj9mUfZY*N
> zc>fIe<G}v+3?Bw=3DhW|2X#qV)o|NDl|0zZfTTz`jw-T81X=3DcA**yTEtE?SBNk-5bv=
=3D
> z^!zmVx)^^3@UzIfKZfgo<=3D>j)XVZTZu;1T0VE=3DoHTY(i1Tht!?wgYd6e|OC9oipG=
Z
> zuy6l&1N-{j2RtADxii-HEx`Ww8V>;L{H%3D4d>@S0p910@5{iqdGI%ZT|ARM`JFwZ
> z__|O0k@rWyDfI31A;!+1Q~2|#z-69&7XiEVSc>`mo4~%kRss9`_}xOYop?5a9n}A&
> zzz?DCFxJm+1Ft1MI{0c}U;ozu`}1iS*#92ooxnPu-6{Tz=3DhMK7e|N?D`%_^5dzD`S
> zJ~T?_9FqSTVE_A-W5A=3DH{{92l_otr$AM^b0RF>$9$9Kp5Ed+M^!y0cLu-|^U;COvd
> zlQ_-10eA%cZ$}=3D{UkH3%jF)_u0(YRl2V(ub4cP53YrLH^=3D=3D*{F?``e__P@9Jd%=
!xs
> zKO}jjFW|%8cpm}Q`MEB}e;xRkhkp+EIsE;p7=3DH}d|2}8gtm)&?Q%U~!I$sCu`_DPR
> z{`WgK0*4=3DvbtE4@909!CgS&x!{ag#|f6w#%z<&I>1NbWR+aiAG_W-aTza9YI;PL-5
> zu+D#1#q>`B_ubB#fn54}j$G@n>e%1@9eBPsKgv!ao_qYx0A7v#!kFJ{fv@uL=3DK}lV
> zSqtpX|BHZqf8GMD_0LA;t>no7AG(Jz#PVDX`~dT7S=3D`^Xz|uEvOT0MUd?1Dat^eN!
> z?0>)X9$<fdeim5k*{J<#=3DJUXAeIk8+1z7977Whe?G2o|00XXEpKLmE`A<_Q~*#ACi
> zO~rKkoCWO5zXEv3)7SaH`#tzd;Jdx}dkwJGzs^7J0QTok9=3DOG`*JpwK`2Q%d|2@`2
> zz*<kPMsAJo+raL6Y%bShe-G@(w<Ey!dh-1Q*!L$>*Jj#z%h>y>tEua7Pky!c599`T
> zm6eCUGMS6lZ^^V?v~?R_ea&P#dNVt_dv~;TXF3LY`*WGL!Rrj0-+kTLfow<pIjdK`
> z;rK)uZNSI3N!Tdwzn*WVvb~+@7~H-4dYX99^gAaa-I?v-edhK|^mZ*m@dE7NKv#Dz
> z!`^w@J2QiQ8T-O@{a{DeHMy>pncO?O`ZAQ$8FuHjD}UVTX}57S$_wARL4$lt>t*XM
> zXw6*q<~MJ>a9d{E1?yTb)X-mcL&vMIpT#wq4Zr=3D?3ogBAz0sY5_-;@pW8dJ+bn=3Dy=
4
> zqxW-LTHJ?Xn_<dbg3hL?@$gaG=3DpA_bd0d}VFD7TW5!#u{^!4WKjjpNp4(;8I_)E5a
> zqgV#}igDbS8wtD@OwYP?7U47chV8UwnOKn;b@UnE=3D)<~GMCXEv2ZnM1I=3Dg$@1_t?=
*
> zZb#=3D7im&DF%ua&cO+rokjBw`SYcgB1JG*k+nO)z_+xy(hnCvt9bnx^(Z8te}5`Eow
> z3M*|!618{IFRxEqpQ9E?N{+ugeEb&ru&<iLECwT4BYs`-q)C+Jo_$yJy<?x5ujSZ2
> z*0`v8K>aiHIF~ziuB0M2xI=3D~LGs8Zw88<QYePJIhXYk=3Dku_bDBW3E##XL571rzhK=
O
> z?@mq*V6dx6w<C||qf!EQP&3@)id{pFA8Wz3ip^{-VCC<y1BuO&o3j0&MA_Y|o}%{M
> zPKzBK8Z&;#Z!7fqqri(htoLVjTpvwn*S2#v-*2V`Z^Qcy_&~I7;_+J!9r5R&eJu0?
> z{HlRpMT2)mrif&cqhQL(Zu&6@knGbX`}D*H?8x<IP-Tbp5Ife`&*|BQMJ9Ko2s^7L
> zUj>dd84*R_koKjqU!wLaGBaJseWltb@&bXCB>J?rPce;6Jm1~-x2MrL%UH{LpTC|?
> zH0ccPJJ>!N_A{&)eP-LIvF;Qrfv<H>Lq&0;qs#N0PAg7iAm(95^a1a8&S=3D(k9igzx
> z*tc+<pU3xZC(jOwrhVLt-5vEZW#?$J$DbRY&Nz1V*m?CG@o9Lu+N8Tg-hyw+q5JxK
> z`F#`S4L?5uKm=3D&oas7Z7Qo0C#(RanCbF{aW(WAbbJ`FQD@j7*az$^8Y@<_f8>#4rG
> zM0U>Lq?!1~Kiuqy&rOaSBXi$upWYky$r)X)v%|)!$%&3-;Qcb$rhl5<=3Dj2O;7JQL*
> z<amZ;y0tXdqn}@y9GlLR4$utUsgM-QV?8DQcDvuH{S3Q3MNc;Eka_Hv;C;eL#!X!}
> GnEwmW9UP+o
>=20
> literal 0
> HcmV?d00001
>=20
> diff --git a/drivers/staging/iio/Documentation/sysfs-bus-iio b/driver=
s/staging/iio/Documentation/sysfs-bus-iio
> index 46a995d..ca12784 100644
> --- a/drivers/staging/iio/Documentation/sysfs-bus-iio
> +++ b/drivers/staging/iio/Documentation/sysfs-bus-iio
> @@ -453,9 +453,9 @@ What:		/sys/.../events/in_magn_z_raw_thresh_risin=
g_value
>  What:		/sys/.../events/in_magn_z_raw_thresh_falling_value
>  What:		/sys/.../events/in_voltageY_supply_raw_thresh_rising_value
>  What:		/sys/.../events/in_voltageY_supply_raw_thresh_falling_value
> +What:		/sys/.../events/in_voltageY_raw_thresh_rising_value
>  What:		/sys/.../events/in_voltageY_raw_thresh_falling_value
> -What:		/sys/.../events/in_voltageY_raw_thresh_falling_value
> -What:		/sys/.../events/in_tempY_raw_thresh_falling_value
> +What:		/sys/.../events/in_tempY_raw_thresh_rising_value
>  What:		/sys/.../events/in_tempY_raw_thresh_falling_value
>  KernelVersion:	2.6.37
>  Contact:	linux-iio@vger.kernel.org
> @@ -490,9 +490,9 @@ What:		/sys/.../events/in_magn_z_raw_roc_rising_v=
alue
>  What:		/sys/.../events/in_magn_z_raw_roc_falling_value
>  What:		/sys/.../events/in_voltageY_supply_raw_roc_rising_value
>  What:		/sys/.../events/in_voltageY_supply_raw_roc_falling_value
> +What:		/sys/.../events/in_voltageY_raw_roc_rising_value
>  What:		/sys/.../events/in_voltageY_raw_roc_falling_value
> -What:		/sys/.../events/in_voltageY_raw_roc_falling_value
> -What:		/sys/.../events/in_tempY_raw_roc_falling_value
> +What:		/sys/.../events/in_tempY_raw_roc_rising_value
>  What:		/sys/.../events/in_tempY_raw_roc_falling_value
>  KernelVersion:	2.6.37
>  Contact:	linux-iio@vger.kernel.org


--=20
Maxime Ripard, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
