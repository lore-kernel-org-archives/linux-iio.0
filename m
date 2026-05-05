Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A00C3BFE5C
	for <linux-iio@vger.kernel.org>; Tue,  5 May 2026 17:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778003234; cv=none; b=WTPu+fntmN5NjX6s7quuuTO/jE9lfM/rMIjXYc4HwMFUI3PnaZMMxjqWE3gBHkYTuh+ZghUS9R00zJzZrO+cBQVd4ni4VE1ctCsTL1QJsiHBfyqtjaoVQzXoYE/qRcHKQ75VfHKrKVRBLv0/rLbUrn6+lh8XaWZqnpuwuLIgw9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778003234; c=relaxed/simple;
	bh=ngG7ZwhjbqXvArOVUnvZ+tcYvPyJZDl2+T97t7i14D0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WnXtao0HBed/fbjprmMJjMZKPImZUoRu20L79gw2unJrOvViIKXuwIzODVnZ2ElV3LvRoistlfbHjjVS73n3Fqn/UWTlOwOLkFLRW/uQoJdcMwGxSnilggeDs/BdK+Zr2I95/1a7OECmYydqQOw3XupP5aBHBH77Zr/2L08JHXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=od4723to; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="od4723to"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2ab39b111b9so24242925ad.1
        for <linux-iio@vger.kernel.org>; Tue, 05 May 2026 10:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778003227; x=1778608027; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dwTtCxRL7jVLdLm408KX/zDQEsquIagWbu04Wg8HTuc=;
        b=od4723toB0wlHo5Ahipn3TqECIKEcNKEs2GiqTRFE6srmByxkgt/T9C6vjb78gylUv
         Ux4wwBFUJrbND0h1q2JbOLpj+zfpcJw2UsrS6uaqb3MAv1tNioybapyKAH8W7AoQ+VVM
         l7/HZIgtyD2kR0b31hehK/ETDPNWoukybXCIFrq1EZnfuvfCldIYHDWkMDB3hZY04nLR
         kr0Q8qkHdQ56f/wmMa2DTQcjA1XDrPgerQD35UFUwJlUgQ+efvFE+FQCHtLkYbCAaekp
         uEL5ijS6iEGniaWvpyH1mGxCsLLScZwJXyLk2mFMT+RgPPsbUW0NKeJTYV1DFJtLuWvO
         Oosg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778003227; x=1778608027;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dwTtCxRL7jVLdLm408KX/zDQEsquIagWbu04Wg8HTuc=;
        b=g9NFj22GR7CDm/nD758OJ14SP5rR069hgWJ+dETM9KqcXW//+xJEbQwAIU0PgNos1h
         B3UbEIxYc3WormCo0fv3zI1wNvC329fxe2hqSCKXQjQms/gchds+xA/jVlbZX1+vR09P
         jB6K9mdC9LGtSvHjCyz5Nim7ArdulEdFkZkruc6tr8af9T9qnfpdMmsM5Tw2YWkeP9Yg
         WLxYLJuR1MSCf7iEBbSIA2yw4ahV5wDyP1zpGE7C/JzGZmPtml/zHe1hVw8ooKFtF0AA
         1mR+/+hWebLTL6qP599zo39C1a1HuCccIkRREbwDUFY2zmZ6jqNOihgQsZpCe8pSxTNa
         E2jw==
X-Forwarded-Encrypted: i=1; AFNElJ/YCVyeT1uufWnjwCi92O93npWACuJO/DElrqXiyIpgDfSQzZgNlPE5nZNv90SWLYCmcsL4VckyqIU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyY2KibH7Pn54MlWhXZv9YyguR+RL7du7HJyuS8S/oKFfAzbW1g
	FIBd8mu/oj+YUjU3WJiO2dbBH5F2nXVjDdyU+PZWa0/1z6MSVQ1wLG+4
X-Gm-Gg: AeBDievJixSArK1GoloIQQNiR7GlZBHGIitsZFoXNbJM+ciiBDEWmFZvDTZA7qUGPrb
	kMQJLBTrGd49K+uBNVFfqV+vdkmstWkTb9Ttux2hQN7YUGCVHpn4jhrlrE4jdSYylv3mfWH5D3x
	19iPdE4ArjFcp6NaNT2nIlpLOY/ItNAu/w3iYAM70mQuU7pDKncn/bk4c7VpFsWjVeSX2s0A/5X
	+ds0WsxUbp0zL5hoJDf227sOHF6jLvi58z0nSJ+PIEH4quoMbV1kv3pItLa0b1LC555+PU1DIrw
	Qd/rJZdndH25tfFFsn6rngfXf0s43Po2gYvhMV3cXOxZkqsAM0MmLiW8J3OcdcHQkrXBeV61olq
	1xSWH6bwg2IaXeP0RYF85KN06Aakhp543Cns1+AUonaPW1mJXgWF4MZx44IQYNtJetopmmaRzQ/
	cjCgjNasLNT22na3O2/zOPbVHNSDWKL45ZzCZv8iNLcb+zX3UBN7VXQ080xLc=
X-Received: by 2002:a17:902:f711:b0:2b4:61cc:37a8 with SMTP id d9443c01a7336-2ba53609907mr40685675ad.17.1778003226925;
        Tue, 05 May 2026 10:47:06 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b9cae3b169sm148663355ad.63.2026.05.05.10.47.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 10:47:06 -0700 (PDT)
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
Subject: [PATCH v3 05/10] iio: accel: mma8452: Use dev_err_probe()
Date: Tue,  5 May 2026 23:16:35 +0530
Message-Id: <20260505174640.3998281-6-sanjayembedded@gmail.com>
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

dev_err_probe() makes error code handling simpler and handle
deferred probe nicely (avoid spamming logs).

Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
---
 drivers/iio/accel/mma8452.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index d227ce3d5f67..b49949792190 100644
--- a/drivers/iio/accel/mma8452.c
+++ b/drivers/iio/accel/mma8452.c
@@ -1548,6 +1548,7 @@ MODULE_DEVICE_TABLE(of, mma8452_dt_ids);
 
 static int mma8452_probe(struct i2c_client *client)
 {
+	struct device *dev = &client->dev;
 	struct mma8452_data *data;
 	struct iio_dev *indio_dev;
 	int ret;
@@ -1580,14 +1581,12 @@ static int mma8452_probe(struct i2c_client *client)
 				     "failed to get VDDIO regulator!\n");
 
 	ret = regulator_enable(data->vdd_reg);
-	if (ret) {
-		dev_err(&client->dev, "failed to enable VDD regulator!\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to enable VDD regulator!\n");
 
 	ret = regulator_enable(data->vddio_reg);
 	if (ret) {
-		dev_err(&client->dev, "failed to enable VDDIO regulator!\n");
+		dev_err_probe(dev, ret, "failed to enable VDDIO regulator!\n");
 		goto disable_regulator_vdd;
 	}
 
-- 
2.34.1

