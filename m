Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:33666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726978AbeICApc (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 2 Sep 2018 20:45:32 -0400
Date: Sun, 2 Sep 2018 21:28:30 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/5] iio: imu: st_lsm6dsx: add read_fifo callback to
 fifo_ops
Message-ID: <20180902212830.41869adc@archlinux>
In-Reply-To: <20180830205259.7029-2-lorenzo.bianconi@redhat.com>
References: <20180830205259.7029-2-lorenzo.bianconi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 30 Aug 2018 22:52:55 +0200
Lorenzo Bianconi <lorenzo.bianconi@redhat.com> wrote:

> Remove static qualifier from st_lsm6dsx_read_fifo definition and
> introduce read_fifo function pointer in fifo_ops data structure
> in order to run the proper read_fifo routine since other compliant
> devices will use a different FIFO queueing scheme.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h        | 5 +++++
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c | 6 +++---
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c   | 3 +++
>  3 files changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> index edcd838037cd..a0a6c07aad62 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> @@ -41,13 +41,17 @@ struct st_lsm6dsx_reg {
>  	u8 mask;
>  };
>  
> +struct st_lsm6dsx_hw;
> +
>  /**
>   * struct st_lsm6dsx_fifo_ops - ST IMU FIFO settings
> + * @read_fifo: Read FIFO callback.
>   * @fifo_th: FIFO threshold register info (addr + mask).
>   * @fifo_diff: FIFO diff status register info (addr + mask).
>   * @th_wl: FIFO threshold word length.
>   */
>  struct st_lsm6dsx_fifo_ops {
> +	int (*read_fifo)(struct st_lsm6dsx_hw *hw);
>  	struct {
>  		u8 addr;
>  		u16 mask;
> @@ -175,5 +179,6 @@ int st_lsm6dsx_update_watermark(struct st_lsm6dsx_sensor *sensor,
>  int st_lsm6dsx_flush_fifo(struct st_lsm6dsx_hw *hw);
>  int st_lsm6dsx_set_fifo_mode(struct st_lsm6dsx_hw *hw,
>  			     enum st_lsm6dsx_fifo_mode fifo_mode);
> +int st_lsm6dsx_read_fifo(struct st_lsm6dsx_hw *hw);
>  
>  #endif /* ST_LSM6DSX_H */
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> index 2b49d928f4c0..7e02935a4250 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> @@ -284,7 +284,7 @@ static inline int st_lsm6dsx_read_block(struct st_lsm6dsx_hw *hw, u8 *data,
>   *
>   * Return: Number of bytes read from the FIFO
>   */
> -static int st_lsm6dsx_read_fifo(struct st_lsm6dsx_hw *hw)
> +int st_lsm6dsx_read_fifo(struct st_lsm6dsx_hw *hw)
>  {
>  	u16 fifo_len, pattern_len = hw->sip * ST_LSM6DSX_SAMPLE_SIZE;
>  	u16 fifo_diff_mask = hw->settings->fifo_ops.fifo_diff.mask;
> @@ -408,7 +408,7 @@ int st_lsm6dsx_flush_fifo(struct st_lsm6dsx_hw *hw)
>  
>  	mutex_lock(&hw->fifo_lock);
>  
> -	st_lsm6dsx_read_fifo(hw);
> +	hw->settings->fifo_ops.read_fifo(hw);
>  	err = st_lsm6dsx_set_fifo_mode(hw, ST_LSM6DSX_FIFO_BYPASS);
>  
>  	mutex_unlock(&hw->fifo_lock);
> @@ -480,7 +480,7 @@ static irqreturn_t st_lsm6dsx_handler_thread(int irq, void *private)
>  	int count;
>  
>  	mutex_lock(&hw->fifo_lock);
> -	count = st_lsm6dsx_read_fifo(hw);
> +	count = hw->settings->fifo_ops.read_fifo(hw);
>  	mutex_unlock(&hw->fifo_lock);
>  
>  	return !count ? IRQ_NONE : IRQ_HANDLED;
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> index aebbe0ddd8d8..394bcd3719e0 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> @@ -171,6 +171,7 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
>  			},
>  		},
>  		.fifo_ops = {
> +			.read_fifo = st_lsm6dsx_read_fifo,
>  			.fifo_th = {
>  				.addr = 0x06,
>  				.mask = GENMASK(11, 0),
> @@ -217,6 +218,7 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
>  			},
>  		},
>  		.fifo_ops = {
> +			.read_fifo = st_lsm6dsx_read_fifo,
>  			.fifo_th = {
>  				.addr = 0x06,
>  				.mask = GENMASK(11, 0),
> @@ -265,6 +267,7 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
>  			},
>  		},
>  		.fifo_ops = {
> +			.read_fifo = st_lsm6dsx_read_fifo,
>  			.fifo_th = {
>  				.addr = 0x06,
>  				.mask = GENMASK(10, 0),
