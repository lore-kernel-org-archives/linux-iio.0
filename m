Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:32895 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751408Ab3JEJ7X (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 5 Oct 2013 05:59:23 -0400
Message-ID: <524FF12B.3030604@kernel.org>
Date: Sat, 05 Oct 2013 11:59:55 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 3/8] iio:adxrs450: Use spi_sync_transfer()
References: <1380959108-21775-1-git-send-email-lars@metafoo.de> <1380959108-21775-3-git-send-email-lars@metafoo.de>
In-Reply-To: <1380959108-21775-3-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/05/13 08:45, Lars-Peter Clausen wrote:
> Use the spi_sync_transfer() helper function instead of open-coding it. Makes
> the code a bit shorter.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Applied to the togreg branch of iio.git

Thanks,
> ---
>  drivers/iio/gyro/adxrs450.c | 12 ++----------
>  1 file changed, 2 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/iio/gyro/adxrs450.c b/drivers/iio/gyro/adxrs450.c
> index c1f40ef..1e546ba 100644
> --- a/drivers/iio/gyro/adxrs450.c
> +++ b/drivers/iio/gyro/adxrs450.c
> @@ -90,7 +90,6 @@ static int adxrs450_spi_read_reg_16(struct iio_dev *indio_dev,
>  				    u8 reg_address,
>  				    u16 *val)
>  {
> -	struct spi_message msg;
>  	struct adxrs450_state *st = iio_priv(indio_dev);
>  	u32 tx;
>  	int ret;
> @@ -114,10 +113,7 @@ static int adxrs450_spi_read_reg_16(struct iio_dev *indio_dev,
>  		tx |= ADXRS450_P;
>  
>  	st->tx = cpu_to_be32(tx);
> -	spi_message_init(&msg);
> -	spi_message_add_tail(&xfers[0], &msg);
> -	spi_message_add_tail(&xfers[1], &msg);
> -	ret = spi_sync(st->us, &msg);
> +	ret = spi_sync_transfer(st->us, xfers, ARRAY_SIZE(xfers));
>  	if (ret) {
>  		dev_err(&st->us->dev, "problem while reading 16 bit register 0x%02x\n",
>  				reg_address);
> @@ -169,7 +165,6 @@ static int adxrs450_spi_write_reg_16(struct iio_dev *indio_dev,
>   **/
>  static int adxrs450_spi_sensor_data(struct iio_dev *indio_dev, s16 *val)
>  {
> -	struct spi_message msg;
>  	struct adxrs450_state *st = iio_priv(indio_dev);
>  	int ret;
>  	struct spi_transfer xfers[] = {
> @@ -188,10 +183,7 @@ static int adxrs450_spi_sensor_data(struct iio_dev *indio_dev, s16 *val)
>  	mutex_lock(&st->buf_lock);
>  	st->tx = cpu_to_be32(ADXRS450_SENSOR_DATA);
>  
> -	spi_message_init(&msg);
> -	spi_message_add_tail(&xfers[0], &msg);
> -	spi_message_add_tail(&xfers[1], &msg);
> -	ret = spi_sync(st->us, &msg);
> +	ret = spi_sync_transfer(st->us, xfers, ARRAY_SIZE(xfers));
>  	if (ret) {
>  		dev_err(&st->us->dev, "Problem while reading sensor data\n");
>  		goto error_ret;
> 
