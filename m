Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF9D37E304
	for <linux-iio@vger.kernel.org>; Fri, 26 Jun 2026 11:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782471871; cv=none; b=kHV1gi/T4pI9rBeti/eRjUTQ8ssPrCC0kkfLNwVgE9xfNIewoifW+gu9MMrFY3mhcWfNcH/Gg0mHLCeRuW0+GWj+I+ru7TC1pRxTbQKEPHywSgWffmpHIobHU1Zly0GkBPWYhkv4KNCZw6QczFP7fEBHLDywLSEf79iRT2ohTfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782471871; c=relaxed/simple;
	bh=IFfo2PqVhs4LB9en5ZOxT2gnMExm7F4Cs1+p9+ZsBqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PgX5JDpSwfGMqSQmQO9vCXeAOgkFkMj1kLeq21rEcVFU7XI5VXeT5CYye7ewcedwY/5DniJOuip15ky5G/adZaZlB+cJ4cDrrwyxcYI1aV5Mf220Buku3sN6EV40P4pKjXN78hJds8GJFnB25UwUJdeHZJNyaNKwXr9aqpURgfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kH8OzdwV; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kH8OzdwV"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-30c591fb1cbso1271258eec.1
        for <linux-iio@vger.kernel.org>; Fri, 26 Jun 2026 04:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782471868; x=1783076668; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Omn/hVFEp8NRB7W9LBODAywOnRWJWEvbpZswLa0+Wpg=;
        b=kH8OzdwVR+0+XS3MXnd5m66S75FxbYByxOLuaKzpGRFQjkzlrpKCJK9OIasWGqI1GL
         eImqUJmq/pcBIDv9JXCnVxfdrYBv9DrYnN/2GmIWmCT2gJSAs3fVcqdVvmnVwjqLhplE
         +VMArd99Oko/hC+ciQe9GF+ns8yE14NxgHbicD1Ye/Alj7o7u/vGZ1Tr24l3+aVM6MdP
         1jSgYfZ93uoWYrvmyAFjfUFxPoIBKDH44q09bsi0PMEGctej4iz+J84G5DOqRW7vzA3c
         SF56KVYB08Iu6ZJt2msal5x9U8LeXywyP/aIUWZqixghEe8NEzcyur9EyzHKTocbKLvS
         tKQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782471868; x=1783076668;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Omn/hVFEp8NRB7W9LBODAywOnRWJWEvbpZswLa0+Wpg=;
        b=VRRnhlkQbVp+qMW1LlSI9ISH7KZvMXqXrLAaqWaPKmbIUYpx8OaUBpEd8dNLcekE4B
         Alip52GCSFtpTBnP3pJYx+D4lNCLJYQxA4yre0r4gZ3qOdJd/JwL2SLmhP4y1N93sec9
         lFGZiP3nVZT8deW3vAKb4NZo5c4u26GDaTFM0vMOQJw7bO4cRMCuBOqBeo0Hu2LTBcA7
         L8pAiBB3+zbk0krPiHqc6Ek7gkqKM0L8o8AIxqERkI2o7sR3Enmsm8f1ItioxnxseS7b
         Pi93Qjc0pYUuZrWDzCFLAVk+q2dTxefpHyH/ouG9Ff+6cy+nTIJwYylBu4+tSYmtXIvC
         Rgzw==
X-Forwarded-Encrypted: i=1; AFNElJ91a+AgjopaWykfyAeFYHMSARVk6pxrZI9eJujtxJ+AK/Lz8iwsnO7aCVO/yUlLnqrz3Xt92PjG8b4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzk9UXDLt+Ow1CTUhpxFrl/SzEVjIGU35wcz9+RKzO376RBPH7/
	vFAZGxkjdbI4GmX3/rc7BIsdTbla3qHBgK28KiNj+sZDb8IwvpWA6/LJ/fnrIyLd
X-Gm-Gg: AfdE7cneGVCBLdC4oS5MmdIUzGh1kaLYSir6m46x1wzsS4zEJpTHBQP47y8ssaJeB0g
	uRUH9lZ0pwVYC1Yr+AGdy6oo+nvCDbzQR/sOhKMnvTzj26t76HQSt5VHq9ZAabnq1cziqILiWOb
	+QpYKci3/uc8tmpiXIfQ764peNMSJxyRBuczOw3m5kxXhRm53m279/zPH1Y2TaxzwD6Bw2Cl531
	AtqNloEAe3182yNu7Z0tj4XpE6Oe8OJLUn5Ux1nUU0064Z7wibCZruD0puQ/wzF8q1MaQkipPRS
	4bmspilWqIY2P2buQBMtCb4Vk46MmrgWlFEmeGW5GGNyb4K7pbpcHhZnw67xYal1WmH0X3/Qsri
	/TbI7VUTUQkxNgzdlVhYtCZFrZ8tV26GkabBa4BZe54aJSFYYzPgUzfjDEv4ftsEzhcqW31Qyhn
	pn+dUn/+Lc9eqL+lgNh+DwtOED/hFN+ehFBXQuAFyEZU9ELIUH2hgSQB6cUCpl5JeqtjP4dwUP+
	wqnv/X8Y7xjl7FiKL0Li1U=
X-Received: by 2002:a05:7022:110:b0:138:407c:1d1a with SMTP id a92af1059eb24-139dbbd5ad3mr5578817c88.38.1782471867586;
        Fri, 26 Jun 2026 04:04:27 -0700 (PDT)
Received: from MacBookPro.tail792e28.ts.net ([2401:4900:1c17:d4b4:14f2:a68e:e644:dca4])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-139d8f6d2e4sm17171357c88.7.2026.06.26.04.04.24
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 26 Jun 2026 04:04:27 -0700 (PDT)
From: Shardul Deshpande <iamsharduld@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shardul Deshpande <iamsharduld@gmail.com>
Subject: [PATCH] iio: light: veml6075: fix UV index reported at half value
Date: Fri, 26 Jun 2026 16:34:00 +0530
Message-ID: <20260626110400.68885-1-iamsharduld@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

veml6075_get_uvi_micro() normalises the UV index for the configured
integration time by dividing the summed, responsivity-weighted UVA/UVB
components by the integration-time scale factor relative to the 50 ms
base case (which is returned undivided).

The supported integration times are 50, 100, 200, 400 and 800 ms, i.e.
the register field index int_index in 0..4 selects (50 << int_index) ms,
so the correct scale factor is 2^int_index == (1 << int_index).

The code instead divides by (2 << int_index) == 2^(int_index + 1), which
is twice the correct value. The reported UV index is therefore half of
the true value for every integration time except 50 ms (handled as a
separate case). As the driver powers up with VEML6075_IT_100_MS, the UV
index is reported at half value out of the box.

Divide by (1 << int_index) instead; this also matches the undivided
50 ms case (1 << 0 == 1).

Fixes: 3b82f43238ae ("iio: light: add VEML6075 UVA and UVB light sensor driver")
Cc: stable@vger.kernel.org
Signed-off-by: Shardul Deshpande <iamsharduld@gmail.com>
---
 drivers/iio/light/veml6075.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/light/veml6075.c b/drivers/iio/light/veml6075.c
index 59187244a..af71df69f 100644
--- a/drivers/iio/light/veml6075.c
+++ b/drivers/iio/light/veml6075.c
@@ -244,7 +244,7 @@ static int veml6075_get_uvi_micro(struct veml6075_data *data, int uva_comp,
 	case VEML6075_IT_200_MS:
 	case VEML6075_IT_400_MS:
 	case VEML6075_IT_800_MS:
-		return (uvia_micro + uvib_micro) / (2 << int_index);
+		return (uvia_micro + uvib_micro) / (1 << int_index);
 	default:
 		return -EINVAL;
 	}
-- 
2.50.1 (Apple Git-155)

