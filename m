Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F9A3DD840
	for <linux-iio@vger.kernel.org>; Thu, 14 May 2026 08:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778748123; cv=none; b=uhxi94yxkz2xJUlzp5yAi4V0COJRMJQHjve3GxS7Uvp6JzzmcO0oipK6UEIZG+oXKYYpaRODI8vJ3NtAPQ4OYtaUJ2W+/W+vlxConz2nfQ7mkCfjWi0TUZGH2uN3937KFQiRm0bMvHS8Sty8ztwYTRib+Zgg+l192VLmT7D7RBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778748123; c=relaxed/simple;
	bh=LuPxpyHvmy+t1hj/p2H8/JlujCymj9F2cMcV+eBA5WI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N9Bz1dk+48tW3UneS73gbroQh+QZP0pe5RX+17nmGtcvvxvrab+yNfZzPYQmYDGGNJJmc3VpiMpTOvD81Lt3LLX1H0E690Ie1UqDGRmW0FHl2sKO7YkDAIk+uQSo8Unzyq+9GNxmnao4SwF+4S3GZahyT/4wXOpI1pYT6iSEagE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QlbgcrVn; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QlbgcrVn"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-488d2079582so78831405e9.2
        for <linux-iio@vger.kernel.org>; Thu, 14 May 2026 01:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778748120; x=1779352920; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oKh3xbTRFTYgVsr7K3mUWoC6h/DQrJ3+p7VCS66GyV0=;
        b=QlbgcrVncZMD4iKF5thLzM1U+i3/u89/T1fZfg/rLUTXEXSGfv8vE2dKMiMJuKHeTg
         qZF4z4p9Jukt7qfzcJz/jcuHdZHESdiBSWurFeVaawTYHV8RYIIhgAoKJuuTDsWKVfHl
         njDVDc0ma9T9NS7mviTUPEiHD7oT7mEFKow32/pPVavHggwckEqocRFxmkPAxtv8HxYJ
         LbKcRGG0MQYghWljDYC4OIynyLcno8vkdIG51nnIprlZp4pws1XelleQqXKawgKJ9TOp
         yHIddfuyySXrGo6NG3HHah6qWfDlpDUnD4WguFgpHcE40L8v7qdb+HpnXRY6suW+XLht
         TUYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778748120; x=1779352920;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oKh3xbTRFTYgVsr7K3mUWoC6h/DQrJ3+p7VCS66GyV0=;
        b=Af7QWc/xc4FlQgL4bNJhQmQsARfqTy8uKoVSrJY+tGMbfv3NA8t9wqMQ/9beb8vmLk
         F7ROgAZ2oRUs01lvGbtOqOr8ZLVWGhIYJJ1r5gSgRbIBq57FRscw/fX2/8BBaVZezD8p
         k5GVqTs9bIeDl3yuIBhefnlasQbqwQaKRVYSrsn+974YlIENtxbjl2zCYQwyBkW/oB3k
         iK5BTewwk2veRR37+9uEGLQQ0+VOGjsXX/nkWXR9yx27kcd6XQ+93VNtiFNuY9f+SjgL
         8BjXhk772m7wWd5/ElxbRJI1EMiJVeAqwXm+nGNmUJZSDQUpL2nY6GySmjlbZQUUrUoy
         46Wg==
X-Gm-Message-State: AOJu0YyPVhKCaQInya3HpDHxalDiOXShfwy9sHw8sru2P7pEFQbYalh6
	II312Rq2ZH9xrsLBtJTIZgGCk0Z0bLSDizqaTkam0OePsLPtt/qRfMbJ
X-Gm-Gg: Acq92OHuhXJrU5hQJgmhhkPGr3mNKqfX9PbR6qpIF7e/JhQICFCjGYD+UkQSFXyqq7Q
	NtmzHxGNsEPtwOxkzWGpEzftbqU0kRFFqKDFevLFJJejbv6Rkrxn/4JSenS0OBLOv1PkoRKH/3n
	WH754Udvn+zCP+VWlx7KOcYuwIYcTSjRtciY2BWmP96GpMqEcHfP9VHFfWa8dseZ6llo2XXz7iz
	vqKNcNLMEepnsKznBiDCLGJ9Du+cJvjO0QoW0K3Bl9D3XdZJq/KpwpUcNx/LPbi445RCXUw6eUg
	PAd7UNIAApHxwv4mFmnlDe4P//jRCxuP2EhIVswwIJLQ9ffkfysURfIQZcWl5v9R4VDBp2IpqkX
	4oLjptmbZ1nAgbQaIEDxeHoqfqCJUAGmoRhswFhu0Rzf+cNbJ85n47PKoLsZXGxp2FGFWBg0xIf
	CjOCojjkEAnVgZgwrLsf6NkSBGv2i3p4TZ5mxWag==
X-Received: by 2002:a05:600c:8105:b0:48f:d5e8:758c with SMTP id 5b1f17b1804b1-48fd5e875e7mr52919755e9.16.1778748120041;
        Thu, 14 May 2026 01:42:00 -0700 (PDT)
Received: from localhost.localdomain ([196.235.65.162])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fd649a21asm53190365e9.6.2026.05.14.01.41.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 01:41:59 -0700 (PDT)
From: Salah Triki <salah.triki@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Salah Triki <salah.triki@gmail.com>
Subject: [PATCH v7] iio: humidity: ens210: Extend I2C functionality check
Date: Thu, 14 May 2026 09:41:54 +0100
Message-ID: <20260514084154.298154-1-salah.triki@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ENS210 driver requires several specific SMBus protocols to operate:
- WRITE_BYTE for sending commands.
- BYTE_DATA and WORD_DATA for register access.
- I2C_BLOCK_DATA for reading humidity/temperature results.

Update the probe function to explicitly check for these required
functionalities using standard macros. This ensures the driver only
binds to adapters that support the necessary transaction types.

Signed-off-by: Salah Triki <salah.triki@gmail.com>
---
Changes since v6:
- Replaced the incorrect use of I2C_FUNC_SMBUS_EMUL with an explicit 
  list of required SMBus functionalities as requested by Jonathan Cameron.
- Used combined macros (BYTE_DATA, WORD_DATA) to simplify the check.

Changes since v5:
- Changed patch title from "Fix missing I2C functionality checks" to
  "Simplify I2C functionality check" to reflect the new approach.
- Dropped the Fixes tag as the change is now considered hardening rather
  than a bug fix.
- Replaced individual functionality checks with a single check for
  I2C_FUNC_SMBUS_EMUL as suggested by Jonathan Cameron.

Changes since v4:
- Fixed the alignment and indentation of the I2C functionality check
  per Andy's review.

Changes since v3:
- Fixed the alignment and indentation of the I2C functionality check
  per Andy's review.

Changes since v2:
- Fixed the alignment and indentation of the I2C functionality check
  per Maxime's review.

Changes since v1:
- Updated the I2C functionality test to check for both required native
  operations and SMBus emulation (`I2C_FUNC_SMBUS_EMUL`)
 drivers/iio/humidity/ens210.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/humidity/ens210.c b/drivers/iio/humidity/ens210.c
index 77418d97f30d..d209f30d61ed 100644
--- a/drivers/iio/humidity/ens210.c
+++ b/drivers/iio/humidity/ens210.c
@@ -204,6 +204,8 @@ static int ens210_probe(struct i2c_client *client)
 	if (!i2c_check_functionality(client->adapter,
 				     I2C_FUNC_SMBUS_WRITE_BYTE_DATA |
 				     I2C_FUNC_SMBUS_WRITE_BYTE |
+				     I2C_FUNC_SMBUS_BYTE_DATA |
+				     I2C_FUNC_SMBUS_WORD_DATA |
 				     I2C_FUNC_SMBUS_READ_I2C_BLOCK)) {
 		return dev_err_probe(&client->dev, -EOPNOTSUPP,
 			"adapter does not support some i2c transactions\n");
-- 
2.43.0

