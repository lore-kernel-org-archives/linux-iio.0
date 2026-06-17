Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3801C3783DE
	for <linux-iio@vger.kernel.org>; Wed, 17 Jun 2026 22:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781735591; cv=none; b=S2f4iMoAWNezD4Cz5F/KIyYi34J3yehYQdlx4+e44Ez4RzPn2n0NdBKbTape68u0y2oQhvGYum85CF19Y4L51YfsLmo7FiSQqRAGzS7TV7ZO4Mdm5IRF61Sha+N8FCtvlr8OoRUOiYCYXJXA4mv+X1MUT4RnMpTHndbSgt9EoGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781735591; c=relaxed/simple;
	bh=7XyKUNIOL46jZur+YvXtih0JCTOGsfPQw2wktLsAwsU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X/Rz0FI35FMeXrEMeLFFjs2iwBn1t2J8W/VybsR/2m2sOyK7uODIZtfr89s+d02jzMhKK6dQQ4MGVm9jQbJwTADtufdQxpvOHPsTJxFZLvg1CvoNbeHpI2S/5kud+QoFfBmI3QyUfGqg5RTx/NCEX9XS77XPbzUdFCcGW5TzH6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=J5w9Otzl; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="J5w9Otzl"
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-43cce34c881so189965fac.2
        for <linux-iio@vger.kernel.org>; Wed, 17 Jun 2026 15:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1781735588; x=1782340388; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w3NNNLn3FzT6ruT5UBTY8dZFvASj4Gla53dS/0lXbqE=;
        b=J5w9OtzlcRAI6NCAwROEIOE4GpSq2dwHFIVVDmLKYlmP2ojhN4yezW1AR1xli6prVo
         XsdyCp/d/BT5YdS8o65ZMZkYPGE0rcH5VG24FTG6p57tkkCUvkn0TJZ6RcjB7FgFjI+s
         hTYTOUNXqvF1/pnHkIL0M+TH1HgMie0B4gWmJs4v+U9MYZTs1CaKE9K4TPueMH6McV9T
         7tvtwW0I25zSdHaLQ28+W3SGQhCq1ETqp86AbGUcU9vUprJXUY+8NvLgrfNNv7T1nsWn
         VAN601uG/6y0pjlvyV+grd9RUdTQh+Jru/w8HauTEwd9YQDs0AJ2m0PGVOfxR3f2dYGK
         /eLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781735588; x=1782340388;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w3NNNLn3FzT6ruT5UBTY8dZFvASj4Gla53dS/0lXbqE=;
        b=p5AsLpPq4PZ37odbDhDHIITn+4NYjSOfEmC593DzmoYMBIQlxJuX6IPApbHLPVfUfw
         BT7Md/0DTOErU3+Mfh+9h8LEil57vvfnYRvRZWuJiDwVoFc5F5q8lEq0ljlZT0plkbdu
         Es3JJs1RZGBRhlxn73yaZBpfsuu06aepczm5zcEa8+P5SesW7SRUUfT1JZ11Gr90p+QI
         eF005otYDJrjP+9rGm6aGaJ9Vi7Wz0Sk0F+MqZ9yRN3LaDT9kWoRgb80v/4zlIz3xCnn
         3iKDC6iByoh83rlz3pDBRM8iYEcXIbHxroOcl6Ba4vEdKeSpWVJK+ZXCmWYVae+NQ5/q
         o2WQ==
X-Forwarded-Encrypted: i=1; AFNElJ/gTKppjHpwvOB3O4oOQnhhX9j7tN8wF68/OQyVYv0eVvbkIV0Xcyha8A67MGpUVD8wBm2c3KKP1/g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUVN3sRWgjGDQ2JIrViPrnPakhOQLTDNfaV7UFdvJjT4R3gTSV
	cd4lO6ncqN35tybjwdVBmIbhyDBnCUIulpmWRUHli+YZ/AokXuXUEj0OC+cuLw0nkZ4=
X-Gm-Gg: Acq92OF7P5mhOlew0qVjA8P+WMzweWEzilzBAgZteBE1Q4nyoPKn8qX0z+EQ2dBg/z7
	6YOxvvXNeSj9gg2mL7gTb5AZ8FiYz63UZIQumG9E187gLqNEee0CXrNivHTMco+5U0IdEn9Lb7K
	e5va37CJHuYpSkifocfD6DDynNB9ylsKeNdb/oXazf+wEVHsO5xg+XQkBcD/Eq/IKHzmZ5w6xLi
	wU+lNW6jSZjhc9v4hZc6z65U8KIZQht3sUvFljasLvo9H2JvzoJ7EsdZxz88u8ySS3l9MBkP2oB
	6rRVTmTii0qsYdsiDtjBS7XI7OiC6qR111KJDnt+r7rzRwscV7//FceCPsTl7tHZHQ/lY5t33h6
	aT6L02M8rp2MuBsTT1n6bzVTWrviRz8xPhBMwycBzd9vw2Wk63FD0f+lFLF8yXRjO6OT6fgZWhM
	Vrq2SP4oMJph+AmTeRpIhIXmHGr0MXdxcRfQ3oZWAAXtHQzy4k2MmVFGzxA877lCw=
X-Received: by 2002:a05:6870:31ab:b0:442:87b:c83 with SMTP id 586e51a60fabf-4469041bcd2mr4724545fac.22.1781735588136;
        Wed, 17 Jun 2026 15:33:08 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:9458:d356:778c:22ac? ([2600:8803:e7e4:500:9458:d356:778c:22ac])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-44308f09405sm5253268fac.12.2026.06.17.15.33.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jun 2026 15:33:07 -0700 (PDT)
Message-ID: <3787d23b-6dd8-4e89-9a03-c3fddbbe8bf8@baylibre.com>
Date: Wed, 17 Jun 2026 17:33:06 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/5] iio: adc: ltc2378: Enable high-speed data capture
To: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: jic23@kernel.org, nuno.sa@analog.com, Michael.Hennerich@analog.com,
 andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 pop.ioan-daniel@analog.com, marcelo.schmitt1@gmail.com
References: <cover.1781661028.git.marcelo.schmitt@analog.com>
 <9f173c47928446aa3e900cf0becb6130dd76846b.1781661028.git.marcelo.schmitt@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <9f173c47928446aa3e900cf0becb6130dd76846b.1781661028.git.marcelo.schmitt@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/16/26 9:04 PM, Marcelo Schmitt wrote:
> Make use of SPI transfer offloading to speed up data capture, enabling data
> acquisition at faster sample rates (up to 2 MSPS).
> 
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> ---
> Change log v2 -> v3:
> - Fixed the evaluation loop conditions for CNV PWM and SPI Engine trigger PWM,
>   avoiding potential infinite loop if and CPU stall.
> - Added comment to about initial PWM disable.
> - Adjusted SPI offload setup initialization to not print error on a valid condition.
> - Fully initialize IIO channel scan_type.
> - Reworked to make offload support not imply all dependencies to be built in.
> - Made sampling_frequency a buffer attribute.
> - Made offload support not require DMA and other features to be built in.
> - Now using same scan_type configuration for all use cases.
> 
>  drivers/iio/adc/Kconfig                  |  19 ++
>  drivers/iio/adc/Makefile                 |   6 +
>  drivers/iio/adc/ltc2378-lib-core.c       |  35 +++
>  drivers/iio/adc/ltc2378-offload-buffer.c | 305 +++++++++++++++++++++++
>  drivers/iio/adc/ltc2378.c                |  46 ++++
>  drivers/iio/adc/ltc2378.h                |  42 ++++
>  6 files changed, 453 insertions(+)
>  create mode 100644 drivers/iio/adc/ltc2378-lib-core.c
>  create mode 100644 drivers/iio/adc/ltc2378-offload-buffer.c
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 2b8203451367..f96d9262b891 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -944,6 +944,9 @@ config LTC2378
>  	tristate "Analog Devices LTC2378 ADC driver"
>  	depends on SPI
>  	depends on GPIOLIB
> +	select LTC2378_LIB
> +	select LTC2378_LIB_OFFLOAD_BUFFER if SPI_OFFLOAD && PWM && SPI_OFFLOAD_TRIGGER_PWM && IIO_BUFFER && IIO_BUFFER_DMAENGINE
> +	select LTC2378_LIB_TRIGGERED_BUFFER if IIO_BUFFER
>  	help
>  	  Say yes here to build support for Analog Devices LTC2378-20 and
>  	  similar analog to digital converters.
> @@ -2027,3 +2030,19 @@ config XILINX_AMS
>  	  xilinx-ams.
>  
>  endmenu
> +
> +config LTC2378_LIB
> +	tristate
> +	help
> +	  Say yes here to build support for buffered data capture with LTC2378
> +
> +config LTC2378_LIB_OFFLOAD_BUFFER
> +	bool
> +	help
> +	  Say yes here to build support for high speed data capture with LTC2378
> +
> +config LTC2378_LIB_TRIGGERED_BUFFER
> +	bool
> +	select IIO_TRIGGERED_BUFFER
> +	help

Why do these need to be compile-time options to only select one or the other?
In all other SPI offload ADCs we've done so far, they always support both and
gets selected at runtime based on devicetree config.

> +	  Say yes here to build support for buffered data capture with LTC2378
> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> index 1814fb78dde3..109cd39237c9 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -82,6 +82,12 @@ obj-$(CONFIG_LPC18XX_ADC) += lpc18xx_adc.o
>  obj-$(CONFIG_LPC32XX_ADC) += lpc32xx_adc.o
>  obj-$(CONFIG_LTC2309) += ltc2309.o
>  obj-$(CONFIG_LTC2378) += ltc2378.o
> +
> +ltc2378_lib-y += ltc2378-lib-core.o
> +ltc2378_lib-$(CONFIG_LTC2378_LIB_OFFLOAD_BUFFER) += ltc2378-offload-buffer.o
> +ltc2378_lib-$(CONFIG_LTC2378_LIB_TRIGGERED_BUFFER) += ltc2378-triggered-buffer.o
> +obj-$(CONFIG_LTC2378_LIB) += ltc2378_lib.o

Why do these need to be split into separate files? The driver isn't that
long, so seems better to just do it all in one file to make it easier to
read.

> +
>  obj-$(CONFIG_LTC2471) += ltc2471.o
>  obj-$(CONFIG_LTC2485) += ltc2485.o
>  obj-$(CONFIG_LTC2496) += ltc2496.o ltc2497-core.o
> diff --git a/drivers/iio/adc/ltc2378-lib-core.c b/drivers/iio/adc/ltc2378-lib-core.c
> new file mode 100644
> index 000000000000..1160f4324d01
> --- /dev/null
> +++ b/drivers/iio/adc/ltc2378-lib-core.c
> @@ -0,0 +1,35 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Analog Devices LTC2378 ADC series driver
> + *
> + * Copyright (C) 2026 Analog Devices Inc.
> + * Author: Marcelo Schmitt <marcelo.schmitt@analog.com>
> + */
> +
> +#include <linux/err.h>
> +#include <linux/iio/iio.h>
> +
> +#include "ltc2378.h"
> +
> +int ltc2378_lib_buffer_setup(struct iio_dev *indio_dev, struct ltc2378_state *st)
> +{
> +	struct device *dev = &st->spi->dev;
> +	int ret;
> +
> +	ret = __ltc2378_set_offload_ops(st);
> +	if (ret == -EOPNOTSUPP)
> +		return 0; /* Let device setup complete without buffer support */
> +
> +	if (!ret)
> +		ret = st->ops->buffer_setup(indio_dev, st);
> +
> +	if (ret)
> +		return dev_err_probe(dev, ret, "error on SPI offload setup\n");

Would be better to just return early instead of doing the !ret check.

> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(ltc2378_lib_buffer_setup, "IIO_LTC2378");
> +

...

> diff --git a/drivers/iio/adc/ltc2378.c b/drivers/iio/adc/ltc2378.c
> index 88582bdcd6a6..bf17b202230b 100644
> --- a/drivers/iio/adc/ltc2378.c
> +++ b/drivers/iio/adc/ltc2378.c
> @@ -17,6 +17,7 @@
>  #include <linux/regulator/consumer.h>
>  #include <linux/spi/spi.h>
>  #include <linux/types.h>
> +#include <linux/units.h>
>  
>  #include <linux/iio/iio.h>
>  #include <linux/iio/types.h>
> @@ -26,120 +27,160 @@
>  static const struct ltc2378_chip_info ltc2338_18_chip_info = {
>  	.name = "ltc2338-18",
>  	.resolution = 18,
> +	.max_sample_rate_hz = HZ_PER_MHZ,

1 * HZ_PER_MHZ would make a bit more sense

> +	.tconv_ns = 527,
>  	.bipolar = true,
>  };
>  


