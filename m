Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 835A739524B
	for <linux-iio@vger.kernel.org>; Sun,  8 Mar 2026 18:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772994580; cv=none; b=MBP37+54d7lLKtH4yVPa2mgXlFMeQqHs+019XC9omU8VROiOssmckp6UNJ6SJQ+Tb2LR2CuPwwsw8n90/9Ht1/igOlzqYOfzKZut2hNbKlRnGSyPJ3fuwBEWuRb54j17XTzjc17+X6cYrXV5nIxWHk0kWoyFOeoEwbFdHfCoIdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772994580; c=relaxed/simple;
	bh=bm3XsVGjFkryooJxAWHpozHBmRmQtMXuFqy6bl6PuhM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Z/q6gGJFc/ZGt3LKvNCto+9B7jrbqOlmws1p8jf8PrjQmsvkJjUlUsw2KPg548r7H4tuQuTf4X8YlFQ9b2Riy4843ZxEbCS0tKuxwg8o7gNFtgzRs3Qb3rEgrk11zh4lkmaZFD3Em1+RJvwh96eJ3aLU//Muf0zn9X0d2OOQsPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=jebbyOAI; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="jebbyOAI"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7d7422b4ff1so258908a34.3
        for <linux-iio@vger.kernel.org>; Sun, 08 Mar 2026 11:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1772994577; x=1773599377; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CD7iu+ylXOIKSlHyhq4ziqO2oHF1Z2J0S9R30cHWcqI=;
        b=jebbyOAI4/husFOioKfRwlYOldlzrc7eyYLXBrWC0d6sL+I/4CjMQ4KM4BpZB/IIbW
         Md2Pf4K6p4Q6SKZqZU3epOiylbL2iN4GEGkV/vPyN+3fuYK2eOrjEjzOfX1NAWYMum8a
         FT61fP9AX+Y3CPdAmpRev0TEbM90ZRUyOchOavFMcNlZshg4eHrpEyV60Fw6j8qHzR52
         f/BaMGAcU9deahUl0Dia0eMTO8HucVAuJQT4R9Qtx8Mx5MSYW2rf76JMAVD1fklSmQO1
         eXqFfxpVBkPQ0Lkofy9fA4QZEIOGDldrF3VS72DioFpyJucGj92Ff/7NtosWpKUv3rLN
         BygA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772994577; x=1773599377;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CD7iu+ylXOIKSlHyhq4ziqO2oHF1Z2J0S9R30cHWcqI=;
        b=E+ebUxgVtBBfkEs3kew9tDgSpTL3W24PoXiqn3sSa7eCisqEp0mfOGLSwm8txhs7Xi
         DDWE5CCBVnYykOx9axD/Uc7+CdlAszYst1OY+BJ3eRM6U3BpUioUQvNchHBeCyn/5nwy
         5QgjJ/hdHBCVhvPbpMM0WhJCbl2x03DWvzjfEzCNfdBtS7pBSYOlrjSn5bqyUIJgE1u3
         YL2qwJN9cmpMUaV82+KSzFIwQ0fKilpKLLL8wgiBK9SvjAUUjSJBHxRT6sdi7EsUXevl
         dIjmo07zq3gPCHnSYRzMfwpo8Or5nd2m2vs04OZYMSHhNYMU65AgLRlyeDTDEsD7usmC
         usnA==
X-Forwarded-Encrypted: i=1; AJvYcCV69PnPhc0GfMwpxk9JaU6pAaMt46Sk42QLA3G1BWpvqtSfMZwtdlBicEj/s0VMqdCAVHwlHUFvMpM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyygz3RkZyquGM+ecyZFuOUZFzFSTleU6wrSDNl4U+/UIpVCesC
	0NqykAOP2LzWX/K/MsE8lJUwMw1/t1nADJCTRCk1F2SDyFmXNZK03p23aKmc2NRcJUg=
X-Gm-Gg: ATEYQzyHrVxmBxebdeEmf6Rd7ezMVr+TGHDukSg+GzuI+cW2mxW2B23+dKykuMf0TUD
	oal5fOioHoiMEG6e+fwglH1dYj1In/mLKaPG+ITF063EahC7R7gCdEyR7P4oCTbDywxm1HNXbbk
	sPRKGrGb6Nb0qeuSXFHmtHSItcow/uLv0O2GRWQrsejKPRbHJb5aPJ+DBd3YtROY6g9KW9vWLA6
	v8Im1Ujnfx1SamR7d1hQuj7zft1fmzFLGeDN3fo5atX9zt94HM9RunJw6FsGtrkXulGTK69Sn5a
	cmlVB7hq0/ABLrvROcmL57WAZxN60QMMWJNa5jYfTEiU5Lxi2OwdZh7qnLKSnmq9tbBCb4rrBaO
	NTl6sdhsYrbMl6CqFU6Czxs+nli4YXbhBKCRBpFeqsncmoNEeE29szxzCKfLBvl8hnm9At6LOY6
	rqF/EG6hywwwW4J7KdIgTY29XvYPFC7aAz7UWXD3zRRtOR7w+P0cniPUqR6d15QCJo/Na3RH60R
	Q==
X-Received: by 2002:a05:6830:6aca:b0:7cf:d91b:c49e with SMTP id 46e09a7af769-7d727003267mr5329081a34.18.1772994577469;
        Sun, 08 Mar 2026 11:29:37 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:a7b4:e550:6d81:e067? ([2600:8803:e7e4:500:a7b4:e550:6d81:e067])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d740fab570sm2150965a34.28.2026.03.08.11.29.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Mar 2026 11:29:36 -0700 (PDT)
Message-ID: <a0afb85b-4bc3-4b96-abda-404f7303a688@baylibre.com>
Date: Sun, 8 Mar 2026 13:29:35 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: imu: fix unbalanced regulator_disable calls, when
 probe fails
To: Andrey Skvortsov <andrej.skvortzov@gmail.com>,
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260308110328.2859831-1-andrej.skvortzov@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260308110328.2859831-1-andrej.skvortzov@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

The patch subject should include the specific driver so we know
what we are dealing with right away and to make it easy to search
for later.

iio: imu: inv_mpu6050: ...

On 3/8/26 6:03 AM, Andrey Skvortsov wrote:
> During a probe functions after all regulators are enabled, runtime pm
> is enabled. Before probe function finishes, runtime pm triggers and
> disables vddio regulator. When probe function fails after that,
> inv_mpu_core_disable_regulator_action tries to disable already
> disabled by runtime pm vddio regulator causing following backtrace:

This sounds like a similar issue to one we saw recently [1][2].

[1]: https://lore.kernel.org/all/20260205-inv-icm45600-fix-regulator-put-warning-v1-1-314ec12512cb@tdk.com/
[2]: https://lore.kernel.org/linux-iio/20260217-inv-icm45600-fix-regulator-put-warning-v2-1-08ad62b1dcdb@tdk.com/

...

> 
> This change introduces variable to track state of vddio regulator and
> whether it's needed to disable it or not.

If we have to track the regulator enable state, it seems like the frameworks
are broken or we are using them wrong.

In the other similar patch, we moved the pm_runtime stuff around to make it
work. Could we do something like that here?

...

Also, tip for better commit messages: this last paragraph should go
first and use imperative form "Introduce a variable..." (don't say "This
change/patch/etc."). Then follow that with the explanation of why we
need the change.
