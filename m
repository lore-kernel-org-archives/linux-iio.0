Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:42591 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752251AbbDZSxN (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 26 Apr 2015 14:53:13 -0400
Message-ID: <553D3417.6070009@kernel.org>
Date: Sun, 26 Apr 2015 19:53:11 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Irina Tirdea <irina.tirdea@intel.com>, linux-iio@vger.kernel.org,
	Hartmut Knaack <knaack.h@gmx.de>
CC: linux-kernel@vger.kernel.org, Vlad Dogaru <vlad.dogaru@intel.com>
Subject: Re: [PATCH v2 12/17] iio: accel: mma9553: fix gpio bitnum init value
References: <1428939664-12503-1-git-send-email-irina.tirdea@intel.com> <1428939664-12503-13-git-send-email-irina.tirdea@intel.com>
In-Reply-To: <1428939664-12503-13-git-send-email-irina.tirdea@intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 13/04/15 16:40, Irina Tirdea wrote:
> Initial value of gpio bitnum is set to -1, but
> the variable is declared as unsigned.
> 
> Use a positive invalid value for initial gpio
> bitnum.
> 
> Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
> Suggested-by: Hartmut Knaack <knaack.h@gmx.de>
Applied.  I thought about adding this to the fixes-togreg
branch but got lazy and added it to the togreg one instead.

J
> ---
>  drivers/iio/accel/mma9553.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/accel/mma9553.c b/drivers/iio/accel/mma9553.c
> index 9573147..5755977 100644
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
> @@ -404,8 +405,8 @@ static int mma9553_init(struct mma9553_data *data)
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

