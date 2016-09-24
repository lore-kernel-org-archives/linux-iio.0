Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:59560 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758823AbcIXQSV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 24 Sep 2016 12:18:21 -0400
Subject: Re: [PATCH] drivers: iio: dac: Fix sparse warning
To: Sandhya Bankar <bankarsandhya512@gmail.com>, lars@metafoo.de,
        Michael.Hennerich@analog.com, knaack.h@gmx.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org
References: <20160923192022.GA10786@localhost.localdomain>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <04f40c36-9a05-f439-6d01-e59729e655e1@kernel.org>
Date: Sat, 24 Sep 2016 17:18:17 +0100
MIME-Version: 1.0
In-Reply-To: <20160923192022.GA10786@localhost.localdomain>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 23/09/16 20:20, Sandhya Bankar wrote:
> Fixing below warnings:
> 
> drivers/iio/dac/ad5592r.c:58:41: warning: incorrect type in argument 2 (different base types)
> drivers/iio/dac/ad5592r.c:58:41:    expected unsigned short [usertype] *buf
> drivers/iio/dac/ad5592r.c:58:41:    got restricted __be16 *<noident>
> drivers/iio/dac/ad5592r.c:62:41: warning: incorrect type in argument 2 (different base types)
> drivers/iio/dac/ad5592r.c:62:41:    expected unsigned short [usertype] *buf
> drivers/iio/dac/ad5592r.c:62:41:    got restricted __be16 *<noident>
> drivers/iio/dac/ad5592r.c:92:41: warning: incorrect type in argument 2 (different base types)
> drivers/iio/dac/ad5592r.c:92:41:    expected unsigned short [usertype] *buf
> drivers/iio/dac/ad5592r.c:92:41:    got restricted __be16 *<noident>
> drivers/iio/dac/ad5592r.c:110:41: warning: incorrect type in argument 2 (different base types)
> drivers/iio/dac/ad5592r.c:110:41:    expected unsigned short [usertype] *buf
> drivers/iio/dac/ad5592r.c:110:41:    got restricted __be16 *<noident>
> 
> Signed-off-by: Sandhya Bankar <bankarsandhya512@gmail.com>
Looks good to me.  Lars, will be a while before I send next pull if
you want to comment on this as well.

Applied to the togreg branch of iio.git -- initially pushed out as
testing for the autobuilders to play with it.

Thanks,

Jonathan
> ---
>  drivers/iio/dac/ad5592r.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/dac/ad5592r.c b/drivers/iio/dac/ad5592r.c
> index 0b235a2..6eed5b7 100644
> --- a/drivers/iio/dac/ad5592r.c
> +++ b/drivers/iio/dac/ad5592r.c
> @@ -17,7 +17,7 @@
>  #define AD5592R_GPIO_READBACK_EN	BIT(10)
>  #define AD5592R_LDAC_READBACK_EN	BIT(6)
>  
> -static int ad5592r_spi_wnop_r16(struct ad5592r_state *st, u16 *buf)
> +static int ad5592r_spi_wnop_r16(struct ad5592r_state *st, __be16 *buf)
>  {
>  	struct spi_device *spi = container_of(st->dev, struct spi_device, dev);
>  	struct spi_transfer t = {
> 

