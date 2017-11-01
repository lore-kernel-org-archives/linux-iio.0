Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:47893 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751681AbdKAQxX (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 1 Nov 2017 12:53:23 -0400
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 1/2] iio: proximity: sx9500: Add another ACPI ID
Date: Wed,  1 Nov 2017 18:53:18 +0200
Message-Id: <20171101165319.36033-1-andriy.shevchenko@linux.intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add new ACPI ID for sx9500 as had been found on prototype board.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/proximity/sx9500.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/proximity/sx9500.c b/drivers/iio/proximity/sx9500.c
index 53c5d653e780..8f417ccacf22 100644
--- a/drivers/iio/proximity/sx9500.c
+++ b/drivers/iio/proximity/sx9500.c
@@ -1021,7 +1021,7 @@ static const struct dev_pm_ops sx9500_pm_ops = {
 };
 
 static const struct acpi_device_id sx9500_acpi_match[] = {
-	{"SSX9500", 0},
+	{"SASX9500", 0},
 	{ },
 };
 MODULE_DEVICE_TABLE(acpi, sx9500_acpi_match);
-- 
2.14.2

