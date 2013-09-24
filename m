Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:38240 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750823Ab3IXHi2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 24 Sep 2013 03:38:28 -0400
From: =?utf-8?q?J=C3=BCrgen_Beisert?= <jbe@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/9] Staging/iio/adc/touchscreen/MXS: add proper clock handling
Date: Tue, 24 Sep 2013 09:39:48 +0200
Cc: Lothar =?utf-8?q?Wa=C3=9Fmann?= <LW@karo-electronics.de>,
	linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
	marex@denx.de, fabio.estevam@freescale.com, jic23@cam.ac.uk,
	linux-input@vger.kernel.org
References: <1379946998-23041-1-git-send-email-jbe@pengutronix.de> <1379946998-23041-2-git-send-email-jbe@pengutronix.de> <21056.24202.312851.105281@ipc1.ka-ro>
In-Reply-To: <21056.24202.312851.105281@ipc1.ka-ro>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Message-Id: <201309240939.48094.jbe@pengutronix.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Lothar,

On Monday 23 September 2013 17:30:18 Lothar Waßmann wrote:
> > [...]
> > @@ -928,6 +931,9 @@ static int mxs_lradc_probe(struct platform_device
> > *pdev) if (IS_ERR(lradc->base))
> >  		return PTR_ERR(lradc->base);
> >
> > +	lradc->clk = devm_clk_get(&pdev->dev, NULL);
> > +	clk_prepare_enable(lradc->clk);
> > +
>
> Wouldn't it make sense to enable the clock only when the device is
> opened to save power while not actually in use?

Sure. But I haven't analyzed yet if the IIO part of the driver also uses the 
delay units and - more important - when it use them.

@Marek: can you tell us, where the clock should be enabled in your part of the 
driver (if required)?

BTW: do we also need to get and enable the 24 MHz clock (used by the ADC 
itself)? I'm not sure if this clock is the "CLK_ANA24M" shown in 
their "Logical Diagram of Clock Domains". The datasheets also mention 
the "clk_xtal24m" clock for "analog 24 MHz clock domains". But does "Fixed 
clock domains" mean they are not switchable and thus always enabled?

Regards,
Juergen

-- 
Pengutronix e.K.                              | Juergen Beisert             |
Linux Solutions for Science and Industry      | http://www.pengutronix.de/  |
