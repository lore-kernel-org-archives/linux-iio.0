Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4CD3F7895
	for <linux-iio@vger.kernel.org>; Mon, 17 Aug 2026 11:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786967778; cv=none; b=mnd8eTJFk0kxdTy+ADqNT1+QrewNg0J2k9OCEGtQ0xuLNRVAetN+fWxNEsLTyRPclTUnEIIwFcGwCUwyBcPuWv0JlmPTEdjSCzMIKruw8aC4zoH/f58h6t8C9moH69KY/mUkO4/qQHy4eAs7VE18YmZKTHxAutWrMOWFJxeH4wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786967778; c=relaxed/simple;
	bh=Gez6xpQwq1YHIFskoCdlyQnVU+aHTgdUkmXSskLEISo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nn/hXAptXOuLaPOH2KbVF6mOlW0p9whq75J6BAGFIPOrNDXxe/cEKnKMwEEivGWC8h5gMb97yZdvKkyleiFkU+cwRDnJEbJ4e6lmyotvLHvtyNSo1m1uDFxAChbNO/2SvaPmXWlDHdBkZ6wyT1SQbyIZ3OF2aJuOYOtftUFjerU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oy/2MAjy; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oy/2MAjy"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-481412f1828so1070246f8f.1
        for <linux-iio@vger.kernel.org>; Mon, 17 Aug 2026 04:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786967774; x=1787572574; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tV4PQbMLFFgyHeT+5vlbh1R9csfOU7q00rfgp5Wi+ME=;
        b=Oy/2MAjyBS1fIFnMsU1QEeYuwM58oBlquAEJpeNzBbJJYYbi8krhekwtw9SehZ0AVC
         oFmI2F+RlJt1irfvI/oZ4MNp13dLM0srSZEGHA/3erlAaZ++VPWcwIDFTKwyxjR+7G5q
         0bsA2Nig0t0ypgU6bcerIPhzGXHQ73+rQTg+fAedbRc1ck7E9gvlvWkNZICNC/1Z+fss
         jxdyPN+NCU0tFj9cKoMLLDcWsrTarG1/UgzH+35rExhTcgBrYV5JHcyf1LSd7mVHq+aN
         WPiZ5AD9yWk3IRyjZH8e92g+e6t5XL6vo0DH/hDAdgUsy+q+W2fK4ZBE9q81Wh1PdOex
         8/Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786967774; x=1787572574;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tV4PQbMLFFgyHeT+5vlbh1R9csfOU7q00rfgp5Wi+ME=;
        b=rCxXAEWmwECCWQDmiY6mkQSfQkUtXOGAf1lWJOMVR8p+5RuFlJKMtu6SJljXYH9Pyz
         1z0/j7Pq7rTNuLTebDkpttAYMNs8g+e+J9fqaRRe3wHQsrz3eePXx7gLYW0dAvBpVC/6
         9yVxtKDj857N8gg8pHRrJ7Lf16EFVwea4xDNvEVbM83FYDhTFbSK//agijYISm+bFZ+2
         onbqxcjD53bPPIk+6HG/L0R4ZcR5TUEvEza7luC8Y4T1yamRV1WDDUS+aUj2eT0MrwCs
         q/TG8u9lTYnp2kX25xm/0KhmLDmz2Ws6MpQFxMSeJkzOoCI8IfAgpDY2gtEPjaiyJZ03
         UrQQ==
X-Forwarded-Encrypted: i=1; AHgh+RpqECEq71og8pqgjSYLaJq1Fl2NKOFNGXNQW4+4OXCD7b3wZrs0W358FFv9aRsc8MVUp4bo4QysiLM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjAVk2dP+zcfbCWdINA2iw2lVcNuEcakdkv4oDSZz3Q4QT8/d8
	UCeKJxls/XMkJSK/njmouBln5hZrYE/gNhCInXpWzODO9wyJzZ5pIuPF
X-Gm-Gg: AR+sD11t8q+HDChp0cK5A4cg/gWQiS5SWcqJbUMFHUROAEp+BLw3cB7+BHYy6ufwq6e
	f8OCs4Xus5QoXc0syYnlvsKd+ZmajfTIz9n9v/9iaJATqcV6q69o+HK4mLr+/3kDPYJi29B263C
	Fzz2ykdNT57pS4gE4EwGW5OP3T7XfIGnWS9o38oreQudk+IzD4ZXAzKIPz3WGvt4BmHvRpGqbWX
	x19BhQBaROJeHcdzLayY2v7eOgjD8dh9N7oUb7CkEMvknVONy9FiIyzAEq11oLrjhKCfVEfv/MU
	u9s+wulnOQNExZAKo532H/DTMS90X/oLkGislyuBGZAVWop1Gk05DhwIgNZsGdxd11wiJIZr2GU
	AOrz9IX0Kis5DWi4sb7MnQabdheSbTcBOMBT0vSpOGqQG+gh5UUm0/VlZL1J3uFucmrlmNzqVPV
	RG0y0UHvCBY22MfTwb6wI/R0jh+lyJNSCddOvTXdJAsY5hIk9ZDspqnvnd4yJXTsk9twOpgeMJ4
	5RcIIn//RnUl+8pGPP3f/m649ecjbwn/Tk9cJ/3ndMXNGfwy36bidHFVeQl/lC0pSh+iquGH3OH
	1wSgq/+PYhaz4i2ZfkTciZwjMmJCBLHBbu0OKHXzM4fmHxliFF+SfVWgnHRnllEGbURO3BMdvz9
	l0++uHIVshNiiVtNG6SvSeiY4svYvY5baCeDUBKYfdCggY3hji3+wraATPRfgTTzxTlymoQ==
X-Received: by 2002:a05:600c:3b1d:b0:499:87b6:f3c0 with SMTP id 5b1f17b1804b1-4998807e4c9mr371138435e9.14.1786967773981;
        Mon, 17 Aug 2026 04:56:13 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4998777a4bdsm203726505e9.0.2026.08.17.04.56.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 04:56:13 -0700 (PDT)
Date: Mon, 17 Aug 2026 13:56:10 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Petar Stepanovic <pstepanovic@axiado.com>, Akhila Kavi
 <akavi@axiado.com>, Prasad Bolisetty <pbolisetty@axiado.com>, Jonathan
 Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Harshit Shah
 <hshah@axiado.com>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/2] iio: adc: add Axiado SARADC driver
Message-ID: <20260817135610.00000c0c@gmail.com>
In-Reply-To: <anoYDi-bt-t6ZeeD@ashevche-desk.local>
References: <20260810-axiado-ax3000-ax3005-saradc-v5-0-bb0df3ecedaa@axiado.com>
	<20260810-axiado-ax3000-ax3005-saradc-v5-2-bb0df3ecedaa@axiado.com>
	<anoYDi-bt-t6ZeeD@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Aug 2026 21:27:26 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> 
> > +	soc_data = device_get_match_data(dev);
> > +	if (!soc_data)
> > +		return dev_err_probe(dev, -EINVAL, "failed to get match data\n");  
> 
> -ENODATA

Hmmm, I always thought it should be -ENODEV. (`grep -Rb5a5 "device_get_match_data"
drivers/iio/` confirms this, but maybe it's just wrong to begin with, a few
instances even have checks missing).

-- 
Kind regards,
Joshua Crofts
