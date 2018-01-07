Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:43150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753902AbeAGQUV (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 7 Jan 2018 11:20:21 -0500
Date: Sun, 7 Jan 2018 16:20:03 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Cc: linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: imu: st_lsm6dsx: pre-allocate read buffer at
 bootstrap
Message-ID: <20180107162003.1c3e1efd@archlinux>
In-Reply-To: <20180106222325.17442-2-lorenzo.bianconi@redhat.com>
References: <20180106222325.17442-2-lorenzo.bianconi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat,  6 Jan 2018 23:23:24 +0100
Lorenzo Bianconi <lorenzo.bianconi@redhat.com> wrote:

> Allocate device read buffer at bootstrap and do not put it on the stack
> since it is pretty big (~200B) and its size will increase adding support
> to device hw timestamp.
> Moreover this patch fixes following sparse warnings:
> drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c:250:17: warning: Variable length
> array is used.
> drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c:283:55: error: cannot size
> expression
> 
> Fixes: 290a6ce11d93 ("iio: imu: add support to lsm6dsx driver")
> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h        | 4 ++++
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c | 7 +++----
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c   | 4 ++++
>  3 files changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> index ccbe44cef41a..35acb9c96745 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> @@ -27,6 +27,7 @@ enum st_lsm6dsx_hw_id {
>  	ST_LSM6DSX_MAX_ID,
>  };
>  
> +#define ST_LSM6DSX_BUFF_SIZE		256
>  #define ST_LSM6DSX_CHAN_SIZE		2
>  #define ST_LSM6DSX_SAMPLE_SIZE		6
>  #define ST_LSM6DSX_MAX_WORD_LEN		((32 / ST_LSM6DSX_SAMPLE_SIZE) * \
> @@ -122,6 +123,7 @@ struct st_lsm6dsx_sensor {
>   * @fifo_mode: FIFO operating mode supported by the device.
>   * @enable_mask: Enabled sensor bitmask.
>   * @sip: Total number of samples (acc/gyro) in a given pattern.
> + * @buff: Device read buffer.
>   * @iio_devs: Pointers to acc/gyro iio_dev instances.
>   * @settings: Pointer to the specific sensor settings in use.
>   */
> @@ -137,6 +139,8 @@ struct st_lsm6dsx_hw {
>  	u8 enable_mask;
>  	u8 sip;
>  
> +	u8 *buff;
> +
>  	struct iio_dev *iio_devs[ST_LSM6DSX_ID_MAX];
>  
>  	const struct st_lsm6dsx_settings *settings;
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> index 093f9750974a..1d6aa9b1a4cf 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> @@ -247,7 +247,6 @@ static int st_lsm6dsx_read_fifo(struct st_lsm6dsx_hw *hw)
>  	struct st_lsm6dsx_sensor *acc_sensor, *gyro_sensor;
>  	s64 acc_ts, acc_delta_ts, gyro_ts, gyro_delta_ts;
>  	u8 iio_buff[ALIGN(ST_LSM6DSX_SAMPLE_SIZE, sizeof(s64)) + sizeof(s64)];
> -	u8 buff[pattern_len];
>  	__le16 fifo_status;
>  
>  	err = regmap_bulk_read(hw->regmap,
> @@ -280,7 +279,7 @@ static int st_lsm6dsx_read_fifo(struct st_lsm6dsx_hw *hw)
>  				samples);
>  
>  	for (read_len = 0; read_len < fifo_len; read_len += pattern_len) {
> -		err = st_lsm6dsx_read_block(hw, buff, sizeof(buff));
> +		err = st_lsm6dsx_read_block(hw, hw->buff, pattern_len);
>  		if (err < 0)
>  			return err;
>  
> @@ -305,7 +304,7 @@ static int st_lsm6dsx_read_fifo(struct st_lsm6dsx_hw *hw)
>  
>  		while (acc_sip > 0 || gyro_sip > 0) {
>  			if (gyro_sip-- > 0) {
> -				memcpy(iio_buff, &buff[offset],
> +				memcpy(iio_buff, &hw->buff[offset],
>  				       ST_LSM6DSX_SAMPLE_SIZE);
>  				iio_push_to_buffers_with_timestamp(
>  					hw->iio_devs[ST_LSM6DSX_ID_GYRO],
> @@ -315,7 +314,7 @@ static int st_lsm6dsx_read_fifo(struct st_lsm6dsx_hw *hw)
>  			}
>  
>  			if (acc_sip-- > 0) {
> -				memcpy(iio_buff, &buff[offset],
> +				memcpy(iio_buff, &hw->buff[offset],
>  				       ST_LSM6DSX_SAMPLE_SIZE);
>  				iio_push_to_buffers_with_timestamp(
>  					hw->iio_devs[ST_LSM6DSX_ID_ACC],
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> index 819a85bb86ec..c2fa3239b9c6 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> @@ -722,6 +722,10 @@ int st_lsm6dsx_probe(struct device *dev, int irq, int hw_id, const char *name,
>  	mutex_init(&hw->fifo_lock);
>  	mutex_init(&hw->conf_lock);
>  
> +	hw->buff = devm_kzalloc(dev, ST_LSM6DSX_BUFF_SIZE, GFP_KERNEL);
> +	if (!hw->buff)
> +		return -ENOMEM;
> +
>  	hw->dev = dev;
>  	hw->irq = irq;
>  	hw->regmap = regmap;

