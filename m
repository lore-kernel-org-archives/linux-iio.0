Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DFF74C0439
	for <linux-iio@vger.kernel.org>; Wed,  6 May 2026 18:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778091321; cv=none; b=iTZ6pGTYP6rEEYcjfRLVNKgXAwfgL78ggdtLQlMlVT2B1P1zsnW29C+2TA7sY22fXjTgrHnFjOWs1I5tkNZlywShKr8DQeJPQim2DgQDoOIgo48l2g4jNjpodOE2K7EHtgJdGNy16FamzkqJ/Z9Sh/FW2l0H6NctPzUQyXeJJKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778091321; c=relaxed/simple;
	bh=7wwEeddHxhCClQzgwuisu1/1yJfMaAt2aMlXmyRxTYM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JAhjYecRs/T5SLwuimOrCdT+xJUdyN1gxDxCo4VA5XRsaxhJom9lyj40XfU/yaax+ZaeBuUcz2Oz/2C6V9bO8judk4LjJyrwKEKlTBtWnkF3d/V5FBF1C5/xmb9uCPCmV9kC6BgoiQ/bvrnFVxSgKHkDdznOTUnWCOCz/Y/wem0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TAhUO2hv; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TAhUO2hv"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5a86bfa2a4eso6145869e87.1
        for <linux-iio@vger.kernel.org>; Wed, 06 May 2026 11:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778091318; x=1778696118; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U4zF8aJYC8sIqGUROlbDSF6MUK4SPWjcto9OGe/HwWY=;
        b=TAhUO2hvjU0iduy9AcZn85vixcylmjyBWcii9CAZtKzowYx3AChNxv1Xd6vlkAvzbK
         K4ND1agqXZuXY5EEkz0PxYWq1wIDzCcZ/d9dBjyHoN1tUU+t14fdITuOn4g3CdcvCGDE
         KS/kmEQImDVV0u5DZEe4iYjPuejjlKFjJvGV7TPJv1XWSmjvJ4WLVDN5iaVrap018BMz
         ddOzggy/Q22Vliwief4wdQmj3GpHeCGds6WZGVK6fZNTGje1ylnYXMg7BzWUSsEzcHfw
         YUJDi95dUm1F9f3vKAv3YxsFYjCRN6I4Z6KCv5Ccv2lkJwV6cQW4shYh9I5AIBu6z11F
         sr5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778091318; x=1778696118;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=U4zF8aJYC8sIqGUROlbDSF6MUK4SPWjcto9OGe/HwWY=;
        b=kAUMnj+l9rjKYvr1kGj41IRAUDDmGIlBab7Doaio0u40iwkf33jxMl/uT6Y53XdjRz
         Q8cdGO6tDugWF1fRQn+65U6d8I+rxSsi0TVbByVi53q80Dn+8wF+n3FkSAAOYm6Lh17Y
         kmK9yOuRiEcRmtLVBkt5WvzyWruQC7T60/F8+iI246W/clKJMIKVeB4AlL/p3Z1b86pz
         MKvRljzd6o3BCtJCjJ1TVk4lT85VcG+eCT2zoKkOZIVtPOCX2ckQBG1Qeu8b+jIx1t+q
         aKeOZyjqzBOE8hFZRTJ6RbLmLbfNOp5MQTk1YE+EYdKulcVAiVFE0uGOOxsplLhFecUR
         E2lw==
X-Gm-Message-State: AOJu0Yx68e8Wkab9K/B1rOniPyTXZgfmwmir6IkiwbsY6aacalqcblNy
	U0LBvR7y8O+0pyjVZXaL8fhxg0PgPPPPCHGxdvjysu1PlrmfRU5AkJX5XXgyxz2L
X-Gm-Gg: AeBDiet+8ShhtkgrUUsn0SIK03wbRvXs3Te1ZR4D8HL5p0+p4P/s+3qW/6rX2kumhWh
	FgXByOXwZej+toIaI78ENLlNt3OnHuuhsgYkEA0IqMM11nhMAyNNReKsCpcsUnWJNeAMKwszFfa
	iQ2ssjLxtMWNEaVvhOF3HXjSQhn/Mk/M+Xlu9lNVUbAa6Z0ioziOR72fHX7y8gIFw43m6pEVl8a
	IznWu/op3sc4ho8wmo7BJkXO6o3oCIZyp69uvgxQ7mu7J7JdMDP3F8Bntd8Kj8gZWduC56f9F/7
	Am5os0fPL9mp25SAH3LU2sVrOuAv1V/gci9pO8BmM1mOel3Bn39MbWIlDXRWXUAwbwhA5/2tkjw
	diKgK4MLhbZEuDp9B/UyqHaXcECYfFeGNuyQ82qkx3K4kb9PPA7iFDp1oNCHhVq6ICgo5y7fFDH
	ZizuejnEfONz0Ssu7i6Qt0nL+B0/IhxF8BiWXEIxTsiZT+mOK412POZxcCiyc3t3VoqtqlIsPJJ
	K/C36qFb+klPw==
X-Received: by 2002:a05:6512:3f1e:b0:5a8:7f58:5fba with SMTP id 2adb3069b0e04-5a887adfd8emr1872899e87.9.1778091317901;
        Wed, 06 May 2026 11:15:17 -0700 (PDT)
Received: from Shofiq (87-92-218-151.rev.dnainternet.fi. [87.92.218.151])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a85c341848sm5037123e87.65.2026.05.06.11.15.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 11:15:17 -0700 (PDT)
From: Md Shofiqul Islam <shofiqtest@gmail.com>
To: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Md Shofiqul Islam <shofiqtest@gmail.com>,
	jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	mike.looijmans@topic.nl
Subject: [PATCH 2/3] iio: adc: ti-ads1298: Fix incorrect timeout comment
Date: Wed,  6 May 2026 21:15:05 +0300
Message-ID: <20260506181508.6813-3-shofiqtest@gmail.com>
X-Mailer: git-send-email 2.54.0.windows.1
In-Reply-To: <20260506181508.6813-1-shofiqtest@gmail.com>
References: <20260506181508.6813-1-shofiqtest@gmail.com>
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

