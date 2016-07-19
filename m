Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-yw0-f193.google.com ([209.85.161.193]:33254 "EHLO
	mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752473AbcGSKBX (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 19 Jul 2016 06:01:23 -0400
Received: by mail-yw0-f193.google.com with SMTP id i12so819155ywa.0
        for <linux-iio@vger.kernel.org>; Tue, 19 Jul 2016 03:01:23 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CACA7eURhTD8RzGOoYciOEp_oC2iuy+197gS7M3qnMhAEiH=v8A@mail.gmail.com>
References: <CACA7eURhTD8RzGOoYciOEp_oC2iuy+197gS7M3qnMhAEiH=v8A@mail.gmail.com>
From: Christophe Chapuis <chris.chapuis@gmail.com>
Date: Tue, 19 Jul 2016 12:01:22 +0200
Message-ID: <CACA7eUSu8yY+0F_Dy+RE5magv+erZRZNO-ydNmvN8c5rT87SfA@mail.gmail.com>
Subject: Fwd: [PATCH] iio: accel: kxcjk-1013: add the "KIOX000A" ACPI id
To: linux-iio@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On the Cube i9 tablet, the ACPI id for the Kionix kxcj9 accelerometer
is "KIOX000A" (as can be seen in the DSDT of the Cube i9 tablet).
It is the same accelerometer, so only adding the ACPI id is needed.

Signed-off-by: Christophe Chapuis <chris.chapuis@gmail.com>
---
 drivers/iio/accel/kxcjk-1013.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
index edec1d0..cf392c7 100644
--- a/drivers/iio/accel/kxcjk-1013.c
+++ b/drivers/iio/accel/kxcjk-1013.c
@@ -1393,6 +1393,7 @@ static const struct acpi_device_id kx_acpi_match[] = {
     {"KXCJ1013", KXCJK1013},
     {"KXCJ1008", KXCJ91008},
     {"KXCJ9000", KXCJ91008},
+    {"KIOX000A", KXCJ91008},
     {"KXTJ1009", KXTJ21009},
     {"SMO8500",  KXCJ91008},
     { },
-- 
2.7.4
