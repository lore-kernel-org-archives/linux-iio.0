Return-Path: <ao2@ao2.it>
From: Antonio Ospite <ao2@ao2.it>
To: linux-iio@vger.kernel.org
Cc: Daniel Baluta <daniel.baluta@gmail.com>,
	Antonio Ospite <ao2@ao2.it>,
	Jonathan Cameron <jic23@kernel.org>,
	Bastien Nocera <hadess@hadess.net>
Subject: [PATCHv2 1/2] iio: accel: kxcjk-1013: add the "KXCJ9000" ACPI id
Date: Mon,  4 May 2015 11:13:03 +0200
Message-Id: <1430730785-17833-2-git-send-email-ao2@ao2.it>
In-Reply-To: <1430730785-17833-1-git-send-email-ao2@ao2.it>
References: <1430730785-17833-1-git-send-email-ao2@ao2.it>
List-ID: <linux-iio@vger.kernel.org>

This id has been seen in the DSDT of the Teclast X98 Air 3G tablet based
on Intel Bay Trail.

Signed-off-by: Antonio Ospite <ao2@ao2.it>
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: Bastien Nocera <hadess@hadess.net>
Cc: linux-iio@vger.kernel.org
---
 drivers/iio/accel/kxcjk-1013.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
index 51da369..5b7a860 100644
--- a/drivers/iio/accel/kxcjk-1013.c
+++ b/drivers/iio/accel/kxcjk-1013.c
@@ -1418,6 +1418,7 @@ static const struct dev_pm_ops kxcjk1013_pm_ops = {
 static const struct acpi_device_id kx_acpi_match[] = {
 	{"KXCJ1013", KXCJK1013},
 	{"KXCJ1008", KXCJ91008},
+	{"KXCJ9000", KXCJ91008},
 	{"KXTJ1009", KXTJ21009},
 	{"SMO8500",  KXCJ91008},
 	{ },
-- 
2.1.4
