Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-067.synserver.de ([212.40.185.67]:1258 "EHLO
	smtp-out-188.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750808AbbKRK1t (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 18 Nov 2015 05:27:49 -0500
Message-ID: <564C526F.7050506@metafoo.de>
Date: Wed, 18 Nov 2015 11:26:55 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Dragos Bogdan <dragos.bogdan@analog.com>,
	Jonathan Cameron <jic23@kernel.org>
CC: Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH] staging:iio:ad7780: Switch to the gpio descriptor interface
References: <1447842205-3422-1-git-send-email-dragos.bogdan@analog.com>
In-Reply-To: <1447842205-3422-1-git-send-email-dragos.bogdan@analog.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/18/2015 11:23 AM, Dragos Bogdan wrote:
> Use the gpiod interface for the powerdown_gpio instead of the deprecated
> old non-descriptor interface.
> 
> The powerdown pin can be tied high, so the gpio is optional.
> Remove the gpio_pdrst platform_data member since the new interface is
> used.
> 
> Signed-off-by: Dragos Bogdan <dragos.bogdan@analog.com>

Thanks, looks mostly good. One comment inline.

> ---
>  drivers/staging/iio/adc/ad7780.c | 26 +++++++++++---------------
>  drivers/staging/iio/adc/ad7780.h |  1 -
>  2 files changed, 11 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7780.c b/drivers/staging/iio/adc/ad7780.c
> index 618b41f..a5c5a95 100644
> --- a/drivers/staging/iio/adc/ad7780.c
> +++ b/drivers/staging/iio/adc/ad7780.c
> @@ -16,6 +16,7 @@
>  #include <linux/err.h>
>  #include <linux/sched.h>
>  #include <linux/gpio.h>

I think this include can be removed now.

[...]
