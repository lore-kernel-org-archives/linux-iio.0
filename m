Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D6826CE05;
	Sat, 25 Jul 2026 22:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785018842; cv=none; b=nHeV29mKmu08vCaxCt4Qg8/kuP1IqNpKps29n18AKn9SZsEkMyOBwm2d+MtXlf7cYQeZf9By/PsNL21cDDVuMvt41QbH4riWXDY18nI7D7EkGY79S7dEgMXfYEnszGcwbPZiQpwIlzlTzHln+1CCrXyRLgppzaXUyu0YK3wZN00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785018842; c=relaxed/simple;
	bh=2rW93ASxYrwT9b7iOHBrRN+svH3w8s5ff4WagzzI1+A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EfFyDQyzIZXPoDnwYr3jcrlRc7h4Zkuzj5jwb/8ek50WHlZCERogSWgNKiykqFj2p+bxaOr/nixjgeyfW2uRzPNIH+/l1dS9OtHJxs15ymiLBgKlngYlXS5Dzonw5ReiEosk3g06IXXL/fnxWVPNirvgQb+Z60BfqotD9Y2YGjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=is8smjom; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="is8smjom"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AA9B1F000E9;
	Sat, 25 Jul 2026 22:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785018841;
	bh=ha4rFh+zkTNjipvFuS93aiqbZLY2NNHnz1eZwh96x0U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=is8smjomO+FIok7jq7tuN11zMEiMlcUV+LLxzA3+nqO4WF0Ll+85Cj7jK1H3PkY1n
	 fGcN2G8Xp2OJ8kNLSbtwlhg7Bamn670wrWpME/3DmE0W7q5VF0QzVVof+Q9SFpEx/k
	 IxQ2eGro04jZUfrGCWUk25eB5GOFiaOgby/hupNR0KX7+FY/OjyZv4QHeapFbrYGm4
	 uNGIKTTXeRoDK9xoc18XRtAOit3WiuZ/gCg+T5b9AMEk/qFkZ8bNrbFGDPUSA2y+iH
	 d9jc9gAl74z47TTishnsn0+RXMP6sT65H2TaYhJXdaSNZqTeItu8Cr64YR2TR1hqAH
	 hTUZS6f9f7gzQ==
Date: Sat, 25 Jul 2026 23:33:54 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Alencar via B4 Relay
 <devnull+rodrigo.alencar.analog.com@kernel.org>
Cc: rodrigo.alencar@analog.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-hardening@vger.kernel.org, Lars-Peter
 Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Philipp
 Zabel <p.zabel@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>, Shuah
 Khan <skhan@linuxfoundation.org>, Kees Cook <kees@kernel.org>, "Gustavo A.
 R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH v9 10/17] iio: frequency: ad9910: initial driver
 implementation
Message-ID: <20260725233354.369b3fa2@jic23-huawei>
In-Reply-To: <20260722-ad9910-iio-driver-v9-10-459d1df5ac56@analog.com>
References: <20260722-ad9910-iio-driver-v9-0-459d1df5ac56@analog.com>
	<20260722-ad9910-iio-driver-v9-10-459d1df5ac56@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 22 Jul 2026 16:50:19 +0100
Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:

> From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> 
> Add the core AD9910 DDS driver infrastructure with single tone mode
> support. This includes SPI register access, profile management via GPIO
> pins, PLL/DAC configuration from firmware properties, and single tone
> frequency/phase/amplitude control through IIO attributes.
> 
> Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>

...

> diff --git a/drivers/iio/frequency/ad9910.c b/drivers/iio/frequency/ad9910.c
> new file mode 100644
> index 000000000000..b41b011af281
> --- /dev/null
> +++ b/drivers/iio/frequency/ad9910.c

...

> +static int ad9910_parse_fw(struct ad9910_state *st)
> +{
> +	static const char * const refclk_out_drv0[] = {
> +		"disabled", "low", "medium", "high",
> +	};
> +	struct device *dev = &st->spi->dev;
> +	const char *prop;
> +	u32 tmp;
> +	int ret;
> +
> +	st->data.pll_enabled = device_property_read_bool(dev, "adi,pll-enable");
> +	if (st->data.pll_enabled) {
> +		prop = "adi,charge-pump-current-microamp";
> +		if (device_property_present(dev, prop)) {
> +			ret = device_property_read_u32(dev, prop, &tmp);
> +			if (ret)
> +				return dev_err_probe(dev, ret, "property read: %s\n", prop);
> +
> +			if (tmp < AD9910_ICP_MIN_uA || tmp > AD9910_ICP_MAX_uA)
> +				return dev_err_probe(dev, -ERANGE,
> +						     "invalid charge pump current %u\n", tmp);
> +		} else {
> +			tmp = AD9910_ICP_MIN_uA;
> +		}
> +		st->data.pll_charge_pump_current = tmp;
> +
> +		prop = "adi,refclk-out-drive-strength";

Sashiko did have a question about this.  I didn't care enough about the particular
combination restrictions on the clock being output, but please have a quick check.
https://sashiko.dev/#/patchset/20260722-ad9910-iio-driver-v9-0-459d1df5ac56%40analog.com

If it is possible but nonsensical, add a comment here.

> +		if (device_property_present(dev, prop)) {
> +			ret = device_property_match_property_string(dev, prop,
> +								    refclk_out_drv0,
> +								    ARRAY_SIZE(refclk_out_drv0));
> +			if (ret < 0)
> +				return dev_err_probe(dev, ret, "property read: %s\n", prop);
> +
> +			st->data.refclk_out_drv = ret;
> +		}
> +	}
> +
> +	return 0;
> +}
