Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793171766;
	b=aJBg7ZWEu1bYgbjDi+u3p31GcThbES/82u0DHMGh1ULE3pQhAyqSrPurF4tJR021hG8b
	 I1+yHjKFq8dh+9YEen4NBDbROvRiY/3yQ6XT8sla43f2ftHzVnIDY3V5c+FCdSXhBXHc3
	 heFVtAbSI+qAnQpsYC+jSYqOOuqVXVI+X6XaVKgnE1J1sFFAr7wmHNSg0LJITUh0NiJrU
	 fnpxaltK6XdDkTyw6hHXNIh5ia+vMerrc4LRS1f6vcqc7f2ZejixHXksOf01NQPlgSeWA
	 EGDmMO9Ba0fhBR6SEcKE2R5krn2P9WDv7lhl54LUjz9KX9zJkUTAtXviW3LlM7DTTtw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793171766;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=emtegajvD2PHGqYHH217zdcmL1omyniO8biT/+kuRok=;
	b=269hFnLfl93pY52HEIUC7l8hRTaIIZNkdfLdbKNtf4GlOfPR3xhYSJIjeeyiXkO6wEh/
	 +HhloCpL71IpMElQ7QU/U82oyNOVtxwINFTNfgGPruGM3IqNsSMbpgCZmYMEIIIxSBvZo
	 NW/GM6Yt9p70zreRgdJcvBcH+KUSrXihbD2n/t1Oh5iEHunfrXRH1fYGewrfw0zLQlDy8
	 efgci4/SSD3kKAqxxUV2cBvaKRYwDwOyovoS2loPOiZuqFN8Vx5c8xevDDqy9T9A5QiMd
	 2LBju0RGi60WmhrVXmBn64WPx3kwnXYpJyeKVECkhto7u8twXAgbqtm82D3au7sbVeA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=baylibre.com;
	spf=pass smtp.mailfrom=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=bj1RDHAt;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819F6606A31F
	for <linux-iio@vger.kernel.org>; Wed, 28 Oct 2026 07:16:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 819F6606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=bj1RDHAt
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a210470b49so4612985e9.2
        for <linux-iio@vger.kernel.org>; Wed, 28 Oct 2026 00:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1793171764; x=1793776564; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=emtegajvD2PHGqYHH217zdcmL1omyniO8biT/+kuRok=;
        b=bj1RDHAtB7vjolh/24QUvBkjTKpiQ4fB+9unIykEiiFy4aRwpzNeawm3XLokJFOah2
         L7uL3NcV9qrvoRUqBUstYTl/vbX7YesKx4ZUfFicl7U0ZsfVEuiRMkTUPaMCfpZXAnxc
         /JjgXahGqqSkk9nnUASL9ilmPxeG/bwigyi1WtMUZTIUPREvuPQt1BM5hJSRONfAHWEf
         afYWiwnrkeiWB613fQ2NABYwf+OZPqsBHno58MpDGrmclIEV2sDw70ph5TLcdta7Hequ
         EyLnEWnEbaAVFzWmaI/hvzq6EOv2s3YJ3knhw/Y/8s2NJDbalyD+DZeCRZSLIiJqsPYN
         yC/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793171764; x=1793776564;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=emtegajvD2PHGqYHH217zdcmL1omyniO8biT/+kuRok=;
        b=flZlzBI6gNI0NhjWYWD9AdKaupeE3Mk7DkEYOvfurZAc4RJAPyAQADNnHdmr1grWpI
         ar8dDKKvaeeTZqPCkPckDSSP0+4tsFu3P/88/mcYFcDnUrbM4ck3fKyy8xWfTPoycV5a
         xkOOs2hHpfb6DLhs8urZ62Wt3B1bn6NqEg/Jpo+SWdf96THEjnSaBIvThadpJABq8uQu
         6b0xeiihrYKYxYwClw3RMIUZRog8pfy0U1ALvOA2x9RipVivjHrXeHk8koXyz9zcWeFX
         YzTeQppaX6BGTE8kdG6erXqjjzPAxBWjRZi34RM2okPy5C2ZtzeXyi1gyR6l25wMpsrm
         EH8Q==
X-Forwarded-Encrypted: i=1; AKwUvBwgz2o4GerahQRPmjsaGirWl+sPkTOPxh+hjs8P1D3i5dEB+dn19O1rRGOJLEYnbaTSzJeM6lTN8c0=@vger.kernel.org
X-Gm-Message-State: AFq9FYKYEMxoR2dIz8Q60av9GMrGpLJ6VtSU2RYKteaoyLRZN2ApvgXN
	onhT4Bupl+CvdoR87ROQW4IVAv03kGC3UGzdXy8DIafO6X5reIdzYcHaXxn+reC7zKM=
X-Gm-Gg: AYBFou3nBG3UF8WpqTLi2P6OOgmm1jvAxgmSb4zwyurXE9Wj8QPpyA1ImO13PD77Hgh
	SOVi6weXrTnltWiIpDd+YxIwPbRPwc5ndRqx8Qi+rLw8k7EtA8D+kGPw49jAJ4MPopiBbunTNpQ
	AbYPtmQYUSCq1LQp1KlcNXdG16+3X4uXf9NgGDGikzZicusrM2PlqVD56okw8+JIwT3ZIlM2TJY
	iS1o28Xpzt1xOe20T1YN2rCOYacF/iRtj+BF6P26xG8KJ9g6AdKl0IgpAZfKn3EuGFuxJN/tT80
	ycBXLK7pxiLs5ZsU4Zwwl6vW8EGZLuVM7v3eFwkVTYDRRdCP1PLko5A956JJNc4p4rwjHFNLkBg
	g6qI1Uoj0jlGF0HJKqDsyB+4ukrLUGGfgvh8cqqnkHU2CVRszu3KmjzLh/bQpWBs52mu84mSpmH
	ezVUdC5/M4o/4cAw3+kx+N1VRpn985JIk7yi38c9c1UoK9ctgueiQ5QbvWRcu64FZsnxeF/HllN
	UYKz5cMXCUqpkpuTcXGryr3bS9NO88sVhN4YBxJziJotnz3UGkAFnUbP7oTeRtOeRZH9dxjupVh
	5gJUUzRNjhQjVh1o4/rRklKDp38zi4QXmqNYSIGAcLFxJyc0pc9fA6Ep/5np57/qNlHSHJsyTNI
	T9TLFMIOoeBVPI4E=
X-Received: by 2002:a05:600c:6098:b0:4a1:e00b:a0ea with SMTP id 5b1f17b1804b1-4a9640f2328mr26189545e9.1.1793171763595;
        Wed, 28 Oct 2026 00:16:03 -0700 (PDT)
Received: from localhost (p200300f65f19a904c16506b94501b867.dip0.t-ipconnect.de. [2003:f6:5f19:a904:c165:6b9:4501:b867])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4a930a63eb3sm26054795e9.1.2026.10.28.00.16.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 00:16:02 -0700 (PDT)
Date: Wed, 28 Oct 2026 08:16:01 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Olivier Louvignes <olivier@mgcrea.io>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Paul Cercueil <paul@crapouillou.net>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: adc: Add a driver for the Ingenic X1600 ADC
Message-ID: <auGg1AwlHMTKYAL8@monoceros>
References: <20261023204209.48556-1-olivier@mgcrea.io>
 <20261023204209.48556-2-olivier@mgcrea.io>
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
	protocol="application/pgp-signature"; boundary="7kzx4bd5q3rwseko"
Content-Disposition: inline
In-Reply-To: <20261023204209.48556-2-olivier@mgcrea.io>


--7kzx4bd5q3rwseko
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH 2/2] iio: adc: Add a driver for the Ingenic X1600 ADC
MIME-Version: 1.0

Hello,

On Fri, Oct 23, 2026 at 10:42:09PM +0200, Olivier Louvignes wrote:
> +#include <linux/mod_devicetable.h>
> [...]
> +#include <linux/platform_device.h>

Please don't include <linux/mod_devicetable.h>,
<linux/platform_device.h> already provides of_device_id without all the
added build dependencies of <linux/mod_devicetable.h>. If you insist on
full iwyu, use <linux/device-id/of.h> instead.

Best regards
Uwe

--7kzx4bd5q3rwseko
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmrhoS4ACgkQj4D7WH0S
/k4yYggApnKsIa+rCf3BFQJjly7WiAmxlAQR57PJQJaEPivBmt7SsrrspxVOOAum
ZSo8hfftL2LyDHfMgYIzt3la64M0m9Ka5MNheXRDG3NuIFW78hiJY1uyy1Sy+fcU
oPNpBjjLJWxzwjcGLUxIbM4kPqmIdsBamY7GrwDSB3BeNHFmOL2l6oLaF7QF22sC
3rDO8bwez9gW80BWN7CJCjpw4ynQK6LaxRX+7fBFbX4fRvqIL3Onp3Nufmp4TVo5
iXpJYlTPv3vt8tTP6rhxFh3R+9bmnzR2nc8MUCJJmAb7qRiaZSoQ3kz09LzpeVWt
eAau0gujuBeEzy26ASfKDcl86MpIng==
=0pQ9
-----END PGP SIGNATURE-----

--7kzx4bd5q3rwseko--
