Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37B62F8E84
	for <linux-iio@vger.kernel.org>; Sun,  5 Jul 2026 17:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783273054; cv=pass; b=XtIF7HmKJCYW8Y/M7pgtExfHMAiiCnLMubPPHAU/jpLHk8R16zpHTKRIEaN1oAFHVB6G54m7fFA1u5XpDC4c/Upw3JSlipGCfyPda4aZhQq2r52f5DLj+fTPtXcGe9tqIIvIOmy6gmBzFIkSPGYYTRXD6n7aVgQXO+tk71HU6l0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783273054; c=relaxed/simple;
	bh=IFm/WnhCTaV7U9ONGScAKE4YXKRpLiC1OsTXHHvfYUo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AboHMyebgzpBj6CK+BOsbqW9Y/9Qa924OSuzER2s2TuquuBqvyv70Ct7ws3laZW2VOyWZwJIB9IPBoP+cXmZy2lSBYaUVtrVMzKt1FD0NUD1hAANEs13gJy1aYQpr1CDSSs77XTMoATSSE+qY1BbJ3YpoaxKgpjY6P3fPzN+T8s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fs3G+17g; arc=pass smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fs3G+17g"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-493c19bad03so19752525e9.2
        for <linux-iio@vger.kernel.org>; Sun, 05 Jul 2026 10:37:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783273051; cv=none;
        d=google.com; s=arc-20260327;
        b=I/PukrhCTVC2aN1ZLGk3I7tky8unYI+FCPLqf6zZqzt7Q947TrdRC26Yrtx0UhcRPx
         JOt9oPzWUhfSgJC16OYACdQoGbUUB41o3IucspAD76LXON+F9h8K7oG7Fzb72zyqubSZ
         sd/MgDhB9o3nwvk7lSfFfClVg8ro0snif6b9QP+iBN9bcmk+Ih3tQE+HFu5W1MwapKeY
         CTlQmunVrSEpHGO+C3BITOnsTGCd52B9L8sX3nWz0o/QUDIp1pU6O0YMwjxuAifDP4fS
         jTga2nQb+tR11gyOHVUrE4TJeCNX39yyFakuDgFZu1+olSPwbVzacpbdocgFgnZ5RmEe
         ozwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=jte5AFn9Nze0IttfmjA2LvKdWxXfgmRLYG8V51pnxzU=;
        fh=Jem8Ko6G3Qoe6Nw1u1KPqC6tWw6bkhn6aySDT6gu/kE=;
        b=PH1Xn34WZoO3x4arhAeqbOWuD3vXNex/WWdPrnAcwObHghD24M8QZFZv1cPszN+17Z
         875K5JIvw37dNJ7LFHQJ4PVzdScXz0sYrt/JY/tbLA/O9UlUJ/p+5O+JyzssX0wigj4m
         6o1FvQL62gM+h3FVjt27QKnYTWAkP34udqymXj0WhCVcUnRCufGUGYBwcuPNHodODBQT
         ErlileCc8A40XjpixeXTXJTRWkPcbBeM9oN+BScQutOTZ7Dy/6OQXcAtiZiyFanP1GJm
         jensL8k1ERaMCmQKHmpAsvPjCeWav0ASZOmR37wsaPktBPErsAVutP2VpSHF2C3e8y79
         wTFA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783273051; x=1783877851; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jte5AFn9Nze0IttfmjA2LvKdWxXfgmRLYG8V51pnxzU=;
        b=Fs3G+17gKfgscnNxeWGsdleHUtu/HAKhRYQEp4ZWs8tsreyqmvyH1mgZLvHU3G6skk
         Zas+g9Rn9oSYo2nfPNQ9fF+bM6jmy7I8fxzr1079UAq3+aMJ8yA82IABeMBuxzz2W8M7
         pOMLV/E2JwyDzC4Fbt8Lnzr0h0t3SeBeviuaeqnrOJDj5op/Oa5WPl/dVJficNthJyiY
         tdVyMIZvHIDmb38JlQNa2JbQcFb5QRkr0Pe/8yHaOrDXvTn3sIIsdmOG6XvQmAKOMLrr
         R/a83mHAurkYZEL4UAtFOp1npkMc/kRsKRafkJbEnXFVgTWC1D7noCpBh6PsvEuibGMA
         xRcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783273051; x=1783877851;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jte5AFn9Nze0IttfmjA2LvKdWxXfgmRLYG8V51pnxzU=;
        b=Wiz/SRtyXZ31GWll+kVFTSgtUhWb3vtzhwxLl6DB56QMC0xVzgdvYVvcSq2g36Xndm
         FjOdHEyEyiP+rZ5Clic9rh83XOptqFQNsndCRrThEGAENX0q88FgQbGTHxGgn/Ikt3hp
         xG4GLQNnxvmqhfpAYHh9kwdfDIv0xZt5DHTE2uXw5w0rihIuFIOXAnq9YXSZqBS8ONB1
         M6dnDNNl2lOrGvxZHBGEjJx5lQYhzPlOdrc2DXb/V3gYlHcI8yGKJMLM9cgSKjAGvoQv
         bDa7J22/Rseow7ADpXVqpMlC+iUefGvChsSrIlmQNahEWzFYCHEcIEKz44kqh2b+3nXu
         /7sA==
X-Forwarded-Encrypted: i=1; AHgh+RoODGfRRN6Jb3rQ7fcLkRnJzHOuX/SGcnRSb/JogEh4Yutxf0wxraNEK9E1l8P079PW2b/n20bWJNk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqfVh860Q+f9ytcXtkm7jCp+S6GC8hX5eNY7885KKLfg9tPH9d
	yqfTWqW0104JAXCuGq3zMbDpI6/3fBJCk9pbCgpP/kUQr1qaS1gh0+MH3iAxIbH8QQSPS+TF/yt
	Mbwr0h/6qAEPUbyRSiTMRMj8QJv4nakrUqVGSshw=
X-Gm-Gg: AfdE7clvVl+p8yxjsrr4dOaRFOq8ZLvwnVygiMGsSLFYheZm7XJ1HUliUj657hXLhTb
	xGZzkRX0aD8cWmklb2T3tmS0fmCgVp5olM8GR31Z2VP+DbBZCESQLhpJG7cuWPp1+8wlRekLT9O
	Ohkok6jZwAxgrNfM5jsOOJTch+U60I4edoCeEGpPPTOsWoSWqROHjxqxRSM9B6JW7zhgDMaa+eh
	Q5+Iedt6NZGg5uBIKHglvMuL1NOQ6+pqx/GiZJ3fjpzuzD8ypYm6L0xUX6DcRzCfdC6UAnvkypA
	HDd+bYxNA4vg49KSN+uU73v29qxksR7qlky/TAlCzviNvqlnszTtKW0VG6EWBcW6DN06Oskenkw
	K9e/jgKMNGO+4J8wL685ZJFvMV65139f7zrC/EnJkf9XfBFrnlIDA1DWPmDCTf+bclIfuSAOScr
	+Hn2DDZtRMEekOXb9r88ALB6VbH51E5H915p7WHwnuV1dY1YhKmPH08RdNjq6PeFKKn5irBjwc3
	Q==
X-Received: by 2002:a05:600c:81c9:b0:493:aa0a:45ad with SMTP id
 5b1f17b1804b1-493d11d06a0mr73925815e9.2.1783273051210; Sun, 05 Jul 2026
 10:37:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260705172438.119204-3-krzysztof.kozlowski@oss.qualcomm.com> <20260705172438.119204-4-krzysztof.kozlowski@oss.qualcomm.com>
In-Reply-To: <20260705172438.119204-4-krzysztof.kozlowski@oss.qualcomm.com>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Sun, 5 Jul 2026 19:37:19 +0200
X-Gm-Features: AVVi8Cce0OHV12Dt4sEnLvJlkpBMW5Mglff6JuBiiNWMwwf4gFnXwIfxtbzj03M
Message-ID: <CALoEA-wpN6CpCHufphWOPJL4seGZOYOgQFmyLui93hqAgZQA1Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] iio: adc: ade9000: Drop incorrect kerneldoc marker
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Antoniu Miclaus <antoniu.miclaus@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Andy Shevchenko <andy@kernel.org>, linux@analog.com, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 5 Jul 2026 at 19:25, Krzysztof Kozlowski
<krzysztof.kozlowski@oss.qualcomm.com> wrote:
>
> Top-level comment is not a kerneldoc, so drop marker to fix W=1 warning:
>
>   drivers/iio/adc/ade9000.c:2 This comment starts with '/**', but isn't a kernel-doc comment. Refer to Documentation/doc-guide/kernel-doc.rst
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> ---

Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>

-- 
Kind regards

CJD
