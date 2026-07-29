Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC174248A1
	for <linux-iio@vger.kernel.org>; Wed, 29 Jul 2026 07:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785310494; cv=none; b=DNtQYvhJGMMO2FELpQVl4ab4itOCQ0sbD653YCQ5tsYqxVm83aBNOTtr5KKX1TNyCvi4HkB/w5Sj0F6RTwDt6yJynahuzKcJKtrRiSGlOT4zJrM6GMLAM4uKPPQdLqY6fKiKw/bQw0OxoCM579/TM5nz+mkv3m0a2FOnDcMwsfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785310494; c=relaxed/simple;
	bh=2M47jzI3GMCSI8tvz+uvp+NPMu46ffAFj6LSFWJX3H8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ABA9MlJpjT0gn+Ig2V19K16APHE1T9KwE38ACysY8JmGa5xAyhyHHr/CBDJMLLcbFFf3s+5BaxK2DH0hBgn/4HZxaCqaKV01LRvUjmrDVFHasaargV+MREWIo2nRUQi0PgBSDdPoGWARle9nDF48/VrrAn7qdUJJDXjt3KB8b8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oro2Jv/S; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oro2Jv/S"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-47f7854678bso254686f8f.3
        for <linux-iio@vger.kernel.org>; Wed, 29 Jul 2026 00:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785310482; x=1785915282; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=J96GiC3Lu8OCM/Ebd7ATNlWx75x2wiMwCn6WDtv6ToQ=;
        b=oro2Jv/Slc5uXuReyUFXa2J06F6B9icXGdCaLPxXbKnXN7LiPK7LntH/RmELENMg6W
         Hm/bmGDCNFEwiWW6h5j433hdoMr/2TfuRrnX4bMyyHQh8OdVnq3IFyGF2sNE1OPGaTIN
         +ygOyBUDc3Rw5rieiTt0acn+pRMMTdWGwAZBQ2BD8KDQenfJfFkvPGgPjbHZ/uME7LRH
         rs+w1KMF3Gq+QfY2C2+WRtxeg0yvaTJ/wOJGNT24EfsjFZmxjHOVd6kAiWQq+ZtTl//E
         TNd22U2DdJiCAODPKRCGx/5uouRiI/Hhrd9dk/r5BlQ5NFDMOd2/sKoT+MeXtl+5A7cU
         VSrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785310482; x=1785915282;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=J96GiC3Lu8OCM/Ebd7ATNlWx75x2wiMwCn6WDtv6ToQ=;
        b=H+Lv2hhNLloAb8DHgRy5WkEbJT9CUkEnHuD+FMKMhO+3dCIs6VP/vmGlN+WtjFvkvk
         RW/zq0Xb+XO1flfxA6f9xOIfOxWPf995oDp0DnWIhpzp5Kk6aclhRMtSyx8E8Z51KeP0
         FPjXbuf6IdW4mt49+fGjWnajacQWTUxxo1mx3qBnGW7Ojqm9kZObfLnlBYJMndlrEqG5
         eekreDkwfv3WjLZe+hPGGvX1S9Y7mOQsuNsMJhsc7nX20ZryLWsmATs6G1cUunAE+cya
         4Z65n7Fn2C7mSwmxIMmWdRU060qk/PxJzYkDDI8EG5AQfCSvQkFeikTRUC6Bgjslgc1/
         af/A==
X-Forwarded-Encrypted: i=1; AHgh+RqJTkNNgk7qR42eqVI4Hz8H9DtknADGJB3kqRs+cBMo8WLcuxmbShemWSNWDS0Qlw6WUjbMByDclMY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzJVp/QAzce0SE2fwImuLsV8NvthlR3IaGLiaoz0V6Bu5lBzNJ
	2zRpsXrkl/ow69YMmDJ2ozofFVagbSYCh/pJs1F6yfvUiDi8vAVRMdNH
X-Gm-Gg: AR+sD10rmbuJrFdQfhFWwKMkt78e58KqvNX3rx9lUlZLQkUJ9wULOaPGDXVqXMyzrcu
	9ufiNJ5y/ftB8hhQa36srijcyuG9WIUuxGtEIAqxKxUqdMeNTpG+BaP3g7bhXFspvx6uP1Wyf/5
	Lr03gxq+Hoyl9QQ+b/USDRqLpCj+xi5woDOkDChYFl33U4AHko5EdYZ5OwF7GtIozN42g5S1s1g
	aA3jzJIVALaTvz0xvVE4j/iki9p1V8o9p108/Yr4BLEtNm39EEU4HDCj3lC2ruZzOC3j0gbU2zI
	+6mo3rHdoOPq93dbU62lC/B8lgApEpVJTjehDKtlJCirfEwu8hjeyAEXq1Tz0taeoBamy1eAvEF
	qHLfSRhmGeMivjPocnYraMioGy4qDPUMm4uLAYvSReMjspZ0OXi7XIoo8R/8uHGK8wGpkFfdZb8
	kS3EuA5djSUNneuP5Sd9JsA6GIKPeWr+M9JFcm+f0Ol16C8KhirtDdeg1+Iz+42e/g3QWsfUjJV
	MI9QG/NWGLZKtdDQMMQ5SweQuJm1mNxnzJnuQ8mLu7qFimy8iz0xVivb8kbP5kUlixcPfr7L2bt
	qiEzb7Xda9iTvEE5GT1tlY0OgHhr7DgLl60JJysh8Wd5wmYYI6tmHltsdi+JJesl2iOg0b3SfSY
	wCXDWeRm5MPrds5PpedlvExvvQpOb0fF5WmKDJSSCcOly82PQOcBaJX7vhg671annGzDbeHw=
X-Received: by 2002:a5d:5d0a:0:b0:47f:9260:4bc9 with SMTP id ffacd0b85a97d-47fb1f10855mr6272310f8f.29.1785310481628;
        Wed, 29 Jul 2026 00:34:41 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fb6aa3a32sm5852689f8f.2.2026.07.29.00.34.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 00:34:41 -0700 (PDT)
Date: Wed, 29 Jul 2026 09:34:39 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Babanpreet Singh <bbnpreetsingh@gmail.com>
Cc: William Breathitt Gray <wbg@kernel.org>, Kamel Bouhara
 <kamel.bouhara@bootlin.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] counter: microchip-tcb-capture: Fix DT channel
 validation
Message-ID: <20260729093439.00007440@gmail.com>
In-Reply-To: <20260714042910.7-1-bbnpreetsingh@gmail.com>
References: <20260714042910.7-1-bbnpreetsingh@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 14 Jul 2026 04:29:10 +0000
Babanpreet Singh <bbnpreetsingh@gmail.com> wrote:

> mchp_tc_probe() reads the devicetree "reg" cell - a u32, per the API
> contract of of_property_read_u32_index() - into a signed int, so the
> bounds check "channel > 2" fails to reject cell values at or above
> 0x80000000: reinterpreted as a negative int, they compare below 2 and
> pass validation.
>=20
> A malformed devicetree can therefore drive a negative channel into the
> ATMEL_TC_REG() offset arithmetic, making the driver access syscon
> regmap offsets outside the TC block's register window, and into the
> "t%d_clk" clock-name formatting, where it truncates clk_name (sized
> for "t0_clk".."t2_clk").
>=20
> Declare channel as u32, matching the API contract; the unsigned
> comparison then rejects everything except channels 0..2. Adjust the
> format specifier to %u accordingly, which also resolves the W=3D1
> warning that exposed the gap:
>=20
>   microchip-tcb-capture.c:520:56: warning: '%d' directive output may
>     be truncated writing between 1 and 11 bytes into a region of size
>     6 [-Wformat-truncation=3D]
>   note: directive argument in the range [-2147483648, 2]
>=20
> No behavior change for well-formed devicetrees: channels 0..2 take
> identical paths before and after.
>=20
> Fixes: 106b104137fd ("counter: Add microchip TCB capture counter")
> Assisted-by: Claude:claude-fable-5 [gcc W=3D1]
> Signed-off-by: Babanpreet Singh <bbnpreetsingh@gmail.com>
> ---
> Note: struct mchp_tc_data's channel[2] member stays int =E2=80=94 after t=
his
> fix it can only ever hold 0..2, so converting it (and the QDEC-mode
> comparisons reading it) would be churn beyond the minimal fix. Happy
> to do that conversion as a follow-up if preferred.
>=20
>  drivers/counter/microchip-tcb-capture.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/counter/microchip-tcb-capture.c b/drivers/counter/mi=
crochip-tcb-capture.c
> index 19d457ae4c3b..e53a8390756b 100644
> --- a/drivers/counter/microchip-tcb-capture.c
> +++ b/drivers/counter/microchip-tcb-capture.c
> @@ -483,7 +483,7 @@ static int mchp_tc_probe(struct platform_device *pdev)
>  	char clk_name[7];
>  	struct regmap *regmap;
>  	struct clk *clk[3];
> -	int channel;
> +	u32 channel;
>  	int ret, i;
> =20
>  	counter =3D devm_counter_alloc(&pdev->dev, sizeof(*priv));
> @@ -517,7 +517,7 @@ static int mchp_tc_probe(struct platform_device *pdev)
> =20
>  		priv->channel[i] =3D channel;
> =20
> -		snprintf(clk_name, sizeof(clk_name), "t%d_clk", channel);
> +		snprintf(clk_name, sizeof(clk_name), "t%u_clk", channel);
> =20
>  		clk[i] =3D of_clk_get_by_name(np->parent, clk_name);
>  		if (IS_ERR(clk[i])) {
>=20
> base-commit: 3b029c035b34bbc693405ddf759f0e9b920c27f1

Makes sense.

Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>

--=20
Kind regards,
Joshua Crofts
