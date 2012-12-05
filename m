Return-Path: <lars@metafoo.de>
Message-ID: <50BF8875.3080108@metafoo.de>
Date: Wed, 05 Dec 2012 18:46:29 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Denis CIOCCA <denis.ciocca@st.com>
CC: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio:common: Add STMicroelectronics common driver
References: <1354623414-10742-1-git-send-email-denis.ciocca@st.com> <1354623414-10742-2-git-send-email-denis.ciocca@st.com>
In-Reply-To: <1354623414-10742-2-git-send-email-denis.ciocca@st.com>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 12/04/2012 01:16 PM, Denis CIOCCA wrote:
> +
> +/**
> + * struct st_sensors_data - ST sensors device status
> + * @dev: Pointer to instance of struct device (I2C or SPI).
> + * @trig: The trigger in use by the core driver.
> + * @enabled: Status of the sensor (false->off, true->on).
> + * @multiread_bit: Use or not particular bit for [I2C/SPI] multiread.
> + * @index: Number used to point the sensor being used in the
> + *	st_sensors_sensors struct.
> + * @buffer_data: Data used by buffer part.
> + * @fullscale: Maximum range of measure by the sensor.
> + * @gain: Sensitivity of the sensor [m/s^2/LSB].
> + * @odr: Output data rate of the sensor [Hz].
> + * @buf_lock: Mutex to protect rx and tx buffers.
> + * @tx_buf: Buffer used by SPI transfer function to send data to the sensors.
> + *	This buffer is used to avoid DMA not-aligned issue.
> + * @rx_buf: Buffer used by SPI transfer to receive data from sensors.
> + *	This buffer is used to avoid DMA not-aligned issue.
> + * @read_byte: Function used to read one byte.
> + * @write_byte: Function used to write one byte.
> + * @read_multiple_byte: Function used to read multiple byte.
> + */
> +
> +struct st_sensors_data {
[...]
> +
> +	struct mutex buf_lock;
> +	u8 tx_buf[ST_SENSORS_TX_MAX_LENGHT] ____cacheline_aligned;
> +	u8 rx_buf[ST_SENSORS_RX_MAX_LENGHT] ____cacheline_aligned;

The point of making the buffers cacheline aligned is that they get their own
cacheline. By putting elements in the struct after the buffer these will end
up on the same cacheline as the buffer. So move the callbacks above the
buffers. As far as I know it is ok, if the tx and rx buffer are on the same
cacheline so you just need to have ____cacheline_aligned on the tx_buf.

> +
> +	int (*read_byte) (struct st_sensors_data *adata, u8 reg_addr,
> +								u8 *res_byte);
> +	int (*write_byte) (struct st_sensors_data *adata, u8 reg_addr, u8 data);
> +	int (*read_multiple_byte) (struct st_sensors_data *adata, u8 reg_addr,
> +							int len, u8 *data);
> +};
