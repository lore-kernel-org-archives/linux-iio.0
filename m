Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793556408;
	b=htwGCe7DuwwObu47lEpNVPjj71XagpLDepDhVCF7GasdlcXa6OxsGhps4MGX8JGlAHg8
	 cbNzCAlYCZF0wRtgk6w+eBvckqfoR5LqjUwRAhJOupL+Rjc5ZtEXZOb4o28gjBQ8Lh5sv
	 nvRvWpRUG8euadbloFjA5P9nlqOCgqDynSIvdC/SdjHqM+2NL6FwcGeIzIvPuHJw2IJM4
	 1YABsz06bP8PlSJ0shtcspRR1Lbe9UH9kXKdJvHomeKCDAONATLeor9STlngov9dGgzCK
	 /NRvBxZ8FAlITV+ONaL74gxm0+qpugr891gneyqrfHABeHmZghf/xANTvIu+K8S75gg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793556408;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=HxzxY68LFgsEqhESPA9sAtt7IItE63uFTt9H+9KAsqY=;
	b=z0SdfiVaX5TqPtThS8hSddjruqfypxizo8g8rnPm/6D5DxoM9A6Ws6B5oTwkBphQlN9Y
	 0EosLe2Ql9qcCuPrvjWtx3/7/Yo6XslyMT+Fhe4141FvWy+BavA68rCB5GXzyApHy7tOj
	 Xejqdbw0xCIGEi2tmbDpiurj+bQ8ydd+dm78yFICHVA1AXOWujHaoFDQVJEFJArM/lqS4
	 RItGBtP+g/0GVRgI8Zp7BryvHOeXSOg7CH+WZHJdGIYIUVJSRyqvQ/S7yolXIqeDNSEDr
	 2ZTXqkwjELhzyQDVgxatyfOanTrIQWElmm8XwLaCKrxzIO/htgHH+59w4BKHEhDsU7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P87YTrAl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9F2606A324;
	Sun,  1 Nov 2026 18:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P87YTrAl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 114FE1F00919;
	Sun,  1 Nov 2026 18:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793556407;
	bh=HxzxY68LFgsEqhESPA9sAtt7IItE63uFTt9H+9KAsqY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=P87YTrAlXtY6yTL6IVaei3/kaOV+qmy3YbWBNzzuWpy6WjTbgurONXks1pqV4mNXE
	 sjx+eMH2lRrqVYZ3Qey6G/C2wLfO0ioCJT1AB6p9lfed1xj8TuR5exgKhAS34ch0DQ
	 7ZeOyfroZovcW2qm7NL284hQ0fA9Dk8ZvfaThRbuetPVLL47299bI/PRTcyp+YpRXy
	 hoDmoM1ZYfLiuJxS2JLxvOWieRcYZd8nDP3siIJvITvLQm1HSbHbFEJwIQOUei5CtQ
	 iJ6LnvDsJn7n/zsjHQBQALkhshFdyERjBQEZgyz+yHA3R82UEVDQx6BGLRd64Bd/qP
	 mQpNUJyNXD1eA==
Date: Sun, 1 Nov 2026 18:06:42 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Patrick Fischer via B4 Relay
 <devnull+admin.tsv-stahl-riesa.de@kernel.org>
Cc: admin@tsv-stahl-riesa.de, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, David
 Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Kevin Tsai
 <ktsai@capellamicro.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: light: Add Capella CM3217 ambient light sensor
 driver
Message-ID: <20261101180642.1768c3f2@jic23-hlaptop>
In-Reply-To: <20261101-upstream-iio-cm3217-v1-2-5e1724cae7b7@tsv-stahl-riesa.de>
References: <20261101-upstream-iio-cm3217-v1-0-5e1724cae7b7@tsv-stahl-riesa.de>
	<20261101-upstream-iio-cm3217-v1-2-5e1724cae7b7@tsv-stahl-riesa.de>
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

On Sun, 01 Nov 2026 15:46:07 +0100
Patrick Fischer via B4 Relay <devnull+admin.tsv-stahl-riesa.de@kernel.org> wrote:

> From: Patrick Fischer <admin@tsv-stahl-riesa.de>
> 
> The CM3217 has no registers and no ID. Writing a byte to address 0x10
> or 0x11 sets command byte 1 or 2, reading a byte from 0x10 or 0x11
> returns the high or low byte of the 16-bit light count.
> 
> Command byte 1 holds the shutdown bit and the IT_T field (1/2 T, 1 T,
> 2 T or 4 T), command byte 2 the FD_IT field (800 ms down to 66 ms). The
> count scales linearly with both. The driver exposes FD_IT as the
> integration time and IT_T through the scale, so the scale list offers
> four ranges for each integration time.
> 
> The datasheet is not public. The bit fields, the reserved bits that are
> written as 1 and the startup setting of 2 T and 100 ms come from NVIDIA's
> downstream drivers for the Tegra Note 7 (drivers/staging/iio/light/
> cm3217.c in the 3.4 and 3.10 kernels). For the resolution, Capella
> gives a range of 0.01875 to 119156 lux. The driver takes 0.01875 lux
> per count at 4 T and 800 ms. This matches both the upper end (65535
> counts at 1/2 T and 66 ms) and the 0.3 lux per count that the NVIDIA
> 3.4 driver uses at 2 T and 100 ms.
> 
> The sensor has no data-ready flag, and a new setting only takes effect
> when the conversion in progress ends. A conversion takes IT_T times
> FD_IT, up to 3.2 s. Leaving shutdown starts a new one at once, so the
> driver passes through shutdown on every change and waits one conversion
> period plus a margin before it reads the count. The timing was measured
> on a Tegra Note 7.

I don't think we have a current active Capella Micro developer on the
list as it's been a while since I heard from Kevin Tsai who contributed
drivers for them, so your approach of using the vendor driver as a
guide is probably the best we can do.

> 
> Signed-off-by: Patrick Fischer <admin@tsv-stahl-riesa.de>
A few comments inline.

If it is really hard to precompute all the available values, then
we can probably get away with not doing so.  I don't think it is
though and picking between precomputed sets is both cleaner and avoids
a race if we ever get light driver inkernel consumers.

Thanks

Jonathan

> diff --git a/drivers/iio/light/cm3217.c b/drivers/iio/light/cm3217.c
> new file mode 100644
> index 000000000000..9e0e9afee092
> --- /dev/null
> +++ b/drivers/iio/light/cm3217.c
> @@ -0,0 +1,383 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Capella CM3217 ambient light sensor driver
> + *
> + * The CM3217 has no registers. It answers on two fixed I2C addresses:
> + * writing a byte to 0x10 or 0x11 sets command byte 1 or 2, reading a byte
> + * from 0x10 or 0x11 returns the MSB or LSB of the 16-bit light count.
> + *
> + * Copyright (C) 2026 Patrick Fischer <admin@tsv-stahl-riesa.de>
> + */
> +
> +#include <linux/array_size.h>
> +#include <linux/bitfield.h>
> +#include <linux/bits.h>
> +#include <linux/cleanup.h>
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/i2c.h>
> +#include <linux/ktime.h>
> +#include <linux/math64.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/pm.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/types.h>
> +#include <linux/units.h>
> +
> +#include <linux/iio/iio.h>
> +
> +#define CM3217_ADDR_CMD2_LSB	0x11
> +
> +#define CM3217_CMD1_RSVD	BIT(5)		/* reserved, set to 1 */
> +#define CM3217_CMD1_IT_T	GENMASK(3, 2)	/* 1/2 T, 1 T, 2 T, 4 T */
> +#define CM3217_CMD1_WDM		BIT(1)		/* set to 1 like the vendor driver */
> +#define CM3217_CMD1_SD		BIT(0)		/* shutdown when set */
> +
> +#define CM3217_CMD2_FD_IT	GENMASK(7, 5)
> +
> +#define CM3217_IT_T_2T		2
> +#define CM3217_FD_IT_100MS	5
> +
> +/* 0.01875 lux per count at 4 T and 800 ms, the finest resolution */
> +#define CM3217_NLUX_MS		15000000000ULL

Use a muiltiplier for that definition. Various ones in units.h.
I haven't figured out what makes sense, but that is too many 
zeros to eyeball!

> +
> +#define CM3217_MARGIN_MS	10


> +
> +static unsigned int cm3217_conv_ms(struct cm3217_data *data)
> +	__must_hold(&data->lock)
> +{
> +	unsigned int fd_it = FIELD_GET(CM3217_CMD2_FD_IT, data->cmd2);
> +	unsigned int it_t = FIELD_GET(CM3217_CMD1_IT_T, data->cmd1);
> +
> +	return (cm3217_fd_it_ms[fd_it] << it_t) / 2;
> +}
> +
> +static void cm3217_update_scale_avail(struct cm3217_data *data)
There are some unfortunately complex race conditions around
read_avail where a consumer driver (iio/inkern.c) can hold a pointer to the
array and there is no visibility in the consumer of the fact the
data might be changing under it. The concern isn't so much getting
wrong values as getting torn ones as the writes are occuring. 
There have been a few goes at solving the race generically but none
have landed yet.  Generally avoiding that sort of handoff of
dynamic data is a nice to have and often easy enough to do.

I'm not that concerned for a light sensor as we have no consumers
in upstream anyway, but how bad would it be to precompute all possible
tables at probe time or even at compile time, and then just pick between them?

> +	__must_hold(&data->lock)
> +{
> +	unsigned int fd_it = FIELD_GET(CM3217_CMD2_FD_IT, data->cmd2);
> +	unsigned int i;
> +	u32 rem;
> +	u64 nlux;
> +
> +	for (i = 0; i < ARRAY_SIZE(data->scale_avail); i++) {
Might as well do

	for (unsigned int i = 0; .. {
	

> +		nlux = div_u64(CM3217_NLUX_MS << (3 - i), cm3217_fd_it_ms[fd_it]);
> +		data->scale_avail[i][0] = div_u64_rem(nlux, NANO, &rem);
> +		data->scale_avail[i][1] = rem;
> +	}
> +}



> +
> +static int cm3217_suspend(struct device *dev)
> +{
> +	struct cm3217_data *data = iio_priv(dev_get_drvdata(dev));
> +
> +	guard(mutex)(&data->lock);
> +
> +	return i2c_smbus_write_byte(data->client, data->cmd1 | CM3217_CMD1_SD);

Given this lines up with the power off callback above and the start of
the write_cmd() sequence, maybe have a little helper to put this write
command in just one place?

> +}
> +
> +static int cm3217_resume(struct device *dev)
> +{
> +	struct cm3217_data *data = iio_priv(dev_get_drvdata(dev));
> +
> +	guard(mutex)(&data->lock);
> +
> +	return cm3217_write_cmd(data, data->cmd1, data->cmd2);
> +}

> 

