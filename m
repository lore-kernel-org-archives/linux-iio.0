Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C130151CF5F
	for <linux-iio@vger.kernel.org>; Thu, 15 Oct 2026 13:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792069965; cv=none; b=nt6g3I1PdK9P8ZKis72iIFFh5Agt5wIQT28O5TdxGBoKMQImPVuEx9MPtYEsHlr28lA8L5X7Zx1S6w7RBFfqNuiA4ROUcdnEZJFPnnM6OHWZSXN2hA/y2Z25eeb9NF50fcwE581vUOjUTj1eeRFYoDP/DTyPA+3WzMHEOwg0aCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792069965; c=relaxed/simple;
	bh=l9UNplYJIOv2bNql5t6OQ2PN0ybmSrQaq8gHkf+c+2A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ry5yR9jNWQQpShPUH3diuFdVQ9dQju0kSaWA1DFOhk1y3gSoQG/MW0U6iCYhilKNEPok6unSvTAdGs9Qn7Y4RMjSZmSicfoe4n+YgzrtchlPvK2pCUZdOD1NhULMWMAK8P9nhtOUMl9ec+wUL/6FuBRncMIMbcd07zsfzOr2p48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o4k6Y2lU; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o4k6Y2lU"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a018792ab3so42771135e9.0
        for <linux-iio@vger.kernel.org>; Thu, 15 Oct 2026 06:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792069963; x=1792674763; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eYpTs37ebMsmt4FCok4Jg2bBzSQXMfDrajAj3p5BF9s=;
        b=o4k6Y2lULHW11jTQ5vb1Do7VNgkQyWsRiHzbRfwl1VMdDfta3bI0VS5XuGMtNcyp1f
         15l8VJ/IqU7LYnwqBwWIXaxYFz2n25CR4h3Ne1+Z7eYvJUCm2v/KfPWLC++09LfsFI+D
         EsBBul/+8WPnnP4+hwpnwY3EYyEoAcRL6EB4SeyiJI3pmgU6twtKJaCzXJBS/Tlr5Uzv
         Hxr9ebBruP3K1MzkQ4MqhAf9wsKGTEwnkMxKsi/qX5/nG8uj4OXxTUJyXxqlHxidxair
         rLN5WraVsA0jM1rgvntTpSFSpZvPgtroYMZ4m+Uu5mJX1GzGxlCo2PgJVUxp4XU7nXcL
         qd/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792069963; x=1792674763;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eYpTs37ebMsmt4FCok4Jg2bBzSQXMfDrajAj3p5BF9s=;
        b=RdX1l7naG+6cQIV52EACHPOj3k8bthoknEygLAzXltN0wWxpSRWcw/gd/OGmWoXCWc
         GnKiY95FWtIb6NAxLf32vS26MVq6HPilw77Bo4z4J9K7lgT/1YERsQJtDRbDR74PYikz
         LnHGK0v8EgJlsGDGihLwZJlfs34w3rO0M0CScDBQduUfV+hokc90VFT0UW7g5Dkt8yTf
         2GeaUbFzB+rOtnC6WOFKYPU/8TfHgFoNRcvre7nqhlJdYr5BM85p8Z5pRw69o1Xh8lSP
         QuvkB87pc/jW8VsdM9CLNfto165Q5W8tbxlr1s5ngn0cgIxLv7+nG+yAbQk9VSTTc448
         bldg==
X-Forwarded-Encrypted: i=1; AKwUvBxZhJmHmOfen6OAQCUb9UKvb+dthUTxHaINtTnGIIJjN/4zYXy45sHneO1VKCPJ2p+HUpwsxhFcaXA=@vger.kernel.org
X-Gm-Message-State: AFq9FYKGmyTUCRIhQJSyNP0hEeZ5xdAxaGPIppLlrg6wd0s4p+XbsRcC
	w47BD/8aI1NkLuAl5sr5lHW06GxaePz1w/SQc41NTSjABtDgVJu5q9M/
X-Gm-Gg: AYBFou2/TubjuRiOhUOJ9bBxyTS1C0n7oGrJ8sZdmFocLPCdSDYtcP6vrro0e7s5tq+
	SMKk8Xw06tJqPUzGiHGNA52rt9eB2yR1SDfT10KAmGM1wTNrZ8DQYwu/JhXm1RnzQLRCdAVC4ax
	8d0bJO+mbRhl/WewgsJ9Y7/2rqI5o7GdvoUqFUUlhJqaCHAXtdlzmoBbGL6a+dYDIsBZHZRPNYA
	1pyxMgWsP6cGVYptjlXP0A7DzHGurdYvpcRoVRQKGY9IyPFujGeNO1SUSYJmffij3E7ucEtswJK
	0GIL1aOfhyT5Q5jPfO/FHUSvD0ANa7EieK8ELob/4VaZYz+1yzxH+R6RR1ApzpTjxtY/av1Ci4S
	0yLl0iWQIf2QcHNYzu1Lo5/Z+2Ad1o7p0D89v0FqYGPdzU9AVch4lKTLGo/UxxTqRoex6RaeZ7u
	DCqF6HXT2yqg5XWtEJSKB/XNW8FIzcg87c2213pJBAgZrzlL1KgqJrv7SnutbsHHOr1XX7s+96Y
	zorQlLIyEcihiDKz957bPb4LgdyjvFwC5IR65u750bXvOzzGb2lXh/7Iu9oklWuCtTn0cKjFVRN
	RKCDRDr0Mub1uRtUoGaZiw4m/oZyVvowAAtj7USpAJ1Kwg7d+jvzMx0bzjLi3/g9M7TX9IJsoBX
	lLH46I0muI03+QloBbWFm4wj7ZKwCZj8Cf60S2BH38wgF/MiQjcLOYlY0VXdS8/Y5h9OrpLKhio
	Fkc/rJ
X-Received: by 2002:a05:600c:e547:20b0:4a1:a2c0:7b73 with SMTP id 5b1f17b1804b1-4a1a2c07cb4mr166991725e9.30.1792069962853;
        Thu, 15 Oct 2026 06:12:42 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48df0f99f0bsm6681901f8f.21.2026.10.15.06.12.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 06:12:42 -0700 (PDT)
Date: Thu, 15 Oct 2026 15:12:39 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Paulius Zaleckas <paulius.zaleckas@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org, Eddie
 James <eajames@linux.ibm.com>, Joel Stanley <joel@jms.id.au>, David Lechner
 <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Andy Shevchenko
 <andriy.shevchenko@intel.com>, Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?=
 <u.kleine-koenig@baylibre.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Rupesh
 Majhi <zoone.rupert@gmail.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/5] iio: pressure: dps310: add per-chip data
Message-ID: <20261015151239.00000ace@gmail.com>
In-Reply-To: <20261015104945.2687162-4-paulius.zaleckas@gmail.com>
References: <20261015104945.2687162-1-paulius.zaleckas@gmail.com>
	<20261015104945.2687162-4-paulius.zaleckas@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 15 Oct 2026 13:49:43 +0300
Paulius Zaleckas <paulius.zaleckas@gmail.com> wrote:

> Move the coefficient count, the TMP_CFG startup value and the IIO device
> name into a per-chip structure, passed through the I2C and ACPI match
> data. This prepares for the Zilltek ZTS8032, which has two more
> coefficients and a different TMP_CFG layout.
> 
> No functional change.
> 
> Assisted-by: LLM
> Signed-off-by: Paulius Zaleckas <paulius.zaleckas@gmail.com>
> ---

LGTM.

Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>

-- 
Kind regards,
Joshua Crofts
