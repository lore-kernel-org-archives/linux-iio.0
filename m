Return-Path: <SRS0=52cM=C6=pressers.name=steve@kernel.org>
Subject: Re: [PATCH 0/2] iio: accel: bmc150: Check for a second i2c resource
To: Lars Kellogg-Stedman <lars@oddbit.com>, Jeremy Cline <jeremy@jcline.org>
Cc: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
 Hans de Goede <hdegoede@redhat.com>, linux-iio@vger.kernel.org
References: <0100016009e7c075-ae3eb98f-22d0-4fae-bcff-93102508b227-000000@email.amazonses.com>
 <CA+Q+rdwpgoiHVqvkF-gTb8g1BsVRqQucNRm0nWcmtJvzeeyqHQ@mail.gmail.com>
From: Steven Presser <steve@pressers.name>
Message-ID: <53d5f05c-ac77-3a43-81fc-239be814bbca@pressers.name>
Date: Sat, 2 Dec 2017 11:32:19 -0500
MIME-Version: 1.0
In-Reply-To: <CA+Q+rdwpgoiHVqvkF-gTb8g1BsVRqQucNRm0nWcmtJvzeeyqHQ@mail.gmail.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-512; boundary="------------ms080007070001070109000608"
List-ID: <linux-iio@vger.kernel.org>

This is a cryptographically signed message in MIME format.

--------------ms080007070001070109000608
Content-Type: multipart/alternative;
 boundary="------------454FBD8DF58166163F5CB321"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------454FBD8DF58166163F5CB321
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Seconding this question.=C2=A0 Or does this merely require some configura=
tion?

I also have a Yoga 11e to try this on.=C2=A0 I built this last night and =
gave=20
it a try this morning.=C2=A0 The screen rotations I'm getting are reasona=
bly=20
correct, but don't seem to be accounting for the relative positions of=20
the screen and keyboard.=C2=A0 That is, I'm getting screen rotation in la=
ptop=20
mode and the keyboard isn't disabled in tent or tablet mode.

I should note this is definitely an improvement over what used to happen =

- screen rotations used to be 90 degrees off correct.

Thanks for all your work on this,

Steve


On 11/30/2017 04:19 PM, Lars Kellogg-Stedman wrote:
> On Wed, Nov 29, 2017 at 5:31 PM, Jeremy Cline <jeremy@jcline.org=20
> <mailto:jeremy@jcline.org>> wrote:
>
>     Some BOSC0200 ACPI devices, like the one in the Yoga 11e, have two =
i2c
>     accelerometers listed under a single ACPI device. This checks to
>     see if
>     there is an ACPI companion and if so handles a second i2c client.
>
>
> I am going to try this out (on a yoga 11e) over the weekend.
>
> Will this require an additional patch to iio-sensor-proxy in order to=20
> provide the appropriate input events to enter/exit tablet mode? I=20
> believe these need to be generated based on the relative position=20
> indicated by the two accelerometers.
> --=20
> Lars Kellogg-Stedman <lars@oddbit.com <mailto:lars@oddbit.com>> |=20
> larsks@{twitter, irc, github, ...}


--------------454FBD8DF58166163F5CB321
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html>
  <head>
    <meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dutf=
-8">
  </head>
  <body text=3D"#000000" bgcolor=3D"#FFFFFF">
    <p>Seconding this question.=C2=A0 Or does this merely require some
      configuration?</p>
    <p>I also have a Yoga 11e to try this on.=C2=A0 I built this last nig=
ht
      and gave it a try this morning.=C2=A0 The screen rotations I'm gett=
ing
      are reasonably correct, but don't seem to be accounting for the
      relative positions of the screen and keyboard.=C2=A0 That is, I'm
      getting screen rotation in laptop mode and the keyboard isn't
      disabled in tent or tablet mode.</p>
    <p>I should note this is definitely an improvement over what used to
      happen - screen rotations used to be 90 degrees off correct.</p>
    <p>Thanks for all your work on this,</p>
    <p>Steve<br>
    </p>
    <br>
    <div class=3D"moz-cite-prefix">On 11/30/2017 04:19 PM, Lars
      Kellogg-Stedman wrote:<br>
    </div>
    <blockquote type=3D"cite"
cite=3D"mid:CA+Q+rdwpgoiHVqvkF-gTb8g1BsVRqQucNRm0nWcmtJvzeeyqHQ@mail.gmai=
l.com">
      <div dir=3D"ltr">
        <div class=3D"gmail_extra">
          <div class=3D"gmail_quote">On Wed, Nov 29, 2017 at 5:31 PM,
            Jeremy Cline <span dir=3D"ltr">&lt;<a
                href=3D"mailto:jeremy@jcline.org" target=3D"_blank"
                moz-do-not-send=3D"true">jeremy@jcline.org</a>&gt;</span>=

            wrote:<br>
            <blockquote class=3D"gmail_quote" style=3D"margin:0 0 0
              .8ex;border-left:1px #ccc solid;padding-left:1ex">Some
              BOSC0200 ACPI devices, like the one in the Yoga 11e, have
              two i2c<br>
              accelerometers listed under a single ACPI device. This
              checks to see if<br>
              there is an ACPI companion and if so handles a second i2c
              client.<br>
            </blockquote>
            <div><br>
            </div>
            <div>I am going to try this out (on a yoga 11e) over the
              weekend.</div>
            <div><br>
            </div>
            <div>Will this require an additional patch to
              iio-sensor-proxy in order to provide the appropriate input
              events to enter/exit tablet mode? I believe these need to
              be generated based on the relative position indicated by
              the two accelerometers.<br>
            </div>
            <div>=C2=A0</div>
          </div>
          -- <br>
          <div class=3D"gmail_signature" data-smartmail=3D"gmail_signatur=
e">
            <div dir=3D"ltr">
              <div>
                <div dir=3D"ltr">
                  <div>
                    <div dir=3D"ltr">
                      <div><font face=3D"monospace, monospace">Lars
                          Kellogg-Stedman &lt;<a
                            href=3D"mailto:lars@oddbit.com"
                            target=3D"_blank" moz-do-not-send=3D"true">la=
rs@oddbit.com</a>&gt;
                          | larsks@{twitter, irc, github, ...}</font></di=
v>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------454FBD8DF58166163F5CB321--

--------------ms080007070001070109000608
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgMFADCABgkqhkiG9w0BBwEAAKCC
C+QwggXiMIIDyqADAgECAhBrp4p9CteI1lEK+Vnk57ThMA0GCSqGSIb3DQEBCwUAMH0xCzAJ
BgNVBAYTAklMMRYwFAYDVQQKEw1TdGFydENvbSBMdGQuMSswKQYDVQQLEyJTZWN1cmUgRGln
aXRhbCBDZXJ0aWZpY2F0ZSBTaWduaW5nMSkwJwYDVQQDEyBTdGFydENvbSBDZXJ0aWZpY2F0
aW9uIEF1dGhvcml0eTAeFw0xNTEyMTYwMTAwMDVaFw0zMDEyMTYwMTAwMDVaMHUxCzAJBgNV
BAYTAklMMRYwFAYDVQQKEw1TdGFydENvbSBMdGQuMSkwJwYDVQQLEyBTdGFydENvbSBDZXJ0
aWZpY2F0aW9uIEF1dGhvcml0eTEjMCEGA1UEAxMaU3RhcnRDb20gQ2xhc3MgMSBDbGllbnQg
Q0EwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQC9fdr3w6J9g/Zbgv3bW1+uHht1
wLUZr5gkrLtXedg17AkefMyUGwrQdvwObhajcVmnKVxhrUwkZPXRAwZZosRHfEIi5FH7x6SV
/8Sp5lZEuiMnvMFG2MzLA84J6Ws5T4NfXZ0qn4TPgnr3X2vPVS51M7Ua9nIJgn8jvTra4eyy
QzxvuA/GZwKg7VQfDCmCS+kICslYYWgXOMt2xlsSslxLce0CGWRsT8EpMyt1iDflSjXZIsE7
m1uTyHaKZspMLyIyz6mySu8j8BWWHpChNNeTrFuhVfrOAyDPFJVUvKZCLKBhibTLloyy+Lat
oWELrjdI4a8StZY8+dIR9t4APXGzAgMBAAGjggFkMIIBYDAOBgNVHQ8BAf8EBAMCAQYwHQYD
VR0lBBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMEMBIGA1UdEwEB/wQIMAYBAf8CAQAwMgYDVR0f
BCswKTAnoCWgI4YhaHR0cDovL2NybC5zdGFydHNzbC5jb20vc2ZzY2EuY3JsMGYGCCsGAQUF
BwEBBFowWDAkBggrBgEFBQcwAYYYaHR0cDovL29jc3Auc3RhcnRzc2wuY29tMDAGCCsGAQUF
BzAChiRodHRwOi8vYWlhLnN0YXJ0c3NsLmNvbS9jZXJ0cy9jYS5jcnQwHQYDVR0OBBYEFCSB
bDlhvkkPj7cbRivJKLUnSG1oMB8GA1UdIwQYMBaAFE4L7xqkQFulF2mHMMo0aEPQQa7yMD8G
A1UdIAQ4MDYwNAYEVR0gADAsMCoGCCsGAQUFBwIBFh5odHRwOi8vd3d3LnN0YXJ0c3NsLmNv
bS9wb2xpY3kwDQYJKoZIhvcNAQELBQADggIBAIvj94fsAYuErQ8BAluc4SMnIwS9NPBwAm5S
H9uh2NCXTq7im61g7F1LIiNI/+wq37fUuaMbz4g7VarKQTgf8ubs0p7NZWcIe7Bvem2AWaXB
sxsaRTYw5kG3DN8pd1hSEUuFoTa7DmNeFe8tiK1BrL3rbA/m48jp4AiFXgvxprJrW7izsyet
OrRHPbkW4Y07v29MdhaPv3u1JELyszXqOzjIYo4sWlC8iDQXwgSW/ntvWy2n4LuiaozlCfXl
149tKeqvwlvrla2Yklue/quWp9j9ou4T/OY0CXMuY+B8wNK0ohd2D4ShgFlMSjzAFRoHGKF8
1snTr2d1A7Ew02oF6UQyCkC2aNNsK5cWOojBar5c7HplX9aHYUCZouxIeU28SONJAxnATgR4
cJ2jrpmYSz/kliUJ46S6UpVDo/ebn9c6PaM/XtDYCCaM/7XX6wc3s++sbQ7CtCn1Ax7df6uf
QbwyO0V+oFa9H0KAsjHMzcwk3EV2B2NLatidKE/m7G+rB9m+FlVgIiSp0mGlg43QO9Kh1+Jq
vTCIzv2bJJkmPMLQJNuKKwHNL8F4GGp6jbAV+WL+LDeGfVcq8DHS3LrD+xyYEXQBiqZEdiPV
OMxLDSUCXsDO0uCWpaNQ8j6y6S9p0xE/Ga0peVLadVHhqf9nXqKaxnr358VgfrxzUIrvOaOj
MIIF+jCCBOKgAwIBAgIQblaS/9kadBN5WggiIMdzXzANBgkqhkiG9w0BAQsFADB1MQswCQYD
VQQGEwJJTDEWMBQGA1UEChMNU3RhcnRDb20gTHRkLjEpMCcGA1UECxMgU3RhcnRDb20gQ2Vy
dGlmaWNhdGlvbiBBdXRob3JpdHkxIzAhBgNVBAMTGlN0YXJ0Q29tIENsYXNzIDEgQ2xpZW50
IENBMB4XDTE2MDgxMDIyNDkxN1oXDTE5MTExMDIyNDkxN1owQjEcMBoGA1UEAwwTc3RldmVA
cHJlc3NlcnMubmFtZTEiMCAGCSqGSIb3DQEJARYTc3RldmVAcHJlc3NlcnMubmFtZTCCAiIw
DQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIBANawlmrhSo5cCRT6pKi1VGoktCtiFh3vwsY3
D+KnXNxrTaVWcrqvEnWrcx6CYctQbvUWnxPt1Yrgnsev4TSNqPqIv+oqkwiho3UOM9AutTLa
U8RsNkoercgA7klslpjC3ItaWazN5BlRaZ8QWwpg6TjRATEG5RvNMbi31DHNM/1yinv7U495
SOSue5jvKvW639GlwxTUfWrUmtmtKJZSMpAYKwnhSehxyN8E3vzd82j4MvlrFSvPEdfIVPkt
o3K0BNAwYd2eHPVlHlWEBekNAzCQqY2vxPTjzlsusYV9lKzCPQ439D4XEWRvEDVS+wCcWepv
dgXqz38rzm4BO3T7udBDBvy2KaImZpPm1y/VHQ8ZFuRHJsdkq+E63wZuTuYFY1RJGm68vaV/
gxFSDZc4adZ/HG0+2/kPc/NuZa66yP4n58irIZXWBe6b6PvET3SUEA7HmsU1arLXVwE/TkPS
/QmGKZLCRrzpgeAP2bwuZMr+dXoNeGlGaf9TBhMXRqrRM+rvWrTst/745uqV5pUTQSJE8xha
SXUanZWZ3COcHiepdq7Lr09XAXU4QU29SgOi7cpxdZAUe0apsTMMWhJYBvISQVBvYZqPPj1X
WuCR4mAUouL8zFvt108F8iTh3VU1lCAI3ulrGqPPlJF7AXEtUGggkxwxnQR7p1Kk/BYeJn4T
AgMBAAGjggG3MIIBszAOBgNVHQ8BAf8EBAMCBLAwHQYDVR0lBBYwFAYIKwYBBQUHAwIGCCsG
AQUFBwMEMAkGA1UdEwQCMAAwHQYDVR0OBBYEFHEeAfB8TH+O1yTnfhhCM4F+NomZMB8GA1Ud
IwQYMBaAFCSBbDlhvkkPj7cbRivJKLUnSG1oMG8GCCsGAQUFBwEBBGMwYTAkBggrBgEFBQcw
AYYYaHR0cDovL29jc3Auc3RhcnRzc2wuY29tMDkGCCsGAQUFBzAChi1odHRwOi8vYWlhLnN0
YXJ0c3NsLmNvbS9jZXJ0cy9zY2EuY2xpZW50MS5jcnQwOAYDVR0fBDEwLzAtoCugKYYnaHR0
cDovL2NybC5zdGFydHNzbC5jb20vc2NhLWNsaWVudDEuY3JsMB4GA1UdEQQXMBWBE3N0ZXZl
QHByZXNzZXJzLm5hbWUwIwYDVR0SBBwwGoYYaHR0cDovL3d3dy5zdGFydHNzbC5jb20vMEcG
A1UdIARAMD4wPAYLKwYBBAGBtTcBAgUwLTArBggrBgEFBQcCARYfaHR0cHM6Ly93d3cuc3Rh
cnRzc2wuY29tL3BvbGljeTANBgkqhkiG9w0BAQsFAAOCAQEAOBc5QbBzQ4Ghvh1xoHKcCsMj
xm38z1Z3bPWYmEWs0mQVjfT6otJ5dAhmJW8MS2I3MTIg/s8w8b9nSzah84JZT4/pqN0BLvfW
paEn3R3k2OtMnqYNglNEd45PwZO17wD1vqBSoArRXsgGn3X/jTbM+bC7E1c1AnqTePhNdd+d
nGvzFA52eL1HeyecgofMANKiFGViUBFVBW5No1rtw0cF9FVrNMubsLE5J/e/j8OOPYO/pMfr
ruOcbAPTHTEmDJJhYQ/9GQoTBOAR2J2BzbLmjNIjwnxCKggIP5QR59JBQ11JPn9MoX82GRGB
wVGNBj2Rifdg20JXDLuhQUdNVZIIhDGCBOwwggToAgEBMIGJMHUxCzAJBgNVBAYTAklMMRYw
FAYDVQQKEw1TdGFydENvbSBMdGQuMSkwJwYDVQQLEyBTdGFydENvbSBDZXJ0aWZpY2F0aW9u
IEF1dGhvcml0eTEjMCEGA1UEAxMaU3RhcnRDb20gQ2xhc3MgMSBDbGllbnQgQ0ECEG5Wkv/Z
GnQTeVoIIiDHc18wDQYJYIZIAWUDBAIDBQCgggIzMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0B
BwEwHAYJKoZIhvcNAQkFMQ8XDTE3MTIwMjE2MzIxOVowTwYJKoZIhvcNAQkEMUIEQGbDg0ug
kVGzQnYpObzvAlcm5w9WvF4Eo0Zn1vy4tBwF+obMNMAc9CzLMpnRh1wJdOdliboSUZUQXMnN
zsUmtpEwbAYJKoZIhvcNAQkPMV8wXTALBglghkgBZQMEASowCwYJYIZIAWUDBAECMAoGCCqG
SIb3DQMHMA4GCCqGSIb3DQMCAgIAgDANBggqhkiG9w0DAgIBQDAHBgUrDgMCBzANBggqhkiG
9w0DAgIBKDCBmgYJKwYBBAGCNxAEMYGMMIGJMHUxCzAJBgNVBAYTAklMMRYwFAYDVQQKEw1T
dGFydENvbSBMdGQuMSkwJwYDVQQLEyBTdGFydENvbSBDZXJ0aWZpY2F0aW9uIEF1dGhvcml0
eTEjMCEGA1UEAxMaU3RhcnRDb20gQ2xhc3MgMSBDbGllbnQgQ0ECEG5Wkv/ZGnQTeVoIIiDH
c18wgZwGCyqGSIb3DQEJEAILMYGMoIGJMHUxCzAJBgNVBAYTAklMMRYwFAYDVQQKEw1TdGFy
dENvbSBMdGQuMSkwJwYDVQQLEyBTdGFydENvbSBDZXJ0aWZpY2F0aW9uIEF1dGhvcml0eTEj
MCEGA1UEAxMaU3RhcnRDb20gQ2xhc3MgMSBDbGllbnQgQ0ECEG5Wkv/ZGnQTeVoIIiDHc18w
DQYJKoZIhvcNAQEBBQAEggIAZDw2W5FubgpUQJxgxvCHcb5D1U1tx8qsG9gMR3EoyFRqWuiI
UFEfGhnBNyX0Vmfn07doTcRaral32M/BBDiMRMvpRNqzKItzswHVjyzL6i4rA/Nb/tmHobMY
howfZB8BVdu8BQTHC4ZeX6xCCYOBe+RkpTmHpucMbbomNeVwRtnq3I6FJ2gfFSY77FYWA4p4
OUqrTALQxCBNZoTCNWAyKe2FsC1QPJ0cnUCMSd9JYc8jXe2uBbs2xK/v7voGt+k4xTLKotTd
i12yB8V+xWRDYBSxz2gwlWcLvjH6u/PkHen0149BwCuT7nK+Qr2X1I9LX5Ya21yx4UCZiiHS
aD4dqdpNGm3wmzekpd0iwEzOruSvdr0YMzIMqjl4dresSn3fM5ZBSHKXzUUHv8CJ2qEAvLOf
wSxuiiOkEBCRdqtwCUaxXoHHrM6ab1SnoN3HfqPweTlqlQApuYXQusNhxGo3++fXPxw3v9TI
ZbLfZz6cWNXmN5QaDp93rlKfzvVyF21D/518XB8rCf/4iv9UFEDV4a0p1RHJ66snxoAGYZQo
xOnK1S4k1SVVDjCXwSyzzG0fYENqjPfetBrg7V6bQ8TLFQ7ltz0s7J4k/BdQbOQYQcpwJS6r
uyTNQwUidO/tlryLj4pUMySdSv78PCqgL4lB4EM9R1UeSrEakvlPI/BXLOQAAAAAAAA=
--------------ms080007070001070109000608--
