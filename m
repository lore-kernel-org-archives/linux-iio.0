Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED0435CB8F
	for <linux-iio@vger.kernel.org>; Mon, 23 Feb 2026 11:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771845173; cv=none; b=eIXA+tTICZ+uY3/NVJklf+drvIRj/i8330FLvoir9tXx1bjfJiLJZDkQpVKvoIZsIoCpFsxfvtyTqnEInYpN/JPNHMVg7/JN2klkeyfSAFutpinkxdPrjU10A4IH8JQdqgYfz4ROn2MU90MTWaqVvNlsqI+AGA6sBznMx/dEZQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771845173; c=relaxed/simple;
	bh=q8eA+W36LX/ybN8wpBbHn5OQ+mGmGjizeB/KQ0As6BM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sO/d3OyErP7mUtjIfKKe31sBPWhp1Ul+cN9XYpVbYvPdCGIVR+m7P/IolCiX1krLpcxliZzHmdfAQvmxU2BegSSKOXAmrecy7/F07eLZLpt6S4p/soZ9BgpdXGF7jVSBSO1YeS1hYmt2K02tSHfEnBKIR88bMzNz5mccmsoNvdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ad4+yNdl; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ad4+yNdl"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-48334ee0aeaso30540995e9.1
        for <linux-iio@vger.kernel.org>; Mon, 23 Feb 2026 03:12:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771845170; x=1772449970; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xnKDf+x7HLHllT2OTm2TYnpcf3b4bSzsLYz0UOALcks=;
        b=ad4+yNdl8Tzhv4YEE1rz7gOaW0NU5PjX5oSjwGf385dagtmGevet/HRtjZl3RU+MKb
         asDhtfmx20n7mfGIh9axKBXVP9Yxy8Y6h+8CJ5egg/AU+lav4U3KggdgtjJjxOxRA0tl
         c6HCS9k+FHnHJilmrUECSsCjLoa/0YIIEKF4Xzatnic6vddPd3dkfwHFwM5ci7kg6kqh
         ZTah0z6bLP4EcMipUU0tSnhI53yGIChK5rh5ubKEfpFs684209nzChFzqfsIi9Y+gu73
         CvaoWEM1U37aL7aDwL77pba2XefPfz5BQ90Oc8s9rUbiWRQ3ZHQ1TYqE18GPXpoZ3dIh
         9yCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771845170; x=1772449970;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xnKDf+x7HLHllT2OTm2TYnpcf3b4bSzsLYz0UOALcks=;
        b=siYdtxehL1Nm2tI2b9aG/X9al9cxvc2Qkm6jfWo9af/e4uLOOX9xcVe4UyItBRV/xP
         5zAg0N26snMpiG/YbLqFvRagVCP7a75t0QFm1vmqZVsIz4UJloH2asE5ijnjnRPrfnXF
         19hS5gWzIhVQG6lXNdaZELuJwTcsmnSOWwTdBRUPqNrGnaYoNOHVD8L16Y7MDrQprnbD
         a6fdPKIJB4Z2KqLJc3nB3DovtBaA9/EKihCU3kCh9XQnGYmwf7WbBnsibTqQ7LQfm8rF
         r7zwd0oNJEx7C1FMgThVnGMS6l2CDQqD4dQRnlGACI9XeWOoGLPC0kPDLRsfCm4pu32C
         TKzA==
X-Forwarded-Encrypted: i=1; AJvYcCWKc5Yw2jTL+cZpm7cX7LiMDTOG4B3NbQipFMLae7w4gT8bRm3c1abg513LMJI8RCzxj9Kk/3LSWjI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxh953gsYxKt/g111kguXv47y9PUrU8YkWJF0TEgWiBHcVpgFKA
	tb6cCL2BEqL4U7e24To1y7rwYBfwDHVOGfwqNoPEdaGKsIuOWq7FPEr8
X-Gm-Gg: AZuq6aIEU2APddUYArQlHJmOfluPhOn7Y85byrSjl7VhkYrIR4ELgPwO7PzA5m+zoZM
	Apvsb8Rm6WAWBjwl9HOBBWa2uINLIiqb/ypkuEdukZIKC0rEsz2FAEXw3mS3d7UXetakBXetaVs
	Oq5daNq1SxRzQZV9BUO1QfgtJn8r3meHOw4o6VtiWY6/q1eB7DK65mrTwQ1Z3Gfirm1vdUHg6Hf
	Xsw4aKPcg5rXfAhRtneVphrRHDyvvT9C5/6c1lmVy/yYkp5XaJUnJn8fh6QibrYMJan6scp8WKz
	U1M0zpiXOOFm1erUKr/h51DLOXBBGeejqCpS7ysnYv3A2eBa87CN07NRobFNzZmZ9ujIy/YoTnv
	EzLWkT9f9i9WUj988ogrKLo/4Hn/s6p6orU5nF9nheaXA07hZs3F2eP3SpQeWoQyn6E6vEUvSBV
	w6kkxPZd+3d5SiYSb+2NgrQxSObuTixjI=
X-Received: by 2002:a05:600c:4749:b0:47e:e970:b4e4 with SMTP id 5b1f17b1804b1-483a95e6ceemr116203185e9.29.1771845170097;
        Mon, 23 Feb 2026 03:12:50 -0800 (PST)
Received: from [192.168.1.187] ([148.63.225.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483a8df83bcsm209099825e9.13.2026.02.23.03.12.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 03:12:49 -0800 (PST)
Message-ID: <0ae976f070b0bf5a13ba5985b8e7d0f1efbb2cfd.camel@gmail.com>
Subject: Re: [PATCH] iio: dac: mcp47feb02: Fix mutex used before
 initialization
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Felix Gu <ustc.gu@gmail.com>, Ariana Lazar <ariana.lazar@microchip.com>,
  Jonathan Cameron	 <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?=	 <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, 	linux-kernel@vger.kernel.org
Date: Mon, 23 Feb 2026 11:13:33 +0000
In-Reply-To: <20260223-mcp47feb02-v1-1-41f80bdbbb45@gmail.com>
References: <20260223-mcp47feb02-v1-1-41f80bdbbb45@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-02-23 at 16:03 +0800, Felix Gu wrote:
> The mcp47feb02_parse_fw() function uses data->lock, but the mutex was
> initialized after this function in probe path.
>=20
> Fix this by moving devm_mutex_init() before mcp47feb02_parse_fw().
>=20
> Fixes: bf394cc80369 ("iio: dac: adding support for Microchip MCP47FEB02")
> Signed-off-by: Felix Gu <ustc.gu@gmail.com>
> ---
> =C2=A0drivers/iio/dac/mcp47feb02.c | 8 ++++----
> =C2=A01 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/iio/dac/mcp47feb02.c b/drivers/iio/dac/mcp47feb02.c
> index b218f0c3a0bd..4ff5abcfecea 100644
> --- a/drivers/iio/dac/mcp47feb02.c
> +++ b/drivers/iio/dac/mcp47feb02.c
> @@ -1131,14 +1131,14 @@ static int mcp47feb02_probe(struct i2c_client *cl=
ient)
> =C2=A0
> =C2=A0	indio_dev->name =3D chip_features->name;
> =C2=A0
> -	ret =3D mcp47feb02_parse_fw(indio_dev, chip_features);
> -	if (ret)
> -		return dev_err_probe(dev, ret, "Error parsing firmware data\n");
> -
> =C2=A0	ret =3D devm_mutex_init(dev, &data->lock);
> =C2=A0	if (ret)
> =C2=A0		return ret;
> =C2=A0
> +	ret =3D mcp47feb02_parse_fw(indio_dev, chip_features);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Error parsing firmware data\n");
> +

Actually I think the better fix is to not lock at all? Why do we need a loc=
k around=20
mcp47feb02_parse_fw() if it's only called from probe()?

- Nuno S=C3=A1
>=20
