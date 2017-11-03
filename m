Return-Path: <SRS0=1Hpq=CB=linux.intel.com=andriy.shevchenko@kernel.org>
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v3 5/5] iio: magnetometer: ak8975: Add another ACPI ID
Date: Fri,  3 Nov 2017 15:03:40 +0200
Message-Id: <20171103130340.42459-5-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20171103130340.42459-1-andriy.shevchenko@linux.intel.com>
References: <20171103130340.42459-1-andriy.shevchenko@linux.intel.com>
List-ID: <linux-iio@vger.kernel.org>

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
