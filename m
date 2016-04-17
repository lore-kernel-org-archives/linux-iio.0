Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:53255 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751385AbcDQLcg (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 17 Apr 2016 07:32:36 -0400
Subject: Re: [PATCH V3 26/29] iio: use parity32 in adxrs450
To: zengzhaoxiu@163.com, linux-kernel@vger.kernel.org
References: <1460601525-3822-1-git-send-email-zengzhaoxiu@163.com>
 <1460603530-5761-1-git-send-email-zengzhaoxiu@163.com>
Cc: Zhaoxiu Zeng <zhaoxiu.zeng@gmail.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <57137451.1080605@kernel.org>
Date: Sun, 17 Apr 2016 12:32:33 +0100
MIME-Version: 1.0
In-Reply-To: <1460603530-5761-1-git-send-email-zengzhaoxiu@163.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 14/04/16 04:12, zengzhaoxiu@163.com wrote:
> From: Zhaoxiu Zeng <zhaoxiu.zeng@gmail.com>
> 
> Signed-off-by: Zhaoxiu Zeng <zhaoxiu.zeng@gmail.com>
Acked-by: Jonathan Cameron <jic23@kernel.org>

I did ack the previous version and this seems unchanged,
so please do pick up those Acks and carry them with the
series and it makes it obvious when reviewers need to look
again!

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

