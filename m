Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B368632F759
	for <linux-iio@vger.kernel.org>; Sat, 14 Mar 2026 17:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773508042; cv=none; b=bx5TUDAWBpp7taqwN13f3/hujS0C8xXlx/DFShkKqha8GPsCEW6sX/Lu85x45qPdB6qfEtQP+QU24zzvm45qA/50UGxWAYWd1zNQzCZukqvDIFtQI+bb8n6ojvmgMMdbZgr6SwlFsIjgxwVyosmrT0mT6Qqn8ZyX+fGABOSL+/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773508042; c=relaxed/simple;
	bh=ZMGQz8p+WMx9gntwb21iw9j21CSaitzQfChDCBCMzLY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bQvd+t0OwMymGvAnfay+B7+H0qDgh3DyPpr2mQ/dvEpOS4asz4svUuv2awddlnSrYij10ZVsnkO9LUmXCCBLG+fydvvhPFWto42vAxjqshC6Fs8GN4n9qzIqCsPr9/Aptgkc72qsPnFJdMP882+KnZd4pdtRDnN/qeGzUAa3SmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UNV6huM9; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UNV6huM9"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-35a09e0dd63so3420019a91.3
        for <linux-iio@vger.kernel.org>; Sat, 14 Mar 2026 10:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773508041; x=1774112841; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w1PBY/NwbNLWWh1/jD23nm9avcwnxhc3WMg+rhw5oy8=;
        b=UNV6huM93WT9PD5iKGfsD6QbyTzQmLb9BFWtUfDhSXKV94YvEFZopEoRwdzFmXXDC8
         Lb/h6xaokzO8wy9Z3L4jInZ/K7x03iQoIhUcenEZT3J0qEvAB1eaYjvP9eYkS5udKDgJ
         AAwMAuickiF3hAxgUyp0WnA1Ezd46eqAh9pQLcFxxgyF4A00NRZl441v2vkwdEkfthMJ
         5z4LcRBgUASEAjmndfMo4mUNhZMumiKsOx5bziiUJsAN1UyoUZmKr7E9dAxaS32t2SbY
         ESdhxnbdwcFvDtf3DD8LGQh/B/t38roAt84e8P7GPhSxYD+08OcjRSWgks0nCrl4/NjS
         L9Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773508041; x=1774112841;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=w1PBY/NwbNLWWh1/jD23nm9avcwnxhc3WMg+rhw5oy8=;
        b=HFNdOzy4Zbmt2P8mRMLhkWZ77E8BUj5ht9E+QqfsMfc+0G79rmbHMP+6LoLDzWDzWF
         iv0WVslroicIfjqH2dLagUsEQj4Hylio/Tv8bhDixLCSSfFJWzmtB8LYxHLkl0RN4TXM
         9yl9zRUlTuWvQPUOuObtJuEyOgvHa19uOdRmUytDydpPfyTFMaeYlrUQ/2Ubd4BKplc7
         Q1/JvfypRAiRK/IV3LkjXXSUAndkH9H2f/o4c8HHvoBbebUh4SeQaAZzZCWVTqy5WSH2
         WcrtRnDhx3tjz0qDCYvpr5hLn6iykToz8r6JDDiALM5/o9MGI6PgaHqZ2lXKKi3qpvg0
         sLgw==
X-Gm-Message-State: AOJu0YzIrmk72wp+H1YrEG+mehMcDFSAOSztnZPRGL2/14XnhD5pr5y8
	Tx6UVM88jm1N7rjEyNZv+nHE8Vh9e75rltirq0Z3QZqRH9Iz+zqWO6Y4
X-Gm-Gg: ATEYQzyVyl2KGr6+1k6EixW3RwyK3cTscTVKoqNkm4Cvw6IyNsgCKV0ZKeaDuKBG/Xi
	rR5fItF/1BpSoqDT9UB8HkvAIGRkCPr4iSPVIyRGZDTWS+lWKFGtDX4yEdcMthTEC0byAnMhyh8
	8DSf1py53C0eEQtrclIcTx7YI4ZXwAk77WF7lROcd8QbrYbSE7dFUB+IZ/inVhTzeMKORZdoebq
	02+gTDO5rqzCgG/U5IKr7HxBrSovf5ESV7F75bbCXZD6NiUFP5Fc/zU0M+Q4J53Q3Le4eXIflbQ
	GeIBSjQcnE+o6B8RBC5ZNC/RWg9hoqICW4eb2fLXEkzLVWlTuonY+wyx3dtvnZPDACpyIGqffFE
	siVuV+vu7Q8dCoCebARqXx/ME3kaXBaXU+sgurmuywvMeWe4Cbn7CZy7G/TM3aTNfziwsoCgeMU
	s9CrEW1r6FvkO9YHdDUQn1/MAAXG3PMKrWxQKuaTbM+uBsxd/S79StEioRdL5608W5av0LprA9e
	jdCBhgRv/JaciG6xOwGjOiDyy0=
X-Received: by 2002:a17:90a:e710:b0:343:7714:4ca8 with SMTP id 98e67ed59e1d1-35a21f21635mr7388738a91.15.1773508040966;
        Sat, 14 Mar 2026 10:07:20 -0700 (PDT)
Received: from fedora ([2401:4900:8898:a35f:15b4:3058:14c8:4287])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35b90d3f572sm1600116a91.14.2026.03.14.10.07.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2026 10:07:20 -0700 (PDT)
From: Rajveer Chaudhari <rajveer.chaudhari.linux@gmail.com>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	waqar.hameed@axis.com,
	linusw@kernel.org,
	sakari.ailus@linux.intel.com,
	harshit.m.mogalapalli@oracle.com,
	antoniu.miclaus@analog.com,
	andrew.ijano@gmail.com
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rajveer Chaudhari <rajveer.chaudhari.linux@gmail.com>
Subject: [PATCH v4 4/8] iio: accel: mma8452: convert to guard(mutex)
Date: Sat, 14 Mar 2026 22:36:05 +0530
Message-ID: <20260314170609.26827-5-rajveer.chaudhari.linux@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260314170609.26827-1-rajveer.chaudhari.linux@gmail.com>
References: <20260314170609.26827-1-rajveer.chaudhari.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace manual mutex_lock/mutex_unlock pair with guard(mutex) in
mma8452_change_config(). This ensures the mutex is
released on all return paths and allows returning directly
without a goto label.

Signed-off-by: Rajveer Chaudhari <rajveer.chaudhari.linux@gmail.com>
---
v4: No changes

v3 : No changes

v2 : Dropped Header alignment change
---
 drivers/iio/accel/mma8452.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index 79ee4dff0ff6..16d9124b844c 100644
--- a/drivers/iio/accel/mma8452.c
+++ b/drivers/iio/accel/mma8452.c
@@ -599,36 +599,30 @@ static int mma8452_change_config(struct mma8452_data *data, u8 reg, u8 val)
 	int ret;
 	int is_active;
 
-	mutex_lock(&data->lock);
+	guard(mutex)(&data->lock);
 
 	is_active = mma8452_is_active(data);
-	if (is_active < 0) {
-		ret = is_active;
-		goto fail;
-	}
+	if (is_active < 0)
+		return is_active;
 
 	/* config can only be changed when in standby */
 	if (is_active > 0) {
 		ret = mma8452_standby(data);
 		if (ret < 0)
-			goto fail;
+			return ret;
 	}
 
 	ret = i2c_smbus_write_byte_data(data->client, reg, val);
 	if (ret < 0)
-		goto fail;
+		return ret;
 
 	if (is_active > 0) {
 		ret = mma8452_active(data);
 		if (ret < 0)
-			goto fail;
+			return ret;
 	}
 
-	ret = 0;
-fail:
-	mutex_unlock(&data->lock);
-
-	return ret;
+	return 0;
 }
 
 static int mma8452_set_power_mode(struct mma8452_data *data, u8 mode)
-- 
2.53.0

