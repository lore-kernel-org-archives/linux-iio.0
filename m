Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C99A18E02A
	for <linux-iio@vger.kernel.org>; Wed, 19 Aug 2026 10:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787135492; cv=none; b=Yy+5ukWoI66fNNrojf1mmwRFegTAh3aoUYe/nXmJnWQ/kQhG4/qQIPRjVjIXOyfOvDaHHKF92i8hXVajQB1sR04cpXhuAfSL3iU+Pfryi8FK/tOKgZDFlZWDSz8SJijJd2o/NUpwOknrqPJSOBvPGNfnyD3h5Be7xO9czoTnH5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787135492; c=relaxed/simple;
	bh=9Qkhkh8522ebnwz5H0rW3+Pio8/owpsLYVwSBfFvyCs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eWjP1GzXEYhx/KJnwnBFg3uzrNL+3jgq9Nnd4g09oY0mAcC6O4volTtryvOWXP7mvYa8G4MDvt86047jXmVDtn7JZWjXGXtAxbIMa7ut5hJFhbHXvrRySTO1BuHnoZFmBxSgtgoX+epM4U20QQnW/JbbuZvYFRHXaC7wnyx4XlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QTb4xtr3; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QTb4xtr3"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-49954b88fffso8668435e9.0
        for <linux-iio@vger.kernel.org>; Wed, 19 Aug 2026 03:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787135489; x=1787740289; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jR2O7SPhUsucSLV7PAV/FXwdRoC1TShjM26AELxkU6Y=;
        b=QTb4xtr3bAsyqu00nOevvqeMc8vXgyQKive02FU6Rs1/a/QQi51vK2CnSfFE1rBsXu
         WqREDcNsJdIcoBa5j7v1FzmcgzGJL3VC/5NFUfiwou7aRlXqmFSGNWvLMZOlAmMj6lS2
         bY9C9a4PyEIHshBRpT9draQai3Xa7sG2UuBWi22rdOACdSZKjR+rsCVySukS0Rex94Cu
         bR1JrkhLzlGLUrnYvjcq2wTfD8SktnJaW+L47pn0aPcAumWk/l9lb5h3oeY3hsFpyVsk
         C5rDYTGAPDkIkeMalo0Pk4fWR81rXJpl2qmX4QuF25Qd/dP3Fbz4qZHU8e6oD0YlJB6T
         m8/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787135489; x=1787740289;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jR2O7SPhUsucSLV7PAV/FXwdRoC1TShjM26AELxkU6Y=;
        b=iVC+0kv0AIchYz+jTsHfW79DmT+1KsYPL/y3ISTADPzjYwfhq+so7p0m7JrQa+0YkZ
         uLtYt8Md3oHBkVRqoqa+CwetgQlBSSxdiORJThMaqJXjR2J2KaFhuz/q6CnjTy5edfzf
         H7p0DVNNe3NhY+W7tTaOjgkWoVllsyM3FsD8QugXVmw6VBjCKlX1yqgBCQrTGI2gZmVM
         tTXuxpBiuJT3eUFOK1y/R6icL3uP/UaU+BbQr/2fsudazZhDMQ73lAjJ5rc+WubtDZUV
         Lyzd+fd5dbKMqAqxu3nk3AKT7mdzz7Tbg7KJpvOkkHSSyCb6wW5TtK/ZTePGdF6u3YkS
         2ZzA==
X-Gm-Message-State: AOJu0Yzfc76KbX4j6m8kfCsIRarvdKvc1QVHpHssmhe84iaFR/ogOOE0
	9Rh3WqlGXfqjXhQCh4PGSG7RW5WRRmA7Z4Wa4T+zFSd4GB5M4KULkmXL
X-Gm-Gg: AR+sD138fCxPB4CAyB+v0z2sfFXczmcc/3x6lDKjbGsOdcHCR1mk5mvTiFsvIsAofTi
	Icrhs6Ew+rAxf599r/uQ6pYv85JUmKHhwJ6fhMYPi7eTYktMO3WFVMJdLNQYvPikPAJAvM6RscX
	aHBU+4vw9+cTGZRsEE2LtcJhOqAD/3nhvBM1QQqTFN1u0Gb/s3S6Mh7jXvUioNl9VgAZQLTfg75
	qQCG8cqcx14h+N7xMi1IIS7FU8iHc8AFg+VYrZZy8SpaW5FWSJoe9bxo/+3Pnk1kq22/FbDSG3r
	t+9DOyJwLJ3EL8VST1NAUKZh3bIr/mmO4SwPKFjv/NpkLpJbp9pFHlOrJ4mZmYKrymb5vLfLL+B
	1j9XImuKuN65D2wvU4pKsRisT3AmSQEKRvAxHxOP5lD6Fd5KxSYFH8wBsWECMebH8o6AbRrKmeA
	eBiHgydmeCNUPEtFvfwD9dVIJ2cOgSHuXW3wUhC2x+wj2KzjZxiVSQgaSCKr8jp0oOKVWEY5pfx
	F4=
X-Received: by 2002:a05:600c:8b65:b0:499:a5fc:2087 with SMTP id 5b1f17b1804b1-499aa1722f5mr66480935e9.6.1787135488419;
        Wed, 19 Aug 2026 03:31:28 -0700 (PDT)
Received: from localhost.localdomain ([165.51.108.173])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499ab2a8b34sm56446915e9.8.2026.08.19.03.31.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 03:31:26 -0700 (PDT)
From: Salah Triki <salah.triki@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Stepan Ionichev <sozdayvek@gmail.com>
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Salah Triki <salah.triki@gmail.com>
Subject: [PATCH v8] iio: humidity: ens210: Extend I2C functionality check
Date: Wed, 19 Aug 2026 11:31:09 +0100
Message-ID: <20260819103110.25718-1-salah.triki@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ENS210 driver uses byte data read/write, word data read, and block
data read transactions. However, the probe function checks for
I2C_FUNC_SMBUS_WRITE_BYTE (which is unused) and misses the check for word
data reads.

Update the functionality check to strictly match the transactions used by
the driver by removing the unused flag and adding the missing byte and word
read capabilities.

Signed-off-by: Salah Triki <salah.triki@gmail.com>
---
Changes since v7:
- Fixed functionality mask based on code analysis by Stepan Ionichev and
  Jonathan Cameron:
  - Removed unused I2C_FUNC_SMBUS_WRITE_BYTE.
  - Replaced I2C_FUNC_SMBUS_WRITE_BYTE_DATA with I2C_FUNC_SMBUS_BYTE_DATA.
  - Used I2C_FUNC_SMBUS_READ_WORD_DATA

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

 drivers/iio/humidity/ens210.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/humidity/ens210.c b/drivers/iio/humidity/ens210.c
index 81276195152b..4bdd37e7227b 100644
--- a/drivers/iio/humidity/ens210.c
+++ b/drivers/iio/humidity/ens210.c
@@ -202,8 +202,8 @@ static int ens210_probe(struct i2c_client *client)
 	int ret;
 
 	if (!i2c_check_functionality(client->adapter,
-				     I2C_FUNC_SMBUS_WRITE_BYTE_DATA |
-				     I2C_FUNC_SMBUS_WRITE_BYTE |
+				     I2C_FUNC_SMBUS_BYTE_DATA |
+				     I2C_FUNC_SMBUS_READ_WORD_DATA |
 				     I2C_FUNC_SMBUS_READ_I2C_BLOCK)) {
 		return dev_err_probe(&client->dev, -EOPNOTSUPP,
 			"adapter does not support some i2c transactions\n");
-- 
2.43.0

