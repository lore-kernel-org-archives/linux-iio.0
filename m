Return-Path: <SRS0=Vd33=RF=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00EA6C43381
	for <linux-iio@archiver.kernel.org>; Sat,  2 Mar 2019 16:55:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EC6820838
	for <linux-iio@archiver.kernel.org>; Sat,  2 Mar 2019 16:55:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.ru header.i=@mail.ru header.b="JuTdK8WD";
	dkim=pass (1024-bit key) header.d=mail.ru header.i=@mail.ru header.b="JuTdK8WD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726295AbfCBQzX (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 2 Mar 2019 11:55:23 -0500
Received: from fallback17.m.smailru.net ([94.100.176.130]:34218 "EHLO
        fallback17.mail.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbfCBQzX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 2 Mar 2019 11:55:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru; s=mail2;
        h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From; bh=MMIdQh2xGdSnf2wsmllip47qNoLWVp0xpB7bMpVfuCk=;
        b=JuTdK8WD8UcrSOfWVrdBqOyhUn8BQt4RcjQ5+d//KKPGmZ5iPCiXvnwNkXVvMB9XjYU1HTGXCuByNf8/wo+5u7D0XUrDMVAtTgfaezdfr7Pg3PoC1qAIMbaxexc3FG8FcMOz4f2wlw1iav9l17mfNiPsR5lW1+HqA1IA6WZLBKA=;
Received: from [10.161.100.15] (port=52612 helo=smtpng3.m.smailru.net)
        by fallback17.m.smailru.net with esmtp (envelope-from <cerg2010cerg2010@mail.ru>)
        id 1h07ux-0004Ur-UV; Sat, 02 Mar 2019 19:55:20 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru; s=mail2;
        h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From; bh=MMIdQh2xGdSnf2wsmllip47qNoLWVp0xpB7bMpVfuCk=;
        b=JuTdK8WD8UcrSOfWVrdBqOyhUn8BQt4RcjQ5+d//KKPGmZ5iPCiXvnwNkXVvMB9XjYU1HTGXCuByNf8/wo+5u7D0XUrDMVAtTgfaezdfr7Pg3PoC1qAIMbaxexc3FG8FcMOz4f2wlw1iav9l17mfNiPsR5lW1+HqA1IA6WZLBKA=;
Received: by smtpng3.m.smailru.net with esmtpa (envelope-from <cerg2010cerg2010@mail.ru>)
        id 1h07uj-0002Fo-Fe; Sat, 02 Mar 2019 19:55:05 +0300
From:   Sergey Larin <cerg2010cerg2010@mail.ru>
To:     linus.walleij@linaro.org, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net
Cc:     linux-iio@vger.kernel.org, Sergey Larin <cerg2010cerg2010@mail.ru>
Subject: [PATCH] iio: gyro: mpu3050: fix chip ID reading
Date:   Sat,  2 Mar 2019 19:54:55 +0300
Message-Id: <20190302165455.6594-1-cerg2010cerg2010@mail.ru>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-77F55803: 260C666A7D66B36A5A78504BD2AC294173B5FE5E8078F296D5885A35BB6CD9191570026D6B5434CDA73A9F2227E2EA61
X-7FA49CB5: 0D63561A33F958A5CE3FF36B95377A5D7DFDA410385C74B468C0371F3ECE78B68941B15DA834481FA18204E546F3947C2FFDA4F57982C5F4F6B57BC7E64490618DEB871D839B7333395957E7521B51C2545D4CF71C94A83E9FA2833FD35BB23D27C277FBC8AE2E8BF1175FABE1C0F9B6A471835C12D1D977C4224003CC836476C0CAF46E325F83A522CA9DD8327EE4930A3850AC1BE2E7359F34C67CCB0B91AF45CB49CF220575A2731C566533BA786A40A5AABA2AD371193C9F3DD0FB1AF5EB2526A3BF303149AF3C9F3DD0FB1AF5EB4E70A05D1297E1BBCB5012B2E24CD356
X-Mailru-Sender: 689FA8AB762F739359CD701D0F70D3B13A3A3B9558049ECB6543E3B619AB9AD359BDA819A5E6616DA8F624234B89B86CE8B5287D445C8DCEAF94EBD2C457D57F4B70C0F398F9AAE4ECC6A6E4A36FFAA567EA787935ED9F1B
X-Mras: OK
X-77F55803: 6AF0DA0BABFA9FDB7F9F52485CB584D7271FD7DF62800FDC9DC7353DBE0221D904A00C6BAFA453F3A2E3B5DA1BBD9376BF3CD1B365EBDF45
X-7FA49CB5: 0D63561A33F958A5AC7DC85961B7BE17578A4CA62F6722183F6588960E8096ED8941B15DA834481FA18204E546F3947CEDCF5861DED71B2F389733CBF5DBD5E9C8A9BA7A39EFB7666BA297DBC24807EA117882F44604297287769387670735209ECD01F8117BC8BEA471835C12D1D977C4224003CC836476C0CAF46E325F83A50BF2EBBBDD9D6B0F2EF91E2201DEA5EC574AF45C6390F7469DAA53EE0834AAEE
X-Mailru-Sender: A5480F10D64C90052060E016933BC039B608E4A14D3004D73D81AD2EF8AB3108B18789A3A159887F51913ECE9F5D4CE557914126969F3D9578C09B768FF42B7F4F0A872F021F9059A8B6234B51EB8B42EAB4BC95F72C04283CDA0F3B3F5B9367
X-Mras: OK
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

According to the datasheet, the last bit of CHIP_ID register controls
I2C bus, and the first one is unused. Handle this correctly.

Signed-off-by: Sergey Larin <cerg2010cerg2010@mail.ru>
---
 drivers/iio/gyro/mpu3050-core.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/gyro/mpu3050-core.c b/drivers/iio/gyro/mpu3050-core.c
index 77fac81a3adc..5ddebede31a6 100644
--- a/drivers/iio/gyro/mpu3050-core.c
+++ b/drivers/iio/gyro/mpu3050-core.c
@@ -29,7 +29,8 @@
 
 #include "mpu3050.h"
 
-#define MPU3050_CHIP_ID		0x69
+#define MPU3050_CHIP_ID		0x68
+#define MPU3050_CHIP_ID_MASK	0x7E
 
 /*
  * Register map: anything suffixed *_H is a big-endian high byte and always
@@ -1176,8 +1177,9 @@ int mpu3050_common_probe(struct device *dev,
 		goto err_power_down;
 	}
 
-	if (val != MPU3050_CHIP_ID) {
-		dev_err(dev, "unsupported chip id %02x\n", (u8)val);
+	if ((val & MPU3050_CHIP_ID_MASK) != MPU3050_CHIP_ID) {
+		dev_err(dev, "unsupported chip id %02x\n",
+				(u8)(val & MPU3050_CHIP_ID_MASK));
 		ret = -ENODEV;
 		goto err_power_down;
 	}
-- 
2.21.0

