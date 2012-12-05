Return-Path: <jic23@jic23.retrosnub.co.uk>
References: <1354623414-10742-1-git-send-email-denis.ciocca@st.com> <1354623414-10742-2-git-send-email-denis.ciocca@st.com> <50BF8875.3080108@metafoo.de>
In-Reply-To: <50BF8875.3080108@metafoo.de>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="----9OGE8PBEDH7E20FHMJRDQTPL6IRV4S"
Subject: Re: [PATCH] iio:common: Add STMicroelectronics common driver
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Date: Wed, 05 Dec 2012 18:32:17 +0000
To: Lars-Peter Clausen <lars@metafoo.de>,Denis CIOCCA <denis.ciocca@st.com>
CC: Jonathan Cameron <jic23@kernel.org>,linux-iio@vger.kernel.org
Message-ID: <76bbc942-891d-472c-b40a-68593a39f479@email.android.com>
List-ID: <linux-iio@vger.kernel.org>

------9OGE8PBEDH7E20FHMJRDQTPL6IRV4S
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8bit


Good point.. must have half asleep when I read this!

-- 
Sent from my Android phone with K-9 Mail. Please excuse my brevity.

Lars-Peter Clausen <lars@metafoo.de> wrote:

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


------9OGE8PBEDH7E20FHMJRDQTPL6IRV4S
Content-Type: text/html;
 charset=utf-8
Content-Transfer-Encoding: 8bit

<html><head></head><body><br>
Good point..  must have half asleep when I read this!<br>
<br>
-- <br>
Sent from my Android phone with K-9 Mail. Please excuse my brevity.<br><br><div class="gmail_quote">Lars-Peter Clausen &lt;lars@metafoo.de&gt; wrote:<blockquote class="gmail_quote" style="margin: 0pt 0pt 0pt 0.8ex; border-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;">
<pre style="white-space: pre-wrap; word-wrap:break-word; font-family: monospace">On 12/04/2012 01:16 PM, Denis CIOCCA wrote:<br />&gt; +<br />&gt; +/**<br />&gt; + * struct st_sensors_data - ST sensors device status<br />&gt; + * @dev: Pointer to instance of struct device (I2C or SPI).<br />&gt; + * @trig: The trigger in use by the core driver.<br />&gt; + * @enabled: Status of the sensor (false-&gt;off, true-&gt;on).<br />&gt; + * @multiread_bit: Use or not particular bit for [I2C/SPI] multiread.<br />&gt; + * @index: Number used to point the sensor being used in the<br />&gt; + *	st_sensors_sensors struct.<br />&gt; + * @buffer_data: Data used by buffer part.<br />&gt; + * @fullscale: Maximum range of measure by the sensor.<br />&gt; + * @gain: Sensitivity of the sensor [m/s^2/LSB].<br />&gt; + * @odr: Output data rate of the sensor [Hz].<br />&gt; + * @buf_lock: Mutex to protect rx and tx buffers.<br />&gt; + * @tx_buf: Buffer used by SPI transfer function to send data to 
 the
sensors.<br />&gt; + *	This buffer is used to avoid DMA not-aligned issue.<br />&gt; + * @rx_buf: Buffer used by SPI transfer to receive data from sensors.<br />&gt; + *	This buffer is used to avoid DMA not-aligned issue.<br />&gt; + * @read_byte: Function used to read one byte.<br />&gt; + * @write_byte: Function used to write one byte.<br />&gt; + * @read_multiple_byte: Function used to read multiple byte.<br />&gt; + */<br />&gt; +<br />&gt; +struct st_sensors_data {<br />[...]<br />&gt; +<br />&gt; +	struct mutex buf_lock;<br />&gt; +	u8 tx_buf[ST_SENSORS_TX_MAX_LENGHT] ____cacheline_aligned;<br />&gt; +	u8 rx_buf[ST_SENSORS_RX_MAX_LENGHT] ____cacheline_aligned;<br /><br />The point of making the buffers cacheline aligned is that they get their own<br />cacheline. By putting elements in the struct after the buffer these will end<br />up on the same cacheline as the buffer. So move the callbacks above the<br />buffers. As far as I know it is ok, if the tx and rx buffer are
  on the
same<br />cacheline so you just need to have ____cacheline_aligned on the tx_buf.<br /><br />&gt; +<br />&gt; +	int (*read_byte) (struct st_sensors_data *adata, u8 reg_addr,<br />&gt; +								u8 *res_byte);<br />&gt; +	int (*write_byte) (struct st_sensors_data *adata, u8 reg_addr, u8 data);<br />&gt; +	int (*read_multiple_byte) (struct st_sensors_data *adata, u8 reg_addr,<br />&gt; +							int len, u8 *data);<br />&gt; +};<br /><br /></pre></blockquote></div></body></html>
------9OGE8PBEDH7E20FHMJRDQTPL6IRV4S--
