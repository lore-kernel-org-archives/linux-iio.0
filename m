Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795830138;
	b=JhyZ+Cc0RxOYv7hVogbkTGUNnCSnmsU2Id0N/AmuUfZnQa0YSZxQC7ZCxE7Ty/LYFLp7
	 /CSEiNKQAV3K881jF9vea9T69RQOPXhUHrkmZE3LeBaJhjYWnKdMATUC3EYboG43RI+ev
	 FC1w2EcjobWa4sonpFRY8jgLeCdNdpXaBspyLTpX0ofs1fSAYg6CO2mO4PFDoqyBeF0qn
	 vLBqU1Q3xI89KN12Fn02oJlk5Qv4KV2iKmS0Jj8OXeXExBQuAu5D0wbLGrTZMUu4ebsFZ
	 UWxKMT/IChmCl2vIZ9r43TxxDVlnrmWhD/nwDb2hC03uOewTAm6P0rzKpuah17T7JCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795830138;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=NGxIKYlTWLs9BdPsJCG0LMDXFmXTxHrXo25j3QkL8Q0=;
	b=3OkEHxbuFxo5kz6VDgtOhkQq8VfnYtPrqp83Jy9uFPtpo6F62n1KAtQCuSYFmzrwrkFJ
	 r5sepn7Gvo5VoX78r0dll4hP3I2jXczm3CwnwMYqh5TxtcU2ltS2titzkpYZo9N6ca4JA
	 O3zX8ianCw7jK+k534MAIByl0nJedK/GDHTq3gR9he2Yryo3bLrZtx+bMSD/rNilHqJMI
	 ZsLWpd/UGtn6BDvdU8voEPAwVux10NcEzIDhh+hfxZaugPb3qinStGatYb5unij4JSk79
	 jLlZnm5YJdShRPIGcvcsgVnSy0TA46XTvb/wy6tkFIYejssaBEVudLjp5VqF7bmso0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nNXr230Y;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282A2606A31C;
	Sat, 28 Nov 2026 01:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nNXr230Y
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03EB81F000C1;
	Sat, 28 Nov 2026 01:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795830137;
	bh=NGxIKYlTWLs9BdPsJCG0LMDXFmXTxHrXo25j3QkL8Q0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=nNXr230YLXe7qRNa6cff7PJMk4+5H/ebByyucSmlZxTmYxpSwUtUUUDO4SayTGSrc
	 IrK93o4EiCl883KNuHtjOjxPxkleWHWQzgNGOfz2yaipODcECiWb0mVt/hl2WPRnaZ
	 pPWF33NEYSVe8fX9jHsJhMjRq7qNAaHcFuud1XB1DLhx1jgeJ+m2ndJdOX727rVVuI
	 gIB414vsgClROTtG9jep2lrWGmA56xTxT+qg3fDPEJoQ0KDrgOD4Z/RjwLVpS98xcM
	 8xCyLL0cxUmiD4AKQx3JmpERUioes0CEZO82vfhazhNp+66tqun7cSvkT1YyT/FAQk
	 QUZZCOcZjDnZQ==
Date: Sat, 28 Nov 2026 01:42:14 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Robert Ijtsma via B4 Relay <devnull+robertijtsma.gmail.com@kernel.org>
Cc: robertijtsma@gmail.com, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Matti Vaittinen
 <mazziesaccount@gmail.com>
Subject: Re: [PATCH v3 2/2] iio: light: add ams OSRAM TCS3430 XYZ and
 ambient light sensor driver
Message-ID: <20261128014214.1541d7ee@jic23-hlaptop>
In-Reply-To: <20261127-iio-tcs3430-v3-2-e191a40a4ae9@gmail.com>
References: <20261127-iio-tcs3430-v3-0-e191a40a4ae9@gmail.com>
	<20261127-iio-tcs3430-v3-2-e191a40a4ae9@gmail.com>
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

On Fri, 27 Nov 2026 09:12:50 +0100
Robert Ijtsma via B4 Relay <devnull+robertijtsma.gmail.com@kernel.org> wrote:

> From: Robert Ijtsma <robertijtsma@gmail.com>
> 
> Add an IIO driver for the ams OSRAM TCS3430 ambient light and CIE 1931
> XYZ tristimulus color sensor (found at I2C address 0x39 on devices such
> as the Microsoft Surface Pro X).
> 
> Unlike the older TAOS RGBC drivers (tcs3414, tcs3472) that use the 0x80
> COMMAND-bit SMBus protocol and RGBC channels, and unlike the banked
> MAZeT/JENCOLOR as73211 driver, the TCS3430 uses ams's direct-addressed
> 0x80..0xdd register map and exposes Z, Y, IR1, and X tristimulus channels.
> 
> The driver exposes:
> - Illuminance (photopic Y channel) with raw counts and lux scale
> - Modified intensity channels for X, Y, Z, and IR1
> - Selectable scale and integration time via the IIO GTS helper across
>   1x/4x/16x/64x/128x gain and 50.04/100.08/200.16/400.32 ms integration
>   time settings
> - Regulator management and system sleep suspend/resume support
> 
> Tested on Microsoft Surface Pro X SQ2 (SC8180X).
> 
> Signed-off-by: Robert Ijtsma <robertijtsma@gmail.com>
Looking good.

Only significant remaining question I had is over scaling of the
channels other than the illuminance one.  

I'm not sure how easy it is to make the gts helper deal with the
different scales (it was written much more recently than when I last
touched a light sensor and I haven't used it myself yet as a result!)

+CC Matti for input on this.

Thanks,

Jonathan

> diff --git a/drivers/iio/light/tcs3430.c b/drivers/iio/light/tcs3430.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..06e5ecd91f6502a1d8c99de4707e590dac4f5beb
> --- /dev/null
> +++ b/drivers/iio/light/tcs3430.c
> @@ -0,0 +1,521 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * ams OSRAM TCS3430 ambient light and CIE 1931 XYZ sensor driver
> + *
> + * Copyright (C) 2026 Robert Ijtsma <robertijtsma@gmail.com>
> + *
> + * Datasheet:
> + *   https://look.ams-osram.com/m/43d518b4cd81e3f2/original/TCS3430-DS000539.pdf
> + */
> +
> +#include <linux/array_size.h>
> +#include <linux/bitfield.h>
> +#include <linux/bits.h>
> +#include <linux/cleanup.h>
> +#include <linux/device.h>

I didn't check, but do we need device.h itself or can we use
more specific headers like dev_printk.h?

> +#include <linux/err.h>
> +#include <linux/i2c.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/pm.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/types.h>
> +
> +#include <asm/byteorder.h>

> +
> +/*
> + * Photopic Y channel typical sensitivity from datasheet optical characteristics:
> + * ~0.537 counts/lux at AGAIN = 16x and ATIME = 100 ms (36 cycles), giving:
> + *   lux/count = 2980 / (gain * integration_time_ms)
> + *
> + * At minimum gain (1x) and shortest integration time (50.04 ms, 18 cycles):
> + *   max_scale = 2980 / 50.04 = 59.552358113 lux/count
> + */
> +#define TCS3430_MAX_SCALE_INT		59
> +#define TCS3430_MAX_SCALE_NANO		552358113


> +static int tcs3430_apply_itime(struct tcs3430_data *data, u8 atime)
> +{
> +	int ret;
> +
> +	ret = regmap_write(data->regmap, TCS3430_REG_ATIME, atime);
> +	if (ret)
> +		return ret;
> +
> +	data->atime = atime;

Trivial but slightly preference for a blank line before simple
returns of 0 for success like these.  Just makes them stand out a tiny
bit more as being the good path.

> +	return 0;
> +}

> +
> +#define TCS3430_INTENSITY_CHANNEL(_mod, _addr) {			\
> +	.type = IIO_INTENSITY,						\
> +	.modified = 1,							\
> +	.channel2 = (_mod),						\
> +	.address = (_addr),						\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),			\
> +	.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME),		\
> +	.info_mask_shared_by_all_available =				\
> +		BIT(IIO_CHAN_INFO_INT_TIME),				\
> +}
> +
> +static const struct iio_chan_spec tcs3430_channels[] = {
> +	{
> +		.type = IIO_LIGHT,
> +		.address = TCS3430_REG_CH1DATAL,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +				      BIT(IIO_CHAN_INFO_SCALE),
> +		.info_mask_separate_available = BIT(IIO_CHAN_INFO_SCALE),

Scale is a bit of a weird concept for the various intensity channels
but I'd still expect that if we change this scale, they would be affected
(if it modifies AGAIN rather than the integration time that you are exposing).
Hence I'm a little surprised to see it only here.

The actual scaling doesn't matter for intensity channels because they are
normally poorly defined though for CIE XYZ we are in a better state than
normal so if the gain doubles they should double.  I'd expect the same
for the IR channel. Or am I missing something?

Upshot, I think this is either shared_by_all or separate but for
each element with appropriate additional scale factors rolled in
I played with an LLM and it thinks the values are a bit wrong for the
listed 2700K white test relecting perhaps a small channel specific scaling?

I'm not immediately sure how we do that with the gts code.

Perhaps just keeping the one simple scaling control is the right option
but I think we do need to expose it for all channels.



> +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME),
> +		.info_mask_shared_by_all_available =
> +			BIT(IIO_CHAN_INFO_INT_TIME),
> +	},
> +	TCS3430_INTENSITY_CHANNEL(IIO_MOD_Z, TCS3430_REG_CH0DATAL),
> +	TCS3430_INTENSITY_CHANNEL(IIO_MOD_Y, TCS3430_REG_CH1DATAL),
> +	TCS3430_INTENSITY_CHANNEL(IIO_MOD_LIGHT_IR, TCS3430_REG_CH2DATAL),
> +	TCS3430_INTENSITY_CHANNEL(IIO_MOD_X, TCS3430_REG_CH3DATAL),
> +};


