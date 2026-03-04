Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22D038D;
	Wed,  4 Mar 2026 18:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772649210; cv=none; b=bWV0PRak3A2HLCBp6JuYjUR/M/dRUBDAkEyUq7wCBaxBCWWElL+xBk1gYiQcKM2/VUmrSPZhsv5Chy+ltOkYCaBy1PzwPf92t53nhLnRLAVPseMNj4VAEj12//Xeb/S9C3AfHCsXcjN0G4248HbLXIsMYDu+SeATl2uRCvHx7pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772649210; c=relaxed/simple;
	bh=23ZWre++sbdS9AI7YPSqbB78TTAMgEfyCsXi1q7Brv4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E02BK5UMBWiwPEbGpiSG6ZO2LEhV4iFBgXBV0kivLdWHC5aFsXa3OIzLHVKqX1KJu1uLm+vTPJsTm0JYAVhnDzSK4sThQZ1fnvV7Z6shA3qWlsEUN1COE91Do4g0m/ldGJh/FtWApTtTH1GnL5uTtGQ8qvc7hU4J4wqH5i7pKKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BdDTbYkm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BdDTbYkm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6B0FC19425;
	Wed,  4 Mar 2026 18:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772649210;
	bh=23ZWre++sbdS9AI7YPSqbB78TTAMgEfyCsXi1q7Brv4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BdDTbYkmujqRAY7paiLfuJbpaOo8DW1h8n4jQiqoFyNMbNPgnugld8Vk4thus4NGr
	 t2WnrfToW/vvZ3gczCJExTPc/ulTklb5Mrtr9CcDtouZcnaiIBhKVUm5Jqw82LtRLC
	 E336KidEdT417o92tLZAYXJ4Q6BqxOAp91hFu+N2HJ78qIFby6cIdwDSL6CpUtTg2U
	 kduOhlZJHGAdUhmiuln0nVA1AmGG8+3HLkbT1D+qjK65TFgpJWz+ZZAsIM77LCe1Qb
	 olY/3Vj9yfr+h1loTh5c56Lpj92EgIcqi0/XwRRvoCN0Ro1XBLUAGzdl7ReSJCcD9q
	 /laM0tOJ0WlfQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>,
 Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 linux-iio@vger.kernel.org
Subject:
 [PATCH v1 2/2] iio: light: acpi-als: Convert ACPI driver to a platform one
Date: Wed, 04 Mar 2026 19:33:14 +0100
Message-ID: <3609079.QJadu78ljV@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <6147175.MhkbZ0Pkbq@rafael.j.wysocki>
References: <6147175.MhkbZ0Pkbq@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

In all cases in which a struct acpi_driver is used for binding a driver
to an ACPI device object, a corresponding platform device is created by
the ACPI core and that device is regarded as a proper representation of
underlying hardware.  Accordingly, a struct platform_driver should be
used by driver code to bind to that device.  There are multiple reasons
why drivers should not bind directly to ACPI device objects [1].

Overall, it is better to bind drivers to platform devices than to their
ACPI companions, so convert the ACPI ambient light sensor driver to a
platform one.

After this change, the subordinate IIO device will be registered under
the platform device used for driver binding instead of its ACPI
companion.

While this is not expected to alter functionality, it changes sysfs
layout and so it will be visible to user space.

Link: https://lore.kernel.org/all/2396510.ElGaqSPkdT@rafael.j.wysocki/ [1]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/iio/light/acpi-als.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/light/acpi-als.c b/drivers/iio/light/acpi-als.c
index 2fe6b493c012..ef4fe708b271 100644
--- a/drivers/iio/light/acpi-als.c
+++ b/drivers/iio/light/acpi-als.c
@@ -18,6 +18,7 @@
 #include <linux/err.h>
 #include <linux/irq.h>
 #include <linux/mutex.h>
+#include <linux/platform_device.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/buffer.h>
@@ -175,9 +176,10 @@ static irqreturn_t acpi_als_trigger_handler(int irq, void *p)
 	return IRQ_HANDLED;
 }
 
-static int acpi_als_add(struct acpi_device *device)
+static int acpi_als_probe(struct platform_device *pdev)
 {
-	struct device *dev = &device->dev;
+	struct device *dev = &pdev->dev;
+	struct acpi_device *device = ACPI_COMPANION(dev);
 	struct iio_dev *indio_dev;
 	struct acpi_als *als;
 	int ret;
@@ -188,7 +190,6 @@ static int acpi_als_add(struct acpi_device *device)
 
 	als = iio_priv(indio_dev);
 
-	device->driver_data = indio_dev;
 	als->device = device;
 	mutex_init(&als->lock);
 
@@ -226,9 +227,10 @@ static int acpi_als_add(struct acpi_device *device)
 					       acpi_als_notify, indio_dev);
 }
 
-static void acpi_als_remove(struct acpi_device *device)
+static void acpi_als_remove(struct platform_device *pdev)
 {
-	acpi_dev_remove_notify_handler(device, ACPI_DEVICE_NOTIFY, acpi_als_notify);
+	acpi_dev_remove_notify_handler(ACPI_COMPANION(&pdev->dev),
+				       ACPI_DEVICE_NOTIFY, acpi_als_notify);
 }
 
 static const struct acpi_device_id acpi_als_device_ids[] = {
@@ -238,17 +240,16 @@ static const struct acpi_device_id acpi_als_device_ids[] = {
 
 MODULE_DEVICE_TABLE(acpi, acpi_als_device_ids);
 
-static struct acpi_driver acpi_als_driver = {
-	.name	= "acpi_als",
-	.class	= ACPI_ALS_CLASS,
-	.ids	= acpi_als_device_ids,
-	.ops = {
-		.add	= acpi_als_add,
-		.remove	= acpi_als_remove,
+static struct platform_driver acpi_als_driver = {
+	.probe = acpi_als_probe,
+	.remove = acpi_als_remove,
+	.driver = {
+		.name = "acpi_als",
+		.acpi_match_table = acpi_als_device_ids,
 	},
 };
 
-module_acpi_driver(acpi_als_driver);
+module_platform_driver(acpi_als_driver);
 
 MODULE_AUTHOR("Zhang Rui <rui.zhang@intel.com>");
 MODULE_AUTHOR("Martin Liska <marxin.liska@gmail.com>");
-- 
2.51.0




