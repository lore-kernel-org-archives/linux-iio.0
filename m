Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C548D388390
	for <linux-iio@vger.kernel.org>; Mon, 20 Apr 2026 08:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776673489; cv=none; b=mrvMXswOcOlqHAGeKyiISnoW/zJ6t1RM6xlE09u/uLvbeJQ5y7jSbgNwAnKzlwfwWBE1m2jhs1bgzIdE4Z44FPTq4D8P+uTS3cEMlWzNFj1tcqlFTCYwnSl/3ro+ga5MGug5KF0G+m2Jg/hAxmYB3bgbdVgmJpmNbV+7hWJXlOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776673489; c=relaxed/simple;
	bh=bD2e+VD3h98TxzA6gIz3MyfuSMksooLImtDVCo4foJI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bYLZgUy9v+XjYkg6UwNMFuEuMiTEgzdMg6tFTFMXiQbhpk3jdypSsPyc9zPo9tDzQiN7+O6f4WA8W+Qi6u+Y6phCgkW24/DcernyIfGx/YEGAGSGr+tecd41CzpuDoH1OjDZ2r2+pC2IANVTyhfipBucHEFK9pGKIThJ1uKex1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S0pjCwY4; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S0pjCwY4"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2b4650d5f5cso9436735ad.0
        for <linux-iio@vger.kernel.org>; Mon, 20 Apr 2026 01:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776673487; x=1777278287; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uSDRikDDBRUTiYv01PTEEVHLcwBVfJAbVJm3JV50ecM=;
        b=S0pjCwY4CfU636IMMRdgdYXCZuqs8uWSi4nz79iqmnWE+lE8FT6uGpfduQ+Rl9gZ7o
         iZCZ4/2AwUwJ18musMNmxoJlBpw7ajYWWH3BV5j9wg2teHCv0CnthFJbuaErvEuiVuaP
         NAxCHJOnFIkWFpsV/jW99NY84oxSjpfIglC0rWZjgSrwwTNGZS3cNM+0JQGFftG15/5s
         A0SbVj5/pzbY9qR0/NA++HE5gevN+F4OXgq4qXuQ6a/t+Y3V/fpLxqRiUiGgfh2uX+T8
         6PNbSQujwgtdKdxc6gYpOqhljUIhfjy09F/f6rLI1ThGe4KCzv9Q/sQLXk3d/3h3dcPH
         aDzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776673487; x=1777278287;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uSDRikDDBRUTiYv01PTEEVHLcwBVfJAbVJm3JV50ecM=;
        b=pK/11lmRXaMEZOOHaVcyO8RA4TNYcSjPbSJwXDYlyXrPucLjThDFPTAIYC8CYbuKGJ
         EDz/KHuND6w7h6Yt3yu1v8Lu+1cwhkyk24a7F5wVqW2S+zZCOoBVXT0Mfe6cRyxITcIS
         E+2e2mOilanZmFZzEfXI8NUVcfbCffd+rcVleZAY0byrF/dGxuOoeWu+dKnForrTtQUJ
         qJuedpZ1C+ldah5NNrpn2ldDADptgqhdQ3vf3+/uS4JMl6NRpwfPY5yCzpv/JkLCMCUn
         aClgffzx1h9Z64BmzyxJrh6MXBhhmtejCOolxTSGTpUemZ2BbzG18dbcnvCORYNfcC12
         xjnQ==
X-Gm-Message-State: AOJu0YzGgim5CbMbrIsXbkZ7l+QZQ/L5jK5v6xic8CLRtdJtVXUFQ3nd
	91K4iLLWqNlkT15ddSWBp9LRmN3B0RAnASO+F9JTPinsMZ2mIW9KNU2VrJqYtm5Zrw==
X-Gm-Gg: AeBDiet6CQykr+1Ix3dZnlbgY4KSy9xtlPmuLp0rvELaaZSybEzipi5Mr+VxU0m6XWT
	kzlYsMMhmLARNqqrr1GAa9EW87C1f0dF9C2xHLcRbC+1yAJcusDW1D69jlgs3ogTPmQbZ0xQlfe
	9XrSeclIpHH8Yhs57XIH1YBk6ZT1sH0UwRsi3O6eV7Sbz/It4adW5lItzsYVQhIVdUYLxlCoLFu
	ZWMozeDcMeJ252NJiovpgbzzHIuaLxDSFWlfShkE+t3mnQ/zHVl4FrYHjC1Ppvl4Y3dBFQQFjRI
	GS6WQh/fWdavtFl+twz5gYaZNSFD4DGsuo5gQ8uvSyT+EdhLoWQWWkvAm874tYhcFfM3NmESSdR
	gk9MMyymibZMsc8R62pes8fwwzufB2OOOR1CqsAfow5xS3+IetohP6LwHsAafxZEAuHlf6jEfTJ
	MifxoVmKLfNuS908q8XcVEhwRlB9eJNWTw73b/hyKJ9gr2+I7y4x5q
X-Received: by 2002:a17:903:1103:b0:2b0:6b98:59ec with SMTP id d9443c01a7336-2b5f9f7abacmr129684655ad.34.1776673487240;
        Mon, 20 Apr 2026 01:24:47 -0700 (PDT)
Received: from nik.. ([101.0.62.224])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fab20e80sm99464395ad.57.2026.04.20.01.24.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 01:24:46 -0700 (PDT)
From: Nikhil Gautam <nikhilgtr@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	dlechner@baylibre.com,
	Nikhil Gautam <nikhilgtr@gmail.com>
Subject: [PATCH v2 1/1] iio: chemical: bme680: use BME680_NUM_CHANNELS for scan buffer
Date: Mon, 20 Apr 2026 13:54:36 +0530
Message-Id: <20260420082436.7223-2-nikhilgtr@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260420082436.7223-1-nikhilgtr@gmail.com>
References: <20260420082436.7223-1-nikhilgtr@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use BME680_NUM_CHANNELS instead of the hardcoded channel count
in the scan buffer.

This avoids use of a magic number and improves code readability
and maintainability.

Suggested-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Nikhil Gautam <nikhilgtr@gmail.com>
---
 drivers/iio/chemical/bme680_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/chemical/bme680_core.c b/drivers/iio/chemical/bme680_core.c
index 3e850562ab00..42c1a9de175a 100644
--- a/drivers/iio/chemical/bme680_core.c
+++ b/drivers/iio/chemical/bme680_core.c
@@ -128,7 +128,7 @@ struct bme680_data {
 	u16 heater_temp;
 
 	struct {
-		s32 chan[4];
+		s32 chan[BME680_NUM_CHANNELS];
 		aligned_s64 ts;
 	} scan;
 
-- 
2.34.1

