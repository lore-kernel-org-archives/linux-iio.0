Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F0F3644C7
	for <linux-iio@vger.kernel.org>; Fri, 12 Jun 2026 13:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781272694; cv=none; b=mVHo+N9c6y0vfoGEdCAV/7ZCEnyw3rjpx2pzqHx/7MTcD86m6jbFoH6sLTnNPkzjMQoHup7LqMos/mCZ52rzcxeVybrSr4qHpnvtZ2XJCdLFH8dTO0lBRhJHxmzosiVXT8T4wSMWxqvvj/QyKBrpynWTcLz9zetlYkv7W+ID+rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781272694; c=relaxed/simple;
	bh=0ZR2dHBJCJIV7izh6baDvLxom0CSaWn2wTdEurxPKO4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G7U9XjBcI5+erjZ5ybfZ8SIMRS0jQBKtpX7uosY93Fc7fPJayK3zw+92Xd5CXCQfTvges/WOZfKMjaXuZ1d1N9UKe/X8GqiaTLAuwFe2pJzeV25+LlrFMh+ot4RPmDRJbV9gpHq58uB3b/no+uK7iW3pgOh2uebiWkepEqKGPgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C9kDxF57; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C9kDxF57"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-490b211ee6aso7073635e9.3
        for <linux-iio@vger.kernel.org>; Fri, 12 Jun 2026 06:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781272689; x=1781877489; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FFsEYlInaSHqLS2KZVjT1FL0qF+p1vPQhrQhmNDTg1Y=;
        b=C9kDxF57y+pTzCd9Z+UzZHjEvhufcMlXyLIZtPwIN1s/+u8RRjZq48bvpeuPayOWfW
         J+Fb/4otzkeaK3Vdy8lCPC3eB9RBCn8GhLc7heN1vFVP9q4ydjXUdvpo2UeODj8w4pnI
         3U2EskTgi+CybbUvm2ENmYDQI1z+2WGH05tYKoiZpfRiHrWiIe6buKlq89fQvuZW9JBU
         Tb9vXBnunr44eINAYZ8ro5zF2ZOm/80xDpUf9AwUIovEZ7par2ZmHIZAzqOUsuelXjsX
         NhRxAmTKN1t8HnqRQxTB8Yt2e4MivMXJb52RcPmh/yVdXF6lHwMJT/sMwqePWJIMNzX+
         S0gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781272689; x=1781877489;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FFsEYlInaSHqLS2KZVjT1FL0qF+p1vPQhrQhmNDTg1Y=;
        b=Eao66luEWpByA7aLDFFVZm7v6bAWupSt6XMVK8r7z3Zz4DCByAgNYWjRxxBrmDDuPA
         2Y9cf90pwzQh5vxuIzQQCGG8iAgG+9zHlgI531eP9tqelGCimrTmKZGQtr9DFi6IqvKZ
         fboM1wNuHHy6KtBRDGZrWRw3AkOEQtKFXYL9lEjpWb6txzuVzTWI0okc5ymp8sYC+2zJ
         kNkD8Oce+XIxefCfN3Ou1nXaw+O2gXgwfr6KmSgK1p8VsjMO4h1z3ROaGs48VDBXKd+u
         Ho2MY/Y4RdDSvsNwqMwGdZo1frVjUPLFwCkTCnGm/xPZpPPLOQ9CCwd1DSCR3FpJnLVO
         Lc0A==
X-Gm-Message-State: AOJu0YxRPJoujHJCCuob+e+A2yM0SgHXjE/W3+W53ukkbKaQTQQJEX+B
	t9UuD/7jJS3Y1tXy+xtOsaDoHLLO1o8tRDTHDXngpgEUi82VQKw7ayHe+0OrXg==
X-Gm-Gg: Acq92OETTIeMovk5webekl6l9EZ+GBATA3KdNggn343QBKXOJrdz6iPoOXeA8hB38K5
	VfRgdu5h4yBO1DiZV2Dn4uZ6ltxmb8G4o4vRMtXarnOL/cNE4RRxc4C1r7yc1pBWRJAkEa538aY
	IAaHpfj/LvzWNVacKOeQh3JOOXzdgx59CBv7fwRZX8xLTQZuZH/ze3Y1XHaLga70ALR3lOCM8TO
	17nRmhCSLUb3mHjjdGRGOpaT5EUX7pRP9lUwftPAzY4rr0w1ttlL4V4cZGF2AQOJRSD5s1d7TUg
	eXVltuPJEcE0QpG+oFFtUxY11c4Q5uNvdlNnExCW++WdKqBfcUh94dyq7MYxzXmOqPAsWV1Ec0m
	f7mu9Dd8TculsUCTwPBo3hnGDaegKWaFxR3h4k6SGayUjyGNiONh6KDh1KlXPhr8dHIlqPzWsPg
	WWbWrQed81Y2iC9UXxPT0dDVfXMsoDzsm4DCNQJCiCEFx5+3aMUYDWzqpBykOmSVoyNbQd1TRsX
	iYSNjp5t8n5Ev+++L/wo2kOoCT6kAh6e1bsguOkgjrjO5eLL7WskM0SlAgfQkddNaSllqVJ2jFG
	vxb2cZNMxIBIUAonIADJkUH1SywtFKXrajxct8Hcz2QrzVbIdVehydVBVQV8xxBXNg==
X-Received: by 2002:a05:600c:46cf:b0:488:a882:c7 with SMTP id 5b1f17b1804b1-490ec4ee40fmr35602725e9.25.1781272689430;
        Fri, 12 Jun 2026 06:58:09 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490ea95c512sm39291915e9.2.2026.06.12.06.58.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 06:58:09 -0700 (PDT)
Date: Fri, 12 Jun 2026 15:58:07 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Marcin Bis <marcin@bis-linux.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: iio: dac: adi,ad5337: add dt-bindings
Message-ID: <20260612155807.000059e5@gmail.com>
In-Reply-To: <20260612133125.196208-2-marcin@bis-linux.com>
References: <20260612133125.196208-1-marcin@bis-linux.com>
	<20260612133125.196208-2-marcin@bis-linux.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 12 Jun 2026 15:31:22 +0200
Marcin Bis <marcin@bis-linux.com> wrote:

> Add dt-bindings for the AD5337 dual 8-bit I2C voltage-output DAC driver.
> 
> Signed-off-by: Marcin Bis <marcin@bis-linux.com>
> ---

If you're adding new device support, any dt-binding patches
should go first in the series.

Another big problem is that you haven't cc'd any devicetree
maintainers/reviewers, nor the devicetree mailing list, therefore
they probably won't see this patch and their automated tooling
definitely won't check this. If you're unsure where to send this
patch to, use the get_maintainer.pl script.

Also, it seems that you've replied with this patch to the
first patch in the series, making it appear strangely in my
(and probably other people's) email clients. Use a cover
letter when sending patch series, it prevents things like
this from happening.

+cc'd devicetree@vger.kernel.org

-- 
Kind regards

CJD
