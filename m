Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F6C24E4A8
	for <linux-iio@vger.kernel.org>; Tue, 14 Apr 2026 17:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776186216; cv=none; b=CIyy+E2/iFGVecshxQ0Rx2PmIFWZV3hqtMSC7tis5t4G7x6FSohya2HjSx+4gFpaNYnJoHjrQhwOtXjqJj3oYeVw2sGjcgDECoKX9pp9TfTpoVHbj236As6XJPaQgAAARAnJJNBTwDizVNjKzPWyukAwBPz4AS14S/eTuRTO9XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776186216; c=relaxed/simple;
	bh=2EAhbEunbnWx1STmqHGbdEe3uOxnWZWtoXBQNQ+eexs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZuZroCkCg9dbDUWwbSxMK4PmfD4iiHXw4MknIdkCBHjuUUe0w8gMZjQgAiEFsl7eyq0lvlDuAZ3oiCDFTSnzcqyuQUMjGLTB7PU5a/xL2kJyRry9AeGm0GZcDQzeXRegKVnw6NBS7so5M7V2tji7S+Ew1Zy7NwfSXEQADhJ96Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WyW+BS0e; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WyW+BS0e"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-82418b0178cso2988169b3a.1
        for <linux-iio@vger.kernel.org>; Tue, 14 Apr 2026 10:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776186214; x=1776791014; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wbmBkzDiWaveSAX2sdx9ysFjfKAEklV0Y/mejTh5y64=;
        b=WyW+BS0e+uN/3vij9RkDnLb8EgGM2K492mq9rd9tGl/IPlaPcIaZ2xkvKdL/ie9iDQ
         xhsrLD2WxhpdHMrYLuMKRzUddgzG2irOcPPcU1gVFEFjKfZlfQJWT6uRinztBCi5nZKX
         IdtbFbcokIIPUD1zaMs35cAsCzXeS4u8zqyIAvIV+Red2CrRujQj/rPjfMnVqsJyrxF4
         LprDg1LJ1GJyoj58mhHZYRktHruSAFIwUJYhG3r2OJtzuuZfWXaMLzq3Hmbpv7CvCJ1m
         KJN0fbpv/OimuQSXjOkGI0G5hRVKn7KSAIGdQKJ3wgc5pjE9kg63QkkQgjcATyWJDOzR
         qIWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776186214; x=1776791014;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wbmBkzDiWaveSAX2sdx9ysFjfKAEklV0Y/mejTh5y64=;
        b=oruRRU6oxv1oMSnuwZkt4nhrzfIVNaz5/bPMU3qKc3MGmh2M16NALzmbeciDsPNovP
         3pxOHtfFFVBs5cM5qerLfohNUYwSjZ7vLNPC8dTSt6JnmpMMjHOynRZ1umvPhiqXVKa3
         6ER0KiTFvw/8ARv9mdK772gRMJtbxNafrTSd4AsZAQv7uqzz0nlXsYSFhQPhgS3zx5Fk
         zASP5cgdvttvt/HWCSxCPhaxgraod3JSBvRD8YcI+XO/hHTG2ddJvmRP/tPqi/afxu3Q
         pTuh3iXlk2nHQ28Shty+zFj50iEi4zHz1n2ybPs1F2YtrBkREFXAoXaP6OuZsdblbfYN
         oZug==
X-Gm-Message-State: AOJu0Yyv1B1adV6cZ5QS7coN+2xr9S/V4TkJEWiX6vORZEyHNK9Yv82a
	S86bWG5FZUaSDPgZ//PRfY7jKBLsl/OUsSWhi4Z2Oue3xl3wMmQ2dcU/QeYPzPxzS8cm
X-Gm-Gg: AeBDievXU2pnCqcHMJEiAcejfcmVjzgTt8hSDEfAgGpWTeCCPwYvQkKZNoJGRfSjad9
	ocd0CJfnNSM0duJ2nk2xavNz5t0A6WVOtC4/Ty5Yo2GvcY1HQiMyBEM28W10sa5kMsoVs420M8S
	eheNdgkrvIaP2OpbHh6SwZS+grat+zUPzT9WDrYIHwdtshaw0sM5SQGW6tvLGiIw+tAXAwUGuKv
	UkE7ikmtZkbYpm0124zgwtbkFbc9zBwoYPpAWdjcBU61uZuWr2LI/tCWE9+Tae2SooBWvVeCzDO
	ocv7kINuIU0qwcEzOCuSGAPuSEFx3jujuSNAnwXElcC5AoEIcNMXpHQRI9wSLqL6oyHNifgq1o6
	Oe3Pkonlm/a26eDtCzWKOQBd8rxIzCN51NMaRKU08z9R6pNOXh4zZoC/ks51y52UGwgFQNHqlUp
	cjJ9l2nDdGaHDe8p4l3nk/IxuaVXscQ1DG2BFqUXk/P60=
X-Received: by 2002:a05:6a00:2ea2:b0:82c:9f7e:518c with SMTP id d2e1a72fcca58-82f0c222098mr19318940b3a.25.1776186213956;
        Tue, 14 Apr 2026 10:03:33 -0700 (PDT)
Received: from nik.. ([101.0.62.236])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f0c4e3d41sm19077474b3a.48.2026.04.14.10.03.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 10:03:33 -0700 (PDT)
From: Nikhil Gautam <nikhilgtr@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	dlechner@baylibre.com,
	Nikhil Gautam <nikhilgtr@gmail.com>
Subject: [PATCH v6 1/3] iio: dac: mcp4821: fix spelling mistake in enum name
Date: Tue, 14 Apr 2026 22:33:06 +0530
Message-ID: <20260414170309.6151-2-nikhilgtr@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260414170309.6151-1-nikhilgtr@gmail.com>
References: <20260414170309.6151-1-nikhilgtr@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a typo in the enum name mcp4821_supported_drvice_ids
by renaming it to mcp4821_supported_device_ids.

This improves code readability and consistency.

Signed-off-by: Nikhil Gautam <nikhilgtr@gmail.com>
---
 drivers/iio/dac/mcp4821.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/dac/mcp4821.c b/drivers/iio/dac/mcp4821.c
index 748bdca9a964..29187f2a9d3c 100644
--- a/drivers/iio/dac/mcp4821.c
+++ b/drivers/iio/dac/mcp4821.c
@@ -31,7 +31,7 @@
 /* DAC uses an internal Voltage reference of 4.096V at a gain of 2x */
 #define MCP4821_2X_GAIN_VREF_MV 4096
 
-enum mcp4821_supported_drvice_ids {
+enum mcp4821_supported_device_ids {
 	ID_MCP4801,
 	ID_MCP4802,
 	ID_MCP4811,
-- 
2.43.0

