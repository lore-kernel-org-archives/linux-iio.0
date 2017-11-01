Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:24357 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754978AbdKAQzX (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 1 Nov 2017 12:55:23 -0400
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 2/2] iio: magnetometer: ak8975: Add another ACPI ID
Date: Wed,  1 Nov 2017 18:53:19 +0200
Message-Id: <20171101165319.36033-2-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20171101165319.36033-1-andriy.shevchenko@linux.intel.com>
References: <20171101165319.36033-1-andriy.shevchenko@linux.intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add new ACPI ID for ak9911 as had been found on prototype board.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/magnetometer/ak8975.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
index c09329069d0a..42a827a66512 100644
--- a/drivers/iio/magnetometer/ak8975.c
+++ b/drivers/iio/magnetometer/ak8975.c
@@ -788,6 +788,7 @@ static const struct acpi_device_id ak_acpi_match[] = {
 	{"AK8975", AK8975},
 	{"AK8963", AK8963},
 	{"INVN6500", AK8963},
+	{"AK009911", AK09911},
 	{"AK09911", AK09911},
 	{"AK09912", AK09912},
 	{ },
-- 
2.14.2

