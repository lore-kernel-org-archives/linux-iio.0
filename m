Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:27284 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755667AbdKCNDs (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 3 Nov 2017 09:03:48 -0400
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v3 4/5] iio: proximity: sx9500: Add another ACPI ID
Date: Fri,  3 Nov 2017 15:03:39 +0200
Message-Id: <20171103130340.42459-4-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20171103130340.42459-1-andriy.shevchenko@linux.intel.com>
References: <20171103130340.42459-1-andriy.shevchenko@linux.intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add new ACPI ID for sx9500 as had been found on prototype board.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/proximity/sx9500.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/proximity/sx9500.c b/drivers/iio/proximity/sx9500.c
index 3cf054155779..640ea08cd3b2 100644
--- a/drivers/iio/proximity/sx9500.c
+++ b/drivers/iio/proximity/sx9500.c
@@ -1048,6 +1048,7 @@ static const struct dev_pm_ops sx9500_pm_ops = {
 
 static const struct acpi_device_id sx9500_acpi_match[] = {
 	{"SSX9500", 0},
+	{"SASX9500", 0},
 	{ },
 };
 MODULE_DEVICE_TABLE(acpi, sx9500_acpi_match);
-- 
2.14.2

