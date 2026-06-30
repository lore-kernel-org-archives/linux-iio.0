Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C40C3C2BBA
	for <linux-iio@vger.kernel.org>; Tue, 30 Jun 2026 16:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782838329; cv=none; b=qWHFIqkqyVuVYO9pkGK5Q7OBSYTjokGYfXfh4b/1XzjfYiX7etMDt0N7e6T8GM6138IYL1C10gMAPoxbFxdhyX9gz5QNU49//S7e1A/5L7Qk9qeaUrbOG9LKbubo0BClHMcuVtHISjBZEpIY1TooN9cwUCoJwOj2UmC+S4vWYJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782838329; c=relaxed/simple;
	bh=p9qdUI/lUknXQnCWsii2SSCvYgUqIEJrzVQ1fSz/k8s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o8m9tpnGNkDBGl2weodY/eytS0hDLTILSwrJolfUxE+mnGfD0UGfUmRcWK1AT+CKYC6/2qpS3D6F24u70mv10fW8E5DnTwyRkFZT/VUcD3p7DsZCg7+CPje3dn+xDtNzP+AMJP0hw1kM3D+bIn2srJ9X4rfBtOTzMMP5B3C873I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=H8Zthvmp; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="H8Zthvmp"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-493bb510ce4so6868255e9.1
        for <linux-iio@vger.kernel.org>; Tue, 30 Jun 2026 09:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1782838326; x=1783443126; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1oD4crJkupbrs2P0dPAh7zAFV05yZx0M25Kw9ZEhuPw=;
        b=H8ZthvmpUdk8IFvzuo5z2hoR3O7xNKMLnJqzMWvNYxAjxJuxDGqmpNZ8y0uDdjTRp8
         jbhUI2Yn0WN0sKok8NBnuNsejY11K54kxZKbXMIukLUmb+UNu82htf5RLFgfZ7oGJGok
         gNo33X/4kZuPdD1JmcrumZOyD23RTJqLz7DQy9jMC055u9crZ3LNe+iR6/yIyptSZ/Bw
         Sn6FQa2OjCFri+dyTmqDRg8F8Tf9o4jF6swZygi6vzPBkU+uK3oBvG5Pd1fIrRyzaL4f
         t1IwJm3hG43Y4Wso3HnGarakLcmivTr79cGXDQoBzkfsmvEngT1Ty9TuFOhonheqx0Zm
         c0Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782838326; x=1783443126;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1oD4crJkupbrs2P0dPAh7zAFV05yZx0M25Kw9ZEhuPw=;
        b=VWQYcAVYcn8tnB11gIlPT6XhBbzeShmU7obzIZVYmd395T3TMZMXTB5+7J0xO0oZej
         dx/X2Zm6d320EViJMYrQocGkxlVAQDmBdbQEBl/NYQO7VBlAHe680KHgFTInygGP2sUX
         /kCoSxSwsByHkStAziDQ+hT0xJ8/5+cPMpI8uSbwbtU5fs9UFwChU0GlgjD2g9UqrBdF
         /W85EBbnuZIvdxSqP1sCJRgxRcJeNi1oY7JUE2c88895wWvviGJoLPWJpQb3cxWTZgUC
         RzzTPaHL76xFZk24pZfIiz3WN0MhmfFUcXpixSxjF6dToksk2vMA5+zIwCfPsXY5arSP
         uuTg==
X-Gm-Message-State: AOJu0YxHGxnsaTKq4j1HANnCmcFq6jTMXrXaBwsYzLdLw4kJ1ey21uBS
	A+O3qqnR6Cwo42QTsv/2B14FHV0CDXqEiNOlXKFrSPExghLLNwCCCHphxdK7wg3g0X8=
X-Gm-Gg: AfdE7cmVIzZFPHjM9d/lJUe/z/gdrm5X1cWjMDMJc9z8ofNsu/dmGefWwe7ni67IlJm
	heljb/HPFnaAym2ejTwwJvKRred+NsGaczEb+1CWpPvy9OeqhNWlDDX04WUH83iUxRq2Me8+PEl
	qWbkQ3sb77SwDzjOye0uLoXjOh98aSlmF2wq6B1DfZ3pY/6I5+Fd6z76YU707+PGbvF18BS6B5i
	J+eGQwDoMmQosgqJPT2H3Z6oNZ1f/lvhsbQb7gqdhZ/7cxcgnng0NX1AqwuaAr92qpZIlVI/afO
	7sfQT/fxBXmmTBBQVwakWmJdv7ldMw9scPGlba/XoMb5L0r4lJcy2nfzxBaBr9/5eUVh17GiQSA
	U0bQXHXNseDG582pX3C5gVW7Ss/8dcYctGWHgw0JqUk9cAgQmPrDr0Rnf3acegsUXgUCSVUi2im
	PD/VPIRCcmz8a3ouTC/ECG7aVSmjzuLAu94ZFoS2lS+/zCL9eSLqtxUCoaqSzZICdgrcL4h6Rg/
	cgfVDzxqocGmuo=
X-Received: by 2002:a05:600c:8114:b0:490:e190:3b50 with SMTP id 5b1f17b1804b1-493b8287298mr63861575e9.9.1782838326380;
        Tue, 30 Jun 2026 09:52:06 -0700 (PDT)
Received: from localhost (p200300f65f47db042a9b551def0a6b94.dip0.t-ipconnect.de. [2003:f6:5f47:db04:2a9b:551d:ef0a:6b94])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-47567884770sm9584973f8f.33.2026.06.30.09.52.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 09:52:05 -0700 (PDT)
Date: Tue, 30 Jun 2026 18:52:04 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Md Shofiqul Islam <shofiqtest@gmail.com>
Cc: linux-iio@vger.kernel.org, jic23@kernel.org, dlechner@baylibre.com, 
	nuno.sa@analog.com, robh@kernel.org, krzk+dt@kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/1] iio: health: add MAX86150 ECG and PPG biosensor
 driver
Message-ID: <akPz88UyBcppAXzx@monoceros>
References: <20260623140113.12574-1-shofiqtest@gmail.com>
 <20260623140113.12574-2-shofiqtest@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4mn3rmgxh7bhldsh"
Content-Disposition: inline
In-Reply-To: <20260623140113.12574-2-shofiqtest@gmail.com>


--4mn3rmgxh7bhldsh
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH 1/1] iio: health: add MAX86150 ECG and PPG biosensor
 driver
MIME-Version: 1.0

On Tue, Jun 23, 2026 at 05:01:13PM +0300, Md Shofiqul Islam wrote:
> +static const struct i2c_device_id max86150_id[] = {
> +	{ "max86150" },
> +	{ }
> +};

Please use a named initializer here, i.e.

	static const struct i2c_device_id max86150_id[] = {
		{ .name = "max86150" },
		{ }
	};

See
https://lore.kernel.org/lkml/20260515103150.164887-2-u.kleine-koenig@baylibre.com/
for the rationale.

Best regards
Uwe

--4mn3rmgxh7bhldsh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmpD9DEACgkQj4D7WH0S
/k50agf5AXgF95nsug1XdkRpr7QReE2M4gY+aXGupfL9FLijTJVIMlEUEgahumfb
7KGqJ/jcH3nJyBLFUTamSRkYMyh+pxSi1lD96xGSDkhfme5DAgPJvHH4DXr6WjKU
v4ksv6Zg2WVsgi396pzoCUKQjNTV5M2g6GbJ6nuOUz6iRUKQsvwYgYS0RSNSGSKt
n9Oeg8KaI259VVuHY1wMQjGmVjCAnqqyeBj9RhehWZhdUVys8sqBjoIpZmM687lB
+ZiXBfzC/EhaKF4gBn3zbDjB1hllwHAsgLpVWn2DUkytgb3BFVXYE08mDYFcDFux
zu3Ld2CN/7hyhfHrdXkFaBUBC7zcuQ==
=IDGH
-----END PGP SIGNATURE-----

--4mn3rmgxh7bhldsh--
