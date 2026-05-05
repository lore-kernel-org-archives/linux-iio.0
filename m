Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61D948B384
	for <linux-iio@vger.kernel.org>; Tue,  5 May 2026 17:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778001779; cv=none; b=L2NTYATEL/pUajoVEprALkeWNEiUEgXQ4jpdJbpIyjv/0f7kUuf4NfNMFeVc4CFD+LoorXYNqW1ZmRXufhfnDHVwCuDOQUrpFv9i+F8vNy+MuyKWSTg9Qeh7mV/qnQrqtCrZFj/41LXWuSpPHUds4A+Aw/X9dvsvIJUNCIj5JW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778001779; c=relaxed/simple;
	bh=dmt9Gkk2uhujIs4G4b5U8EFHGxaY+XAsrfyXWKYDACA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aCSYX+cRpHYcbThfaLGroyAEsEXgyLjYJv4vvR0ofLl4vbR/A+aUksOn/+rMJBJNM7W81CpHe27UzfXEpoQJz9PHsnOIcucmhpCqLzcj1/Er/E3g/DtpEXQeSzn6cGjxTw7GY2WWgN+MeToWidl/W4GHyIY3TBzkO5OzcmMRzWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MHVWbwW1; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MHVWbwW1"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-bc47a96d3bbso120386866b.3
        for <linux-iio@vger.kernel.org>; Tue, 05 May 2026 10:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778001776; x=1778606576; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0FOqjUCkmT7At/F8JOz9gBL9DtdzAA5KnxpWzyPRye8=;
        b=MHVWbwW1i0S50okI3x6QVt9384+bd+fGCFpL/FMg52q5cW/71kE1MzLD1Eh1GEpzNu
         XurwD4ew0ybD+eYMKI2M9pvr52Y7r1dj6V4G16KaDJyJCTpOhGmLads5kuHI1HjTKRGT
         +HRFlcZtXmetSU/HSl4UHCyK7omaE9LXt9op3MSpeV27PMK9cR2ZsbfZFE9IC8d1+3vd
         fnUfeWpv06y/FpwflPNhaR9vgUz5qtBPW1ltZeFXEGJ7iQwVjANlHdqs4wIPKjAzz36W
         XuziUuQblyHIf81iNB9LCru7UdEj9P6iWmb9Rk84zw6H/lhI86hIFv34jOgd3/d4wj4q
         /byQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778001776; x=1778606576;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0FOqjUCkmT7At/F8JOz9gBL9DtdzAA5KnxpWzyPRye8=;
        b=KeF7+4xvs44r/H7COrjJ+BNztPw9Om4ITq7xG+kOrkWDwDs94J53D/BhEHCtQYGeKR
         wc1LIPyPCkj+Q81IBqzs94Gf0YTbd6jtujMG57q/TaWH/9Kcctz7KvXp6VgIDC4s0uBb
         X2TNuSw+ay1JBD+by8i0dHOmYUtPFEVE/Q2rpg4LfH0TafsRZSj9yT0DjFevPSpqiHM5
         3jL17LWuMLgl8Mjr64peMCeuEbfkB7+8O2oSV8Dgh0j0EuFIuYb2wWgXJL+ikStHdOsM
         wpbN9LTN+Z9Uuexn9A5X6kLS8bOPz3GHCjuD7CThksK0bD2Q0mj2SyIdBHdeXxCCwMld
         j1Wg==
X-Gm-Message-State: AOJu0YxHGF/wRC+cQeW13m5A5BAgFh4yOl1phhWhg/AHJGm335ggFiTE
	YnoK3qrxlAFZjf6TpG19TGZIZIulJtxuZKPBF+CLMXNr2MDdCq8eR3Rz
X-Gm-Gg: AeBDieu2+sJuCO/JQvUWB6W6D7JrIg5oV7WwxTkjVosU/4wYyTPgEw2uzJ7TT8uq41P
	LSkeMSaYF0o2nzcYFsT21oKHnnzKJBJoxCyf9Oo/Rlqj7i4d9jHxHqUeKHjedw65QBbwQ4crHZC
	gHJEW/telZpH1JwZlOBYikMNMUZvMdb6oA4Kg/aWc8ZxtcoYx18bvAHypi+dMtiVYGVdehpapO8
	4ilZC0rpR866ggBX1+ih9NFS52gV83y6gjWX2FNjdgZNprHUFq47Df9ej0oKU1TniVoIzUbAHm6
	zwiKZ4oZrUixqTCBx2QdUcQro9aGQFvF5eIymgHzOjpfx1lQ2KF8v61iUTjQzhdMwpcIl/MkNmT
	VlWxyXbcoqzlFSvQ0FoE+D/sfgzaysWTCptE+vM6vYnJ8GxqkNiteX7hmoqqKmrItblKzqi2fxX
	VXrTLWmx3mAe+JYpMIZfXnJ4x41ZKj+5CcNByZAviDjEDfsuRF
X-Received: by 2002:a17:906:4fd4:b0:baa:6847:af9 with SMTP id a640c23a62f3a-bbffcf81c95mr843789766b.28.1778001775889;
        Tue, 05 May 2026 10:22:55 -0700 (PDT)
Received: from localhost.localdomain ([196.235.252.38])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bc21f2ed5eesm236003966b.14.2026.05.05.10.22.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 10:22:55 -0700 (PDT)
From: Salah Triki <salah.triki@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Salah Triki <salah.triki@gmail.com>
Subject: [PATCH v2] iio: humidity: ens210: Fix missing I2C functionality checks
Date: Tue,  5 May 2026 18:22:45 +0100
Message-ID: <20260505172246.90892-1-salah.triki@gmail.com>
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
 drivers/iio/humidity/ens210.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/humidity/ens210.c b/drivers/iio/humidity/ens210.c
index 77418d97f30d..c722087bc188 100644
--- a/drivers/iio/humidity/ens210.c
+++ b/drivers/iio/humidity/ens210.c
@@ -202,9 +202,12 @@ static int ens210_probe(struct i2c_client *client)
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
+			!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_EMUL)) {
 		return dev_err_probe(&client->dev, -EOPNOTSUPP,
 			"adapter does not support some i2c transactions\n");
 	}
-- 
2.43.0

