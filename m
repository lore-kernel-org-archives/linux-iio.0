Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC56B3F7AB2
	for <linux-iio@vger.kernel.org>; Wed,  6 May 2026 09:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778061567; cv=none; b=Ht2KiaxHVBUoTNGO4w203vNSmMZCmcAv123g3iX9HBLlLslxWvy0gvfjvPrtYi3rJ7PrbDNPLmnWI39oNjXRKfbh/kK3lbrNSZQebZPubb2amgUAl8useUtKNhf0bKtcuKez1NkmwMP+lw0hCoUTzmIDtjtT3709vq9BQvrkUTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778061567; c=relaxed/simple;
	bh=ODYbs/4qFS8mGunySbbl9t5b3pslPtDBAWJ2j3ndbtw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ek9OCyiiuIBUOGkhlR8phl2H2AYWE7x+nOE8wE9DxzNGAP07HYwIgQ4OmxAeOePOgF3royIDlffaoHTH4fa/gd4BhInU4thCkzNm+8BfYpBsk9GeijkLG2L4ufVQOCsX1kk5Qljq2BBRuFgBFxR/3czVuIyQIEAvHUxQ2JKLXeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=agvVv6fR; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="agvVv6fR"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-488b8bc6bc9so39402535e9.3
        for <linux-iio@vger.kernel.org>; Wed, 06 May 2026 02:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778061548; x=1778666348; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iS5WTyUEworChY9dzMjKKDtiYrkTGtQXOk8l279bHxU=;
        b=agvVv6fRQkNStPRIYXYpTkQJnHF9uiYRF0XOhmsFZmhqEAKYM7nB/r30qcn/4Q58A7
         r/LZks7IfBZfsRfrGadBvG/RWbWiVDECbumNC0+eFe9OG/uIlbJuxe1KRydvv9kmjoqH
         Q6K66gnVasn6jCwDF2DEUYfNV2VMsyeTReRsl5zEhgxZduR1p6V/ga3ucU/XjpaDnhFJ
         qCgQTOAL/mIWdWNOC8gg4mlDmTBNDIhm7BaPjFDtIsKEadTnMTcvfC1f8gwY05b5+RZk
         0tGLLiorhnoZijULDXdRBlpCNn+l0LP8kqZM2d4YYZL8pahEC482K36r/iDaBEYPFyIh
         hWMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778061548; x=1778666348;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iS5WTyUEworChY9dzMjKKDtiYrkTGtQXOk8l279bHxU=;
        b=Xskruv8VcJdIh1ZIXPE6BGAPkFNbdlYpua0tgKjTVwjNPBmS1p121T6ab0aKAPowKO
         I+O7rKJMHp5MBOEkX6Ek79gipfh121dlOl9DhQdziA66GL6nAERGza1ZE5vP30Xfl78I
         QGuod04lGaHpGo3J/QIi916dRyImwai4Y2tPT8G16sOnUbDw18fet73J5Jd1GVp2J7+6
         NWD8aYZpgYVmW7fyfWWnRYF6pjN1oAxozZovwbOEn1my/mcHyBv1yVyCMOVs72gQEt1A
         UpPNZjkq2wgqxuBgoX5EE9hroE13/EPCPN9OiAdx7byUaEycVacvRBwqqaJG+89eRpvA
         i1Zw==
X-Gm-Message-State: AOJu0YxPm43XWtDpjMq8bHl29zNvREbJ8NSh/2haz/1c4EFej3CE+d91
	uX2ii9BtANSyFfcoo4Xi6Cuv+9NWK66m/MFmMx2WPiEd9kot2y3Laa5M
X-Gm-Gg: AeBDiesmfSNDXW/QetsnDxsvIkp7pSGLNEOS7viUC2e8j0PoQl/Tx5KHMSPJ7Q4Xb+l
	ACRzRp3YvhUoETG1YAQGuUS2HYBhbIgZoT8hgGzKxc1XJ6tu9D0vA5Z34QkQhHUZEy/N33YODu8
	JSzgn2LS+nmUX5SyqJovmjkB0eNknmob+ZfcoWYO1X/fs6feWFS4P4EppEj7wSpo3mtrnqJ+NRU
	WJ1ESVcr97Qxn5gj99BkpbU4d1JOIdJ9ufSLBoFxz8aZ+IY2Zv/KSmBLgcPmLQXWGircLvl1Ckf
	aUVdMRpdvGVAZNgsBCxU9EvtyxKlR3s9Z4W+bU+YkaiDGGgKlweTm8mc2FrPMu5pS6a8zJby2l4
	RV02u+5BoDGj+ILExhoebM8laGGEI11rnlPdF0JOdiDWJAaiQzZhVcJB2YFwl6zPWg77rL7xUgs
	oTKbPbioFGnCa3Zot1TZHLAW74nt5Rj71y//sDnNqN3HaLkN+H
X-Received: by 2002:a05:600c:8485:b0:48d:364:e236 with SMTP id 5b1f17b1804b1-48e51f30493mr50016315e9.18.1778061547531;
        Wed, 06 May 2026 02:59:07 -0700 (PDT)
Received: from localhost.localdomain ([196.235.155.85])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e538c4ae1sm33933415e9.12.2026.05.06.02.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 02:59:07 -0700 (PDT)
From: Salah Triki <salah.triki@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Salah Triki <salah.triki@gmail.com>
Subject: [PATCH v5] iio: humidity: ens210: Fix missing I2C functionality checks
Date: Wed,  6 May 2026 10:58:35 +0100
Message-ID: <20260506095835.10112-1-salah.triki@gmail.com>
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
  operations and SMBus emulation (`I2C_FUNC_SMBUS_EMUL`) to prevent
  loading issues on controllers lacking the emulation flag.

 drivers/iio/humidity/ens210.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/humidity/ens210.c b/drivers/iio/humidity/ens210.c
index 77418d97f30d..159a3c158c9f 100644
--- a/drivers/iio/humidity/ens210.c
+++ b/drivers/iio/humidity/ens210.c
@@ -204,7 +204,10 @@ static int ens210_probe(struct i2c_client *client)
 	if (!i2c_check_functionality(client->adapter,
 				     I2C_FUNC_SMBUS_WRITE_BYTE_DATA |
 				     I2C_FUNC_SMBUS_WRITE_BYTE |
-				     I2C_FUNC_SMBUS_READ_I2C_BLOCK)) {
+				     I2C_FUNC_SMBUS_READ_BYTE_DATA |
+				     I2C_FUNC_SMBUS_READ_WORD_DATA |
+				     I2C_FUNC_SMBUS_READ_I2C_BLOCK) &&
+	    !i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_EMUL)) {
 		return dev_err_probe(&client->dev, -EOPNOTSUPP,
 			"adapter does not support some i2c transactions\n");
 	}
-- 
2.43.0

