Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:57030 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750717AbcCESYM (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 5 Mar 2016 13:24:12 -0500
Subject: Re: [PATCH 0/4] Support for analog peripherals on LPC18xx familiy
To: Joachim Eastwood <manabian@gmail.com>
References: <1456772741-9402-1-git-send-email-manabian@gmail.com>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org, robh+dt@kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56DB2449.8090300@kernel.org>
Date: Sat, 5 Mar 2016 18:24:09 +0000
MIME-Version: 1.0
In-Reply-To: <1456772741-9402-1-git-send-email-manabian@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 29/02/16 19:05, Joachim Eastwood wrote:
> This patch set adds support for the analog (ADC and DAC) peripherals
> found on NXP LPC18xx/43xx SoCs. The ADC is a SAR converter with 10-bit
> resolution and 8 muxed inputs. The DAC is a simple single channel 10-
> bit DAC.
> 
> Note that these drivers do not support all the features found on the
> peripherals. DMA and interrupts are not supported in either drivers.
> The ADC driver also lack 'burst-mode' and hardware triggers. So for
> now the ADC is limited to single shot samples.
> 
> Both drivers tested on Embedded Artists' LPC4357 Developer's Kit.
> 
> Based on iio/testing branch from 29.02.15.
Series looks pretty good.  Will do a review of V2 - right now I haven't
found anything to add to what Peter found.

Nice little ADC from a quick read of the data sheet.  Not too complex
but still well featured.
> 
> 
> Joachim Eastwood (4):
>   iio: adc: add NXP LPC18xx ADC driver
>   dt: document NXP LPC1850 ADC driver bindings
>   iio: dac: add NXP LPC18xx DAC driver
>   dt: document NXP LPC1850 DAC driver bindings
> 
>  .../devicetree/bindings/iio/adc/lpc1850-adc.txt    |  21 ++
>  .../devicetree/bindings/iio/dac/lpc1850-dac.txt    |  20 ++
>  drivers/iio/adc/Kconfig                            |  10 +
>  drivers/iio/adc/Makefile                           |   1 +
>  drivers/iio/adc/lpc18xx_adc.c                      | 226 +++++++++++++++++++++
>  drivers/iio/dac/Kconfig                            |  10 +
>  drivers/iio/dac/Makefile                           |   1 +
>  drivers/iio/dac/lpc18xx_dac.c                      | 204 +++++++++++++++++++
>  8 files changed, 493 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/lpc1850-adc.txt
>  create mode 100644 Documentation/devicetree/bindings/iio/dac/lpc1850-dac.txt
>  create mode 100644 drivers/iio/adc/lpc18xx_adc.c
>  create mode 100644 drivers/iio/dac/lpc18xx_dac.c
> 

