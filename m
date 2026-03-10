Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87393E8C41
	for <linux-iio@vger.kernel.org>; Tue, 10 Mar 2026 20:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773173211; cv=none; b=dtKLK6MA9BHNdApwQxoNVFzZsc6HWbjh5idkf6ZBDgctxilafOwHgugP0bhBDMy12BIgQ1spaksIRi894vQL461aSGii0rNn2FPdWcY1w0pl8T8wpytfxdAirH5zz4i+o64maINKqFY3ji8xz6A3kJp8jj9r5A9mrW2SWkMtaio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773173211; c=relaxed/simple;
	bh=BAEAEao8zGcfEPk3ro9fqvnx7VdR1iceehL4mhJX3gE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CfmJHveS5rb4sR3Dcrt9O9QgMmTA9KTVvT+oeWepeamdViPcB9rHOfWh656/r56qA1Vrmi1gBs985iTrwR0+RNDgZd2fU7FbHErrEJCGfswiXBoCXZuyrhtRKG4YVnvZhwUFGzlDd3Cn4bhzM9aFV6WMZ8e+BAzVvXuEjvUR95w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EigOO2GA; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EigOO2GA"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-82735a41920so4945702b3a.2
        for <linux-iio@vger.kernel.org>; Tue, 10 Mar 2026 13:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773173209; x=1773778009; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=maRFdwFBItYsUxmd+9t8qBnRnOAkqFEhAXgbmQcZeFE=;
        b=EigOO2GAx+kVSZimumtEPDu4LKmq2DjuZInKvZEiWrNgyNxGtxYewUQpkhw5N857iF
         kRClGOzhUZJYqu3f0tJINcNxLx9pYBrOBIywdBeslV0fbKsAE2pABBtcN/JVV14IHsk5
         SE0lgBA1e9Ewj8hIzppr77j+AgdyRjkJYcEhRfhpTU3MMaNF11xTUquCaKk4oEWjb8Ik
         AKQ/Et6KMDWVWdM/7qfJA3gYRDCIsiDlg/WsWf3qMhMtrjwqsUKAbQPYfSOEYewfOdeO
         odJ3zuMoRbdENb0NlUBLZIhIngOPnnN/6Yu3tTL0b4CZsa+Iu+AazNCXAtBskxUFbvnj
         3lGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773173209; x=1773778009;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=maRFdwFBItYsUxmd+9t8qBnRnOAkqFEhAXgbmQcZeFE=;
        b=A5APCXEhsj1tAjWK5Wvyi6zcqCJrFnzoz+Qqh9f8IILq93muaKGKJ0+cACff4HR94P
         cobql3Zycd9CyiRwx9xMwj2sjoaD541/e6i3g5DjWHnpMCksJCO/bt/M6aB3QRrmbExJ
         noxSNN49lPEJ0iYHpRFIRA4+TyvdqBK69qB32CuWUzFwPPAs6Xw6wARx140up9NqPats
         ajpOe3y6IobeyUHekMI3K2cRKvSeNlr+XumbnH4ClqRvpJwtPDXasSu7aZak7KUxg67F
         BEB0JlfXyV/zQcBorGeNGrMLFRGiXr8AKblWUP7uRR6b0o1okhTQn45g5XXVbt4HTN4K
         uhSg==
X-Forwarded-Encrypted: i=1; AJvYcCUr/Tj1zNPzao5ZMKWNXvORx+ULzYy9w7HVYv9APZxq/48eBTcnbLPRBz2LrFczL+QWLs1CCYnPuv8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxqmt5ZIGYPC57BM6bLOvryv1m4wu3cYgW/l8M9zJYs94Vw2oS7
	Od+SXQnsSS9jAifGqi85Nu0uAR0FeZgBj8z1+tCx/AUktrrb5056WBey
X-Gm-Gg: ATEYQzyUEAohzrwZDuzZAYyULB1iZcu3Nju6pJikp9RWFcyRJBjvfnTZQjvjaiHlEov
	5BCYtbEHd8IKP5bJN2ErS6Kp3NIYOpE+dzsnJKSUHfvz26Q7HFonjSLPbLbTDkhpNkOPfkfUzeK
	WMugIQ5z+Ucu+jqeAcFm3T6E8AEJx4RbeWgnkPkdl/bpin3I1Jbd51b++UK6yEAcwZYAuazLEEf
	1UGcyL+YbYVVhKtj/KMq15j3Crr7GBohnb0q5H3wBxcLE2MIAxqqkxkuOMrbLmddVMimZSZdoqJ
	ReIwLab+5h9yPLogZyMmynOCPSbKjE/W0On4+ztukDTYzckjZ3FbGZfb6GeweAcYfYX5oeV/AfL
	dCSIE/aS4/7Con1UAWmgFZRy0oz1kTNUf6iNlVyk9mqkwVzWM0LXx0v9fxhC0VIdNemrJMXlUlz
	J+INdeUKziwqU3A+Q37jgNsx/URKKRPLl/4/LvJUBj6KQbJMNP
X-Received: by 2002:a05:6a00:ac0f:b0:829:7e6d:cf1f with SMTP id d2e1a72fcca58-829f721be36mr107593b3a.51.1773173209251;
        Tue, 10 Mar 2026 13:06:49 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829f6dc2d0asm101660b3a.13.2026.03.10.13.06.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 13:06:48 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
To: jic23@kernel.org,
	m.tretter@pengutronix.de,
	mchehab@kernel.org,
	p.zabel@pengutronix.de,
	tiffany.lin@mediatek.com,
	andrew-ct.chen@mediatek.com,
	yunfei.dong@mediatek.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	johan@kernel.org,
	elder@kernel.org,
	gregkh@linuxfoundation.org,
	pure.logic@nexus-software.ie
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	kernel@pengutronix.de,
	kees@kernel.org,
	nabijaczleweli@nabijaczleweli.xyz,
	marcelo.schmitt1@gmail.com,
	maudspierings@gocontroll.com,
	hverkuil+cisco@kernel.org,
	ribalda@chromium.org,
	straube.linux@gmail.com,
	dan.carpenter@linaro.org,
	lukagejak5@gmail.com,
	ethantidmore06@gmail.com,
	samasth.norway.ananda@oracle.com,
	karanja99erick@gmail.com,
	s9430939@naver.com,
	tglx@kernel.org,
	mingo@kernel.org,
	sun.jian.kdev@gmail.com,
	weibu@redadmin.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	greybus-dev@lists.linaro.org,
	linux-staging@lists.linux.dev,
	sanjayembeddedse@gmail.com,
	skhan@linuxfoundation.org
Subject: [PATCH 7/7] staging: rtl8723bs: simplify cleanup using __free
Date: Wed, 11 Mar 2026 01:35:13 +0530
Message-Id: <20260310200513.2162018-8-sanjayembedded@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260310200513.2162018-1-sanjayembedded@gmail.com>
References: <20260310200513.2162018-1-sanjayembedded@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sanjay Chitroda <sanjayembeddedse@gmail.com>

Replace manual cleanup logic with __free attribute from cleanup.h. This
removes explicit kfree() calls and simplifies the error handling paths.

No functional change intended for kmalloc().

Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
---
 .../staging/rtl8723bs/hal/rtl8723b_hal_init.c | 13 ++-----
 drivers/staging/rtl8723bs/hal/sdio_ops.c      | 37 ++++---------------
 2 files changed, 11 insertions(+), 39 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
index 8d259820f103..2badf7d1aec4 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
@@ -627,7 +627,6 @@ static void hal_ReadEFuse_WiFi(
 	u8 *pbuf
 )
 {
-	u8 *efuseTbl = NULL;
 	u16 eFuse_Addr = 0;
 	u8 offset, wden;
 	u8 efuseHeader, efuseExtHdr, efuseData;
@@ -640,7 +639,7 @@ static void hal_ReadEFuse_WiFi(
 	if ((_offset + _size_byte) > EFUSE_MAX_MAP_LEN)
 		return;
 
-	efuseTbl = kmalloc(EFUSE_MAX_MAP_LEN, GFP_ATOMIC);
+	u8 *efuseTbl __free(kfree) = kmalloc(EFUSE_MAX_MAP_LEN, GFP_ATOMIC);
 	if (!efuseTbl)
 		return;
 
@@ -702,8 +701,6 @@ static void hal_ReadEFuse_WiFi(
 
 	rtw_hal_set_hwreg(padapter, HW_VAR_EFUSE_BYTES, (u8 *)&used);
 	rtw_hal_set_hwreg(padapter, HW_VAR_EFUSE_USAGE, (u8 *)&efuse_usage);
-
-	kfree(efuseTbl);
 }
 
 static void hal_ReadEFuse_BT(
@@ -713,7 +710,6 @@ static void hal_ReadEFuse_BT(
 	u8 *pbuf
 )
 {
-	u8 *efuseTbl;
 	u8 bank;
 	u16 eFuse_Addr;
 	u8 efuseHeader, efuseExtHdr, efuseData;
@@ -728,7 +724,7 @@ static void hal_ReadEFuse_BT(
 	if ((_offset + _size_byte) > EFUSE_BT_MAP_LEN)
 		return;
 
-	efuseTbl = kmalloc(EFUSE_BT_MAP_LEN, GFP_ATOMIC);
+	u8 *efuseTbl __free(kfree) = kmalloc(EFUSE_BT_MAP_LEN, GFP_ATOMIC);
 	if (!efuseTbl)
 		return;
 
@@ -739,7 +735,7 @@ static void hal_ReadEFuse_BT(
 
 	for (bank = 1; bank < 3; bank++) { /*  8723b Max bake 0~2 */
 		if (hal_EfuseSwitchToBank(padapter, bank) == false)
-			goto exit;
+			return;
 
 		eFuse_Addr = 0;
 
@@ -804,9 +800,6 @@ static void hal_ReadEFuse_BT(
 
 	rtw_hal_set_hwreg(padapter, HW_VAR_EFUSE_BT_BYTES, (u8 *)&used);
 	rtw_hal_set_hwreg(padapter, HW_VAR_EFUSE_BT_USAGE, (u8 *)&efuse_usage);
-
-exit:
-	kfree(efuseTbl);
 }
 
 void Hal_ReadEFuse(
diff --git a/drivers/staging/rtl8723bs/hal/sdio_ops.c b/drivers/staging/rtl8723bs/hal/sdio_ops.c
index c9cb20c61a2b..303139a75551 100644
--- a/drivers/staging/rtl8723bs/hal/sdio_ops.c
+++ b/drivers/staging/rtl8723bs/hal/sdio_ops.c
@@ -179,9 +179,7 @@ static u32 sdio_read32(struct intf_hdl *intfhdl, u32 addr)
 	if (shift == 0) {
 		val = sd_read32(intfhdl, ftaddr, NULL);
 	} else {
-		u8 *tmpbuf;
-
-		tmpbuf = kmalloc(8, GFP_ATOMIC);
+		u8 *tmpbuf __free(kfree) = kmalloc(8, GFP_ATOMIC);
 		if (!tmpbuf)
 			return SDIO_ERR_VAL32;
 
@@ -189,8 +187,6 @@ static u32 sdio_read32(struct intf_hdl *intfhdl, u32 addr)
 		sd_read(intfhdl, ftaddr, 8, tmpbuf);
 		memcpy(&le_tmp, tmpbuf + shift, 4);
 		val = le32_to_cpu(le_tmp);
-
-		kfree(tmpbuf);
 	}
 	return val;
 }
@@ -223,19 +219,17 @@ static s32 sdio_readN(struct intf_hdl *intfhdl, u32 addr, u32 cnt, u8 *buf)
 	if (shift == 0) {
 		err = sd_read(intfhdl, ftaddr, cnt, buf);
 	} else {
-		u8 *tmpbuf;
 		u32 n;
 
 		ftaddr &= ~(u16)0x3;
 		n = cnt + shift;
-		tmpbuf = kmalloc(n, GFP_ATOMIC);
+		u8 *tmpbuf __free(kfree) = kmalloc(n, GFP_ATOMIC);
 		if (!tmpbuf)
 			return -ENOMEM;
 
 		err = sd_read(intfhdl, ftaddr, n, tmpbuf);
 		if (!err)
 			memcpy(buf, tmpbuf + shift, cnt);
-		kfree(tmpbuf);
 	}
 	return err;
 }
@@ -326,22 +320,18 @@ static s32 sdio_writeN(struct intf_hdl *intfhdl, u32 addr, u32 cnt, u8 *buf)
 	if (shift == 0) {
 		err = sd_write(intfhdl, ftaddr, cnt, buf);
 	} else {
-		u8 *tmpbuf;
 		u32 n;
 
 		ftaddr &= ~(u16)0x3;
 		n = cnt + shift;
-		tmpbuf = kmalloc(n, GFP_ATOMIC);
+		u8 *tmpbuf __free(kfree) = kmalloc(n, GFP_ATOMIC);
 		if (!tmpbuf)
 			return -ENOMEM;
 		err = sd_read(intfhdl, ftaddr, 4, tmpbuf);
-		if (err) {
-			kfree(tmpbuf);
+		if (err)
 			return err;
-		}
 		memcpy(tmpbuf + shift, buf, cnt);
 		err = sd_write(intfhdl, ftaddr, n, tmpbuf);
-		kfree(tmpbuf);
 	}
 	return err;
 }
@@ -491,7 +481,6 @@ static s32 _sdio_local_read(
 	struct intf_hdl *intfhdl;
 	u8 mac_pwr_ctrl_on;
 	s32 err;
-	u8 *tmpbuf;
 	u32 n;
 
 	intfhdl = &adapter->iopriv.intf;
@@ -503,7 +492,7 @@ static s32 _sdio_local_read(
 		return _sd_cmd52_read(intfhdl, addr, cnt, buf);
 
 	n = round_up(cnt, 4);
-	tmpbuf = kmalloc(n, GFP_ATOMIC);
+	u8 *tmpbuf __free(kfree) = kmalloc(n, GFP_ATOMIC);
 	if (!tmpbuf)
 		return -ENOMEM;
 
@@ -511,8 +500,6 @@ static s32 _sdio_local_read(
 	if (!err)
 		memcpy(buf, tmpbuf, cnt);
 
-	kfree(tmpbuf);
-
 	return err;
 }
 
@@ -529,7 +516,6 @@ s32 sdio_local_read(
 	struct intf_hdl *intfhdl;
 	u8 mac_pwr_ctrl_on;
 	s32 err;
-	u8 *tmpbuf;
 	u32 n;
 
 	intfhdl = &adapter->iopriv.intf;
@@ -544,7 +530,7 @@ s32 sdio_local_read(
 		return sd_cmd52_read(intfhdl, addr, cnt, buf);
 
 	n = round_up(cnt, 4);
-	tmpbuf = kmalloc(n, GFP_ATOMIC);
+	u8 *tmpbuf __free(kfree) = kmalloc(n, GFP_ATOMIC);
 	if (!tmpbuf)
 		return -ENOMEM;
 
@@ -552,8 +538,6 @@ s32 sdio_local_read(
 	if (!err)
 		memcpy(buf, tmpbuf, cnt);
 
-	kfree(tmpbuf);
-
 	return err;
 }
 
@@ -570,7 +554,6 @@ s32 sdio_local_write(
 	struct intf_hdl *intfhdl;
 	u8 mac_pwr_ctrl_on;
 	s32 err;
-	u8 *tmpbuf;
 
 	intfhdl = &adapter->iopriv.intf;
 
@@ -583,7 +566,7 @@ s32 sdio_local_write(
 	)
 		return sd_cmd52_write(intfhdl, addr, cnt, buf);
 
-	tmpbuf = kmalloc(cnt, GFP_ATOMIC);
+	u8 *tmpbuf __free(kfree) = kmalloc(cnt, GFP_ATOMIC);
 	if (!tmpbuf)
 		return -ENOMEM;
 
@@ -591,8 +574,6 @@ s32 sdio_local_write(
 
 	err = sd_write(intfhdl, addr, cnt, tmpbuf);
 
-	kfree(tmpbuf);
-
 	return err;
 }
 
@@ -880,16 +861,14 @@ void sd_int_dpc(struct adapter *adapter)
 	}
 
 	if (hal->sdio_hisr & SDIO_HISR_TXERR) {
-		u8 *status;
 		u32 addr;
 
-		status = kmalloc(4, GFP_ATOMIC);
+		u8 *status  __free(kfree) = kmalloc(4, GFP_ATOMIC);
 		if (status) {
 			addr = REG_TXDMA_STATUS;
 			hal_sdio_get_cmd_addr_8723b(adapter, WLAN_IOREG_DEVICE_ID, addr, &addr);
 			_sd_read(intfhdl, addr, 4, status);
 			_sd_write(intfhdl, addr, 4, status);
-			kfree(status);
 		}
 	}
 
-- 
2.34.1

