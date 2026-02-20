Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C92A7478;
	Fri, 20 Feb 2026 10:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771584712; cv=none; b=kFdpoNqKqjBcP4/R3utzvALi0NZrm5cpreY2YmUdIaX9BDK4N2t5XDmVEHCWiDxg33ecFHOK8Vyl1h1iHxmGSBtuk7+7zpvRzMD6MpPNrXUGIeyfL1gpSzqIR7iwHgtaDC2U0siWJ1I9Fp5bZ3qa74WwxZCTMZTswc0/zyH6Ey4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771584712; c=relaxed/simple;
	bh=JSisQMD3kKXu77sl1IcU2jv3ZqU8zKfW02TMTGHQeEo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gE0Fy9SZznHu1kjHCqQoUv/uUzPKhvx7jqRxNprbU6+aQauz6BVQIzGXeaoO1mu2DJ2cmECEHzyyOc3DjFkHeukYqHTrgI/u6j0TynARIp5nyeAqpTXKARUUsDBQLNdRyNUP4NP3Y8tyqE8+B3aZfLlWdRriAs4/WvB4ZvMucCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H6YBjiUN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H6YBjiUN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F4B6C116C6;
	Fri, 20 Feb 2026 10:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771584712;
	bh=JSisQMD3kKXu77sl1IcU2jv3ZqU8zKfW02TMTGHQeEo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H6YBjiUNlrxm/aAI6APhInHGXg766TIcXzvDjXgn/U71qK6a0Wq0dDXrBmyID7s1K
	 TEppkJNgxDo7MZNUmq797awROHBrpxd81SCD1Lkuot3HgYvBAo+u8EC15XM9EmGxzv
	 EONLeW7cnDlar2am/j/5lw8coF2LphDLQ57KMpCA0RBtoH4dg8E6GvjOJ18jK5AHJS
	 YwOwPSSdS6eKoqv4lZMkROo3DgVTxW4Mj65YyMTDk0HvLTtBVJ3VESdQbYvZkTkjYP
	 qFJgIN5X/arQCZXoJQAIlMjwAtGwhImgsLOopogaJZDF6r8pMgj7THgkcZ78lRD2J8
	 Ef/+RHAriLHJw==
Date: Fri, 20 Feb 2026 11:51:49 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Alexis Czezar Torreno <alexisczezar.torreno@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH 2/3] iio: dac: ad5706r: Add support for AD5706R DAC
Message-ID: <aZg51rcxck6AyYUm@monoceros>
References: <20260220-dev_ad5706r-v1-0-7253bbd74889@analog.com>
 <20260220-dev_ad5706r-v1-2-7253bbd74889@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jxpwguxmcbdpqpxt"
Content-Disposition: inline
In-Reply-To: <20260220-dev_ad5706r-v1-2-7253bbd74889@analog.com>


--jxpwguxmcbdpqpxt
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH 2/3] iio: dac: ad5706r: Add support for AD5706R DAC
MIME-Version: 1.0

Hello,

On Fri, Feb 20, 2026 at 04:02:57PM +0800, Alexis Czezar Torreno wrote:
> +static int _set_pwm_duty_cycle(struct ad5706r_state *st, int duty_cycle)
> +{
> +	struct pwm_state ldacb_pwm_state;
> +	int ret;
> +
> +	pwm_get_state(st->ldacb_pwm, &ldacb_pwm_state);
> +
> +	ldacb_pwm_state.duty_cycle = duty_cycle == 0 ? 0 :
> +		DIV_ROUND_CLOSEST_ULL(NANO, st->sampling_frequency * 100 / duty_cycle);

This being integer math it would benefit when simplifying that to

	10000000 * duty_cycle / st->sampling_frequency

. Consider st->sampling_frequency = 667 and duty_cycle = 99:

	NANO / (st->sampling_frequency * 100 / duty_cycle) = 1484257.8710644676
	DIV_ROUND_CLOSEST_ULL(NANO, st->sampling_frequency * 100 / duty_cycle) = 1485884
	DIV_ROUND_CLOSEST_ULL(10000000 * duty_cycle, st->sampling_frequency) = 1484258

With duty_cycle <= 100 this doesn't even overflow.

> +	ret = pwm_apply_might_sleep(st->ldacb_pwm, &ldacb_pwm_state);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +/* Device Attributes */
> +static ssize_t ad5706r_dev_addr_write(struct iio_dev *indio_dev,
> +				      uintptr_t private, const struct iio_chan_spec *chan,
> +				      const char *buf, size_t len)
> +{
> +	struct ad5706r_state *st = iio_priv(indio_dev);
> +	unsigned int reg_val;
> +	int ret;
> +
> +	ret = kstrtou32(buf, 10, &reg_val);
> +	if (ret)
> +		return ret;
> +
> +	st->dev_addr = AD5706R_MASK_DEV_ADDR(reg_val);
> +
> +	return ret ? ret : len;

This can be written as:

	return ret ?: len;

It's a matter of taste which one you like better.

> +}
> +

Best regards
Uwe

--jxpwguxmcbdpqpxt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmmYPMIACgkQj4D7WH0S
/k6/2Qf/ZoeFt0oZ8oUHV/quWMjmAlY6txvcb8uIRJNUFfT7BbSpJTAtes3Zb/oB
gBrJsNjZPUoQvb8keCb79a/mpCwwwEr+aWlBpo/0wPR2jiJhtXsvVHvps7tlU2V+
U766+NNYuIHWy8hN9SYMyEHPPKkiyrvN1ivtKyZiCq1lypE237J5RwSMQ+KSUjE8
9tmpwr+Twf/fsebHhW3jfm+z9ce+6NJleayD25JJBY39AduPTzUZvOH83hrOrVot
hO3UDiInBM2g5SY7lB6T2xSqvJGUyp/Nam6ma2+YgUFhF/1626zVvk5NAE7pd6QL
7q5jO2q4kn3YwXsOtQIJAQKxHSHs0w==
=hQTe
-----END PGP SIGNATURE-----

--jxpwguxmcbdpqpxt--
