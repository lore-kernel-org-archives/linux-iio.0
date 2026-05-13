Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 835633A4531
	for <linux-iio@vger.kernel.org>; Wed, 13 May 2026 11:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778672653; cv=none; b=OrSpz4X2J0TiG1Qc6zqi8lzGx0uA2iQ4X5Q+X6XSppoLJWEeBzF8X49B1iON/Kju5i0i8A8QeRfDqnMe9o08kYzViV63Q46NRPrkEzqzT89jt28T7WwMIERAKjdU/3Zam4zE5oma7fXEV7iUhH9B14K4k5qn+TNb6wd9BU3itLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778672653; c=relaxed/simple;
	bh=1a+V7SN5Ad1tvDfgTgTwhX+lul4htUJKibU3Otb53LQ=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=IAXpr5MzEJjZL3W6T/Ehgtb5vPiwY61XINmFi3F7kptn02QO5ZB8xXWkNVXP/mXRg/ujaDb4LxB5sMELnVFG3oewvLNihnhkUP3SM7+nYML2gHz5o4Z+85fUV5zeMuDxifQ1QcX03uPAsB+0BYMKJ5/FH7uJzDJ4b0qdx2nhXw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gEq1hdHh; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gEq1hdHh"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-36643b96b99so4393855a91.0
        for <linux-iio@vger.kernel.org>; Wed, 13 May 2026 04:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778672652; x=1779277452; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qYAcfX5TZQ1aO/tUlnMIN+1pF6qLETPLwxG8ZHIUVfI=;
        b=gEq1hdHhXaN9hfUHDRC7spe2P68YK/n731u3tq7uWrGdzINNnmUDOW8Oh9KoWScOJQ
         DN+ORe3jW3HsyQaZlizJ061yElkn9LWzIsSBZXdnsVWC//Z4qEac0uH3WC7WtQt/r6Lp
         LpJbgi/L7q30rhoCdMLKlMEArpOvB3gabBHhgdz7oLPiDlUXRwVYuIgNL96jLwq6F+s7
         V0LzfBYxepKqOYbH7jtH0yybby9sEZnliRKesNpyzUdmDLqSxybjHEGu5z6TA4izw8ag
         KJjuiM5FQBkGf9fvN5lPrNRGAsfzfPNAVXIOiZxizw0YMfntq/c89OBKQfIN7XwvTy4U
         FTcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778672652; x=1779277452;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qYAcfX5TZQ1aO/tUlnMIN+1pF6qLETPLwxG8ZHIUVfI=;
        b=TBlW3Z1y2+t50C1awaUqsnqeiozAk3E7cEWP9QVoPyzLIuZ6hI6BvM4uRP96QPJ8vI
         bsaVvSvoJhIpl0xSikwBZDQZFKt7u7sosLH4dV2yQ/nygPUyLRfuMsS1HpzIPOrv5VtB
         ftdizOerhrTA6gUlV52ItLvnRKkqYBGLIps2xZ2N4TKttN9Pv5qvv4TtqrhjltAsYFa+
         IdF0FMgJ4+CXIDUcc3lvdcyjSKNhgzFzc/LerpbxeGI74ic65ivWCz2k7T0uu7xCjXpP
         cKQXhyCiyOAa5Fcq+zCJV7WCZSKDbqpHikWD6zc+R6hD+asH3qVrjqhmqFhfOxqooPUL
         agFg==
X-Gm-Message-State: AOJu0YxaxDJUvBueN+YzYA7U5rDQipWr6xwyK0SHQSEBLM0RKzJqYEuL
	bYOzMK1Kwnu/FGWCpLNdX2iz3NV5VN/bEq7Tc6RuBXu4uv0yZZIGQ4Mg
X-Gm-Gg: Acq92OECYESonORcFEGccoUsmoAzGRI58D0tW4tqanzWgvLyeDgNTHvidM1XXPLd3OT
	weau5EWIsKv6oRIZZnErb+R+h1XLyCRuNuL/OYwVd0zOjYhw8fXULi+KFyeJE08h5kMe/Vi6Ppw
	wjg9NWV9Yi8NSkcp2eW3wbiINdRMFGf7S3zTFcc90LlxCzoGx7tkCBxnnxOjOaN5xtx+DCV2ntO
	CVB5CPu9tTdAZAJqSu+KZzvNCsRwAbdq6XI0NCeucLYRGf3RI2EtuE0XMCFuKAOaEYxpI+OYcfJ
	HlAMS7IR+Z7Zr2oFgPVoon/h4MgD83vBT9VI3zaCC2so8Qwa3eIYKqy1DsV6yvVvHJxBkuyQp+b
	/0rebJzIOIslSHnBw5T3IAzLvgYcUdoRsUlK14j16aPML9puy1n2MgZS6ou1qvHpnm3F4dnteFN
	qj1t22v3LNjaTj2z2TUzQyrRJM99LWqTfvAzmf1UlgdvaQ4Ic=
X-Received: by 2002:a17:903:9ce:b0:2bd:56c:97ad with SMTP id d9443c01a7336-2bd2ec5abd3mr25711825ad.0.1778672651705;
        Wed, 13 May 2026 04:44:11 -0700 (PDT)
Received: from ehlo.thunderbird.net ([2401:4900:ac0f:c362:ceaf:f4a4:19f1:7e92])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1d52f27sm204870005ad.36.2026.05.13.04.44.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 May 2026 04:44:11 -0700 (PDT)
Date: Wed, 13 May 2026 17:14:05 +0530
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
To: Michal Piekos <michal.piekos@mmpsystems.pl>,
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
 =?ISO-8859-1?Q?Nuno_S=E1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>, Maksim Kiselev <bigunclemax@gmail.com>
CC: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] iio: adc: sun20i-gpadc: add A523 gpadc support
User-Agent: Thunderbird for Android
In-Reply-To: <20260513-sunxi-a523-gpadc-v2-2-d5efde151dac@mmpsystems.pl>
References: <20260513-sunxi-a523-gpadc-v2-0-d5efde151dac@mmpsystems.pl> <20260513-sunxi-a523-gpadc-v2-2-d5efde151dac@mmpsystems.pl>
Message-ID: <A7772824-E704-4BFD-A796-BCD81197E5A2@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 13 May 2026 10:29:43=E2=80=AFam IST, Michal Piekos <michal=2Epiekos@mmp=
systems=2Epl> wrote:
>A523 differs from existing sun20i-gpadc-iio by having two clocks; bus
>clock and module clock=2E
>
>Change driver to enable all clocks=2E
>
>Signed-off-by: Michal Piekos <michal=2Epiekos@mmpsystems=2Epl>
>---
> drivers/iio/adc/sun20i-gpadc-iio=2Ec | 11 +++++++----
> 1 file changed, 7 insertions(+), 4 deletions(-)
>
>diff --git a/drivers/iio/adc/sun20i-gpadc-iio=2Ec b/drivers/iio/adc/sun20=
i-gpadc-iio=2Ec
>index 861c14da75ad=2E=2E3f1f07b3a385 100644
>--- a/drivers/iio/adc/sun20i-gpadc-iio=2Ec
>+++ b/drivers/iio/adc/sun20i-gpadc-iio=2Ec
>@@ -180,7 +180,7 @@ static int sun20i_gpadc_probe(struct platform_device =
*pdev)
> 	struct iio_dev *indio_dev;
> 	struct sun20i_gpadc_iio *info;
> 	struct reset_control *rst;
>-	struct clk *clk;
>+	struct clk_bulk_data *clks;
> 	int irq;
> 	int ret;
>=20
>@@ -205,9 +205,11 @@ static int sun20i_gpadc_probe(struct platform_device=
 *pdev)
> 	if (IS_ERR(info->regs))
> 		return PTR_ERR(info->regs);
>=20
>-	clk =3D devm_clk_get_enabled(dev, NULL);
>-	if (IS_ERR(clk))
>-		return dev_err_probe(dev, PTR_ERR(clk), "failed to enable bus clock\n"=
);
>+	ret =3D devm_clk_bulk_get_all_enabled(dev, &clks);
>+	if (ret <=3D 0)

Thank you Michal for the change=2E

Have you validated the changes ?
It looks while success ret would be 0 and it would give return error=2E

Thanks, Sanjay


>+		return dev_err_probe(
>+			dev, ret,
>+			"failed to enable clocks or no clocks defined\n");
>=20
> 	rst =3D devm_reset_control_get_exclusive(dev, NULL);
> 	if (IS_ERR(rst))
>@@ -243,6 +245,7 @@ static int sun20i_gpadc_probe(struct platform_device =
*pdev)
>=20
> static const struct of_device_id sun20i_gpadc_of_id[] =3D {
> 	{ =2Ecompatible =3D "allwinner,sun20i-d1-gpadc" },
>+	{ =2Ecompatible =3D "allwinner,sun55i-a523-gpadc" },
> 	{ }
> };
> MODULE_DEVICE_TABLE(of, sun20i_gpadc_of_id);
>
