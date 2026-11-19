Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795058228;
	b=dKJZrliyPzXP0cDBPZrkTyHndXdtTDBsrEzeGZU5ATJPGr+kzjx8kaBpEjBVUpR0iKU4
	 UfXk7hdUcAAdTEjUBemt7Jzbl74hfaZn9/1QowKS1VN9XBOUDSWedqWqm2TM3cJlqdeqr
	 ixS2ycqlKCZYohDKU6kiJXvLwKaJJF7N2EUefe7UGNnlKtzc2ksuHx0xY/Y789L/8npdD
	 3kWZU27v5I6sXaFX0i7ThCXodUqToE+1o9jTNuRRMeO86FoqxGWCdVs76tu/soQ5y6O3f
	 HS2G5fi8cfobx1wIWMX9WIpiJwpiDq4K7zVX/jlPxTgavlU4+UkU65OXxfBF4mU3x/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795058228;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=r2uY6+NIgq+iesXLv4eqMI/o1G/fBRZ5sTurYgJmAv8=;
	b=CbLYGA+9OhXoO4UI1kpqnnY700PCh7o9CZFb9e0OtabKjLshkknt7+1HFFQ9IGkz3h0Q
	 iRx9UYB4w1ya+MVdWtCdiJoHXbWNcJSSIk1YdbTI7v2eHoPZaPU+fBNCrTb/TSwn7wi0W
	 /2f09zrU7yTxrhvIhGkhsdwxhxpX3FQGhbONLGADc+Zr3moAgT9xhS9mExM1invBpVZrI
	 HhQxS2+rjPaZTv7KwzCFeRnVUW9aJwo7btU0Xvk1GexualBaB/wjq1ZDx8ux+7SZD1CbI
	 eD+ll4BByTGMZMVQMGTdn5U8rNvh3biw3yDeSQRS9VzLShnlug3SRYy/SppiXksTL8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BegmDEyk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902F9606A325;
	Thu, 19 Nov 2026 03:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BegmDEyk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 065621F000C4;
	Thu, 19 Nov 2026 03:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795058228;
	bh=r2uY6+NIgq+iesXLv4eqMI/o1G/fBRZ5sTurYgJmAv8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=BegmDEykbxYqYqOZ6nEdV7JABs5osPkCSmuoS16IKoYq9EMUtq7+KTUQz5Y3dqYuF
	 enP1Z+trbRyA9S1iJa02MSw8G5CHX8cWbJRnp7YIssNaY79y4FsU9zGs7u/rKLLVOv
	 BOg5BcL5x1ywCqyN85ns80JQKcRIRDBsWB7czYXl1zuFnyjOLEXPWHprGo/5Xm5yTg
	 rol6XlTGNg8t9opcE90y0FqK+QAMMNop1MxRV5M88+vBrem3UV3z2Uii1rBt44X0iA
	 5m5Tmi5vhdz3I4Ib+geUP690Hn3icgUdSH4ely4piqvS041899SjY2cQicCbAaKWX0
	 pgkTOEO8nYYjw==
Date: Thu, 19 Nov 2026 03:16:59 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux@analog.com>,
 <Michael.Hennerich@analog.com>, <nuno.sa@analog.com>,
 <eblanc@baylibre.com>, <dlechner@baylibre.com>, <andy@kernel.org>,
 <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
 <olivier.moysan@foss.st.com>, <marcelo.schmitt1@gmail.com>
Subject: Re: [PATCH v1 5/5] iio: adc: Add support for ADA4355 and similar
 ADCs
Message-ID: <20261119031659.6a84e737@jic23-hlaptop>
In-Reply-To: <2f5e83aa17aea08bbff69ca6ef7d32b11368f518.1795003864.git.marcelo.schmitt@analog.com>
References: <cover.1795003864.git.marcelo.schmitt@analog.com>
	<2f5e83aa17aea08bbff69ca6ef7d32b11368f518.1795003864.git.marcelo.schmitt@analog.com>
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

On Wed, 18 Nov 2026 10:04:33 -0300
Marcelo Schmitt <marcelo.schmitt@analog.com> wrote:

> The ADA4355 and AD4356 are 14-bit, 125 MSPS, analog-to-digital converters
> with integrated analog front-end. These chips are configured over SPI while
> conversion data is streamed over a serial LVDS interface handled by an IIO
> backend.
> 
> Add an IIO device driver for ADA4355 and similar designs, providing device
> configuration, debugfs register access and buffered captures through the
> IIO backend framework.
> 
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
I'm feeling lazy, and it's a v1 so I haven't actually looked
at what sashiko found to see if it is right. But it found stuff..
https://sashiko.dev/#/patchset/cover.1795003864.git.marcelo.schmitt%40analog.com

A few things I noticed inline.

> diff --git a/drivers/iio/adc/ada4355.c b/drivers/iio/adc/ada4355.c
> new file mode 100644
> index 000000000000..7f9f58a14385
> --- /dev/null
> +++ b/drivers/iio/adc/ada4355.c
> @@ -0,0 +1,798 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Analog Devices ADA4355 device driver
> + *
> + * Copyright (C) 2026 Analog Devices, Inc.
> + * Author: Marcelo Schmitt <marcelo.schmitt@analog.com>
> + *
> + * Expanded and improved version made on top of preliminary code from:
> + *	Antoniu Miclaus <antoniu.miclaus@analog.com>
> + *	Pop Ioan Daniel <pop.ioan-daniel@analog.com>
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/bitmap.h>
> +#include <linux/bitops.h>
> +#include <linux/cleanup.h>
> +#include <linux/clk.h>
> +#include <linux/debugfs.h>
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/kernel.h>

No to including this in new code. Need to use more specific
includes and not that catch all unless this really does use
one of the things still defined in there.

> +#include <linux/minmax.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/property.h>
> +#include <linux/regmap.h>
> +#include <linux/seq_file.h>
> +#include <linux/slab.h>
> +#include <linux/spi/spi.h>
> +#include <linux/units.h>
> +
> +#include <linux/iio/backend.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>

Is that used? I maybe missed something.





> +/*
> + * Sweep the I/O delay of one delay line while only the error source fed by
> + * that line is reported, and apply the delay in the middle of the widest run
> + * of valid test points. @offset is where this line's test points start in
> + * @st->calib_map.
> + */
> +static int ada4355_calibrate_lane(struct ada4355_state *st,
> +				  enum iio_backend_calib_source source,
> +				  unsigned int lane, unsigned int offset)
> +{
> +	struct device *dev = &st->spi->dev;
> +	unsigned int point, val, cnt;
> +	bool stat;
> +	int ret;
> +
> +	ret = iio_backend_calibration_source_set(st->back, source, lane);
> +	if (ret)
> +		return ret;
> +
> +	for (point = 0; point < ADA4355_MAX_TEST_POINTS; point++) {

	for (unsigned int point = 0; 

> +		ret = iio_backend_iodelay_set(st->back, lane, point);
> +		if (ret)
> +			return ret;
> +
> +		ret = iio_backend_chan_status(st->back, 0, &stat);
> +		if (ret)
> +			return ret;
> +
> +		if (stat) {
> +			dev_dbg(dev, "Invalid point(%u) for lane %u\n", point,
> +				lane);
> +			continue;
> +		}
> +
> +		__clear_bit(offset + point, st->calib_map);
> +	}
> +
> +	cnt = ada4355_find_optimal_point(st->calib_map, offset, ADA4355_MAX_TEST_POINTS,
> +					 &val);
> +	if (!cnt) {
> +		dev_err(dev, "No valid delay found for lane %u\n", lane);
> +		return -EIO;
> +	}
> +
> +	/* "normalize" the selected value */
> +	val -= offset;
> +	dev_dbg(dev, "lane %u: selected delay: %u\n", lane, val);
> +
> +	return iio_backend_iodelay_set(st->back, lane, val);
> +}
> +
> +static int ada4355_calibrate(struct ada4355_state *st)
> +{
> +	unsigned int lane;
> +	int ret;
> +
> +	/* all points invalid */
> +	bitmap_fill(st->calib_map, st->calib_map_size);
> +
> +	ret = ada4355_calibrate_prepare(st);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * The frame signal has to be aligned first: the pattern match block
> +	 * only reports meaningful per-lane errors once the word boundary is
> +	 * known.
> +	 */
> +	ret = ada4355_calibrate_lane(st, IIO_BACKEND_CALIB_SOURCE_FRAME,
> +				     ADA4355_FRAME_LANE,
> +				     ADA4355_MAX_DATA_LANES * ADA4355_MAX_TEST_POINTS);
> +	if (ret)
> +		return ret;
> +
> +	for (lane = 0; lane < ADA4355_MAX_DATA_LANES; lane++) {
	for (unsigned int lane = 0; lane < ADA4355_MAX_DATA_LANES; lane++) {

Going to take a while for us to all train ourselves to prefer this style
but it is both acceptable and once or twice Linus has said he prefers
keeping the scope tightly defined like this.

> +		ret = ada4355_calibrate_lane(st,
> +					     IIO_BACKEND_CALIB_SOURCE_DATA_LANE,
> +					     lane,
> +					     lane * ADA4355_MAX_TEST_POINTS);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return ada4355_calibrate_stop(st);
> +}


> +
> +static int ada4355_write_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan,
> +			     int val, int val2, long mask)
> +{
> +	struct ada4355_state *st = iio_priv(indio_dev);
> +	long r_clk;
> +
> +	IIO_DEV_ACQUIRE_DIRECT_MODE(indio_dev, claim);
> +	if (IIO_DEV_ACQUIRE_FAILED(claim))
> +		return -EBUSY;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		r_clk = clk_round_rate(st->clk, val);
> +		if (!in_range(r_clk, 1, ADA4355_MAX_SAMP_RATE_SPS))
This is a little odd as in_range takes start + length.
That happens to work here because the start is 1.   I'd
just check <1 || > MAX_SAMP_RATE_SPS.

> +			return -ERANGE;
> +
> +		return ada4355_update_clock(st, r_clk);
> +	case IIO_CHAN_INFO_SCALE:
> +		return ada4355_set_scale(st, val, val2);
> +	default:
> +		return -EINVAL;
> +	}
> +}

> +
> +static int ada4355_setup(struct ada4355_state *st,
> +			 struct ada4355_chip_info const *chip_info)
> +{
> +	struct device *dev = &st->spi->dev;
> +	struct gpio_desc *gpio_vld_en;
> +	struct gpio_desc *gpio_lfp;
> +	unsigned int id;
> +	int ret;
> +
> +	gpio_vld_en = devm_gpiod_get(dev, "adi,vld-en", GPIOD_OUT_LOW);
> +	if (IS_ERR(gpio_vld_en))
> +		return dev_err_probe(dev, PTR_ERR(gpio_vld_en),
> +				     "Failed to find adi,vld-en-gpios\n");
> +
> +	if (gpio_vld_en) {
> +		gpiod_set_value_cansleep(gpio_vld_en, 1);
> +		fsleep(1000);
> +	}
> +
> +	gpio_lfp = devm_gpiod_get(dev, "adi,lfp", GPIOD_OUT_LOW);
> +	if (IS_ERR(gpio_lfp))
> +		return dev_err_probe(dev, PTR_ERR(gpio_lfp),
> +				     "Failed to find adi,lfp-gpios\n");
> +
> +	ret = ada4355_digital_reset(st);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(st->regmap, ADA4355_CHIP_CONFIG_REG, 0x00);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(st->regmap, ADA4355_DEVICE_INDEX_REG, 0x02);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(st->regmap, ADA4355_SERIAL_CHANNEL_STATUS_REG, 0x03);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(st->regmap, ADA4355_DEVICE_INDEX_REG, 0x31);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_read(st->regmap, ADA4355_CHIP_ID_REG, &id);
> +	if (ret)
> +		return ret;
> +
> +	if (id != chip_info->id)
> +		dev_warn(dev, "Mismatch CHIP_ID, got 0x%X, expected 0x%X\n",
> +			 id, chip_info->id);

Given we want fallback compatibles to work if appropriate, I'd relax
that to dev_info.  And say something about unknown id. Mismatch sounds scary.


> +
> +	ret = regmap_update_bits(st->regmap, ADA4355_SERIAL_OUT_DATA_CNTRL_REG,
> +				 ADA4355_SERIAL_OUT_LANE_MODE_MASK,
> +				 FIELD_PREP(ADA4355_SERIAL_OUT_LANE_MODE_MASK,
> +					    ADA4355_DDR_TWO_LANE_BITWISE));
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_set_bits(st->regmap, ADA4355_TRANSFER_REG,
> +			      ADA4355_TRANSFER_OVERRIDE);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(st->regmap, ADA4355_OUTPUT_MODE_REG,
> +			   ADA4355_OUTPUT_MODE_TWOSCOMP);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(st->regmap, ADA4355_RESOLUTION_SAMPLE_RATE_REG,
> +			   ADA4355_125_RATE);
> +	if (ret)
> +		return ret;
> +
> +	return 0;

	return regmap_write();

> +}

> +
> +static int ada4355_probe(struct spi_device *spi)
> +{
> +	const struct ada4355_chip_info *chip_info;
> +	struct device *dev = &spi->dev;
> +	struct iio_dev *indio_dev;
> +	struct ada4355_state *st;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	st = iio_priv(indio_dev);
> +	st->spi = spi;
> +
> +	chip_info = spi_get_device_match_data(spi);
> +	if (!chip_info)
> +		return -ENODATA;
> +
> +	st->regmap = devm_regmap_init_spi(spi, &ada4355_regmap_config);
> +	if (IS_ERR(st->regmap))
> +		return PTR_ERR(st->regmap);
> +
> +	ret = devm_mutex_init(dev, &st->lock);
> +	if (ret)
> +		return ret;
> +
> +	st->calib_map_size = ADA4355_MAX_CALIB_MAP_SIZE;
> +
> +	st->clk = devm_clk_get_enabled(dev, NULL);
> +	if (IS_ERR(st->clk))
> +		return PTR_ERR(st->clk);
> +
> +	indio_dev->name = chip_info->name;
> +	indio_dev->channels = &ada4355_channel;
> +	indio_dev->num_channels = 1;
> +	indio_dev->info = &ada4355_iio_info;
> +	st->chan = &ada4355_channel;

Why in two places?  If you just want it in the scale
table calc, pass it in directly. Don't think it is used after that.


> +	ret = ada4355_interface_setup(st);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "failed to setup the digital interface\n");

Go a bit longer.  As long as it's not too far past 80 I don't mind. Particularly
when the end bit is the tail end of an error message.

> +
> +	if (iio_backend_has_caps(st->back, IIO_BACKEND_CAP_CALIBRATION)) {
> +		ret = ada4355_calibrate(st);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return devm_iio_device_register(dev, indio_dev);
> +}

