Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A15D3939DE
	for <linux-iio@vger.kernel.org>; Mon,  9 Mar 2026 10:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773053177; cv=none; b=Qf+R8nkEP2ODrfftcpqrL6rKpoMbKFoXW5FaOqqwe/rG736BooWnttYnjevQ8FSKnmuIXY1ebQEOghNwSDiM24X06QaQDSkFWDMiWioNC+kxmNgEpd/BB7QPUgPu3gC8o4PL0CB6e9tXxAMjXm1LSEbG4UXqhaiInvsL6yJ6o0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773053177; c=relaxed/simple;
	bh=GEKF4DSIPqf8iTNvzGmcZ8ACdxqenBxpGn1KwgO6weg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cnNqtoMF1TGrKL+HP41HROfF4ZjqGHHnM4u+l+xgXWnxKLzM85MmWwHMXRXhmvHpTVfrivm5xleMkQoELgtx19MpJ46iePD3UljU2OVJuISOBraESPbVfSkN0rH4T6zBN8xeXIwRHBEU9PTcFidyofkFiklrJO0NU5zaYnvuOZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MTohfGfp; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MTohfGfp"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-82987437624so2012373b3a.1
        for <linux-iio@vger.kernel.org>; Mon, 09 Mar 2026 03:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773053176; x=1773657976; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HNpYRSGd+j/T6pgpjNPyqo3Qzs4qm+K9ub7Shj6jVf0=;
        b=MTohfGfp82ezo6pZHyzDeBm53xne/hGzTHPqaI1pcU4mW9I6MjOjxo6B7z4da7i+zV
         IUVcLuDkRG0rEbytEHTCwwOysNNMPOzDMn+FhEgWoetIVxeiWWoKQkpoNh1W7FspfywN
         l7UZEWZPLmSa56+TziHuOs3k3K3DxuXDbePq0stmNZ4qpjC4fX9rpRcOtonUIfF1ZeJB
         Zcr3dC0whwcpH7bhSRr5g+dnelAc1s+8vcxp6Ewx8YAsF9stNo4NQ4b6y/xwaQgEipyo
         ImcpbO3jk1CHZ3T1Fm7ORQwH2ucrWHxzo1g0vhJM4itAW/1A1ZXGEbYbwA8HgXQdWOjZ
         DQtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773053176; x=1773657976;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HNpYRSGd+j/T6pgpjNPyqo3Qzs4qm+K9ub7Shj6jVf0=;
        b=NzdI3vMe40mrak2M5lYLp6/D7BvTF5h8+ea9x5UlT8JfvdsPQ0sHavdUkRpXPo1Jmr
         Vdx2bxwrnDEin5J8foIu7GZIvW1FmjRJ4V7P3mk1IZDtNkLPUsnK73KeFxZ8yDg0+wq+
         phf7aTGUL020vKjvgGiL3n2rWyF5cpVhY4V/4XJwfwP7dSlu5vXkQhusFgPC2j6XqyuY
         w6uGR/QcIAA+1NB/CjBKKH4ochF8gPsfgqHJjUswT7Xa2jL//QqJmQ3y5evpK5E49IkV
         2YRzPmFQh+dSBACfTO2Hxjejpu+GAPb3l6hZE7cO6TIm69ndDuQXavS+WRb0aUqPenPg
         zXlA==
X-Forwarded-Encrypted: i=1; AJvYcCWFLW+SB9VvefuuDGRFRRE5Fqd8IkZCrM6nIfF8hNGlmoxpGtv/Zv2to7+txtw0KLJXjMgO9BLB8ro=@vger.kernel.org
X-Gm-Message-State: AOJu0YxD/4eO8mHoVztq4COVb937sW6Obj+Na2H43XhIfE6JT/SiXTre
	Nfoh7I3nnnvz2TWrmkkSloQ8PMrO3iJME1QjcWgOtP3G1rYXMbCL+0Tv
X-Gm-Gg: ATEYQzyhaKHeI/HrThUM8iFrwamSj8c6yqbfosZrLBUT3OKZxlddsBwscn+ciSkEXU+
	nHUIlv1hcJae79tECAn6z1RhheIVPg9js+f1CqhfgsegBqTNMltxchp7qH5dUfb7djcc1FfS35Z
	USO5NMXoT4PVhVwd/FkOl+R5QZcvzHIRL1nGIgPvQvCTSYNtVLUNqCvVvJx7Swtdf50q69UGQQT
	K8RvhwUODjU9dJEVv6LtUKfUuQtvA8nR3GFM9VOEncSYrnxQbd+3OCPiWpeapJPiw2F4qjPRHG7
	g1WheCPQ6NJZE0r2/NoIPsampmqz42JWhx4POeggF5Jf27CwLjm9JDit7Jr/Bna/Id9MQ29aCvV
	rAFTjHMzzVqPh5cqGs9EIRbDOMThYlnTiF4lqTMybU9yGbzK5r0aF2Vmxk28sTvCVPFid339ZlZ
	d3kTdnJbcFNRGEzo8rz97FCraHm8UlBWTRmZU=
X-Received: by 2002:a05:6a00:37c5:b0:827:2b3f:f9b4 with SMTP id d2e1a72fcca58-829a29d2a47mr7842876b3a.5.1773053175694;
        Mon, 09 Mar 2026 03:46:15 -0700 (PDT)
Received: from fedora ([2401:4900:1f32:2ea1:a1a7:f2aa:545b:3c1e])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829a4657445sm10276143b3a.17.2026.03.09.03.46.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 03:46:15 -0700 (PDT)
From: Shi Hao <i.shihao.999@gmail.com>
To: jic23@kernel.org
Cc: andriy.shevchenko@intel.com,
	andy@kernel.org,
	dlechner@baylibre.com,
	i.shihao.999@gmail.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	marcelo.schmitt@analog.com,
	mazziesaccount@gmail.com,
	nuno.sa@analog.com
Subject: [PATCH v3 5/6] iio: chemical: fix typo insuffient to insufficient
Date: Mon,  9 Mar 2026 16:15:12 +0530
Message-ID: <20260309104513.40359-6-i.shihao.999@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309104513.40359-1-i.shihao.999@gmail.com>
References: <20260309104513.40359-1-i.shihao.999@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fix incorrect spelling in comment

- insuffient -> insufficient

Signed-off-by: Shi Hao <i.shihao.999@gmail.com>
---
 drivers/iio/chemical/bme680_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/chemical/bme680_core.c b/drivers/iio/chemical/bme680_core.c
index 70f81c4a96ba..204663330bb3 100644
--- a/drivers/iio/chemical/bme680_core.c
+++ b/drivers/iio/chemical/bme680_core.c
@@ -807,7 +807,7 @@ static int bme680_read_gas(struct bme680_data *data, int *comp_gas_res)
	adc_gas_res = FIELD_GET(BME680_ADC_GAS_RES, gas_regs_val);

	/*
-	 * occurs if either the gas heating duration was insuffient
+	 * occurs if either the gas heating duration was insufficient
	 * to reach the target heater temperature or the target
	 * heater temperature was too high for the heater sink to
	 * reach.
--
2.53.0
