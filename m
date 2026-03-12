Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62DF33A6F7
	for <linux-iio@vger.kernel.org>; Thu, 12 Mar 2026 08:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773303625; cv=none; b=WgezeGyU0Dlh5ZA/1QayBfnt3q+KUmV6LES37+hXGic6Q3dBCZTLRyEMM1bCV9tfkGgSW5UFmyyHnO5kNJD3tKHhoM8QKsUgJFQ8efEuopEWVA8VV4SgaYc/WW/siSvymY4FV0tPUYUWn09PPtxrm7/J0Rsj5NM3xRPmW7CK18w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773303625; c=relaxed/simple;
	bh=ou3lbyq4fDZg+GSVSfhDp3gj9+aEBNAHHddZXTYBnG4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q/gh19r3u3RAmZhjUqvXwvJmtzkDRLkqxdWmwBK3jq+Q3uyk096wQ4vC4Hxsv4YlcQsXPkcgc/ZzYpyQM4PeBb29D3Te7TtXUrkOEMXW8dkATqVDkpPgtYNDt5iu7YrlVoaVnvqOgc9fc0IxKZz89hF8RaXgHf+y7XeGUdRTaPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eXc+vijq; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eXc+vijq"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2ae4d48dc2fso3991785ad.3
        for <linux-iio@vger.kernel.org>; Thu, 12 Mar 2026 01:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773303623; x=1773908423; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UY+BDJIyA8NSf40uEDoQLKUGXr4A905L63hTXYyoJv0=;
        b=eXc+vijqqGgrzxngjrmQD/SsbN52lq7SQOVc70fhzJKXURlwVb8IlRDOBmT0z0H8NQ
         Uk9axJvyz9DnO6GhRVglJ5hALkCqiZBJGUKadZUUDUMetPRQmQu08+F10E3/42DGeg2J
         zdwfpM1O5RvXe65J2mO4+/JwZAR/hVuTu8MYxnyG8qGluFxUq8Ns4obPH0N3DiWGyaui
         LpEWeIKeHkW/S4SX408ky1QUHbYRV6h/QOQPUW9mmiXdWglKcTJ8o9GHmn0fkfjMzKpT
         ymmctzF/aIR/m8EDOsqn8U2O0zoQcG4ujTNJnCxQqbCE0+pVw+abSjLimdAnYj+4R3Gm
         4aeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773303623; x=1773908423;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UY+BDJIyA8NSf40uEDoQLKUGXr4A905L63hTXYyoJv0=;
        b=nkXH+rKyXLJaaPtxCMztlavn/HWNsD3oAWrBcycac19475LZDHTqhIxfB1W6QizTEX
         hAYBcsvWElzWirCAODtGVhz1Eza33EEELf07qdhHVCA2uUStFStXn4MH3KERPXFpMkzo
         YdxcqsfPqlT+D3jFUlHdA4ciFsBroWUXUy3sBjR+4gLkZwlKHmi+N9jaHfN6Ip5reqTH
         QzVJF7/1nHkIDShTEUplCvSEdUCSTySbkgBE91G9ZfNIUxqUB+pffY7XM6d8+1VRTtqA
         /vm3pjsX3YFMKFw4FFHqlhqOe1ddZwCModSi7nnLUuck8Bo+d4a6ZWPoEzIIUBxFhNhc
         o5jQ==
X-Gm-Message-State: AOJu0YwQERx5/JqjvXwhZMQR7OEVHBbsWUc82aE8uonRXQvoFcJRJ5kY
	bbjkkg1zRpfgTB6IWs9PwKPHKz42f4y8Ty4RtOt9zYLHvFZNGpWuswBv
X-Gm-Gg: ATEYQzwZPIl76DhMs820b7uhNI2bUAsWxB1Rua1Q54H8nYWJfsMI/O3hhP7bb91fgRr
	gyVBgmVOInan+lSlpO+YvWmCx5QZ1dtTPRghRVBT4Id6pPz7R7/TW6BDwGAnE3tYyzmIVd8G1z8
	8i4Zxa7f27xGVIGmDtwnxY+c/gw7hze2VsVvMv+rUU4ln5FyzG3MUmTKvlKi66vDfkxxqX17Row
	y0SiqWingzWF2nmKxeZtLx4M76P7tpfay+z2xHCLZhq8WQ8vlUD8ALO02iWAtnxUM6dWp9xX/l9
	l1H8tPLoUsvZB8OUWDoK+WLHM/gaPl6iMj/dLzIOj2KjLJxTBdpCWMCIV0fFDHs3Jhcky+SgOUR
	YjUq7b6eYhHdYA8mBU0NM4hzXcRVnlQ10IYGCzq7kEd72chPeyezgODHBqW2X/hdo1ads+NusyW
	gWc68CYxAKd0S0G5u0pyb2oSQG4xegQT2l3iVq9JbsDq9cDEA/Z0HA+e2VOk3h384VV+hiYzj3/
	tHSdRBlF+Ce24KpJ01IA38=
X-Received: by 2002:a17:903:2f8d:b0:2ae:5a28:cbac with SMTP id d9443c01a7336-2aeae85a65dmr53352415ad.32.1773303623161;
        Thu, 12 Mar 2026 01:20:23 -0700 (PDT)
Received: from fedora ([103.92.106.30])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aeae24a91dsm64388905ad.31.2026.03.12.01.20.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 01:20:22 -0700 (PDT)
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
Subject: [PATCH v3 2/4] iio: accel: mma8452: convert to guard(mutex)
Date: Thu, 12 Mar 2026 13:49:40 +0530
Message-ID: <20260312081942.23858-3-rajveer.chaudhari.linux@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260312081942.23858-1-rajveer.chaudhari.linux@gmail.com>
References: <20260312081942.23858-1-rajveer.chaudhari.linux@gmail.com>
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
v3 : No changes

v2 : Dropped Header alignment change
---
 drivers/iio/accel/mma8452.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index 15172ba2972c..09bb205a1b8f 100644
--- a/drivers/iio/accel/mma8452.c
+++ b/drivers/iio/accel/mma8452.c
@@ -20,6 +20,7 @@
 
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
+#include <linux/cleanup.h>
 #include <linux/property.h>
 #include <linux/i2c.h>
 #include <linux/iio/iio.h>
@@ -597,36 +598,30 @@ static int mma8452_change_config(struct mma8452_data *data, u8 reg, u8 val)
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

