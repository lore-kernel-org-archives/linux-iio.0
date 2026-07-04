Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6097F3A7D9E;
	Sat,  4 Jul 2026 23:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783208644; cv=none; b=UCmC4HXissZLbpquTMpag4C2RHNGmiPr/cW85FrhNBvrOoCXyxImJv0RZNbrlPyveMYX67gXE/gE5iGxPO3nNRqHPlcyv2iuIwSeTdMJC2loo5Ev8O3yMsTi6mwAOb4wlsAdhPeMonZ4IJ/KuZgzDcbYCOk7RMV77OD81Bx+Eyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783208644; c=relaxed/simple;
	bh=c4O4KyNMRxE0+hVBrYSk/+QOj9L35Rzg8EjDgYOLo64=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SAW0ymvuy3zwMBmWpI7TjsmrEPlK0SkMY1EafFcZt65CoKRDZ3zobs4JnkMcb9x6FA3UgCCtz5dGT+9hj8iIHohIYe20bJJpI55CT26A1dJ/VJ0cLUPrsHl1r7ShW9WvjOwutlD/hQoKewNEsBhvFRmWLoAJruz5B8IqQPwgoco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jLsEKwaN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jLsEKwaN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76E301F000E9;
	Sat,  4 Jul 2026 23:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783208643;
	bh=8Kb6ZRbp6rmJhiqr4hN3r5nXzNVI9x8m2BBe4AUFbns=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=jLsEKwaNZdmmIe7L+gj9JXb4+0xHxG/czIlcIWGpbEa4A4U0Qm68SvwefxAAkJo+Y
	 HMZPXYPKIqLrRThCEHFC1SiFtVLXgRJJNR2r9NJYyC+zQDYYQfX0ONLSQJzN3jJwiN
	 m8U5QA5hSleWs1gkqmOoqoVfwijIX0QHhqRtAjVB1wmNQlpV0MTFdT4PhkvpkDHigM
	 bntSEkylx9mD/wnFTHFSi7VQvOFGYYZnOMKO3/tokZGQGvf38h7Rm5lswzr28GTZnF
	 kHCME4UssGDAkHbw8F3dUw/E+yLTLPIzrvHmBPMi9Wrh4ZuP/bQIGCpBj5ld6hDXdJ
	 2VIdPnM2YHxsQ==
Date: Sun, 5 Jul 2026 00:43:57 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <nuno.sa@analog.com>,
 <Michael.Hennerich@analog.com>, <dlechner@baylibre.com>, <andy@kernel.org>,
 <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
 <julianbraha@gmail.com>, <marcelo.schmitt1@gmail.com>
Subject: Re: [PATCH v5 2/4] iio: adc: ltc2378: Add support for LTC2378-20
 and similar ADCs
Message-ID: <20260705004357.6f3e8157@jic23-huawei>
In-Reply-To: <724f2408cb84bf4546115408fc9857777e6f2fd7.1783028033.git.marcelo.schmitt@analog.com>
References: <cover.1783028033.git.marcelo.schmitt@analog.com>
	<724f2408cb84bf4546115408fc9857777e6f2fd7.1783028033.git.marcelo.schmitt@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 2 Jul 2026 18:45:27 -0300
Marcelo Schmitt <marcelo.schmitt@analog.com> wrote:

> Support for LTC2378-20 and similar analog-to-digital converters.
> 
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
Just a couple of trivial additional comments as you are spinning
again anyway.

> diff --git a/drivers/iio/adc/ltc2378.c b/drivers/iio/adc/ltc2378.c
> new file mode 100644
> index 000000000000..b5cf2e974dac
> --- /dev/null
> +++ b/drivers/iio/adc/ltc2378.c
> @@ -0,0 +1,404 @@
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

Drop this one. Uwe just had a series merged that moved
the relevant include path into spi/spi.h 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/diff/include/linux/spi/spi.h?id=ecca1d63c1eadbbb38ceab82de0f7adfbc2b465d

I'll probably rebase the iio tree on rc2 or merge that in
to resolve any conflicts.

> +#include <linux/module.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/spi/spi.h>
> +#include <linux/types.h>
> +#include <linux/units.h>
> +
> +#include <linux/iio/iio.h>
> +#include <linux/iio/types.h>

We had some discussion about this recently and IIRC concluded that types.h will
always be included by iio.h so maybe just iio.h is enough.
I don't care strongly either way though.

> +
> +static int ltc2378_channel_single_read(const struct iio_chan_spec *chan,
> +				       struct ltc2378_state *st, int *val)
> +{
> +	const struct iio_scan_type *scan_type = &chan->scan_type;
> +	u32 sample;
> +	int ret;
> +
> +	ret = ltc2378_convert_and_acquire(st);
> +	if (ret)
> +		return ret;
> +
> +	if (chan->scan_type.endianness == IIO_BE) {
> +		if (chan->scan_type.realbits > 16)
> +			sample = be32_to_cpu(st->scan.data.sample_buf32_be);
> +		else
> +			sample = be16_to_cpu(st->scan.data.sample_buf16_be);
> +	} else {

Trivial but can we have a /* IIO_CPU */ for this else.
I briefly wondered why for little endian we didn't need to use lexx_to_cpu()
before registering this is for offload where the spi controller is dealing
with it (and hence IIO_CPU for the endian)


> +		if (chan->scan_type.realbits > 16)
> +			sample = st->scan.data.sample_buf32;
> +		else
> +			sample = st->scan.data.sample_buf16;
> +	}
> +
> +	sample >>= chan->scan_type.shift;
> +
> +	if (scan_type->format == IIO_SCAN_FORMAT_SIGNED_INT)
> +		*val = sign_extend32(sample, scan_type->realbits - 1);
> +	else
> +		*val = sample;
> +
> +	return 0;
> +}
