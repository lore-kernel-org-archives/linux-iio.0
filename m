Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5053ED5A8
	for <linux-iio@vger.kernel.org>; Wed,  6 May 2026 09:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778060799; cv=none; b=Du8f5a1iaVDTYYJDR+1eKlk+5sZcYOglETMy5bH5sLhEbgeKEIdpGTx3ojTbcO6gxZFHRjqOHmwGeKJI46UsVhIblNYbSqzh4NHCfCLCOEjx2hfsdEI65gfs6nyT4vKbzg0OjkyndZiYUGAiFNPcJoMUiGGy5aZ3scE8QJB9Wyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778060799; c=relaxed/simple;
	bh=O7H1bjWhe7G+p25CEte5AQNZVR4jOK7mE1NxJHripdI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DLuQ75aH79wzhF9KZS2Bg9jzuSRLhTsrzDOP/RPXCac4B1zwbGBYzYnjl/OJRmxnl1OJthCtLCA5hboC9PVO8NwVGXRgCTUd9GMo93Uu+fBeuntdCzlJROAwM72umDHVm+CdWugIjR3ZENGzMhV3uUVXbgtHTSmciMJWB1spJBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WZXc8uor; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WZXc8uor"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-488b3f8fa2bso6850445e9.1
        for <linux-iio@vger.kernel.org>; Wed, 06 May 2026 02:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778060797; x=1778665597; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JE7uJopuB1K2d8z6OYIS2HK/E7UeqDAO31A/wEEkRu4=;
        b=WZXc8uor7ntEbCJM5j4vRFCuznDc68XteuqXl1byn8/pedplsxVL9W/Qy4eXPZJFvM
         IGiRN74ZEd5ud4J1B5+AESPLCMkeovMuuPgi2AOlNpGNlQO8c2d4NYP+YUxP18l2v2ho
         kv89kg2ay3hd97MDTecTeDQ5NiBuCSPtFPn11d4NxJFsy86EbhBdcCAIgk93CKMW1aQ8
         VvGM8I0xTbWla1iP2sjkdXvdfj3Dp7PBCmRuhaZt5BI0zCVFWT5OSta4KcDM+HubPjGa
         SKyQ4HBUINfuX7rQ+DjLPWMTMIxulIYfuZ9p7h7sxEWkddDGkmTiDByKfIQcfEFwKrgX
         kwEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778060797; x=1778665597;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JE7uJopuB1K2d8z6OYIS2HK/E7UeqDAO31A/wEEkRu4=;
        b=F+SHsYfhIgOcrfmvHkxNmF7eVKmPrbPmOv4wB+xVL1kIumCzLej1MBxzLkKpDRq543
         nCz+Vvr680VeGDmW8dY2IaW9aoVSzzq38PpsAlclsZytgDH7vofJnYxjwmEs3a05J4+/
         vzys5eMSD/Vc3loSRrOwG9DYheKvn2TD4sCQhrp9dbmzRCNHtiGbxWiROTrUGo1Mp6QV
         NC4z4fopdZQ0GfDa/KpWSDDXeH3yCZzVmp4Ua1GqXMs2pLD6HWvw8fBSNBWzF4rR9NFA
         IKvJX3lUDvSzrPcYwMiqdY2PtyedHWbrtFAaze5zjVFWrBcT8Z4gF3XCLDFSmqfsA/Yu
         tuvw==
X-Gm-Message-State: AOJu0YzVifApjy2BDDaFtKY7pK6noErLcvbdt0sIz7NMmoDaokca2Yzn
	LXlKtMDeNU/c3KyN1hJ2HZx7nhMIp6BmlWAue/gIG6wTkYGG9tBdL9tWWudVKG9d
X-Gm-Gg: AeBDietNxfxZhWSWQMxpwwiu7LDiSAo3i5szqpyK48at3caVxtwdw0nv5p/CGVcxn/D
	+yS/BURFzkFDggK9C1CwvfuFgE3vFBVFWvh70anz/rdWGvA2MzqQE+MY/wMSd1JFCSKodiDs0HZ
	U2Fd9RLTQygedv2UuCcWuOmuqE/j5xvUub4TDk6ffue1DoxN+vdH591NgcoRNp+NT1IqHVH9bww
	Vt+Lsy4iWK2R1RvYvSW825UU2DEOwbMocnoP0h+siW8VhB3aykUOH08QxOapNbur39RfRey1J3f
	YJqae3TQujwx30hFZ6DjEcMJ0olzcCmH4QeK4ZRhY7dJNpBSb9hzpWX6ZoWWaIAeweLA1uoGNYk
	h8KCjApCxeVRSOC3El1NrUl5NwS629XQ5RbWsmTVrAUz3qgWB0GSOBspBPOo2HNgJha6w2lrCy+
	nV5iMyihburpt2p/vv6iw9MN2MkKgacZi4/AwVfnDyG86bb0QO
X-Received: by 2002:a05:600c:5291:b0:489:32b:ac0b with SMTP id 5b1f17b1804b1-48e52285af1mr34914935e9.6.1778060796440;
        Wed, 06 May 2026 02:46:36 -0700 (PDT)
Received: from localhost.localdomain ([196.235.155.85])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e538a517bsm37354135e9.4.2026.05.06.02.46.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 02:46:35 -0700 (PDT)
From: Salah Triki <salah.triki@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Salah Triki <salah.triki@gmail.com>
Subject: [PATCH v4] iio: humidity: ens210: Fix missing I2C functionality checks
Date: Wed,  6 May 2026 10:46:29 +0100
Message-ID: <20260506094629.8999-1-salah.triki@gmail.com>
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

 drivers/iio/humidity/ens210.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/humidity/ens210.c b/drivers/iio/humidity/ens210.c
index 77418d97f30d..96076b0391a7 100644
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
+	    !i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_EMUL)) {
 		return dev_err_probe(&client->dev, -EOPNOTSUPP,
 			"adapter does not support some i2c transactions\n");
 	}
-- 
2.43.0

