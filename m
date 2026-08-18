Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BFF147F2E1;
	Tue, 18 Aug 2026 16:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787071100; cv=none; b=h9mXNgI28slE0YuP5Soa8Fd+qF7KXGRSG4DMk/qnTq1jmDytpcXtpYALseYc1hdaXvvaIlS0g8LR1SBFcpdBcn7jknRKshMM94XuV6nE3jSgZ2qqPvktQn9Z2eIxCJoqnqPmkWpYeYyU8uPjHCtJtZLk+3UheF0Sq9xSw6VE8nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787071100; c=relaxed/simple;
	bh=Pir/9iu4vrrOZSRmeQ9oxLSlxsN/3ktKzgfRYMC9ug4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HGAJIC0F82vze4E/DUz+n1lmT/LIkFjkkhppAHEu/qqDv4ZMTUeqFfXrVbeMnPQ9gfGdjZE14GOI1EB7gAnnL5tgXC22BpAo4KtUmrJS2LIPfluyiY21Agi25gJxGNmeJMNpTrte+LAiAmhTm6l8lyYLN0PCysCXxlU02KU4mBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dZRwzbr/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dZRwzbr/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F1B71F000E9;
	Tue, 18 Aug 2026 16:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787071098;
	bh=z1NUCSnANL+DoYXEy1Eg4Lj1F5LfC/BGvmV+DHJkSbc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=dZRwzbr/C3Yj2NoyC8oIZdZmX8VZvuCiCz8IQo4RIUhAoEIeXzf7LOgtD3OmASlOo
	 Oa4N5ZNlwKEXDfPM695kObIif6Y6KwT8KnF50sQ1qxxpk8Nr9s6XTezPd991DT9wsk
	 G1kcpQnLqCj7wcIyXJx+7Y82WKL6bhgDWdKLO2au9W0E2FJIRvilidTLNM9fbaWLjq
	 XqN2wDrqpeu0AdciE6cUdkzbxSkz1igrDM3amLjpgPfQlqopLrXGP4OQ7KH/XKvAzv
	 xpnV6jAn1ktLF1V0D3Dgw3hj+1bVO9zHxKnnnSEiFiEm+PQe9qK7QKsrlT+o2t/0TS
	 wL9zXbYoK5fNA==
Date: Tue, 18 Aug 2026 17:38:09 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Stefan Popa <stefan.popa@analog.com>
Cc: <linux-iio@vger.kernel.org>, <lars@metafoo.de>,
 <Michael.Hennerich@analog.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
 <conor+dt@kernel.org>, <andy@kernel.org>, <dlechner@baylibre.com>,
 <nuno.sa@analog.com>, <siratul.islam@linux.dev>,
 <u.kleine-koenig@baylibre.com>, <linux@roeck-us.net>,
 <joshua.crofts1@gmail.com>, <ciprian.hegbeli@analog.com>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 2/2] iio: adc: add MAX40080 current-sense amplifier
 driver
Message-ID: <20260818173809.76a05ac4@jic23-huawei>
In-Reply-To: <20260818142928.8244-3-stefan.popa@analog.com>
References: <20260818142928.8244-1-stefan.popa@analog.com>
	<20260818142928.8244-3-stefan.popa@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Aug 2026 17:29:28 +0300
Stefan Popa <stefan.popa@analog.com> wrote:

> The MAX40080 is a bidirectional current-sense amplifier with an
> integrated 12-bit ADC and an I2C/SMBus interface. It measures the
> voltage across an external shunt resistor and the input bus voltage,
> storing the results in an internal FIFO.
> 
> Add a direct-mode IIO driver exposing the current and voltage channels
> with raw, scale and hardware-gain attributes, a configurable
> oversampling (digital averaging) ratio, and PEC-protected register
> access. The current scale is derived from the shunt resistor value
> described in the device tree.
> 
> The driver operates in single-measurement mode: each raw read triggers
> an on-demand conversion via SMBus Quick Command and returns a matched
> current/voltage pair. This avoids the latency and complexity of the
> continuous FIFO mode while ensuring each read reflects the current
> state. The two selectable current-sense ranges are exposed through
> scale/scale_available.
> 
> Continuous FIFO buffering, threshold events and the alert interrupt are
> intentionally left out of this initial submission and may be added
> later.
https://sashiko.dev/#/patchset/20260818142928.8244-1-stefan.popa%40analog.com

The copy being optimized out is likely complier optimization so I think
sashiko is correct that you need READ_ONCE() (and probably the WRITE_ONCE()
as well)

> 
> Co-developed-by: Ciprian Hegbeli <ciprian.hegbeli@analog.com>
> Signed-off-by: Ciprian Hegbeli <ciprian.hegbeli@analog.com>
> Signed-off-by: Stefan Popa <stefan.popa@analog.com>
Otherwise, just trivial stuff from me.  Andy caught a lot more than me!

Given this seems to be coming to a point where it is ready to be applied
(hopefully v8) feel free to send a new version out in a day or two rather
than waiting a week.

Thanks

Jonathan

> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> index 7cc8f9a12f763..9245a337dd935 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -166,3 +166,4 @@ obj-$(CONFIG_VIPERBOARD_ADC) += viperboard_adc.o
>  obj-$(CONFIG_XILINX_AMS) += xilinx-ams.o
>  xilinx-xadc-y := xilinx-xadc-core.o xilinx-xadc-events.o
>  obj-$(CONFIG_XILINX_XADC) += xilinx-xadc.o
> +obj-$(CONFIG_MAX40080) += max40080.o
> diff --git a/drivers/iio/adc/max40080.c b/drivers/iio/adc/max40080.c
> new file mode 100644
> index 0000000000000..4b397bcd145b2
> --- /dev/null
> +++ b/drivers/iio/adc/max40080.c

> +/*
> + * Configure the device from the cached state. The device powers up in standby
> + * with PEC enabled (CFG POR = 0x0060), so PEC is kept enabled throughout.
> + */
> +static int max40080_init(struct max40080_state *st)
> +{
> +	u16 fifo_cfg, cfg;
> +	int ret, filter;
> +
> +	filter = max40080_oversampling_to_filter(st->oversampling_ratio);
> +	if (filter < 0)
> +		return filter;
> +
> +	/*
> +	 * Put the device in standby before (re)configuring the FIFO: the FIFO
> +	 * configuration register can only be written while the device is not
> +	 * converting.
> +	 */
> +	cfg = FIELD_PREP(MAX40080_CFG_MODE_MSK, MAX40080_CFG_MODE_STDBY) |
> +	      FIELD_PREP(MAX40080_CFG_PEC_EN_MSK, 1);
> +

As below.

> +	ret = i2c_smbus_write_word_data(st->client, MAX40080_REG_CFG, cfg);
> +	if (ret)
> +		return ret;
> +
> +	/* Store a matched current+voltage pair per conversion. */
> +	fifo_cfg = FIELD_PREP(MAX40080_FIFO_CFG_STORE_IV_MSK, MAX40080_FIFO_CFG_STORE_IV);
> +

Where you have pairs like this of setting local and using it, drop the blank line.
We want those to be visually closely coupled.

> +	ret = i2c_smbus_write_word_data(st->client, MAX40080_REG_FIFO_CFG,
> +					fifo_cfg);
> +	if (ret)
> +		return ret;
