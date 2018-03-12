Return-Path: <SRS0=mzGy=GC=gmail.com=john3909@kernel.org>
From: John Syne <john3909@gmail.com>
Message-Id: <A4D8DA6C-EECE-4333-92AE-D2861D8A7D50@gmail.com>
Content-Type: multipart/alternative;
	boundary="Apple-Mail=_4CBF3BBB-CCB0-4284-A686-B20AD02608A5"
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: Removal of iio (staging) meter/ade7753, ade7754, ade7758, ade7759
 and ade7854
Date: Mon, 12 Mar 2018 15:00:04 -0700
In-Reply-To: <20180312175539.00001e4d@huawei.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
 linux-iio@vger.kernel.org,
 Michael Hennerich <michael.hennerich@analog.com>,
 Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20180307211912.68752ce0@archlinux>
 <ADF8B8A0-EE33-4E1D-8902-894D35801EE3@gmail.com>
 <20180312175539.00001e4d@huawei.com>
List-ID: <linux-iio@vger.kernel.org>


--Apple-Mail=_4CBF3BBB-CCB0-4284-A686-B20AD02608A5
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

Hi Jonathan,

I=E2=80=99m glad to help in any way I can. I have e-mailed my patches to =
Rodrigo and I=E2=80=99m willing to move those patches to a latter kernel =
if he has any difficulty. Some of the patches may not be suitable for =
IIO as I created a audio codec to stream the measurement samples via =
I2S. The ADE7878 has an SPI master interface, which requires the Kernel =
to support an SPI slave interface, which we know does exist. We used =
some hardware to convert the ADE7878 SPI master to I2S and since the I2S =
driver is part of ALSA, we created a codec to stream the measurement =
samples.  This is one of the reasons why we want to migrate to ADE9000 =
since it support an SPI Slave interface and this makes the driver much =
simpler.=20

Regards,
John

> On Mar 12, 2018, at 9:55 AM, Jonathan Cameron =
<Jonathan.Cameron@huawei.com> wrote:
>=20
> On Wed, 7 Mar 2018 16:27:29 -0800
> John Syne <john3909@gmail.com <mailto:john3909@gmail.com>> wrote:
>=20
>> Hi Jonathan,
> Hi John
>>=20
>> I=E2=80=99m using the ADE7878 and I made several changes that I did =
not send
>> to mainline. If someone is willing to clean these drivers up as
>> proposed, I am willing to test the drivers with hardware (I have both
>> ADE7878 EVAL and ADE9000 EVAL boards) and send through any required
>> changes. These changes were made about a year ago, so my patches will
>> probably need some work for the current driver.=20
> Great.
>>=20
>> For the most part, there was a problem with checking the return value
>> from I2C communications (return is either negative or the number of
>> bytes read/write), the read32 requires 4 bytes not 3. Other than
>> that, I renamed the registers to match the data sheet and added many
>> of the missing registers.=20
> Cool - seems to me that whoever wants to take this one should email
> you and get those patches.  The first job then becomes bringing those
> up to date.
>=20
>>=20
>> I am currently looking at updating our hardware to ADE9000 and the
>> ADE7758 looks like a good template for me to follow with core, ring
>> and trigger functionality. I=E2=80=99m also looking to add DMA =
support to
>> stream waveforms. I=E2=80=99m not sure if Analog Devices is looking =
to
>> develop a driver for ADE9000.=20
> DMA support would be interesting.  Obviously good to have such
> a driver whether you are Analog writes it.  I wouldn't take the
> current ade7758 as a template though.  I haven't looked at it for
> a while, but IIRC it's quite some way from where we want to be
> in terms of userspace ABI.
>=20
>>=20
>> One thing I don=E2=80=99t like is the mixing of register definitions =
in
>> meter.h. Each data sheet uses different naming conventions for
>> registers that have similar functionality, which means the common
>> name used in meter.h does not match the data sheet and that is very
>> confusing. There is also inconsistencies when naming the attributes;
>> sometimes they follow the register name like avrms or cwgain, and
>> sometimes they are given functional names like =E2=80=9Cvolt_a" or
>> =E2=80=9Cactive_power_c_gain". I propose that each part have its own =
include
>> file and that the naming convention follow the data sheet and listed
>> in the same order as the data sheet.=20
> Meter.h is going to go away in any cleanup of this driver.
> We changed a lot of how we do things since those early days of IIO.
> All of this ABI needs proper consideration and may well end up
> entirely different from what it is now.  Basically the driver need
> wrenching into the modern world ;)
>=20
> I just took a very brief look and it's better than some of the
> other meter drivers but still a lot of work to do.
>=20
> Anyhow, short term upshot is I won't drop this one from staging
> next cycle, but we'll keep it under review dependent on whether it
> looks like anyone is interested in working on it or not!
>=20
> Thanks for your kind offer to test - that gets us half the way.
>=20
> Jonathan
>>=20
>> Regards,
>> John
>>=20
>>=20
>>=20
>>=20
>>=20
>>> On Mar 7, 2018, at 1:19 PM, Jonathan Cameron <jic23@kernel.org>
>>> wrote:
>>>=20
>>> Hi All,
>>>=20
>>> All of these parts are apparently marked as not being for new
>>> designs and we have no known access to hardware suitable for
>>> testing the major changes needed for these drivers to graduate from
>>> staging.
>>>=20
>>> Given this, unless someone expresses an interest (and has hardware
>>> for testing) I propose to drop these drivers from staging next
>>> kernel cycle (so in around 3 months time).
>>>=20
>>> Of course I hope that someone can help us keep support for these
>>> parts and we won't end up dropping them, but they are old and
>>> several generations behind the current Analog Devices offerings.
>>>=20
>>> Please share this with anyone you happen to know who is using any
>>> of these energy meters.
>>>=20
>>> Thanks,
>>> =09
>>> Jonathan
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe
>>> linux-iio" in the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html =20=

>>=20
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio"
>> in the body of a message to majordomo@vger.kernel.org =
<mailto:majordomo@vger.kernel.org>
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html =
<http://vger.kernel.org/majordomo-info.html>

--Apple-Mail=_4CBF3BBB-CCB0-4284-A686-B20AD02608A5
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=utf-8

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html; =
charset=3Dutf-8"></head><body style=3D"word-wrap: break-word; =
-webkit-nbsp-mode: space; line-break: after-white-space;" class=3D"">Hi =
Jonathan,<div class=3D""><br class=3D""></div><div class=3D"">I=E2=80=99m =
glad to help in any way I can. I have e-mailed my patches to Rodrigo and =
I=E2=80=99m willing to move those patches to a latter kernel if he has =
any difficulty. Some of the patches may not be suitable for IIO as I =
created a audio codec to stream the measurement samples via I2S. The =
ADE7878 has an SPI master interface, which requires the Kernel to =
support an SPI slave interface, which we know does exist. We used some =
hardware to convert the ADE7878 SPI master to I2S and since the I2S =
driver is part of ALSA, we created a codec to stream the measurement =
samples. &nbsp;This is one of the reasons why we want to migrate to =
ADE9000 since it support an SPI Slave interface and this makes the =
driver much simpler.&nbsp;<br class=3D""><div class=3D"">
<div style=3D"color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: =
normal; letter-spacing: normal; orphans: auto; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; widows: =
auto; word-spacing: 0px; -webkit-text-size-adjust: auto; =
-webkit-text-stroke-width: 0px; word-wrap: break-word; =
-webkit-nbsp-mode: space; line-break: after-white-space;" class=3D""><div =
class=3D""><br class=3D"Apple-interchange-newline">Regards,</div><div =
class=3D"">John</div></div>
</div>
<div><br class=3D""><blockquote type=3D"cite" class=3D""><div =
class=3D"">On Mar 12, 2018, at 9:55 AM, Jonathan Cameron &lt;<a =
href=3D"mailto:Jonathan.Cameron@huawei.com" =
class=3D"">Jonathan.Cameron@huawei.com</a>&gt; wrote:</div><br =
class=3D"Apple-interchange-newline"><div class=3D""><span =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; float: none; =
display: inline !important;" class=3D"">On Wed, 7 Mar 2018 16:27:29 =
-0800</span><br style=3D"font-family: Helvetica; font-size: 12px; =
font-style: normal; font-variant-caps: normal; font-weight: normal; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px;" class=3D""><span style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; float: none; display: =
inline !important;" class=3D"">John Syne &lt;</span><a =
href=3D"mailto:john3909@gmail.com" style=3D"font-family: Helvetica; =
font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: normal; letter-spacing: normal; orphans: auto; text-align: =
start; text-indent: 0px; text-transform: none; white-space: normal; =
widows: auto; word-spacing: 0px; -webkit-text-size-adjust: auto; =
-webkit-text-stroke-width: 0px;" class=3D"">john3909@gmail.com</a><span =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; float: none; =
display: inline !important;" class=3D"">&gt; wrote:</span><br =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D""><br=
 style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px;" =
class=3D""><blockquote type=3D"cite" style=3D"font-family: Helvetica; =
font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: normal; letter-spacing: normal; orphans: auto; text-align: =
start; text-indent: 0px; text-transform: none; white-space: normal; =
widows: auto; word-spacing: 0px; -webkit-text-size-adjust: auto; =
-webkit-text-stroke-width: 0px;" class=3D"">Hi Jonathan,<br =
class=3D""></blockquote><span style=3D"font-family: Helvetica; =
font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: normal; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; float: none; display: =
inline !important;" class=3D"">Hi John</span><br style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D""><blockquote=
 type=3D"cite" style=3D"font-family: Helvetica; font-size: 12px; =
font-style: normal; font-variant-caps: normal; font-weight: normal; =
letter-spacing: normal; orphans: auto; text-align: start; text-indent: =
0px; text-transform: none; white-space: normal; widows: auto; =
word-spacing: 0px; -webkit-text-size-adjust: auto; =
-webkit-text-stroke-width: 0px;" class=3D""><br class=3D"">I=E2=80=99m =
using the ADE7878 and I made several changes that I did not send<br =
class=3D"">to mainline. If someone is willing to clean these drivers up =
as<br class=3D"">proposed, I am willing to test the drivers with =
hardware (I have both<br class=3D"">ADE7878 EVAL and ADE9000 EVAL =
boards) and send through any required<br class=3D"">changes. These =
changes were made about a year ago, so my patches will<br =
class=3D"">probably need some work for the current driver.<span =
class=3D"Apple-converted-space">&nbsp;</span><br =
class=3D""></blockquote><span style=3D"font-family: Helvetica; =
font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: normal; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; float: none; display: =
inline !important;" class=3D"">Great.</span><br style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D""><blockquote=
 type=3D"cite" style=3D"font-family: Helvetica; font-size: 12px; =
font-style: normal; font-variant-caps: normal; font-weight: normal; =
letter-spacing: normal; orphans: auto; text-align: start; text-indent: =
0px; text-transform: none; white-space: normal; widows: auto; =
word-spacing: 0px; -webkit-text-size-adjust: auto; =
-webkit-text-stroke-width: 0px;" class=3D""><br class=3D"">For the most =
part, there was a problem with checking the return value<br =
class=3D"">from I2C communications (return is either negative or the =
number of<br class=3D"">bytes read/write), the read32 requires 4 bytes =
not 3. Other than<br class=3D"">that, I renamed the registers to match =
the data sheet and added many<br class=3D"">of the missing =
registers.<span class=3D"Apple-converted-space">&nbsp;</span><br =
class=3D""></blockquote><span style=3D"font-family: Helvetica; =
font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: normal; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; float: none; display: =
inline !important;" class=3D"">Cool - seems to me that whoever wants to =
take this one should email</span><br style=3D"font-family: Helvetica; =
font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: normal; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D""><span =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; float: none; =
display: inline !important;" class=3D"">you and get those patches. =
&nbsp;The first job then becomes bringing those</span><br =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px;" =
class=3D""><span style=3D"font-family: Helvetica; font-size: 12px; =
font-style: normal; font-variant-caps: normal; font-weight: normal; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; float: none; display: inline =
!important;" class=3D"">up to date.</span><br style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D""><br =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px;" =
class=3D""><blockquote type=3D"cite" style=3D"font-family: Helvetica; =
font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: normal; letter-spacing: normal; orphans: auto; text-align: =
start; text-indent: 0px; text-transform: none; white-space: normal; =
widows: auto; word-spacing: 0px; -webkit-text-size-adjust: auto; =
-webkit-text-stroke-width: 0px;" class=3D""><br class=3D"">I am =
currently looking at updating our hardware to ADE9000 and the<br =
class=3D"">ADE7758 looks like a good template for me to follow with =
core, ring<br class=3D"">and trigger functionality. I=E2=80=99m also =
looking to add DMA support to<br class=3D"">stream waveforms. I=E2=80=99m =
not sure if Analog Devices is looking to<br class=3D"">develop a driver =
for ADE9000.<span class=3D"Apple-converted-space">&nbsp;</span><br =
class=3D""></blockquote><span style=3D"font-family: Helvetica; =
font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: normal; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; float: none; display: =
inline !important;" class=3D"">DMA support would be interesting. =
&nbsp;Obviously good to have such</span><br style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D""><span =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; float: none; =
display: inline !important;" class=3D"">a driver whether you are Analog =
writes it. &nbsp;I wouldn't take the</span><br style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D""><span =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; float: none; =
display: inline !important;" class=3D"">current ade7758 as a template =
though. &nbsp;I haven't looked at it for</span><br style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D""><span =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; float: none; =
display: inline !important;" class=3D"">a while, but IIRC it's quite =
some way from where we want to be</span><br style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D""><span =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; float: none; =
display: inline !important;" class=3D"">in terms of userspace =
ABI.</span><br style=3D"font-family: Helvetica; font-size: 12px; =
font-style: normal; font-variant-caps: normal; font-weight: normal; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px;" class=3D""><br style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D""><blockquote=
 type=3D"cite" style=3D"font-family: Helvetica; font-size: 12px; =
font-style: normal; font-variant-caps: normal; font-weight: normal; =
letter-spacing: normal; orphans: auto; text-align: start; text-indent: =
0px; text-transform: none; white-space: normal; widows: auto; =
word-spacing: 0px; -webkit-text-size-adjust: auto; =
-webkit-text-stroke-width: 0px;" class=3D""><br class=3D"">One thing I =
don=E2=80=99t like is the mixing of register definitions in<br =
class=3D"">meter.h. Each data sheet uses different naming conventions =
for<br class=3D"">registers that have similar functionality, which means =
the common<br class=3D"">name used in meter.h does not match the data =
sheet and that is very<br class=3D"">confusing. There is also =
inconsistencies when naming the attributes;<br class=3D"">sometimes they =
follow the register name like avrms or cwgain, and<br class=3D"">sometimes=
 they are given functional names like =E2=80=9Cvolt_a" or<br =
class=3D"">=E2=80=9Cactive_power_c_gain". I propose that each part have =
its own include<br class=3D"">file and that the naming convention follow =
the data sheet and listed<br class=3D"">in the same order as the data =
sheet.<span class=3D"Apple-converted-space">&nbsp;</span><br =
class=3D""></blockquote><span style=3D"font-family: Helvetica; =
font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: normal; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; float: none; display: =
inline !important;" class=3D"">Meter.h is going to go away in any =
cleanup of this driver.</span><br style=3D"font-family: Helvetica; =
font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: normal; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D""><span =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; float: none; =
display: inline !important;" class=3D"">We changed a lot of how we do =
things since those early days of IIO.</span><br style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D""><span =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; float: none; =
display: inline !important;" class=3D"">All of this ABI needs proper =
consideration and may well end up</span><br style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D""><span =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; float: none; =
display: inline !important;" class=3D"">entirely different from what it =
is now. &nbsp;Basically the driver need</span><br style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D""><span =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; float: none; =
display: inline !important;" class=3D"">wrenching into the modern world =
;)</span><br style=3D"font-family: Helvetica; font-size: 12px; =
font-style: normal; font-variant-caps: normal; font-weight: normal; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px;" class=3D""><br style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D""><span =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; float: none; =
display: inline !important;" class=3D"">I just took a very brief look =
and it's better than some of the</span><br style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D""><span =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; float: none; =
display: inline !important;" class=3D"">other meter drivers but still a =
lot of work to do.</span><br style=3D"font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: =
normal; letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px;" class=3D""><br style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D""><span =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; float: none; =
display: inline !important;" class=3D"">Anyhow, short term upshot is I =
won't drop this one from staging</span><br style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D""><span =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; float: none; =
display: inline !important;" class=3D"">next cycle, but we'll keep it =
under review dependent on whether it</span><br style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D""><span =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; float: none; =
display: inline !important;" class=3D"">looks like anyone is interested =
in working on it or not!</span><br style=3D"font-family: Helvetica; =
font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: normal; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D""><br =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px;" =
class=3D""><span style=3D"font-family: Helvetica; font-size: 12px; =
font-style: normal; font-variant-caps: normal; font-weight: normal; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; float: none; display: inline =
!important;" class=3D"">Thanks for your kind offer to test - that gets =
us half the way.</span><br style=3D"font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: =
normal; letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px;" class=3D""><br style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D""><span =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; float: none; =
display: inline !important;" class=3D"">Jonathan</span><br =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px;" =
class=3D""><blockquote type=3D"cite" style=3D"font-family: Helvetica; =
font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: normal; letter-spacing: normal; orphans: auto; text-align: =
start; text-indent: 0px; text-transform: none; white-space: normal; =
widows: auto; word-spacing: 0px; -webkit-text-size-adjust: auto; =
-webkit-text-stroke-width: 0px;" class=3D""><br class=3D"">Regards,<br =
class=3D"">John<br class=3D""><br class=3D""><br class=3D""><br =
class=3D""><br class=3D""><br class=3D""><blockquote type=3D"cite" =
class=3D"">On Mar 7, 2018, at 1:19 PM, Jonathan Cameron &lt;<a =
href=3D"mailto:jic23@kernel.org" class=3D"">jic23@kernel.org</a>&gt;<br =
class=3D"">wrote:<br class=3D""><br class=3D"">Hi All,<br class=3D""><br =
class=3D"">All of these parts are apparently marked as not being for =
new<br class=3D"">designs and we have no known access to hardware =
suitable for<br class=3D"">testing the major changes needed for these =
drivers to graduate from<br class=3D"">staging.<br class=3D""><br =
class=3D"">Given this, unless someone expresses an interest (and has =
hardware<br class=3D"">for testing) I propose to drop these drivers from =
staging next<br class=3D"">kernel cycle (so in around 3 months time).<br =
class=3D""><br class=3D"">Of course I hope that someone can help us keep =
support for these<br class=3D"">parts and we won't end up dropping them, =
but they are old and<br class=3D"">several generations behind the =
current Analog Devices offerings.<br class=3D""><br class=3D"">Please =
share this with anyone you happen to know who is using any<br =
class=3D"">of these energy meters.<br class=3D""><br class=3D"">Thanks,<br=
 class=3D""><span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><br class=3D"">Jonathan<br class=3D"">--<br class=3D"">To =
unsubscribe from this list: send the line "unsubscribe<br =
class=3D"">linux-iio" in the body of a message to <a =
href=3D"mailto:majordomo@vger.kernel.org" =
class=3D"">majordomo@vger.kernel.org</a><br class=3D"">More majordomo =
info at &nbsp;<a href=3D"http://vger.kernel.org/majordomo-info.html" =
class=3D"">http://vger.kernel.org/majordomo-info.html</a> &nbsp;<br =
class=3D""></blockquote><br class=3D"">--<br class=3D"">To unsubscribe =
from this list: send the line "unsubscribe linux-iio"<br class=3D"">in =
the body of a message to<span =
class=3D"Apple-converted-space">&nbsp;</span><a =
href=3D"mailto:majordomo@vger.kernel.org" =
class=3D"">majordomo@vger.kernel.org</a><br class=3D"">More majordomo =
info at &nbsp;<a href=3D"http://vger.kernel.org/majordomo-info.html" =
class=3D"">http://vger.kernel.org/majordomo-info.html</a></blockquote></di=
v></blockquote></div><br class=3D""></div></body></html>=

--Apple-Mail=_4CBF3BBB-CCB0-4284-A686-B20AD02608A5--
