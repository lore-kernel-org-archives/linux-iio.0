Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f49.google.com ([74.125.82.49]:35459 "EHLO
	mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752311AbcGUMLu (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 21 Jul 2016 08:11:50 -0400
Received: by mail-wm0-f49.google.com with SMTP id f65so19769895wmi.0
        for <linux-iio@vger.kernel.org>; Thu, 21 Jul 2016 05:11:49 -0700 (PDT)
Date: Thu, 21 Jul 2016 13:12:53 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Quentin Schulz <quentin.schulz@free-electrons.com>,
	jdelvare@suse.com, linux@roeck-us.net, knaack.h@gmx.de,
	lars@metafoo.de, pmeerw@pmeerw.net,
	maxime.ripard@free-electrons.com, wens@csie.org,
	linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	thomas.petazzoni@free-electrons.com,
	antoine.tenart@free-electrons.com
Subject: Re: [PATCH v2 3/4] mfd: add support for Allwinner SoCs ADC
Message-ID: <20160721121253.GE14925@dell>
References: <1468576754-3273-1-git-send-email-quentin.schulz@free-electrons.com>
 <1468576754-3273-4-git-send-email-quentin.schulz@free-electrons.com>
 <de8ebab2-cde9-d209-3c9a-e1868fafb84b@kernel.org>
 <20160719073109.GD17074@dell>
 <d64cf632-41a4-3e23-6239-7f854cbb0293@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <d64cf632-41a4-3e23-6239-7f854cbb0293@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, 20 Jul 2016, Jonathan Cameron wrote:

> On 19/07/16 08:31, Lee Jones wrote:
> > On Mon, 18 Jul 2016, Jonathan Cameron wrote:
> > 
> >> On 15/07/16 10:59, Quentin Schulz wrote:
> >>> The Allwinner SoCs all have an ADC that can also act as a touchscreen
> >>> controller and a thermal sensor. For now, only the ADC and the thermal
> >>> sensor drivers are probed by the MFD, the touchscreen controller support
> >>> will be added later.
> >>>
> >>> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> >> Hmm. Previous patch includes the header this one creates.  Ordering issue?
> >> The depends kind of prevents build failures by ensuring that can't be built
> >> until this one is in place, but it is certainly an ugly way to do it.
> >>
> >> Few little bits innline.
> >>> ---
> >>>
> >>> v2:
> >>>  - add license headers,
> >>>  - reorder alphabetically includes,
> >>>  - add SUNXI_GPADC_ prefixes for defines,
> >>>
> >>>  drivers/mfd/Kconfig                 |  14 +++
> >>>  drivers/mfd/Makefile                |   2 +
> >>>  drivers/mfd/sunxi-gpadc-mfd.c       | 197 ++++++++++++++++++++++++++++++++++++
> >>>  include/linux/mfd/sunxi-gpadc-mfd.h |  23 +++++
> >>>  4 files changed, 236 insertions(+)
> >>>  create mode 100644 drivers/mfd/sunxi-gpadc-mfd.c
> >>>  create mode 100644 include/linux/mfd/sunxi-gpadc-mfd.h
> > 
> > [...]
> > 
> >>> +static struct mfd_cell sun6i_gpadc_mfd_cells[] = {
> >>> +	{
> >>> +		.name	= "sun6i-a31-gpadc-iio",
> >>> +		.resources = adc_resources,
> >>> +		.num_resources = ARRAY_SIZE(adc_resources),
> >>> +	}, {
> >>> +		.name = "iio_hwmon",
> >> I still really dislike using this to force the probe of that driver but
> >> kind of up to the hwmon / mfd guys on this.
> > 
> > Can you at least say *why* you don't like it?
> It just feels odd to have an mfd child that isn't really dependent
> on the mfd hardware itself.
> 
> Still if you are happy, mfd is your domain and my objections were
> as you probably noticed not that strong - or well described!)
> 
> So I'm fine with this.

I see.  So it's not actually part of the same IP/chip?

> > How else would it get probed?
> > 
> >> I don't have any better suggestions though..
> >>> +	},
> >>> +};
> > 
> > [...]
> > 
> >>> +	if (ret) {
> >>> +		dev_err(&pdev->dev, "failed to add MFD devices: %d\n", ret);
> >>> +		regmap_del_irq_chip(irq, sunxi_gpadc_mfd_dev->regmap_irqc);
> >>> +		return ret;
> >>> +	}
> >>> +
> >>> +	dev_info(&pdev->dev, "successfully loaded\n");
> >> Seems like noise to me, but not my subsystem :)
> > 
> > Agreed, I don't allow this either.
> > 
> > [...]
> > 
> 

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
