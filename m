Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225F2248166
	for <linux-iio@vger.kernel.org>; Sat, 11 Apr 2026 13:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775915305; cv=none; b=ZbJe3nD9JrWHhElB8Tvw88YtsAty7VCVwrSEQ/sv4KB86aBTTzVXwftT4vdgQ5AKiASATnhOiRZ6e8ePeHcHhDOZBHWvE44gUowIfNpOJTOtg/rk9lTvjz4WeirpWIo9Q9Sf5O+RKYM1USB5CvZUlAdGrxsbJlzf7nbYx3xsbBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775915305; c=relaxed/simple;
	bh=iBCoQB7E6fCskWNJT7pOEw0uozNRZCGjwSGu4gC534g=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XDD+mRud03hrkX8p0Ette7CDm7bwKHvrjhcrEyERpQzumB6KeP4JpnDeyjWwR09oUFKpqBWqoy6v56c0JtK7nq5YV/eqV0xE2b6/2fhQ9RUUUIW2TOuKcwdoHst3N2w1tfkB1tTfrfrgrRhvnJwgoqShNK7/oyC6kXVULgUSEN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KnGDEBtE; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KnGDEBtE"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-488c21c636dso17263115e9.2
        for <linux-iio@vger.kernel.org>; Sat, 11 Apr 2026 06:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775915302; x=1776520102; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HrZqmkVKNr5K9poq/brXT/Y5EBXoQ8WwGpl8/FnN2cI=;
        b=KnGDEBtEVZhXFjBS9G1l9IC9czl0sZPG2ibhHkorgmAZlkZAE3wdSVY+fTrojGjFgh
         g2s3ZMqY8YHNAS0ZxFQF3vwH/rHiSO8XYgb0GhDHyx1CYk2kvzZGS4iKR3zLZewT+48v
         Bwd3L76lWeKhKps1SdgZLwekuEKFXNMyWNgUAbppuW2tAiFXl/1LqhbIx0boZb1pmF7Z
         fPULDn5gt8TtUNzSodtIC5SZO0S9Icz5RNq7Yybq9qjtMwU0RZd95YJesXZtekvLurnr
         eL2+nbFFqMvVNyBkAOKDTDs8KO+bhQ+7jVFXzqb0oJ/nVZgVUcRF8mnpF+HXO/aks4EZ
         CKFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775915302; x=1776520102;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HrZqmkVKNr5K9poq/brXT/Y5EBXoQ8WwGpl8/FnN2cI=;
        b=hp8dbG0TiQULndSZvMR/TWX5ff9KDamkFYxjF9Q9cF9Kq7ipPVpfF5m54vdQPWWt2F
         aXHV2xjWhJIE2DA7aaZTmJHj5d1ZpgJSc18LXq0Yy9g0IIs1MM11+HwWGlQd0WReyOPy
         qW8d1TkrEa+2suQSkRdIOCq5cVMzOXbDBSe/0TFqSmp5z1VawJ3dbffb8o4WloCruLJy
         K2mvdHn7oQxjrX9fnje09uon2/y+w71/TVoX5vFFe2lZ8ASzUTQBwd914zu9FelXwbJG
         eLlWNBNX2atzZoOwZHCVZu8F5qm+ySiBIEzq6rMywiYsINqRTRvybSWKUEM+Q2njKSYI
         N+9w==
X-Gm-Message-State: AOJu0YwuzGAPM4A9OMbatx45OjErz93A8AUt1GPEI8qjI2t5xyexZ2e8
	0JfDq6SUUBzakFgUGnOSFcrGSScl7zvxXMEekpCUwuRXJ3qf6JmJHoz7
X-Gm-Gg: AeBDieu27VZcgyj7fa61SmGBpKHzoJBrEpAcAhr/s2Y+CF05Vf/ebhIfCl0khSP66oi
	ZguQKPDkfJmFBUDysg023c1GZv3Gpp5Xl2GoUxf5HSSPFUIjFZTHzeOmVfh9qMziMyyK6Qy/Ji7
	o0qlGXkEzQjwgq0oc/BxIAcGzz8DIQRwpcrGQxa/vSuSoBdU59SQVWhMOZg9x8RaG670lXGn1Ex
	I0BBDq6qPZWepu+769Lazn9YBdpq4ZQWFDLkG2zV/RRi6HkvQxs4pZu5ic+05q3zgl2DsTuSJ1e
	jSkQdfDGiSbztMA/pz2IqCoqGH0SWZUgpywBknSY/TtCjkqFFNJHeYkJg7o832O1Dfn7RyjKtbK
	v0ysRGmYO1ncR4chK3h9x2PmDc78mqxTNrpZTZ1Yrd3UH7MRsY5iwo8oLk0C4OyqKGeVKw6XDHG
	xFI8LcI0KjICtSEa67OPXE6uXP+vVALR/EMjw0S5n3HcQ0OVc6RyOQ+gmodqAC755fJWKf1v+Qx
	HCv5CDM9PdG
X-Received: by 2002:a05:600c:a30b:b0:485:6e40:5584 with SMTP id 5b1f17b1804b1-488d67eb7e1mr70269305e9.6.1775915302344;
        Sat, 11 Apr 2026 06:48:22 -0700 (PDT)
Received: from ?IPv6:2001:818:ea56:d000:56e0:ceba:7da4:6673? ([2001:818:ea56:d000:56e0:ceba:7da4:6673])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488cd10b1dbsm149876125e9.2.2026.04.11.06.48.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2026 06:48:22 -0700 (PDT)
Message-ID: <76eda9d5a2ff1a3a4d21466d78632081dc9a5cd0.camel@gmail.com>
Subject: Re: [PATCH] iio: dac: ad3552r: use field_get() for power-down bit
 read
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Piyush Patle <piyushpatle228@gmail.com>, Nuno =?ISO-8859-1?Q?S=E1?=	
 <nuno.sa@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich	 <Michael.Hennerich@analog.com>, Jonathan Cameron
 <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, Andy Shevchenko
 <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Sat, 11 Apr 2026 13:49:31 +0100
In-Reply-To: <20260411051650.11949-1-piyushpatle228@gmail.com>
References: <20260411051650.11949-1-piyushpatle228@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2026-04-11 at 10:46 +0530, Piyush Patle wrote:
> Use field_get() for the per-channel DAC power-down bit instead of an
> open-coded mask-and-shift sequence.
>=20
> No functional change.
>=20
> Signed-off-by: Piyush Patle <piyushpatle228@gmail.com>
> ---

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

> =C2=A0drivers/iio/dac/ad3552r.c | 3 +--
> =C2=A01 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/drivers/iio/dac/ad3552r.c b/drivers/iio/dac/ad3552r.c
> index 93c33bc3e1be..f206bba3a701 100644
> --- a/drivers/iio/dac/ad3552r.c
> +++ b/drivers/iio/dac/ad3552r.c
> @@ -167,8 +167,7 @@ static int ad3552r_read_raw(struct iio_dev *indio_dev=
,
> =C2=A0		mutex_unlock(&dac->lock);
> =C2=A0		if (err < 0)
> =C2=A0			return err;
> -		*val =3D !((tmp_val & AD3552R_MASK_CH_DAC_POWERDOWN(ch)) >>
> -			=C2=A0 __ffs(AD3552R_MASK_CH_DAC_POWERDOWN(ch)));
> +		*val =3D !field_get(AD3552R_MASK_CH_DAC_POWERDOWN(ch), tmp_val);
> =C2=A0		return IIO_VAL_INT;
> =C2=A0	case IIO_CHAN_INFO_SCALE:
> =C2=A0		*val =3D dac->ch_data[ch].scale_int;
