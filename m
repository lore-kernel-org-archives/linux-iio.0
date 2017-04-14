Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:56093 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751898AbdDNNwK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 14 Apr 2017 09:52:10 -0400
Subject: Re: [PATCH] iio: proximity: as3935: fix as3935_write
To: Matt Ranostay <matt.ranostay@konsulko.com>,
        linux-iio@vger.kernel.org
References: <20170414062156.26782-1-matt.ranostay@konsulko.com>
Cc: George McCollister <george.mccollister@gmail.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <bdf8a3f5-21ed-b9a7-d078-cfafcb1ccd8b@kernel.org>
Date: Fri, 14 Apr 2017 14:52:08 +0100
MIME-Version: 1.0
In-Reply-To: <20170414062156.26782-1-matt.ranostay@konsulko.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 14/04/17 07:21, Matt Ranostay wrote:
> AS3935_WRITE_DATA macro bit is incorrect and the actual write
> sequence is two leading zeros.
> 
> Cc: George McCollister <george.mccollister@gmail.com>
> Signed-off-by: Matt Ranostay <matt.ranostay@konsulko.com>
Applied to the fixes-togreg branch of iio.git and marked
for stable.

Thanks,

Jonathan
> ---
>  drivers/iio/proximity/as3935.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/proximity/as3935.c b/drivers/iio/proximity/as3935.c
> index 5656deb17261..020459513384 100644
> --- a/drivers/iio/proximity/as3935.c
> +++ b/drivers/iio/proximity/as3935.c
> @@ -50,7 +50,6 @@
>  #define AS3935_TUNE_CAP		0x08
>  #define AS3935_CALIBRATE	0x3D
>  
> -#define AS3935_WRITE_DATA	BIT(15)
>  #define AS3935_READ_DATA	BIT(14)
>  #define AS3935_ADDRESS(x)	((x) << 8)
>  
> @@ -105,7 +104,7 @@ static int as3935_write(struct as3935_state *st,
>  {
>  	u8 *buf = st->buf;
>  
> -	buf[0] = (AS3935_WRITE_DATA | AS3935_ADDRESS(reg)) >> 8;
> +	buf[0] = AS3935_ADDRESS(reg) >> 8;
>  	buf[1] = val;
>  
>  	return spi_write(st->spi, buf, 2);
> 

