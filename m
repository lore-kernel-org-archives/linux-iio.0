Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:51545 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754847AbbDILmw (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 9 Apr 2015 07:42:52 -0400
Message-ID: <552665C0.2000005@kernel.org>
Date: Thu, 09 Apr 2015 12:42:56 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Irina Tirdea <irina.tirdea@intel.com>, linux-iio@vger.kernel.org,
	Hartmut Knaack <knaack.h@gmx.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/8] iio: accel: mma9553: fix gpio bitnum init value
References: <1428503857-9081-1-git-send-email-irina.tirdea@intel.com> <1428503857-9081-4-git-send-email-irina.tirdea@intel.com>
In-Reply-To: <1428503857-9081-4-git-send-email-irina.tirdea@intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/04/15 15:37, Irina Tirdea wrote:
> Initial value of gpio bitnum is set to -1, but
> the variable is declared as unsigned.
> 
> Use a positive invalid value for initial gpio
> bitnum.
> 
> Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
> Suggested-by: Hartmut Knaack <knaack.h@gmx.de>
This is fine, but I'm feeling lazy as this isn't going
anywhere until after the merge window now. Will pick it
up once you've done the reordering to pull the fixes to the
top of the series.

J
> ---
>  drivers/iio/accel/mma9553.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/accel/mma9553.c b/drivers/iio/accel/mma9553.c
> index 9cfedb5..d781999 100644
> --- a/drivers/iio/accel/mma9553.c
> +++ b/drivers/iio/accel/mma9553.c
> @@ -78,6 +78,7 @@
>  
>  /* Bitnum used for GPIO configuration = bit number in high status byte */
>  #define MMA9553_STATUS_TO_BITNUM(bit)	(ffs(bit) - 9)
> +#define MMA9553_MAX_BITNUM		MMA9553_STATUS_TO_BITNUM(BIT(16))
>  
>  #define MMA9553_DEFAULT_SAMPLE_RATE	30	/* Hz */
>  
> @@ -406,8 +407,8 @@ static int mma9553_init(struct mma9553_data *data)
>  	}
>  
>  
> -	data->gpio_bitnum = -1;
>  	/* Reset GPIO */
> +	data->gpio_bitnum = MMA9553_MAX_BITNUM;
>  	ret = mma9553_conf_gpio(data);
>  	if (ret < 0)
>  		return ret;
> 

