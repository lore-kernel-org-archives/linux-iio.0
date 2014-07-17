Return-Path: <gang.chen.5i5j@gmail.com>
Content-Type: multipart/alternative; boundary="Apple-Mail=_C10E72D1-6DF1-45E5-BDF4-1DCA7754AED9"
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH] drivers: Let several drivers depends on HAS_IOMEM for 'devm_ioremap_resource'
From: Chen Gang <gang.chen.5i5j@gmail.com>
In-Reply-To: <53C72DBC.5020900@roeck-us.net>
Date: Thu, 17 Jul 2014 10:11:25 +0800
Cc: Richard Weinberger <richard@nod.at>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 dmitry.torokhov@gmail.com,
 linux-iio@vger.kernel.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 teg@jklm.no,
 Thierry Reding <thierry.reding@gmail.com>,
 Lennox Wu <lennox.wu@gmail.com>,
 Marek Vasut <marex@denx.de>,
 Liqin Chen <liqin.linux@gmail.com>,
 msalter@redhat.com,
 linux-pwm@vger.kernel.org,
 devel@driverdev.osuosl.org,
 linux-watchdog@vger.kernel.org,
 linux-input@vger.kernel.org,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 knaack.h@gmx.de,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Mischa.Jonker@synopsys.com,
 jic23@kernel.org,
 arnd@arndb.de,
 Geert Uytterhoeven <geert@linux-m68k.org>
Message-Id: <BE9EBCC4-CC35-4353-8B71-ABBA93EB7E43@gmail.com>
References: <201407130545.23004.marex@denx.de> <CAF0htA60juBVkPo2HQKMDGcEr-wRzRVL_6JgHAa+7WVE_E8M0Q@mail.gmail.com> <53C25551.1050909@nod.at> <53C288F0.3070001@metafoo.de> <53C28C4A.70907@nod.at> <53C29015.5070607@metafoo.de> <53C291C8.6050303@nod.at> <53C296C2.30304@metafoo.de> <20140713192202.GA19090@kroah.com> <53C2DF12.6040507@nod.at> <20140713201753.GA29955@kroah.com> <53C39569.9020802@nod.at> <53C3994C.1010309@metafoo.de> <53C39B66.4060500@nod.at> <5A40E1FC-CA61-4AFF-B205-4BAC175AA7AC@gmail.com> <53C47725.8000005@gmail.com> <53C47B76.4080306@roeck-us.net> <53C47FB7.6080304@gmail.com> <53C53CE1.4090803@gmail.com> <53C7269E.4010702@gmail.com> <53C72DBC.5020900@roeck-us.net>
To: Guenter Roeck <linux@roeck-us.net>
List-ID: <linux-iio@vger.kernel.org>


--Apple-Mail=_C10E72D1-6DF1-45E5-BDF4-1DCA7754AED9
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8


=E5=9C=A8 2014=E5=B9=B47=E6=9C=8817=E6=97=A5=EF=BC=8C=E4=B8=8A=E5=8D=889:5=
8=EF=BC=8CGuenter Roeck <linux@roeck-us.net> =E5=86=99=E9=81=93=EF=BC=9A

> On 07/16/2014 06:27 PM, Chen Gang wrote:
>>=20
>>=20
>> On 07/15/2014 10:38 PM, Chen Gang wrote:
>>> On 07/15/2014 09:11 AM, Chen Gang wrote:
>>>>=20
>>>>=20
>>>> On 07/15/2014 08:53 AM, Guenter Roeck wrote:
>>>>> On 07/14/2014 05:34 PM, Chen Gang wrote:
>>>>>> On 07/14/2014 05:22 PM, Chen Gang wrote:
>>>>>>>=20
>>>>>>> =E5=9C=A8 2014=E5=B9=B47=E6=9C=8814=E6=97=A5=EF=BC=8C=E4=B8=8B=E5=8D=
=884:57=EF=BC=8CRichard Weinberger <richard@nod.at> =E5=86=99=E9=81=93=EF=BC=
=9A
>>>>>>>=20
>>>>>>>> Am 14.07.2014 10:48, schrieb Lars-Peter Clausen:
>>>>>>>>> On 07/14/2014 10:31 AM, Richard Weinberger wrote:
>>>>>>>>>> Am 13.07.2014 22:17, schrieb Greg Kroah-Hartman:
>>>>>>>>>>> On Sun, Jul 13, 2014 at 09:33:38PM +0200, Richard Weinberger =
wrote:
>>>>>>>>>>>> Maybe we could add COMPILE_TEST to the version string too?
>>>>>>>>>>>> Just to detect such kernels fast in user bug reports...
>>>>>>>>>>>=20
>>>>>>>>>>> What kind of bug report are you going to get?
>>>>>>>>>>=20
>>>>>>>>>> User manages to enable CONFIG_FOO by selecting COMPILE_TEST =
and
>>>>>>>>>> complains that it does not work. :)
>>>>>>>>>=20
>>>>>>>>> These drivers are typically drivers for some SoC peripheral =
and the
>>>>>>>>> device will simply physically not exist on a platform that =
does not
>>>>>>>>> provide HAS_IOMEM. This is not really any
>>>>>>>>> different from making the driver selectable via COMPILE_TEST =
for
>>>>>>>>> any other platform. To hit the issue you'd have to instantiate =
a
>>>>>>>>> device driver instance for a device that
>>>>>>>>> physically does not exist. This will always result in a =
failure.
>>>>>>>>=20
>>>>>>>> Okay, you have convinced me. :)
>>>>>>>>=20
>>>>>>=20
>>>>>> After search the history patches, I found one related patch which =
made
>>>>>> by myself (when I am in Asianux):
>>>>>>=20
>>>>>>    "https://lkml.org/lkml/2013/7/1/641"
>>>>>>=20
>>>>>> For me, it is a long discussion, and forced many members have to =
join
>>>>>> in. Please help check again.
>>>>>>=20
>>>>>=20
>>>>> One thing you could try would be to return NULL (or where =
appropriate
>>>>> an error) in the #else case of CONFIG_HAS_IOMEM and =
CONFIG_HAS_IOPORT,
>>>>> ie dont take COMPILE_TEST into account at all. Obviously that =
means
>>>>> you won't be able to dump a warning message in the COMPILE_TEST
>>>>> case, but at least the code would compile. The rejection of above =
patch
>>>>> would make a good case for this approach.
>>>>>=20
>>=20
>> For me, only let 'devm_io*map*' support COMPILE_TEST is OK, that can =
fix
>> all related issues:
>>=20
>>=20
>> [PATCH] lib: devres: Add dumy functions to support COMPILE_TEST when =
no IOMEM
>>=20
>> For some architectures which no IOMEM, 'devres' will be skipped. But
>> many drivers may still want COMPILE_TEST, so let 'devres' support it.
>>=20
>> The related error (with allmodconfig under score):
>>=20
>>     MODPOST 1365 modules
>>   ERROR: "devm_ioremap_resource" [drivers/watchdog/tegra_wdt.ko] =
undefined!
>>   ERROR: "devm_ioremap_resource" [drivers/watchdog/of_xilinx_wdt.ko] =
undefined!
>>   ERROR: "devm_ioremap_resource" =
[drivers/staging/iio/adc/mxs-lradc.ko] undefined!
>>   ERROR: "devm_ioremap_resource" [drivers/pwm/pwm-clps711x.ko] =
undefined!
>>   ERROR: "devm_ioremap_resource" [drivers/input/serio/olpc_apsp.ko] =
undefined!
>>   ERROR: "devm_ioremap_resource" [drivers/input/serio/arc_ps2.ko] =
undefined!
>>   ERROR: "devm_ioremap_resource" [drivers/rtc/rtc-xgene.ko] =
undefined!
>>   ERROR: "devm_ioremap_resource" [drivers/rtc/rtc-stk17ta8.ko] =
undefined!
>>   ERROR: "devm_ioremap_resource" [drivers/rtc/rtc-ds1742.ko] =
undefined!
>>   ERROR: "devm_ioremap_resource" [drivers/rtc/rtc-ds1553.ko] =
undefined!
>>   ERROR: "devm_ioremap_resource" [drivers/rtc/rtc-ds1511.ko] =
undefined!
>>   ERROR: "devm_ioremap_resource" [drivers/rtc/rtc-ds1286.ko] =
undefined!
>>   ERROR: "devm_ioremap" [drivers/rtc/rtc-rp5c01.ko] undefined!
>>   ERROR: "devm_ioremap" [drivers/rtc/rtc-msm6242.ko] undefined!
>>   ERROR: "devm_ioremap" [drivers/rtc/rtc-m48t59.ko] undefined!
>>   ERROR: "devm_ioremap" [drivers/rtc/rtc-m48t35.ko] undefined!
>>   ERROR: "devm_ioremap" [drivers/rtc/rtc-bq4802.ko] undefined!
>>=20
>>=20
>> Signed-off-by: Chen Gang <gang.chen.5i5j@gmail.com>
>> ---
>>  include/linux/device.h |  9 +++++++++
>>  include/linux/io.h     | 30 +++++++++++++++++++++++++++++-
>>  2 files changed, 38 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/include/linux/device.h b/include/linux/device.h
>> index c2421e0..a7500c3 100644
>> --- a/include/linux/device.h
>> +++ b/include/linux/device.h
>> @@ -630,7 +630,16 @@ extern unsigned long devm_get_free_pages(struct =
device *dev,
>>  					 gfp_t gfp_mask, unsigned int =
order);
>>  extern void devm_free_pages(struct device *dev, unsigned long addr);
>>=20
>> +#ifdef CONFIG_HAS_IOMEM
>>  void __iomem *devm_ioremap_resource(struct device *dev, struct =
resource *res);
>> +#elif defined(CONFIG_COMPILE_TEST)
>=20
> I would make it #else
>=20

That sounds OK to me, I will use #else instead of.

>> +static inline void __iomem *devm_ioremap_resource(struct device =
*dev,
>> +						struct resource *res)
>> +{
>> +	pr_warn("no hardware io memory, only for COMPILE_TEST\n");
>=20
> dev_warn
>=20

OK, thanks, I shall use dev_warn instead of pr_warn.


Thanks.
=E2=80=94
Chen Gang
Open, share, and attitude like air, water, and life which God blessed=

--Apple-Mail=_C10E72D1-6DF1-45E5-BDF4-1DCA7754AED9
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=utf-8

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html =
charset=3Dutf-8"><meta http-equiv=3D"Content-Type" content=3D"text/html =
charset=3Dutf-8"></head><body style=3D"word-wrap: break-word; =
-webkit-nbsp-mode: space; -webkit-line-break: =
after-white-space;"><div><br></div><div>=E5=9C=A8 =
2014=E5=B9=B47=E6=9C=8817=E6=97=A5=EF=BC=8C=E4=B8=8A=E5=8D=889:58=EF=BC=8C=
Guenter Roeck &lt;<a =
href=3D"mailto:linux@roeck-us.net">linux@roeck-us.net</a>&gt; =
=E5=86=99=E9=81=93=EF=BC=9A</div><div><br =
class=3D"Apple-interchange-newline"><blockquote type=3D"cite"><div =
style=3D"font-size: 12px; font-style: normal; font-variant: normal; =
font-weight: normal; letter-spacing: normal; line-height: normal; =
orphans: auto; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: auto; word-spacing: 0px; =
-webkit-text-stroke-width: 0px;">On 07/16/2014 06:27 PM, Chen Gang =
wrote:<br><blockquote type=3D"cite"><br><br>On 07/15/2014 10:38 PM, Chen =
Gang wrote:<br><blockquote type=3D"cite">On 07/15/2014 09:11 AM, Chen =
Gang wrote:<br><blockquote type=3D"cite"><br><br>On 07/15/2014 08:53 AM, =
Guenter Roeck wrote:<br><blockquote type=3D"cite">On 07/14/2014 05:34 =
PM, Chen Gang wrote:<br><blockquote type=3D"cite">On 07/14/2014 05:22 =
PM, Chen Gang wrote:<br><blockquote type=3D"cite"><br>=E5=9C=A8 =
2014=E5=B9=B47=E6=9C=8814=E6=97=A5=EF=BC=8C=E4=B8=8B=E5=8D=884:57=EF=BC=8C=
Richard Weinberger &lt;<a =
href=3D"mailto:richard@nod.at">richard@nod.at</a>&gt; =
=E5=86=99=E9=81=93=EF=BC=9A<br><br><blockquote type=3D"cite">Am =
14.07.2014 10:48, schrieb Lars-Peter Clausen:<br><blockquote =
type=3D"cite">On 07/14/2014 10:31 AM, Richard Weinberger =
wrote:<br><blockquote type=3D"cite">Am 13.07.2014 22:17, schrieb Greg =
Kroah-Hartman:<br><blockquote type=3D"cite">On Sun, Jul 13, 2014 at =
09:33:38PM +0200, Richard Weinberger wrote:<br><blockquote =
type=3D"cite">Maybe we could add COMPILE_TEST to the version string =
too?<br>Just to detect such kernels fast in user bug =
reports...<br></blockquote><br>What kind of bug report are you going to =
get?<br></blockquote><br>User manages to enable CONFIG_FOO by selecting =
COMPILE_TEST and<br>complains that it does not work. =
:)<br></blockquote><br>These drivers are typically drivers for some SoC =
peripheral and the<br>device will simply physically not exist on a =
platform that does not<br>provide HAS_IOMEM. This is not really =
any<br>different from making the driver selectable via COMPILE_TEST =
for<br>any other platform. To hit the issue you'd have to instantiate =
a<br>device driver instance for a device that<br>physically does not =
exist. This will always result in a failure.<br></blockquote><br>Okay, =
you have convinced me. :)<br><br></blockquote></blockquote><br>After =
search the history patches, I found one related patch which made<br>by =
myself (when I am in Asianux):<br><br>&nbsp;&nbsp;&nbsp;"<a =
href=3D"https://lkml.org/lkml/2013/7/1/641">https://lkml.org/lkml/2013/7/1=
/641</a>"<br><br>For me, it is a long discussion, and forced many =
members have to join<br>in. Please help check =
again.<br><br></blockquote><br>One thing you could try would be to =
return NULL (or where appropriate<br>an error) in the #else case of =
CONFIG_HAS_IOMEM and CONFIG_HAS_IOPORT,<br>ie dont take COMPILE_TEST =
into account at all. Obviously that means<br>you won't be able to dump a =
warning message in the COMPILE_TEST<br>case, but at least the code would =
compile. The rejection of above patch<br>would make a good case for this =
approach.<br><br></blockquote></blockquote></blockquote><br>For me, only =
let 'devm_io*map*' support COMPILE_TEST is OK, that can fix<br>all =
related issues:<br><br><br>[PATCH] lib: devres: Add dumy functions to =
support COMPILE_TEST when no IOMEM<br><br>For some architectures which =
no IOMEM, 'devres' will be skipped. But<br>many drivers may still want =
COMPILE_TEST, so let 'devres' support it.<br><br>The related error (with =
allmodconfig under score):<br><br>&nbsp;&nbsp;&nbsp;&nbsp;MODPOST 1365 =
modules<br>&nbsp;&nbsp;ERROR: "devm_ioremap_resource" =
[drivers/watchdog/tegra_wdt.ko] undefined!<br>&nbsp;&nbsp;ERROR: =
"devm_ioremap_resource" [drivers/watchdog/of_xilinx_wdt.ko] =
undefined!<br>&nbsp;&nbsp;ERROR: "devm_ioremap_resource" =
[drivers/staging/iio/adc/mxs-lradc.ko] undefined!<br>&nbsp;&nbsp;ERROR: =
"devm_ioremap_resource" [drivers/pwm/pwm-clps711x.ko] =
undefined!<br>&nbsp;&nbsp;ERROR: "devm_ioremap_resource" =
[drivers/input/serio/olpc_apsp.ko] undefined!<br>&nbsp;&nbsp;ERROR: =
"devm_ioremap_resource" [drivers/input/serio/arc_ps2.ko] =
undefined!<br>&nbsp;&nbsp;ERROR: "devm_ioremap_resource" =
[drivers/rtc/rtc-xgene.ko] undefined!<br>&nbsp;&nbsp;ERROR: =
"devm_ioremap_resource" [drivers/rtc/rtc-stk17ta8.ko] =
undefined!<br>&nbsp;&nbsp;ERROR: "devm_ioremap_resource" =
[drivers/rtc/rtc-ds1742.ko] undefined!<br>&nbsp;&nbsp;ERROR: =
"devm_ioremap_resource" [drivers/rtc/rtc-ds1553.ko] =
undefined!<br>&nbsp;&nbsp;ERROR: "devm_ioremap_resource" =
[drivers/rtc/rtc-ds1511.ko] undefined!<br>&nbsp;&nbsp;ERROR: =
"devm_ioremap_resource" [drivers/rtc/rtc-ds1286.ko] =
undefined!<br>&nbsp;&nbsp;ERROR: "devm_ioremap" =
[drivers/rtc/rtc-rp5c01.ko] undefined!<br>&nbsp;&nbsp;ERROR: =
"devm_ioremap" [drivers/rtc/rtc-msm6242.ko] =
undefined!<br>&nbsp;&nbsp;ERROR: "devm_ioremap" =
[drivers/rtc/rtc-m48t59.ko] undefined!<br>&nbsp;&nbsp;ERROR: =
"devm_ioremap" [drivers/rtc/rtc-m48t35.ko] =
undefined!<br>&nbsp;&nbsp;ERROR: "devm_ioremap" =
[drivers/rtc/rtc-bq4802.ko] undefined!<br><br><br>Signed-off-by: Chen =
Gang &lt;<a =
href=3D"mailto:gang.chen.5i5j@gmail.com">gang.chen.5i5j@gmail.com</a>&gt;<=
br>---<br>&nbsp;include/linux/device.h | &nbsp;9 =
+++++++++<br>&nbsp;include/linux/io.h &nbsp;&nbsp;&nbsp;&nbsp;| 30 =
+++++++++++++++++++++++++++++-<br>&nbsp;2 files changed, 38 =
insertions(+), 1 deletion(-)<br><br>diff --git a/include/linux/device.h =
b/include/linux/device.h<br>index c2421e0..a7500c3 100644<br>--- =
a/include/linux/device.h<br>+++ b/include/linux/device.h<br>@@ -630,7 =
+630,16 @@ extern unsigned long devm_get_free_pages(struct device =
*dev,<br>&nbsp;<span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-tab-span" style=3D"white-space: =
pre;">	</span><span class=3D"Apple-converted-space">&nbsp;</span>gfp_t =
gfp_mask, unsigned int order);<br>&nbsp;extern void =
devm_free_pages(struct device *dev, unsigned long addr);<br><br>+#ifdef =
CONFIG_HAS_IOMEM<br>&nbsp;void __iomem *devm_ioremap_resource(struct =
device *dev, struct resource *res);<br>+#elif =
defined(CONFIG_COMPILE_TEST)<br></blockquote><br>I would make it =
#else<br><br></div></blockquote><div><br></div><div>That sounds OK to =
me, I will use #else instead of.</div><br><blockquote type=3D"cite"><div =
style=3D"font-size: 12px; font-style: normal; font-variant: normal; =
font-weight: normal; letter-spacing: normal; line-height: normal; =
orphans: auto; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: auto; word-spacing: 0px; =
-webkit-text-stroke-width: 0px;"><blockquote type=3D"cite">+static =
inline void __iomem *devm_ioremap_resource(struct device *dev,<br>+<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span>struct =
resource *res)<br>+{<br>+<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span>pr_warn("no hardware io memory, =
only for =
COMPILE_TEST\n");<br></blockquote><br>dev_warn<br><br></div></blockquote><=
div><br></div><div>OK, thanks, I shall use dev_warn instead of =
pr_warn.</div><div><br></div><div><br></div></div>Thanks.<div>=E2=80=94</d=
iv><div>Chen Gang</div><div>Open, share, and attitude like air, water, =
and life which God blessed</div></body></html>=

--Apple-Mail=_C10E72D1-6DF1-45E5-BDF4-1DCA7754AED9--
