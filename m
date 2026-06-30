Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD9B3FA5D8
	for <linux-iio@vger.kernel.org>; Tue, 30 Jun 2026 12:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782824013; cv=none; b=id6D89AG+76WfwgQgRmBc+H9Jr7biItNgo2pYbGPTywzg/hmpp85egQSZjEtM0vWmj0cdesuoIELwaqCzR0YRVkC9EQtFpzn4TnqhoO7Pkk4sZpfgBZDR+zXM2aAsX7wDXiBGXe8K3J5aR3O8Dd9CBOEnCf/hpXfNX0xwLW13Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782824013; c=relaxed/simple;
	bh=I8w7twwhO+Fudt6Dx6OVYjJDtxFmOgn8p+UBgRfNcPs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TBDdWU/eLvBjx+nNhteHaCbRaKcmAQ6fUqaGE5McXT9H08NU9lCOB2xtnLCNrn/1O9cw8Ac1YgcMJU7FLekZwUrpYn17pPrEotlMwcsIZla8TMk98eckvWsZaC66vzPtOXeeCbav0ra8t8DoKIX2CehaLA3Y3+mQQWUMwmCHHcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IZC1jzOd; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IZC1jzOd"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-49270caa5c0so35322085e9.3
        for <linux-iio@vger.kernel.org>; Tue, 30 Jun 2026 05:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782824010; x=1783428810; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mSGodP7cK/pvMw4+oLYBMKgoaJCXar+mj5YEbsdMiWE=;
        b=IZC1jzOdPQH5+zQT+/7+hntAN6KS1fgze5mtA5xYGTdQk1XsAOvAgv34wh+a1ksXZS
         DxHPKWKhTJLNGG4aW/+umHE2UDdk+uu1QFO8jmhOSnNyMc5Jd5oCklu8nSVrm/6MOQ7v
         etMoAWbnyvfzAkrAgSmxPWviSDsGqSqBsKU89XedKj57vxnNOrxuyeZiRAXMGQiMGd9w
         798fwA8Go7rHhsTNcD340nbB39cRnwYURcG0ncKNcmPU4Rz7cIz9tTtPnBFygJe/QOK7
         kTbYmzPeLHmnWTOBzXiy+PVMBtAQKRyUBS1yGNH5oyx+00d+TNz8yI+Un59X+jPMaZij
         e/pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782824010; x=1783428810;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mSGodP7cK/pvMw4+oLYBMKgoaJCXar+mj5YEbsdMiWE=;
        b=cysl2rdNAwOkRj+E3yPbGieul6ty0nG/5IjSDREM83MWGNkHXzUf+SzlEKEwBn6sTy
         vh0Qs7GGbHFDUBJOkU9ZfLeX02gH8nlrSTl9DI7DlQ0UaZ5Rd7LkjkRrgTxlyUBuQF/y
         RUQQYIHBZeBQonlG0xPXQcBVXGfX8zl4H8JzJwLSfbD2cgXiBBz+ct+5XGLBx4ikPj0W
         UNq6PzQwgllE5goqw6S7kf+4jYfKSXpn6nXuBq4gQpwEmTKOs3CTHpYiH/47XjsPu+cR
         KtrKInY2gQNv/djLwwwUrdiXOcjJCqZ6Q2/CJApJxWvRrrNOfGF4x+ff3sQpL0Ps1hYH
         tLOA==
X-Forwarded-Encrypted: i=1; AFNElJ+VRoFu9NWWfiVLitWrzc0yd3836glO5n2DHfiLzlb/swpbuhEhcxPbQzmfaV0NOqGKdeVP0RSGLDo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/R9GNONO2KFCp7jgsx9s0p+5gNuYEDqVl5YAy7W23RN6Ofpts
	3/vBZqYTg8sKwDiuWaUiI1hVCVTyxRjnuVaV7SzoJgkTbGSuSBLymFDv9CKWNw==
X-Gm-Gg: AfdE7clF3x5amXaxl7jUnIpe/rCtwjYKdhGYIhMEA7v7TEEFCfMA+4dGhbv1PMZ7A0I
	O3zZ2Cos73qx8YMrRx7EFMU8aDFB9EnZz737dXgKhzaGJz+vzOlRtttJCNB3spGxJgC0hf0Z26V
	gf3wHA/kUb7EJkWiCcd4Q4WFBOABx2Dx7qfcmkhKALZP0t4Gtb7SroJHYgrLHbObkpvPzImOwmP
	V4FhwjgT2+kWljbtmS/InL6KWtXRvAehCMU383SYCIjDnWTFSL5cS7BLCzCDeXWCDejHW8f1V0b
	d/xOTYLgGJRSTvtBxfP6c7pbrH3z+xSVt12wGPxWvOhMoHY/0jaXvpSwySuuDFQrWNL6K5fwEy6
	79VjpmtmR1ReZmecalmH9SQq1CdTUhRdaTY2cfprd0OCqs+xFHtN09028fAAaiMqmDAdJ84q+vJ
	8DhS3t0eUudvCJojt1S0W+PfxrYZZ51VUSY9bue2fhpMuKCp17lLb+/q+tZx95ZkKc4W1AtpuUk
	ZruqSwFolh1t/E1usE5qi56KrN5STA76BgIHCQyE1mkFVrcsNwxzA4EG2iwwnrSgmJdY/fjY4uW
	e5xxVbj2BoAtRC3Wjd+4jyyzJSL7be9c9ee6AKnHsmg1u7C4bUnn2B9sa3rOU/1uHA==
X-Received: by 2002:a05:600c:4694:b0:493:a8eb:5145 with SMTP id 5b1f17b1804b1-493b827e9ecmr57348605e9.4.1782824010074;
        Tue, 30 Jun 2026 05:53:30 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493b8c66c15sm70148205e9.2.2026.06.30.05.53.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 05:53:29 -0700 (PDT)
Date: Tue, 30 Jun 2026 14:53:27 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Moksh Panicker <mokshpanicker.7@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, nuno.sa@analog.com,
 Michael.Hennerich@analog.com, dlechner@baylibre.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 skhan@linuxfoundation.org
Subject: Re: [PATCH v2 0/2] iio: adc: ad7779: Remove dead code and redundant
 error message
Message-ID: <20260630145327.00001b9f@gmail.com>
In-Reply-To: <CAK0z5Okxj7r_hdB8xzdkVBX9z4xHyfcv4ZKfkumYHiObCc9tfw@mail.gmail.com>
References: <20260628145734.77191-1-mokshpanicker.7@gmail.com>
	<20260628191350.583470a7@systembl0wer>
	<20260630001156.61ef50d9@jic23-huawei>
	<CAK0z5Okxj7r_hdB8xzdkVBX9z4xHyfcv4ZKfkumYHiObCc9tfw@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 30 Jun 2026 12:43:04 +0000
Moksh Panicker <mokshpanicker.7@gmail.com> wrote:

> Thanks for the feedback, I'll fix the blank line and wait before sending v3.

Also, please don't top-post!

-- 
Kind regards

CJD
