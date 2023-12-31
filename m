Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E64AD25
	for <linux-iio@vger.kernel.org>; Sun, 31 Dec 2023 18:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bJ4HTaAw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A769C433C8;
	Sun, 31 Dec 2023 18:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704047756;
	bh=TFFWIIjCmLsPf5u7zPp74sVLrXDsrklat03JWq0cwTQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bJ4HTaAwCg8xXfoONlU4SqYryNHa7sWcB0W5mlZGEePNKCeqi3RTq53gAOGYpo8G5
	 YIuSOzvar7pITbn0aqJW92MvKv8vEr786ZTlcGM2NV32aXBbfiAJNI8yDBYIPfMLMA
	 yj3oGnJLkLjVHEfrPDk6FOwIxYnIKGOpWbhpXRZJPBjr+Bdg5LChx4DSaetIle2ENJ
	 fXgaM2QdvRFnDbAb9K60ZiyhtzYvUnSJxviPdz22y56qpLLIfdcvYJjxnMDALx5N+B
	 YsipXFJp2hZYxlEJYDGMjqC9qDqZWSYGfruAYpB1rfQC2f2b8lnCbsyoZBv6unfRWg
	 Ap/Q+Y7By2VFg==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH 20/24] iio: potentiometer: max5487: Drop ACPI_PTR() usage
Date: Sun, 31 Dec 2023 18:35:10 +0000
Message-ID: <20231231183514.566609-21-jic23@kernel.org>
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

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

---

I can't find a specific listing for this one so no closes tag.
---
 drivers/iio/potentiometer/max5487.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/potentiometer/max5487.c b/drivers/iio/potentiometer/max5487.c
index 42723c996c9f..4838d2e72f53 100644
--- a/drivers/iio/potentiometer/max5487.c
+++ b/drivers/iio/potentiometer/max5487.c
@@ -5,8 +5,8 @@
  * Copyright (C) 2016 Cristina-Gabriela Moraru <cristina.moraru09@gmail.com>
  */
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/spi/spi.h>
-#include <linux/acpi.h>
 
 #include <linux/iio/sysfs.h>
 #include <linux/iio/iio.h>
@@ -144,7 +144,7 @@ MODULE_DEVICE_TABLE(acpi, max5487_acpi_match);
 static struct spi_driver max5487_driver = {
 	.driver = {
 		.name = "max5487",
-		.acpi_match_table = ACPI_PTR(max5487_acpi_match),
+		.acpi_match_table = max5487_acpi_match,
 	},
 	.id_table = max5487_id,
 	.probe = max5487_spi_probe,
-- 
2.43.0

