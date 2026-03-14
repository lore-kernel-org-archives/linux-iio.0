Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319C1279334
	for <linux-iio@vger.kernel.org>; Sat, 14 Mar 2026 10:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773485542; cv=none; b=YacOWLQ2g48x1Mn/I9uQUM/QHaiG31qQAs1O4MkmWznfIEdOFDv+KcdEj+lhDQViO8yVdotlhzW4Z4LvQy3xM2W6WHYYcbJAxdkCS/vcCKbPpB/uUCo6udZJS6Fk/w9sq6mL1KmIItA7KXzIJtDIGSriwx1jdyUeSRRRV7nA1iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773485542; c=relaxed/simple;
	bh=sW48G7WREIPgOi419kvooa49/ZlnypsboLknbzYxG5U=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BD4J4if9j3vY6OQMu94/STyGKMZ4mCSIhKEzCr2nLcFJ7OsvLyKKGUEyqGuCb5gdjV+ZG2mYmZR3GSYM9wAzvxhFI5WlAyNz3a5/BLnr6b/5UiaWWy3SCjdlGflt7qQmOHqja/ZPPVsSKCfr0kb6HPM5cMkTe+wzea1HDHdTlGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EF+j8wso; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EF+j8wso"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-439a89b6fd0so2975626f8f.2
        for <linux-iio@vger.kernel.org>; Sat, 14 Mar 2026 03:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773485539; x=1774090339; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ErKx3equV1FxAke8zHO6Glgi2rG62nsHrQe2I4bcMho=;
        b=EF+j8wso5Fo7AzGSUUeRULPIEEgtoo1Y9FmdOfMXgZxQLy0TFovxiFFDm6egCpHiQi
         xhaUtzxvr2w4V3Whv6eF+eA7HoX51GKoJ01eN5C18GxQS5SkHAVZM0oihOsLinTFJC3R
         Z4wGCEz6x8YH221pnOAum2bWp2YeYA8pZkQDlwoaMaVgwFHR7hDfDCRDKUsQGNCUZmnu
         2h10F8GzbSco7wLA6gS9PMLNsJDYWg32pDlK0R3RnUkd/zwqzW6CfTLUwwqvfumL/puL
         AkVE9Sg85sOsJUNixLq7xrv3D70DP2iFBvhnjuyzTrR+kW5oAOgXeaDaEiZx+aduG/Tr
         Z2Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773485539; x=1774090339;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ErKx3equV1FxAke8zHO6Glgi2rG62nsHrQe2I4bcMho=;
        b=TXnEc430JT99LDTvqFrmI5mGN2G2rY3m3pI3uyNaUVSycEyaHRf0H+hZA7bt2Zih0M
         TVh4fQWiliu+pRygCxWJF5xrh9jQAh1xEUpw0MMkt1rn6/BlU/28aic9CYap+xbgQoSS
         KHssWBSXzDsKfd/hG/k/5XtNbO58FmUXLNMFQiu7w2VakwxcTCysL6SRAFCFgh5SX7s1
         r7KBGhlkumPrM9vVGI+0wE6BRGEZ2lCNk+M0Q99O0mY7C1eGy4jo5o5x78zTR+s09RO7
         o6AP2FfIxu2t8m8xUT1CPRI6eK/4LTPIcha4Gf9vHxOMFXj37LS31VaT4pK+M3WSyZbT
         D4hw==
X-Forwarded-Encrypted: i=1; AJvYcCUTMNuAzGHdrE7432dXiqGA6I3LKiqIPAluwBlsrgWuhrDv//RZWu2AnZMJJkDezJvLzp+ZX/nWKqg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwznZ6U2/ZGo+CSJeVkCFiNl0eAHv4AYTXm4cLnB6sFG56hSPiZ
	w6RCK4c92fv9r9gj544H488Z47jZjL9Ejwgel2t2GVLUn+PR+95wfcXm
X-Gm-Gg: ATEYQzwxanuGl+xYST9hUbQVqChSdibbH7Ic7U3XV9Z8MGPGLltJhezZ5GMDV+mpPFG
	kuhcdCn8L47t8fp8Qv1HXFYy4slBkLI0C9VJPb6R1CfEtCv6IJw04oXbgt22b+uzrtXtSFCJkFv
	+lXia7+pJgLkL0iIdg3JAtB4liYlH2uKDDuLqOgscmTa0bwmizN6KSDfcZuPH3v9cjDT8OxOTBb
	2ph/08jiZ9jZLu3fzeCsVDQMR0piRTsFlgzS/AdizVtRZshokf4EKysGxTLp12vcySrt+iQZPw8
	5G/bl0l2swjfBOQPeleISojr1/Vvgnuy+gHJLs7GNtIVYmsMO7vcmM4+zp2c5qhWkDIvzQmhlbu
	2wj2h4iD55jWfUQaZg9ki7wPhtHqtoM0NA/xmUTFVz/z0rLinthE/NntzvmLfJsEo+25uWcg0rh
	tc5SN6pvICqWbzFeSSMDfXULEYdZ17Ie9sis6iPqD1k4VsmyzCvWLLAfEIfJcTu1+Ca9SGhxw=
X-Received: by 2002:a05:6000:609:b0:439:c9d0:5fd4 with SMTP id ffacd0b85a97d-43a04d8c258mr12342846f8f.16.1773485539285;
        Sat, 14 Mar 2026 03:52:19 -0700 (PDT)
Received: from ?IPv6:2001:818:ea56:d000:94c4:fb0e:28f:2a8d? ([2001:818:ea56:d000:94c4:fb0e:28f:2a8d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe23afc5sm28305833f8f.39.2026.03.14.03.52.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2026 03:52:18 -0700 (PDT)
Message-ID: <13defdd2f744f8b94e47235035f7d8f29893dab7.camel@gmail.com>
Subject: Re: [PATCH v6 1/4] iio: backend: use __free(fwnode_handle) for
 automatic cleanup
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>, Lars-Peter Clausen
	 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron
	 <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?ISO-8859-1?Q?S=E1?=
	 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
	 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	 <conor+dt@kernel.org>, Olivier Moysan <olivier.moysan@foss.st.com>, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Sat, 14 Mar 2026 10:53:24 +0000
In-Reply-To: <20260313115856.87763-2-antoniu.miclaus@analog.com>
References: <20260313115856.87763-1-antoniu.miclaus@analog.com>
	 <20260313115856.87763-2-antoniu.miclaus@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-03-13 at 13:58 +0200, Antoniu Miclaus wrote:
> Convert __devm_iio_backend_fwnode_get() to use the __free(fwnode_handle)
> cleanup attribute for the fwnode_back variable, removing the need for
> manual fwnode_handle_put() calls. Move the declaration closer to its
> first use, narrowing its scope.
>=20
> No functional change.
>=20
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

> Changes in v6:
> =C2=A0 - No changes
>=20
> =C2=A0drivers/iio/industrialio-backend.c | 6 ++----
> =C2=A01 file changed, 2 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industriali=
o-
> backend.c
> index 447b694d6d5f..58f7e1426095 100644
> --- a/drivers/iio/industrialio-backend.c
> +++ b/drivers/iio/industrialio-backend.c
> @@ -952,7 +952,6 @@ EXPORT_SYMBOL_NS_GPL(iio_backend_data_transfer_addr,
> "IIO_BACKEND");
> =C2=A0static struct iio_backend *__devm_iio_backend_fwnode_get(struct dev=
ice *dev, const
> char *name,
> =C2=A0							 struct fwnode_handle
> *fwnode)
> =C2=A0{
> -	struct fwnode_handle *fwnode_back;
> =C2=A0	struct iio_backend *back;
> =C2=A0	unsigned int index;
> =C2=A0	int ret;
> @@ -967,7 +966,8 @@ static struct iio_backend *__devm_iio_backend_fwnode_=
get(struct
> device *dev, con
> =C2=A0		index =3D 0;
> =C2=A0	}
> =C2=A0
> -	fwnode_back =3D fwnode_find_reference(fwnode, "io-backends", index);
> +	struct fwnode_handle *fwnode_back __free(fwnode_handle) =3D
> +		fwnode_find_reference(fwnode, "io-backends", index);
> =C2=A0	if (IS_ERR(fwnode_back))
> =C2=A0		return dev_err_cast_probe(dev, fwnode_back,
> =C2=A0					=C2=A0 "Cannot get Firmware reference\n");
> @@ -977,7 +977,6 @@ static struct iio_backend *__devm_iio_backend_fwnode_=
get(struct
> device *dev, con
> =C2=A0		if (!device_match_fwnode(back->dev, fwnode_back))
> =C2=A0			continue;
> =C2=A0
> -		fwnode_handle_put(fwnode_back);
> =C2=A0		ret =3D __devm_iio_backend_get(dev, back);
> =C2=A0		if (ret)
> =C2=A0			return ERR_PTR(ret);
> @@ -988,7 +987,6 @@ static struct iio_backend *__devm_iio_backend_fwnode_=
get(struct
> device *dev, con
> =C2=A0		return back;
> =C2=A0	}
> =C2=A0
> -	fwnode_handle_put(fwnode_back);
> =C2=A0	return ERR_PTR(-EPROBE_DEFER);
> =C2=A0}
> =C2=A0
