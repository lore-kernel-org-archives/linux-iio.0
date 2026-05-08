Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850883537F7
	for <linux-iio@vger.kernel.org>; Fri,  8 May 2026 13:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778247946; cv=none; b=ZZDEgSTVCsjURuT9+3r+h5LLGL6slzYD5DBLQI3vy1P0YM1kV08F/fzjKw+qbIka0zp1w4lIB6iVJp+8HSXO8mWvWKwuh7Gw9MZR6ZBNdDjSFWfh/TWpFkZb/UqWYX9WVt+sY0bIJTglPIBNkPzDwe2J7k4GEDSqe++W242qHS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778247946; c=relaxed/simple;
	bh=swKNYtdLKr3OhrimkgzuGhyW4+eoy5xIjmC+acX8vcQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=idPTYx4ojp/XJC3sEZRWOGinbfQzCW303ElFXZyaCbSHpTn4zrG06jRNtBVUmWBizvRe6vbXKxZkeLWbh96CCjZH1fG45oHx+7f8sspsv+27Izs2IQBBrBS1DgXGr+zL2hE1y/drwVlm7ym5ILYvlTGF2ryKI4+q7af8GStU+ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kwarBpE+; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kwarBpE+"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-488ac04e13dso1839365e9.1
        for <linux-iio@vger.kernel.org>; Fri, 08 May 2026 06:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778247943; x=1778852743; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kr0cUuzDRGZr6LrYbByoSCOtYdNcTKwBMZ0ewR7sxFo=;
        b=kwarBpE+9YcCUCY1jGFEmz2DaOWvUTanBNHv8FkPrTWXb3Ka0gWy7LIIvcGCTByNyy
         FflrRzXsKLIAjdynvfZkGOYKbevuNZZTnWMMPYwTX2RX0HC6TI+5YPtZiOmgcBuT1Rnr
         UhIDpggwfvwV8I3SRpsviakF/z17zuVR/LysRrpuV0FH88X6n+bJQysADfAUgGNtu7YY
         L38SaGJ/OX5qeXxMHNAUS/UygVg9nKzRiWWehsyiUHIcmCsulJ8c3VM9IR18xI/cwbJ2
         vo2/7foemWD4nusr3xH3bBgBR0rY8F/Wtpa8qJ/kMuYlTCyvyyxtZx/rAP+awnDKeFpr
         msSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778247943; x=1778852743;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kr0cUuzDRGZr6LrYbByoSCOtYdNcTKwBMZ0ewR7sxFo=;
        b=RkqiC54ZKPYwxhbGOC3I1HEaVWg5NKt4lZGT2km0jl3UzKGbNuOUwdImRyXp+IUjqi
         Sc/LfRRmmO+8zcyzYzeb/rw7azURbuylTc6BRsg6yAHYjhygdZRQBSGbVLiSA9I+aeS3
         lH89jUXJ/oGQybA/BdZgDW4vjNXZcjqd3v4VFL8DGLrwO2J1P8esDROxHkP9UL3aqNwB
         4gVtpYyZFCFMDTYNbBdB3v1LVzC78QNSsdkB9BOBjB5H99jPbD55qiApwkinKmSr8OIe
         53qku9lqAyE1DLuEVFyN3ujPn7Qq3zk9gSaLM6I4boPSoJDRLBirDGk486Rpfoxy+wnx
         Mpdg==
X-Forwarded-Encrypted: i=1; AFNElJ85qKYZIO1w66wfQaDLwg/NoJdvV5nQkPH9zC9AlZsa0xsIdg06BSBpqqJxhTSNhFj0rHSDFXQiAYA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxF512BwhrJtbzhJYpktleoaKq9iEELPrcJjEGfhxpgyGMdhxIJ
	nItCoH8Jpig/csp8qpW9GPnUuEbN+olwKLIXfvUXn6tjoZvJ1gOewLu4
X-Gm-Gg: AeBDieuwB3kXZkYtrtO1obsu/QhTQnyhedHuycm5gZD8KcbcwaYtnXiCGqwFQBt5Mt1
	yJtHe3n/ubPVaeCu7PhpgFZUElisOnxeziHr9vdF398xXYRorv/DQmGFrzQuy9y0Wxfi6kLpbHx
	aY4T9oByOzrctp8JKjGHs7PhUcnNmI12WETdZ9nVicnfDSgz76sAVr8qOwNyBtNT4Blvs18wvK/
	15CfZxddNGwtuZWiFbThxFrGfQyO7PSnB2rW31+24MQUDgCzFS0mBc2RSm/rG7D3G9PWd0FQ21T
	pNyHApX486Nbxsx7FnxRuazVyX2slM5Y93qC8ONNjmde5nmEQMNuuDfKAoYoNZVL7Jvfo5fC62a
	Cxss2vn6Wek9nuawTDJelJ/RRHEH/qDUXmIgWyD53Ty+i2+E1861ANe3L3I6IN3at37VK7BCy2q
	2MdI2nERm2uaCm3/jjpnMbYPfAwZS/iZcnO4Gf1yIffzPNonKcEx9hhtggwJkKNmFsYjz+C+N+5
	rt2DTsADECXTwecGIVw22sBgwUWNj9giPcgO60jNXR80omTW8jQ
X-Received: by 2002:a05:600c:548b:b0:486:f634:f2e with SMTP id 5b1f17b1804b1-48e530b05c8mr92706295e9.4.1778247942507;
        Fri, 08 May 2026 06:45:42 -0700 (PDT)
Received: from fedora ([149.3.87.76])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4548e4bb87bsm4463735f8f.2.2026.05.08.06.45.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 06:45:42 -0700 (PDT)
From: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
To: antoniu.miclaus@analog.com,
	lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
Subject: [PATCH] iio: chemical: scd30: make command lookup table const
Date: Fri,  8 May 2026 17:39:17 +0400
Message-ID: <20260508133915.22042-3-giorgitchankvetadze1997@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

scd30_i2c_cmd_lookup_tbl contains fixed opcodes and is
only read by scd30_i2c_command(). Make it const to document that it's immutable
and allow it to be placed in read-only memory.

Signed-off-by: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
---
 drivers/iio/chemical/scd30_i2c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/chemical/scd30_i2c.c b/drivers/iio/chemical/scd30_i2c.c
index 436df9c61a71..bf465cc71be7 100644
--- a/drivers/iio/chemical/scd30_i2c.c
+++ b/drivers/iio/chemical/scd30_i2c.c
@@ -20,7 +20,7 @@
 #define SCD30_I2C_MAX_BUF_SIZE 18
 #define SCD30_I2C_CRC8_POLYNOMIAL 0x31
 
-static u16 scd30_i2c_cmd_lookup_tbl[] = {
+static const u16 scd30_i2c_cmd_lookup_tbl[] = {
 	[CMD_START_MEAS] = 0x0010,
 	[CMD_STOP_MEAS] = 0x0104,
 	[CMD_MEAS_INTERVAL] = 0x4600,
-- 
2.52.0

