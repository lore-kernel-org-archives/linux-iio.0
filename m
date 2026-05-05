Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73AC321018A
	for <linux-iio@vger.kernel.org>; Tue,  5 May 2026 09:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777971776; cv=none; b=N6tS8UNhUQz+3A6n2ytnqBijjfHXmPtLfVWUZpJRhMTXS8aEYanHYQahT5zOWe864uc4jbqhH/8zR17Ex7hpo7slQf4V5WagO6j8FvTz5YAvvmLw4l2Doo/jSIsZ3yBiltLepcS2Zr7PZiThyhbeofp0vtffzc9esSlkmMcjAyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777971776; c=relaxed/simple;
	bh=lsMotbbmjRTSAnTSuiqgbvDO+1BFLTUtvyaJVAE3KZM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LPXuddZcUUMTvAyrKf8HKDRY3Wjq74xrNJG3k7Dm4X8w+VXbaIi19NHE2d1NcRAk+SKcMtoOsP3bNu23QXrkCoeiX48bciZd8SbFk570U+VqywYkpPG4t6oa33/igPp42MdpfUnaFnBh4qZ54aArDaW5aCrrTt8MdAGxzoM3BaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nijqaXE8; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nijqaXE8"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-bc2301be8ecso304273566b.3
        for <linux-iio@vger.kernel.org>; Tue, 05 May 2026 02:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777971774; x=1778576574; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ccyLV26D7zYbN2fFdWu3DrAeub8S6U6KL3Fci4tQRyM=;
        b=nijqaXE8f7ezdGzhmHsnxFcgQcc8UybgzEaLcHzoeOOSk+2CiBAKja46vXq0ManSVR
         EEHrNc7oUXJlFEviUq8wNX8815AkvFpHtiHkm82VAXZHQEo4itGu38XiPvfh5sqvbiyW
         ZaQk0c/ALNgM+AmWwZYkmacFSimb/KP3BVtBJS8fZTlEw/5zzrXzhkWCyNHg64dDllJE
         09kPCgTXnUqjfP/rD3/lSpjm9ZnIqT6GCaluZU0i08y4/Y2XedS6vQCxixnvOkaZEHNc
         NqAoxboyexI4GRlSeRSC+IlBWrBl7qrbc37btMyieEAWef3MAleV5lAzAwAwh2+o/5WH
         6LTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777971774; x=1778576574;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ccyLV26D7zYbN2fFdWu3DrAeub8S6U6KL3Fci4tQRyM=;
        b=gGCyKWbSgOTD8hbyo3wRHsSnwmOr5xy+fQ8qmUDBtNLIKR9DrKrWehaokDLnmcz2eG
         M7L0EhaJ47pf+AKYtAuVr5qTWYRo/ggz9/TdMZ8xDDdAQE+nwYaPrbDpsleayGLipmXg
         FRIvqqTIEzfq9Sh72Orl24mC7So60Kz/pzVV3vVeoWuoyFVygRgw2da0EZkVsE68rOre
         8kFfiJDteGeT38NwP14Zxxoh53S3ga24j0Yi5Qd3s22h47Na4ecXmWvYIZkEnZoTuvO7
         Hl5RWogJ/lL4nqAbSlyFDHvzhE/Xr9ISPyWTtne1r/9ZBw5Q4OZktHwmQXqBXhbWc9dL
         jh6A==
X-Gm-Message-State: AOJu0YxFYCskXmlAawMJaDtWtg98MEY+rL3C0i695NjQFxNuiCexytoN
	Gszi9d2ugFJyqPE1kZIhBMxizGOfVDzmTr9bIThtT3ooWvFH4nsh6tJY
X-Gm-Gg: AeBDieuDFialui4pD6FkgOOnCL3SFgBZ12N9BJ03APt0Yl13ksYn1Qd1TiGQjG8Xs+O
	Mfsfa8ZIbiZDnCJE5lDt5KajrQnodWHMAmuvzbpzNJt1ope0HpNTHpzN/x77e1n6cPWunxrOaOS
	ekuPkion15nMH/D2mHQgO4SVqstPUb8/KddEt4pQfwS+gktNzvbYjULwLnm/Vbf1juv9ve5db7Y
	zncBoao/uoTmjYjLRk4SHRvJ7ZEaV1GVwvmHv1odPOaDkB1BBQkz/csCK2VLldRQoA80cnuyU2H
	RWpU6arIaCnj9rSBOUjbdXbKVV2c/ZC++7Via25J9FwXYTgJWoQWhqpYzslVDnAnr9J+bPYRIDg
	lmfL2XkYLAwUbUdwe0m8eWN3P/aMXrrndOFDwmnACoqzks24Cp35C93DRqZbLg5AiwA29BHjFGN
	haD7gfV7jaUfGgWWCEsE1BYuJQl1tvWS+YavT1PY+PQ3DGacJK
X-Received: by 2002:a17:907:74c:b0:bc2:d65b:5a9c with SMTP id a640c23a62f3a-bc40f43878emr102409066b.1.1777971773370;
        Tue, 05 May 2026 02:02:53 -0700 (PDT)
Received: from localhost.localdomain ([196.235.252.38])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bc1dd343108sm216136366b.63.2026.05.05.02.02.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 02:02:52 -0700 (PDT)
From: Salah Triki <salah.triki@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Salah Triki <salah.triki@gmail.com>
Subject: [PATCH] iio: humidity: ens210: Fix missing I2C functionality checks
Date: Tue,  5 May 2026 10:02:47 +0100
Message-ID: <20260505090247.74555-1-salah.triki@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ENS210 driver uses both `i2c_smbus_read_byte_data()` and
`i2c_smbus_read_word_data()` during the read and probe phases.
However, `i2c_check_functionality()` was only checking for block reads
and simple byte writes, which could lead to hardware interface
incompatibilities or errors on certain adapters that do not natively
support SMBus word or byte data transactions.

Add `I2C_FUNC_SMBUS_READ_BYTE_DATA` and `I2C_FUNC_SMBUS_READ_WORD_DATA`
to the functionality check mask to ensure the adapter supports the
required operations before communication begins.

Fixes: c524fbca672e ("iio: humidity: Add support for ENS210")
Signed-off-by: Salah Triki <salah.triki@gmail.com>
---
 drivers/iio/humidity/ens210.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/humidity/ens210.c b/drivers/iio/humidity/ens210.c
index 77418d97f30d..e8633f247b10 100644
--- a/drivers/iio/humidity/ens210.c
+++ b/drivers/iio/humidity/ens210.c
@@ -204,6 +204,8 @@ static int ens210_probe(struct i2c_client *client)
 	if (!i2c_check_functionality(client->adapter,
 				     I2C_FUNC_SMBUS_WRITE_BYTE_DATA |
 				     I2C_FUNC_SMBUS_WRITE_BYTE |
+				     I2C_FUNC_SMBUS_READ_BYTE_DATA |
+				     I2C_FUNC_SMBUS_READ_WORD_DATA |
 				     I2C_FUNC_SMBUS_READ_I2C_BLOCK)) {
 		return dev_err_probe(&client->dev, -EOPNOTSUPP,
 			"adapter does not support some i2c transactions\n");
-- 
2.43.0

