Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792499024;
	b=XB2NYs64WYLgTqWvMK7LpCUDQVHnmsMbIuy4s/MRKEwA1g8OIsyNkgtdcH4d1fgRHO/R
	 M05axzaTZurI3sNLp8FlfbY0T5A74FRezlm5Ai1FfAV0csl09rz+GR/FNIFTJ8g4xE6s7
	 vh4BUvpKkrPal0iFWPZ+Ii0+yQaadHYhXxPYRgg2NC4gxqQZakUWXj0e9oLLegTqao3DB
	 hrm91tppAEcdN/16rXum+NmbrprSt2tcc8LGipT4MsHMtVKYZRKEB1XsjDkOvXAotBRmL
	 goDe7AQFS5z23As2R2LOFKULJpIO+GYgtJo+Z6hapJ7IMWzvanmq+JQ8dATBk0jZKXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792499024;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=dmh4SEio2e2zB4dSZuzKozFuJ75qBwgCNF0O8LkaaMw=;
	b=UwxRdnCpyUx7JUPwcMMtqdteva8PT8gRQ7V2Ol1C0oluQtG3rPqEP6IGlPsWBNkapZBn
	 HmZbHr6mD7Cz8L4luWZ5CnaSl47fG19igVJkta2OSbqtQQg13hm3h/m+MnHSOQ/aaAQg4
	 OIFkZ3lYnII3dxYjZ6WjlncrNoHDemyJXYnhESPhtwUI5MeB5uwjtK1d7evp16xCjXnVO
	 3+bazv+OUo3/BQLNPXvm9Dohu6Y/50UQG1T5kiDgZ8N1szCRxzhlpM2k3ngq4HGoozrYZ
	 7JJ7Yh+fNk7jpJP1XiFPmlNEHa7qZ0PC2iZgbe3xst41Vek6AREaMxf8UR++pywARPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e6x4fg+h;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 9F058606A31B;
	Tue, 20 Oct 2026 12:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e6x4fg+h
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id BD66E1F000C4;
	Tue, 20 Oct 2026 12:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792499024;
	bh=dmh4SEio2e2zB4dSZuzKozFuJ75qBwgCNF0O8LkaaMw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=e6x4fg+hVKPlf2jX7H+IVrTI1GS4Ja6Rd9ow0P5twU2QcW1CNYNYCVBoKdfxFIdrd
	 w/6zvMfMwiOMYw2ZbPhUnC3z4K3jRDyBhmIj14tR44Zq/xgwRWB3fRnP4y5rfTMqlm
	 us9Z7Ut3bLGJKFoDShskHkl0bjK8h3csi06fLw3rEPLURe3bhHRQujnPxKUeHYBHS9
	 v7zmGEGquB3DScWBMKnukDEwhqZrZffR7jwtYOHBF1H8gD+1fIDGtXDyCd1dd8qiyZ
	 G0uonBMpKP8dWQ+IM7tSSFleDDTqwLo0CWUXbpiRGHhbJfS0iRVJbdgJI0gqnX918B
	 iBOo4tGYU1o1g==
Date: Tue, 20 Oct 2026 14:23:41 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: rodrigo.alencar@analog.com
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux@analog.com, devicetree@vger.kernel.org, linux-pwm@vger.kernel.org, 
	linux-doc@vger.kernel.org, Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>, 
	Olivier Moysan <olivier.moysan@foss.st.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH 07/10] iio: frequency: ad9910: support drctl control
Message-ID: <atdcOsaDbtaQJd-9@monoceros>
References: <20261015-ad9910-backend-support-v1-0-3c21648c8e26@analog.com>
 <20261015-ad9910-backend-support-v1-7-3c21648c8e26@analog.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qqr4vuuxuxl2n7wx"
Content-Disposition: inline
In-Reply-To: <20261015-ad9910-backend-support-v1-7-3c21648c8e26@analog.com>


--qqr4vuuxuxl2n7wx
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH 07/10] iio: frequency: ad9910: support drctl control
MIME-Version: 1.0

On Thu, Oct 15, 2026 at 01:49:47PM -0300, Rodrigo Alencar via B4 Relay wrote:
> +static int ad9910_drctl_sync(struct ad9910_state *st)
> +{
> +	struct pwm_state state;
> +	bool ndh, ndl;
> +	int ret;
> +
> +	if (!st->drctl_pwm)
> +		return 0;
> +
> +	ndh = FIELD_GET(AD9910_CFR2_DRG_NO_DWELL_HIGH_MSK,
> +			st->reg[AD9910_REG_CFR2].val32);
> +	ndl = FIELD_GET(AD9910_CFR2_DRG_NO_DWELL_LOW_MSK,
> +			st->reg[AD9910_REG_CFR2].val32);
> +
> +	pwm_init_state(st->drctl_pwm, &state);
> +
> +	if (!ndh && ndl) {
> +		state.duty_cycle = st->ramp_down_time_ns / 2;
> +		state.period = st->ramp_down_time_ns;
> +		state.polarity = PWM_POLARITY_INVERSED;
> +	} else if (ndh && !ndl) {
> +		state.duty_cycle = st->ramp_up_time_ns / 2;
> +		state.period = st->ramp_up_time_ns;
> +		state.polarity = PWM_POLARITY_NORMAL;
> +	} else if (!ndh && !ndl) {
> +		state.duty_cycle = st->ramp_up_time_ns;
> +		state.period = st->ramp_up_time_ns + st->ramp_down_time_ns;
> +		state.polarity = PWM_POLARITY_NORMAL;
> +	} else {
> +		state.duty_cycle = 0;
> +		state.period = st->ramp_up_time_ns + st->ramp_down_time_ns;
> +		state.polarity = PWM_POLARITY_NORMAL;
> +	}
> +
> +	if (!state.period) {
> +		pwm_disable(st->drctl_pwm);
> +		return 0;
> +	}
> +
> +	state.enabled = true;
> +	ret = pwm_apply_might_sleep(st->drctl_pwm, &state);
> +	if (ret)
> +		return ret;
> +
> +	ret = pwm_get_state_hw(st->drctl_pwm, &state);
> +	if (ret)
> +		return ret;

Does enabling the PWM have any side effects? Are you doing that only to
be able to call pwm_get_state_hw() and thus find out what the resulting
output looks like? In that case, pwm_round_waveform_might_sleep() might
be your friend.

> +
> +	if (!ndh && ndl) {
> +		st->ramp_down_time_ns = state.period;
> +	} else if (ndh && !ndl) {
> +		st->ramp_up_time_ns = state.period;
> +	} else if (!ndh && !ndl) {
> +		st->ramp_up_time_ns = state.duty_cycle;
> +		st->ramp_down_time_ns = state.period - st->ramp_up_time_ns;
> +	}

So the configuration depends on the previous state of the
AD9910_REG_CFR2 register? That's a recipe for surprises?!

> +
> +	return 0;
> +}
> +

Best regards
Uwe

--qqr4vuuxuxl2n7wx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmrXXUsACgkQj4D7WH0S
/k6OXAf/d+0pGyggG4T72U405o4MpvtL+k9Xo8s1ca6BnOzf6oX3P+2ME8TPhrb+
tAbw9W7x2qZdaa9AfsihMrbotE1l8vdodoHQnT6SRG+xHJrBUD5rP+hKbq8Ty5Wj
FoP3PuI+QYjoxUJu++Vni4rEVdR0MrpAntztgjxHGiORpDpzCeRq5/fsjeyjCjzc
0qmjXAoTuaHprZJgINMMlAh8DaWEp1fIWncKJcv/unU58YYTJpduMC/ULDF3Gcy9
nFc5vQe7UoKaoPHqcHofv/MbjJ2r21fHnZWLih6piUi7ATYfj88G/Q08R+ANcuer
7xDjDYfwt2MDswuPJ8SVpUCA9TbOyw==
=KbhQ
-----END PGP SIGNATURE-----

--qqr4vuuxuxl2n7wx--
