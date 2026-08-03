Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F5A411A01
	for <linux-iio@vger.kernel.org>; Mon,  3 Aug 2026 14:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785766410; cv=pass; b=CVwY6cD3nbqAYzoUaUdGpsU/2U3R7q7XZruQLUh1ZV2dNQ5xVjNlXjBtoZLltw2cKerGl/46taUjNFNH97n1wJmkyP+85NixF0fXkB134moZNznUryyMNOv7dFPV8gCNtsT7n64ONW8/8KIvT3k1ZQzotN4IHt0B2T+5XyPz4SE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785766410; c=relaxed/simple;
	bh=oQhcgDYE4V9l+J4BrYp1bBzaqMS76rGWzomp6RT6kyM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M2eJlnBBgcOl7TCJ3LMXgMXQghbXJe8Lx/6okhvZcmyQjyarbRWwHoObs1IKi8SDKGJUJQpNfvIXl1aksZxjFGitMIE+rGrgCc9MgzoB4GF3ddwWc/Op3GGaL8hldYKQHiT06zr4m57+m5+aU4mPx73XPikoxdIV05rE0crlcMM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qS3foQOl; arc=pass smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qS3foQOl"
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-6acb63301acso1407783eaf.0
        for <linux-iio@vger.kernel.org>; Mon, 03 Aug 2026 07:13:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785766408; cv=none;
        d=google.com; s=arc-20260327;
        b=NJarhhzG//LuDKq1vB3pB2XqTwM4YJDN37YOItqi5cvvUOoZXYrOIa7CjfJhGf0Q5s
         6F+FEfefIOjvJE+ZaMdmMih3ax61FE5OA+0zrf+0BW0y0XEEO9R4WqdcCHRzCW5rEfb0
         7Sd6asqfwSHbJDZ9/cZQHFYio6ie/IDHkxZlPfJhan98+kxti/F9961rl3ujP+UAvwWP
         bU5p5HAFzTIeLDsgPV5wqzldWvG6Kwn5Mf9d6jwnPCf2Ff5RAPjM2B9+ayVSGkcarBP/
         ZZXezyE6lyGggeARwjgzoRKV6n1rEvpxKDW69H/f3E6qgu0A1U+l3ZItBryy6hlLX7V1
         IMmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=oQhcgDYE4V9l+J4BrYp1bBzaqMS76rGWzomp6RT6kyM=;
        fh=3ZTt3uoUg2xm9UTfHMROHixnfxyjMhpJ9tXktkglMjI=;
        b=ieH1MOikq/QQG/mQthaR3Zjl+GYczX3gpOOrPYaqiRHi3+Eq8M3f+jjzjcG45pu8tk
         rorMBdsAgyWrdts15erzgJfq6xwqBT+3w7ggkhycvdPD3m/HCMS6jRevo3ge4+4wcRBu
         X1jOl8z6WAKrVKWGSGIu/f9DiibAz4EnmjKE2GR+rP4/VzhceWdawuTWI1m9YoY5AYYO
         8jSZzcCQPF7yf/JXz12NlWNdcBQciWG3PDx4mncknB8Jd8L5td+9JP7pPuchdeE0O442
         Q5kr3TRqX5Mpr/UpK8vD10/dL8k6HKeyAz4NBJLyQK8oF0kb+76MiTM9gnGc0cRmPYms
         m0/g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785766408; x=1786371208; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oQhcgDYE4V9l+J4BrYp1bBzaqMS76rGWzomp6RT6kyM=;
        b=qS3foQOlgDijzwk2Rei7/KmfvM5/xOCyflCQkTWiqG/fn0kUaKmKyXWxB1ZtN0gfY3
         pnIddgpnIIX7X3pIpkUp/sECxMeE+ybGmx0O0Tfvrt+GL0SKHNTJVQthp5RtGO0on3w3
         4JGILw9zDScELMKns0LuVUzg94jOsZ03LHbseILnJpzjYQtg6TPXBkO+yST3sUx5V0JR
         AUbdreMxYzO2xkw7x0QvfjDhu+bgzWkFnLCwS2h8Z5N3QpSi42Pl4/tHnJnA6tFhcRhs
         TS2686UDAK6XnEkb0dyEPyGlLmIeG1QnJQHrLcDqpobACMCm9buQSzh3JlbzCMtfw4lr
         qOyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785766408; x=1786371208;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=oQhcgDYE4V9l+J4BrYp1bBzaqMS76rGWzomp6RT6kyM=;
        b=PVdQEhLYLKGniR2kFPsLx5vp/HsQVMdbII84TTLYpTeZWx/slx4xulEEThE2VOKXmv
         QoYAQftfkl6fChzW06MjkwVf/1OHRA+usSIjv3lMA/npqiWyhk2zSqrrs6wNXCUjDMnl
         mUl0cWRNJSyR5e2NTCTBhDWHsVus/YRC/hCaOwgsysNVnTItbuUlQfZgcg7eZvcwiM3s
         k9zX8oyAhVHOcUVB/Cvw+DVKBsqKD96zMWhJSIqHK0pphSl6F4HcNKRo9gEgak/7fRCR
         R4HbOh8GpuESIGtzzgoT8Htnb1kTiOHX6PsFV9v0BJrCg8xx0kMnnyv4ska7KcXIUg5C
         2w7A==
X-Forwarded-Encrypted: i=1; AHgh+RoRK12LiekZ00hGexvLGfhkprDlzk//7DMiaim0NfBrzys2341p0P88DSUMeeTDccZecXTpE12uDiY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzc1FU/Mn6xL5wlH4ICW/YTnvqim4MriOD5muaXKL8ZYaSe44UX
	a6iDYiUgj+hFoD8rIpiRW+gIzEVL1GsmbdDEnAkCCqKFSZBcJTKY2Pyzfv3a8BUpHFvnrqZncC8
	EWVVVElPZQrHzAy6iWQtJWHzdEX9u4Bg=
X-Gm-Gg: AR+sD12jJ9mZQyrWYApKU2SP7p3tPLFePVDG/EDwmk4p6jdq1GjiFiylJ2EYV7C2VL7
	S+grwbM/A66bw9iOq5/BP1d37c0RmSzF/hPiZV49be5B4YAiRYse+/J4qdMGOIthWiwHtcKLv/W
	bKTTtYAeoQ+CI6tGZQR6jwG9q/zZ5tmcTwggpJCmeVvHXOG5ctHkvXLEJ0glDV0loKb+izHVF81
	oW5nX6ImnGaqRVpzU3qCTLwwvwvRzGbSeBYtCqinOT+b1t8Yqn6K6NacwWfQ8EZXO1jAyuvrBK8
	kEOZ+Hh5u3oGWjAPR4ldh4TYeumetOxYt3XxXjh+OayJU+/nhxT2S/ZQ
X-Received: by 2002:a05:6820:f026:b0:6aa:da90:8bd1 with SMTP id
 006d021491bc7-6ae38367df7mr16031842eaf.11.1785766407959; Mon, 03 Aug 2026
 07:13:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0bde2343-8a70-44d4-9b27-8ce42c099309@baylibre.com>
 <20260803121520.6274-1-abdelnasserhussein11@gmail.com> <20260803154231.000070ab@gmail.com>
In-Reply-To: <20260803154231.000070ab@gmail.com>
From: nasser <abdelnasserhussein11@gmail.com>
Date: Mon, 3 Aug 2026 17:13:17 +0300
X-Gm-Features: AUfX_mx26LfhxigSYrDT8xCyVWGLlJyya_tQ4hFcVXkYDlAVSBLkgKGnQKxuMyY
Message-ID: <CANpqX3aj4i=X3-aLasXQsjPS+R+woJEGzRJHPHb6wpTafTfLuQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] staging: iio: ad7816: Fix DMA from stack and race conditions
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: jic23@kernel.org, nuno.sa@analog.com, Michael.Hennerich@analog.com, 
	gregkh@linuxfoundation.org, linux-iio@vger.kernel.org, 
	linux-staging@linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi all,

Please ignore this v3 series.

I accidentally sent a few unrelated patches after forgetting to clean
my working directory before running git send-email.

Sorry for the confusion and the extra noise. I'll send a clean v4
with only the correct ad7816 patches.

Best regards,
Abdelnasser
