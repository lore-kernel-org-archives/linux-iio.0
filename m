Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2F73D9DBB
	for <linux-iio@vger.kernel.org>; Wed, 15 Jul 2026 09:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784106054; cv=none; b=oJ3LMtIlMa7ATDMP5HdiO+ssiUlzTDWtnQilXXCcJgv8OmgpT5daKNhQM4UraStI/L+KqvqG+ypBz61HuK9AxSu+PW8+xjj84s38fmV5DaFI5fwbESwPCPhXCeHOTuF8bHJpy1FcOd0OtK8FXViacP5xa1omnPT3R2IsDW3xpE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784106054; c=relaxed/simple;
	bh=oeOPqOOHX4vx7wNAoVD/Owj8kJ4/yJGKi9yRp2ITc1w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZUTjWtMIXbbseTbu6yReSeGoQTxFBWp9pi1M868Lmck1xL3IX108oEuwCReQc7Gej4fdkC5xZBIDUS/RNNHsSaN8iosQ2zRT1J7CDoOJW5eTMvYa6hVAW9B+RJXKh2ihYaXT4/wSuticJsdDF575Z8Tf0DoNbAddGRrncEKV3MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RRnIy1Os; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RRnIy1Os"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-47c6e9a694bso2825408f8f.1
        for <linux-iio@vger.kernel.org>; Wed, 15 Jul 2026 02:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784106048; x=1784710848; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VVH1oge+oUXjz7fA2PBFdWN8ikRwkxQ+DXDLXhR5jCc=;
        b=RRnIy1OsV3arEGLXhqfR4/ih6kB3MSCZBooSSe1uM8iOMSW5dmSLF/8lZzMTbG5ZJW
         XN96D3NhQGXOGY6Yr3rYaiSugE6r2KXlLjspuwYtVuTXlZMHw7CSkPw1eYl31+hogFgq
         K64ZgRz/5GgkS9/KKZrOlglPh5MaZJS4nw3xSy0b50bu8sfQ0DG704vaFN9+sYhyW0qF
         5FngJc1ldmX3vhjFf2OGsE2W8mWi01Qy9RrlIQTUtM2+8KulOL/Wx4vv8noNQL5f1dIJ
         a34PP6zSu/GBn1tedi4O4abvQStmPjHM6PsB7S8GkmSPnRIgWddDRpuZ45jcordgFap8
         DVvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784106048; x=1784710848;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VVH1oge+oUXjz7fA2PBFdWN8ikRwkxQ+DXDLXhR5jCc=;
        b=hiOErWOmVEUX5lP4OxpEs49gSh9O8QMvoRzl1nydYJaA+Ka3pph3xyeZ+9YHRpI1cG
         RrOgfsvVTUkaqC2z1dt32bGZb8s3p2HeYZGA3GOeA6bGbHCpLRuWxpRb50iLr2ZIaStB
         moX+SPa84BH7tbCC3czjdHk5LdwJ4/EHXoB9b1dXaswhi5kYjttXKmNTzoTD2wK3FrDJ
         wkkfsij+z5eye0gI1qr41wiYJqCIOyj/9mFrEaWHjXfYTHyz1vVGq0PKJr3dDqXQ+fIl
         oQwCbdgrmDopyAbkhic6/EV1eQV6QFq7oXVwMH5rdSDHFeNWULTDHNoWMrzg6DEZ4evY
         TzNQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp+1+hcEjUuO5peLYH2w+XdO1lbZxrC7+ti8nLWiSJO2Q17QT3k7FIB7wNzkWQ9uDlHtdKJn0/qUfU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz86grylG4GcOBAk6LDrWVyrD1iiC2PNjpmcAqq43MKLC/2ibbV
	079M54M5gqufje82fK2j9dH63uNr6Tff2oV9C7q7iACnbggCzJvgHbP8
X-Gm-Gg: AfdE7cmhoNb35AHBw8a9tWlqdegTzyqa1K6jbH0xOne0+FwevTn8Mxtxt2A2+oSYjUI
	xaMonXh3WgZayYHi0wj2qfAA9S2xVyfuzgnr+7PmtATN4Iy4x2/wSWsE+JpmBqRBlk7QnyKPPZB
	cti5darGO8RmwyJgpPG6HnCiNXa5dvN3LGWBAf3BsO5wP5pPnaKxewBxbt/6lCqRQVHsUqk1YGq
	czg0zjnDNWGpdZBErL2lphM+TC6LoKBxQtS1rvybUaECQg4fgiT7b7C2N3Gs7Z8Q+NyTQTz3l2m
	9hFmSxLq4YAzALrRbqUWXKDmo7gDycr2775R65+ld05BQG6//JNWijTr2eW1eRUWlIt1yCScP+L
	+4vHpYdoSC+/ka9giBy0LNQg+774o2mcoXs8Z/eASeB0dFqUwORXr2fxuVa6FXUlb6IdOaQdA3b
	Y+evDoZeHEe6WtV+GLNpo9kGSupEfZa9w4lmd6De+gYy6/z8sLU9L3vVx7qSPpMDHnlom9K7rib
	jyQmPLRMCUQi1rB0Ny//GxSbpgUCSpSXBmYuaXidAuokMevk+70q2UTjMlplhHI4m26Cj3HrlQV
	mGe10etRGvEJh2o7QmQ8NoWcfIXKL9CoG8lfmWJgeGSeiaeuB3Y40XbtqJsd98NtO4O4XjOG8yF
	XU584Za6BbcCkcGraBjQnLkg=
X-Received: by 2002:a05:6000:2086:b0:46f:7d90:8114 with SMTP id ffacd0b85a97d-47f4fcb5992mr1968563f8f.14.1784106048085;
        Wed, 15 Jul 2026 02:00:48 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f4635c86csm14503414f8f.16.2026.07.15.02.00.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 02:00:47 -0700 (PDT)
Date: Wed, 15 Jul 2026 11:00:46 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Esben Haabendal <esben@geanix.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Nikita
 Travkin <nikita@trvn.ru>, Maslov Dmitry <maslovdmitry@seeed.cc>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] iio: light: ltr501: Add ltr329 driver support
Message-ID: <20260715110046.00001aa8@gmail.com>
In-Reply-To: <20260715-liteon-ltr329-v1-3-31f027051594@geanix.com>
References: <20260715-liteon-ltr329-v1-0-31f027051594@geanix.com>
	<20260715-liteon-ltr329-v1-3-31f027051594@geanix.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 15 Jul 2026 10:23:50 +0200
Esben Haabendal <esben@geanix.com> wrote:
> @@ -1257,6 +1269,18 @@ static const struct ltr501_chip_info ltr501_chip_info_tbl[] = {
>  		.channels = ltr301_channels,
>  		.no_channels = ARRAY_SIZE(ltr301_channels),
>  	},
> +	[ltr329] = {
> +		.partid = 0x0A,
> +		.als_gain = ltr559_als_gain_tbl,
> +		.als_gain_tbl_size = ARRAY_SIZE(ltr559_als_gain_tbl),

While you're at it, add `#include <linux/array_size.h>`

> +		.als_mode_active = BIT(0),
> +		.als_gain_mask = BIT(2) | BIT(3) | BIT(4),
> +		.als_gain_shift = 2,
> +		.info = &ltr301_info_no_irq,
> +		.info_no_irq = &ltr301_info_no_irq,
> +		.channels = ltr301_channels,
> +		.no_channels = ARRAY_SIZE(ltr301_channels),
> +	},
>  };
>  
>  static int ltr501_write_contr(struct ltr501_data *data, u8 als_val, u8 ps_val)
> @@ -1531,6 +1555,11 @@ static int ltr501_probe(struct i2c_client *client)
>  		return ret;
>  
>  	if (client->irq > 0) {
> +		if (!ltr501_has_irq_support(data->chip_info)) {
> +			dev_err(&client->dev, "chip does not support irq\n");
> +			return -EINVAL;

Shouldn't this jump to the powerdown_on_error label instead of returning?

-- 
Kind regards

CJD
