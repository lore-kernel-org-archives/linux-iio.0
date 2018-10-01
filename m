Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wr1-f43.google.com ([209.85.221.43]:33830 "EHLO
        mail-wr1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728791AbeJARft (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 1 Oct 2018 13:35:49 -0400
Subject: Re: Bad MAINTAINERS pattern in section 'RENESAS R-CAR GYROADC DRIVER'
To: Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org
Cc: linux-iio@vger.kernel.org
References: <20180928220152.31151-1-joe@perches.com>
From: Marek Vasut <marek.vasut@gmail.com>
Message-ID: <6b5b6ff4-1575-706e-defe-03fe4223c155@gmail.com>
Date: Mon, 1 Oct 2018 12:58:32 +0200
MIME-Version: 1.0
In-Reply-To: <20180928220152.31151-1-joe@perches.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/29/2018 12:01 AM, Joe Perches wrote:
> Please fix this defect appropriately.
> 
> linux-next MAINTAINERS section:
> 
> 	12496	RENESAS R-CAR GYROADC DRIVER
> 	12497	M:	Marek Vasut <marek.vasut@gmail.com>
> 	12498	L:	linux-iio@vger.kernel.org
> 	12499	S:	Supported
> -->	12500	F:	drivers/iio/adc/rcar_gyro_adc.c
> 
> Commit that introduced this:
> 
> commit 059c53b3232960cfd38cc46de0a7bedd642021f5
>  Author: Marek Vasut <marek.vasut+renesas@gmail.com>
>  Date:   Sat Jan 28 00:08:37 2017 +0100
>  
>      iio: adc: Add Renesas GyroADC driver
>      
>      Add IIO driver for the Renesas RCar GyroADC block. This block is a
>      simple 4/8-channel ADC which samples 12/15/24 bits of data every
>      cycle from all channels.
>      
>      Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
>      Cc: Geert Uytterhoeven <geert+renesas@glider.be>
>      Cc: Simon Horman <horms+renesas@verge.net.au>
>      Cc: Jonathan Cameron <jic23@kernel.org>
>      Cc: linux-renesas-soc@vger.kernel.org
>      Cc: Wolfram Sang <wsa@the-dreams.de>
>      Signed-off-by: Jonathan Cameron <jic23@kernel.org>
>  
>   MAINTAINERS                    |   6 +
>   drivers/iio/adc/Kconfig        |  13 +
>   drivers/iio/adc/Makefile       |   1 +
>   drivers/iio/adc/rcar-gyroadc.c | 631 +++++++++++++++++++++++++++++++++++++++++
>   4 files changed, 651 insertions(+)
> 
> No commit with drivers/iio/adc/rcar_gyro_adc.c found
> 
Fixed, thanks for the heads up.

-- 
Best regards,
Marek Vasut
