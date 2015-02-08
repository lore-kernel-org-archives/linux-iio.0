Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:39138 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753459AbbBHLzI (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 8 Feb 2015 06:55:08 -0500
Message-ID: <54D74E99.6080807@kernel.org>
Date: Sun, 08 Feb 2015 11:55:05 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Tolga Ceylan <tolga.ceylan@gmail.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] Staging: iio: Coding style correction
References: <1423381233-11810-1-git-send-email-tolga.ceylan@gmail.com>
In-Reply-To: <1423381233-11810-1-git-send-email-tolga.ceylan@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/02/15 07:40, Tolga Ceylan wrote:
> Line over 80 characters corrected
> 
> Signed-off-by: Tolga Ceylan <tolga.ceylan@gmail.com>
Applied, again with an amended patch title to reflect the driver
it is changing rather that simply the subsystem.
> ---
>  drivers/staging/iio/meter/ade7854-i2c.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/meter/ade7854-i2c.c b/drivers/staging/iio/meter/ade7854-i2c.c
> index 5b33c7f..5d0671a 100644
> --- a/drivers/staging/iio/meter/ade7854-i2c.c
> +++ b/drivers/staging/iio/meter/ade7854-i2c.c
> @@ -195,7 +195,8 @@ static int ade7854_i2c_read_reg_32(struct device *dev,
>  	if (ret)
>  		goto out;
>  
> -	*val = (st->rx[0] << 24) | (st->rx[1] << 16) | (st->rx[2] << 8) | st->rx[3];
> +	*val = (st->rx[0] << 24) | (st->rx[1] << 16) |
> +		(st->rx[2] << 8) | st->rx[3];
>  out:
>  	mutex_unlock(&st->buf_lock);
>  	return ret;
> 

