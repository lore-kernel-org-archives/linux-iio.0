Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:32924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751297AbdL2QYm (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 29 Dec 2017 11:24:42 -0500
Date: Fri, 29 Dec 2017 16:24:36 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Eugen Hristev <eugen.hristev@microchip.com>
Cc: <nicolas.ferre@microchip.com>, <ludovic.desroches@microchip.com>,
        <alexandre.belloni@free-electrons.com>,
        <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-input@vger.kernel.org>, <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 11/14] iio: adc: at91-sama5d2_adc: optimize scan index
 for diff channels
Message-ID: <20171229162436.5fe18421@archlinux>
In-Reply-To: <1513955241-10985-12-git-send-email-eugen.hristev@microchip.com>
References: <1513955241-10985-1-git-send-email-eugen.hristev@microchip.com>
        <1513955241-10985-12-git-send-email-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 22 Dec 2017 17:07:18 +0200
Eugen Hristev <eugen.hristev@microchip.com> wrote:

> Optimize the scan index for the differential channels. Before, it
> was single channel count + index of the first single channel
> number of the differential pair. (e.g. 11+0, +2, +4, etc.)
> Divide that number by two (since it's always even), and add it up
> as a scan index to have consecutive numbered channels in the
> index.
Why?  This is odd as it stands, but that isn't a strong enough reason
to fix it.

This is making a userspace ABI change.  We need a very strong
argument for why it is necessary and also why existing userspace
won't care.

> 
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
> ---
>  drivers/iio/adc/at91-sama5d2_adc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
> index 7b9febc..9610393 100644
> --- a/drivers/iio/adc/at91-sama5d2_adc.c
> +++ b/drivers/iio/adc/at91-sama5d2_adc.c
> @@ -209,7 +209,7 @@
>  		.channel = num,						\
>  		.channel2 = num2,					\
>  		.address = addr,					\
> -		.scan_index = num + AT91_SAMA5D2_SINGLE_CHAN_CNT,	\
> +		.scan_index = (num >> 1) + AT91_SAMA5D2_SINGLE_CHAN_CNT,\
>  		.scan_type = {						\
>  			.sign = 's',					\
>  			.realbits = 12,					\

