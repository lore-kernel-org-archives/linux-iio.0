Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793893367;
	b=AgPW6fl4/cOsjiirfQ5k3SBMYzd3Pu1TddsmbsrdERY6cT/q53AmYW1Fx+i9w90DHq9f
	 RVAOPREpshTZilJCRyEgs8yJxBuAam79NgcZoSt7EZTOo+oN+XDXKH0Fl6SEfyYrTeCmY
	 4gya+4qksoC8ghKKR+QOzPuRsZXIO7Bg17rDn3zhkpPmM3y/QCDSlHeMwB18OuIGtbdVH
	 yX7+HMYHcRVt9hHLQzCU8JwZk7PuLnGVEMe8vCCWI11y9pMQYESkToWaMWMCluHDG8Siu
	 o60uaP52ZTDQT670SoziiV7cSGoSD/HmD81yJE0sr3jjAfwoumijxXkLidjSrfbgvww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793893367;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=CNjjrSNQGLbkLKnHiNf/ABSrRsMuuhd+YnklcW3AyI0=;
	b=Y9rjRvkd+HqzfmCyHWa17nBYV3xrDk7LHy+T+VhVF04lF84wRQtHvFbQIYEtFzzlJbet
	 +QsFTQZ4W+lqY8peftKPEEhnCe8Az3Pr0nUhvHC2YVPPti6brchkS2zgH9pu8PSWRIzbp
	 E89WgQHHQ7MuFRGgTDU9ISqxkzj9Fvj+L4+wfBruHBb2j5p1bQivp5off+UHj3wQMGLqU
	 77x5ISKp3oddqU4e/4voeRHAvpA8dxGbr9vTaA2/KWg/bgBxuas54Lxucl+ODPr6G0n4/
	 5tIFP6beCDFEqOQL99/EiVxkvMjz38a32AvtR5INP85fUrzh0jkgqxUwy/b26LHrIZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=baylibre.com;
	spf=pass smtp.mailfrom=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=YkCthRMR;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD3BB606A326
	for <linux-iio@vger.kernel.org>; Thu,  5 Nov 2026 15:42:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CD3BB606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=YkCthRMR
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a1fbd52ab6so14660675e9.0
        for <linux-iio@vger.kernel.org>; Thu, 05 Nov 2026 07:42:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1793893364; x=1794498164; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CNjjrSNQGLbkLKnHiNf/ABSrRsMuuhd+YnklcW3AyI0=;
        b=YkCthRMRKMiuRd2Z4NfKndCCeWHe86gUxzUIWiAlNnFY0Wo1vBpt+oxvKGMqtals3p
         Yy/lw3IAFgg0RMoIvldBnLb/vacj+9QQBvMIrXUeIALFxhKov7zmXc8ftWZb+7gMIUq+
         HmsbDWdkKFy7gKBozRej/ca2uHLwvaViwSpEWds9zNdgOcOyG1J/WHV/NpBWVyKweLcH
         9GLmvsc4oyATxsTFBzi0kucJreoY0z8Sr1/TTAg1uOwKj7RsWU1gOzXMaX90EgaDrBjl
         Vd/DWeywNz3MHUifdfjzXdS7rcxlm5SlX2be3DkLNdCFj0IAb+0y9d37iZl+ZjMatgvi
         r+cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793893364; x=1794498164;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CNjjrSNQGLbkLKnHiNf/ABSrRsMuuhd+YnklcW3AyI0=;
        b=x8OmjivkNJFvj/uZ12d1Z3yhG6604HLP53sL+812acW1Gogmg3LvQR3u1q/o+Ab2/5
         L1G+d4eZJXKMv3O8SSMtgFsfWXfVroR3v2LlfDRRhMbTqM7dJJvUzPQk0SK77iBEzt5C
         qKiTW6dEdHkRFLqsz+wQEhdeGcI/ZG+U8iosgGQ+Dz67geQY9z9Id94hEpipxYUthbYJ
         MTVhwJp6WvO99DJpvN00AZJDIR5iVMbiqqsKAfr0JCaAi4kJVPpy+QhAAYFVU+tTbKdT
         IlYJnoJIwTpcmpxZAiZ8K4Fzo22ygpp9PlNsag97/f41YzVhEZBSL15bZTMdJ83JDYBu
         wqSg==
X-Forwarded-Encrypted: i=1; AKwUvBwcDTa6hFxJZtZDLQ4wV7WxIWRXgoCkWuBX+uXrtWJ5KHWM1gotENLHWu9gQ4g1D8sH8JJSXMdxiMY=@vger.kernel.org
X-Gm-Message-State: APuU4Z+zpb2li0hY7UZjMCMSStBiZSOYMnNASl8dujQPGz+0dlCX0mex
	DVEsDOo0c/xrXz2z6U7H5Xu3/LhYFF+flk6ahk5jpWxAT9XO3WOsXdl+gug198MKVKc=
X-Gm-Gg: AYBFou2X/xdXPZGXysvbe84Hb/HJEuyG/JuF80TlF4M/Kzz/kIh9H0/niPiO3UfWrcP
	8ZDUUzl0fCy7BjDVJuotG1gChNNJ6mdcQt7wWyODuuQ0MQOodxI11RRfQV8Df/6jtUV6QmHggER
	zeh7rc33SQP4R74SjLHIB3LfMPLvBXLvN8kQ1k7WteM9+4bO6j2vx8dP2thd22qRComdyY9UjZF
	+KEOnmrv0ncyKT/rdN0O5ZFPLlYZt2aJ7jkxOqz9LnQqd/YI2Egxdy/cbuneMPlyqsFzaEykG5G
	i/5zkfGTiMMQBSHpYP8y79Ga1b58KlQ7AGgzKuqnswQeQw3cDBf4WWO7dVSRkFRSeyIca3w9QUL
	BtyHNgo5WByc5X7KHEGfOZwSu+mxYJITDKCEtbB0fbXBsoRTgL5g7D8/jGJADCbKtG2KKSzECka
	yWIR29cevqSVnC3gZScSgx2wySmlrE82ZqAALiSyzSNHuEHWreZ4ePNugoakF58WCSxszVHvr8I
	yALbBT8XkLcMQUn4KT+gbZk8vaUAh5KZK2Jogi/GyQijgEiSxx90NqK2xlyhpFVCdsaXHM+JibL
	Z3jk/4H+y1TCRD+tCf9hPI8HKPtTrXsobbOCERgB+DWTCG6s6g1w1SRPg5hM0VeaQkRumKtV56L
	uLew9ILK/Xui4/6fjvcQ+Oadx9bweVlcNnAaa
X-Received: by 2002:a05:600c:190b:b0:4b6:267a:dd6e with SMTP id 5b1f17b1804b1-4b6267adeebmr31331575e9.28.1793893364291;
        Thu, 05 Nov 2026 07:42:44 -0800 (PST)
Received: from localhost (p200300f65f19a9044f222dad4d982d50.dip0.t-ipconnect.de. [2003:f6:5f19:a904:4f22:2dad:4d98:2d50])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-48fec8d87b5sm10229911f8f.11.2026.11.05.07.42.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 07:42:43 -0800 (PST)
Date: Thu, 5 Nov 2026 16:42:42 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matti Vaittinen <mazziesaccount@gmail.com>, Rodolfo Giometti <giometti@enneenne.com>, 
	Marcelo Schmitt <marcelo.schmitt@analog.com>, Antoniu Miclaus <antoniu.miclaus@analog.com>, 
	Angelo Dureghello <adureghello@baylibre.com>, Tobias Sperling <tobias.sperling@softing.com>, 
	Eason Yang <j2anfernee@gmail.com>, Marilene Andrade Garcia <marilene.agarcia@gmail.com>, 
	Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>, duje@dujemihanovic.xyz, herve.codina@bootlin.com, 
	thomas.petazzoni@bootlin.com, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: adc: add driver for Texas Instruments
 TLA2528 adc
Message-ID: <auyjgDddFs3OvnC3@monoceros>
References: <20261030164705.297354-1-maxime.chevallier@bootlin.com>
 <20261030164705.297354-3-maxime.chevallier@bootlin.com>
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
	protocol="application/pgp-signature"; boundary="yopseine6onc6aoe"
Content-Disposition: inline
In-Reply-To: <20261030164705.297354-3-maxime.chevallier@bootlin.com>


--yopseine6onc6aoe
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v2 2/2] iio: adc: add driver for Texas Instruments
 TLA2528 adc
MIME-Version: 1.0

On Fri, Oct 30, 2026 at 05:47:04PM +0100, Maxime Chevallier wrote:
> +#include <linux/i2c.h>
> +#include <linux/mod_devicetable.h>

Please don't include <linux/mod_devicetable.h>. <linux/i2c.h> already
provides i2c_device_id and of_device_id. <linux/mod_devicetable.h>
provides many more *_device_id and thus introduces a big list of
unnecessary dependencies.

I recommend to just drop <linux/mod_devicetable.h> here. If you insist
on full iwyu, there is <linux/device-id/i2c.h> and
<linux/device-id/of.h>.

Best regards
Uwe

--yopseine6onc6aoe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmrso+8ACgkQj4D7WH0S
/k44lAgAo9dVK371hYEKF67NIG+UneFq4MYJzAcDXxvTtOhkbG3bb3pvqR6IBDfT
cuJDoIH2cpFukhzp7daIjeRVZpJ9S2/yuGTPjumt1eFVYZcFvNB8FU87IQ+3R47Z
utePF5ukTS1zmkZe+1b0fRCH64mAjTRZYEsWsVqzRjg1lmt8vrD3NInKYzW7rJSw
j9qrARlJ8XOODrkeq85ZYnLncp9tj1ilDLcOyU4ffM+IWCHDgLt9BJSZx7F9G6j0
OqBCEhqyudx26Gg0Tdb/HE7uBUDFIeqcV0PljqUHkmfaLTBSRPNsVlQsoO65SvfH
9Vyt+P+ogAtsiSJAyxM1OhsbrNR2BA==
=ujJA
-----END PGP SIGNATURE-----

--yopseine6onc6aoe--
