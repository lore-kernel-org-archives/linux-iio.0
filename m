Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2B3344DAA
	for <linux-iio@vger.kernel.org>; Wed, 28 Jan 2026 09:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769592818; cv=none; b=QV6FhkO/U7++qCvh7TIMY7iEFMyNzDctMHHoHtPnQSnu9K9r4kABCYWw5l4FGgt5RA5igQBroukyDkI8F6JtOUF9Z/6i72hNxV6/oWDwI9K14QeF2EeryBcyZw68yJNxgDmMcuZNvsK7lFo1TrDM4tY3ruXHaPp9CAvkTvITo9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769592818; c=relaxed/simple;
	bh=H2zibAagF2FTtB9gOHD4qNLVT9VFk9BWPjT7M2JTCdw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bZKV2fJr4cVuD2tEzwnLsRObV091UJdwBygqe3YH23Ws2ED/FWVh0+ip9JYgdaJFi+qz39ZlmcYS+l23UmKMEyxHFnJKv3JmzxlRVtwlGmgnLJoONqmw2a0mFIrEV6Bkvt1af9sQmjhfRmwfzCOGhPpKcMoF1cDeGZ2h5A5JxKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JXWKguCl; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JXWKguCl"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-47edd9024b1so54980145e9.3
        for <linux-iio@vger.kernel.org>; Wed, 28 Jan 2026 01:33:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769592816; x=1770197616; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TNYvY6oOH6n+xcex5RDHCxx+n1ZkeBiAi+G6kKR3x2Q=;
        b=JXWKguClVyCn6BDinNcYnC3LR2pkU6Zf6OR5/gdaXtp8z3aRpRtqoqeTCk8A35GcYj
         zl8oweponBehf399gca0WuzpT2EAWpU9x7Klch6azwC7uiOG9y2P76j8WByIe+h1pxri
         lwceUzdq+lOoqB830sxSjY/CnmKDZ+ib+G+oBQ1gmkR+D7wv9gMhTt5yatDnTtqCaBj8
         duV4GYwcWylP3Hu2RsUJbyvqP7CPeTsjnHRP8K048QC4ut6/hhUr+h4f5Xcn9siw3ulw
         JcnKoFzWT9V9UWkcv2LpKqoByyErz+GqcZs2nAIkGWx/mzSvP5LmDE6IZMD7IY30rB8n
         C3lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769592816; x=1770197616;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TNYvY6oOH6n+xcex5RDHCxx+n1ZkeBiAi+G6kKR3x2Q=;
        b=tixn1cRre9OlQITm2gluRV/8mstaInsiqlxOZoX0Nji/Szj+hB+VlmztHejxCcL1Pt
         zDsFnyqCKK78i54Rxg6GBOms8InC6p6MGpRQjSLZZUX6FCXo6mLwuX7rRHHO4OfP45De
         8QDT2WZ5QQNYc0EqCUfLLLttapfVpisuWpDyyYYvvrLkdCQClzu0Pnz2bybms5OdUo1X
         gnfuQ5F/eTyMEUWqo1kjVgJ2Yx7xaOWASlQiQ0otxEdyulTbJDhS53NXSJ8rgPV36mXN
         ay+YEDXYspIYw5ERPZ28EgKIYlm9SSK0lo+Zik3i013Rn6yR3ahS0VA3JpxusCBNxo/1
         3Wkg==
X-Gm-Message-State: AOJu0YxaRby6xIu9q7lvlfNgUvSL07MNu78zU/UnGSWKPMdGzMPVXZz9
	nOXwG4MiRr1dqL0fANl0unAIL09yg7nBd7JPJA9M750qeYCTpF5JfrVw
X-Gm-Gg: AZuq6aLcYTHuhm1LHuAb3h6Omqr3tSq6ZCiXJCQbf2Yixo7NPNtxVl19IGsMn5rxXdE
	4k9M37Lr8WHNZT+C/q8S4D7Sb1DxKnto0D6oP0qHkTrdRRWk3EJ+JIurOvRhqW+pcaqAlg/9jcw
	fq5HjCkAxrWlN5+BsECwMpXMG91e2BMzB5KOR48VHJNd3gz4zQkBKqwzobDQSD6oGthSvTfUTSf
	na/OYBW4JD43WtD+cE3D2Pvj2iZrUO+/EWGQhLk929PmDuut6f1n58gwAbzUidM9rSYw5O3qr15
	j47zYDdgKRI9jdopgaNMtkjyd9zTNeOBQZAgIaxsUYcec/7QxW9uAPcITngr+5l1tmYkU8Ysu4s
	DFlAo1VMiYRLhViGgN+ZwHIx/JAw7/TrEwiCoFMrn0NmyMZ7WNeQOdab+WOJETE3rLsUBQP/leP
	r90nyINjJFPBZQlt8uCZs=
X-Received: by 2002:a05:600c:450b:b0:47d:25ac:3a94 with SMTP id 5b1f17b1804b1-48069c788a3mr56199605e9.17.1769592815480;
        Wed, 28 Jan 2026 01:33:35 -0800 (PST)
Received: from [192.168.1.187] ([148.63.225.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4806ce56068sm47030305e9.13.2026.01.28.01.33.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 01:33:35 -0800 (PST)
Message-ID: <5b0471519e4fdefd41c5d951401483cde3e49f19.camel@gmail.com>
Subject: Re: [PATCH] iio: addac: ad74115: Add missing check for
 device_property_read_u32_array
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Chen Ni <nichen@iscas.ac.cn>, lars@metafoo.de,
 Michael.Hennerich@analog.com, 	cosmin.tanislav@analog.com,
 jic23@kernel.org, dlechner@baylibre.com, 	nuno.sa@analog.com,
 andy@kernel.org
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 28 Jan 2026 09:34:18 +0000
In-Reply-To: <20260128043040.2260887-1-nichen@iscas.ac.cn>
References: <20260128043040.2260887-1-nichen@iscas.ac.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-01-28 at 12:30 +0800, Chen Ni wrote:
> Add check for the return value of device_property_read_u32_array() and
> return the error if it fails in order to catch the error.
>=20
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
> ---
> =C2=A0drivers/iio/addac/ad74115.c | 6 +++++-
> =C2=A01 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/iio/addac/ad74115.c b/drivers/iio/addac/ad74115.c
> index f8b04d86b01f..d0d6c0575ff1 100644
> --- a/drivers/iio/addac/ad74115.c
> +++ b/drivers/iio/addac/ad74115.c
> @@ -1515,8 +1515,12 @@ static int ad74115_setup_adc_conv2_range(struct ad=
74115_state *st)
> =C2=A0	};
> =C2=A0	struct device *dev =3D &st->spi->dev;
> =C2=A0	unsigned int i;
> +	int ret;
> =C2=A0
> -	device_property_read_u32_array(dev, prop_name, vals, 2);
> +	ret =3D device_property_read_u32_array(dev, prop_name, vals, 2);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to read %s prop\n",
> +				=C2=A0=C2=A0=C2=A0=C2=A0 prop_name);

Thanks for the patch but this is intentional. Not a mandatory property. If =
you want, you could
do

if (ret && ret !=3D -EINVAL)
	return dev_err_probe()

Not 100% sure if that is the proper error code but the goal is to only erro=
r out in case the
property __is__ present but wrong. However we are kind of relaxed with the =
above in IIO.

- Nuno S=C3=A1
>=20
