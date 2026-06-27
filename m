Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D64337FF71
	for <linux-iio@vger.kernel.org>; Sat, 27 Jun 2026 21:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782595476; cv=none; b=MmJygfK9h93ZESzVZ4QZR360hWGJc/IWyKYnhp1TOIcJPrXJF6oPuj6OkKK6C7eze3S+RUOb0dnRKOvPleQkx8QDeEmxcy5mscCqFzJgpD/NfHiTK8MQ9lKkp7z4G1b9xX70FnYy6GhYMMn1Ham4DH7f+tuUiwBlUFGF4F3cA/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782595476; c=relaxed/simple;
	bh=/ZjeGJ/bIA564jdCVSzFiyPxI844EbgOUogGjeVY0oo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W9ouRcyM8Jdu0g7Ixor+P5C6+SP4MTDN5w8VrabNaQU2wXpOUirJuNh0jZ8ntGJKNuc5wCxcDDZuns66NU4iBEwANq1DNvtPeVEeX7FGL3RUS5vAPJEVU935nQDBlfHPKcQ/tZeJ5Hyhs8K2/6dYIfmorVJRJyRu/s0K7UcnGUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=BxsW+YcD; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="BxsW+YcD"
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-6a1009f6adeso1577880eaf.3
        for <linux-iio@vger.kernel.org>; Sat, 27 Jun 2026 14:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1782595473; x=1783200273; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s4jIJTVXYnKYZ9qZqfum56MRXesVpvMmgXXybijGVXk=;
        b=BxsW+YcDMse3LD+buzs64R3PbYgSW5+f9IQ+d+XKoQnKmvceuUf4l9bqM8NpRSDM0f
         UEpI1zq8m5V9K7pV62P3PeokmS3DtZMfvw/ygELDXOyEikK8JHy87pctkt3NZCoz600z
         uFIyPEys1DtMlnpoDFVJONbAZcXWoR0Y1a1iOzza4amN/Q33F4NohPuIUytWQ96LLWCS
         yvfr4pbNoqgUOFdjrweHPTtL8DrpMYpphwLfrTFv/uzTE7clpvz7VnubnAAwOlaO0gux
         ZfZezzc/mntJ6Tpal2B3G8DAw59FGBTrfiDBQHMXiXnDrbp2n3mEq5HWy1oIBYhB46Kx
         dYYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782595473; x=1783200273;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s4jIJTVXYnKYZ9qZqfum56MRXesVpvMmgXXybijGVXk=;
        b=ZdChithQPt1HzMtI/KfrRECyChOv7pAC5/k3QLQBI16biH0s0vXmwqo8CfzwYZTFta
         X/ZMPxjWf3SokREOGUT3w/cQ1q+oK7/g/Kgdy7eBWi/IzhalmWdE+fDt0iUL6M9uYjCG
         NrY7L1tqbMYzZh6R8v7rPLxBOOG4VaVOQsMy210zQhhkbTWDcSmisofRi7oRcv/VspK6
         I9lzULrldV9fO7akVl9XF1IeAgbVf2g4/GyWkeWLSKPsnxj9QVA1IIHYja4i+VWWxQNN
         Chhvas79847EOWUFAuXqOVBflfUUNe84k4AFzQ/d8ZSP4K9gP+qMNr3QSH1757cLCuLm
         yPcg==
X-Forwarded-Encrypted: i=1; AFNElJ/Hj8m5K7iKWg5mMl6EXn2MztB2PhYVdfahIMpZZE2NkjPwHyDa/elEMAvOiQMeIDv0xNtfKE7zgh4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlXDTmcB2yt+peUl5sX4OWnK4XCx2MazUZy+UU0CmGfVFHZmcq
	sLmXt5aJ5xBWIxa2cuRLil5Jl713S894J+9cDl6jxxX2Qz1rrQc0GGJ7jwI6orP2JUU=
X-Gm-Gg: AfdE7cnO5Kk/tk1BGkgoMBUo9jOF144r7UfZo3JA8L9HD/JPBUIg9DQXn8wDeC6SugO
	/YWkokgQDV9iBo9k0IJ8opQZ5f57TR37bpWFAfU0fOO2JzQ0LAHwGNxIzGz1V/5uaujtUnTTLIR
	YgzjyK9ZGjivhCoemwLnuz4Bf5xHUM9R7RgzG2naDpwng5Dy//zYDvdIRU7RN8kzOORXL6xs2bw
	qxrYsql1aW+luC8agcsbtUzREC8AXcxYAKhqc0J4O1+mvUbZ1xVNaBusb3lxg/i657O3Qlc+odr
	sVuOHW5i4bvlgdUPE4wCCt/xwZKJ9g9fErzQt/gSpGb/vcSJUAEptZ9lLjOB2WvCVyHp9EZFU4e
	GDi2aj0OA8UBvqnGetPAxLYx0fyg1BqyszU3sarw87cgpZ9dw5F+wDK4awRFhy3WPqhG7g0nnmD
	R8Q38X/07ddQ+mljuRPBUVNj2NQPCgFwHz5232aUWu/RZghtlKfOL2VDc4Qobf6uk=
X-Received: by 2002:a05:6820:1608:b0:6a0:b54b:a1ef with SMTP id 006d021491bc7-6a13517f731mr8946039eaf.11.1782595473208;
        Sat, 27 Jun 2026 14:24:33 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:f242:ecd6:f61e:d764? ([2600:8803:e7e4:500:f242:ecd6:f61e:d764])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4487291914asm1472012fac.7.2026.06.27.14.24.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Jun 2026 14:24:32 -0700 (PDT)
Message-ID: <9c6e0a74-c9c5-43ee-8eca-ae1667c51c32@baylibre.com>
Date: Sat, 27 Jun 2026 16:24:31 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/4] iio: adc: ltc2378: Add support for LTC2378-20 and
 similar ADCs
To: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: jic23@kernel.org, nuno.sa@analog.com, Michael.Hennerich@analog.com,
 andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 julianbraha@gmail.com, marcelo.schmitt1@gmail.com
References: <cover.1782397418.git.marcelo.schmitt@analog.com>
 <0abf862eeb277ae82262d09b11b1446f04c47be7.1782397418.git.marcelo.schmitt@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <0abf862eeb277ae82262d09b11b1446f04c47be7.1782397418.git.marcelo.schmitt@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/25/26 9:35 AM, Marcelo Schmitt wrote:
> Support for LTC2378-20 and similar analog-to-digital converters.

This should mention that it contains some future prep for offloading.
(Although would be a bit easier to review if we deferred adding the
offload stuff).

> 
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> ---
> Change log v3 -> v4:
> - Reworked the driver to make IIO channels static according to v3 feedback.
> - Updated to use default 8 bits_per_word for non-offloaded transfers.
> - Handled refin voltage reference supply for LTC2338.
> - Used spi_bpw_to_bytes() where applicable.
> 
>  MAINTAINERS               |   1 +
>  drivers/iio/adc/Kconfig   |  12 ++
>  drivers/iio/adc/Makefile  |   1 +
>  drivers/iio/adc/ltc2378.c | 395 ++++++++++++++++++++++++++++++++++++++
>  4 files changed, 409 insertions(+)
>  create mode 100644 drivers/iio/adc/ltc2378.c
> 

...

> diff --git a/drivers/iio/adc/ltc2378.c b/drivers/iio/adc/ltc2378.c
> new file mode 100644
> index 000000000000..9a9f32e4989b
> --- /dev/null
> +++ b/drivers/iio/adc/ltc2378.c
> @@ -0,0 +1,395 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Analog Devices LTC2378 ADC series driver
> + *
> + * Copyright (C) 2026 Analog Devices Inc.
> + * Author: Marcelo Schmitt <marcelo.schmitt@analog.com>
> + */
> +
> +#include <linux/bitops.h>
> +#include <linux/bits.h>
> +#include <linux/cleanup.h>
> +#include <linux/delay.h>
> +#include <linux/err.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/spi/spi.h>
> +#include <linux/types.h>
> +#include <linux/units.h>
> +
> +#include <linux/iio/iio.h>
> +#include <linux/iio/types.h>
> +
> +#define __LTC2378_DIFF_CHANNEL(_sign, _real_bits, _storage_bits, _offl)\

Why the leading underscores? I don't see a conflicting name.

> +{										\
> +	.type = IIO_VOLTAGE,							\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |				\
> +			      BIT(IIO_CHAN_INFO_SCALE) |			\
> +			      (_offl ? BIT(IIO_CHAN_INFO_SAMP_FREQ) : 0),	\
> +	.info_mask_separate_available = _offl ? BIT(IIO_CHAN_INFO_SAMP_FREQ) : 0,\
> +	.scan_index = 0,							\
> +	.scan_type = {								\
> +		.format = _sign ? IIO_SCAN_FORMAT_SIGNED_INT :			\
> +				  IIO_SCAN_FORMAT_UNSIGNED_INT,			\
> +		.realbits = _real_bits,						\
> +		.storagebits = _storage_bits,					\
> +		.shift = (_offl ? 0 : _storage_bits - _real_bits),		\
> +		.endianness = _offl ? IIO_CPU : IIO_BE				\
> +	},									\
> +}
> +
> +#define LTC2378_BIPOLAR_DIFF_CHANNEL(_real_bits)				\
> +	__LTC2378_DIFF_CHANNEL(1, _real_bits, (((_real_bits) > 16) ? 32 : 16), 0)
> +
> +#define LTC2378_UNIPOLAR_DIFF_CHANNEL(_real_bits)				\
> +	__LTC2378_DIFF_CHANNEL(0, _real_bits, (((_real_bits) > 16) ? 32 : 16), 0)

Why not move the (((_real_bits) > 16) ? 32 : 16) into the __LTC2378_DIFF_CHANNEL()
macro to avoid repeating it?

> +
> +struct ltc2378_chip_info {
> +	const char *name;
> +	unsigned int internal_ref_uv;

_uV (to be consistent)

> +	struct iio_chan_spec chan;
> +};
> +

...

> +static int ltc2378_regulator_setup(struct device *dev, struct ltc2378_state *st)
> +{
> +	int ret;
> +
> +	ret = devm_regulator_get_enable_read_voltage(dev, "refin");
> +	if (ret < 0 && ret != -ENODEV) {
> +		return dev_err_probe(dev, ret, "failed to read refin regulator\n");
> +	} else if (ret > 0) {

Else is not needed here.

> +		st->ref_uV = ret;
> +		return 0;
> +	}
> +
> +	if (st->info->internal_ref_uv) {
> +		st->ref_uV = st->info->internal_ref_uv;
> +		return 0;
> +	}

I would be tempted to have two separate functions here and only call one depending
on the chip. Otherwise, it allows incorrect devicetree.

> +
> +	ret = devm_regulator_get_enable_read_voltage(dev, "ref");
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "failed to read ref regulator\n");
> +
> +	st->ref_uV = ret;
> +
> +	return 0;
> +}
> +
