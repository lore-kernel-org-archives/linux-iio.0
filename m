Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0BF3B895A;
	Fri,  4 Sep 2026 23:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788563389; cv=none; b=fZK3O8vLEbtMCHiFOR6W/G5rIDpUTa26Bl+WlHkxeemN71YPOw4KNHTDJM1RY/a6c735S5QANpWMRNagbSN8uVZtxiHOAqpYapwcekUxqkBnE51WVXQdPU/ncy5B3EYXrVl3GzKOIrL4yJL3P56sQMuz5FdrNzJUjzWLm6glP5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788563389; c=relaxed/simple;
	bh=VEexMFB9svsjyiRZYIMYXyrvA36MCNbOR3Op8eAcRDc=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=iS7saDs7ophgfcwFbT+6/MUmBLV12nbjaLrmdX12TcqBMD4dEFke2h7VlWK7zK2WMP+sEkz3iY9ayllUk9EG8PM3N2Xj445PJP7e2+mh0ZtoWS6DgMMZOqUQ703b1dvatH5E8ua8ZtKIbxhrKce+/qL+MJ+bxFaGOGBpieOPSK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XQXnHi1K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XQXnHi1K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91E461F00A3E;
	Fri,  4 Sep 2026 23:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788563387;
	bh=b3izwUxoLcXRrk+dHR3h+TrOr9Oex56Yt2lq9rpcabk=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=XQXnHi1KpnWP2SiEawlhlyAT510B3cvwWFl1l23RlaV1aZ/qXAjzGH2J4yZuSkBna
	 L2p218wHd0PXIc4x5DaSq0fZ84liVfHEFzUqe5Buel8arWwTbypnqEcvN+NadPFDjW
	 CUdeyw5pGcJXfnUJ4BWJsgSYI6WrUaXGYx1JSAYcnFmBv4vSZH0CiEJLhUP+HXNQCj
	 B+Er5N0GF2k3PhBB6YFEjkLfwzSVLr0R4KJ+S0BVUGH8A4hl09zrMR+7otlIT5lsgO
	 WswoDa8Nb+CtnFZFl0MOz0+hwDn3Fx1cnMBZB2MC6CyUzMsCJLvYzy1ZP6mT4aL3Vf
	 xFdPOJpP3fbUQ==
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v9 2/2] iio: adc: add MAX40080 current-sense amplifier
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
In-Reply-To: <20260831134334.196359-3-stefan.popa@analog.com>
References: <20260831134334.196359-1-stefan.popa@analog.com>
 <20260831134334.196359-3-stefan.popa@analog.com>
Date: Sat, 05 Sep 2026 00:09:25 +0100
Message-Id: <178856336528.3402141.14990070299510613675.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3260;
 i=jonathan.cameron@oss.qualcomm.com; h=from:subject:message-id;
 bh=VEexMFB9svsjyiRZYIMYXyrvA36MCNbOR3Op8eAcRDc=;
 b=owEBfwKA/ZANAwAKAVSFNJnE9BaIAcsmYgBqm0+22xhnbbpVtHz8aGPtXRaL0FjPDnfMJZKSE
 f3laV6/CgCJAkUEAAEKAC8WIQRuKWazh4QGUpEmgbFUhTSZxPQWiAUCaptPthEcamljMjNAa2Vy
 bmVsLm9yZwAKCRBUhTSZxPQWiEm8EACUo8GrgORo+/7yni3Kc/bp3Uqz3L7dCE9eUn+FzpUnw4B
 h3P40YPcWjrqYUp48p9aRs27F0/CJdJvMurwKIVdAVhiX5POgWCyEDpTOXZTdwDF02KiEMGGCge
 HqY80j0+uY+t+8int0v3ezZktyN5RNDYa26FAKLzrJY7OiI3nOkuyWrZy+hNZRE4opF37L24PgL
 6a0R6c3/rXuJjSOFH737i0ciyKTN4qqHwBPRleM8dFwQw97Fo8/mkCncpyQfkFrLbrKAQHu+1v/
 rgIfDFmjaBnot9RPcPE6SbNW7U190rXUkZstf9RkTxZ8IngivumdAGmY2ErqFUXgzzy9zlULPq2
 KCzJVg/9TeA/d+sBiM3Ect9XwlR6sfcZH2Wmr/iFhHnC9itioO0QJug90nGYNUZhYPT2smpfITe
 lbudfwGzkx8xAV0VzTz1Tg6XlrYZUhKMzwP21cwiWXpbvxBUVI7ucB+5YYYg1PLqn3tSbG70nff
 5vFbdT4kkriLsFT1K9MX8QVG5Ym4AzNjZ83w9eGH1i4XR6x/6DdP34jvV3zUPZMepSpRT2oQq8f
 Pq5OZQ9PCNPImS+RSx0TF4mPir5hdCchH3BFoZs//bA1xfmP9EgnJdOsLIRX5HVSBhbVSyLD23/
 2Y10qWfVaBoxF3ljbCpffMGnIgtGNJ4gin4Bvcg==
X-Developer-Key: i=jonathan.cameron@oss.qualcomm.com; a=openpgp;
 fpr=6E2966B387840652912681B154853499C4F41688

> The MAX40080 is a bidirectional current-sense amplifier with an
> integrated 12-bit ADC and an I2C/SMBus interface. It measures the

[Severity: Medium]
The commit message claims to expose a hardware-gain attribute, but is this
actually implemented in the code?

Looking at max40080_channels, the promised hardware-gain attribute appears to
be structurally omitted in favor of standard scale representations:

-

This one seems to be valid... If nothing else comes up I'll tidy
that up whilst applying.


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

One other trivial thing inline. I'll tidy up whilst applying

> diff --git a/drivers/iio/adc/max40080.c b/drivers/iio/adc/max40080.c
> new file mode 100644
> index 000000000000..6864ce1cb063
> --- /dev/null
> +++ b/drivers/iio/adc/max40080.c

> +static int max40080_read_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan,
> +			     int *val, int *val2, long mask)
> +{
> +	struct max40080_state *st = iio_priv(indio_dev);
> +	unsigned int range;
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		if (chan->type == IIO_CURRENT) {
> +			ret = max40080_get_current(st, val);
> +			if (ret)
> +				return ret;
> +		} else if (chan->type == IIO_VOLTAGE) {
> +			ret = max40080_get_voltage(st, val);
> +			if (ret)
> +				return ret;
> +		}
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SCALE:
> +		if (chan->type == IIO_CURRENT) {
> +			/*
> +			 * The selectable current-sense range is exposed through
> +			 * scale: each RANGE setting has its own precomputed
> +			 * mA-per-code value. Userspace picks the range by writing
> +			 * the matching scale.
> +			 *
> +			 * Use READ_ONCE to ensure the compiler reads st->range
> +			 * exactly once, so val and val2 come from the same setting
> +			 * even if a concurrent write changes st->range.
> +			 */

Wrapping is a bit odd. It is to just over 80 chars (83 or so).  No
readability gain, so 80 makes more sense.

-- 
Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
