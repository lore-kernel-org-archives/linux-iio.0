Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:36270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751415AbdFZQse (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 26 Jun 2017 12:48:34 -0400
Date: Mon, 26 Jun 2017 17:48:28 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Reno Farnesi <nfarnesi4@gmail.com>
Cc: gregkh@linuxfoundation.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH] staging: iio: ad7280a: add spaces around '-'
Message-ID: <20170626174828.7445f608@kernel.org>
In-Reply-To: <1498418147.3882.10.camel@gmail.com>
References: <1498418147.3882.10.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, 25 Jun 2017 15:15:47 -0400
Reno Farnesi <nfarnesi4@gmail.com> wrote:

> Fixes the following checkpatch check to improve readability.
> 
> CHECK: spaces preferred around that '-' (ctx:VxV)
> 
> Signed-off-by: Reno Farnesi <nfarnesi4@gmail.com>
False positive.  Not everything is what it seems ;)

Check what the macro does with that parameter...

Jonathan
> ---
>  drivers/staging/iio/adc/ad7280a.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7280a.c
> b/drivers/staging/iio/adc/ad7280a.c
> index d5ab83f0236d..d79e7746d351 100644
> --- a/drivers/staging/iio/adc/ad7280a.c
> +++ b/drivers/staging/iio/adc/ad7280a.c
> @@ -745,14 +745,14 @@ static irqreturn_t ad7280_event_handler(int irq,
> void *private)
>  }
>  
>  static IIO_DEVICE_ATTR_NAMED(in_thresh_low_value,
> -		in_voltage-voltage_thresh_low_value,
> +		in_voltage - voltage_thresh_low_value,
>  		0644,
>  		ad7280_read_channel_config,
>  		ad7280_write_channel_config,
>  		AD7280A_CELL_UNDERVOLTAGE);
>  
>  static IIO_DEVICE_ATTR_NAMED(in_thresh_high_value,
> -		in_voltage-voltage_thresh_high_value,
> +		in_voltage - voltage_thresh_high_value,
>  		0644,
>  		ad7280_read_channel_config,
>  		ad7280_write_channel_config,

