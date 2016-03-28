Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:43955 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753416AbcC1IJQ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 28 Mar 2016 04:09:16 -0400
Subject: Re: [PATCH 3/4] iio: st_sensors: verify interrupt event to status
To: Linus Walleij <linus.walleij@linaro.org>, linux-iio@vger.kernel.org
References: <1458825486-17188-1-git-send-email-linus.walleij@linaro.org>
 <1458825486-17188-3-git-send-email-linus.walleij@linaro.org>
Cc: Giuseppe Barba <giuseppe.barba@st.com>,
	Denis Ciocca <denis.ciocca@st.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56F8E6AC.9090609@kernel.org>
Date: Mon, 28 Mar 2016 09:09:16 +0100
MIME-Version: 1.0
In-Reply-To: <1458825486-17188-3-git-send-email-linus.walleij@linaro.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 24/03/16 13:18, Linus Walleij wrote:
> This makes all ST sensor drivers check that they actually have
> new data available for the requested channel(s) before claiming
> an IRQ, by reading the status register (which is conveniently
> the same for all ST sensors) and check that the channel has new
> data before proceeding to read it and fill the buffer.
> 
> This way sensors can share an interrupt line: it can be flaged
> as shared and then the sensor that did not fire will return
> NO_IRQ, and the sensor that fired will handle the IRQ and
> return IRQ_HANDLED.
> 
Looks good and even matches on the archaic lis3l02dq I keep meaning
to add to the driver :) (had that datasheet lying around)

One day we'll figure out how to report 'overruns' sensibly at
which point we can use the other bits in that register as well.

Anyhow, will let this sit just a little longer as would like Denis
and/or Giuseppe to have a look at it as well.

Jonathan
> Cc: Giuseppe Barba <giuseppe.barba@st.com>
> Cc: Denis Ciocca <denis.ciocca@st.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/iio/accel/st_accel_core.c                 |  5 +++++
>  drivers/iio/common/st_sensors/st_sensors_buffer.c | 18 ++++++++++++++++++
>  drivers/iio/gyro/st_gyro_core.c                   |  3 +++
>  drivers/iio/magnetometer/st_magn_core.c           |  1 +
>  drivers/iio/pressure/st_pressure_core.c           |  2 ++
>  include/linux/iio/common/st_sensors.h             |  3 +++
>  6 files changed, 32 insertions(+)
> 
> diff --git a/drivers/iio/accel/st_accel_core.c b/drivers/iio/accel/st_accel_core.c
> index a03a1417dd63..4df4c278af23 100644
> --- a/drivers/iio/accel/st_accel_core.c
> +++ b/drivers/iio/accel/st_accel_core.c
> @@ -302,6 +302,7 @@ static const struct st_sensor_settings st_accel_sensors_settings[] = {
>  			.mask_int2 = ST_ACCEL_1_DRDY_IRQ_INT2_MASK,
>  			.addr_ihl = ST_ACCEL_1_IHL_IRQ_ADDR,
>  			.mask_ihl = ST_ACCEL_1_IHL_IRQ_MASK,
> +			.addr_stat_drdy = ST_SENSORS_DEFAULT_STAT_ADDR,
>  		},
>  		.multi_read_bit = ST_ACCEL_1_MULTIREAD_BIT,
>  		.bootime = 2,
> @@ -367,6 +368,7 @@ static const struct st_sensor_settings st_accel_sensors_settings[] = {
>  			.mask_int2 = ST_ACCEL_2_DRDY_IRQ_INT2_MASK,
>  			.addr_ihl = ST_ACCEL_2_IHL_IRQ_ADDR,
>  			.mask_ihl = ST_ACCEL_2_IHL_IRQ_MASK,
> +			.addr_stat_drdy = ST_SENSORS_DEFAULT_STAT_ADDR,
>  		},
>  		.multi_read_bit = ST_ACCEL_2_MULTIREAD_BIT,
>  		.bootime = 2,
> @@ -444,6 +446,7 @@ static const struct st_sensor_settings st_accel_sensors_settings[] = {
>  			.mask_int2 = ST_ACCEL_3_DRDY_IRQ_INT2_MASK,
>  			.addr_ihl = ST_ACCEL_3_IHL_IRQ_ADDR,
>  			.mask_ihl = ST_ACCEL_3_IHL_IRQ_MASK,
> +			.addr_stat_drdy = ST_SENSORS_DEFAULT_STAT_ADDR,
>  			.ig1 = {
>  				.en_addr = ST_ACCEL_3_IG1_EN_ADDR,
>  				.en_mask = ST_ACCEL_3_IG1_EN_MASK,
> @@ -502,6 +505,7 @@ static const struct st_sensor_settings st_accel_sensors_settings[] = {
>  		.drdy_irq = {
>  			.addr = ST_ACCEL_4_DRDY_IRQ_ADDR,
>  			.mask_int1 = ST_ACCEL_4_DRDY_IRQ_INT1_MASK,
> +			.addr_stat_drdy = ST_SENSORS_DEFAULT_STAT_ADDR,
>  		},
>  		.multi_read_bit = ST_ACCEL_4_MULTIREAD_BIT,
>  		.bootime = 2, /* guess */
> @@ -553,6 +557,7 @@ static const struct st_sensor_settings st_accel_sensors_settings[] = {
>  			.mask_int2 = ST_ACCEL_5_DRDY_IRQ_INT2_MASK,
>  			.addr_ihl = ST_ACCEL_5_IHL_IRQ_ADDR,
>  			.mask_ihl = ST_ACCEL_5_IHL_IRQ_MASK,
> +			.addr_stat_drdy = ST_SENSORS_DEFAULT_STAT_ADDR,
>  		},
>  		.multi_read_bit = ST_ACCEL_5_MULTIREAD_BIT,
>  		.bootime = 2, /* guess */
> diff --git a/drivers/iio/common/st_sensors/st_sensors_buffer.c b/drivers/iio/common/st_sensors/st_sensors_buffer.c
> index 2ce0d2a3f855..c55898543a47 100644
> --- a/drivers/iio/common/st_sensors/st_sensors_buffer.c
> +++ b/drivers/iio/common/st_sensors/st_sensors_buffer.c
> @@ -58,6 +58,24 @@ irqreturn_t st_sensors_trigger_handler(int irq, void *p)
>  	struct iio_dev *indio_dev = pf->indio_dev;
>  	struct st_sensor_data *sdata = iio_priv(indio_dev);
>  
> +	/* If we have a status register, check if this IRQ came from us */
> +	if (sdata->sensor_settings->drdy_irq.addr_stat_drdy) {
> +		u8 status;
> +
> +		len = sdata->tf->read_byte(&sdata->tb, sdata->dev,
> +			   sdata->sensor_settings->drdy_irq.addr_stat_drdy,
> +			   &status);
> +		if (len < 0)
> +			dev_err(sdata->dev, "could not read channel status\n");
> +
> +		/*
> +		 * If this was not caused by any channels on this sensor,
> +		 * return IRQ_NONE
> +		 */
> +		if (!(status & (u8)indio_dev->active_scan_mask[0]))
> +			return IRQ_NONE;
> +	}
> +
>  	len = st_sensors_get_buffer_element(indio_dev, sdata->buffer_data);
>  	if (len < 0)
>  		goto st_sensors_get_buffer_element_error;
> diff --git a/drivers/iio/gyro/st_gyro_core.c b/drivers/iio/gyro/st_gyro_core.c
> index 110f95b6e52f..be9057e89dc3 100644
> --- a/drivers/iio/gyro/st_gyro_core.c
> +++ b/drivers/iio/gyro/st_gyro_core.c
> @@ -190,6 +190,7 @@ static const struct st_sensor_settings st_gyro_sensors_settings[] = {
>  			 * drain settings, but only for INT1 and not
>  			 * for the DRDY line on INT2.
>  			 */
> +			.addr_stat_drdy = ST_SENSORS_DEFAULT_STAT_ADDR,
>  		},
>  		.multi_read_bit = ST_GYRO_1_MULTIREAD_BIT,
>  		.bootime = 2,
> @@ -258,6 +259,7 @@ static const struct st_sensor_settings st_gyro_sensors_settings[] = {
>  			 * drain settings, but only for INT1 and not
>  			 * for the DRDY line on INT2.
>  			 */
> +			.addr_stat_drdy = ST_SENSORS_DEFAULT_STAT_ADDR,
>  		},
>  		.multi_read_bit = ST_GYRO_2_MULTIREAD_BIT,
>  		.bootime = 2,
> @@ -322,6 +324,7 @@ static const struct st_sensor_settings st_gyro_sensors_settings[] = {
>  			 * drain settings, but only for INT1 and not
>  			 * for the DRDY line on INT2.
>  			 */
> +			.addr_stat_drdy = ST_SENSORS_DEFAULT_STAT_ADDR,
>  		},
>  		.multi_read_bit = ST_GYRO_3_MULTIREAD_BIT,
>  		.bootime = 2,
> diff --git a/drivers/iio/magnetometer/st_magn_core.c b/drivers/iio/magnetometer/st_magn_core.c
> index 501f858df413..62036d2a9956 100644
> --- a/drivers/iio/magnetometer/st_magn_core.c
> +++ b/drivers/iio/magnetometer/st_magn_core.c
> @@ -484,6 +484,7 @@ static const struct st_sensor_settings st_magn_sensors_settings[] = {
>  			.mask_int1 = ST_MAGN_3_DRDY_INT_MASK,
>  			.addr_ihl = ST_MAGN_3_IHL_IRQ_ADDR,
>  			.mask_ihl = ST_MAGN_3_IHL_IRQ_MASK,
> +			.addr_stat_drdy = ST_SENSORS_DEFAULT_STAT_ADDR,
>  		},
>  		.multi_read_bit = ST_MAGN_3_MULTIREAD_BIT,
>  		.bootime = 2,
> diff --git a/drivers/iio/pressure/st_pressure_core.c b/drivers/iio/pressure/st_pressure_core.c
> index 172393ad34af..1cd37eaa4a57 100644
> --- a/drivers/iio/pressure/st_pressure_core.c
> +++ b/drivers/iio/pressure/st_pressure_core.c
> @@ -226,6 +226,7 @@ static const struct st_sensor_settings st_press_sensors_settings[] = {
>  			.mask_int2 = ST_PRESS_LPS331AP_DRDY_IRQ_INT2_MASK,
>  			.addr_ihl = ST_PRESS_LPS331AP_IHL_IRQ_ADDR,
>  			.mask_ihl = ST_PRESS_LPS331AP_IHL_IRQ_MASK,
> +			.addr_stat_drdy = ST_SENSORS_DEFAULT_STAT_ADDR,
>  		},
>  		.multi_read_bit = ST_PRESS_LPS331AP_MULTIREAD_BIT,
>  		.bootime = 2,
> @@ -312,6 +313,7 @@ static const struct st_sensor_settings st_press_sensors_settings[] = {
>  			.mask_int2 = ST_PRESS_LPS25H_DRDY_IRQ_INT2_MASK,
>  			.addr_ihl = ST_PRESS_LPS25H_IHL_IRQ_ADDR,
>  			.mask_ihl = ST_PRESS_LPS25H_IHL_IRQ_MASK,
> +			.addr_stat_drdy = ST_SENSORS_DEFAULT_STAT_ADDR,
>  		},
>  		.multi_read_bit = ST_PRESS_LPS25H_MULTIREAD_BIT,
>  		.bootime = 2,
> diff --git a/include/linux/iio/common/st_sensors.h b/include/linux/iio/common/st_sensors.h
> index 6670c3d25c58..d8da075bfda0 100644
> --- a/include/linux/iio/common/st_sensors.h
> +++ b/include/linux/iio/common/st_sensors.h
> @@ -37,6 +37,7 @@
>  #define ST_SENSORS_DEFAULT_AXIS_ADDR		0x20
>  #define ST_SENSORS_DEFAULT_AXIS_MASK		0x07
>  #define ST_SENSORS_DEFAULT_AXIS_N_BIT		3
> +#define ST_SENSORS_DEFAULT_STAT_ADDR		0x27
>  
>  #define ST_SENSORS_MAX_NAME			17
>  #define ST_SENSORS_MAX_4WAI			7
> @@ -121,6 +122,7 @@ struct st_sensor_bdu {
>   * @mask_int2: mask to enable/disable IRQ on INT2 pin.
>   * @addr_ihl: address to enable/disable active low on the INT lines.
>   * @mask_ihl: mask to enable/disable active low on the INT lines.
> + * @addr_stat_drdy: address to read status of DRDY (data ready) interrupt
>   * struct ig1 - represents the Interrupt Generator 1 of sensors.
>   * @en_addr: address of the enable ig1 register.
>   * @en_mask: mask to write the on/off value for enable.
> @@ -131,6 +133,7 @@ struct st_sensor_data_ready_irq {
>  	u8 mask_int2;
>  	u8 addr_ihl;
>  	u8 mask_ihl;
> +	u8 addr_stat_drdy;
>  	struct {
>  		u8 en_addr;
>  		u8 en_mask;
> 

