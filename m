Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from co1ehsobe006.messaging.microsoft.com ([216.32.180.189]:11291
	"EHLO co1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751115Ab3KZNfM (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 26 Nov 2013 08:35:12 -0500
Date: Tue, 26 Nov 2013 21:37:39 +0800
From: Shawn Guo <shawn.guo@linaro.org>
To: Fugang Duan <B38611@freescale.com>
CC: <jic23@kernel.org>, <sachin.kamat@linaro.org>,
	<devicetree@vger.kernel.org>, <b20596@freescale.com>,
	<linux-iio@vger.kernel.org>
Subject: Re: [PATCH v3 3/3] Documentation: add the binding file for Freescale
 vf610 ADC driver
Message-ID: <20131126133737.GA5402@S2101-09.ap.freescale.net>
References: <1385463394-11157-1-git-send-email-B38611@freescale.com>
 <1385463394-11157-4-git-send-email-B38611@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1385463394-11157-4-git-send-email-B38611@freescale.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, Nov 26, 2013 at 06:56:34PM +0800, Fugang Duan wrote:
> +Optional properties:
> +- fsl,adc-io-pinctl: Enable field for the I/O port control of MCU pins used as analog inputs.
> +- fsl,adc-vref: ADC refrence voltage value, unit is uV.
> +- fsl,adc-clk-div: Current clock divider value, such as 1,2,4,8,16 and so on.
> +- fsl,adc-res: ADC conversion mode selection, such as 8 for 8-bit, 10 for 10-bit, 12 for 12-bit mode.
> +- fsl,adc-sam-time: ADC sample time duration, number of ADC clocks, such as 2, 4, 6, 8, 12, 16, 20, 24
> +- fsl,adc-aver-sam-sel: Determines how many ADC conversions will be averaged to create the ADC average result.
> +			The Optional value is 4, 8, 16, 32.
> +- fsl,adc-hw-aver-en: Bool type to decide enable hardware average function.
> +- fsl,adc-low-power-mode: Bool type to decide enable ADC low power mode.
> +- fsl,adc-high-speed-conv: Bool type to decide enable ADC high speed mode.
> +- vref: The regulator to support ADC refrence voltage.

Shouldn't it be vref-supply?

Shawn

