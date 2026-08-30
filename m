Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC81F2DC32E;
	Sun, 30 Aug 2026 00:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788051140; cv=none; b=RrePdGuq1sQpNrCTq6CMRLPo9MTv8cohUgQ0UYSIFyb2NsFLeTNgdgLnlOD0mzb2wxONa7Xq6ImYoP5EaqFqshNP3czd21WedAzCMxOpqoVKElB+gJRWr2sideqfFOTY5zybJ3czoDd1jRTIiKXKbQwQ6qsUc19z+lznCxnGFHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788051140; c=relaxed/simple;
	bh=yrQ5q++ZAGDNzwmqvxQIXMeXVeqM1Yn1HrC46+NhYgM=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=lPE9M5wiAKLElci9HgOZB2zxTl6r7WCbjK1RlqnVHdFwGPB/qdmstCfu7CVv/0oAWwEh/5PTUkyZ6twu7idq1BFZIPGNFCWizSaHo8mOz7oNglESwlcs2vg5S6WhkY4/0A++9IGZxaKNV/D3GakMjKPHCalj1vzNFrP9Ug/YwGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WavyBIGO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WavyBIGO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A8571F00ACF;
	Sun, 30 Aug 2026 00:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788051138;
	bh=oK6s1ygpAgeTyn0Zin2Dw+abzUhUUbjUhSu0CAuOVzw=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=WavyBIGOU8gybBGm6yttYQEkZNPeqyFOWgnTGAvnqoYpoYXoFIZtIpwA3rVQdx2zc
	 CM6ir0oFL13JbWZJbc4HjQfN1MAvfgC1DTHRdzW1Co2tnz8ZX69Wb6Ig5cQLnZmDyB
	 YJyoXCklCyG0/OrhOqApij4U0Os3XHdd0oedk/Bt1epOMlKfa4srixFuiS5sJHYwrE
	 XfEj8EJRt7MAsUlTA2/JfAplmnscAiXAS53SrGe/Jji7qfwVIsw99srTRfP1jvHqqN
	 rKLv6nns2eYz38G2uXoKwzcdX8ahkzz0EgXI1sVH9+eoHVRXgMZHcNrFJB2LrGH0Lz
	 yt81paoosrwFA==
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v8 2/2] iio: adc: add MAX40080 current-sense amplifier
 driver
From: Jonathan Cameron <jic23@kernel.org>
To: Stefan Popa <stefan.popa@analog.com>
Cc: linux-iio@vger.kernel.org, jic23@kernel.org, lars@metafoo.de, 
 Michael.Hennerich@analog.com, robh@kernel.org, krzk+dt@kernel.org, 
 conor+dt@kernel.org, andy@kernel.org, dlechner@baylibre.com, 
 nuno.sa@analog.com, siratul.islam@linux.dev, u.kleine-koenig@baylibre.com, 
 linux@roeck-us.net, joshua.crofts1@gmail.com, ciprian.hegbeli@analog.com, 
 krzysztof.kozlowski@oss.qualcomm.com, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260828083119.54495-3-stefan.popa@analog.com>
References: <20260828083119.54495-1-stefan.popa@analog.com>
 <20260828083119.54495-3-stefan.popa@analog.com>
Date: Sun, 30 Aug 2026 01:51:39 +0100
Message-Id: <178805109907.2786293.4089810271829907624.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2745;
 i=jonathan.cameron@oss.qualcomm.com; h=from:subject:message-id;
 bh=yrQ5q++ZAGDNzwmqvxQIXMeXVeqM1Yn1HrC46+NhYgM=;
 b=owEBfwKA/ZANAwAKAVSFNJnE9BaIAcsmYgBqk36+PlZR8ZKGWXJdVrrqV2OFXJ/E9aJE4dDFO
 UCxAbFwwk2JAkUEAAEKAC8WIQRuKWazh4QGUpEmgbFUhTSZxPQWiAUCapN+vhEcamljMjNAa2Vy
 bmVsLm9yZwAKCRBUhTSZxPQWiOHJD/9HVU+MnvDze6ir/eOThXu3rUxlJBSEgcOddecujzSsvk8
 V5evr7FwHdkeIXDjUAiLcjg35Mk9RE+hsD0fb8txBXEbl6LxOvBPyPqLBobEapiXD33OrjvshvM
 lnnh4Uhm+MGRHQpoJpcXyyRwQePIoQdzYRntyNkaMqeIhrsRvvBZ2U+wlGZKQ6WCMdcZYXS9CB7
 howGg08kHe0OkSVrMkU3B3uU+WqDK7udRixsmi8dxmpPhAGso7KopzQlnsfiiBZLv/DaEhR7emI
 s3sI0zE57rNH9vAfHtqQ9/wzB8YxwokQvhCUB978T7MHNXUYUqW0ARh9djDVI6CwsYWKsUWoK1W
 aJUJ6j5umBdL1vNmuQ7onyiFObXh31tU13kg3DmfwgmKepSElMRYn1lbgAktaslAiuwb74nIlQ4
 avjRN9vUANrwUzahK7KrM1pQaSHIe5xdVk4TJ0Nyu9IEEBmm8TxIqwKLHE82ru/sllXiIIRXIaJ
 4Kmh4jho4xFi3ZR1CfWk4omexSTZv95oE5DOb9xCP8HjtdLHOUxhJa6e4oIHbAHr1S3lNgQlpTV
 Av72tC2aYa9sYUGRNcxw5rdOh3SlYHh8E1Xr2o8ZLEEXV1jubDAs9wQQq5EJVYxVrgpzd/796dm
 UIbsoP7e4F9dYaCGDaPfzr0MsxlAp6vvk6di+0Q==
X-Developer-Key: i=jonathan.cameron@oss.qualcomm.com; a=openpgp;
 fpr=6E2966B387840652912681B154853499C4F41688

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
> 
> Co-developed-by: Ciprian Hegbeli <ciprian.hegbeli@analog.com>
> Signed-off-by: Ciprian Hegbeli <ciprian.hegbeli@analog.com>
> Signed-off-by: Stefan Popa <stefan.popa@analog.com>
> Reviewed-by: Siratul Islam <siratul.islam@linux.dev>

One thing inline

> diff --git a/drivers/iio/adc/max40080.c b/drivers/iio/adc/max40080.c
> new file mode 100644
> index 000000000000..1a6568eabcaa
> --- /dev/null
> +++ b/drivers/iio/adc/max40080.c

> +/*
> + * A single measurement holds the matched current/voltage pair in one 32-bit
> + * word (MAX40080_REG_IV). Reading all four bytes in one transaction returns
> + * both from the same conversion; reading the separate current (0x0C) and
> + * voltage (0x0E) registers would decorrelate the two channels.
> + *
> + * Unlike the word accesses used elsewhere, this is a plain I2C block read: the
> + * SMBus layer does not append or verify a PEC byte for it even when PEC is
> + * otherwise enabled for the device, so this transfer is not PEC protected.
> + */
> +static int max40080_read_iv_once(struct max40080_state *st, u32 *iv)
> +{
> +	__le32 buf;

Whilst it is vanishingly unlikely we'd get a short read, setting
buf = 0; will keep the checkers happy. Sashiko did comment on this
again and I changed my mind a bit on whether we care about that warning.

> +	int ret;
> +
> +	ret = i2c_smbus_read_i2c_block_data(st->client, MAX40080_REG_IV,
> +					    sizeof(buf), (u8 *)&buf);
> +	if (ret < 0)
> +		return ret;
> +
> +	*iv = le32_to_cpu(buf);
> +
> +	return 0;
> +}

Jonathan

-- 
Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
