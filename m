Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE8C1F872D
	for <linux-iio@vger.kernel.org>; Sun,  8 Feb 2026 09:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770541448; cv=none; b=fpL7o13Mty6E+gD3C/bHJNQKhaCBOkyWEPRDmEWN05jUcqLlxJuuuKJsOUogEmMnUm4iUfvfk7LYLT0BPBPOHos1OvESwNgWolYzOtZXyeoOTZEjQL1dwmuAQaB64HfFo/IYanaW18W979ptkQIGD+BJh2PUI9+EOKDkTbbSvyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770541448; c=relaxed/simple;
	bh=yGiVPrpt74qqeKVY5Kdknj4Kya0jm0QP6yMOV9F0V8M=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iqNukCuHoyP0AutCccciwfq2rQRs3YsoRomSQ0Yi44ORe+cQ6ZC/Gbggjn+EGEX9qYjoKme3Y2Gf86RLSrmuakEOlGG/bql2aevMtDu3UrAXsiI8Ao10VJUTuBqthkTNZlLd84Cx75PtTCf/1sRU5xiqBoKz2Hwm33iA4YEjZYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hXOMX29s; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hXOMX29s"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-480706554beso22081815e9.1
        for <linux-iio@vger.kernel.org>; Sun, 08 Feb 2026 01:04:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770541446; x=1771146246; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yGiVPrpt74qqeKVY5Kdknj4Kya0jm0QP6yMOV9F0V8M=;
        b=hXOMX29sBL2k5960kNaH+NyTVsB+H+S12Xa4GTVmlhDOKYzL6hB4S++W27yfk2NQg3
         brJkRYC9fj8p4xBw17OY+gOZUKpA2jl1OeVT9mF8gwIVWQBD75Zq3nkXudgqRApnE2/D
         sieI7UWMRP8DPPNc+XQhz+P9xP0P7piAf2HY/3SwLDFYMR5ZCVoejHwbDMN98jAAOvGw
         3y5Hxw7xv5YHAL7ZBNn9lkFG8l3m5KyuCCCP4yVWT8o5Xfmsooy3VLnPSxResmJizAdp
         zt7Mmxpu6yCxaAiNXeybgfiQEgulVGTJ8o+BkE8AaN/7+CpTHFli75ACEXqq968VzylK
         B2Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770541446; x=1771146246;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yGiVPrpt74qqeKVY5Kdknj4Kya0jm0QP6yMOV9F0V8M=;
        b=Xw/y4CagnZS6iwFudx3DzALkkMpvuPlXBsKXiZXsrd3N6EjUz3yKlMGd9/K7YJPDHZ
         RULV35OW0gwwzXkKXyg0NrSbYKfQeMRUXBtBuBzIYW5rPi3vpkzWRZu3eHso6V5L9kmn
         t8Iok7yNe+Gte4KGamg8p9JjBwJXScpuc19e9aG0mK3ae7kWCsVCflxb8puTJrE8/1Ax
         To2QttSZnolc3v9ReOsV7W2a9h20pBuoHoZtRThbAcJuA5bUDFMIh8Txqo5QmR3qJe2C
         jgim62MFfamXSFPbMMmEuhkKMlrXinVJzXEtFY3We1X0QzLdTZApr10wTaCsZWJEDVRO
         EoAQ==
X-Gm-Message-State: AOJu0YyNkArIrYll+Ezo6v7Vufzzb9OgSW4viB1seuXKMiCjX0s7RGi8
	u5mGY2i1z2PiE2z4g42Gu/CupYwEEOCru4TKva4cMdC5HyDJWvAZJv04
X-Gm-Gg: AZuq6aKP8k8aCtDExbut4IcCYRUQLSSCka7XgDO6/ge8ygUDQ0lWMMbzBBDTGFnZwrl
	HOMMOYyY/VnaSqoJDCtEfIzB++gJkDone4xRk7Ly8Ffb65461SHfIuyMCS6i6g86/P4oQJLNsoP
	PZf61lbWHtgTqR6Pz7F+1aufwzHaqxRjwC0TurxSmy6AVTM1I4M8zTzc8xkcq5kLzkwtLgGn/4d
	rS/70VteZAjAHCH/FszQclmUA5p/Jfk4q2Cag4gIeojYFh4ks2Dktpe1v1BlItoaZPeqVdOHrQG
	en4JXBCE4PVxsULE7Sfdl2MgC8kzovSNv6paOcB9XEKpdnv53XQ0qZvc4NWjmEbb0jTzXl+QdbJ
	7yAkL3ibLq04zmGy/XhP50pBptRpK5DPTjV7kVZ6qeL7FcJEuYw0tiwWkv5SlKFBDld7fbnmU6l
	n9L/+aVbxzWdETN0QLS9FmnbG0cXIQsXKROjCO1+r5Xygptwg6TUr9mfecsQU=
X-Received: by 2002:a05:600c:1390:b0:477:5ad9:6df1 with SMTP id 5b1f17b1804b1-483201dc4bamr106657255e9.3.1770541445993;
        Sun, 08 Feb 2026 01:04:05 -0800 (PST)
Received: from ?IPv6:2001:818:ea56:d000:94c4:fb0e:28f:2a8d? ([2001:818:ea56:d000:94c4:fb0e:28f:2a8d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483179dbdcfsm309008405e9.0.2026.02.08.01.04.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Feb 2026 01:04:05 -0800 (PST)
Message-ID: <0ec1a65a61d4b4f176018bf8478be24eed800a4c.camel@gmail.com>
Subject: Re: [PATCH v6 0/5] iio: adc: ad9467: Support alternative backends
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Tomas Melin <tomas.melin@vaisala.com>, Michael Hennerich	
 <Michael.Hennerich@analog.com>, Nuno Sa <nuno.sa@analog.com>, Lars-Peter
 Clausen <lars@metafoo.de>, Jonathan Cameron <jic23@kernel.org>, David
 Lechner	 <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>,
 Olivier Moysan	 <olivier.moysan@foss.st.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Sun, 08 Feb 2026 09:05:09 +0000
In-Reply-To: <20260205-b4-ad9467-optional-backend-v6-0-7ca20c40c59a@vaisala.com>
References: 
	<20260205-b4-ad9467-optional-backend-v6-0-7ca20c40c59a@vaisala.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-02-05 at 12:24 +0000, Tomas Melin wrote:
> To facilitate backends with different set of features, add support
> for defining capabilities provided by the backend. These capabilities
> typically extend beyond a single operation and are therefore not
> directly linked to if a single function call is implemented or not.
> Furthermore, the capabilities determine if a certain set of operations
> should be attempted, or skipped by the frontend. This way
> the frontend driver can work with a minimalistic set of features and
> still have the device in fully functional state.
>=20
> Signed-off-by: Tomas Melin <tomas.melin@vaisala.com>
> ---

Well, as you all know, not my preferred way to handle the enable/disable st=
uff,
but, anyways:

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

> Changes in v6:
> - Renamed CAP_ALWAYS_ON to CAP_ENABLE with inverted interpretation
> - Renamed CAP_BUFFERING to CAP_BUFFER
> - Added sd_adc_modulator capability commit (CAP_ENABLE)
> - minor fixups in code and docs
> - Link to v5:
> https://patch.msgid.link/20260130-b4-ad9467-optional-backend-v5-0-7da803b=
a7326@vaisala.com
>=20
> Changes in v5:
> - As per recommendation, use guard for whole block
> - Typo fix in commit message and cover letter
> - Link to v4:
> https://lore.kernel.org/r/20260121-b4-ad9467-optional-backend-v4-0-18d2c0=
d450cc@vaisala.com
>=20
> Changes in v4:
> - Readd CAP_BUFFERING and also add CAP_ALWAYS_ON to support backends
> =C2=A0 that do not need explicit enable/disable
> - Don't mix checks for eopnotsupp and caps. Prefer capability checking
> =C2=A0 also for caps that map to single operation
> - Move capability checking to top of call stack
> - Revise iio_backend_has_caps to use bool signature and fixup semantics
> - Amend documentation texts
> - Add capability checks for axi-dac
> - Drop two's complement patch from this series, already applied
> - Link to v3:
> https://lore.kernel.org/r/20260114-b4-ad9467-optional-backend-v3-0-d2c849=
79d010@vaisala.com
>=20
> Changes in v3:
> - Reduce set of capabilities to only include calibration. The other
> =C2=A0 ones propsed in V2 can be seen as subset of calibration, or single
> =C2=A0 operation failing with opnotsupported
> - Rename backends checking function
> - Relocate caps field inside backend struct (pahole)
> - Add kernel-docs
> - Add capabilites for exisiting backend variants
> - Link to v2:
> https://lore.kernel.org/r/20260113-b4-ad9467-optional-backend-v2-0-0a27e7=
e72f41@vaisala.com
>=20
> Changes in v2:
> - Added industrialio-backend capabilities feature
> - Removed acceptance for fully optional backend, instead require atleast
> =C2=A0 minimalistic backend to exist
> - Switched to FIELD_MODIFY()
> - Fixed kernel test robot reported failure for missing bitfield.h
> - Link to v1:
> https://lore.kernel.org/r/20251216-b4-ad9467-optional-backend-v1-0-83e615=
31ef4d@vaisala.com
>=20
> ---
> Tomas Melin (5):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio: industrialio-backend: support backend=
 capabilities
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio: adc: adi-axi-adc: define supported ii=
o-backend capabilities
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio: dac: adi-axi-dac: define supported ii=
o-backend capabilities
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio: adc: sd_adc_modulator: define support=
ed iio-backend capabilities
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio: adc: ad9467: check for backend capabi=
lities
>=20
> =C2=A0drivers/iio/adc/ad9467.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 | 67 +++++++++++++++++++++++---------------
> =C2=A0drivers/iio/adc/adi-axi-adc.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=
 5 +++
> =C2=A0drivers/iio/adc/sd_adc_modulator.c |=C2=A0 1 +
> =C2=A0drivers/iio/dac/adi-axi-dac.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=
 2 ++
> =C2=A0drivers/iio/industrialio-backend.c | 16 +++++++++
> =C2=A0include/linux/iio/backend.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | 24 ++++++++++++++
> =C2=A06 files changed, 89 insertions(+), 26 deletions(-)
> ---
> base-commit: a7b10f0963c651a6406d958a5f64b9c5594f84da
> change-id: 20251215-b4-ad9467-optional-backend-23f1099ee4d7
>=20
> Best regards,
> --=C2=A0=20
> Tomas Melin <tomas.melin@vaisala.com>
