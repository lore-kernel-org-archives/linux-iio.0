Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from onstation.org ([52.200.56.107]:51384 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966063AbcKXPsw (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 24 Nov 2016 10:48:52 -0500
Date: Thu, 24 Nov 2016 10:48:33 -0500
From: Brian Masney <masneyb@onstation.org>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Eva Rachel Retuya <eraretuya@gmail.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [patch] iio: tsl2583: make array large enough
Message-ID: <20161124154833.GB2118@basecamp.onstation.org>
References: <20161118140326.GA20458@basecamp.onstation.org>
 <20161124133807.GA32255@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161124133807.GA32255@mwanda>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, Nov 24, 2016 at 04:38:07PM +0300, Dan Carpenter wrote:
> This array is supposed to have 10 elements.  Smatch complains that with
> the current code we can have n == max_ints and read beyond the end of
> the array.
> 
> Fixes: ac4f6eee8fe8 ("staging: iio: TAOS tsl258x: Device driver")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> diff --git a/drivers/iio/light/tsl2583.c b/drivers/iio/light/tsl2583.c
> index 0b87f6a..a78b602 100644
> --- a/drivers/iio/light/tsl2583.c
> +++ b/drivers/iio/light/tsl2583.c
> @@ -565,7 +565,7 @@ static ssize_t in_illuminance_lux_table_store(struct device *dev,
>  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>  	struct tsl2583_chip *chip = iio_priv(indio_dev);
>  	const unsigned int max_ints = TSL2583_MAX_LUX_TABLE_ENTRIES * 3;
> -	int value[TSL2583_MAX_LUX_TABLE_ENTRIES * 3];
> +	int value[TSL2583_MAX_LUX_TABLE_ENTRIES * 3 + 1];
>  	int ret = -EINVAL;
>  	unsigned int n;
>  

Acked-by: Brian Masney <masneyb@onstation.org>
