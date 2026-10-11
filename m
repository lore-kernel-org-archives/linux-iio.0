Received: from out203-205-221-209.mail.qq.com (out203-205-221-209.mail.qq.com [203.205.221.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC782DCF57
	for <linux-iio@vger.kernel.org>; Sun, 11 Oct 2026 17:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791738177; cv=none; b=Tw/euyR64dVrUGakWwH1qtu/DN7rtxwoUwuoN8GCHsFfxCLsF30JfD7sDO20tdPBPamygyET9YQ+C3XcUNOJtPabMIZrxkEzqHGXscJMKNE5bbLZIr+AiqIVL/YSrO0VSLPQEcKtkRhYJBdQZ8jsVsxk2Ns5/CmATJuoQF72RcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791738177; c=relaxed/simple;
	bh=9ONPgr/gpjxCtQixO2VzPZJAO4u9D9WuILPmVGmZ2c4=;
	h=Message-ID:From:To:Cc:Subject:Content-Type:MIME-Version; b=Ta5Esa0fsBYGg3z5/fVwuPzGIB6fE/1ZN0ilbq8LvHI6MPxyhtqEPZAJrUgriTjG+mWTYBqp+UzTKZnu6GIbBF4Shhtw4S4lxpUn26d/KBfBVumCGSi0dVKuHwUsDxb6D7xst/qqGjW3bMOw4otqHTR3/nsJvpaoDITAqr9ymhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=a3M2D7GS; arc=none smtp.client-ip=203.205.221.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="a3M2D7GS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1791738170;
	bh=nQ8jvkhkfh+zsIkDAoAzZ3t3md421lAlMwQ2h0BPD5g=;
	h=From:To:Cc:Subject;
	b=a3M2D7GSF8msLm9Yu+mVOIP/nhsPfZO0nOSmugRnZIUtPoqtc4qgBy7nm2ZNC/J4D
	 mOD+T8fk7VGQkSm96WNHFSmJ7XERxgkEQ0WiaOrn8/hqgbOJMnTuj8G4d84wQg4wFB
	 AwIZMmHKwQmSfhrcOFc8f711qalB4bNEQBgiNc/I=
Received: from [127.0.0.1] ([112.224.162.161])
	by newxmesmtplogicsvrszb51-1.qq.com (NewEsmtp) with SMTP
	id AFB9C1E; Mon, 12 Oct 2026 01:02:47 +0800
X-QQ-mid: xmsmtpt1791738167tc9rr930o
Message-ID: <tencent_27A2DA110A464EC41673E7C2217844837C09@qq.com>
X-QQ-XMAILINFO: N0KWS97VikCl4oJJ1vM5EysMKk51pGnR5ajTun8pU3CS98Mc8mP6bf0iqOeQkU
	 3EZPbSWG7Y+Ipg611sSgVltNfUTtibHGckJ7ebWnV9IZ9w3TkUKCzqGlzeXlv3V3pG+az/VXkk/0
	 m1VgZNs8owwGc1OrwfZTCKBF93BUvsZqMXeXM3pPXvRKuQEOQgeVu3XQc9r6LzxBtHLCxMz1e83x
	 /dhVV0K9ckpAJGtoWlJKQmHUaoMWdCF3qYS1H1YnrkAqbn5KP8mHFBbMpiyOmNF8tFGivD7G8RR8
	 hm7qVWKUocgaYBw6+MLiqbe5y0ofCuPd1YSr8Ryo0Qy6vtZP4o6vCkBtX/zvVx+yDWBkdxtqrhgK
	 uClGj37KmjE0VLd/zeTvxAJYBb04WDyMOCGFcGldPB/1GCQDZfl0zNtywNaHU6nkcG5cKiSgvaCh
	 bjVAOssGCjVUUfe5uy/zIbZFRilT20OpM1gQWGZBJLBb2daXlwfT2NKhkxcPK/SzyNDN/MyhlTNy
	 JWck3PbXYXdSsoT1ce6iVre37/WuKhnYCrBLGuHYSHbJDjTs6zq131KsybBCyxpkTZLBVFs6ruSo
	 J2hj3lvX9COvDb2KtcNzAwt5hVBA9JTIr1NhAJGtQ6dCVPoCMKtgb0NogKLUPeuMIN4aUo7OzsYJ
	 MYE+sEazRhspjVPIvSGQLg2tQn59kMSh+HxwB6a/lasjVdgrSl2wOB8riKdN5c8yvhyzeOe2u8gD
	 Xq34sf7vKGuRqthV/ilfwQ7Z3KydGCDYFnJUvP/hkum3JGOIE4siGlLkT1zVeE8KOObqv1n1T/FD
	 /oDBKvdBk+Jg03Y1p0R4wLRe52z+N+Ppx6Q4/nVrOQC0BhjWBGv3EW2VqPXUmpAXGgldUBGK/Xx3
	 oSP7hj2FpVRJLn2yNCwfiWf7G7IdA0g7TbMRJpDjhcaGyOMYqGGh9BwYjFUnHX8rdVAOEqcqpuwQ
	 55/IhI2jwej8qklMY9uvYlMuewYNKg/QCt681bxyUkC9cWbAx7KMgA+/beLbev4zQiNQrNlNyoIe
	 vCy98ho2At3PSTACqdNljMnfsuwRhNYSpLRN9ksXs+U3l/6IrnmfAD9wqBrXVd94xQKYmSmzw5sM
	 jD77+c5AsJ52IFovIQppCd/cW9TL30glC1pihd6xbyRaY5mUOnrg34Mbb2WbHgOKhCLx/xgt1Org
	 7z76o=
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
From: Zixin Wang <ywp1023456@foxmail.com>
To: Kevin Tsai <ktsai@capellamicro.com>, Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>,
 Nuno =?utf-8?q?S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Joshua Crofts <joshua.crofts1@gmail.com>
Subject: [PATCH v2] iio: light: cm32181: add support for the CM32183
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Add the device ID for the CM32183. The device has the same register
layout as the CM32181.

Signed-off-by: Zixin Wang <ywp1023456@foxmail.com>
---
v2:
- Shorten the commit message and move the detailed rationale below the
  fold, as suggested by Joshua Crofts.

v1: https://lore.kernel.org/linux-iio/tencent_C2E579008244A394105247CCC4787391C209@qq.com/

The CM32183 is another member of the Capella CM3218x ambient light
sensor family. Its device ID register (0x07) returns 0x83 in the low
byte, following the same scheme as the already supported parts:

    CM3218  -> 0x18
    CM32181 -> 0x81
    CM32182 -> 0x82
    CM32183 -> 0x83

The driver falls through to the default branch of the ID switch and
returns -ENODEV, so probe() fails even though the device is present and
functional:

    cm32181 i2c-CPLM3218:00: cm32181_probe: register init failed

This was observed on an H3C MegaBook 14 (Intel Core Ultra 5 226V, Lunar
Lake). Its DSDT declares the sensor as:

    Device (LSRD) {
        Name (_HID, "CPLM3218")
        Name (_CID, "CPLM3218")
        Name (_UID, 1)
    }

on I2C at address 0x29, and additionally provides the vendor
initialisation and calibration objects that this driver already parses.
CPM0[0] reports a device-id of 32183, and CPM1 provides lux_per_bit =
2200 and calibscale = 265859.

Treat the CM32183 like the CM32181.

Measurements on the above machine confirm the register layout matches:
the power-on value of the CMD register (0x0001) has bit 0 set, which is
CM32181_CMD_ALS_DISABLE, and register 0x04 is the ALS data register.
With this change the driver binds, the ACPI-provided initialisation
values are written and the CPM1 calibration is taken into account
(in_illuminance_calibscale reads back 265859). The reported illuminance
tracks ambient light without saturating.

Please Cc me on replies, I am not subscribed to linux-iio.
 drivers/iio/light/cm32181.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/light/cm32181.c b/drivers/iio/light/cm32181.c
index 2590fc8..97882e4 100644
--- a/drivers/iio/light/cm32181.c
+++ b/drivers/iio/light/cm32181.c
@@ -54,7 +54,10 @@
 
 #define SMBUS_ALERT_RESPONSE_ADDRESS	0x0c
 
-/* CPM0 Index 0: device-id (3218 or 32181), 1: Unknown, 2: init_regs_bitmap */
+/*
+ * CPM0 Index 0: device-id (3218, 32181 or 32183), 1: Unknown,
+ * 2: init_regs_bitmap
+ */
 #define CPM0_REGS_BITMAP		2
 #define CPM0_HEADER_SIZE		3
 
@@ -200,6 +203,7 @@ static int cm32181_reg_init(struct cm32181_chip *cm32181)
 		break;
 	case 0x81: /* CM32181 */
 	case 0x82: /* CM32182, fully compat. with CM32181 */
+	case 0x83: /* CM32183 */
 		cm32181->num_als_it = ARRAY_SIZE(cm32181_als_it_bits);
 		cm32181->als_it_bits = cm32181_als_it_bits;
 		cm32181->als_it_values = cm32181_als_it_values;
-- 
2.39.5

