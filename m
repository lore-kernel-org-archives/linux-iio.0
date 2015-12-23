Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from eusmtp01.atmel.com ([212.144.249.243]:54079 "EHLO
	eusmtp01.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934123AbbLWK3x (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 23 Dec 2015 05:29:53 -0500
Date: Wed, 23 Dec 2015 11:29:10 +0100
From: Ludovic Desroches <ludovic.desroches@atmel.com>
To: Rob Herring <robh@kernel.org>
CC: Ludovic Desroches <ludovic.desroches@atmel.com>,
	<jic23@kernel.org>, <nicolas.ferre@atmel.com>,
	<alexandre.belloni@free-electrons.com>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-iio@vger.kernel.org>, <plagnioj@jcrosoft.com>,
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 1/5] iio:adc:at91_adc8xx: introduce new atmel adc driver
Message-ID: <20151223102910.GD2789@odux.rfo.atmel.com>
References: <1450689852-22763-1-git-send-email-ludovic.desroches@atmel.com>
 <1450689852-22763-2-git-send-email-ludovic.desroches@atmel.com>
 <20151223005118.GA29457@rob-hp-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20151223005118.GA29457@rob-hp-laptop>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, Dec 22, 2015 at 06:51:18PM -0600, Rob Herring wrote:
> On Mon, Dec 21, 2015 at 10:24:08AM +0100, Ludovic Desroches wrote:
> > This driver supports the new version of the Atmel ADC device introduced
> > with the SAMA5D2 SoC family.
> > 
> > Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> > ---
> >  .../devicetree/bindings/iio/adc/at91_adc8xx.txt    |  27 ++
> >  drivers/iio/adc/Kconfig                            |  11 +
> >  drivers/iio/adc/Makefile                           |   1 +
> >  drivers/iio/adc/at91_adc8xx.c                      | 417 +++++++++++++++++++++
> >  4 files changed, 456 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/adc/at91_adc8xx.txt
> >  create mode 100644 drivers/iio/adc/at91_adc8xx.c
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/adc/at91_adc8xx.txt b/Documentation/devicetree/bindings/iio/adc/at91_adc8xx.txt
> > new file mode 100644
> > index 0000000..64ad6a5
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/adc/at91_adc8xx.txt
> > @@ -0,0 +1,27 @@
> > +* AT91 SAMA5D2 Analog to Digital Converter (ADC)
> > +
> > +Required properties:
> > +  - compatible: Should be "atmel,sama5d2-adc".
> > +  - reg: Should contain ADC registers location and length.
> > +  - interrupts: Should contain the IRQ line for the ADC.
> > +  - clocks: phandles to clocks.
> > +  - clock-names: tuple listing clock names.
> > +      Required elements: "adc_clk", "adc_op_clk". "adc_clk" is the peripheral
> > +      clock, "adc_clk" is the sampling clock.
> > +  - vref-supply: Supply used as reference for conversions.
> > +
> > +Optional properties:
> > +  - vddana-supply: Supply for the adc device.
> 
> What makes a supply optional? If chip dependent, then then you need a 
> more specific compatible string.
> 

I thought I had read that we can supply an external vddana or having a
default one. Double checking the datasheet. I can't find it, I probably
read it on a draft version. Will move the vddana supply to required
properties.

Thanks

Ludovic
