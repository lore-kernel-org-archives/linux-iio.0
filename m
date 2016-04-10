Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:44278 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752734AbcDJOhq (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 10 Apr 2016 10:37:46 -0400
Subject: Re: [PATCH v2 27/30] iio: use parity32 in adxrs450
To: zengzhaoxiu@163.com, lars@metafoo.de, Michael.Hennerich@analog.com,
	knaack.h@gmx.de, pmeerw@pmeerw.net
References: <57031D9D.801@gmail.com>
 <1459937776-8438-1-git-send-email-zengzhaoxiu@163.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Zhaoxiu Zeng <zhaoxiu.zeng@gmail.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <570A6536.3000308@kernel.org>
Date: Sun, 10 Apr 2016 15:37:42 +0100
MIME-Version: 1.0
In-Reply-To: <1459937776-8438-1-git-send-email-zengzhaoxiu@163.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 06/04/16 11:16, zengzhaoxiu@163.com wrote:
> From: Zhaoxiu Zeng <zhaoxiu.zeng@gmail.com>
> 
> Signed-off-by: Zhaoxiu Zeng <zhaoxiu.zeng@gmail.com>
Applied to the togreg branch of iio.git as you seem to have addressed
Lars' comments.

Thanks,

Jonathan
> ---
>  drivers/iio/gyro/adxrs450.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/gyro/adxrs450.c b/drivers/iio/gyro/adxrs450.c
> index a330d42..307f55b 100644
> --- a/drivers/iio/gyro/adxrs450.c
> +++ b/drivers/iio/gyro/adxrs450.c
> @@ -109,7 +109,7 @@ static int adxrs450_spi_read_reg_16(struct iio_dev *indio_dev,
>  	mutex_lock(&st->buf_lock);
>  	tx = ADXRS450_READ_DATA | (reg_address << 17);
>  
> -	if (!(hweight32(tx) & 1))
> +	if (!parity32(tx))
>  		tx |= ADXRS450_P;
>  
>  	st->tx = cpu_to_be32(tx);
> @@ -145,7 +145,7 @@ static int adxrs450_spi_write_reg_16(struct iio_dev *indio_dev,
>  	mutex_lock(&st->buf_lock);
>  	tx = ADXRS450_WRITE_DATA | (reg_address << 17) | (val << 1);
>  
> -	if (!(hweight32(tx) & 1))
> +	if (!parity32(tx))
>  		tx |= ADXRS450_P;
>  
>  	st->tx = cpu_to_be32(tx);
> 

