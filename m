Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853AB324B33;
	Sat, 30 May 2026 16:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780157145; cv=none; b=c6JQE6db/xtEWuo9KYREj1rlgJK5bIKHz26gP66UJTHAz0mp+7dtg+2GDZ+aQuoQf/g91THasBbHs2Lgh8O5D1ZsgNm+LSGOm/koSgkiH2HgPB37YRrYvwbbr6TvyuwvWj5tokc/lWAmTXT0PiOQmG3QUhXisldJddj+/EzqqP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780157145; c=relaxed/simple;
	bh=Sq8ZxPT/G3zFlv6sRvriotdJ+HzFgC7wa2ISDn6HCRY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t1Lqacr/OWTfeIXSjIKFx3tvh21l1BQC01pEPma1afNFgsduyzeWs8zWullg7AiHWGzTeMlhmVtzv/NT3H+nkNsVmowputJTRHP2osceObaMT0H2WA8/0tXtRCoCn4Qh0We2KjsTzTjdl7IloVP8IjXxcAVSmCnXb/AoNLNqeYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LjsinQpJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LjsinQpJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC9D91F00893;
	Sat, 30 May 2026 16:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780157143;
	bh=au8o4CZ62G+3miAUN480QYBgPfk74D53Glo7/Vn0oKE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=LjsinQpJC2gif7IhiUawsM2TnUAI8ozxY4soPUuZI7kq6YF/5cHZwRLcP6I0TjLg9
	 EJ3GbCHeEA1CQ239D+uWha+Sb/+I1NzmmJdvTFD98+IP27w/0peC/Kv0P6OlSsCLXM
	 8LIH04VtbgwQf2iH+DvQrGwWc+LYQIrSwiNtH0r6FrakVm7gnlnydBw4eRVIsrD5AP
	 wX555u0vWNXzeYkWwR1wFwMlWp57Hbc6sLjwkB5CQnr+959xef4cZ/M+dkKNpKH3/V
	 /vnTNdB58sErcBOFUOsGbnLANmFhXhHT1T7AkUVBsZWWFtNxYT87ww6sSNSeCQAscH
	 69Kzd/pEbYsdQ==
Date: Sat, 30 May 2026 17:05:34 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: SeungJu Cheon <suunj1331@gmail.com>
Cc: linux-iio@vger.kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, apokusinski01@gmail.com, me@brighamcampbell.com,
 skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH 4/4] iio: pressure: mpl3115: add hardware FIFO support
Message-ID: <20260530170534.11f8e7f7@jic23-huawei>
In-Reply-To: <20260530113938.171540-5-suunj1331@gmail.com>
References: <20260530113938.171540-1-suunj1331@gmail.com>
	<20260530113938.171540-5-suunj1331@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 30 May 2026 20:39:38 +0900
SeungJu Cheon <suunj1331@gmail.com> wrote:

> Add support for the MPL3115A2 hardware FIFO.
> 
> The device provides a 32-sample FIFO with configurable
> watermark interrupts, allowing buffered data acquisition
> with reduced interrupt and CPU overhead.
> 
> Use a kfifo-backed IIO buffer when a DRDY interrupt and
> SMBus block reads are available, falling back to the
> existing triggered buffer implementation otherwise.
> 
> When enabled, the driver configures the FIFO in circular
> mode and drains accumulated samples on watermark
> interrupts.
> 
> Overflow conditions are handled by flushing available
> samples before resetting the FIFO, avoiding unnecessary
> data loss.
> 
> The hardware always captures pressure and temperature
> samples together, so FIFO operation requires both channels
> to be enabled.
> 
> Register cache updates are performed only after successful
> I2C writes to keep cached and hardware state consistent.
> 
> No functional change for non-buffered operation.
> 
> Signed-off-by: SeungJu Cheon <suunj1331@gmail.com>

Various comments inline to add to what Andy pointed out.

Note that even though you've had a couple of quick reviews wait at least a few
days / 1 week to see if others have review comments before doing a new version.
Any discussion will probably have finished by then.

(I can't speak for Andy, but in the UK it's too hot to do much outside
today - so I'm bored!)

Thanks,

Jonathan

> ---
>  drivers/iio/pressure/mpl3115.c | 266 +++++++++++++++++++++++++++++++--
>  1 file changed, 256 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/iio/pressure/mpl3115.c b/drivers/iio/pressure/mpl3115.c
> index 90e83e34ec43..26b6490c8c4c 100644
> --- a/drivers/iio/pressure/mpl3115.c
> +++ b/drivers/iio/pressure/mpl3115.c

> +#define MPL3115_BUF_PRESS_OFFSET 0
> +#define MPL3115_BUF_TEMP_OFFSET 4
> +#define MPL3115_BUF_TS_OFFSET 8
> +#define MPL3115_BUF_SIZE (MPL3115_BUF_TS_OFFSET + sizeof(s64))
> +
> +#define MPL3115_FIFO_SAMPLES_PER_READ 6U
comment on why 6.
> +
>  #define MPL3115_PT_DATA_EVENT_ALL GENMASK(2, 0)
>  
>  #define MPL3115_CTRL1_RESET BIT(2) /* software reset */
> @@ -63,8 +89,12 @@
>  #define MPL3115_CTRL3_IPOL2 BIT(1)
>  
>  #define MPL3115_CTRL4_INT_EN_DRDY BIT(7)
> +#define MPL3115_CTRL4_INT_EN_FIFO BIT(6)
>  #define MPL3115_CTRL4_INT_EN_PTH BIT(3)
>  #define MPL3115_CTRL4_INT_EN_TTH BIT(2)
> +#define MPL3115_CTRL4_ACTIVE_MASK \
> +	(MPL3115_CTRL4_INT_EN_DRDY | \
> +	 MPL3115_CTRL4_INT_EN_PTH | MPL3115_CTRL4_INT_EN_TTH)
>  
>  #define MPL3115_CTRL5_INT_CFG_DRDY BIT(7)
>  #define MPL3115_CTRL5_INT_CFG_FIFO BIT(6)
> @@ -94,6 +124,9 @@ struct mpl3115_data {
>  	struct mutex lock;
>  	u8 ctrl_reg1;
>  	u8 ctrl_reg4;
> +	u8 watermark;
> +	u8 fifo_buf[MPL3115_FIFO_SIZE * MPL3115_FIFO_SAMPLE_SIZE]
> +		__aligned(IIO_DMA_MINALIGN);
>  };
>  
>  enum mpl3115_irq_pin {
> @@ -101,6 +134,25 @@ enum mpl3115_irq_pin {
>  	MPL3115_IRQ_INT2,
>  };
>  
> +static int mpl3115_set_active(struct mpl3115_data *data, bool active)
> +{
> +	u8 reg;
> +	int ret;
> +
> +	if (active)
> +		reg = data->ctrl_reg1 | MPL3115_CTRL1_ACTIVE;
> +	else
> +		reg = data->ctrl_reg1 & ~MPL3115_CTRL1_ACTIVE;
> +
> +	ret = i2c_smbus_write_byte_data(data->client, MPL3115_CTRL_REG1,
> +					reg);
One line.  Or as Andy suggested split this in two, then the reg local
variable isn't needed.

> +	if (ret)
> +		return ret;
> +
> +	data->ctrl_reg1 = reg;
> +	return 0;
> +}
> +
>  static int mpl3115_request(struct mpl3115_data *data)
>  {
>  	int ret, tries = 15;
> @@ -322,6 +374,109 @@ static irqreturn_t mpl3115_trigger_handler(int irq, void *p)
>  	return IRQ_HANDLED;
>  }
>  
> +static int mpl3115_set_fifo(struct mpl3115_data *data,
> +			    enum mpl3115_fifo_mode mode)
> +{
> +	u8 f_setup;
> +
> +	f_setup = FIELD_PREP(MPL3115_F_SETUP_F_MODE, mode) |
> +		  FIELD_PREP(MPL3115_F_SETUP_F_WMRK, data->watermark);
> +
> +	return i2c_smbus_write_byte_data(data->client, MPL3115_F_SETUP,
> +			f_setup);

Align after (  Or just go a bit long and put it one line.


> +}
> +
> +static int mpl3115_fifo_reset(struct mpl3115_data *data)
> +{
> +	int ret;
> +
> +	ret = mpl3115_set_fifo(data, MPL3115_F_MODE_DISABLED);
> +	if (ret)
> +		return ret;
> +
> +	return mpl3115_set_fifo(data, MPL3115_F_MODE_CIRCULAR);
> +}
> +
> +static int mpl3115_fifo_transfer(struct mpl3115_data *data,
> +				 unsigned int sample_count)
> +{
> +	unsigned int remaining = sample_count;
> +	unsigned int offset = 0;
> +	unsigned int batch;
> +	int ret;
> +
> +	while (remaining > 0) {

Don't think this can got negative. I'd make that explicit as != 0

> +		batch = min(remaining, MPL3115_FIFO_SAMPLES_PER_READ);
> +
> +		ret = i2c_smbus_read_i2c_block_data(data->client,
> +						    MPL3115_OUT_PRESS,
> +						    batch * MPL3115_FIFO_SAMPLE_SIZE,
> +						    &data->fifo_buf[offset]);
Given this is reading up to 6 samples, it feels odd to just keep reading without
pushing any of them to the buffer. I'd rework the logic so for each iteration
of the fifo we push the data we have. That will reduce the storage requirement
quite a bit.
> +		if (ret < 0)
> +			return ret;
> +		if (ret != batch * MPL3115_FIFO_SAMPLE_SIZE)
> +			return -EIO;
> +
> +		offset += batch * MPL3115_FIFO_SAMPLE_SIZE;
> +		remaining -= batch;
> +	}
> +
> +	return 0;
> +}
> +
> +static int mpl3115_fifo_flush(struct iio_dev *indio_dev)
> +{
> +	struct mpl3115_data *data = iio_priv(indio_dev);
> +	u8 buffer[MPL3115_BUF_SIZE] __aligned(sizeof(s64)) = { };

This is only used int he loop below. Declare it down there with
an appropriate struct (see reply I sent to Andy's review)

> +	unsigned int sample_count, i;
> +	int ret;
> +	bool overflow;
> +	s64 ts;
When no other reason for ordering, reverse xmas tree preferred in IIO.


See below. I'd pull the guard() in here.

> +
> +	ret = i2c_smbus_read_byte_data(data->client, MPL3115_F_STATUS);
> +	if (ret < 0)
> +		return ret;
> +
> +	overflow = FIELD_GET(MPL3115_F_STATUS_F_OVF, ret);
> +	sample_count = FIELD_GET(MPL3115_F_STATUS_F_CNT, ret);
> +	if (sample_count == 0)

Add a comment on what overflow with no samples means. That seems
unusual.

> +		return overflow ? mpl3115_fifo_reset(data) : 0;
> +
> +	ret = mpl3115_fifo_transfer(data, sample_count);
> +	if (ret)
> +		return ret;
> +
> +	ts = iio_get_time_ns(indio_dev);

This data is coming from a fifo. How is the time grabbed here relevant?

Timestamp + fifo handling is hard. See how the invensense IMU drivers
do it.  For 1st version of this you may have to just fail the buffer
enable if the timestamp is turned on.  I'd revisit timestamps after the
rest is upstream (or at least as additional patches).

> +	for (i = 0; i < sample_count; i++) {
> +		u8 *sample = &data->fifo_buf[i * MPL3115_FIFO_SAMPLE_SIZE];
> +
> +		memcpy(&buffer[MPL3115_BUF_PRESS_OFFSET], &sample[0], 3);
> +		memcpy(&buffer[MPL3115_BUF_TEMP_OFFSET], &sample[3], 2);
> +
> +		iio_push_to_buffers_with_ts(indio_dev, buffer, sizeof(buffer), ts);
> +	}
> +
> +	if (overflow) {
> +		dev_warn_ratelimited(&data->client->dev,
> +				     "FIFO overflow, samples may be lost\n");
> +		return mpl3115_fifo_reset(data);
> +	}
> +
> +	return 0;
> +}
> +
> +static int mpl3115_set_watermark(struct iio_dev *indio_dev, unsigned int value)
> +{
> +	struct mpl3115_data *data = iio_priv(indio_dev);
> +
> +	value = clamp_val(value, 1, MPL3115_FIFO_SIZE - 1);
> +
> +	guard(mutex)(&data->lock);
> +	data->watermark = value;
> +
> +	return 0;
> +}
> +
>  static int mpl3115_config_interrupt(struct mpl3115_data *data,
>  				    u8 ctrl_reg1, u8 ctrl_reg4)
>  {
> @@ -348,6 +503,67 @@ static int mpl3115_config_interrupt(struct mpl3115_data *data,
>  	return ret;
>  }
>  
> +static int mpl3115_buffer_postenable(struct iio_dev *indio_dev)
> +{
> +	struct mpl3115_data *data = iio_priv(indio_dev);
> +	u8 ctrl_reg4;
> +	int ret;
> +
> +	guard(mutex)(&data->lock);
> +
> +	ret = mpl3115_set_active(data, false);
> +	if (ret)
> +		return ret;
> +
> +	ret = mpl3115_set_fifo(data, MPL3115_F_MODE_CIRCULAR);
> +	if (ret) {
> +		mpl3115_set_active(data, true);
> +		return ret;
> +	}
> +
> +	ctrl_reg4 = data->ctrl_reg4;
> +	ctrl_reg4 |= MPL3115_CTRL4_INT_EN_FIFO;
> +	ctrl_reg4 &= ~MPL3115_CTRL4_INT_EN_DRDY;
> +
> +	return mpl3115_config_interrupt(data,
> +		data->ctrl_reg1 | MPL3115_CTRL1_ACTIVE, ctrl_reg4);
> +}
> +
> +static int mpl3115_buffer_predisable(struct iio_dev *indio_dev)
> +{
> +	struct mpl3115_data *data = iio_priv(indio_dev);
> +	u8 ctrl_reg1, ctrl_reg4;
> +	int ret;
> +
> +	guard(mutex)(&data->lock);
> +
> +	ret = mpl3115_set_active(data, false);
> +	if (ret)
> +		return ret;
> +
> +	ret = mpl3115_set_fifo(data, MPL3115_F_MODE_DISABLED);
> +	if (ret)
> +		return ret;
> +
> +	ctrl_reg4 = data->ctrl_reg4 & ~MPL3115_CTRL4_INT_EN_FIFO;
> +	ctrl_reg1 = data->ctrl_reg1;
> +
> +	if (ctrl_reg4 & MPL3115_CTRL4_ACTIVE_MASK)
> +		ctrl_reg1 |= MPL3115_CTRL1_ACTIVE;
> +
> +	return mpl3115_config_interrupt(data, ctrl_reg1, ctrl_reg4);
> +}
> +
> +static const struct iio_buffer_setup_ops mpl3115_buffer_ops = {
> +	.postenable = mpl3115_buffer_postenable,
> +	.predisable = mpl3115_buffer_predisable,
> +};
> +
> +static const unsigned long mpl3115_scan_masks[] = {
> +	BIT(0) | BIT(1),
Maybe worth introducing an enum for those bits (use in the iio_chan_spec array elements
 as well)
> +	0,
No comma (Andy got this already)
> +};
> +
>  static const struct iio_event_spec mpl3115_temp_press_event[] = {
>  	{
>  		.type = IIO_EV_TYPE_THRESH,
> @@ -409,10 +625,19 @@ static irqreturn_t mpl3115_interrupt_handler(int irq, void *private)
>  	if (ret < 0)
>  		return IRQ_NONE;
>  
> -	if (!(ret & (MPL3115_INT_SRC_TTH | MPL3115_INT_SRC_PTH |
> -		     MPL3115_INT_SRC_DRDY)))
> +	if (!(ret & (MPL3115_INT_SRC_FIFO | MPL3115_INT_SRC_TTH |
> +		     MPL3115_INT_SRC_PTH | MPL3115_INT_SRC_DRDY)))
>  		return IRQ_NONE;
>  
> +	if (ret & MPL3115_INT_SRC_FIFO) {
> +		int flush_ret;
> +
> +		scoped_guard(mutex, &data->lock)
> +			flush_ret = mpl3115_fifo_flush(indio_dev);
> +		if (flush_ret < 0)
So this is technically not a bug but it runs into the basic argument that if you are
using automatic cleanup you shouldn't be using gotos in the same function
(says that in comments in cleanup.h - Linus was very explicit about this when people
 1st starting using these functions!)

With it pushed into the function though that doesn't matter.

> +			goto err_reset_fifo;
> +	}
> +
>  	if (ret & MPL3115_INT_SRC_DRDY)
>  		iio_trigger_poll_nested(data->drdy_trig);
>  
> @@ -444,6 +669,11 @@ static irqreturn_t mpl3115_interrupt_handler(int irq, void *private)
>  	}
>  
>  	return IRQ_HANDLED;
> +
> +err_reset_fifo:
> +	scoped_guard(mutex, &data->lock)

Hmm. This is trickier given fifo_reset is called in fifo_flush.
Maybe a wrapper and guard()  The none guard version would typically use
__mpl3115_fifo_reset() naming.


> +		mpl3115_fifo_reset(data);
> +	return IRQ_HANDLED;
>  }

>  static int mpl3115_trigger_probe(struct mpl3115_data *data,
> @@ -723,6 +954,7 @@ static int mpl3115_probe(struct i2c_client *client)
>  	const struct i2c_device_id *id = i2c_client_get_device_id(client);
>  	struct mpl3115_data *data;
>  	struct iio_dev *indio_dev;
> +	bool use_fifo;
>  	int ret;
>  
>  	ret = i2c_smbus_read_byte_data(client, MPL3115_WHO_AM_I);
> @@ -762,17 +994,31 @@ static int mpl3115_probe(struct i2c_client *client)
>  	if (ret)
>  		return ret;
>  
> +	data->watermark = MPL3115_DEFAULT_WATERMARK;
> +
>  	ret = mpl3115_trigger_probe(data, indio_dev);
>  	if (ret)
>  		return ret;
>  
> -	ret = devm_iio_triggered_buffer_setup(&client->dev,
> -				      indio_dev,
> -				      NULL,
> -				      mpl3115_trigger_handler,
> -				      NULL);
> -	if (ret)
> -		return ret;
> +	use_fifo = data->drdy_trig &&
> +	   i2c_check_functionality(client->adapter,
> +				   I2C_FUNC_SMBUS_READ_I2C_BLOCK);

Hmm. So this is always a fun thing to work out how to handle.
Gating on a particular i2c controller function isn't appropriate.
More to the point existing code is relying on that being available.

static int mpl3115_fill_trig_buffer(struct iio_dev *indio_dev, u8 *buffer)
{
	struct mpl3115_data *data = iio_priv(indio_dev);
	int ret, pos = 0;

	if (!(data->ctrl_reg1 & MPL3115_CTRL1_ACTIVE)) {
		ret = mpl3115_request(data);
		if (ret < 0)
			return ret;
	}

	if (test_bit(0, indio_dev->active_scan_mask)) {
		ret = i2c_smbus_read_i2c_block_data(data->client,
			MPL3115_OUT_PRESS, 3, &buffer[pos]);
		if (ret < 0)
			return ret;
		pos += 4;
	}

	if (test_bit(1, indio_dev->active_scan_mask)) {
		ret = i2c_smbus_read_i2c_block_data(data->client,
			MPL3115_OUT_TEMP, 2, &buffer[pos]);
		if (ret < 0)
			return ret;
	}

	return 0;
}

It's hard to retrofit a fifo and not end up with a weird control
interface. We can't remove the triggered buffer because that will be
a regression for existing users.

So the trick we have done in the past is to enable the fifo whenever
a trigger is not set, but the buffer enabled.

> +
> +	if (use_fifo) {
> +		indio_dev->available_scan_masks = mpl3115_scan_masks;
Given other changes I'm suggesting we have nothing to gate that on.
2 options:
A) take the view that's not that costly and optimize the exiting triggered
   capture for that case (as a precursor)
B) Do manual data mangling so that you don't need this.  That is just
   fill the buffer with enabled channels (that makes a mess of using a struct
   though as the first channel type changes depending on what is enabled).

I'd do (A)

> +		ret = devm_iio_kfifo_buffer_setup(&client->dev, indio_dev,
> +						  &mpl3115_buffer_ops);
Don't do this - instead...
> +		if (ret)
> +			return ret;
> +	} else {
> +		ret = devm_iio_triggered_buffer_setup(&client->dev,
> +						      indio_dev,
> +						      NULL,
> +						      mpl3115_trigger_handler,
> +						      NULL);

Do this unconditionally. It will register a kfifo so we can use that
anyway, but will also have the interface we can't remove (without it
being an ABI regression) to set the trigger.

> +		if (ret)
> +			return ret;
> +	}
>  
>  	return devm_iio_device_register(&client->dev, indio_dev);
>  }

