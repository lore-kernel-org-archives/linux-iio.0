Return-Path: <SRS0=sSmz=F6=gmail.com=john3909@kernel.org>
From: John Syne <john3909@gmail.com>
Message-Id: <4C40CEF5-252C-47A0-9851-0A0DE1DD7322@gmail.com>
Content-Type: multipart/alternative;
	boundary="Apple-Mail=_BA0C5376-4BCE-4702-960C-8452366C2191"
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: Removal of iio (staging) meter/ade7753, ade7754, ade7758, ade7759
 and ade7854
Date: Wed, 7 Mar 2018 16:22:43 -0800
In-Reply-To: <20180307211912.68752ce0@archlinux>
Cc: linux-iio@vger.kernel.org,
 Michael Hennerich <michael.hennerich@analog.com>
To: Jonathan Cameron <jic23@kernel.org>
References: <20180307211912.68752ce0@archlinux>
List-ID: <linux-iio@vger.kernel.org>


--Apple-Mail=_BA0C5376-4BCE-4702-960C-8452366C2191
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

Hi Jonathan,

I=E2=80=99m using the ADE7878 and I made several changes that I did not =
send to mainline. If someone is willing to clean these drivers up as =
proposed, I am willing to test the drivers with hardware (I have both =
ADE7878 EVAL and ADE9000 EVAL boards) and send through any required =
changes. These changes were made about a year ago, so my patches will =
probably need some work for the current driver.=20

For the most part, there was a problem with checking the return value =
from I2C communications (return is either negative or the number of =
bytes read/write), the read32 requires 4 bytes not 3. Other than that, I =
renamed the registers to match the data sheet and added many of the =
missing registers.=20

I am currently looking at updating our hardware to ADE9000 and the =
ADE7758 looks like a good template for me to follow with core, ring and =
trigger functionality. I=E2=80=99m also looking to add DMA support to =
stream waveforms. I=E2=80=99m not sure if Analog Devices is looking to =
develop a driver for ADE9000.=20

One thing I don=E2=80=99t like is the mixing of register definitions in =
meter.h. Each data sheet uses different naming conventions for registers =
that have similar functionality, which means the common name used in =
meter.h does not match the data sheet and that is very confusing. There =
is also inconsistencies when naming the attributes; sometimes they =
follow the register name like avrms or cwgain, and sometimes they are =
given functional names like =E2=80=9Cvolt_a" or =E2=80=9Cactive_power_c_ga=
in". I propose that each part have its own include file and that the =
naming convention follow the data sheet and listed in the same order as =
the data sheet.=20

Regards,
John





> On Mar 7, 2018, at 1:19 PM, Jonathan Cameron <jic23@kernel.org> wrote:
>=20
> Hi All,
>=20
> All of these parts are apparently marked as not being for new designs
> and we have no known access to hardware suitable for testing the major =
changes
> needed for these drivers to graduate from staging.
>=20
> Given this, unless someone expresses an interest (and has hardware for
> testing) I propose to drop these drivers from staging next kernel =
cycle
> (so in around 3 months time).
>=20
> Of course I hope that someone can help us keep support for these parts
> and we won't end up dropping them, but they are old and several =
generations
> behind the current Analog Devices offerings.
>=20
> Please share this with anyone you happen to know who is using any
> of these energy meters.
>=20
> Thanks,
> =09
> Jonathan
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


--Apple-Mail=_BA0C5376-4BCE-4702-960C-8452366C2191
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=utf-8

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html; =
charset=3Dutf-8"></head><body style=3D"word-wrap: break-word; =
-webkit-nbsp-mode: space; line-break: after-white-space;" class=3D""><div =
class=3D"">Hi Jonathan,</div><div class=3D""><br class=3D""></div>I=E2=80=99=
m using the ADE7878 and I made several changes that I did not send to =
mainline. If someone is willing to clean these drivers up as proposed, I =
am willing to test the drivers with hardware (I have both ADE7878 EVAL =
and ADE9000 EVAL boards) and send through any required changes. These =
changes were made about a year ago, so my patches will probably need =
some work for the current driver.&nbsp;<div class=3D""><br =
class=3D""></div><div class=3D"">For the most part, there was a problem =
with checking the return value from I2C communications (return is either =
negative or the number of bytes read/write), the read32 requires 4 bytes =
not 3. Other than that, I renamed the registers to match the data sheet =
and added many of the missing registers.&nbsp;</div><div class=3D""><div =
class=3D""><br class=3D""></div><div class=3D"">I am currently looking =
at updating our hardware to ADE9000 and the ADE7758 looks like a good =
template for me to follow with core, ring and trigger functionality. =
I=E2=80=99m also looking to add DMA support to stream waveforms. I=E2=80=99=
m not sure if Analog Devices is looking to develop a driver for =
ADE9000.&nbsp;</div><div class=3D""><br class=3D""></div><div =
class=3D"">One thing I don=E2=80=99t like is the mixing of register =
definitions in meter.h. Each data sheet uses different naming =
conventions for registers that have similar functionality, which means =
the common name used in meter.h does not match the data sheet and that =
is very confusing. There is also inconsistencies when naming the =
attributes; sometimes they follow the register name like avrms or =
cwgain, and sometimes they are given functional names like =E2=80=9Cvolt_a=
" or =E2=80=9Cactive_power_c_gain". I propose that each part have its =
own include file and that the naming convention follow the data sheet =
and listed in the same order as the data sheet.&nbsp;<br class=3D""><div =
class=3D"">
<div style=3D"color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: =
normal; letter-spacing: normal; orphans: auto; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; widows: =
auto; word-spacing: 0px; -webkit-text-size-adjust: auto; =
-webkit-text-stroke-width: 0px; word-wrap: break-word; =
-webkit-nbsp-mode: space; line-break: after-white-space;" class=3D""><div =
class=3D""><br class=3D"Apple-interchange-newline">Regards,</div><div =
class=3D"">John</div><div class=3D""><br class=3D""></div><div =
class=3D""><br class=3D""></div></div><br =
class=3D"Apple-interchange-newline" style=3D"color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
orphans: auto; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: auto; word-spacing: 0px; =
-webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px;"><br =
class=3D"Apple-interchange-newline">
</div>
<div><br class=3D""><blockquote type=3D"cite" class=3D""><div =
class=3D"">On Mar 7, 2018, at 1:19 PM, Jonathan Cameron &lt;<a =
href=3D"mailto:jic23@kernel.org" class=3D"">jic23@kernel.org</a>&gt; =
wrote:</div><br class=3D"Apple-interchange-newline"><div class=3D""><div =
class=3D"">Hi All,<br class=3D""><br class=3D"">All of these parts are =
apparently marked as not being for new designs<br class=3D"">and we have =
no known access to hardware suitable for testing the major changes<br =
class=3D"">needed for these drivers to graduate from staging.<br =
class=3D""><br class=3D"">Given this, unless someone expresses an =
interest (and has hardware for<br class=3D"">testing) I propose to drop =
these drivers from staging next kernel cycle<br class=3D"">(so in around =
3 months time).<br class=3D""><br class=3D"">Of course I hope that =
someone can help us keep support for these parts<br class=3D"">and we =
won't end up dropping them, but they are old and several generations<br =
class=3D"">behind the current Analog Devices offerings.<br class=3D""><br =
class=3D"">Please share this with anyone you happen to know who is using =
any<br class=3D"">of these energy meters.<br class=3D""><br =
class=3D"">Thanks,<br class=3D""><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span><br class=3D"">Jonathan<br =
class=3D"">--<br class=3D"">To unsubscribe from this list: send the line =
"unsubscribe linux-iio" in<br class=3D"">the body of a message to <a =
href=3D"mailto:majordomo@vger.kernel.org" =
class=3D"">majordomo@vger.kernel.org</a><br class=3D"">More majordomo =
info at &nbsp;<a href=3D"http://vger.kernel.org/majordomo-info.html" =
class=3D"">http://vger.kernel.org/majordomo-info.html</a><br =
class=3D""></div></div></blockquote></div><br =
class=3D""></div></div></body></html>=

--Apple-Mail=_BA0C5376-4BCE-4702-960C-8452366C2191--
