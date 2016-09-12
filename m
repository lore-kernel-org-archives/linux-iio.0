Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:37371 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759039AbcILNy5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 12 Sep 2016 09:54:57 -0400
Received: by mail-wm0-f44.google.com with SMTP id c131so59308223wmh.0
        for <linux-iio@vger.kernel.org>; Mon, 12 Sep 2016 06:54:56 -0700 (PDT)
Date: Mon, 12 Sep 2016 14:56:46 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Quentin Schulz <quentin.schulz@free-electrons.com>
Cc: jdelvare@suse.com, linux@roeck-us.net, jic23@kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        maxime.ripard@free-electrons.com, wens@csie.org,
        thomas.petazzoni@free-electrons.com,
        antoine.tenart@free-electrons.com, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 2/3] mfd: add support for Allwinner SoCs ADC
Message-ID: <20160912135646.GB9789@dell>
References: <1473344917-1524-1-git-send-email-quentin.schulz@free-electrons.com>
 <1473344917-1524-3-git-send-email-quentin.schulz@free-electrons.com>
 <20160912091829.GB1873@dell>
 <93bd339b-85ab-d0fc-5e80-e2aca290c0d7@free-electrons.com>
 <20160912095923.GD1873@dell>
 <5dec118f-45ae-4fb6-dd1e-2028947add53@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <5dec118f-45ae-4fb6-dd1e-2028947add53@free-electrons.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 12 Sep 2016, Quentin Schulz wrote:
> On 12/09/2016 11:59, Lee Jones wrote:
> > On Mon, 12 Sep 2016, Quentin Schulz wrote:
> > 
> >> On 12/09/2016 11:18, Lee Jones wrote:
> >>> On Thu, 08 Sep 2016, Quentin Schulz wrote:
> >>>
> >> [...]
> > 
> > [...]
> > 
> >>>> +++ b/drivers/mfd/sun4i-gpadc-mfd.c
> > 
> > [...]
> > 
> >>>> +static struct mfd_cell sun4i_gpadc_mfd_cells[] = {
> >>>> +	{
> >>>> +		.name	= "sun4i-a10-gpadc-iio",
> >>>> +		.resources = adc_resources,
> >>>> +		.num_resources = ARRAY_SIZE(adc_resources),
> >>>> +	}, {
> >>>> +		.name = "iio_hwmon",
> >>>> +	}
> >>>
> >>> Single line please
> >>>
> >>> { .name = "iio_hwmon" }
> >>>
> >>
> >> +	{
> >> +		.name	= "sun4i-a10-gpadc-iio",
> >> +		.resources = adc_resources,
> >> +		.num_resources = ARRAY_SIZE(adc_resources),
> >> +	}, { .name = "iio_hwmon" }
> >>
> >> or
> >>
> >> +	{
> >> +		.name	= "sun4i-a10-gpadc-iio",
> >> +		.resources = adc_resources,
> >> +		.num_resources = ARRAY_SIZE(adc_resources),
> >> +	},
> >> +	{ .name = "iio_hwmon" }
> >>
> >> ?
> > 
> > The latter.
> > 
> > [...]
> > 
> >>>> +static const struct of_device_id sun4i_gpadc_mfd_of_match[] = {
> >>>> +	{
> >>>> +		.compatible = "allwinner,sun4i-a10-ts",
> >>>> +		.data = &sun4i_gpadc_mfd_cells,
> >>>> +	}, {
> >>>> +		.compatible = "allwinner,sun5i-a13-ts",
> >>>> +		.data = &sun5i_gpadc_mfd_cells,
> >>>> +	}, {
> >>>> +		.compatible = "allwinner,sun6i-a31-ts",
> >>>> +		.data = &sun6i_gpadc_mfd_cells,
> >>>> +	}, { /* sentinel */ }
> >>>> +};
> >>>
> >>> Don't mix OF and MFD functionality.
> >>>
> >>> Why don't you create a node for "iio_hwmon" and have
> >>> platform_of_populate() do your bidding?
> >>>
> >>
> >> We are using a stable binding which we cannot modify. This means, the DT
> >> in its current state can only be modified to add features, which is not
> >> the case of this driver (it is a rewriting of an existing driver which
> >> uses the rtp node).
> > 
> > Then use .data = <defined model ID> and set up a switch() in .probe().
> > 
> >>>> +static int sun4i_gpadc_mfd_probe(struct platform_device *pdev)
> >>>
> >>> Remove all mention of "mfd" from this file.
> >>>
> >>> (Accept the calls to the MFD API of course).
> >>>
> >> [...]
> >>>> +
> >>>> +MODULE_DEVICE_TABLE(of, sun4i_gpadc_mfd_of_match);
> >>>
> >>> Place this directly under the table.
> >>>
> >>>> +static struct platform_driver sun4i_gpadc_mfd_driver = {
> >>>> +	.driver = {
> >>>> +		.name = "sun4i-adc-mfd",
> >>>> +		.of_match_table = of_match_ptr(sun4i_gpadc_mfd_of_match),
> >>>> +	},
> >>>> +	.probe = sun4i_gpadc_mfd_probe,
> >>>
> >>> No .remove?
> >>>
> >>
> >> No, everything in probe is handled with devm functions.
> > 
> > Don't you need to undo the register write you did?
> > 
> 
> The regmap_write I use is there to disable all interrupts on hardware
> side before the irq_chip handles all interrupts by itself. The
> interrupts are not used in the MFD driver.
> 
> Thus, I chose to disable the hardware interrupts in the remove function
> of drivers using the interrupts (only the IIO yet but the touchscreen
> driver later also which will be using a third interrupt). When the MFD
> driver is removed, the MFD cells will all be removed, thus calling their
> own remove functions, thus disabling hardware interrupts used in each
> driver. So the hardware interrupts disabling would be called twice.

This does send some little alarm bells ringing.  I'd normally expect
the .remove function to undo everything you did in .probe.  So, if you
are disabling the IRQs from within the leaf drivers, shouldn't you be
initialising them in the leaf driver's respective .probes?

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
