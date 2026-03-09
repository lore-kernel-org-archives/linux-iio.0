Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3773D7D7E
	for <linux-iio@vger.kernel.org>; Mon,  9 Mar 2026 15:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773070488; cv=none; b=s5DQgFQXg1rN24Q79NKVW033roU9l5VPiMYtOJQjf2Y6wAwEwHSqldqQkj/zjq/iFGa0inuTO4dpZMXoyMyUfN7MsooQWZv8O+dRZ07S6tIM9rGJ7nptiw0XJAOvFU2hRSiQasnlkbac4UYv/F0BUQh3HVv8tip5Be95RNNMiuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773070488; c=relaxed/simple;
	bh=HGqw1CGl9UHWHkuaYJ5XBx19Rw+kwr2m6DgIvwtTuuc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZBwMHhu2ewZhRrR1vwjr9abOvdpwgtpn0cH5ZaWEyaUTrWUpIqqS2ttYR2ZDsXWejjRMDVO4pxP6IqyTqk3xYqo181rWK/Rkl8mVwa14KWYDiRQdvtwLU8IXRw1jQMU2/yuUWxe7cCLVXBdGVP3YlZitEp8lrQO4mbHttDBwaYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ngZUh4Oc; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ngZUh4Oc"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c70f91776fcso4943214a12.0
        for <linux-iio@vger.kernel.org>; Mon, 09 Mar 2026 08:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773070487; x=1773675287; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ndt3vIv2zGaRlQuL9zR0zjbGPoGP608g1cvLrbOVtFc=;
        b=ngZUh4OcyK6zcm3snFf7eMo9Su3q/tFX+kgiRtfmjDK7zRnhLGo+FHE1MZ6HGEU/Dj
         JOleJquYutiAT45cpV8Z3P/qm7j3gaYJ7+MS0vV3f1YddhhSXj3keRArBzmmXFqKmpZP
         j4lqbzcwYkP0fZyX4UJgDRHWkYrQ6isKMyA5vHOm8oudyI8wz1l1ISojT8TJ+93d+wKx
         hiJp9gQxhrmAIvw2LDraBo+fRyVTmyIxaa0DkKPehcfHvuqCj284/hDQco/hDj8d1yKi
         NZKoMHEgAtKbVFPXBgsBoQImVZNnixKaA0Z9lM9+4aBFOS8VMzQBObNnvkMeq6ljR648
         n/bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773070487; x=1773675287;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ndt3vIv2zGaRlQuL9zR0zjbGPoGP608g1cvLrbOVtFc=;
        b=eRm81tN5MI8z7hEE8HTZm3plePQxIc4vNdvLfzxq3X8m8abaRIgJiO9MSuy4LMJMU4
         f4Zxeu4rKD2/93VFZb63JaLjfjowvTTQCEZkFsx18bD8x87t8SceJr/X6+umAanm4xtO
         GdsIw6AOYMdAxqGamMZwG5HztZUF+76ymouOifaF/eilSo9SvAnXhHpRt6rFyw0AW9/Q
         MFw7tIXcny+zDC6T1zhGqo6jMsMiqvAw6wmhIxtccZ2MNK/F5i/gZ79rKOlSO+GF/Icr
         n+gb0SUbrTjFVlGNeu6Gd3+5HdNMbwZFRV9LTDT7ax/H0y77dePoPIx4B5x7Jszxmjwp
         LbIQ==
X-Gm-Message-State: AOJu0YyUuvTn0u4+rI5HWOKoJcuiaggBcCP+BtszvhpYCBA8swaKYmDt
	MCBfZ6Xcr4dHVsmFSwjEyjje2ZYBHofNWKfAgsVWJ/y/LYHvCVmYWCoRl5sTcg==
X-Gm-Gg: ATEYQzz/pJ1S9gS6h/e7V4Os+TbY3OLCHBJjMoSBhLcieO4t8CABwF07MPY0CPPI7LN
	amAhz2wrClP2mlpWatzccEViZdTan2NwEAHTGyTY6bNiL/1oUX9smSxezXqxnQvi5otAjZa1PQd
	blhB3wSm7Pnsdi8BBxYXMuPv4c0xhsagv60nDWM4Tys7QCy5G7+8b6drFNpPoyv5LVhcC7xThfc
	wlB5T/mLlXTbKqHOexGu2hVv6ut7s6ICKtglW3u9I9RdTNu/fH+N9bf3YZMOfCiSR5AnozKDaXa
	yk5TeC/7UbCBKXik+zEQrECoPBXCeLb8LGq33OwrkCzJnPr1y8w/4oNXjCw6xnlUfSarJKvCRaM
	6f94zC2CqGqrRQLaCkbAgoAxbKLLI73UnUQXYKSOmeZu45bGTRygMHUKlCs7ROdx/7kH1wNqDY2
	ZDS0XwRss9G+UGyDUbJKtBPQgcyQJGJG8zB84nqOtoavjiTe2OkbUEQRcK3MqpCShseU2InwlyH
	EeIYzE1tJREbjbisGe24VZDNfw=
X-Received: by 2002:a05:6a21:2293:b0:35f:4e9d:d28b with SMTP id adf61e73a8af0-39858fd8a8fmr10759904637.18.1773070486764;
        Mon, 09 Mar 2026 08:34:46 -0700 (PDT)
Received: from fedora ([2401:4900:1c80:20f6:77bf:3a75:33cb:748c])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c739e16cebbsm9316563a12.16.2026.03.09.08.34.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 08:34:46 -0700 (PDT)
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
Subject: [PATCH v2 2/4] iio: accel: mma8452: convert to guard(mutex)
Date: Mon,  9 Mar 2026 21:04:06 +0530
Message-ID: <20260309153408.71512-3-rajveer.chaudhari.linux@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309153408.71512-1-rajveer.chaudhari.linux@gmail.com>
References: <20260309153408.71512-1-rajveer.chaudhari.linux@gmail.com>
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

