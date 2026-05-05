Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E694371899;
	Tue,  5 May 2026 10:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777976258; cv=none; b=YOwIRPhSlkwuYn39NRlYnDst1j25lRbsVSM87yy2/9ei79khYbP39FEvf9o5qqHFUBX/cpO+7+zkF7rG+PtRUNh+nTR/9aVJHrbGhrl/HBndgTk4TAkRPhU/9R0ZqVerlh3jt3nQZLwfDRWK+W+G2GbgOt5gP/t7HgzK1ug3y0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777976258; c=relaxed/simple;
	bh=HiZy0Hq2RZxmk3TPPKQemNpPCrDQCvf6ZPEVCZexKAU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=soE/f3j859cPBaoT0ljrij18Jq0stLDQmz8nnq/dYzgE+0HiYfsPy+WpFbDLNj6q5VJbdHlneniZY+WpUSm+sVTTLJ2VuRzOayBu5NOdb+4PoxDQ8Up30+Um6VYGsH/yD6L3LN9C+zcZiLFX34nz+7ckQyLGz/54oYazC4Dq3Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HPhMJ8fE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HPhMJ8fE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84821C2BCB4;
	Tue,  5 May 2026 10:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777976257;
	bh=HiZy0Hq2RZxmk3TPPKQemNpPCrDQCvf6ZPEVCZexKAU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HPhMJ8fEh1VnXw3SGcS/g6PyuN1kKUoUYlnXkKsdAoTDGCAw39otgQf19rbzhrtPq
	 aa6RCPMGZtoFAmb+Iv68pXJpEC0Y6LHZMCz/JTcIKh4QXF7qm2aortty6FFL/kiDMR
	 3iAk/3MRpztY+wkXIXa38KhKeFuigA28ty287WhUyKMnoGW7v/RFA07SEfctQDoMyS
	 dQOOsuvzXUQZHv8+h4X6ekoGR/+cyXKUEdmL4xJmS0/dHuiNB761wNLeNNziLLnHcv
	 0Taf5dH6VshB58z419zZbpKMuS/nipNCsKKHXc3BdGeVCJmBTzSdG1cSf49IGOPAwp
	 ieQWsQnCSjRdQ==
Date: Tue, 5 May 2026 11:17:28 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Chris Morgan <macroalpha82@gmail.com>
Cc: linux-iio@vger.kernel.org, andy@kernel.org, nuno.sa@analog.com,
 dlechner@baylibre.com, jean-baptiste.maneyrol@tdk.com,
 linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
 heiko@sntech.de, conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org,
 andriy.shevchenko@intel.com, Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [PATCH V4 06/10] iio: imu: inv_icm42607: Add Temp Support in
 icm42607
Message-ID: <20260505111728.4fdd9eec@jic23-huawei>
In-Reply-To: <20260501221152.194251-7-macroalpha82@gmail.com>
References: <20260501221152.194251-1-macroalpha82@gmail.com>
	<20260501221152.194251-7-macroalpha82@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  1 May 2026 17:11:45 -0500
Chris Morgan <macroalpha82@gmail.com> wrote:

> From: Chris Morgan <macromorgan@hotmail.com>
> 
> Add functions for reading temperature sensor data.
> 
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
A few minor things.

Thanks,

Jonathan

> diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_temp.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_temp.c
> new file mode 100644
> index 000000000000..bcc11620c74c
> --- /dev/null
> +++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_temp.c
> @@ -0,0 +1,81 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2026 InvenSense, Inc.
> + */
> +
> +#include <linux/kernel.h>

As in previous avoid this by using more specific headers.

> +#include <linux/device.h>
> +#include <linux/mutex.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/regmap.h>

blank line here to match other files.

> +#include <linux/iio/iio.h>
> +
> +#include "inv_icm42607.h"
> +#include "inv_icm42607_temp.h"
> +
> +static int inv_icm42607_temp_read(struct inv_icm42607_state *st, s16 *temp)
> +{
> +	struct device *dev = regmap_get_device(st->map);
> +	__be16 *raw;
> +	int ret;
> +
> +	PM_RUNTIME_ACQUIRE_AUTOSUSPEND(dev, pm);
> +	if (PM_RUNTIME_ACQUIRE_ERR(&pm))
> +		return -ENXIO;
> +
> +	guard(mutex)(&st->lock);
> +
> +	ret = inv_icm42607_set_temp_conf(st, true, NULL);
> +	if (ret)
> +		return ret;
> +
> +	raw = &st->buffer[0];
> +	ret = regmap_bulk_read(st->map, INV_ICM42607_REG_TEMP_DATA1, raw, sizeof(*raw));
> +	if (ret)
> +		return ret;
> +
> +	*temp = be16_to_cpup(raw);
> +	if (*temp == INV_ICM42607_DATA_INVALID)
> +		ret = -EINVAL;
		return -EINVAL;

	return 0;

is no longer and to me a tiny bit simpler to read.

> +
> +	return ret;
> +}

> diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_temp.h b/drivers/iio/imu/inv_icm42607/inv_icm42607_temp.h
> new file mode 100644
> index 000000000000..d0bd6c460ff2
> --- /dev/null
> +++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_temp.h
> @@ -0,0 +1,30 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * Copyright (C) 2026 InvenSense, Inc.
> + */
> +
> +#ifndef INV_ICM42607_TEMP_H_
> +#define INV_ICM42607_TEMP_H_
> +
> +#include <linux/iio/iio.h>

Need header for BIT() and I'm not seeing a need for this one.
Just add forward defs for struct iio_dev and struct iio_chan_spec

> +
> +#define INV_ICM42607_TEMP_CHAN(_index)				\
> +{								\
> +	.type = IIO_TEMP,					\
> +	.info_mask_separate =					\
> +		BIT(IIO_CHAN_INFO_RAW) |			\
> +		BIT(IIO_CHAN_INFO_OFFSET) |			\
> +		BIT(IIO_CHAN_INFO_SCALE),			\
> +	.scan_index = _index,					\
> +	.scan_type = {						\
> +		.sign = 's',					\
> +		.realbits = 16,					\
> +		.storagebits = 16,				\
> +	},							\
> +}
> +
> +int inv_icm42607_temp_read_raw(struct iio_dev *indio_dev,
> +			       struct iio_chan_spec const *chan,
> +			       int *val, int *val2, long mask);
> +
> +#endif

