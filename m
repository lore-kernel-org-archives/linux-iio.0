Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:48278 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727953AbeJLRte (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 12 Oct 2018 13:49:34 -0400
From: Hans de Goede <hdegoede@redhat.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Subject: [PATCH] iio: accel: kxcjk1013: Add KIOX0009 ACPI Hardware-ID
Date: Fri, 12 Oct 2018 12:17:50 +0200
Message-Id: <20181012101750.29333-1-hdegoede@redhat.com>
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add KIOX0009 ACPI HID, this is used e.g. on the Acer One 10.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/iio/accel/kxcjk-1013.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
index af53a1084ee5..8600e4be88ad 100644
--- a/drivers/iio/accel/kxcjk-1013.c
+++ b/drivers/iio/accel/kxcjk-1013.c
@@ -1489,6 +1489,7 @@ static const struct acpi_device_id kx_acpi_match[] = {
 	{"KXCJ1013", KXCJK1013},
 	{"KXCJ1008", KXCJ91008},
 	{"KXCJ9000", KXCJ91008},
+	{"KIOX0009", KXTJ21009},
 	{"KIOX000A", KXCJ91008},
 	{"KXTJ1009", KXTJ21009},
 	{"SMO8500",  KXCJ91008},
-- 
2.19.0
