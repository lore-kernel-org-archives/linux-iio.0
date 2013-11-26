Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-db8lp0186.outbound.messaging.microsoft.com ([213.199.154.186]:7081
	"EHLO db8outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751796Ab3KZIBb (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 26 Nov 2013 03:01:31 -0500
Date: Tue, 26 Nov 2013 16:03:51 +0800
From: Shawn Guo <shawn.guo@linaro.org>
To: Fugang Duan <fugang.duan@freescale.com>
CC: "jic23@kernel.org" <jic23@kernel.org>,
	"sachin.kamat@linaro.org" <sachin.kamat@linaro.org>,
	Frank Li <Frank.Li@freescale.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] iio:adc:imx: add Freescale Vybrid vf610 adc driver
Message-ID: <20131126080343.GO30476@S2101-09.ap.freescale.net>
References: <1385430172-16642-1-git-send-email-B38611@freescale.com>
 <1385430172-16642-3-git-send-email-B38611@freescale.com>
 <20131126072058.GM30476@S2101-09.ap.freescale.net>
 <9848F2DB572E5649BA045B288BE08FBE01895AF4@039-SN2MPN1-023.039d.mgd.msft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <9848F2DB572E5649BA045B288BE08FBE01895AF4@039-SN2MPN1-023.039d.mgd.msft.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, Nov 26, 2013 at 07:33:11AM +0000, Fugang Duan wrote:
> >> +static const struct of_device_id vf610_adc_match[] = {
> >> +	{ .compatible = "fsl,vf610-adc", .data = (void *)VF610_ADC, },
> >
> >We should .data for now, since it's currently unused.
> 
> Ok, I will change it as below.
> { .compatible = "fsl,vf610-adc", .data = (void *)0, },

The following is enough.

 { .compatible = "fsl,vf610-adc", }

<snip>

> >> +static int vf610_adc_probe(struct platform_device *pdev) {
> >> +	struct vf610_adc *info = NULL;
> >> +	struct device_node *np = pdev->dev.of_node;
> >> +	struct iio_dev *indio_dev;
> >> +	struct resource *mem;
> >> +	int ret = -ENODEV;
> >> +
> >> +	if (!np)
> >> +		return ret;
> >
> >Unnecessary check.  We will not be here at all if np is NULL.
> 
> Great. There still have many drivers do it like this.

It's unnecessary for platforms that only support DT probe, like VF610
and IMX6.

Shawn

