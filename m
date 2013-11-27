Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-oa0-f48.google.com ([209.85.219.48]:64743 "EHLO
	mail-oa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752889Ab3K0AQk (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 26 Nov 2013 19:16:40 -0500
Received: by mail-oa0-f48.google.com with SMTP id l6so6812894oag.21
        for <linux-iio@vger.kernel.org>; Tue, 26 Nov 2013 16:16:39 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20131126080343.GO30476@S2101-09.ap.freescale.net>
References: <1385430172-16642-1-git-send-email-B38611@freescale.com>
	<1385430172-16642-3-git-send-email-B38611@freescale.com>
	<20131126072058.GM30476@S2101-09.ap.freescale.net>
	<9848F2DB572E5649BA045B288BE08FBE01895AF4@039-SN2MPN1-023.039d.mgd.msft.net>
	<20131126080343.GO30476@S2101-09.ap.freescale.net>
Date: Tue, 26 Nov 2013 22:16:38 -0200
Message-ID: <CAP9ODKqSnhJPFjmVRim290h7dnBPcDwtLoJQHXY9NLPCDMBjpg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] iio:adc:imx: add Freescale Vybrid vf610 adc driver
From: Otavio Salvador <otavio@ossystems.com.br>
To: Shawn Guo <shawn.guo@linaro.org>
Cc: Fugang Duan <fugang.duan@freescale.com>,
	"jic23@kernel.org" <jic23@kernel.org>,
	"sachin.kamat@linaro.org" <sachin.kamat@linaro.org>,
	Frank Li <Frank.Li@freescale.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, Nov 26, 2013 at 6:03 AM, Shawn Guo <shawn.guo@linaro.org> wrote:
> On Tue, Nov 26, 2013 at 07:33:11AM +0000, Fugang Duan wrote:
>> >> +static const struct of_device_id vf610_adc_match[] = {
>> >> +  { .compatible = "fsl,vf610-adc", .data = (void *)VF610_ADC, },
>> >
>> >We should .data for now, since it's currently unused.
>>
>> Ok, I will change it as below.
>> { .compatible = "fsl,vf610-adc", .data = (void *)0, },
>
> The following is enough.
>
>  { .compatible = "fsl,vf610-adc", }
>
> <snip>
>
>> >> +static int vf610_adc_probe(struct platform_device *pdev) {
>> >> +  struct vf610_adc *info = NULL;
>> >> +  struct device_node *np = pdev->dev.of_node;
>> >> +  struct iio_dev *indio_dev;
>> >> +  struct resource *mem;
>> >> +  int ret = -ENODEV;
>> >> +
>> >> +  if (!np)
>> >> +          return ret;
>> >
>> >Unnecessary check.  We will not be here at all if np is NULL.
>>
>> Great. There still have many drivers do it like this.
>
> It's unnecessary for platforms that only support DT probe, like VF610
> and IMX6.

I know this is not my call but I would prefer it had a imx-adc and in
the Kconfig help you explain clearly which SoCs it will/support. It
will be strange to have i.MX6SLX using a VF610 ADC :-(

-- 
Otavio Salvador                             O.S. Systems
http://www.ossystems.com.br        http://code.ossystems.com.br
Mobile: +55 (53) 9981-7854            Mobile: +1 (347) 903-9750
