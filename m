Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9884C285C8B;
	Sun, 14 Jun 2026 16:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781455408; cv=none; b=h0veM5oW0OsDddU9cfw9YxUG7DpFmr12qVpjS48HAtuIK0f2MFKdPh2NkO05XgM+RHinffi4sJuLgA1m/+qxDFQylNuxHxYTllnV02kFwNdBkhqMZ+15oiVmAmWTxLd/x2DPYl8876mfZ1MavDURIxhrMS5xeXa5BxgxObut4Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781455408; c=relaxed/simple;
	bh=wE/6l/nRZHv2l0ccE0H+IabZswGjTrYZVjOhrGcQXu8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lxM8bzHYDnm5jcyBTuDUPesGq8ZD5GifzPNpXwXseVugZMa5b4q6JdSiORb4Z5VQsCsb2YJy3CXgoUelfdSa6KiCeNb6WtwH4lbw2oSO924iyrhws+1pPbSWfkxoTRacs4GryPziyFM6KdY76SbzvCgsFmbnRh4bxWRArrIAhFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MirJXAQL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MirJXAQL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11A7B1F000E9;
	Sun, 14 Jun 2026 16:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781455407;
	bh=+zQw4+hL3j1CnxUb4Aobd/oKysJEMwCgjzSj2E8RaI8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=MirJXAQLQ1ouWWPrnVTflWkZrsaooPTYk5UZWheC234L3+YabMcEFvH0ZLVALK8bR
	 WdvoCx1xPkAvCljhKgSgdc3awm2pBpWQnsrIUeKWgUIBjQueXd1R47vZTC7+c4akcs
	 iKOmuiNKza1kytdk3lFP6L0k8pvwMPhXoMH5aHSl1llTs324nU0ASEOz0xSdMyQKR0
	 kKdOiJyoxyaUWMajuBvgJf3i0iU37P5DcJFr6zJok8vvETXypyi54d+HiiTtq3undz
	 D/lHRH+jQ2XKjV1WdwWoC2s9joQkbFOM6drW+3cd+QxbfhY6PtQSaDkZjicw2Z16yS
	 VpytERaNj8s2g==
Date: Sun, 14 Jun 2026 17:43:17 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Chris Morgan <macroalpha82@gmail.com>
Cc: linux-iio@vger.kernel.org, andy@kernel.org, nuno.sa@analog.com,
 dlechner@baylibre.com, jean-baptiste.maneyrol@tdk.com,
 linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
 heiko@sntech.de, conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org,
 andriy.shevchenko@intel.com, Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [PATCH V12 7/9] iio: imu: inv_icm42607: Add Accelerometer for
 icm42607
Message-ID: <20260614174317.2a47f191@jic23-huawei>
In-Reply-To: <20260611202607.85376-8-macroalpha82@gmail.com>
References: <20260611202607.85376-1-macroalpha82@gmail.com>
	<20260611202607.85376-8-macroalpha82@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 11 Jun 2026 15:26:04 -0500
Chris Morgan <macroalpha82@gmail.com> wrote:

> From: Chris Morgan <macromorgan@hotmail.com>
> 
> Add icm42607 accelerometer sensor for icm42607.
> 
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
Really trivial stuff that I'd not have mentioned if you weren't
doing a v13 for other reasons.

> ---
>  drivers/iio/imu/inv_icm42607/Makefile         |   1 +
>  drivers/iio/imu/inv_icm42607/inv_icm42607.h   |  34 ++
>  .../iio/imu/inv_icm42607/inv_icm42607_accel.c | 376 ++++++++++++++++++
>  .../iio/imu/inv_icm42607/inv_icm42607_core.c  |  61 +++
>  4 files changed, 472 insertions(+)
>  create mode 100644 drivers/iio/imu/inv_icm42607/inv_icm42607_accel.c

> diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_accel.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_accel.c
> new file mode 100644
> index 000000000000..5e260ddad641
> --- /dev/null
> +++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_accel.c
> @@ -0,0 +1,376 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2026 InvenSense, Inc.
> + */
> +
> +#include <linux/iio/iio.h>
> +#include <linux/mutex.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/regmap.h>
> +
> +#include "inv_icm42607.h"
> +#include "inv_icm42607_temp.h"
> +
> +#define INV_ICM42607_ACCEL_CHAN(_modifier, _index, _ext_info)		\
> +{									\
> +	.type = IIO_ACCEL,						\
> +	.modified = 1,							\
> +	.channel2 = _modifier,						\
> +	.info_mask_separate =						\
> +		BIT(IIO_CHAN_INFO_RAW),					\
> +	.info_mask_shared_by_type =					\
> +		BIT(IIO_CHAN_INFO_SCALE),				\
> +	.info_mask_shared_by_type_available =				\
> +		BIT(IIO_CHAN_INFO_SCALE),				\
> +	.info_mask_shared_by_all =					\
> +		BIT(IIO_CHAN_INFO_SAMP_FREQ),				\
> +	.info_mask_shared_by_all_available =				\
> +		BIT(IIO_CHAN_INFO_SAMP_FREQ),				\
Maybe for these, just go a bit long on line length (so 81 chars).
I don't really care either way!

> +	.scan_index = _index,						\
> +	.scan_type = {							\
> +		.sign = 's',						\
> +		.realbits = 16,						\
> +		.storagebits = 16,					\
> +		.endianness = IIO_BE,					\
> +	},								\
> +	.ext_info = _ext_info,						\
> +}


> +
> +static int inv_icm42607_accel_write_odr(struct iio_dev *indio_dev,
> +					int val, int val2)
> +{
> +	struct inv_icm42607_sensor_conf conf = INV_ICM42607_SENSOR_CONF_INIT;
> +	struct inv_icm42607_state *st = iio_device_get_drvdata(indio_dev);
> +	struct device *dev = regmap_get_device(st->map);
> +	unsigned int idx;
> +	int ret;
> +
> +	for (idx = 5; idx < ARRAY_SIZE(inv_icm42607_accel_odr); ++idx) {
> +		if (val == inv_icm42607_accel_odr[idx][0] &&
> +		    val2 == inv_icm42607_accel_odr[idx][1])
> +			break;
> +	}
> +	if (idx >= ARRAY_SIZE(inv_icm42607_accel_odr))
> +		return -EINVAL;
> +
> +	conf.odr = idx;
> +
> +	PM_RUNTIME_ACQUIRE_AUTOSUSPEND(dev, pm);
> +	ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
> +	if (ret)
> +		return ret;
> +
> +	guard(mutex)(&st->lock);
> +
> +	ret = inv_icm42607_set_accel_conf(st, &conf, NULL);
> +	if (ret)
> +		return ret;

return inv_icm....

> +
> +	return 0;
> +}
