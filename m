Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793934265;
	b=ZrrQJGgeD7eFmA6rsL3ctAv/KHGOJqUAmUcbppRenY/8fh5bfQRNoT+RhQUZhOgQK9U4
	 P3rUvEnBfxRKgxoOaQvsizbn/RBWi0G6sa2bJSDQ8s1WJY/M7V7Z8lyWs6OuR/wpmTrYN
	 aDh+C7Q4MyMAcQs/aJul6GEudeVAMQy7vq8stThD0IeCRnBwLkK9xKQVPWyreLIsLYYTm
	 zmt66BJSKLySJ69NNfGrvIJG0wp8Gd8pc4iGxlsqX6+U1hTaGic1YdM575rN466zSoImT
	 MiDHi0WxNrayswoid/jzwojAeuaMMrFEhxfN9M4JZUBFNZOox6QKFt3UC1z660OJJKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793934265;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=YaknactOBCTUFeqk3Uj61FLC8y4PLLFIqdY5bNGgr40=;
	b=fqKoyg0qSCuP8WedGCwheu9SH//I+rG2n/eQpYCkxPKtyc45CbHMZDK/fIUFwB/ai8qf
	 +LWtrlMVqgfhKanRv1QgpQFqVJN1+tYOCEioouLtci5bFPA2VEmyEV6FBcfDeUJz7dH/q
	 YmB0IuQq1oJojYe9Qy1ahAKEp/vuDFOAq2IMQCeffqemAqPVb0ilhq+rfhFsIGSq5heyE
	 uY2Abp2lbaeTfgSjymC7Q3O+GmmYrIrcRw5Cumr+eUaktje5xeI/tjKUI2zLGcte3shVQ
	 W7nzDxOUQnnVsEn3DS4Ew74BiFHpuhSgDfbIEXmmmV4iQhbGwKss24WM6h4DnY4ZvUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Yzzfxplw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F775606A326;
	Fri,  6 Nov 2026 03:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Yzzfxplw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B79641F0089F;
	Fri,  6 Nov 2026 03:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793934265;
	bh=YaknactOBCTUFeqk3Uj61FLC8y4PLLFIqdY5bNGgr40=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=YzzfxplwDbMvDt9qsx82YtCwODeOXZQ2t+NkAHAnD0JTe8r9T8meSKsauzfMrUGT2
	 ClSb606wJw1tQ9Q9laWzzNazkMR4mGmNoOg8yCqQhe9+maLOrfsKiJAYSrN7RcNP6p
	 Q8X/aKgAdO3eaw2tKCbsftJpN2u+fyW3Hf7HirjO4fLSHdOfo4Y4Lzf0uTWMrVQFH0
	 sfxEh4HmruWCV66rEMYzEfbyztLsvkpyhwBzlfWvvW5t89ckhzveu2NHQNbNxopqTB
	 bIuKuvSKjm1G2KmOLKYPNPjTWcbs8k8oRLeHxqtFhWUxez1YNdvbqh1x6X7AD+F7tN
	 zdQgHU986NTdw==
Date: Fri, 6 Nov 2026 03:04:19 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Viral Patel <viral8854@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: magnetometer: add Infineon TLE493D-W2B6 driver
Message-ID: <20261106030419.23ca9b26@jic23-hlaptop>
In-Reply-To: <20261105-tle493d-v1-2-3246e91e6394@gmail.com>
References: <20261105-tle493d-v1-0-3246e91e6394@gmail.com>
	<20261105-tle493d-v1-2-3246e91e6394@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 05 Nov 2026 21:23:48 +0530
Viral Patel <viral8854@gmail.com> wrote:

> Add a driver for the Infineon TLE493D-W2B6, a 3D Hall effect magnetic
> sensor with 12-bit resolution per axis and an integrated temperature
> sensor, accessed over I2C.
> 
> The sensor is run in master-controlled mode. Each measurement rewrites
> the Config register with the "trigger after write" bits set in the
> register address byte, which starts a single conversion, and then polls
> registers 0x00 to 0x06 until Diag reports a completed conversion with a
> new frame counter. Results with a fuse parity error, test mode flag or
> bad bus parity are rejected. FP and CP are recomputed on every write of
> MOD1 and Config, as a wrong FP makes the sensor release the bus until it
> is reset.
> 
> The /INT output shares a pin with SCL, so the interrupt is disabled and
> so is clock stretching. The sensor's reset sequence relies on
> zero-length messages which many I2C adapters reject, so it is sent on a
> best-effort basis during probe.
> 
> Raw I2C transfers are used rather than regmap: once PR is set a plain
> read always starts at register 0x00, and the register address byte of a
> write carries trigger bits.
> 
> The X, Y and Z channels and the temperature channel are available
> through sysfs and through a triggered buffer with a software timestamp.
> Wake-up, self-test, low-power and fast modes, sampling frequency control
> and the short range are not supported yet.
> 
> This is not added to the tlv493d driver: apart from the X/Y/Z bit
> packing, the two parts differ in write format, read protocol after
> reset, register map and parity scheme.
> 
> Based on the TLE493D-W2B6 User Manual v1.11 and Datasheet v1.2.
> 
> Datasheet: https://www.infineon.com/assets/row/public/documents/30/49/infineon-tle493d-w2b6-datasheet-en.pdf
> Signed-off-by: Viral Patel <viral8854@gmail.com>
Seems sashiko isn't done with this one yet (at time of writing)
so please take a look to see if it finds anything useful
https://sashiko.dev/#/patchset/20261105-tle493d-v1-0-3246e91e6394%40gmail.com

This hardware has a creative interface so I may have
asked some questions that reflect my general state of
confusion induced by that.

A few things inline,

> diff --git a/drivers/iio/magnetometer/tle493d.c b/drivers/iio/magnetometer/tle493d.c
> new file mode 100644
> index 000000000000..232f7680a02b
> --- /dev/null
> +++ b/drivers/iio/magnetometer/tle493d.c

>

> +
> +static bool tle493d_conversion_done(const u8 *buf, u8 last_frm)
> +{
> +	u8 diag = buf[TLE493D_REG_DIAG];
> +
> +	return (diag & TLE493D_DIAG_PD0) && (diag & TLE493D_DIAG_PD3) &&

Use FIELD_GET() to extract the 1 bit values as well.
Ends up easier to read than the mix of & and &&

> +	       FIELD_GET(TLE493D_DIAG_FRM, diag) != last_frm;
> +}
> +
> +static int tle493d_measure(struct tle493d_data *data, u8 *buf)
> +{
> +	u8 last_frm = FIELD_GET(TLE493D_DIAG_FRM, data->regs[TLE493D_REG_DIAG]);
> +	u8 diag;
> +	int ret, err;
> +
> +	/* Rewriting Config with the write trigger starts a single conversion */
> +	ret = tle493d_write(data, TLE493D_REG_CONFIG,
> +			    data->regs[TLE493D_REG_CONFIG], TLE493D_ADDR_TRIG_WRITE);
> +	if (ret)
> +		return ret;
> +
> +	ret = read_poll_timeout(tle493d_read, err,
> +				err || tle493d_conversion_done(buf, last_frm),
> +				TLE493D_POLL_US, TLE493D_TIMEOUT_US, true,
> +				data, buf, TLE493D_DATA_LEN);
> +	if (ret)
> +		return ret;
> +	if (err)
> +		return err;
> +
> +	diag = buf[TLE493D_REG_DIAG];
> +	data->regs[TLE493D_REG_DIAG] = diag;
> +
> +	if (!(diag & TLE493D_DIAG_FF) || (diag & TLE493D_DIAG_T) ||
> +	    !tle493d_data_parity_ok(buf))
> +		return -EIO;

Why do this after setting data->regs[TLE493_REG_DIAG]? 
If this function is returning an error I'd assume we
wouldn't use that value anyway


> +
> +	return 0;
> +}

> +
> +static int tle493d_read_raw(struct iio_dev *indio_dev,
> +			    const struct iio_chan_spec *chan, int *val,
> +			    int *val2, long mask)
> +{
> +	struct tle493d_data *data = iio_priv(indio_dev);
> +	u8 buf[TLE493D_DATA_LEN];
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		scoped_guard(mutex, &data->lock) {
I'd be tempted to just hold the lock a bit long and do the simpler
	case IIO_CHAN_INFO_RAW: {
		guard()...

	...
		return IIO_VAL_INT;
	}
> +			ret = tle493d_measure(data, buf);
> +			if (ret)
> +				return ret;
> +		}
> +		*val = tle493d_get_channel_data(buf, chan->address);
> +		return IIO_VAL_INT;

...

> +
> +static irqreturn_t tle493d_trigger_handler(int irq, void *p)
> +{
> +	struct iio_poll_func *pf = p;
> +	struct iio_dev *indio_dev = pf->indio_dev;
> +	struct tle493d_data *data = iio_priv(indio_dev);
> +	u8 buf[TLE493D_DATA_LEN];
> +	struct {
> +		s16 magn[3];
> +		u16 temp;
> +		aligned_s64 timestamp;
> +	} scan = { };
> +	int ret;
> +
> +	scoped_guard(mutex, &data->lock)

Generally avoid any use of cleanup.h magic in a function with
a goto. This one isn't a bug as such but it is considered bad
practice.  Just use mutex_lock/unlock()

> +		ret = tle493d_measure(data, buf);
> +	if (ret)
> +		goto out;
> +
> +	scan.magn[0] = tle493d_get_channel_data(buf, TLE493D_AXIS_X);
> +	scan.magn[1] = tle493d_get_channel_data(buf, TLE493D_AXIS_Y);
> +	scan.magn[2] = tle493d_get_channel_data(buf, TLE493D_AXIS_Z);
> +	scan.temp = tle493d_get_channel_data(buf, TLE493D_TEMPERATURE);
> +
> +	iio_push_to_buffers_with_ts(indio_dev, &scan, sizeof(scan), pf->timestamp);
> +
> +out:
> +	iio_trigger_notify_done(indio_dev->trig);
> +
> +	return IRQ_HANDLED;
> +}

> +static const unsigned long tle493d_scan_masks[] = { GENMASK(3, 0), 0 };
> +
> +static const struct iio_info tle493d_info = {
> +	.read_raw = tle493d_read_raw,
> +};
> +
> +/*
> + * The reset sequence is four separate frames whose first bytes are 0xff,
> + * 0xff, 0x00 and 0x00, i.e. zero-length reads from address 0x7f followed by
> + * zero-length writes to address 0x00. Not every adapter can send zero-length
> + * messages, so the reset is best effort.

Can we detect if the controller supports it?  Feels like it should have
an I2C_FUNC_xxx to enable discovery of this.

Is it same as SMBUS Quick command?  If so use that.


> + */
> +static void tle493d_reset(struct tle493d_data *data)
> +{
> +	struct device *dev = &data->client->dev;
> +	struct i2c_msg msgs[] = {
> +		{ .addr = 0x7f, .flags = I2C_M_RD },
> +		{ .addr = 0x7f, .flags = I2C_M_RD },
> +		{ .addr = 0x00 },
> +		{ .addr = 0x00 },
> +	};
> +	unsigned int i;
> +	int ret;
> +
> +	for (i = 0; i < ARRAY_SIZE(msgs); i++) {

	for (unsigned int i = 0; ...

> +		/* The reset frames are not acknowledged, so ignore NACKs */
> +		ret = i2c_transfer(data->client->adapter, &msgs[i], 1);
> +		if (ret == -EOPNOTSUPP) {
> +			dev_dbg(dev, "adapter cannot send the reset sequence\n");
> +			return;
> +		}
> +	}
> +
> +	fsleep(TLE493D_RESET_DELAY_US);
> +}
> +
> +static int tle493d_init(struct tle493d_data *data, unsigned int iicadr)
> +{
> +	struct device *dev = &data->client->dev;
> +	unsigned int hwv, id;
> +	u8 mod1;
> +	int ret;
> +
> +	/*
> +	 * After reset the sensor uses a 2-byte read protocol which plain I2C
> +	 * reads cannot handle, so MOD1 has to be written before any read. MOD2
> +	 * is not known yet and FP is computed with its reset value, PRD = 0.
> +	 * Clock stretching and the interrupt are disabled because /INT shares
> +	 * the SCL pin.
> +	 */
> +	mod1 = FIELD_PREP(TLE493D_MOD1_IICADR, iicadr) | TLE493D_MOD1_PR |
> +	       TLE493D_MOD1_CA | TLE493D_MOD1_INT |
> +	       FIELD_PREP(TLE493D_MOD1_MODE, TLE493D_MOD1_MODE_MASTER);
> +	ret = tle493d_write(data, TLE493D_REG_MOD1, mod1, 0);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to write MOD1\n");
> +
> +	ret = tle493d_read(data, data->regs, TLE493D_NUM_REGS);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to read registers\n");
> +
> +	hwv = FIELD_GET(TLE493D_VER_HWV, data->regs[TLE493D_REG_VER]);
> +	if (hwv != TLE493D_VER_HWV_B21)
> +		dev_info(dev, "unknown hardware version %u\n", hwv);
> +
> +	id = FIELD_GET(TLE493D_TEMP2_ID, data->regs[TLE493D_REG_TEMP2]);
> +	if (id != iicadr)
> +		dev_info(dev, "unexpected ID %u, expected %u\n", id, iicadr);
> +
> +	/*
> +	 * Full range, temperature and Bz enabled, no trigger via Config. This
> +	 * also sets a valid CP, which is not the case after reset.
> +	 */
> +	ret = tle493d_write(data, TLE493D_REG_CONFIG, 0, 0);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to write Config\n");
> +
> +	return 0;
> +}
> +
> +static int tle493d_probe(struct i2c_client *client)
> +{
> +	struct device *dev = &client->dev;
> +	struct tle493d_data *data;
> +	struct iio_dev *indio_dev;
> +	unsigned int iicadr;
> +	int ret;
> +
> +	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
> +		return dev_err_probe(dev, -EOPNOTSUPP, "plain I2C transfers not supported\n");
> +
> +	for (iicadr = 0; iicadr < ARRAY_SIZE(tle493d_i2c_addrs); iicadr++) {
> +		if (client->addr == tle493d_i2c_addrs[iicadr])

This match is unusual.  I don't think we should be failing
probe on seeing a device on a different i2c address given we
are happy to accept a mismatch from internal device ID as long
as it is one of this list.  However it seems the index is
written to the device.   Can you add a few comments on what
this iicadr is for.

> +			break;
> +	}
> +	if (iicadr == ARRAY_SIZE(tle493d_i2c_addrs))
> +		return dev_err_probe(dev, -EINVAL, "unsupported I2C address 0x%02x\n",
> +				     client->addr);
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	data = iio_priv(indio_dev);
> +	data->client = client;
> +
> +	ret = devm_mutex_init(dev, &data->lock);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_regulator_get_enable(dev, "vdd");
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to enable vdd regulator\n");
> +
> +	tle493d_reset(data);
> +
> +	ret = tle493d_init(data, iicadr);
> +	if (ret)
> +		return ret;
> +
> +	indio_dev->name = "tle493d";
> +	indio_dev->info = &tle493d_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->channels = tle493d_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(tle493d_channels);
> +	indio_dev->available_scan_masks = tle493d_scan_masks;
> +
> +	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
> +					      iio_pollfunc_store_time,
> +					      tle493d_trigger_handler, NULL);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to set up triggered buffer\n");
> +
> +	return devm_iio_device_register(dev, indio_dev);
> +}

> 

