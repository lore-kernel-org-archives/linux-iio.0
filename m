Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23FE319851
	for <linux-iio@vger.kernel.org>; Mon, 31 Aug 2026 13:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788181766; cv=none; b=vFCvNmQ56Soz2m4Kerccz+CnpxvCIT64yeulKzf72oUIq4fnHoR6ehSuGEV+K65M+33loLd5fRZpTaR3g7QO43POvZYwK7sLgOa8zmSEvyNFsslS7O3Aeje9DFutYhisyOZu7LDUFc12EFeTXPziclm5U9koWyQ46chHOWINi5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788181766; c=relaxed/simple;
	bh=wEk/CSduIDy3y77BOhVW/7T7N3x8NruFyaCJSoC/otQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jIzup/LEKVsBOmJtO9IsNXmZfSG4PCwV157k3Phk9nV7fKG94A/MJrGHbsa4ulq7Ir+2k2RhiTErLM0zsCb0ZgQ2WxyntTshRZF5x1N3xYZxouYyUZdSiLio/0tbkaNYCN7ltWxJxpVqJvxlRTYfuW/3cMwp5jrqz1KunxCbOIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l1lS+LTN; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l1lS+LTN"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-49b0dbfbf7bso24799055e9.2
        for <linux-iio@vger.kernel.org>; Mon, 31 Aug 2026 06:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788181763; x=1788786563; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AMImnaz5ozXUWY8puoivAmaKF1Q7q8KDEeU/7MhVTEE=;
        b=l1lS+LTNsFDonqNbTGDKjYk4QZMzAuRXQWM4G1flipAOiMQhzkXUphzj2fu1E/vj36
         ar1Vi2xwGaogpdY5tDzRCaqL0hjv3rZxCFpp9MOhQGLE58fGpFIrx6AQSnFzEGhzk3IF
         k7a0gN2dWvtpse4JHSRNLuTnspQ33EpyOSuCA+CWKdZvSTfc3ADQ/Q7GUiO+ishSW5/+
         zSAvFHDLFwzgH5FFfGIvHhpHIET1dlcNwgkvMbu6ccHXjjwwhGDm5puVkat1xxOfvNGz
         TpQ+EIY0ntVt7FoFrSW40oPng5nBvHKKbChQPckjxfJ807RiG6lplufxQlUY2FPyoMWl
         wtgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788181763; x=1788786563;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AMImnaz5ozXUWY8puoivAmaKF1Q7q8KDEeU/7MhVTEE=;
        b=mxVvX6xPfCrVL+omIUpiJfNhSt1VKPXT51NiUUB1NKpqLPUCc/5D//9YG5UMII3O7J
         S+BboyZVCfknX0hsjeCtexGER9HTPmiJzZrhP0LnIXCxx9npOAE1RENhqaH7nWrtq1ri
         9nWN9Y6ZKMRbvtUqGuLZundLxdOxIJbcxFu5c16HyzdjPhDERUwhVi+uWFR2fD1512i+
         ndlHgZyHgodsWK3nUWmZUv9aZ3YHSA0Iejb+fuww1l0GxOKvIRuc2m3pbzZYsLPuWD5c
         WBrJO3rImhqy+846W25mgVkdUykGdLG7xGwUm2/q7KoxVwD5MTNVEJxMFi9w2xHWzIUC
         Aouw==
X-Forwarded-Encrypted: i=1; AHgh+RpE9zY8k70nmkWlALEcvrxLriKh2j8gh3gl6SizCDGwyxrLERkDcZjm7F7wZazRoxa54d53DAfE6Cc=@vger.kernel.org
X-Gm-Message-State: AFuF++mN7qxAP/dkkANnrbloKpqUMTruLpKW4j1mpufh530LemtrjRG4
	f3CSPLFfEtbZFiJU5Wa9zHfWqd4/A5yXOjaul3Yh43hm7ts+py2FePQG
X-Gm-Gg: AR+sD132felf4kj5t4xACuArlsAt/hyma+ZjTw3ULcprW4ik/7DPZFOo00QW2reg9rS
	nXytNGf0mNT4Eaeu9Lnn6uUqDcnab4L1uPJsFhuNAuyuT9Bf8yHmO/amKnwtBDmbp5kxnFXP8QW
	Fddkzscz+i9xUkl0SYRynddwRH1CnGhm6PaGREuIvdcbPI4/wB0q553Al5GScvV7u+RqGwHhGgb
	IrTlq4zgYREUP/yeVHO0e7LCYusY7jND/4LuLL/UKH8In1v7gf3rrRk9ndsntrVprrOCCZ6EUY5
	5ExDp3+Lt6tCVJ0tKBQk3UC4X8+alDXF82sN2G5Tw4LOtOHmbkaM1rbd1iBNGJ4CgksfjyR0DCE
	R20cWZWygkkqnUJnuU9yL4esgy+N0B4RG9McqEDjhz9N+5BT5UsiiKbRlK5XZoNeuiL4CUdI1qT
	8KQZTJ5SBSR43aNXK16oIerH32HXjKa2U/nKkj3LFekHQs1hKO4fjq+U7SrcaeV62brjRhvdyvU
	SVjj4ygFfB2IGYejDsSD6eqnwi7NXxeDjxBSTM6XCXzImD1bU/xWbubr5CTjwK/QojRVQpNerJ6
	tXxUoOKo4QLGv+W9pWmmX0JHB13VL9KlxsUACL71v2nQ4xnaeVOKQiCpv1F0zEmqSIj5td+ugMq
	WRh1Ay1gF4hN9nLJ/WyQIzCXHWCMuXnzbgxdL0ANgeWqVyuP/HhR05aXzaNndE25GJZfBMQ==
X-Received: by 2002:a05:600c:3542:b0:499:a5c8:c6f3 with SMTP id 5b1f17b1804b1-49cdc422c19mr9272375e9.3.1788181762855;
        Mon, 31 Aug 2026 06:09:22 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49b94dc0f57sm318698485e9.2.2026.08.31.06.09.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 06:09:22 -0700 (PDT)
Date: Mon, 31 Aug 2026 15:09:19 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Esben Haabendal <esben@geanix.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen
 <lars@metafoo.de>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Martin Kepplinger
 <martink@posteo.de>, Sean Nyekjaer <sean@geanix.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Martin Kepplinger
 <martin.kepplinger@theobroma-systems.com>, Christoph Muellner
 <christoph.muellner@theobroma-systems.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH v7 7/8] iio: accel: mma8452: Fix use-after-free bug in
 error error path
Message-ID: <20260831150919.000048d7@gmail.com>
In-Reply-To: <20260831-mma8452-open-drain-v7-7-22946812c928@geanix.com>
References: <20260831-mma8452-open-drain-v7-0-22946812c928@geanix.com>
	<20260831-mma8452-open-drain-v7-7-22946812c928@geanix.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 31 Aug 2026 14:17:10 +0200
Esben Haabendal <esben@geanix.com> wrote:

> If mma8452_probe() fails in iio_device_register() or later, we could end up
> with runtime suspend callback being called with a now freed device pointer.
> 
> Fixes: 96c0cb2bbfe0 ("iio: mma8452: add support for runtime power management")
> Cc: stable@vger.kernel.org
> Signed-off-by: Esben Haabendal <esben@geanix.com>
> ---

Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>

-- 
Kind regards,
Joshua Crofts
