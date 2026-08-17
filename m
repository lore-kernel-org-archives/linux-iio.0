Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45F94399F8
	for <linux-iio@vger.kernel.org>; Mon, 17 Aug 2026 14:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786978531; cv=pass; b=jwMjt17HGWtP5VpPMexApUEJQ9Kz4o5cNl3D6dZ3TftPdn5TsU5XNZk8amm+evfJ44Xb0I0LQHVqLFgh2yr73Gke9z9O4/YGVuEmDc5mhkgGRg+LvsDfI+nwNcF4sQ3W2c44QtJMsEipsoaa5kaoVgGsNJ26bKvtsI7TBMBAhdI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786978531; c=relaxed/simple;
	bh=Mcw2h8jID2KIUdY3ofOtG54evB8hPVgErX+Eqm0tAf8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XrkTM6d4xojNjwE+jWN8gUsUXTL8Ie5mjK+TChBmmlNqItdK4+BRK24370LKQs4F07uA6TgQ+byC5Cm18AZEOCFApueT4dlVOajVzuDKPpmUj/h778Ud6AIbGIl5ZaJ22KlCwVaCAI9YW+EZP1M9QHJfNYfD25yCzFYQWeGJeMg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MXzh2Ig4; arc=pass smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MXzh2Ig4"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-4518ad44e83so2196123fac.0
        for <linux-iio@vger.kernel.org>; Mon, 17 Aug 2026 07:55:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786978528; cv=none;
        d=google.com; s=arc-20260327;
        b=jHwI+uO6Ctw86R0DcItYrRL8B3ZPOEQBUX8gAoXWsIPBSpGeg0gxk+bE4prlgNHhbL
         Vs+x05IwS3jgytcreCAWbf/wIsFFeIR42s38HnP3fR2mUe6WnwZpBM2lr0DIXwhUW7hJ
         te8KRx+IKj1IfdPXbqoULiFmggWc6L7T6V/HOM5jpxnh/PN6KGW/BNp9FMQ7nSxdyMno
         fsUYwGFBzuhsks/r03lWpXPXvOMJOonZhrkaB9FL0kZ6c2gciEFj7UI2h0vXjf49BloL
         YnPg67iOnJn2SceHHh7AXnn1XZjFQi70rSOl11WgY1jrCEswSuiDUByhpubdEgXEKlED
         bOSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Mcw2h8jID2KIUdY3ofOtG54evB8hPVgErX+Eqm0tAf8=;
        fh=+VZJ7LXfISrAw4pY6XJrcG6KsqV9OjFsVyUtVAS5ElQ=;
        b=c1yWERDUagvCoaD5vXIMha/TujmzQwLAZjJQ1k3OxEDntT1iJQkSO+85qzrtg8zG8o
         sXSCzUmg+vWWkY0psQ/wBz23GBqSrJYMvCDZjd48N/kyFdu7V63H0Raa3HYDlt6gqcB+
         G7Ib+C0aTav3AL0KC1uMpEVJgw6VmTEvdv+fxf5MAzZI4/55M6vOwpcD+BIarRCY9TTp
         qTu8qc3JNI05h4HL5kdtCUhdAe51cPG05q7sISaYwPBPbTOt7dFhM0RbK8JEbQjR3zKg
         aKXS9BD0gQ7NmBV1Y0IYI4hRlhgnjeroJJJi6c9Ap92SQ3YgnC+0Cs47h7GBBawW6Aes
         FFNQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786978528; x=1787583328; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Mcw2h8jID2KIUdY3ofOtG54evB8hPVgErX+Eqm0tAf8=;
        b=MXzh2Ig4bcAUtEKIJcyOnOgbCmaioRqUQxxjkPi95RDf4qrp4EgL4kJp4zFqYEGchT
         RjqYoma2ou9ST8TCAbxBd5ZjL8BoZ1ZvzTW76jQhITVrRCklQKtrviWn14p1aaD96wGo
         1UCXePUgjOW67uiBUIIui7S7Ube0/G+S2uVrCL2MNEA/TDnhLN1bMd8mux0XCHPXbt/k
         37N24WuuGI8pz1+Dma0ycGwO3Zj1gpd2x9hMpCRFJogRS44RuLrpTPW5DbApjdzCTBUJ
         7LuHzZBfR4A0vleiWqYnIMbnpP7Y5u95UeFSeg8JqE3SJYVxJLRUhpZfIzgzkA2vI8Qd
         KKhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786978528; x=1787583328;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Mcw2h8jID2KIUdY3ofOtG54evB8hPVgErX+Eqm0tAf8=;
        b=NVmmuqXz/FQQK6f2T/3u8NENJovmcZSnJxu9QW2Izq5ac7uT2bNT0nszd5ZCLz6LFV
         kbXlttBTgJVZnifXeTssVhBXK3udted1VfuuoThSofLKTNth76Ywb7C+mZcalphREEs4
         FzOrIWyGC8iNATh86m3v59k8oJWslx1N9OHlbrPUWoeESCW/86DAleSWsDV7X2Ar1FqS
         xgYKBUPwUM/OnSs2o60BL2mAOUFdh7Xh9Hx/ux7hV6+fs/lzKxLnUyYKE5ye+cBytEhi
         ZC4/eLI0EOnEWZm4reJQXgbUq2sbyd4Xqo+aaA3VI2bDUgUhHWQhOgc8mJOCyPnSdYku
         8oow==
X-Forwarded-Encrypted: i=1; AHgh+RoxGalM4CxNZIV8aywddrX/Ff6+2KZj8tdt0NsSdDhw/OAN3fSg/V6PCEEjqu9WCucMFD+OGKfoSvQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywyo2SNrj4qbc45h0G2LBomEsV7WqmSKHZQ1jhGdHaUHPiv1p5c
	B41gsOTjicGFfVABKE59J4W3VaoC1L7LvhjLHwhrQWLIB4/8/wUZT/vaagYUfizJwWrwwoihBWH
	5ZUfxz3BWc3+LpJI9cVX0wSXsVs7yvKU=
X-Gm-Gg: AR+sD110P5bX1duvkZftCLOz5RrBFuuQe7+bzmY8fNsVt8J4jaPAcu1PFqnw5lBxTxP
	0fLWzLmCYSkI/Vf3muI6M1bfm1KpxlDxRk1PxseXQXEbDeL4MSghuxWTV7Eh18OrU3pcSPg73t7
	M9v4YTTFYUjBAZIn4uEraEYxt2HaH0Re+xC7055VUmoLqGUmFnsfBtuJgWXy/MJMbuIvNnjjJ0h
	+xE33354KIMqpR585FX9bs555MHYzJmFPoR6SZQ8eOIEZNlQHjNh2e9kG8Eh47U6BWFvw2ONYAJ
	FXTdKswZL/LWDqoxrM8YV0XAiWJEgzsr6fe0M2XriA5vVujr1Q277rR49X8uOuHaoOYG4slNFpS
	L/wRz+U8sWtLWI82FeJumMXeBuipA
X-Received: by 2002:a05:6870:1e8c:b0:43d:d0c:ac30 with SMTP id
 586e51a60fabf-45e918368fdmr23866784fac.0.1786978528513; Mon, 17 Aug 2026
 07:55:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260813153129.12423-1-adinata.softwareengineer@gmail.com> <aoK25pW-4Sxr2yh5@ashevche-desk.local>
In-Reply-To: <aoK25pW-4Sxr2yh5@ashevche-desk.local>
From: Adi <adinata.softwareengineer@gmail.com>
Date: Mon, 17 Aug 2026 22:55:17 +0800
X-Gm-Features: AcwNN1Ue9l-bXG1exTOIxFazPrWQUBG3yRYjj1B2-3z2HklJWD1XMeq1zPkrhQQ
Message-ID: <CABZ6vuAye2aO1BvhXjBAdAJFOmDGkQcXrPN3Bn-VhpEiQGXQog@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] iio: humidity: hts221: update probe and logging implementations
To: Andy Shevchenko <andriy.shevchenko@intel.com>, Jonathan Cameron <jic23@kernel.org>
Cc: lorenzo@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kernel-mentees@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

> Looks like you've fixed up the stuff Andy pointed out in v1 and all looked
> reasonable to me, so applied to the testing branch of iio.git.
>
> Note that branch will be rebased on 7.3-rc1 once available and only
> then pushed out for linux-next to pick up.
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

Thank you for the advice and help.

Regards,
Adi Nata
