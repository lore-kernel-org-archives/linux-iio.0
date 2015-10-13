Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-116.synserver.de ([212.40.185.116]:1428 "EHLO
	smtp-out-112.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753090AbbJMQ0H (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 13 Oct 2015 12:26:07 -0400
Message-ID: <561D3008.2010902@metafoo.de>
Date: Tue, 13 Oct 2015 18:23:36 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>
CC: Marc Andre <marc.andre@netline.ch>, linux-iio@vger.kernel.org,
	Michael Hennerich <michael.hennerich@analog.com>
Subject: Re: [PATCH 1/2] iio:ad5064: Make sure ad5064_i2c_write() returns
 0 on success
References: <1444752938-4680-1-git-send-email-lars@metafoo.de>
In-Reply-To: <1444752938-4680-1-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/13/2015 06:15 PM, Lars-Peter Clausen wrote:
> From: Michael Hennerich <michael.hennerich@analog.com>
> 
> i2c_master_send() returns the number of bytes transferred on success while
> the ad5064 driver expects that the write() callback returns 0 on success.
> Fix that by translating any non negative return value of i2c_master_send()
> to 0.
> 
> Fixes: commit 6a17a0768f77 ("iio:dac:ad5064: Add support for the ad5629r and ad5669r")
> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>

And obviously

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>

Sorry for that.

> ---
>  drivers/iio/dac/ad5064.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/dac/ad5064.c b/drivers/iio/dac/ad5064.c
> index c067e68..7e7ebf3 100644
> --- a/drivers/iio/dac/ad5064.c
> +++ b/drivers/iio/dac/ad5064.c
> @@ -598,10 +598,16 @@ static int ad5064_i2c_write(struct ad5064_state *st, unsigned int cmd,
>  	unsigned int addr, unsigned int val)
>  {
>  	struct i2c_client *i2c = to_i2c_client(st->dev);
> +	int ret;
>  
>  	st->data.i2c[0] = (cmd << 4) | addr;
>  	put_unaligned_be16(val, &st->data.i2c[1]);
> -	return i2c_master_send(i2c, st->data.i2c, 3);
> +
> +	ret = i2c_master_send(i2c, st->data.i2c, 3);
> +	if (ret < 0)
> +		return ret;
> +
> +	return 0;
>  }
>  
>  static int ad5064_i2c_probe(struct i2c_client *i2c,
> 

