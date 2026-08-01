Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF0D3A5452;
	Sat,  1 Aug 2026 02:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785551478; cv=none; b=FA48zaRU1broqLrwGVrZGxkncE0WLGno0yCT0kEsC2zZ3ReaurnSgFnCmv/dpdm6DJ3oZj9uroTM8u5Ca9f4azyKsfmMqJ2J8r6xEZVgRc4KDlvQKuoZ05d+1Ym0wxV5wbbUJHK83qqHuiz1/t2bOH6uRHLh9STs9pI2bS2/TcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785551478; c=relaxed/simple;
	bh=6hJn9hyB2Ab/GtXT5mlDA97bIfaIE0YQnuIq+ACU+UI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EjUTN67H608XFUV5ucp/fmIV3E37chblOxf4iH8EABOWPuYNftO5qBqGfCDGpf5gV765FoZYJT9BSr1tYFC1Qfdi/NKeATO5tM5txBe2sZlG7iGykleoVIb58pUFYsrxQwW52t6lJ/paTKm8UdxGSbMOM0qR8Lxg4z4T7mQc6RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nTRM1Pwi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nTRM1Pwi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABC931F00AC4;
	Sat,  1 Aug 2026 02:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785551476;
	bh=uMiANvgoUOZB5Ic39C9vx3u15Hl4R58pnfusraQYRB4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=nTRM1Pwi/+Q8tslAMfl52eTxm5iZLLbgmzM3Uyqvo9waNHnaVdcHMSF21WGtS9+OT
	 qy47DxnoXpiGJslPQRKcrT9Jbo42jgYR1j0FtPjlgnFZoOtTBx5DLZHhnMjQ2X8jwh
	 K9T4P+fea0vTi5VYbFfmii/ltZfgOAk3gEZ9EV0YcLLhfpJc//GivIPpyQJ5803Lcc
	 +Zb+iVjmOe/lB/dXbtTOht2WDMpJUz0Dn+MLWu777Gk4gt7K5fjsoJEkx8C5NygzEn
	 s07lLpFxdjyNigZ6GYzZwjr0JjRVpcRleavEnQOPsUU72r1suj0U7GMQC8idgpBnh/
	 mu8Vju3YPR8uA==
Date: Sat, 1 Aug 2026 03:31:12 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: dac: mcp47a1: add support for new device
Message-ID: <20260801033112.43169ed1@jic23-huawei>
In-Reply-To: <20260727-mcp47a1-add-support-v2-2-d4591a2ce69e@gmail.com>
References: <20260727-mcp47a1-add-support-v2-0-d4591a2ce69e@gmail.com>
	<20260727-mcp47a1-add-support-v2-2-d4591a2ce69e@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


> diff --git a/drivers/iio/dac/mcp47a1.c b/drivers/iio/dac/mcp47a1.c
> new file mode 100644
> index 000000000000..140e93ff2ba0
> --- /dev/null
> +++ b/drivers/iio/dac/mcp47a1.c
> @@ -0,0 +1,169 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Microchip MCP47A1 DAC driver
> + *
> + * Copyright (c) 2026 Joshua Crofts <joshua.crofts1@gmail.com>
> + *
> + * Datasheet: https://ww1.microchip.com/downloads/aemDocuments/documents/OTH/ProductDocuments/DataSheets/25154A.pdf
> + */
> +
> +#include <linux/array_size.h>
> +#include <linux/delay.h>
> +#include <linux/err.h>
> +#include <linux/i2c.h>
> +#include <linux/module.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/types.h>
> +#include <linux/units.h>
> +
> +#include <linux/iio/iio.h>
> +
> +#define MCP47A1_REG_MAX		0x40
> +#define MCP47A1_CMD_CODE	0x00
> +#define MCP47A1_MAX_STEP	63
> +
> +struct mcp47a1_data {
> +	struct i2c_client *client;
> +	int vref_mV;
> +};
> +
> +static const int mcp47a1_raw_avail[] = { 0, 1, MCP47A1_MAX_STEP };
> +
> +static const struct iio_chan_spec mcp47a1_channels[] = {
> +	{
> +		.type = IIO_VOLTAGE,
> +		.indexed = 1,
> +		.output = 1,
> +		.channel = 0,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +		.info_mask_separate_available = BIT(IIO_CHAN_INFO_RAW),
> +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
> +	},

Given you are doing a v3 anyway, drop the array.  A single channel
is fine - just use &mc47a1_channel when referring to it and provide
channel count of 1 directly (obviously correct as it is clear you
aren't pointing to an array).

> +};
