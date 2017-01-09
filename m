Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www381.your-server.de ([78.46.137.84]:34536 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934221AbdAINpM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 9 Jan 2017 08:45:12 -0500
Subject: Re: [PATCH V2] iio: adc: Add Renesas GyroADC driver
To: Marek Vasut <marek.vasut@gmail.com>, linux-iio@vger.kernel.org
References: <20170109000309.22511-1-marek.vasut@gmail.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms+renesas@verge.net.au>
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <94f3e023-03a5-99f0-1810-15b35f3417b9@metafoo.de>
Date: Mon, 9 Jan 2017 14:45:09 +0100
MIME-Version: 1.0
In-Reply-To: <20170109000309.22511-1-marek.vasut@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 01/09/2017 01:03 AM, Marek Vasut wrote:
[...]
> +- renesas,gyroadc-mode:	GyroADC mode of operation, must be either of:
> +			1 - MB88101A mode, 12bit sampling, 4 channels
> +			2 - ADCS7476 mode, 15bit sampling, 8 channels
> +			3 - MAX1162 mode,  16bit sampling, 8 channels

So is this a ADC, or is this just a specialized SPI controller that
interfaces to an external ADC?

- Lars

