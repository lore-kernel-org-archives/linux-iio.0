Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86CDD3431F5
	for <linux-iio@vger.kernel.org>; Thu, 16 Apr 2026 05:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776316609; cv=none; b=BR6gOUybksZZKVY5fZHelkqigMsVSl7rxCcYVfTxI3PBU3kBakN+m+q+h5BhuGkivMhgtWcV4wzUOiTZrDRQscbfPiSmvSAXAfwXDdvLMVd5jt7DB1QbxNqFnfSIDMiKzlxanKUWt3Mt85kaZvUEEsFcgRRQSzezecJFy7h3dqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776316609; c=relaxed/simple;
	bh=FFZmniEpXwsrQ1vNjMsgYBZ+a3Q+z4kV35DPxd9LecA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F3ZbX2TDDFwFLZGo2w2MiBviexqmA1IBhu+IkV7tk+okThoKDXLSsCelNWd2VEIzxeiFCmn4PM7YoNt0kspaWNbWug0me8GW27tH6Vu/fqSAqRBdw6nQ6pHwJQNgQg2CQcrWc1oqtV5ypy+/5sFHkm2JT0DeP/2nl7oETEwqLmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lTlA/Hp+; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lTlA/Hp+"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-82f1bfc9b8fso2442076b3a.1
        for <linux-iio@vger.kernel.org>; Wed, 15 Apr 2026 22:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776316604; x=1776921404; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OxKsrQZx4v2ys1oBNmQpkI/HqcWlRIelbmWCZdVWEfA=;
        b=lTlA/Hp+kRK7TnxupabAyAkxutTGMVj2nZ2gc5xFXZFrzh3YmQ15NI0aTfKLBXagvz
         +tOqqwF+qYvMwDObvpDQMwfu5EaxgqWVKuAz95CNQ18DqaZVejomnIJyiAmfPaPm3koi
         V/OqjUCFVOc3G9TSuBQVRXQlGahAs9aGNnGKblIGtTGU8lHCWs8uMVHdover7LCfHygg
         I1SmM8AexkNRYC3GAWftjCcJQZe/4/u4D4hERF+RlOBh3A1Bcu8Kxe1z7S874kePOUhn
         tnflfuki3I5Qn1jj78mkS7cgc7zziUSV7tqAsQEGhHGeY+Fk+piX1k7CcpJVIiJPLI37
         MShA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776316604; x=1776921404;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OxKsrQZx4v2ys1oBNmQpkI/HqcWlRIelbmWCZdVWEfA=;
        b=EqRLLdCf5aVmRkVABtI2GBCrMsLQL3YEyYbafqNmFBMJdkjP1mxluU7CYwNqUKCAyV
         x75qEaQYWDCfgQAmAVajbjXL3Gwe24lGoKyrLpoP8MH2LE6efxr58H9EM8wLV9NyQhd3
         Ue6y5T9RvdNMIIkEaccoUpu3jYdX4UJ2DbIae/+TJG+rlB43om3KhKvNoS/96gfSlqXC
         lHZqQL8bQLjYLzP8nq6FkJqn5x/yP9qY0f7OcAHxLwpMAYw2njeQfCzq1NzbLGbJwRbS
         BfZ0plFFjbrOsd027nz9uYi5cVLAIQHR+l3fMWleye4l58mtCss1qKZYzy49ni0jybIZ
         7wVg==
X-Forwarded-Encrypted: i=1; AFNElJ9A4J4QOPYvuPlnT4i4q4qkPJEK7TPbNztLRY9oTESeE5A02d4zU/kw31HmT+JJ96Jw6YvXJW+1VWY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzkgv2pdMo8AKE/FSTP0C5gZWiN3WdLAgZC8gNU1YEjSOOaNMZ8
	K7JpMVmIOaKD3sENNINBVbmy/DvQnfUabmBKvMS0qdkNMNS052OyPDZd
X-Gm-Gg: AeBDies2cJL5ixeRUYwg+HCCfR0uVuzrSZ7agSyKwLL5SSdLb2KZv+4rXVb1XOoaIMk
	Z6fsUoft++TAeYDgompEeFV0jXqSIumD1dn5jaLD7zBxTOtrqxkJZvBvbMQ/HXLPZxIhs5Fwuas
	Knq2512E3+2GwySHTQ/NpCzKNaZVP4tIbtJwyNrhVvWPdlErvyGQ2Fcb57sKIfUA5XTx1vAUrWB
	wBlDbriOPZ3/WMmIMCrf6OvzxkFI0JDvUH6eQaw5GVgREphfE7msn0zHBGfuWS2RauDxwqTbnnS
	DUohAfLiasrjsMNmXFYtPxoh/2Rp9tIiIJOmF1vYgDljgKX6HuLr5MD3UPqd9ghxH5/njIeWgji
	bUwjS6+zmzI8UZiD7e3UE3hW5RTPrIKlcoWSSJDI1qZ2SrXc1FOsyHUXBLI4AEGHTXFLiZIgQ81
	cKBazXo6TiaDx6UASd8BTsQ+EvHSXHiLtQ5iKIpMijNaWUewz8W9RlPMQoEEk=
X-Received: by 2002:a05:6a00:bd85:b0:82c:225e:63c5 with SMTP id d2e1a72fcca58-82f0c28198dmr24538738b3a.18.1776316604432;
        Wed, 15 Apr 2026 22:16:44 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f67476a5fsm3948364b3a.60.2026.04.15.22.16.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 22:16:44 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
To: lucas.p.stankus@gmail.com,
	lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] iio: accel: adxl313_core: use guard() to release mutex
Date: Thu, 16 Apr 2026 10:46:30 +0530
Message-Id: <20260416051631.551250-3-sanjayembedded@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260416051631.551250-1-sanjayembedded@gmail.com>
References: <20260416051631.551250-1-sanjayembedded@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sanjay Chitroda <sanjayembeddedse@gmail.com>

Replace explicit mutex_lock() and mutex_unlock() with the guard() macro
for cleaner and safer mutex handling.

Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
---
 drivers/iio/accel/adxl313_core.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/accel/adxl313_core.c b/drivers/iio/accel/adxl313_core.c
index 2ca4ce90cd86..339570701083 100644
--- a/drivers/iio/accel/adxl313_core.c
+++ b/drivers/iio/accel/adxl313_core.c
@@ -356,19 +356,15 @@ static int adxl313_read_axis(struct adxl313_data *data,
 {
 	int ret;
 
-	mutex_lock(&data->lock);
+	guard(mutex)(&data->lock);
 
 	ret = regmap_bulk_read(data->regmap,
 			       ADXL313_REG_DATA_AXIS(chan->address),
 			       &data->transf_buf, sizeof(data->transf_buf));
 	if (ret)
-		goto unlock_ret;
-
-	ret = le16_to_cpu(data->transf_buf);
+		return ret;
 
-unlock_ret:
-	mutex_unlock(&data->lock);
-	return ret;
+	return le16_to_cpu(data->transf_buf);
 }
 
 static int adxl313_read_freq_avail(struct iio_dev *indio_dev,
-- 
2.34.1

