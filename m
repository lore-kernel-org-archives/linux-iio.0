Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7127F248176
	for <linux-iio@vger.kernel.org>; Fri, 13 Feb 2026 16:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771000364; cv=none; b=LPP3kz/zEkqKZeKlA0mSXV3/iwbdbRKYRQpDLof1Zj4pXJsQuL789/9BuJTB7Xwad7/bs+v4jEJwU5Vr92xIuQjH/ajfSNv5oYBL2FQcwzpUue27y5hfwCtMK/s22dWUA4rG4Qjkx1hulueA+00H9Pe+b/A/ggHQxP0Ej8ZWfKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771000364; c=relaxed/simple;
	bh=6UlCDCKvpgdhVvZEFBWULI+ekMscG3Ep9OXDaN5Aqnk=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EQzx2h6On/1Xr0TWvFdBCTLgyoU6Ygj0L9UaR1DHlngF/gKHxSdGG5UOXWavRJizx+H6jpR50JPjxyKHcmVRvjOzC63mDJPF18Yu9Oe+8aJPwUR5MoSa13VoBFho1+CssRSnG7BXFrwqPBd9LVfSxIwPsPsnYKSZy1qFRAGlZ6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KjMgXtBO; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KjMgXtBO"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-4362197d174so773154f8f.3
        for <linux-iio@vger.kernel.org>; Fri, 13 Feb 2026 08:32:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771000362; x=1771605162; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OSsStgCmS8aP2XA8Nu5NxqlQOoi74RAhmCRiufHYOgY=;
        b=KjMgXtBOgXg3nViI9Uo+WfxfqgzzocoRttlce75FtECP2ICPf6tS9Rwqy59rEL14yw
         UOigNXq9QvKwC8uVZsuqYiT32Ql3FJGc2pGS9gPGtZ27tpzvO4Yfeon3n89y8rOeYroA
         ajjsDObT1+wBYw4KXRL7kIxJN+xIChcY4jQqFkTSob333pfbTGpCntgmH9XTtEj7zUV3
         +PJY0haKqPyhqvY29G4bmvwaoKGK1ogirLs0sw8ljcjcWcIlQrXyWZZjPbDnd7wcNk9X
         phwvC3nUY+wWK3dJw+/uChYbF9AgbvR/81ucNvSrK+U15A6Mjb2n0a1mIbime8IzYL1f
         fB2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771000362; x=1771605162;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OSsStgCmS8aP2XA8Nu5NxqlQOoi74RAhmCRiufHYOgY=;
        b=eicK5ayBuBRdvsTQD1IO3mu3lRltiNaLT1Rl0gx3VKznR8l935JopwnLpx5g4C5e6B
         dpL1GqpibfBafq9fOtUbU54Ao0HGROF/pLB5tgbu7XfpOYhvfAXSBwoLFr4yoVVDlTv4
         JWSZ7owqKecxrK75BTHoDEMJPJOEYyCRtCKlh1kQlLSSzpZO3cnA9zqFeG0kFE3VfpT7
         KQMU+7QSIbw5Wi08w1cChMbTXXY4QgNUc/qzXjZPpoAMOVTXehj997EHV4OaJp68oy8I
         Tdn9s4zejbhGVnJ/ttW5jF/j9AbRbUiETuCBNiRhz0PQfMTlO8DvxImVru2i7n93II4J
         TcWQ==
X-Forwarded-Encrypted: i=1; AJvYcCXUfOBnkUGknyQpIf0RkLglzIDwYyBdCcXqgvQrXXxjeYf3kIGqg/6MJeQ8VjhOqrlOyVlEut6nV5I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiZ7bhKCG6mE3JpGhxZt9M8CxnUiPj1i8p+ZG60qQDu9Z0kuQa
	3hxqPhbQYo0cvLHSVNiojWVs8SZKG6VCMt+B9LumE//kukwcB2uFIorm
X-Gm-Gg: AZuq6aKwgA3c6om7OfizyCUCG6P2fHr5OPQh8NMrQAEa2ai7AKYzLLiOKkk+ss19dIf
	88Is1QNZ6JKqw6rkEdIzuc/gJTP9I6/dHudW+C/qRvUF4iVkTfjkGWAHxVUyuvtbAOP2Nvw2OSm
	V4OXy9ZeZQz9W/qlh/n3+AZTqRceb6/OE6Pk40oOk64veL8FGOY1T8Gze1aaoz/cC79pjP27yjK
	66Ia62WKvIgM1vskmKYAlv4F1ad9Rfgt45fThqDiS5d4njkS3OAJmGP0i1+745ji2jPzRwa7Tk1
	wuyxp0nfREfYU9Ms6FX1JyDK6vAhnTYpBfUq+9/cK5/gCdEQQHb2P4BFubM/pOVh0Tvr301gYjt
	5dWBWEFdC6wa1Rsh8uL+UlIwJc285CdFMm/hV8ywFVkXANaEGIzH6lVq9hk4yfdZAZ3ySYNPfYK
	l70GYKA4t7ch6e8yhQNQyU6LCn8zfTSaAOqjDMLBEVgw==
X-Received: by 2002:a05:6000:1a8b:b0:435:dba0:736c with SMTP id ffacd0b85a97d-43797927177mr5593289f8f.56.1771000361492;
        Fri, 13 Feb 2026 08:32:41 -0800 (PST)
Received: from [192.168.1.187] ([148.63.225.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796acffcesm6118496f8f.37.2026.02.13.08.32.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 08:32:41 -0800 (PST)
Message-ID: <a94e08378199529d30b6c4e33dc9397fd499820c.camel@gmail.com>
Subject: Re: [PATCH v3 3/5] iio: backend: add devm_iio_backend_get_by_index()
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>, Lars-Peter Clausen	
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron	 <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?=	 <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring	 <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley	
 <conor+dt@kernel.org>, Olivier Moysan <olivier.moysan@foss.st.com>, Mark
 Brown	 <broonie@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, 	linux-kernel@vger.kernel.org,
 linux-spi@vger.kernel.org
Date: Fri, 13 Feb 2026 16:33:23 +0000
In-Reply-To: <20260213144742.16394-4-antoniu.miclaus@analog.com>
References: <20260213144742.16394-1-antoniu.miclaus@analog.com>
	 <20260213144742.16394-4-antoniu.miclaus@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-02-13 at 16:47 +0200, Antoniu Miclaus wrote:
> Add a new function to get an IIO backend by its index in the
> io-backends device tree property. This is useful for multi-channel
> devices that have multiple backends, where looking up by index is
> more straightforward than using named backends.
>=20
> The new function directly uses the index to find the backend reference
> in the io-backends property, avoiding the need for io-backend-names.
>=20
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---

LGTM

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

> Changes in v3:
> =C2=A0 - Refactor __devm_iio_backend_fwnode_get() to reuse
> =C2=A0=C2=A0=C2=A0 __devm_iio_backend_fwnode_get_by_index() instead of du=
plicating
> =C2=A0=C2=A0=C2=A0 the lookup logic
> =C2=A0 - Use __free(fwnode_handle) for automatic cleanup instead of manua=
l
> =C2=A0=C2=A0=C2=A0 fwnode_handle_put()
> =C2=A0 - Set back->idx unconditionally in the by_index path
>=20
> =C2=A0drivers/iio/industrialio-backend.c | 61 ++++++++++++++++++++-------=
---
> =C2=A0include/linux/iio/backend.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 2 +
> =C2=A02 files changed, 44 insertions(+), 19 deletions(-)
>=20
> diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industriali=
o-backend.c
> index 447b694d6d5f..d90a3a0b17c6 100644
> --- a/drivers/iio/industrialio-backend.c
> +++ b/drivers/iio/industrialio-backend.c
> @@ -949,25 +949,16 @@ int iio_backend_data_transfer_addr(struct iio_backe=
nd *back, u32 address)
> =C2=A0}
> =C2=A0EXPORT_SYMBOL_NS_GPL(iio_backend_data_transfer_addr, "IIO_BACKEND")=
;
> =C2=A0
> -static struct iio_backend *__devm_iio_backend_fwnode_get(struct device *=
dev, const char *name,
> -							 struct fwnode_handle *fwnode)
> +static struct iio_backend *
> +__devm_iio_backend_fwnode_get_by_index(struct device *dev,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct fwnode_handle *fwnode,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int index)
> =C2=A0{
> -	struct fwnode_handle *fwnode_back;
> +	struct fwnode_handle *fwnode_back __free(fwnode_handle) =3D
> +		fwnode_find_reference(fwnode, "io-backends", index);
> =C2=A0	struct iio_backend *back;
> -	unsigned int index;
> =C2=A0	int ret;
> =C2=A0
> -	if (name) {
> -		ret =3D device_property_match_string(dev, "io-backend-names",
> -						=C2=A0=C2=A0 name);
> -		if (ret < 0)
> -			return ERR_PTR(ret);
> -		index =3D ret;
> -	} else {
> -		index =3D 0;
> -	}
> -
> -	fwnode_back =3D fwnode_find_reference(fwnode, "io-backends", index);
> =C2=A0	if (IS_ERR(fwnode_back))
> =C2=A0		return dev_err_cast_probe(dev, fwnode_back,
> =C2=A0					=C2=A0 "Cannot get Firmware reference\n");
> @@ -977,21 +968,35 @@ static struct iio_backend *__devm_iio_backend_fwnod=
e_get(struct device *dev,
> con
> =C2=A0		if (!device_match_fwnode(back->dev, fwnode_back))
> =C2=A0			continue;
> =C2=A0
> -		fwnode_handle_put(fwnode_back);
> =C2=A0		ret =3D __devm_iio_backend_get(dev, back);
> =C2=A0		if (ret)
> =C2=A0			return ERR_PTR(ret);
> =C2=A0
> -		if (name)
> -			back->idx =3D index;
> +		back->idx =3D index;
> =C2=A0
> =C2=A0		return back;
> =C2=A0	}
> =C2=A0
> -	fwnode_handle_put(fwnode_back);
> =C2=A0	return ERR_PTR(-EPROBE_DEFER);
> =C2=A0}
> =C2=A0
> +static struct iio_backend *__devm_iio_backend_fwnode_get(struct device *=
dev, const char *name,
> +							 struct fwnode_handle *fwnode)
> +{
> +	unsigned int index =3D 0;
> +	int ret;
> +
> +	if (name) {
> +		ret =3D device_property_match_string(dev, "io-backend-names",
> +						=C2=A0=C2=A0 name);
> +		if (ret < 0)
> +			return ERR_PTR(ret);
> +		index =3D ret;
> +	}
> +
> +	return __devm_iio_backend_fwnode_get_by_index(dev, fwnode, index);
> +}
> +
> =C2=A0/**
> =C2=A0 * devm_iio_backend_get - Device managed backend device get
> =C2=A0 * @dev: Consumer device for the backend
> @@ -1008,6 +1013,24 @@ struct iio_backend *devm_iio_backend_get(struct de=
vice *dev, const char
> *name)
> =C2=A0}
> =C2=A0EXPORT_SYMBOL_NS_GPL(devm_iio_backend_get, "IIO_BACKEND");
> =C2=A0
> +/**
> + * devm_iio_backend_get_by_index - Device managed backend device get by =
index
> + * @dev: Consumer device for the backend
> + * @index: Index of the backend in the io-backends property
> + *
> + * Get's the backend at @index associated with @dev.
> + *
> + * RETURNS:
> + * A backend pointer, negative error pointer otherwise.
> + */
> +struct iio_backend *devm_iio_backend_get_by_index(struct device *dev,
> +						=C2=A0 unsigned int index)
> +{
> +	return __devm_iio_backend_fwnode_get_by_index(dev, dev_fwnode(dev),
> +						=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 index);
> +}
> +EXPORT_SYMBOL_NS_GPL(devm_iio_backend_get_by_index, "IIO_BACKEND");
> +
> =C2=A0/**
> =C2=A0 * devm_iio_backend_fwnode_get - Device managed backend firmware no=
de get
> =C2=A0 * @dev: Consumer device for the backend
> diff --git a/include/linux/iio/backend.h b/include/linux/iio/backend.h
> index 7f815f3fed6a..8f18df0ca896 100644
> --- a/include/linux/iio/backend.h
> +++ b/include/linux/iio/backend.h
> @@ -237,6 +237,8 @@ int iio_backend_extend_chan_spec(struct iio_backend *=
back,
> =C2=A0				 struct iio_chan_spec *chan);
> =C2=A0void *iio_backend_get_priv(const struct iio_backend *conv);
> =C2=A0struct iio_backend *devm_iio_backend_get(struct device *dev, const =
char *name);
> +struct iio_backend *devm_iio_backend_get_by_index(struct device *dev,
> +						=C2=A0 unsigned int index);
> =C2=A0struct iio_backend *devm_iio_backend_fwnode_get(struct device *dev,
> =C2=A0						const char *name,
> =C2=A0						struct fwnode_handle *fwnode);
