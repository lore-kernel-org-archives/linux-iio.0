Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E39F361677
	for <linux-iio@vger.kernel.org>; Fri, 13 Feb 2026 16:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771000751; cv=none; b=S0rgGw2froi7WdHYZRa6b1+kUeRaHWqcw/R0vkK8gYPkbiI+M+oWfE2u2w1Z2Lp/9TPklUaJWEbtXitbsb2nxeCnUOCBqkhU7F4bLFK5i5VI7ojyH8CqFVfCgbVtzLhC+uGhZnJVD8wbK18hPTd3+StB2LVG2Sw7ycpKMf3woCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771000751; c=relaxed/simple;
	bh=GnGObxv/l86GyeIwa8n8wqwf7Ir95LEVqVdBanRdmpU=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iPFSKIWPKdGK08Glgw56zoy5zPDhjym6jQk+1kpWcNNh2Wp6aRWXGL6N9IoAcSBJgG4HVbkQwrXSdN9W0wBpPyoZQWVKtTTw6CT+P2D3rmYcFw7fIau4gtpJodgj7QnOUm3jn5PVS+0FqZCkN5icufzK6SibHncMLhYJd5b4mFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HlvR1fYk; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HlvR1fYk"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4836d4c26d3so8965025e9.2
        for <linux-iio@vger.kernel.org>; Fri, 13 Feb 2026 08:39:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771000747; x=1771605547; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yr07ejpNPZdSsJFPw9OG8vsIRIDGnBouhIbIyj4Wji0=;
        b=HlvR1fYk32jZoqreqJrFmdMbAKiYPruXD69RUDOqZwDh+KBoZ3AgzYSDac1x6OWbAW
         si8Y8qGI83Oew2cAI56xRwjhclVaflc+8dTdsibaXwytkwvMifHJX7ZTYeC4wc8k/gLo
         N89uYqccUAScRVHXr4ymLXpC6DuBIgX5mFWwwzbg8RT7aPg4kb02HVy7mlIY3yU3G15P
         teCWWcRkaOGB1IQJfMDQyXrBQ0Efo3GbNhYjrR7NBH7rhkS94/5xAf7XvzaYeBSB47x0
         SqY61NgxUnB4tDkRSSCLABzUKip5W0QxPnXYROEKGLALOeYpKuxBY4L8M3StZaBmMbzd
         7UDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771000747; x=1771605547;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yr07ejpNPZdSsJFPw9OG8vsIRIDGnBouhIbIyj4Wji0=;
        b=QpEgvnb2VPXFNm2KJem1hzt2kr+UmlkwBCQ/Y01gYLzU6hoanlCURTuNh+gV/zUB4C
         HXFn2R0kVD4ZzsO35QU0R9Rr8atrVe23+thN/22hmH8p5949SS1L8v+XquXxUmaZGogm
         1A2SSVYfWgYy4ITMIzOabnnvVcnzKqe9z6alIFUNuTp3lAmyAd+rB5VU0T79P0WWlpnA
         LniMSlDX4H6EdojqqXj8IGVUReGDvPBtCA+qyo77xldZPk2IXBtF/5xqib35E0VzTjVZ
         Lwe/9/UxlY5oQ6CeXb5NnyUV5us56Xl1mMLsDt6XDr5lDKN5PLDlFPEGOiBQuNUfdfbK
         e54Q==
X-Forwarded-Encrypted: i=1; AJvYcCUcehgxJiVoAPMvdCESjNzQXaTLUlTkT6lSPZ0D5e++oxzzIqNZkI91OxAExsq2ug5URIBLT27O00s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaTlZW5fbc1uvk3Qvz4xXFQ7fmukHq80Iyrg/o6D+LnLDsaAKv
	aa2GZ/888R8aqEE4ojfUzJY+feJcqQXcwuZ/fRyQb435j0z0mPcgm09x
X-Gm-Gg: AZuq6aK6C+ub0H/TXJPjbcVUs1RYSA3Y+2lu9RSMFpuK29TbmZqw4rOCfM4RQXK0PsW
	E3W3UMuSqOJUe4Vpdh3itwnRB9T3IBHnjqU9de5uNDsO/bj4xtU7cJEmI1+n7XqadReL0wXeXt3
	1AoYPGNyrZlp5095YgvXlAk1KzrI4PKqfGbaP11eOre/DyNN+2ejIgV/SfEB8IWFMeNa7JTo1aP
	r+wAbbZzRhHe5G7+sx0wXWHFsaWQ/JMNjHwvaOI1LC2MbNeRFXhfk16uThrikGgSFZpoAHsucxY
	zfiqO0ysBewo9zEgIFiNrFAsUbtSV5cp113DqTJB1O9URroUvFQlrsb6kEVAPE0lYuDs4T+ICtc
	AU2hxbmQKtV1B8nyeFqYwp0AtCqI+UcrIkUNmfiwTVhrGPTZf/JsINW5zXc5bWump/071fhTjCo
	lQ5cfy72dewa3gsnMWzveYJV4kr4voy7FSjg+O+ZQbcg==
X-Received: by 2002:a05:600c:64c5:b0:47b:da85:b9ef with SMTP id 5b1f17b1804b1-48373a10316mr44988775e9.16.1771000747154;
        Fri, 13 Feb 2026 08:39:07 -0800 (PST)
Received: from [192.168.1.187] ([148.63.225.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4834d835f6bsm247848425e9.14.2026.02.13.08.39.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 08:39:06 -0800 (PST)
Message-ID: <dd187a378e7a70a83b095711c7535c1004a0b9af.camel@gmail.com>
Subject: Re: [PATCH v3 1/5] spi: allow ancillary devices to share parent's
 chip selects
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
Date: Fri, 13 Feb 2026 16:39:49 +0000
In-Reply-To: <20260213144742.16394-2-antoniu.miclaus@analog.com>
References: <20260213144742.16394-1-antoniu.miclaus@analog.com>
	 <20260213144742.16394-2-antoniu.miclaus@analog.com>
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
> When registering an ancillary SPI device, the current code flags a chip
> select conflict with the parent device. This happens because the
> ancillary device intentionally uses one of the parent's chip selects,
> but __spi_add_device() checks against all existing devices including
> the parent.
>=20
> Allow this by passing the parent device pointer to __spi_add_device()
> and skipping the conflict check when the existing device is the parent.
>=20
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> Reviewed-by: David Lechner <dlechner@baylibre.com>
> ---

Acked-by: Nuno S=C3=A1 <nuno.sa@analog.com>

> Changes in v3:
> =C2=A0 - Drop redundant NULL check for info->parent in spi_dev_check()
>=20
> =C2=A0drivers/spi/spi.c | 29 +++++++++++++++++++++++------
> =C2=A01 file changed, 23 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index e25df9990f82..693bdcc5a12a 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -641,12 +641,26 @@ static inline int spi_dev_check_cs(struct device *d=
ev,
> =C2=A0	return 0;
> =C2=A0}
> =C2=A0
> +struct spi_dev_check_info {
> +	struct spi_device *new_spi;
> +	struct spi_device *parent;	/* set for ancillary devices */
> +};
> +
> =C2=A0static int spi_dev_check(struct device *dev, void *data)
> =C2=A0{
> =C2=A0	struct spi_device *spi =3D to_spi_device(dev);
> -	struct spi_device *new_spi =3D data;
> +	struct spi_dev_check_info *info =3D data;
> +	struct spi_device *new_spi =3D info->new_spi;
> =C2=A0	int status, idx;
> =C2=A0
> +	/*
> +	 * When registering an ancillary device, skip checking against the
> +	 * parent device since the ancillary is intentionally using one of
> +	 * the parent's chip selects.
> +	 */
> +	if (spi =3D=3D info->parent)
> +		return 0;
> +
> =C2=A0	if (spi->controller =3D=3D new_spi->controller) {
> =C2=A0		for (idx =3D 0; idx < spi->num_chipselect; idx++) {
> =C2=A0			status =3D spi_dev_check_cs(dev, spi, idx, new_spi, 0);
> @@ -663,10 +677,11 @@ static void spi_cleanup(struct spi_device *spi)
> =C2=A0		spi->controller->cleanup(spi);
> =C2=A0}
> =C2=A0
> -static int __spi_add_device(struct spi_device *spi)
> +static int __spi_add_device(struct spi_device *spi, struct spi_device *p=
arent)
> =C2=A0{
> =C2=A0	struct spi_controller *ctlr =3D spi->controller;
> =C2=A0	struct device *dev =3D ctlr->dev.parent;
> +	struct spi_dev_check_info check_info;
> =C2=A0	int status, idx;
> =C2=A0	u8 cs;
> =C2=A0
> @@ -710,7 +725,9 @@ static int __spi_add_device(struct spi_device *spi)
> =C2=A0	 * chipselect **BEFORE** we call setup(), else we'll trash
> =C2=A0	 * its configuration.
> =C2=A0	 */
> -	status =3D bus_for_each_dev(&spi_bus_type, NULL, spi, spi_dev_check);
> +	check_info.new_spi =3D spi;
> +	check_info.parent =3D parent;
> +	status =3D bus_for_each_dev(&spi_bus_type, NULL, &check_info, spi_dev_c=
heck);
> =C2=A0	if (status)
> =C2=A0		return status;
> =C2=A0
> @@ -772,7 +789,7 @@ int spi_add_device(struct spi_device *spi)
> =C2=A0	spi_dev_set_name(spi);
> =C2=A0
> =C2=A0	mutex_lock(&ctlr->add_lock);
> -	status =3D __spi_add_device(spi);
> +	status =3D __spi_add_device(spi, NULL);
> =C2=A0	mutex_unlock(&ctlr->add_lock);
> =C2=A0	return status;
> =C2=A0}
> @@ -2580,8 +2597,8 @@ struct spi_device *spi_new_ancillary_device(struct =
spi_device *spi,
> =C2=A0
> =C2=A0	WARN_ON(!mutex_is_locked(&ctlr->add_lock));
> =C2=A0
> -	/* Register the new device */
> -	rc =3D __spi_add_device(ancillary);
> +	/* Register the new device, passing the parent to skip CS conflict chec=
k */
> +	rc =3D __spi_add_device(ancillary, spi);
> =C2=A0	if (rc) {
> =C2=A0		dev_err(&spi->dev, "failed to register ancillary device\n");
> =C2=A0		goto err_out;
