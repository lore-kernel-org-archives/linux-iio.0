Received: from out203-205-221-231.mail.qq.com (out203-205-221-231.mail.qq.com [203.205.221.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F73C409275
	for <linux-iio@vger.kernel.org>; Sun, 11 Oct 2026 08:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791708536; cv=none; b=FccoyTa4Q3k/u0WqJdblilkFBwIUfArLOpQ128wCwo1asQqF/YlS3mEl63GGG6umuoTCQ6ihoqx8hYJJuD6Vo2gPc/u9IKUvogg2hJ4r80IESAG3YKcd2qkpnv0pCYbCzz0jwpeYOvnO0ZfCOtRjRHqaJDiiKwsB+sFDnvFp29Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791708536; c=relaxed/simple;
	bh=AAMiLUQL1aZfpjuWtxhJtBW4uoqr3z5vfym2jjYHz5U=;
	h=Message-ID:From:To:Cc:Subject:Content-Type:MIME-Version; b=QENEegBYx5G8tV0INZCLEaSF5cPW6w6VoNeSZUBxl7QOL1/r3J3mW+H/4Rnw4CZ70AkzHX1p7dOH+CutyszW1s0zZFApdZt8UBOhWqX/l4eo4lvxNO2NvkQYrtsC3LRbzGUy+Tqd6BnNCRi4PKP/87IBvM0LYdk4Hv9/hIDaQgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=NiH/cDQW; arc=none smtp.client-ip=203.205.221.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="NiH/cDQW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1791708520;
	bh=b6pl6KIROIr+mIv97/44CK8Lo6HGmMfZBi/KrrohrDU=;
	h=From:To:Cc:Subject;
	b=NiH/cDQWoWyLcLF13XHPAdrpv0w5g/Pjpzs4jb0DJCWL3Rqiy2dNjx40Fw7XDfiC1
	 ZZIfYXGAb+jDZAHQNkWbRn5rKydC1scp0HGXPumv6Sl4QHM+ZUngbIgviXSFV3W+sk
	 RsDMoqQCTsTkmM2SrMwFN15v4eNoyDgXszxKRweo=
Received: from [127.0.0.1] ([111.55.120.57])
	by newxmesmtplogicsvrsza63-0.qq.com (NewEsmtp) with SMTP
	id C25382F3; Sun, 11 Oct 2026 16:48:37 +0800
X-QQ-mid: xmsmtpt1791708517t0njjsmab
Message-ID: <tencent_C2E579008244A394105247CCC4787391C209@qq.com>
X-QQ-XMAILINFO: MXzpxT/vcbSgYrxcphtEd60uqzXfzQ09fB8b3b7pwOqe7G7OFRMiV3fcsVnH5A
	 x2YF5G3EkGL+1YvpNETV5JXWPW8w3Cxy9nq0UXZAQwUIgnhV8vrLMSvT3xXpwdwo2QnQhf46epP1
	 T5quTL7qb/e0t3KIYExWqTGv2u0PQS24pAhUELRm41Wo3561My52L8fpHUzyffua4LSwlEqyUeF9
	 CmSma9VO/nA3XRZSxm1+oGgYerhq8XMRsZG0LCOMQ4Ld/WCFJizBICkOwO8kIWjOhzkof1YGSLX0
	 oH/SQ4DuKg7ZaNu0ZFB9UvQ9/0/S3v7VDXcz2P4NpweoJ6XKYXjQk5V+rnQfYXz+fYb0rF1Fi/ee
	 wFpc6gy/pw114pteBS6DYRh7iQEd1L4uZSQlXkNWCbQjDU48YInhGPYkte9DGd3MDhd82FiPHihy
	 s2ZVLZN6b3VkO72aIYpy9tZgb0ND4zaLTiQu2j2hBhW0OYSRBQvSBumnw9mvvEP7612R5stznVwb
	 hsMF26sxnYcI4O5AFMFpNbXGqUhmWhXo/N/+lhSjx38JZmg9yOcYojdJa/gQt+cXczuh9hy99eNb
	 XRRsEdQWNGPDe9cEhbvC3yyXjowjspa91NFpfweydClkfIvKXlCi9I2CvpaE/+TjnTXX6Ia6Htgk
	 4WD4phm7EkId44lTOZ49WXP2e2MIhSiyGRXfV4VwFVDqUOyf+ajwIBlZ5U8Xj82TWw3vx2gtBH5+
	 4QJypfgXN6FDBennM3IVE4aW4Uf1kbn5WbOWGgM5CY8KxKET6jZZKZcTUQn+UK+gHA9IbdfE2Loi
	 cjDw/HdEZ2pTOZ0lMm8OcYuEY13kpgvw2A2Ad7cgD4zTKvVg8k7rrdLPYT0cgZZ4FAuusI0Pcmik
	 5s9GN+fjoJ0IOF0R52FdEJpUCU/ZmRL7NSbpQxCnW/5Ia9BMxg2Tws/NN/bk7gSEntkACWqd7uDg
	 Y/sOh2lakDwcF9kMeroPH5h6ispdp+dXzjfDk5Z1D/Gu6rkOjJeCYr+Leltb7U0CC4Nsvcn4pcFC
	 oSg8qkJ1LuNJyJvmQEc2b/S0VoZPrWJDDw6+qquiM49tlyTfbsH+5vRuZ8cmSLUNCbW3simq1wdg
	 GcdyWEM5Gi1criC+/Gz8EOH9OQsbOsb2nflZNoq41zgaVOmczVLU0I8JY2kA==
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
From: Zixin Wang <ywp1023456@foxmail.com>
To: Kevin Tsai <ktsai@capellamicro.com>, Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>,
 Nuno =?utf-8?q?S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>
Subject: [PATCH] iio: light: cm32181: add support for the CM32183
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

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

Signed-off-by: Zixin Wang <ywp1023456@foxmail.com>
---
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

