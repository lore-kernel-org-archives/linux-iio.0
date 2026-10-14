Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC1D54489C
	for <linux-iio@vger.kernel.org>; Wed, 14 Oct 2026 14:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791987432; cv=none; b=Xw27uw1NW5v3+k1Yymul63lJlqq0Qp5XkRUjZW0GLORLcxAaxiLjVyh/+Tp6wNlZgRorn+j6CMClsEFzjqZqbRTxe+h1vnluO58GT6Os9Y15HBJ3Lqp42wjQqyTaD+wIxIBm3aG05uMElvG/FzVk8xUmYmDg9VnfHAqtYOu4tMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791987432; c=relaxed/simple;
	bh=OOkdmqql5ivD7BOlMPIdoD2no1rpPRTLcZbf1MNCcuY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TvOokgbahRU+h1rc+CRH4/sYiURyoD63cOnSu7pBBPk1JoDLLTY6fBfvLPl86vOGTGK6dJmmlsXAUV6/IA1EINkevMSIQg8XtutF0I/sU2sixKQI9EUgim2QWZQrBHhYsqDYzXYpfPk120TeqYm89FC9137d7V72Z/nmPXCG1x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KFQcc0DL; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KFQcc0DL"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-48c4d870d54so2642465f8f.2
        for <linux-iio@vger.kernel.org>; Wed, 14 Oct 2026 07:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791987428; x=1792592228; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Yv5zrfskyNh0rkbAfPLmCrc3ua1VmeTBEU0wOk/Cvk0=;
        b=KFQcc0DLIMK+l70RdvVtEMmJ50RU6bIc8IFJ8WPo+ho7cdQAuxdTZvOjEax0NmgzQF
         eL56pYnHA1s2suFnAy89WimKjk+6bNERNPBkz3hrsmn7uSQteE2Db47tdDTp6gQMoTn4
         G3v3ytTpRZhh88o9QLm4MDBLxjTFAooYDOobNf6D7FZNO/Dz3aX7uNSEnzinC+kqMskA
         5HYIdi3WVv1780dbHVEkF9n1uDvGYZ2ecCvM0xNN6x6/xUHkKZCZmwvuAXaiCBXvyn+s
         EzzXu2j+hOBN7whM2NFcIUAhcJ0X4k64cJCJH1rPgNSMVyS8qUvMC6AePLX8ngRniRQz
         ikHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791987428; x=1792592228;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Yv5zrfskyNh0rkbAfPLmCrc3ua1VmeTBEU0wOk/Cvk0=;
        b=1zkiKHH0z+Jv48R/hTTqG6Z5KQgRKuLNjJhb1A4Hj6qvlOgj/v+66VRJ3KCTIoIzSp
         UMZ6IOg3cNQNdqpLgZ+6MPalkYOJeD+anW78dHPwSftLHRrHkhAixZFrJIa5Vh2azMsm
         4wUF5+x47dG0GLCidAUPUe7Ho+DrlYSiArqgzZSTLHUxQvfblJggyqoaxi5XhH/XsodQ
         3g4XHlWmChhooODF5eMEbxz4FDazm9TqwZzWXcEx/7Y+b46iLmdu23z3yOoBtXc5n5ZV
         H1w8X5nBDUydO+iU4q0DIldRqnU5TDAj5Rp3+enlzmzh4xUpqGTtrUKceIA9D6Ij6ZJN
         3N2g==
X-Forwarded-Encrypted: i=1; AKwUvBydEN/trxs7/voUQf+6vlavLtTOrFZ5mqllAjiwsk21EbhnzKQny4mltHAinmWezGUHHq1bTP8J9ik=@vger.kernel.org
X-Gm-Message-State: AFq9FYKap1z5MH5TpMUOPFhi1Fuf6N77Z8av/haLA4aHRFRXkVU2B9mV
	LHzQMm+4BUVbKrTlYQ2+Kpmi2t1i58uVuZdRvmWmMcq3jLB0u0OENMch
X-Gm-Gg: AYBFou2TzvzqRpZghCSVZWaESMRWCBY4W9Cbu1oFC96R8Wl82SNhxo+1QK7qTgmdJ8C
	nw5xi72y/fEhtWUtAUyrMa/7uTPz2bEKiBMmbQkBOFUj4e8wZUvKtE3GMYTFxLW0w/+eRFZrBZq
	GcE8rNkp+WMtPD2cVVTqCI1uOWIOw22QmRbQ6yveahN1rsuLNFnbEF+soJ2AHkjNxIHDbcnxFWz
	ZMJ78GfjalR+72M31XclRiZCPFpblqMMUoR+h+LCkvx8Y6pVhYJ4xDVUGqhmkqKib7one6NfHXU
	a0ZeMIjeh2AXqMayTyXGyGIguju0eTOcIiIZ/pAD2HfgE4BZdW9J0nv+PT7/5NYBSoJWUFtXk5I
	7uKoPLVZumBlPLBT7eSjaml9vPxqHnqGgTnHUxzyKQq9DzmeFnXHeVpsspSqFepKQIRRvJhKTL+
	U+M6mjs4uxOeCK90cCrPKaf3NjEAuJhpzxLWtSg2PTd/hplgXtrK6VBQCCYHlnr04fzzI=
X-Received: by 2002:a5d:5a4c:0:b0:48c:4f94:222f with SMTP id ffacd0b85a97d-48dbaadec24mr24420936f8f.17.1791987428340;
        Wed, 14 Oct 2026 07:17:08 -0700 (PDT)
Received: from localhost ([2a02:8308:b092:fd00:d20:6232:49ca:4be9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0514ab1sm16082175f8f.0.2026.10.14.07.17.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 07:17:07 -0700 (PDT)
From: Jan Remes <ciakval@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Joe Sandom <joe.g.sandom@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	martin.triska@mycroftmind.com,
	Jan Remes <jan.remes@mycroftmind.com>
Subject: [PATCH v2 2/4] iio: light: tsl2591: add I2C device ID table
Date: Wed, 14 Oct 2026 16:16:48 +0200
Message-ID: <20261014141650.259929-3-ciakval@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261014141650.259929-1-ciakval@gmail.com>
References: <20261014141650.259929-1-ciakval@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jan Remes <jan.remes@mycroftmind.com>

The TSL2591 has only the device-tree matching table, so it cannot be
probed on a kernel with CONFIG_OF disabled.

Add I2C device ID table so that the sensor can be probed.

Signed-off-by: Jan Remes <jan.remes@mycroftmind.com>
---
 drivers/iio/light/tsl2591.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/iio/light/tsl2591.c b/drivers/iio/light/tsl2591.c
index f56d31404c25..8cfce720efb9 100644
--- a/drivers/iio/light/tsl2591.c
+++ b/drivers/iio/light/tsl2591.c
@@ -1149,7 +1149,14 @@ static const struct of_device_id tsl2591_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, tsl2591_of_match);
 
+static const struct i2c_device_id tsl2591_id[] = {
+	{ .name = "tsl2591" },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, tsl2591_id);
+
 static struct i2c_driver tsl2591_driver = {
+	.id_table = tsl2591_id,
 	.driver = {
 		.name = "tsl2591",
 		.pm = pm_ptr(&tsl2591_pm_ops),
-- 
2.53.0

