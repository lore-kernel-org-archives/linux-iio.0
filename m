Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wj0-f179.google.com ([209.85.210.179]:34929 "EHLO
        mail-wj0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759226AbdADLwz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 4 Jan 2017 06:52:55 -0500
Received: by mail-wj0-f179.google.com with SMTP id i20so8137868wjn.2
        for <linux-iio@vger.kernel.org>; Wed, 04 Jan 2017 03:52:54 -0800 (PST)
Date: Wed, 4 Jan 2017 11:56:37 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Quentin Schulz <quentin.schulz@free-electrons.com>
Cc: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, robh+dt@kernel.org, mark.rutland@arm.com,
        wens@csie.org, sre@kernel.org, linux@armlinux.org.uk,
        maxime.ripard@free-electrons.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        thomas.petazzoni@free-electrons.com, icenowy@aosc.xyz,
        bonbons@linux-vserver.org
Subject: Re: [PATCH 04/22] mfd: axp20x: add ADC cells for AXP20X and AXP22X
 PMICs
Message-ID: <20170104115637.GC24058@dell>
References: <20170102163723.7939-1-quentin.schulz@free-electrons.com>
 <20170102163723.7939-5-quentin.schulz@free-electrons.com>
 <20170104115602.GB24058@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20170104115602.GB24058@dell>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, 04 Jan 2017, Lee Jones wrote:

> On Mon, 02 Jan 2017, Quentin Schulz wrote:
> 
> > This adds the AXP20X/AXP22x ADCs driver to the mfd cells of the AXP209,
> > AXP221 and AXP223 MFD.
> > 
> > Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> > ---
> >  drivers/mfd/axp20x.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> 
> Applied, thanks.

Whoops, wrong key combo!  Should have been:

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

> > diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
> > index a33db5e..31a84d81 100644
> > --- a/drivers/mfd/axp20x.c
> > +++ b/drivers/mfd/axp20x.c
> > @@ -582,6 +582,9 @@ static struct mfd_cell axp20x_cells[] = {
> >  	}, {
> >  		.name		= "axp20x-regulator",
> >  	}, {
> > +		.name		= "axp20x-adc",
> > +		.of_compatible	= "x-powers,axp209-adc",
> > +	}, {
> >  		.name		= "axp20x-ac-power-supply",
> >  		.of_compatible	= "x-powers,axp202-ac-power-supply",
> >  		.num_resources	= ARRAY_SIZE(axp20x_ac_power_supply_resources),
> > @@ -602,6 +605,9 @@ static struct mfd_cell axp221_cells[] = {
> >  	}, {
> >  		.name		= "axp20x-regulator",
> >  	}, {
> > +		.name		= "axp20x-adc",
> > +		.of_compatible	= "x-powers,axp221-adc"
> > +	}, {
> >  		.name		= "axp20x-usb-power-supply",
> >  		.of_compatible	= "x-powers,axp221-usb-power-supply",
> >  		.num_resources	= ARRAY_SIZE(axp22x_usb_power_supply_resources),
> > @@ -615,6 +621,9 @@ static struct mfd_cell axp223_cells[] = {
> >  		.num_resources		= ARRAY_SIZE(axp22x_pek_resources),
> >  		.resources		= axp22x_pek_resources,
> >  	}, {
> > +		.name		= "axp20x-adc",
> > +		.of_compatible	= "x-powers,axp221-adc"
> > +	}, {
> >  		.name			= "axp20x-regulator",
> >  	}, {
> >  		.name		= "axp20x-usb-power-supply",
> 

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
