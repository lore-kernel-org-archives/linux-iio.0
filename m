Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D2937A496
	for <linux-iio@vger.kernel.org>; Mon, 22 Jun 2026 09:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782122159; cv=none; b=PF4gye6VpYDw1FVbJCAciTFcYClcqb7Q34qj8rq+Z2iZ7obyFcHI1aW/b5piODKHlel8QDVDW0bPaA4v9gGEFQebQ3K304C9nh20rYcB7NL32GOqL5G2Ayieog+ye1Acuyw7FHOTayCOa1tKUIen4GqwFxeGguD1g26X4I1YoWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782122159; c=relaxed/simple;
	bh=8BETki/jQ5baBxbQcFwkgeSsOIXzQof1N3Fqfu96PVI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JLkPWXKXhs1CN5BtleuRlTg033PZO2x7HNruy7RqWPdazR8p8GYtw3ipHtBg3mxGBRsA8P3hjOGFycV7Q/x6f2FEXeCGo+4kOem7BR9GlZkZu7Wl7Bfr2S1b6B3jBTNzSj+HPxUGDIGykSo9cb6s9lMNV59Q0/2hJzYLbFJrzvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zuu8hF4n; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zuu8hF4n"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-4624c1409c9so3044155f8f.3
        for <linux-iio@vger.kernel.org>; Mon, 22 Jun 2026 02:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782122154; x=1782726954; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P0E0JBlSRaUIEWVL2hII2Z9BSAc+EUsy9g19G1CKGLw=;
        b=Zuu8hF4nPp9nD2umAtReOwK9izswYY0MJIN6LZNNZcT+zXe49MtUUcNNAMHOPvP0Ty
         nUQmZqKS3LFIZei0V0G1Xcp4JIVuyZjmRBTEfnVK/CHOwhDIFld3qqrKzOegiaxqgapj
         SA5xFEPzXSqFV1vROPsqm+SgD6aD9l96DDFoR03lZoL9I9wtZGCEO4ekl8EuonHVv6ne
         So4+RsqLDKtX3dzJQou6Ayam5IxxNJA5FljormrbPKjxeOEP14QtQnq/lI8+rL/PXsAb
         Y1qRHjPKc/h5YSrBo+3XJmbASLDyBuijtulJ3zeEcKk+yUPSo2flaK+e5C9VxgUKWJdp
         iJtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782122154; x=1782726954;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=P0E0JBlSRaUIEWVL2hII2Z9BSAc+EUsy9g19G1CKGLw=;
        b=bcWjNxi+FzLvM311k+1xK7p3Ul1PwywU86AFoCyiNeDR0viSCE4NOSDMSXQmvH03IQ
         m6NyVt3dfZDwgSs/ije/7/B8AwUSsuV45yzZLyThnfDGM6OUjCTj8HiyTFf6tRwuQk3c
         YKnBVjwV878z7yps5OsdI2RTNtjJIF9wU+C7kfNyNm7p2Ty2hb/riuQB6ZjNbdcctGqu
         qQ8avQZkzoavCj1zpQZwV5WMig7jBSfGKProeJwTOk8Xr1lJsSHll1lIMEp0+BZvUmVW
         AZPM/ifJWOGqdOCH8W2+8k/jPtjEV/lHCEH0SOexd/EUCi9WutXnYvqIB5tM71Q8ZmTR
         Fj+w==
X-Forwarded-Encrypted: i=1; AFNElJ8NOQEVB1pb7yHSS4o81LrIJSB6cuQvaQqHnYNEcszhqSv8UWhqvI8rhauV3/BGI3MaapvvvKQHylQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxPq9WK2gmydKI1TrtEOzLuB2X/xrn/Avo1bj8qVlflwPchYnr
	m90Du6gnfWKam44BImUygpA0hpmPU3IAOtZar9wqd/MMFySdH/Glu+JF
X-Gm-Gg: AfdE7clP9CPRhFasI67V4aOv9ABk5NInrvGgs2ox8sjhoJOePpkhCEAPC+62rz/IFAT
	ODSrYIe+FlR5GDNS+gsotYIOveyzbdEooEvhLFy1L7dBzgrvsCDfUcp3xmohZd+gSFnkm7dOv8f
	Gju5Pw3rk/bx5YHsFGCZHpU303JyCjoWTu+HxFo1BCQ4QHUADcwyhhSUK6mDsncQ9Q7HoTrmF2P
	aKyz+wttolFPoxjO8VVR4FXDJvWMT2NY8Pc4ggN7d1x0H3chqVJCun96vZUr3vMi+WNJXjms8rm
	nmVzINodPg8MX0hKr8UIq/1PYKoszT8OburCgfZdL4py5nJUA8wKdFy1ZqjJtJNM2sRVakZHE5z
	ixPE5ymS37SXNBe30ZbY4dhcLr/TSjvNq798GoZjLtNFZI24cxMrInomgfiX1nSDCRWX46+d/P9
	z7Rv+dmzorMrml8eI5vbaWDVIy8dMS2lC0INe4dicFV6dVc4/676vxqdJMnIHR6oJbG0f0hqcE9
	7YqWo6fYkqmaJCHQn9xIy69UFOSJN9qBrrUHqL+EnBttAw4pINXCA6uoieLvL1CEh49oLMiWsou
	zGWu+1ut4IFDkgkbEZnSMQqf52s6jqzAJ5kC2/Z0yZrXPqGwV4RRF/I=
X-Received: by 2002:a05:600c:6288:b0:490:e18f:d108 with SMTP id 5b1f17b1804b1-492490a7778mr137140915e9.19.1782122154243;
        Mon, 22 Jun 2026 02:55:54 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4923fd15535sm313817465e9.3.2026.06.22.02.55.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 02:55:53 -0700 (PDT)
Date: Mon, 22 Jun 2026 11:55:54 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Petar Stepanovic <pstepanovic@axiado.com>
Cc: Akhila Kavi <akavi@axiado.com>, Prasad Bolisetty
 <pbolisetty@axiado.com>, Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Harshit
 Shah <hshah@axiado.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] iio: adc: add Axiado SARADC driver
Message-ID: <20260622115554.000036a9@gmail.com>
In-Reply-To: <20260622-axiado-ax3000-ax3005-saradc-v3-2-e57c7c7ae675@axiado.com>
References: <20260622-axiado-ax3000-ax3005-saradc-v3-0-e57c7c7ae675@axiado.com>
	<20260622-axiado-ax3000-ax3005-saradc-v3-2-e57c7c7ae675@axiado.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 22 Jun 2026 00:47:28 -0700
Petar Stepanovic <pstepanovic@axiado.com> wrote:

> Add support for the SARADC controller found on Axiado AX3000 and
> AX3005 SoCs.
> 
> The driver supports single-shot voltage reads through the IIO
> subsystem. The number of available input channels is selected from
> the SoC match data, allowing AX3000 and AX3005 variants to use the
> same driver.
> 
> Signed-off-by: Petar Stepanovic <pstepanovic@axiado.com>
> ---
> +	info->clk_rate = clk_get_rate(info->clk);
> +	if (!info->clk_rate)
> +		return dev_err_probe(dev, -EINVAL, "invalid clock rate\n");
> +
> +	ret = devm_regulator_get_enable_read_voltage(dev, "vref");
> +	if (ret < 0)
> +		return dev_err_probe(dev, info->vref_uV,
> +				     "failed to get vref voltage\n");

Sashiko raised an issue that I've missed on previous reads - why
are you using info->vref_uV in dev_err_probe()? The info struct
is not zeroed out on initialization, which means that dev_err_probe
will return a different value each time when read_voltage() fails.
It was designed to accept the retval from whatever function we're
checking. 

-- 
Kind regards

CJD
