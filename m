Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2AF53CEB9E;
	Thu, 11 Jun 2026 11:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781176942; cv=none; b=QtO9F8RSabSDoHbX7hyFRO9TRmg4LQWLWb9GXNBzpTObnSOTNvSPxAi+tzogo/KxQ9bENIiXBzsokdDQs5yOyClMAVVz/45IQouxtd0xRRgjJfhjWCO8Db7HX04abwdASYeUxVWwdHqzsyIq4ux+0jG76dQRmimQ9vA5Uew2MPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781176942; c=relaxed/simple;
	bh=VTzbIrxTlmb1/Yak9XXaLt4ul8yDujfLM5YyYSRBM30=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BVOPLA6jzZdbUqDZmjH28QDaP6G2WG2ZLP0Z74sMkP+2RBB2newfsir/du0iXA4nieS6j54D/AbciF499625rv8/ZjRswOKgGjQYbpX2ySbhL+9/t1y5J4Cb6jKrALH6mQUJrfAFO7wRU96YBYc0Yhkdz0zBVPvPscwasCEQk/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OqhNxuKc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OqhNxuKc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09E2A1F00893;
	Thu, 11 Jun 2026 11:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781176941;
	bh=F54wuFhdDUrJ0Wo059CZXz1oADLYin84AYSqrYVeWMU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=OqhNxuKcaKtRypP/Z2P9prHXpycK4s5ls7j3qcX99wEXmGVY+4jCricPhTRQYhJrF
	 fDBStESOAyFmNPDXpZd07PX5Ir4UW4Kdsyypriejkr0KGAlx/HJz1hhWuRfOwmwGSU
	 qVHCtGUuRIkQzEZLT/H9vud0cBP4ItGMzcNlzTeINzGV3M8Nm6/OZOCbCYzx1/ukCw
	 969L0qmXoA9vZCxIjY4QwKpa8+qMRIM4adfkriD2w9ykMmEvrZBmC9wWRtvp/Jojyd
	 immxViphqtqj2ytf2sRBp36IyG9UVKOevJtDNauLpvb7gAoGi7ZHMxaQQWfEyEWt+p
	 5/eYTZonwoLVg==
Date: Thu, 11 Jun 2026 12:22:13 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Chris Morgan <macroalpha82@gmail.com>
Cc: linux-iio@vger.kernel.org, andy@kernel.org, nuno.sa@analog.com,
 dlechner@baylibre.com, jean-baptiste.maneyrol@tdk.com,
 linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
 heiko@sntech.de, conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org,
 andriy.shevchenko@intel.com, Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [PATCH V11 6/9] iio: imu: inv_icm42607: Add Temp Support in
 icm42607
Message-ID: <20260611122213.631903ec@jic23-huawei>
In-Reply-To: <20260610175455.19006-7-macroalpha82@gmail.com>
References: <20260610175455.19006-1-macroalpha82@gmail.com>
	<20260610175455.19006-7-macroalpha82@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 10 Jun 2026 12:54:50 -0500
Chris Morgan <macroalpha82@gmail.com> wrote:

> From: Chris Morgan <macromorgan@hotmail.com>
>=20
> Add functions for reading temperature sensor data.
>=20
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
Hi Chris,

A few consistency things around the channel definitions and some
left over stuff I think from you ripping out the interrupt / buffered suppo=
rt.

Thanks,

Jonathan

> diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_temp.c b/drivers/i=
io/imu/inv_icm42607/inv_icm42607_temp.c
> new file mode 100644
> index 000000000000..55260082a19e
> --- /dev/null
> +++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_temp.c
> @@ -0,0 +1,82 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2026 InvenSense, Inc.
> + */
> +
> +#include <linux/device.h>
> +#include <linux/iio/iio.h>
> +#include <linux/mutex.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/regmap.h>
> +
> +#include "inv_icm42607.h"
> +#include "inv_icm42607_temp.h"

> +int inv_icm42607_temp_read_raw(struct iio_dev *indio_dev,
> +				struct iio_chan_spec const *chan,
> +				int *val, int *val2, long mask)
> +{
> +	struct inv_icm42607_state *st =3D iio_device_get_drvdata(indio_dev);
> +	s16 temp;
> +	int ret;
> +
> +	if (chan->type !=3D IIO_TEMP)
> +		return -EINVAL;
This feels little over defensive given the function name. Any bug
that called it anyway would be pretty bad!
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:

The lack of having the shared_by_all stuff in here makes things
a little fragile (once you've added them to the bitmap below) as
which chan->type we get depends on channel registration ordering.

So avoid this being called for those mask elements.  I'll reply
to next patch to call that out in a few mins.

> +		if (!iio_device_claim_direct(indio_dev))
> +			return -EBUSY;

A driver that isn't yet doing buffered support should not be
claiming modes (as it's always in direct mode).  If this is
serializing for some reason other than avoiding mode transitions,
it should be using the local lock. Seems it is doing that
anyway so just drop this layer of protection.

> +		ret =3D inv_icm42607_temp_read(st, &temp);
> +		iio_device_release_direct(indio_dev);
> +		if (ret)
> +			return ret;
> +		*val =3D temp;
> +		return IIO_VAL_INT;
> +	/*
> +	 * T=C2=B0C =3D (temp / 128) + 25
> +	 * Tm=C2=B0C =3D 1000 * ((temp * 100 / 12800) + 25)
> +	 * scale: 100000 / 12800 ~=3D 7.8125
> +	 * offset: 3200
> +	 */
> +	case IIO_CHAN_INFO_SCALE:
> +		*val =3D 7;
> +		*val2 =3D 812500000;
> +		return IIO_VAL_INT_PLUS_NANO;
> +	case IIO_CHAN_INFO_OFFSET:
> +		*val =3D 3200;
> +		return IIO_VAL_INT;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_temp.h b/drivers/i=
io/imu/inv_icm42607/inv_icm42607_temp.h
> new file mode 100644
> index 000000000000..e03924e30866
> --- /dev/null
> +++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_temp.h
> @@ -0,0 +1,33 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * Copyright (C) 2026 InvenSense, Inc.
> + */
> +
> +#ifndef INV_ICM42607_TEMP_H_
> +#define INV_ICM42607_TEMP_H_
> +
> +#include <linux/bitops.h>
> +
> +struct iio_dev;
> +struct iio_chan_spec;
> +
> +#define INV_ICM42607_TEMP_CHAN(_index)				\
> +{								\
> +	.type =3D IIO_TEMP,					\
> +	.info_mask_separate =3D					\
> +		BIT(IIO_CHAN_INFO_RAW) |			\
> +		BIT(IIO_CHAN_INFO_OFFSET) |			\
> +		BIT(IIO_CHAN_INFO_SCALE),			\

Whilst it makes no difference to exposure of sysfs attributes, this
should include the shared_by_all stuff form the other channels.
That is supposed to be in every channel so that we can easily see
what affects each channel.=20

> +	.scan_index =3D _index,					\
> +	.scan_type =3D {						\
> +		.sign =3D 's',					\
> +		.realbits =3D 16,					\
> +		.storagebits =3D 16,				\
> +	},							\
> +}
> +
> +int inv_icm42607_temp_read_raw(struct iio_dev *indio_dev,
> +			       struct iio_chan_spec const *chan,
> +			       int *val, int *val2, long mask);
> +
> +#endif

