Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35237 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752346AbbCHMB5 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 8 Mar 2015 08:01:57 -0400
Message-ID: <54FC3A32.8090806@kernel.org>
Date: Sun, 08 Mar 2015 12:01:54 +0000
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
Subject: Re: [PATCH 2/3] Staging: iio: meter: ade7854-i2c: code style improvements
References: <1423974765-1782-1-git-send-email-tolga.ceylan@gmail.com> <1423974765-1782-2-git-send-email-tolga.ceylan@gmail.com>
In-Reply-To: <1423974765-1782-2-git-send-email-tolga.ceylan@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 15/02/15 04:32, Tolga Ceylan wrote:
> Code reformatting based on checkpatch.pl with --strict:
> Lines over 80 characters were fixed
> 
> Signed-off-by: Tolga Ceylan <tolga.ceylan@gmail.com>
You sent me a patch for this a week before this one which was applied.
So already done :)
> ---
>  drivers/staging/iio/meter/ade7854-i2c.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/meter/ade7854-i2c.c b/drivers/staging/iio/meter/ade7854-i2c.c
> index 85a7e84..5e6fbe4 100644
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

