Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F7D480978
	for <linux-iio@vger.kernel.org>; Tue,  5 May 2026 17:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778003212; cv=none; b=S49d+ZDHNDtZyhn2nJBtEl8m2ao+TkT2GkRRcS8tWuhNO1CTK6C86ftpaMa7m595jXilmDU89ShNSRvf3+5gKjaZo3VgRmi7rZj7VKOzlfk7dr5rwKT0V1dtjJorWCnRbrNtbpUs77p/7+FbQ3S+tfcYoApRxEamyJWWdHCDzR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778003212; c=relaxed/simple;
	bh=dVoROqRTarCI3ArcUvyKEvYVz3wLegfbNtBsFww7WQE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OJ+mMlSpXzy15WJqz9uLgygnvT8QJfh9KfOTvF8dtA050FEkiDiAuoJa12B5m3EuOZvT7kOwfrxlpEHlZ4N0ccwR1kM5sS+MCS9nNQy/Lukx4yEkpqp9Gg72GZ/fwPXCpIT6qX6h96VsJHTYfNFzaQgZ31Na2aphZ2Woxih3Y3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZJxniXGe; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZJxniXGe"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3651fa24c6bso2418729a91.2
        for <linux-iio@vger.kernel.org>; Tue, 05 May 2026 10:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778003210; x=1778608010; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HZZevsa28Z0lnZm6lTUzLbhzzlq2jzJL2yxl54eCq38=;
        b=ZJxniXGet69UD9oYhI2u09xa03IOvvKWEJFpYrfo1mfupfxeEVaRsyWFLoJmtLjyn7
         vPQxxDJl9bnUpAVHqC7D52/BlAGlHY8Uij1B0g/kpjbIi9+E1NAmUhFDMOqKn1Rb+OIR
         PckXHCuJIUG1OvJXZAk5qqdKblGvsusYzQNxhBF4OkVYq4AUEOxqK6diPP2tYZEgxNdw
         BUc9rRAu16ThFaD37Wi6FBd9vTVn0GmSiKYVBpgFqIzQ9x75P3udIkgT9ohzRt0Yi2g9
         Tt/GvvwOaLAKEuPc1D3b+TiUnacLkf92ogTlJlYxRiUdmARMEnbc42M11lEVQOFclDvH
         T0Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778003210; x=1778608010;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HZZevsa28Z0lnZm6lTUzLbhzzlq2jzJL2yxl54eCq38=;
        b=Mhmrqsx90LjfoKzbcuxVD80yzxWqYVpdK8y6afwCmv4xBaL0Xb1joIetzXufTTgh6S
         Gad/IpqBIBrc3SNzuC83A/HdSgnCd0dpj8iZQ8MnHpMafJl6Eq/JxWbOWt6HwyPL+Q8D
         CVNMWOPHu04R4gecRKfnk/PMo+R6FeID48/cGSFUOF+n2us3HtH4LSAUFdZ0+VPovSfh
         EDFT8YarQp2eUoKCCdga0SjJ4PvPQuEhzXadWDrcm4wE+0aCCslc59fRLo1exG2o8HWP
         FxlAPwTvRZVReCndH9MjZ5quG3sR2QViz1hdPAZiY7xVj6uiTV437AZERn6it5rj6OJH
         TIYg==
X-Forwarded-Encrypted: i=1; AFNElJ893sQwlbcf+ZJ9UVVXSweR1nODWqFPTWKpcmvUlTEL7izdRuEBzk5/9Ok4okNEnOd71X9BY+acI+o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkVy5A7kJv/SZ+neR4+3v6h/OfAPePw7D+jnZXuVTnP7ZgtepP
	adpI+3NJonCKnnNhk/PXtPr/kHvLUV4LJ18z5jRuCGywEib2r8aVHACt
X-Gm-Gg: AeBDiev3gWY3Vwn/fEUefWoryi/s+o50E7TqschBS6UIjTAufAUAod3YDgzCuj2cFHc
	1T6qg/bjOTIQTboE1BpvwX6SE7mCIo727ch1O67I/L85EyDkMVrS6eXz5+tgFPoPGfIULhCkSEI
	P3dinhwtZJui3yYH/gRRVksC3OQ5WxXBUfN8u4ToeSHkJUxgvG0paw8lbtFWmOkKA9T4eoMTk3O
	yQUBHiZQZeswKgCMrbJx0VWpJfBowSfeiu6m7dE5gkhnHq1dwcK6sQJFLlJqgcBqdRtYp2rlKlz
	RPgF0xRumGuD3CUyWvKBZ+/a4/D++UxJKkmxWRGeCXm9p0NP/fhgn+6isJrRqT7a7ZwNXLu/POh
	6zIBrY8a3U6PpWg0mZFRScu0qKthg041yvK+ddQC1GtAjpnU4n2Dk71A1N5RDPkAlSdL/4lwUj9
	QqUCqD69OOUdqKdLZyhhUIPqZ3f960XasU2Dr+vy3KCPIjs8lSBKW/GVW4tL0=
X-Received: by 2002:a17:902:da87:b0:2ba:73c4:4a77 with SMTP id d9443c01a7336-2ba73c44b95mr8864685ad.9.1778003210567;
        Tue, 05 May 2026 10:46:50 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b9cae3b169sm148663355ad.63.2026.05.05.10.46.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 10:46:50 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	sanjayembeddedse@gmail.com,
	sakari.ailus@linux.intel.com,
	christoph.muellner@theobroma-systems.com,
	martink@posteo.de,
	mfuzzey@parkeon.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 01/10] iio: accel: mma8452: handle I2C read error(s) in mma8452_read()
Date: Tue,  5 May 2026 23:16:31 +0530
Message-Id: <20260505174640.3998281-2-sanjayembedded@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260505174640.3998281-1-sanjayembedded@gmail.com>
References: <20260505174640.3998281-1-sanjayembedded@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sanjay Chitroda <sanjayembeddedse@gmail.com>

Currently, If i2c_smbus_read_i2c_block_data() fails but
mma8452_set_runtime_pm_state() succeeds, mma8452_read() returns 0.

As a result, the caller mma8452_read_raw() assumes the read was
successful and proceeds to use a buffer containing uninitialized
stack memory.

Add proper checking of the I2C read return value and propagate errors
to the caller.

Fixes: 96c0cb2bbfe0 ("iio: mma8452: add support for runtime power management")
Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
---
 drivers/iio/accel/mma8452.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index 15172ba2972c..cefc7cf4bd83 100644
--- a/drivers/iio/accel/mma8452.c
+++ b/drivers/iio/accel/mma8452.c
@@ -252,6 +252,8 @@ static int mma8452_read(struct mma8452_data *data, __be16 buf[3])
 
 	ret = i2c_smbus_read_i2c_block_data(data->client, MMA8452_OUT_X,
 					    3 * sizeof(__be16), (u8 *)buf);
+	if (ret < 0)
+		return ret;
 
 	ret = mma8452_set_runtime_pm_state(data->client, false);
 
-- 
2.34.1

