Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC889449
	for <linux-iio@vger.kernel.org>; Sun, 31 Dec 2023 18:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I86AGei/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3F9CC433C7;
	Sun, 31 Dec 2023 18:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704047743;
	bh=Lvpx8Bxt2jg94Hk0bcBhVt3BqENH0sXYyi35Io7CEpw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I86AGei/WASanIV3XSCZ0VYM3L19Du5oZ/emg4JKFdi6D6GQxxBweKQGdfTTYisP+
	 8QLUB8nloCIML84VOs8KSkvMozXUMes4o8tx5hx7sEHiyfm9EerIBv2P7IZlcDQqtS
	 HESE39HGpcmy5mQCEh6fo60CM4jvwSGtI4MIG6vAVllKsMRlIDDremgrvBrhzN4vig
	 BjKFLdcC8gcHKqtxL1RZwHESBJ8fQZ1aJQmUopsOnWaWTmFJhkeIbfZLGtA+RfREJS
	 WkR9ZzSF8yhiR5UrutEQPYMf9mrt/X2Hgtvy83lpwAOAr3uGRW2YTIznKkfcSqnud3
	 srHQ7/PJutEPA==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 13/24] iio: light: jsa1212: Drop ACPI_PTR() usage
Date: Sun, 31 Dec 2023 18:35:03 +0000
Message-ID: <20231231183514.566609-14-jic23@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231231183514.566609-1-jic23@kernel.org>
References: <20231231183514.566609-1-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Avoiding unused variable warnings when using this macro adds
complexity that in simple cases like this one is not justified
for the small saving in data.

Switch include from acpi.h to mod_devicetable.h which includes the
definition of struct acpi_device_id.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/light/jsa1212.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/light/jsa1212.c b/drivers/iio/light/jsa1212.c
index 37e2807041a1..869196746045 100644
--- a/drivers/iio/light/jsa1212.c
+++ b/drivers/iio/light/jsa1212.c
@@ -12,10 +12,10 @@
 #include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/delay.h>
 #include <linux/i2c.h>
 #include <linux/mutex.h>
-#include <linux/acpi.h>
 #include <linux/regmap.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
@@ -438,7 +438,7 @@ static struct i2c_driver jsa1212_driver = {
 	.driver = {
 		.name	= JSA1212_DRIVER_NAME,
 		.pm	= pm_sleep_ptr(&jsa1212_pm_ops),
-		.acpi_match_table = ACPI_PTR(jsa1212_acpi_match),
+		.acpi_match_table = jsa1212_acpi_match,
 	},
 	.probe		= jsa1212_probe,
 	.remove		= jsa1212_remove,
-- 
2.43.0

