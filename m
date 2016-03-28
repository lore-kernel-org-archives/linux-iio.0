Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:44075 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753576AbcC1Ifo (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 28 Mar 2016 04:35:44 -0400
Subject: Re: [PATCH 28/31] iio: gyro: use parity32 in adxrs450.c
To: "zhaoxiu.zeng" <zhaoxiu.zeng@gmail.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>
References: <1458788612-4367-1-git-send-email-zhaoxiu.zeng@gmail.com>
 <56F78ED3.8080603@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56F8ECDE.3010701@kernel.org>
Date: Mon, 28 Mar 2016 09:35:42 +0100
MIME-Version: 1.0
In-Reply-To: <56F78ED3.8080603@gmail.com>
Content-Type: text/plain; charset=gbk
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 27/03/16 08:42, zhaoxiu.zeng wrote:
> From: Zeng Zhaoxiu <zhaoxiu.zeng@gmail.com>
> 
> Signed-off-by: Zeng Zhaoxiu <zhaoxiu.zeng@gmail.com>
Interesting.  Whilst obviously correct I wonder if this obscures the
intent of the code a little. Lars, what do you think?

Jonathan
> ---
>  drivers/iio/gyro/adxrs450.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/gyro/adxrs450.c b/drivers/iio/gyro/adxrs450.c
> index a330d42..f1f19fc20 100644
> --- a/drivers/iio/gyro/adxrs450.c
> +++ b/drivers/iio/gyro/adxrs450.c
> @@ -108,9 +108,7 @@ static int adxrs450_spi_read_reg_16(struct iio_dev *indio_dev,
>  
>  	mutex_lock(&st->buf_lock);
>  	tx = ADXRS450_READ_DATA | (reg_address << 17);
> -
> -	if (!(hweight32(tx) & 1))
> -		tx |= ADXRS450_P;
> +	tx |= !parity32(tx) * ADXRS450_P;
>  
>  	st->tx = cpu_to_be32(tx);
>  	ret = spi_sync_transfer(st->us, xfers, ARRAY_SIZE(xfers));
> @@ -144,9 +142,7 @@ static int adxrs450_spi_write_reg_16(struct iio_dev *indio_dev,
>  
>  	mutex_lock(&st->buf_lock);
>  	tx = ADXRS450_WRITE_DATA | (reg_address << 17) | (val << 1);
> -
> -	if (!(hweight32(tx) & 1))
> -		tx |= ADXRS450_P;
> +	tx |= !parity32(tx) * ADXRS450_P;
>  
>  	st->tx = cpu_to_be32(tx);
>  	ret = spi_write(st->us, &st->tx, sizeof(st->tx));
> 

