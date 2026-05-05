Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531FB3A5455
	for <linux-iio@vger.kernel.org>; Tue,  5 May 2026 17:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778003393; cv=none; b=ImZkmh+SJDAdUqpsctkGWIy/c2K6apJQj7n5GXXyQrxcC9plHTkuXI+UqhrHEqQodpwIYbAqPzc/zqjlBtDZcZbE1W5BmXBrExSm9o/EedIg3EJPeM4NKKPoMkEBhJRPa2T995HmWUcPUwjPAtOpZCVueyLID7DQDigULsoafkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778003393; c=relaxed/simple;
	bh=w4hiPIZSnLm6xSzc/SEuEvonQ7oBR60EMPtp4y/KrDM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N9zu/3gLc4L/A0DPgkuQ7XNrggXHzpFAXgi7zEqrNLzLsPihzq7IQi5kTyB9ajSntu0MakJKWFtCnk8p15Uul3V1XM3ulX4njMmbMsUVApobIBrtTmuvyDDjPxivSTYRqqddIt0Mfotztk7cIx9xdNHh771MOew+icW8Rr+0GPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nocj33Oo; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nocj33Oo"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-670ab084a39so2908508a12.3
        for <linux-iio@vger.kernel.org>; Tue, 05 May 2026 10:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778003391; x=1778608191; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3UrKVe07+jLayu54Y8A/h3uXDWRQcGVYQ0pEg6sqT3o=;
        b=nocj33Oow8jxyfNLbZPTsY54VnFIc3dpQcnn/nj4Odcx+kDJA6oCfnsFisXkPJOuJJ
         pnpEyKgtA0829xKMSyqeVtc+qCiSlKQ9RFRf+AwrA4KeOwfIGVOP+GCxP5uvs0EdMMAk
         loFfUpJrOVLUOudnuWZXC9ZoWi+YkIWH6D9FxgNSc6oDO/FHWvXt3U3TZHfIl+YXyWLx
         ZJzZt7r4p9ifYR7jEXqBQ1MDG5nU2BXQxxRJom7KYu36MynzAxVhGyBT+U4NXwh2vOAU
         xzUaH0/nKUyYOwa7JglrMuRmaANPZ5TxrWLbcCCmC1x+glaZq3Kh+ll/ImyhtdvabqLR
         qJdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778003391; x=1778608191;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3UrKVe07+jLayu54Y8A/h3uXDWRQcGVYQ0pEg6sqT3o=;
        b=tC19BPKjO9xDE/nYPI2UTWa/LWrKC7PdBRqkVPjKk1V8BYTZJcj5NUoq5ksAKFs99w
         b/kXrLPVfzMWj11MJn4I7hJ3Q2q+iPXBcSupBe6SbNOBw44NeovcLRIDsRF76YzTxgdC
         ALMWPcWepzw2WjOgu71x6IJiQI9z+8yOXOzMBFrOCiOP3kPt5A2IDXMW4Qna7ETTgvP4
         1OANfPDP+s9jIwpKVSydIUQVFY0hvsafDuTORQSTJUCsf/rKtM0sKK1zWLQDKfCRi071
         3xYiMOoEXE/F5ey4NxOA/IoalgQdojLWi1usBQ+q2MKqUh3/e/fmXm/Fu9PEmnZ9hbCH
         Gnrw==
X-Gm-Message-State: AOJu0YxAAc5UjD4H0KDr4lNH8B2JLPa71ayu0s2B4qtPgapwPX5c4Gwi
	zPwMMklkLpRuEk+eDFwgdhcMDJAbuHwrdvZ3OoPY9Ov/P5PtqU17giww
X-Gm-Gg: AeBDiesYAeRr53R1TtKPc1moDdnEHq130MRQMEwQr4a89lifRNApmeX9b9b48uXpWQ3
	z+QckJn1Yq5NTMk9yA7kwFQczo7etYH+Ida9ZSGI1zPzvocJSXmL4ifjDPWw2Y9xGziOAccKsr7
	fQMOH8QuYMogXwedjSSVV1EYmLO6S6r8BltWtOZZ1lwp6cuKcMvg8DcSFs3G1LdJXPcnE+mQ5yx
	k5cz8P/qTbO5TCXyaQKlwi30Tdtiq8TSQmF2VeyXxenDvwNqLS3BOc7yv0oqU4SQMyHrdhFsu9k
	W9Zf9+KtIBALCLpBpNH+3eKbjPV6jKxlDSHtyBFzOP98EluxbAiPbwfp+WD7OGGebQW/pVaIJtb
	9cja3xtTHaB3mr/1Ed4HhpXHwiuVMuWgnc0oB4cMamLwfvbG0/YYq5MAorPCFfj0YHp3p64HZMu
	6rSKN02q5oAveCAUCfPRnj8QzoLZiuWBBOq09kao2HNyIhiJSuHmB9JtpvkwA=
X-Received: by 2002:a05:6402:2b91:b0:674:28d8:11b9 with SMTP id 4fb4d7f45d1cf-67cca825a35mr2296707a12.4.1778003390327;
        Tue, 05 May 2026 10:49:50 -0700 (PDT)
Received: from localhost.localdomain ([196.235.252.38])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-67cd90efee1sm596753a12.11.2026.05.05.10.49.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 10:49:48 -0700 (PDT)
From: Salah Triki <salah.triki@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Salah Triki <salah.triki@gmail.com>
Subject: [PATCH v3] iio: humidity: ens210: Fix missing I2C functionality checks
Date: Tue,  5 May 2026 18:49:43 +0100
Message-ID: <20260505174943.94093-1-salah.triki@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ENS210 driver uses SMBus transactions (such as byte, word, and block
data reads/writes) during the probe and measurement phases. However, the
initial functionality check only validated a subset of these capabilities,
which could lead to loading failures on adapters requiring SMBus
emulation or native-only controllers.

To ensure compatibility across a wide range of I2C adapters, modify the
functionality check to verify if the adapter supports the required native
operations or, failing that, supports the SMBus emulation layer.

Fixes: c524fbca672e ("iio: humidity: Add support for ENS210")
Signed-off-by: Salah Triki <salah.triki@gmail.com>
---
Changes since v2:
- Fixed the alignment and indentation of the I2C functionality check
  per Maxime's review.

Changes since v1:
- Updated the I2C functionality test to check for both required native
  operations and SMBus emulation (`I2C_FUNC_SMBUS_EMUL`) to prevent
  loading issues on controllers lacking the emulation flag.

 drivers/iio/humidity/ens210.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/humidity/ens210.c b/drivers/iio/humidity/ens210.c
index 77418d97f30d..07925bed2bea 100644
--- a/drivers/iio/humidity/ens210.c
+++ b/drivers/iio/humidity/ens210.c
@@ -202,9 +202,13 @@ static int ens210_probe(struct i2c_client *client)
 	int ret;
 
 	if (!i2c_check_functionality(client->adapter,
-				     I2C_FUNC_SMBUS_WRITE_BYTE_DATA |
-				     I2C_FUNC_SMBUS_WRITE_BYTE |
-				     I2C_FUNC_SMBUS_READ_I2C_BLOCK)) {
+				I2C_FUNC_SMBUS_WRITE_BYTE_DATA |
+				I2C_FUNC_SMBUS_WRITE_BYTE |
+				I2C_FUNC_SMBUS_READ_BYTE_DATA |
+				I2C_FUNC_SMBUS_READ_WORD_DATA |
+				I2C_FUNC_SMBUS_READ_I2C_BLOCK) &&
+				!i2c_check_functionality(client->adapter,
+					I2C_FUNC_SMBUS_EMUL)) {
 		return dev_err_probe(&client->dev, -EOPNOTSUPP,
 			"adapter does not support some i2c transactions\n");
 	}
-- 
2.43.0

