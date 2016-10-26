Return-Path: <john3909@gmail.com>
From: John Syne <john3909@gmail.com>
Message-Id: <5F10EC3A-7164-4798-91ED-D2CFEE9A9AAD@gmail.com>
Content-Type: multipart/alternative;
 boundary="Apple-Mail=_D20E0817-7EFE-4206-AA92-3546C53DB1B5"
Mime-Version: 1.0 (Mac OS X Mail 10.1 \(3251\))
Subject: Re: [PATCH] drivers: mfd: ti_am335x_tscadc: increase ADC ref clock to
 24MHz
Date: Wed, 26 Oct 2016 12:33:18 -0700
In-Reply-To: <20161026084811.GI8574@dell>
Cc: Mugunthan V N <mugunthanvnm@ti.com>,
 linux-iio@vger.kernel.org,
 Tony Lindgren <tony@atomide.com>,
 Jonathan Cameron <jic23@kernel.org>,
 Vignesh R <vigneshr@ti.com>,
 linux-omap@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 Sekhar Nori <nsekhar@ti.com>,
 Peter Ujfalusi <peter.ujfalusi@ti.com>
To: Lee Jones <lee.jones@linaro.org>
References: <20161024060226.4170-1-mugunthanvnm@ti.com>
 <038C6B01-8443-4321-9C65-BAC4095237D3@gmail.com>
 <086ab2fa-63ee-c5ab-2715-b2efd78270d7@ti.com>
 <12725C92-9BB8-4F77-A7B4-F3C3DA9F8B0B@gmail.com>
 <DB09B26E-C5AB-427A-82D5-6FE857E7C218@gmail.com> <20161025063847.GD8574@dell>
 <CC15CFB4-60D0-4A63-A3D3-2079CFA31274@gmail.com> <20161026084811.GI8574@dell>
List-ID: <linux-iio@vger.kernel.org>


--Apple-Mail=_D20E0817-7EFE-4206-AA92-3546C53DB1B5
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8


> On Oct 26, 2016, at 1:48 AM, Lee Jones <lee.jones@linaro.org> wrote:
>=20
> On Tue, 25 Oct 2016, John Syne wrote:
>>> On Oct 24, 2016, at 11:38 PM, Lee Jones <lee.jones@linaro.org> =
wrote:
>>> On Mon, 24 Oct 2016, John Syne wrote:
>>>>> On Oct 24, 2016, at 11:01 PM, John Syne <john3909@gmail.com> =
wrote:
>>>>>> On Oct 24, 2016, at 10:52 PM, Mugunthan V N <mugunthanvnm@ti.com> =
wrote:
>>>>>>=20
>>>>>> On Tuesday 25 October 2016 02:28 AM, John Syne wrote:
>>>>>>>>> On Oct 23, 2016, at 11:02 PM, Mugunthan V N =
<mugunthanvnm@ti.com> wrote:
>>>>>>>>>=20
>>>>>>>>> Increase ADC reference clock from 3MHz to 24MHz so that the
>>>>>>>>> sampling rates goes up from 100K samples per second to 800K
>>>>>>>>> samples per second on AM335x and AM437x SoC.
>>>>>>>>>=20
>>>>>>>>> Also increase opendelay for touchscreen configuration to
>>>>>>>>> equalize the increase in ADC reference clock frequency,
>>>>>>>>> which results in the same amount touch events reported via
>>>>>>>>> evtest on AM335x GP EVM.
>>>>>>>>>=20
>>>>>>>>> Signed-off-by: Mugunthan V N <mugunthanvnm@ti.com>
>>>>>>>>> ---
>>>>>>>>>=20
>>>>>>>>> This patch depends on ADC DMA patch series [1]
>>>>>>>>>=20
>>>>>>>>> Without DMA support, when ADC ref clock is set at 24MHz, I am
>>>>>>>>> seeing fifo overflow as CPU is not able to pull the ADC =
samples.
>>>>>>>>> This answers that DMA support is must for ADC to consume the
>>>>>>>>> samples generated at 24MHz with no open, step delay or
>>>>>>>>> averaging with patch [2].
>>>>>>>>>=20
>>>>>>>>> Measured the performance with the iio_generic_buffer with the
>>>>>>>>> patch [3] applied
>>>>>>>>>=20
>>>>>>>>> [1] - http://www.spinics.net/lists/devicetree/msg145045.html
>>>>>>>>> [2] - http://pastebin.ubuntu.com/23357935/
>>>>>>>>> [3] - http://pastebin.ubuntu.com/23357939/
>>>>>>>>>=20
>>>>>>>>> ---
>>>>>>>>> include/linux/mfd/ti_am335x_tscadc.h | 4 ++--
>>>>>>>>> 1 file changed, 2 insertions(+), 2 deletions(-)
>>>>>>>>>=20
>>>>>>>>> diff --git a/include/linux/mfd/ti_am335x_tscadc.h =
b/include/linux/mfd/ti_am335x_tscadc.h
>>>>>>>>> index b9a53e0..96c4207 100644
>>>>>>>>> --- a/include/linux/mfd/ti_am335x_tscadc.h
>>>>>>>>> +++ b/include/linux/mfd/ti_am335x_tscadc.h
>>>>>>>>> @@ -90,7 +90,7 @@
>>>>>>>>> /* Delay register */
>>>>>>>>> #define STEPDELAY_OPEN_MASK	(0x3FFFF << 0)
>>>>>>>>> #define STEPDELAY_OPEN(val)	((val) << 0)
>>>>>>>>> -#define STEPCONFIG_OPENDLY	STEPDELAY_OPEN(0x098)
>>>>>>> Wouldn=E2=80=99t this be better to add this to the devicetree?
>>>>>>>=20
>>>>>>> 	ti,chan-step-avg =3D <0x16 0x16 0x16 0x16 0x16 0x16 =
0x16>;
>>>>>>> 	ti,chan-step-opendelay =3D <0x500 0x500 0x500 0x500 =
0x500 0x500 0x500>;
>>>>>>> 	ti,chan-step-sampledelay =3D <0x0 0x0 0x0 0x0 0x0 0x0 =
0x0>;
>>>>>>=20
>>>>>> For a touch screen, there is not need to change in these =
parameter
>>>>>> settings, so my opinion is to keep it as is. Or am I missing =
something?
>>>>> I was thinking that if you are using this driver as an ADC, you =
may want the flexibility to make these changes in the DT. I=E2=80=99m =
doing this by connecting sensors to the ADC inputs. I=E2=80=99m not =
using this driver for a touchscreen.=20
>>>>=20
>>>> Here is a DT overlay were this gets using on the BeagleBoneBlack. =20=

>>>>=20
>>>> =
https://github.com/RobertCNelson/bb.org-overlays/blob/master/src/arm/BB-AD=
C-00A0.dts
>>>>=20
>>>> Besides, these DT features are already implemented in the driver so =
it is just a matter of adding these entries to the am33xx.dtsi & =
am4372.dtsi, which you modified in this patch series.
>>>=20
>>> This looks like configuration, no?
>>>=20
>>> DT should be used to describe the hardware.
>> You may be right, but how is this different to setting the baud rate =
on a serial channel or sampling rate on a audio channel? Looking through =
the DT, there are many configuration settings, so I=E2=80=99m not sure =
what is the correct way to handle this. Surely it is better to handle =
this in DT vs hard coding these settings?
>=20
> I think setting the UART baud rate is also an invalid DT entry.
>=20
> It's okay to list all of the options in DT, but to actually select
> one, that should be done either in userspace or as a kernel option.
> Perhaps as a Kconfig selection.
Yeah, this has been inconsistent for a long time. My only point was that =
these DT parameters had already been implemented in the ti_am335x_adc KM =
and I thought that this was better than hard coding these settings. I =
defer to the domain experts to decide the best way forward.=20

Regards,
John
>=20
> --=20
> Lee Jones
> Linaro STMicroelectronics Landing Team Lead
> Linaro.org <http://linaro.org/> =E2=94=82 Open source software for ARM =
SoCs
> Follow Linaro: Facebook | Twitter | Blog


--Apple-Mail=_D20E0817-7EFE-4206-AA92-3546C53DB1B5
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=utf-8

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html =
charset=3Dutf-8"></head><body style=3D"word-wrap: break-word; =
-webkit-nbsp-mode: space; -webkit-line-break: after-white-space;" =
class=3D""><br class=3D""><div><blockquote type=3D"cite" class=3D""><div =
class=3D"">On Oct 26, 2016, at 1:48 AM, Lee Jones &lt;<a =
href=3D"mailto:lee.jones@linaro.org" =
class=3D"">lee.jones@linaro.org</a>&gt; wrote:</div><br =
class=3D"Apple-interchange-newline"><div class=3D""><span =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
orphans: auto; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: auto; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; float: none; display: inline =
!important;" class=3D"">On Tue, 25 Oct 2016, John Syne wrote:</span><br =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
orphans: auto; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: auto; word-spacing: 0px; =
-webkit-text-stroke-width: 0px;" class=3D""><blockquote type=3D"cite" =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
orphans: auto; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: auto; word-spacing: 0px; =
-webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px;" =
class=3D""><blockquote type=3D"cite" class=3D"">On Oct 24, 2016, at =
11:38 PM, Lee Jones &lt;<a href=3D"mailto:lee.jones@linaro.org" =
class=3D"">lee.jones@linaro.org</a>&gt; wrote:<br class=3D"">On Mon, 24 =
Oct 2016, John Syne wrote:<br class=3D""><blockquote type=3D"cite" =
class=3D""><blockquote type=3D"cite" class=3D"">On Oct 24, 2016, at =
11:01 PM, John Syne &lt;<a href=3D"mailto:john3909@gmail.com" =
class=3D"">john3909@gmail.com</a>&gt; wrote:<br class=3D""><blockquote =
type=3D"cite" class=3D"">On Oct 24, 2016, at 10:52 PM, Mugunthan V N =
&lt;<a href=3D"mailto:mugunthanvnm@ti.com" =
class=3D"">mugunthanvnm@ti.com</a>&gt; wrote:<br class=3D""><br =
class=3D"">On Tuesday 25 October 2016 02:28 AM, John Syne wrote:<br =
class=3D""><blockquote type=3D"cite" class=3D""><blockquote type=3D"cite" =
class=3D""><blockquote type=3D"cite" class=3D"">On Oct 23, 2016, at =
11:02 PM, Mugunthan V N &lt;<a href=3D"mailto:mugunthanvnm@ti.com" =
class=3D"">mugunthanvnm@ti.com</a>&gt; wrote:<br class=3D""><br =
class=3D"">Increase ADC reference clock from 3MHz to 24MHz so that =
the<br class=3D"">sampling rates goes up from 100K samples per second to =
800K<br class=3D"">samples per second on AM335x and AM437x SoC.<br =
class=3D""><br class=3D"">Also increase opendelay for touchscreen =
configuration to<br class=3D"">equalize the increase in ADC reference =
clock frequency,<br class=3D"">which results in the same amount touch =
events reported via<br class=3D"">evtest on AM335x GP EVM.<br =
class=3D""><br class=3D"">Signed-off-by: Mugunthan V N &lt;<a =
href=3D"mailto:mugunthanvnm@ti.com" =
class=3D"">mugunthanvnm@ti.com</a>&gt;<br class=3D"">---<br class=3D""><br=
 class=3D"">This patch depends on ADC DMA patch series [1]<br =
class=3D""><br class=3D"">Without DMA support, when ADC ref clock is set =
at 24MHz, I am<br class=3D"">seeing fifo overflow as CPU is not able to =
pull the ADC samples.<br class=3D"">This answers that DMA support is =
must for ADC to consume the<br class=3D"">samples generated at 24MHz =
with no open, step delay or<br class=3D"">averaging with patch [2].<br =
class=3D""><br class=3D"">Measured the performance with the =
iio_generic_buffer with the<br class=3D"">patch [3] applied<br =
class=3D""><br class=3D"">[1] - <a =
href=3D"http://www.spinics.net/lists/devicetree/msg145045.html" =
class=3D"">http://www.spinics.net/lists/devicetree/msg145045.html</a><br =
class=3D"">[2] - <a href=3D"http://pastebin.ubuntu.com/23357935/" =
class=3D"">http://pastebin.ubuntu.com/23357935/</a><br class=3D"">[3] - =
<a href=3D"http://pastebin.ubuntu.com/23357939/" =
class=3D"">http://pastebin.ubuntu.com/23357939/</a><br class=3D""><br =
class=3D"">---<br class=3D"">include/linux/mfd/ti_am335x_tscadc.h | 4 =
++--<br class=3D"">1 file changed, 2 insertions(+), 2 deletions(-)<br =
class=3D""><br class=3D"">diff --git =
a/include/linux/mfd/ti_am335x_tscadc.h =
b/include/linux/mfd/ti_am335x_tscadc.h<br class=3D"">index =
b9a53e0..96c4207 100644<br class=3D"">--- =
a/include/linux/mfd/ti_am335x_tscadc.h<br class=3D"">+++ =
b/include/linux/mfd/ti_am335x_tscadc.h<br class=3D"">@@ -90,7 +90,7 =
@@<br class=3D"">/* Delay register */<br class=3D"">#define =
STEPDELAY_OPEN_MASK<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>(0x3FFFF &lt;&lt; 0)<br class=3D"">#define =
STEPDELAY_OPEN(val)<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>((val) &lt;&lt; 0)<br class=3D"">-#define =
STEPCONFIG_OPENDLY<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span>STEPDELAY_OPEN(0x098)<br =
class=3D""></blockquote></blockquote>Wouldn=E2=80=99t this be better to =
add this to the devicetree?<br class=3D""><br class=3D""><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>ti,chan-step-avg =3D &lt;0x16 0x16 0x16 0x16 0x16 0x16 =
0x16&gt;;<br class=3D""><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>ti,chan-step-opendelay =3D =
&lt;0x500 0x500 0x500 0x500 0x500 0x500 0x500&gt;;<br class=3D""><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>ti,chan-step-sampledelay =3D &lt;0x0 0x0 0x0 0x0 0x0 0x0 =
0x0&gt;;<br class=3D""></blockquote><br class=3D"">For a touch screen, =
there is not need to change in these parameter<br class=3D"">settings, =
so my opinion is to keep it as is. Or am I missing something?<br =
class=3D""></blockquote>I was thinking that if you are using this driver =
as an ADC, you may want the flexibility to make these changes in the DT. =
I=E2=80=99m doing this by connecting sensors to the ADC inputs. I=E2=80=99=
m not using this driver for a touchscreen.<span =
class=3D"Apple-converted-space">&nbsp;</span><br =
class=3D""></blockquote><br class=3D"">Here is a DT overlay were this =
gets using on the BeagleBoneBlack. &nbsp;<br class=3D""><br class=3D""><a =
href=3D"https://github.com/RobertCNelson/bb.org-overlays/blob/master/src/a=
rm/BB-ADC-00A0.dts" =
class=3D"">https://github.com/RobertCNelson/bb.org-overlays/blob/master/sr=
c/arm/BB-ADC-00A0.dts</a><br class=3D""><br class=3D"">Besides, these DT =
features are already implemented in the driver so it is just a matter of =
adding these entries to the am33xx.dtsi &amp; am4372.dtsi, which you =
modified in this patch series.<br class=3D""></blockquote><br =
class=3D"">This looks like configuration, no?<br class=3D""><br =
class=3D"">DT should be used to describe the hardware.<br =
class=3D""></blockquote>You may be right, but how is this different to =
setting the baud rate on a serial channel or sampling rate on a audio =
channel? Looking through the DT, there are many configuration settings, =
so I=E2=80=99m not sure what is the correct way to handle this. Surely =
it is better to handle this in DT vs hard coding these settings?<br =
class=3D""></blockquote><br style=3D"font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: =
normal; letter-spacing: normal; orphans: auto; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; widows: =
auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D""><span=
 style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
orphans: auto; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: auto; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; float: none; display: inline =
!important;" class=3D"">I think setting the UART baud rate is also an =
invalid DT entry.</span><br style=3D"font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: =
normal; letter-spacing: normal; orphans: auto; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; widows: =
auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D""><br =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
orphans: auto; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: auto; word-spacing: 0px; =
-webkit-text-stroke-width: 0px;" class=3D""><span style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; orphans: auto; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
float: none; display: inline !important;" class=3D"">It's okay to list =
all of the options in DT, but to actually select</span><br =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
orphans: auto; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: auto; word-spacing: 0px; =
-webkit-text-stroke-width: 0px;" class=3D""><span style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; orphans: auto; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
float: none; display: inline !important;" class=3D"">one, that should be =
done either in userspace or as a kernel option.</span><br =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
orphans: auto; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: auto; word-spacing: 0px; =
-webkit-text-stroke-width: 0px;" class=3D""><span style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; orphans: auto; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
float: none; display: inline !important;" class=3D"">Perhaps as a =
Kconfig selection.</span><br style=3D"font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: =
normal; letter-spacing: normal; orphans: auto; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; widows: =
auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;" =
class=3D""></div></blockquote>Yeah, this has been inconsistent for a =
long time. My only point was that these DT parameters had already been =
implemented in the ti_am335x_adc KM and I thought that this was better =
than hard coding these settings. I defer to the domain experts to decide =
the best way forward.&nbsp;</div><div><br =
class=3D""></div><div>Regards,</div><div>John<br class=3D""><blockquote =
type=3D"cite" class=3D""><div class=3D""><br style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; orphans: auto; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: =
0px;" class=3D""><span style=3D"font-family: Helvetica; font-size: 12px; =
font-style: normal; font-variant-caps: normal; font-weight: normal; =
letter-spacing: normal; orphans: auto; text-align: start; text-indent: =
0px; text-transform: none; white-space: normal; widows: auto; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; float: none; display: =
inline !important;" class=3D"">--<span =
class=3D"Apple-converted-space">&nbsp;</span></span><br =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
orphans: auto; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: auto; word-spacing: 0px; =
-webkit-text-stroke-width: 0px;" class=3D""><span style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; orphans: auto; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
float: none; display: inline !important;" class=3D"">Lee Jones</span><br =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
orphans: auto; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: auto; word-spacing: 0px; =
-webkit-text-stroke-width: 0px;" class=3D""><span style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; orphans: auto; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
float: none; display: inline !important;" class=3D"">Linaro =
STMicroelectronics Landing Team Lead</span><br style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; orphans: auto; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: =
0px;" class=3D""><a href=3D"http://linaro.org/" style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; orphans: auto; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: auto; word-spacing: 0px; -webkit-text-size-adjust: auto; =
-webkit-text-stroke-width: 0px;" class=3D"">Linaro.org</a><span =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
orphans: auto; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: auto; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; float: none; display: inline =
!important;" class=3D""><span =
class=3D"Apple-converted-space">&nbsp;</span>=E2=94=82 Open source =
software for ARM SoCs</span><br style=3D"font-family: Helvetica; =
font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: normal; letter-spacing: normal; orphans: auto; text-align: =
start; text-indent: 0px; text-transform: none; white-space: normal; =
widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;" =
class=3D""><span style=3D"font-family: Helvetica; font-size: 12px; =
font-style: normal; font-variant-caps: normal; font-weight: normal; =
letter-spacing: normal; orphans: auto; text-align: start; text-indent: =
0px; text-transform: none; white-space: normal; widows: auto; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; float: none; display: =
inline !important;" class=3D"">Follow Linaro: Facebook | Twitter | =
Blog</span></div></blockquote></div><br class=3D""></body></html>=

--Apple-Mail=_D20E0817-7EFE-4206-AA92-3546C53DB1B5--
