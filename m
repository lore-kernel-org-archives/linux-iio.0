Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B7502DB79F;
	Mon,  7 Sep 2026 01:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788746109; cv=none; b=mmyq8TKbsOWhHtj96O3Mo/RCH6iXzuPQzpMe7j14Y9nytFwTQC8HP8sZujOGuhIhS0HJrc5DZuuiPksTMW4lPqSAKWjKbhi5foxtrYOI0JsGIap7ZbYuA/4R0WMSmZfKsn/nJCBFVBRT+NEYHh2pKBiiZ9X4CkOLPNb9Zga0FIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788746109; c=relaxed/simple;
	bh=thdrsufHSCcJldHvVfxMknQ/GLV5PqQLKAz9ZVlhjjo=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=JCaExUjiW8UOJI2xIJ0z+yFQwCFoMX6ZbATzpD9raunnGJ10ZG5dtHgdsxVHlXXNMx3/W7KeC1NLn5DY5ISg1RCeLjYqRs6FQ4wtPjuC3Z5nJPzFOMtsM2viKFQMEWYbRK/Jk7TLqQPma4erg3NoY4F6rshepyZ8SIbI++Y0mS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aBiRrOoW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aBiRrOoW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98D1A1F00ACA;
	Mon,  7 Sep 2026 01:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788746107;
	bh=21UeIR6OWfC7cLZwBFpTAWtU4Qpth4nhn2R2Szu4zJw=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=aBiRrOoWBBqarTMs+GcvzTeDt2vS6ydkp7O5ILr2AD4T2Mrm6RiKkMqc15quYDuWP
	 CR73Sm13Ob+g47pS+u/XszgS+Y5e8r9X+4puS43oBcyjUEbZK4wzJE/rfvA65tinzk
	 pa08gcmLGcwSLphwrV6e1X1UBoNIgqf3WdEpgbKY39bDVVfEJaVsvgxEVyXKAGy1XX
	 B3yRJ90ndHl5JHYaW6NJ5PU9NTM9zC1ak/VmZR5kE88ULxAdrFH7MhKdmXF0bRl/VG
	 xqjtRcK5+75+S4DBWlK7v8HEpDUJN/QoiXcHtOPXc5DcO0kGvCuWdhXl0ncGnhzOPv
	 lDyUr8Vpibezg==
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 7/8] iio: imu: inv_icm42607: Add accelerometer
 calibbias support
From: Jonathan Cameron <jic23@kernel.org>
To: Kanak Shilledar <kanak.shilledar@axis.com>
Cc: Henrik Grimler <henrik.grimler@axis.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, 
 Joshua Crofts <joshua.crofts1@gmail.com>, 
 Marcelo Schmitt <marcelo.schmitt1@gmail.com>, 
 Chris Morgan <macromorgan@hotmail.com>, kernel@axis.com, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260901-b4-inv_icm42370p-v3-7-77cc31642115@axis.com>
References: <20260901-b4-inv_icm42370p-v3-0-77cc31642115@axis.com>
 <20260901-b4-inv_icm42370p-v3-7-77cc31642115@axis.com>
Date: Mon, 07 Sep 2026 02:54:51 +0100
Message-Id: <178874609182.3402141.6437933635539106261.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6087;
 i=jonathan.cameron@oss.qualcomm.com; h=from:subject:message-id;
 bh=thdrsufHSCcJldHvVfxMknQ/GLV5PqQLKAz9ZVlhjjo=;
 b=owEBfwKA/ZANAwAKAVSFNJnE9BaIAcsmYgBqnhlv6ZEtTnhXJYFub4SR8NeIOSBXt/IJU5WT8
 R5IJ6sQrQ+JAkUEAAEKAC8WIQRuKWazh4QGUpEmgbFUhTSZxPQWiAUCap4ZbxEcamljMjNAa2Vy
 bmVsLm9yZwAKCRBUhTSZxPQWiKiyEACf4wo1z+X+7ZaXofZsBrvdrZwHcAfL1UeRTqBc/7kZnEC
 JwAd105SKWOV9BNdJZbQQPw+cc4A0xFXWYZlfOLinsr6FxOq+PcYPlrKJuEviDgouFeY7HL7NHL
 CR73mCpUdAK6e4gTrJQJdYLY0oQ0s/mqZj2bnq1m5UO5v5DAAhq3F5ZWdmwgYOd0uF5WdfE5fzI
 CA23s7dLbTOhm61igGt3WT+Cp+ijlpEAyqqMHs+UF81lF7MKalpdwv6JVH+aN3ctd2RRieziWYU
 l7oHUCWCvdk2E74nbmHUJLKwaaDBCB56nv5UzHC2+Q8V7nXsO1TVxH/EBg74y85sm3gylEMwX2N
 7h1SIbgZKRv6UpphLm6PS1AO/D/4twn5852c+beQZPCeF6KljN/oZPF+aLgpMrmSzL2JsEIJxQW
 NtSFG+4aL3QNQ/vE6LGvjczv76QB4y0AEu2RXVS7T7JANOvVjYXMcM6NWfDX6WLy4/Hs/b7FbOL
 rRLzF03bzTe9hiNSzFjsqCmg9HsxQJ2OCocVSDhwpcoQOtjFJWQFQ9rlAHC+bOUHBKI5ojLIJQY
 FK9pGXB++d4Q1yPmNxl99isGXiIttFo2twSCXHI9tCfWVhYJ4GDj1ZkPXIR5W9ZIUsdpy6aruN8
 mLpil0RH53jcPh+Lesh2Rdzt0khcoCnCiuT9r1g==
X-Developer-Key: i=jonathan.cameron@oss.qualcomm.com; a=openpgp;
 fpr=6E2966B387840652912681B154853499C4F41688

> Expose IIO_CHAN_INFO_CALIBBIAS on the accelerometer channels. The
> registers are stored in MREG1, which can be accessed by the mreg_read
> and mreg_write routines. The calibration bias is written to OFFSET_USER4
> to OFFSET_USER8 registers in MREG1.
> 
> Note: The accelerometer functionality is tested with Invensense,
> ICM42370-P development board.
> 
> Datasheet: https://www.invensense.tdk.com/en-us/products/3-axis/icm-42370-p
> Datasheet: https://www.lcsc.com/product-detail/C5129967.html
> Signed-off-by: Kanak Shilledar <kanak.shilledar@axis.com>

Various things inline.

Thanks

Jonathan

>
> diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_accel.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_accel.c
> index 318373efeb9e..af2ac9d6a47c 100644
> --- a/drivers/iio/imu/inv_icm42607/inv_icm42607_accel.c
> +++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_accel.c
> @@ -13,6 +13,7 @@
>  #include <linux/pm_runtime.h>
>  #include <linux/regmap.h>
>  #include <linux/types.h>
> +#include <linux/units.h>
>  
>  #include "inv_icm42607.h"
>  #include "inv_icm42607_temp.h"
> @@ -22,9 +23,11 @@
>  	.type = IIO_ACCEL,							\
>  	.modified = 1,								\
>  	.channel2 = _modifier,							\
> -	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),				\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |				\
> +		BIT(IIO_CHAN_INFO_CALIBBIAS),					\
>  	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),			\
> -	.info_mask_shared_by_type_available = BIT(IIO_CHAN_INFO_SCALE),		\
> +	.info_mask_shared_by_type_available = BIT(IIO_CHAN_INFO_SCALE) |	\
> +		BIT(IIO_CHAN_INFO_CALIBBIAS),					\

Sashiko:
[Severity: Medium]
Will reading the in_accel_calibbias_available sysfs attribute fail with
-EINVAL?

Since IIO_CHAN_INFO_CALIBBIAS was added to the _available mask here, does
inv_icm42607_accel_read_avail() also need a new case to handle it?

Right now, it appears to fall through to the default error case:

inv_icm42607_accel_read_avail() {
	switch (mask) {
	case IIO_CHAN_INFO_SCALE:
		...
	case IIO_CHAN_INFO_SAMP_FREQ:
		...
	default:
		return -EINVAL;
	}
}
-
JC, Looks valid to me.

> +
> +static int inv_icm42607_accel_write_offset(struct iio_dev *indio_dev,
> +					   struct iio_chan_spec const *chan,
> +					   int val, int val2)
> +{
> +	struct inv_icm42607_state *st = iio_device_get_drvdata(indio_dev);
> +	struct device *dev = regmap_get_device(st->map);
> +	u8 hi, lo, regval;
> +	s32 min, max;
> +	s16 offset;
> +	s64 val64;
> +	int ret;
> +
> +	if (chan->type != IIO_ACCEL)
> +		return -EINVAL;
> +
> +	/* inv_icm42607_accel_calibbias: min - step - max in micro */
> +	min = inv_icm42607_accel_calibbias[0] * (long)MEGA -
> +	      inv_icm42607_accel_calibbias[1];
> +	max = inv_icm42607_accel_calibbias[4] * (long)MEGA +
> +	      inv_icm42607_accel_calibbias[5];
> +
> +	val64 = (s64)val * (s64)MEGA;
> +	if (val >= 0)
> +		val64 += (s64)val2;
> +	else
> +		val64 -= (s64)val2;
> +
> +	if (val64 < min || val64 > max)
> +		return -EINVAL;
> +
> +	/*
> +	 * Convert m/s² to g then to raw value
> +	 * m/s² to g: 1 / 9.806650
> +	 * g to raw 12 bits signed, step 0.5mg: 10000 / 5
> +	 * val in micro (1000000)
> +	 * val * 10000 / (9.806650 * 1000000 * 5)
> +	 */
> +	val64 = val64 * 10000LL;
> +
> +	/* For rounding, add + or - divisor (9806650 * 5) divided by 2 */
> +	if (val64 >= 0)
> +		val64 += 9806650 * 5 / 2;
> +	else
> +		val64 -= 9806650 * 5 / 2;
> +	offset = div_s64(val64, 9806650 * 5);
> +
> +	/* Clamp value limited to 12 bits signed */
> +	if (offset < -2048)
> +		offset = -2048;
> +	else if (offset > 2047)
> +		offset = 2047;

Use clamp() rather than open coding.
However it may ake more sense to reject out of range values.

> +
> +	PM_RUNTIME_ACQUIRE_AUTOSUSPEND(dev, pm);
> +	ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
> +	if (ret)
> +		return ret;
> +
> +	guard(mutex)(&st->lock);
> +
> +	switch (chan->channel2) {
> +	case IIO_MOD_X:
> +		/* OFFSET_USER4 register is shared */
> +		ret = inv_icm42607_mreg_read(st, INV_ICM42607_MREG1,
> +				INV_ICM42607_REG_OFFSET_USER4, &regval);
> +		if (ret)
> +			return ret;
> +
> +		hi = ((offset & 0xF00) >> 4) | (regval & 0x0F);
> +		lo = offset & 0xFF;
> +
> +		ret = inv_icm42607_mreg_write(st, INV_ICM42607_MREG1,
> +				INV_ICM42607_REG_OFFSET_USER4, hi);
> +		if (ret)
> +			return ret;
> +
> +		ret = inv_icm42607_mreg_write(st, INV_ICM42607_MREG1,
> +					      INV_ICM42607_REG_OFFSET_USER5, lo);
> +
> +		if (ret)
> +			return ret;

return here as well.

> +		break;
> +
> +	case IIO_MOD_Y:
> +		/* OFFSET_USER7 register is shared */
> +		ret = inv_icm42607_mreg_read(st, INV_ICM42607_MREG1,
> +					     INV_ICM42607_REG_OFFSET_USER7,
> +					     &regval);
> +		if (ret)
> +			return ret;
> +
> +		lo = offset & 0xFF;
> +		hi = ((offset & 0xF00) >> 8) | (regval & 0xF0);
> +
> +		ret = inv_icm42607_mreg_write(st, INV_ICM42607_MREG1,
> +					      INV_ICM42607_REG_OFFSET_USER7,
> +					      hi);
> +		if (ret)
> +			return ret;
> +
> +		ret = inv_icm42607_mreg_write(st, INV_ICM42607_MREG1,
> +					      INV_ICM42607_REG_OFFSET_USER6,
> +					      lo);
> +		if (ret)
> +			return ret;

		return inv_icm4...();
		
> +		break;
> +
> +	case IIO_MOD_Z:
> +		/* OFFSET_USER7 register is shared */
> +		ret = inv_icm42607_mreg_read(st, INV_ICM42607_MREG1,
> +					     INV_ICM42607_REG_OFFSET_USER7,
> +					     &regval);
> +		if (ret)
> +			return ret;
> +
> +		hi = ((offset & 0xF00) >> 4) | (regval & 0x0F);
> +		lo = offset & 0xFF;
> +
> +		ret = inv_icm42607_mreg_write(st, INV_ICM42607_MREG1,
> +					      INV_ICM42607_REG_OFFSET_USER7, hi);
> +		if (ret)
> +			return ret;
> +
> +		ret = inv_icm42607_mreg_write(st, INV_ICM42607_MREG1,
> +					      INV_ICM42607_REG_OFFSET_USER8, lo);
> +		if (ret)
> +			return ret;
> +		break;

Just return here. No point in breaking out of the switch then
immediately returning.

-- 
Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
