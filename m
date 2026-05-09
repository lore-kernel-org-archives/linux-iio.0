Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D802C236B
	for <linux-iio@vger.kernel.org>; Sat,  9 May 2026 15:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778340008; cv=none; b=J1x7FKxXKfe92gC6m71ridwCMp8vgFhRhgw0eJ9K++bu9HQ1qG8bxw/cbFGuOoCr8lfrRjrgdj58sfVgY7vFddV3wxnURqEvQ3YZBd5tbd3a9b+frAqWv9EbIHNl9WNKxGYIH9cb4nFL5OPmqe5RS+fxFCtJMlIeucigcMAnVYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778340008; c=relaxed/simple;
	bh=7wwEeddHxhCClQzgwuisu1/1yJfMaAt2aMlXmyRxTYM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e2eyDpz0sUzmZ1+9Pc+GU/54DG4k4nLMHhXqmjYzNPPnqsJpSE7AqvFmZ5IAJ+7jWtvDjN4dWvGiFUCMQmH9f7Zo4jsIvywFKBKkwEim6Fg4WSWUgYDrIRxIKgLlxQPQAMyz5E1pVc33GsecmKwzoKI86pqj8WTs04Opixj3+SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fyo/wmTs; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fyo/wmTs"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5a865004748so3957253e87.0
        for <linux-iio@vger.kernel.org>; Sat, 09 May 2026 08:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778340005; x=1778944805; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U4zF8aJYC8sIqGUROlbDSF6MUK4SPWjcto9OGe/HwWY=;
        b=Fyo/wmTslXXmIURYnN1/A8q7jgKHYLaukpB3ruT2nlnpH8XNyq3E6qTvrxs9ExecRa
         E56k6YJdU5WlsHaGrWzLms+cx/2j5O46HYBvXRnHR750Zjmo7PmbYVWykxdMANBVCVii
         /NN6BUVpjkzkYrZdLL/NokxV6I+IblwYr/UBahhmRo2ltb5NsVjhJlpD/eRdl8wAO0Pv
         LgoFjjLIN/ZKVtHtMziBJe+U8Ygi0Y7effNd09dW/WVzqcvGsjm+DhIBYgWgN7JXSrql
         /i1rGQGZjIjviXfOYfOWFBoKKceY1hw6hv/0H17Ktu8TZBcTFneIGDEahjtX5/MknuKE
         eFlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778340005; x=1778944805;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=U4zF8aJYC8sIqGUROlbDSF6MUK4SPWjcto9OGe/HwWY=;
        b=R/CRx51QqxWlESZp7DnfPbDLPPTNlqrPtMA3f/58K2xj54/U0xB2Im8rFioHrXwUvE
         0TRW5iJEET4U8AGyohlzVWvgHjdAx7VaSYQMEVU2CRP5o1jxsmaRr4TyLFHwC9eya9ZJ
         RdAZvlhAd8CVwp4AGVhKIgrsjOKdoj0zjfCerkIZmYrMiZotOhDxUhNjvB95Pg4Ke/PK
         ZAWSIlK+f+V7Y1LiPfGjLfa0q8MWousP59Xh1HBMJnAVgejDqdq3js4yhXrV8yAPxctu
         JNtKNlm4qTdDu6AhtgdIwWlbwO9aGmTEEuWO6wJBA2w8FZ2P5nqbVQJJXCSPdMilSEh2
         glFQ==
X-Gm-Message-State: AOJu0Yw/yTWkKVmaKp0+etgTSk7xHXO9v4SqbSb7p6n/EISPPz0D3bpN
	EIG+PMC7tZjIyqm5esW8Z2O5dhOHfslUXFmecHCqwkZjbmy4xcxIPo1vPkXs0/VI
X-Gm-Gg: Acq92OEzFbC5LuyFJ9dHQyWbBqTXnQI5rIW936CSR0MNgmUqmwoFMVm3gNKNOTjzJzn
	1UoanlSFRwY2xLimiYV1KbqLjbklFzX1d9ZvOL9aiXV9YrBFUzmO+N2jrfSPHesL418cUL5K1X4
	xl9gm3F68HuWGtyMvmPut3dQJDat8XVY1S3npkNgt3TkmK2fX/V6yXdBMn2u8kTnS2nZdQ73sQa
	W1plTzUcQrXvguqVb9dyM6lpMk+MqK2r9M2GWMjMEj+WLTypbCXSllaxf1hCGRhgj/hNHzNZ6ee
	7mPzkSDY5waulrhTEyylak8NxfoyMC+zl4Dcv96cUWE6CJhNOmU5wob7D2m/Gu8+zWPYt+PuY8o
	LpSBrnUH42lWPDKOO0TLWJROzTnuzzXNcGYnbZY4lx2uE5Z13ZK5cf3Tp/YOhmSfX0b/PcI3ZM9
	prxvtzMEPaP6csE25/anap2Dp4CUVSnsyvLkUUNFz0GhzxYaiYGlYGm0ia+Ov2THNmEhD+Br7Ou
	ds=
X-Received: by 2002:a05:6512:33c5:b0:5a8:9157:ad3b with SMTP id 2adb3069b0e04-5a899b90653mr3650746e87.5.1778340005091;
        Sat, 09 May 2026 08:20:05 -0700 (PDT)
Received: from Shofiq (87-92-218-151.rev.dnainternet.fi. [87.92.218.151])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a8a95664easm1301975e87.70.2026.05.09.08.20.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 08:20:04 -0700 (PDT)
From: Md Shofiqul Islam <shofiqtest@gmail.com>
To: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: jic23@kernel.org,
	mike.looijmans@topic.nl,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	andriy.shevchenko@intel.com,
	Md Shofiqul Islam <shofiqtest@gmail.com>
Subject: [PATCH v4 2/3] iio: adc: ti-ads1298: Fix incorrect timeout comment
Date: Sat,  9 May 2026 18:19:58 +0300
Message-ID: <20260509151959.3475-3-shofiqtest@gmail.com>
X-Mailer: git-send-email 2.54.0.windows.1
In-Reply-To: <20260509151959.3475-1-shofiqtest@gmail.com>
References: <20260509151959.3475-1-shofiqtest@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

At the lowest supported data rate of 250Hz, one conversion period is
4ms, not 40ms. Fix the comment to correctly reflect the timing.
The 50ms timeout value itself is correct as a conservative margin.

Signed-off-by: Md Shofiqul Islam <shofiqtest@gmail.com>
---
 drivers/iio/adc/ti-ads1298.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ti-ads1298.c b/drivers/iio/adc/ti-ads1298.c
index cf5f954206..186bda3087 100644
--- a/drivers/iio/adc/ti-ads1298.c
+++ b/drivers/iio/adc/ti-ads1298.c
@@ -210,7 +210,7 @@ static int ads1298_read_one(struct ads1298_private *priv, int chan_index)
 		return ret;
 	}
 
-	/* Cannot take longer than 40ms (250Hz) */
+	/* Cannot take longer than 4ms at the lowest rate (250Hz) */
 	ret = wait_for_completion_timeout(&priv->completion, msecs_to_jiffies(50));
 	if (!ret)
 		return -ETIMEDOUT;
-- 
2.54.0.windows.1

