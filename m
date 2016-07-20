Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-oi0-f67.google.com ([209.85.218.67]:36266 "EHLO
	mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752611AbcGTBLt (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 19 Jul 2016 21:11:49 -0400
Date: Tue, 19 Jul 2016 20:11:47 -0500
From: Rob Herring <robh@kernel.org>
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>
Subject: Re: [PATCH] iio: adc: add ADC12130/ADC12132/ADC12138 ADC driver
Message-ID: <20160720011147.GA4383@rob-hp-laptop>
References: <1468854029-22153-1-git-send-email-akinobu.mita@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1468854029-22153-1-git-send-email-akinobu.mita@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, Jul 19, 2016 at 12:00:29AM +0900, Akinobu Mita wrote:
> This adds Texas Instruments' ADC12130/ADC12132/ADC12138 12-bit plus
> sign ADC driver.  I have tested with the ADC12138.  The ADC12130 and
> ADC12132 are not tested but these are similar to ADC12138 except that
> the mode programming instruction is a bit different.
> 
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Hartmut Knaack <knaack.h@gmx.de>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Peter Meerwald <pmeerw@pmeerw.net>
> ---
>  .../devicetree/bindings/iio/adc/ti-adc12138.txt    |  32 ++

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/iio/adc/Kconfig                            |  12 +
>  drivers/iio/adc/Makefile                           |   1 +
>  drivers/iio/adc/ti-adc12138.c                      | 541 +++++++++++++++++++++
>  4 files changed, 586 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/ti-adc12138.txt
>  create mode 100644 drivers/iio/adc/ti-adc12138.c
