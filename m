Return-Path: <fugang.duan@freescale.com>
From: Fugang Duan <fugang.duan@freescale.com>
To: Otavio Salvador <otavio@ossystems.com.br>
CC: Shawn Guo <shawn.guo@linaro.org>, "jic23@kernel.org" <jic23@kernel.org>,
	"sachin.kamat@linaro.org" <sachin.kamat@linaro.org>, Frank Li
	<Frank.Li@freescale.com>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>
Subject: RE: [PATCH v2 2/3] iio:adc:imx: add Freescale Vybrid vf610 adc
 driver
Date: Wed, 27 Nov 2013 01:42:29 +0000
Message-ID: <9848F2DB572E5649BA045B288BE08FBE018988F2@039-SN2MPN1-023.039d.mgd.msft.net>
References: <1385430172-16642-1-git-send-email-B38611@freescale.com>
	<1385430172-16642-3-git-send-email-B38611@freescale.com>
	<20131126072058.GM30476@S2101-09.ap.freescale.net>
	<9848F2DB572E5649BA045B288BE08FBE01895AF4@039-SN2MPN1-023.039d.mgd.msft.net>
	<20131126080343.GO30476@S2101-09.ap.freescale.net>
	<CAP9ODKqSnhJPFjmVRim290h7dnBPcDwtLoJQHXY9NLPCDMBjpg@mail.gmail.com>
	<9848F2DB572E5649BA045B288BE08FBE018988A3@039-SN2MPN1-023.039d.mgd.msft.net>
 <CAP9ODKqQAmCfTjrWdMB6enM-x_pZhf0K5FOtb6H9uQhBUC_6gw@mail.gmail.com>
In-Reply-To: <CAP9ODKqQAmCfTjrWdMB6enM-x_pZhf0K5FOtb6H9uQhBUC_6gw@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

From: Otavio Salvador <otavio@ossystems.com.br>
Data: Wednesday, November 27, 2013 9:37 AM

>To: Duan Fugang-B38611
>Cc: Shawn Guo; jic23@kernel.org; sachin.kamat@linaro.org; Li Frank-B20596;
>linux-iio@vger.kernel.org
>Subject: Re: [PATCH v2 2/3] iio:adc:imx: add Freescale Vybrid vf610 adc dr=
iver
>
>On Tue, Nov 26, 2013 at 11:34 PM, Fugang Duan <fugang.duan@freescale.com> =
wrote:
>> From: Otavio Salvador <otavio@ossystems.com.br>
>> Data: Wednesday, November 27, 2013 8:17 AM
>>
>>>To: Shawn Guo
>>>Cc: Duan Fugang-B38611; jic23@kernel.org; sachin.kamat@linaro.org; Li
>>>Frank- B20596; linux-iio@vger.kernel.org
>>>Subject: Re: [PATCH v2 2/3] iio:adc:imx: add Freescale Vybrid vf610
>>>adc driver
>>>
>>>On Tue, Nov 26, 2013 at 6:03 AM, Shawn Guo <shawn.guo@linaro.org> wrote:
>>>> On Tue, Nov 26, 2013 at 07:33:11AM +0000, Fugang Duan wrote:
>>>>> >> +static const struct of_device_id vf610_adc_match[] =3D {
>>>>> >> +  { .compatible =3D "fsl,vf610-adc", .data =3D (void *)VF610_ADC,
>>>>> >> +},
>>>>> >
>>>>> >We should .data for now, since it's currently unused.
>>>>>
>>>>> Ok, I will change it as below.
>>>>> { .compatible =3D "fsl,vf610-adc", .data =3D (void *)0, },
>>>>
>>>> The following is enough.
>>>>
>>>>  { .compatible =3D "fsl,vf610-adc", }
>>>>
>>>> <snip>
>>>>
>>>>> >> +static int vf610_adc_probe(struct platform_device *pdev) {
>>>>> >> +  struct vf610_adc *info =3D NULL;
>>>>> >> +  struct device_node *np =3D pdev->dev.of_node;
>>>>> >> +  struct iio_dev *indio_dev;
>>>>> >> +  struct resource *mem;
>>>>> >> +  int ret =3D -ENODEV;
>>>>> >> +
>>>>> >> +  if (!np)
>>>>> >> +          return ret;
>>>>> >
>>>>> >Unnecessary check.  We will not be here at all if np is NULL.
>>>>>
>>>>> Great. There still have many drivers do it like this.
>>>>
>>>> It's unnecessary for platforms that only support DT probe, like
>>>> VF610 and IMX6.
>>>
>>>I know this is not my call but I would prefer it had a imx-adc and in
>>>the Kconfig help you explain clearly which SoCs it will/support. It
>>>will be strange to have i.MX6SLX using a VF610 ADC :-(
>>
>> i.MX6SLX ADC IP inherit VF610 ADC IP. The VF610 ADC support hardware tri=
gger
>from PDB (The Programmable Delay Block), but i.MX6SLX don't support hardwa=
re
>trigger.
>> So, for the driver feature expander, there have difference for VF610 and
>i.MX6SLX. VF610 use the compatible "vf610-adc", i.MX6SLX use "imx-adc".
>
>I see; but the source code will be vf610_adc.c; I'd expect it to be imx_ad=
c.c
>

Yes, the ADC patch set V1 version name the driver after imx_adc.c, but Jona=
than Cameron think it is generic and suggest to name it one silicon name.

Thanks,
Andy
