Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mo4-p01-ob.smtp.rzone.de ([81.169.146.167]:31243 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbeKYDZy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 24 Nov 2018 22:25:54 -0500
From: Stephan Gerhold <stephan@gerhold.net>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH] iio: accel: kxcjk-1013: Add the "KXJ2109" ACPI HID
Date: Sat, 24 Nov 2018 17:22:20 +0100
Message-Id: <20181124162220.8523-1-stephan@gerhold.net>
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This HID is used on the ASUS MeMO Pad 7 (ME176C) tablet.

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 drivers/iio/accel/kxcjk-1013.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
index af53a1084ee5..cc5b2beb1328 100644
--- a/drivers/iio/accel/kxcjk-1013.c
+++ b/drivers/iio/accel/kxcjk-1013.c
@@ -1491,6 +1491,7 @@ static const struct acpi_device_id kx_acpi_match[] = {
 	{"KXCJ9000", KXCJ91008},
 	{"KIOX000A", KXCJ91008},
 	{"KXTJ1009", KXTJ21009},
+	{"KXJ2109",  KXTJ21009},
 	{"SMO8500",  KXCJ91008},
 	{ },
 };
-- 
2.19.2
