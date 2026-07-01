Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078F4481242;
	Wed,  1 Jul 2026 19:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782933313; cv=none; b=i6kKxUPoyCijBo9ly+Bq5ach5Ain9fqJyeviaw42V27TgzvssetPm9lteBNBBgA0dbsiuRwSm185BPpazIJaO1HtUxMKQ4u7uDoV5JNI6y4DM2lG8LrICg1F1EHbk6/ScVoT1hqEejT+66FUsByjysC8EmYp+k4Gt0ESe6HUiyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782933313; c=relaxed/simple;
	bh=kwv1nQILMZTsDi66MdPmXjLUQ97uV6vufRUKXMrApwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fQSd88NLi+tGpP+MGMj+cyx5ihSmyRaRoh2AtahjvLmM6wNlu/wBb6zC3YtYKPlAmG1pYuoGdcnzFtEO4WnVddEYqvrQmEFyI4eb5QUb/rUASnugzUCxsyP4g8geoUpeeqwgEy372g6zPwODXcdtKanNEifkwOc98YDdXEa4rW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WthTVLL3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WthTVLL3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5704E1F000E9;
	Wed,  1 Jul 2026 19:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782933310;
	bh=PXI6rfCP7rz/KIG0Vkr+So4lrOQjJolN3JUOSQDEk48=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=WthTVLL3lgIP4mIjdkO7naf0W27hBU72WTeYtVQnHcR+DerF0bDIteht2+xlgsBnT
	 paaPLqDT3TdVMhm0BS2waNk56dCZAP7cvAqJYlOEWJlTXIL+soJRrJ+MqkqFJHcqW7
	 Zxi6H2vKaiIkxW5jrVdZPIdI07+NcjtJNGyvNXIaxfBLbN8kEH5xW3vKl04zF8g4y/
	 DXQnEkILwJsczXh4QtyzlZQsWgffpwwAdky18HC5Af4CLHKXgLgmDS6UBkEOvab+UL
	 sR60x/+w1skGlPhocNULpdG9N9KyJqn/z3Li+Dz9QKnT04GkU6i3t5Mbq2+5EY88bF
	 R+WN4xo92gOrA==
Date: Wed, 1 Jul 2026 20:15:01 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Chris Morgan <macroalpha82@gmail.com>
Cc: linux-iio@vger.kernel.org, andy@kernel.org, nuno.sa@analog.com,
 dlechner@baylibre.com, jean-baptiste.maneyrol@tdk.com,
 linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
 heiko@sntech.de, conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org,
 andriy.shevchenko@intel.com, Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [PATCH V15 3/9] iio: imu: inv_icm42607: Add inv_icm42607 Core
 Driver
Message-ID: <20260701201501.2f1dcdca@jic23-huawei>
In-Reply-To: <20260626161230.93069-4-macroalpha82@gmail.com>
References: <20260626161230.93069-1-macroalpha82@gmail.com>
	<20260626161230.93069-4-macroalpha82@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 26 Jun 2026 11:12:24 -0500
Chris Morgan <macroalpha82@gmail.com> wrote:

> From: Chris Morgan <macromorgan@hotmail.com>
> 
> Add the core component of a new inv_icm42607 driver. This includes
> a few setup functions and the full register definition in the
> header file, as well as the bits necessary to compile and probe the
> device when used on an i2c bus.
> 
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
Hi Chris

A few minor formatting things from a fresh read.

Thanks,

Jonathan

> diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607.h b/drivers/iio/imu/inv_icm42607/inv_icm42607.h
> new file mode 100644
> index 000000000000..88d35323bade
> --- /dev/null
> +++ b/drivers/iio/imu/inv_icm42607/inv_icm42607.h
> @@ -0,0 +1,364 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * Copyright (C) 2026 InvenSense, Inc.
> + */
> +
> +#ifndef INV_ICM42607_H_
> +#define INV_ICM42607_H_
> +
> +#include <asm/byteorder.h>
> +#include <linux/bits.h>
> +#include <linux/iio/iio.h>
> +#include <linux/mutex.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/time.h>
> +#include <linux/types.h>
> +

Generally asm includes come in their own block
after the linux ones.

> diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_i2c.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_i2c.c
> new file mode 100644
> index 000000000000..bde931752eb8
> --- /dev/null
> +++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_i2c.c
> @@ -0,0 +1,97 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2026 InvenSense, Inc.
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/dev_printk.h>
> +#include <linux/err.h>
> +#include <linux/i2c.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/regmap.h>
> +
> +

Really trivial, but one blank line is enough here.

> +#include "inv_icm42607.h"
> +


