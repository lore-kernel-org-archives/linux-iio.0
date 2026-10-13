Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39AB7361956
	for <linux-iio@vger.kernel.org>; Tue, 13 Oct 2026 15:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791904066; cv=none; b=iZHvuL0HlL+nhnVlv1VePZ7AS2v/fFTXqp/hyI+KWtMICistHsGgMZXxhgQtv15PKrrjeFzPufxjoYwHkdOEKHPnsVeuqU7txlmpWsR3eW7EqAXWdwsIJgrMF9XylBxCIXm+Q9xfsggNc/gH4j9/rvzzJrvzREYNjjaj2qFCC0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791904066; c=relaxed/simple;
	bh=HF++1O3lp5B7WR9RiUZ2/BzyH8OIXNuIaMQXMVXtTYk=;
	h=Message-ID:From:To:Cc:Subject:Content-Type:MIME-Version:Date; b=oIMle09lSQow4IkEmDV0C07gvdQi4l3WKyp9wlM/L1K+luVuGLFeQp9833U3E/tZ/6n/PsDjtQaOV0QBhZdlnAEn4p0DB0pI3qtouDpP0Q1pR7oI0XaXJDD5HYrr/E/vvo+m5nfyvBNZIQLaKOqj5hLqo0tI8LexVMGBFf7p660=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=RTeOWlZZ; arc=none smtp.client-ip=43.163.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="RTeOWlZZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1791904054;
	bh=Kcz++mdiefWr81gBns/5btD5RPpb/Dtl8Clt2dgWAtA=;
	h=From:To:Cc:Subject:Date;
	b=RTeOWlZZWJGB0baFMleChCTcKW97+HgrM2PlMqo3BXP1iaJQ1t8xVqOtD51N8PmcI
	 2TvwKJHGX1OW9VbSEzw4ZMQ8++g/ycWMAXxFwnsRn0AnzD2fLcJEDraD3VOTmJ/BS0
	 0cREYruqhGFJBr1DJv0MfZ/AsyM+bCRgD00GedGQ=
Received: from [127.0.0.1] ([111.55.120.9])
	by newxmesmtplogicsvrszc50-0.qq.com (NewEsmtp) with SMTP
	id 1DF16ADA; Tue, 13 Oct 2026 23:07:31 +0800
X-QQ-mid: xmsmtpt1791904051t1o0dm1nb
Message-ID: <tencent_850445458D21608E9C8821E6728457F31C0A@qq.com>
X-QQ-XMAILINFO: NMSHCeFjyxDuKN2frx4O1dy4u6YM5QhXGQx1FOTSWHJFxM9VFrKH4emPKZJIJ5
	 8d5TRBTOYOxb7ilOGalwVNqGi8LMCJ/lyjYt2KZ+angvyBuW56MDMtVmW5KW6nVFJzcoadBH/mJl
	 s/0xye1xYTB7RCyzwgGZ/8J3RwoNT9fG9pOS4fQ3pTq67ia/6FAcZNavTn9Bz4MUSpO5Jl2O8tGQ
	 uPOqAFK7Zi0djlxXCK0uACDW5ytJeMrXTdn48qHug/sTUvxEdMlb2hI+hEPJBhcQxohZE23Z2cFc
	 6Y56w96vK05JNlrmco3ZfYV3zJc+yrw9kk2YLeTMsLuQZ1p19w39ADiWrXflwOTwA7A00wVdOpEl
	 7mrKIPXO4t5qeH/hKC+gzNZ+Vwk4jRaXfIpL4Kb3E125wCgLYROgSIPm8bY5vFeQpAmEcZhRx6Ot
	 fb8h8oEFQR1cppQAejweei9gnXZEqT8wvj0Lg0B6CSf6p9eRfpaMpzDkXdySXDiB0jkmeNYm0wt9
	 mdX4JXh4mfDuSteRiW2llHOdqIzoH32GLCj7fflTszIzmR0zjr0LOREsbrvJGwlP/r5zHfIOCQ1p
	 vyqLI8wjVDknmEK25bBoSyeIO8gYOgV0rbSjhHHjqNeaoCIIg/Ow0ukbbr4RJxXtnVwLmiMwBR6A
	 jwRj+sdcU60DaHKWtU7kykK5xQikhdeqTxoKgiJ5u9n/bsIc3MMV59rzSexx1nxe1f46soGEcWLD
	 7MBKBwroLdWLrWbwK+o5e7TH988BnvN6ml7qyYgLHxn/LOz+WobORH1LwsjHNKHp5b4WRPe9/C//
	 hJgi3ZMUqr5ibfq/DwHaq7MrRUfUzlaJtamONIdorjvsbeu5Fn6nG70h+ZqsJCJa5KKeKMfpx/Kf
	 wJhhVuqSSmyOmYD25ODWIJUKPjs/QAvNMvcRwfhwbebmsrhv/4efzfG50kdyV8c4wpM/bnctFgIa
	 AUWIKlaUSutwxVuY4f/NpQW7eA3sA894+v+F0qPqwOYtr2YF4WnY+9kHZ1UaUzENx6v38FD4eIYi
	 hSIR55Wd4Z1Xgx/wtO6Yec6voWM4BDx4nyt2mhg65Q7yO8r2XBmy6vVjTkeU8tav2ulTuQj7wFcT
	 BxihQIYN78QNdkq5/CgNmRCIhFY6s+5QwLjm6nif2y3WNb5RDL4CXp7bbA7msC03M583iKOQHrdb
	 /a8pA=
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
From: Zixin Wang <ywp1023456@foxmail.com>
To: Kevin Tsai <ktsai@capellamicro.com>, Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>,
 Nuno =?utf-8?q?S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Joshua Crofts <joshua.crofts1@gmail.com>
Subject: [PATCH v3] iio: light: cm32181: add support for the CM32183
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 13 Oct 2026 23:07:30 +0800

From: Zixin Wang <ywp1023456@foxmail.com>
Date: Sun, 11 Oct 2026 08:29:13 +0000
Subject: [PATCH v3] iio: light: cm32181: add support for the CM32183

Add the device ID for the CM32183. The device has the same register
layout as the CM32181. Found on the H3C MegaBook 14.

Datasheet: http://www.capellamicro.com.tw/EN/product_c.php?id=96&mode=14
Signed-off-by: Zixin Wang <ywp1023456@foxmail.com>
---
v3:
- Reformat the CPM0 comment as suggested by Andy Shevchenko.
- Mention the product this part is found on, as suggested by Andy
  Shevchenko.
- Add a Datasheet: tag as suggested by Joshua Crofts. The CM32183
  datasheet is only offered by the vendor after registering a My Capella
  account, and no publicly downloadable copy could be found, so the tag
  points at the public product page for the part.

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
---
 drivers/iio/light/cm32181.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/light/cm32181.c b/drivers/iio/light/cm32181.c
index 2590fc8..ac6ec6f 100644
--- a/drivers/iio/light/cm32181.c
+++ b/drivers/iio/light/cm32181.c
@@ -54,7 +54,12 @@
 
 #define SMBUS_ALERT_RESPONSE_ADDRESS	0x0c
 
-/* CPM0 Index 0: device-id (3218 or 32181), 1: Unknown, 2: init_regs_bitmap */
+/*
+ * CPM0 Index
+ * 0: device-id (3218, 32181, or 32183),
+ * 1: Unknown,
+ * 2: init_regs_bitmap
+ */
 #define CPM0_REGS_BITMAP		2
 #define CPM0_HEADER_SIZE		3
 
@@ -200,6 +205,7 @@ static int cm32181_reg_init(struct cm32181_chip *cm32181)
 		break;
 	case 0x81: /* CM32181 */
 	case 0x82: /* CM32182, fully compat. with CM32181 */
+	case 0x83: /* CM32183 */
 		cm32181->num_als_it = ARRAY_SIZE(cm32181_als_it_bits);
 		cm32181->als_it_bits = cm32181_als_it_bits;
 		cm32181->als_it_values = cm32181_als_it_values;
-- 
2.39.5

