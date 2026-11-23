Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.19
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795423529;
	b=wcaIoct5kROrSZ/A0WkU2c+ttHwrAkPC+P0Fkbc/PEdHm9IXUKxvgBs8GqOlhXhMIYPf
	 IYhcPEtuahHpbwkjh1faadu49DzTePPgRd/kAQdts5AllsvwmwBY/a29554sTbI9BAiNN
	 1dLAvebBjo4hl0WVw+km9GTOED9MQx+52nNGbSgbP+9mnIrvDphJ4WgiFnOb2AyH3cHm8
	 V6i79kXogmt18jtzliFdXlMVhHn5fC2N4vyvqcD7rGaFmJZrxinWgi4FfERsLfWwl/hXp
	 UjoVNjsxN8Y2tpSNg6QsloaP4/2pzQa41PBb5vofnY14wTCn3S2aUUa/j+rGEwr1RYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795423529;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=qOtJQ0jRpca6y6cN/hy0lojFWyGBRZEMnIAfoQP+Kxw=;
	b=4OtI765iri1zpMe2mipESdKtChnaRbnOBbdPt/JJyu9DtirzXRQ1SvsUFk4rv/q1MAtJ
	 4LP4LWIt3gJs+cjX3tMrCQvyU6ZN/2qqIfiVjJAfXhabKfIuGit5J2iCp+YYQkfSUcXm6
	 +ihhhirNhYpgDdX82bmRHXbxSPcTaOk6yKLUPZOkJYDf+LcCJYnoNzgh8rg7MVOKzGO73
	 zt/Q+vazsiH5BPPeSVVQhIqjLhJaceh36ie7Y9nVQ/w6R+aHBrYxJbhDEkOVDzaCIq7re
	 5dOHM1UbPULuLQKDRb2v3ZdnCFhrWivZNJ3uqm0y8w82LJP81Iskt7xzOWZawF9LtFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mS+3r1PM;
	arc=none smtp.remote-ip=198.175.65.19
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7241B606A31A;
	Mon, 23 Nov 2026 08:45:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7241B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mS+3r1PM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795423529; x=1826959529;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9tlcGAdRbR5aIXRmxrykaUox99MZYpfMaWlPYOeRnrA=;
  b=mS+3r1PMuAQfbARNvu09RXYIFrbNK7vjM3s05RLvXUeUWUjZwKBzKZIx
   4z5gXJ+nF580AtjtkU3y7dqj3to5qZxYjx1c/cDpUCvGBh6+NgUqJcevR
   CKnC2D5EkVnrYfajfDVxWkb8P8a6zxKY3rS+H42TKV+GY0bf+qQ7TYUbH
   0Co2EKVbsmu6Prq9TMcO6ARkzdiMx+Y9JY5xZwcB85ZafWCXVfndI6FKi
   TO0Bdhq0iJOFZAvPzAr62Mh38HP64MTcGmSUi2EMxpHvTwEz9HJLR4ETJ
   uIUzRtBgFTARTKcLJzm+8xLjb9avwF35d1UpoaRJYbOFmMPoXQ3SYKKcb
   g==;
X-CSE-ConnectionGUID: 2KBJTgGyS/+oRvLCXdC1cQ==
X-CSE-MsgGUID: ydZgJ6gASo+hoxmqO1seOg==
X-IronPort-AV: E=McAfee;i="6800,10657,11974"; a="4267010"
X-IronPort-AV: E=Sophos;i="6.27,227,1787036400"; 
   d="scan'208";a="4267010"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2026 00:45:28 -0800
X-CSE-ConnectionGUID: 8JdDDmVRQsCP8zAGKEMI2Q==
X-CSE-MsgGUID: goGLaBp5RvCkvyXjjJ23fA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,227,1787036400"; 
   d="scan'208";a="11569162"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.204])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2026 00:45:25 -0800
Date: Mon, 23 Nov 2026 10:45:22 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Viral Patel <viral8854@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dixit Parmar <dixitparmar19@gmail.com>,
	Victor Chernyakin <chernyakin.victor.j@outlook.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: magnetometer: add Infineon TLE493D-W2B6
 driver
Message-ID: <awP9IkDVy4VM9Xum@ashevche-desk.local>
References: <20261121-tle493d-v2-0-92d7e57cec89@gmail.com>
 <20261121-tle493d-v2-2-92d7e57cec89@gmail.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261121-tle493d-v2-2-92d7e57cec89@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Nov 21, 2026 at 11:25:11AM +0530, Viral Patel wrote:
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
> so is clock stretching. The sensor's reset sequence is four SMBus Quick
> commands, so it is sent during probe only if the adapter supports
> I2C_FUNC_SMBUS_QUICK.
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
> Based on the TLE493D-W2B6 User Manual v1.11 and Datasheet v1.2. The
> user manual is provided by Infineon after a free registration:

> https://www.infineon.com/gated/infineon-tle493d-w2b6-usermanual-en_dc6d4e62-cde1-4d4b-87bb-c3368e25e35c

Make this a formal Link tag in a form of: Link: $URL [1], and use [1] in
the text above.

> Datasheet: https://www.infineon.com/assets/row/public/documents/30/49/infineon-tle493d-w2b6-datasheet-en.pdf
> Signed-off-by: Viral Patel <viral8854@gmail.com>

> + * Driver for the Infineon TLE493D-W2B6 3D Magnetic Sensor

...

> +#include <linux/array_size.h>
> +#include <linux/bitfield.h>
> +#include <linux/bitops.h>

> +#include <linux/bits.h>

It's guaranteed by bitops.h.

> +#include <linux/cleanup.h>
> +#include <linux/delay.h>
> +#include <linux/dev_printk.h>
> +#include <linux/errno.h>
> +#include <linux/i2c.h>
> +#include <linux/iopoll.h>
> +#include <linux/irqreturn.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/types.h>

...

> +/* A full range conversion takes about 175 us */

Then why not starting with it?
Either elaborate in the comment why smaller is chosen, or use the mentioned one.

> +#define TLE493D_POLL_US		100
> +#define TLE493D_TIMEOUT_US	1000

(1 * USEC_PER_MSEC)

This will require to include time.h.

...

> +/* FP makes MOD1 together with MOD2.PRD odd parity */
> +static u8 tle493d_mod1_fp(u8 mod1, u8 mod2)
> +{
> +	unsigned int ones;
> +
> +	mod1 &= ~TLE493D_MOD1_FP;
> +	ones = hweight8(mod1) + hweight8(mod2 & TLE493D_MOD2_PRD);
> +	if (!(ones & 1))

When I see ' & 1' I want to immediately have it as ' & BIT(0)' but it seems
wrong semantically here, so, why not use ' % 2' instead? The compiler will make
it optimal in the generated code if not the same.

> +		mod1 |= TLE493D_MOD1_FP;
> +
> +	return mod1;
> +}

...

> +/* CP makes registers 0x07 to 0x10 odd parity, ignoring WA, TST and PH */
> +static u8 tle493d_config_cp(const u8 *regs, u8 config)
> +{
> +	unsigned int ones = 0;
> +	unsigned int i;
> +
> +	for (i = TLE493D_REG_XL; i < TLE493D_REG_WU; i++)

	for (unsigned int i = TLE493D_REG_XL; i < TLE493D_REG_WU; i++)

> +		ones += hweight8(regs[i]);
> +	ones += hweight8(regs[TLE493D_REG_WU] & ~TLE493D_WU_WA);
> +	ones += hweight8(regs[TLE493D_REG_TMODE] & ~TLE493D_TMODE_TST);
> +	ones += hweight8(regs[TLE493D_REG_TPHASE] & ~TLE493D_TPHASE_PH);
> +
> +	config &= ~TLE493D_CONFIG_CP;
> +	ones += hweight8(config);
> +	if (!(ones & 1))

As per above.

> +		config |= TLE493D_CONFIG_CP;
> +
> +	return config;
> +}

Similar comments apply elsewhere in the code.

...

> +static bool tle493d_conversion_done(const u8 *buf, u8 last_frm)
> +{
> +	u8 diag = buf[TLE493D_REG_DIAG];
> +
> +	return FIELD_GET(TLE493D_DIAG_PD0, diag) &&
> +	       FIELD_GET(TLE493D_DIAG_PD3, diag) &&

> +	       FIELD_GET(TLE493D_DIAG_FRM, diag) != last_frm;

vvv (see below)

> +}
> +
> +static int tle493d_measure(struct tle493d_data *data, u8 *buf)
> +{
> +	u8 last_frm = FIELD_GET(TLE493D_DIAG_FRM, data->regs[TLE493D_REG_DIAG]);

This is the same as per above, perhaps split a helper for this field?

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

This 'true' is better to be explained at the top of the read_*() call.
Something like

	/* We need to delay before checking the conversion state */

> +				data, buf, TLE493D_DATA_LEN);
> +	if (ret)
> +		return ret;
> +	if (err)
> +		return err;
> +
> +	/*
> +	 * Cache Diag before checking for errors: its frame counter is what the
> +	 * next measurement compares against, so a rejected frame must not be
> +	 * seen as new again.
> +	 */
> +	diag = buf[TLE493D_REG_DIAG];
> +	data->regs[TLE493D_REG_DIAG] = diag;
> +
> +	if (!FIELD_GET(TLE493D_DIAG_FF, diag) || FIELD_GET(TLE493D_DIAG_T, diag) ||
> +	    !tle493d_data_parity_ok(buf))
> +		return -EIO;
> +
> +	return 0;
> +}

...

> +static int tle493d_get_channel_data(const u8 *buf, unsigned int ch)
> +{
> +	u32 val;
> +
> +	switch (ch) {
> +	case TLE493D_AXIS_X:
> +		val = buf[TLE493D_REG_BX] << 4 |
> +		      FIELD_GET(TLE493D_BX2_X_LSB, buf[TLE493D_REG_BX2]);
> +		return sign_extend32(val, 11);
> +	case TLE493D_AXIS_Y:
> +		val = buf[TLE493D_REG_BY] << 4 |
> +		      FIELD_GET(TLE493D_BX2_Y_LSB, buf[TLE493D_REG_BX2]);
> +		return sign_extend32(val, 11);
> +	case TLE493D_AXIS_Z:
> +		val = buf[TLE493D_REG_BZ] << 4 |
> +		      FIELD_GET(TLE493D_TEMP2_Z_LSB, buf[TLE493D_REG_TEMP2]);
> +		return sign_extend32(val, 11);
> +	case TLE493D_TEMPERATURE:
> +		/* 12-bit value whose two LSBs are always zero */

Hmm... Never ever can be negative?

> +		return buf[TLE493D_REG_TEMP] << 4 |
> +		       FIELD_GET(TLE493D_TEMP2_TEMP_LSB, buf[TLE493D_REG_TEMP2]) << 2;
> +	default:
> +		return 0;
> +	}
> +}

...

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

> +	mutex_lock(&data->lock);
> +	ret = tle493d_measure(data, buf);
> +	mutex_unlock(&data->lock);
> +	if (ret)
> +		goto out;

Hmm... It will be mix with cleanup.h (by style), the easiest way is to split
the inner function. Some driver(s) use scoped_guard() with 'break' statement,
but that requires a comment.

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

IIRC. Jonathan prefers to see BIT() by BIT() ORed instead of semantic-less
GENMASK().

...

> +	ret = tle493d_init(data, iicadr);
> +	if (ret)
> +		return ret;

Does _init() do anything that we want to undone on failure or at driver's
remove stage? If so, we need a wrapped rollback function.

-- 
With Best Regards,
Andy Shevchenko


