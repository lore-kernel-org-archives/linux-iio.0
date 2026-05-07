Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82A234E75E
	for <linux-iio@vger.kernel.org>; Thu,  7 May 2026 10:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778151102; cv=none; b=PPW+x7Ds003SigCDw9XeoBZSAUAgfALvrZAohYDdo5ev4SLSE8puTRKx6K+fc9qhyIFGYQNERFg/2dkF8oaXXxjzsqtcXrjdD0YPI3UtyNW7R37di7qEESFRNWztIU+pqRggNT/kCGf4j5C21OcP+0HPe0/oapmsJ8A1Hnj/DrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778151102; c=relaxed/simple;
	bh=H08BrTRalR0jUvy/90S50ZaX5dzgHvM0nJcBr5ocsmg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s8BDCPJsujpThXGFQZOIhpNsU0Fp8CwT+VWXBn5ntaHox55S2bLXT4q3TUadskodfJacDMvz7DnsP84akOfj8on0yCxmz/zOkkip+2IG+zE/WFG9lakkFE2n8ZT0oPhnGTJv4f6K+sJogj+t+LwlXhlcTyvgg46F89ta7KzD20E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MucplbBL; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MucplbBL"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-38e8292423fso4794491fa.0
        for <linux-iio@vger.kernel.org>; Thu, 07 May 2026 03:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778151092; x=1778755892; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qnRfUwgP4GDJT73gEU34kWTDXjMinDYaY8kcXfNdp88=;
        b=MucplbBL1HXTH2B1ifhGCkGpW6XfXqP+OQ9q4z2GywbDt+e2IUVpMI7ytOyu+Txjpy
         McvjV390u/wsh/OdqjPNt6ICPelGKK82U3N9tKuxXG2gJ91n1d+oam7HCL23OHhykmFS
         +mH50MnwE7rxcCQgJ1mff0JEAGeLjp3kAhB4m6tI9N3+ieYEcMYzUnUi34iLs9tx4k7F
         jVLDon9QRWbO4EIUZrrtIj7hofUCyjko7r8Vzjl04wITVCpH0Rwk9VKOUeyXrYnBqM5s
         hbmAYQ4+XFgIVu1TAoaM4hEMGs1ligshBOamPJGxKb05jtGlb2QVKgr24XD5CYOL4Z4D
         gspA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778151092; x=1778755892;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qnRfUwgP4GDJT73gEU34kWTDXjMinDYaY8kcXfNdp88=;
        b=AD/Hw81+yzt11J+/4D+3pZNgjLICATbTctV86rYv2msVvKfdWjHOhYSogTTZWcoqb9
         qCacS2PJUkgQD1VpsbC5MJhHig+8puoRVjMxbKMJepZXcOiA9t+MiPOtIW8narDSGVVD
         KafOFLpkjwdYwCBPZZropgXk7zUn2F+fNq0zZgfeoQ1tGC8tjTUpd9XUqU1oMCzrep8Q
         sO3i/EXRuVG1oKed1O5DBf6SF2xtjcSL6wSDZnP07q09/50C+HpfvdiB0krUR9Q+BYkE
         61rowaPSw/oAdYXHogMb1aNgeWQ/vYlhGW5vSCjDjrpxAdKTv9/PjGhdf3HfTRczqP+f
         HK0A==
X-Gm-Message-State: AOJu0YyfI9Y61+VK5doaKUxgki4Yg9v6kOXZjj4sSaiLs9MbRivLIt1W
	CG7pqa8K+rPZ8NvdyUpVZQAEtYBRi56tGtuBRn3qYILl9duGka67n6GYTBV3fAJh
X-Gm-Gg: AeBDievVhKa1bfsCTvnSmgBOKanqUveUi19kBmbQKj2wYMKZ3ev7JsCEQkUiLBZT7Sp
	5oaur1TmOiB0/FUCoCCvjTfFkDDi8PrzsOkoijZob8Viesw3CsFqlNmSYlMXWcN5YN6Fays+28d
	OwlHyBM+oxgwBiPUDh1ebS6FnpBcjgQn+r7w/po/aKQqie9jwu0G81DTzZtY582N9cjMwP1rIDh
	HSfIp4MPKMZ4y3/Pa9S4lmVF/nZIwDDX1YlLT+z2qGtPBMxXrLn4K3nWLGCXeromMSwmELShUw+
	eWqdzC7/LFP71ugPPZyGPh8uAGoIYilYQsgWcwHBbUCTy8/B5zRg3Y3QHskaq5RFI348J0n+Wip
	lW4lCIekJiML3p0ZKmgENknbqFq7ib/N9lxG4xyTm+UGgTfsEYBUf4hXnhCu9CM2Zr4dV53wVDd
	82T9vLMd8E3nOOjtC17V04hGcnM354SM951wqW1g6OOWiWLxh4e70xfl7Q3Vu644NaOqcwZw/4C
	5ivesoGtTbF3bF8BNTr+A9h
X-Received: by 2002:a05:6512:3404:b0:5a7:4ac2:70b4 with SMTP id 2adb3069b0e04-5a887cec860mr3152383e87.40.1778151091930;
        Thu, 07 May 2026 03:51:31 -0700 (PDT)
Received: from Shofiq (87-92-218-151.rev.dnainternet.fi. [87.92.218.151])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a85c341848sm5530224e87.65.2026.05.07.03.51.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 03:51:31 -0700 (PDT)
From: Md Shofiqul Islam <shofiqtest@gmail.com>
To: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Md Shofiqul Islam <shofiqtest@gmail.com>,
	jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	mike.looijmans@topic.nl
Subject: [PATCH v2 1/3] iio: adc: ti-ads1298: Add parentheses around macro parameter
Date: Thu,  7 May 2026 13:51:26 +0300
Message-ID: <20260507105129.25639-2-shofiqtest@gmail.com>
X-Mailer: git-send-email 2.54.0.windows.1
In-Reply-To: <20260507105129.25639-1-shofiqtest@gmail.com>
References: <20260507105129.25639-1-shofiqtest@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ADS1298_REG_CHnSET() is missing parentheses around the parameter 'n'.
Add them to follow kernel macro coding style and prevent potential
operator precedence issues if the argument is an expression.

Signed-off-by: Md Shofiqul Islam <shofiqtest@gmail.com>
---
 drivers/iio/adc/ti-ads1298.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ti-ads1298.c b/drivers/iio/adc/ti-ads1298.c
index ae30b47e45..cf5f954206 100644
--- a/drivers/iio/adc/ti-ads1298.c
+++ b/drivers/iio/adc/ti-ads1298.c
@@ -66,7 +66,7 @@
 #define ADS1298_MASK_CONFIG3_VREF_4V		BIT(5)
 
 #define ADS1298_REG_LOFF	0x04
-#define ADS1298_REG_CHnSET(n)	(0x05 + n)
+#define ADS1298_REG_CHnSET(n)	(0x05 + (n))
 #define ADS1298_MASK_CH_PD		BIT(7)
 #define ADS1298_MASK_CH_PGA		GENMASK(6, 4)
 #define ADS1298_MASK_CH_MUX		GENMASK(2, 0)
-- 
2.54.0.windows.1

