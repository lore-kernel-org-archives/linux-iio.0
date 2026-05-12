Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D333CC7E3;
	Tue, 12 May 2026 16:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778603309; cv=none; b=i/hAHWljUKD5Hl1ZiQmNYmkd8z5O+2hTSvIzg36dI4d6JtggQDVYgXpCbqInkrAqIzmVHmqziozwGR6HrJmJFUK5d34kpgT9IK+wOoM3209s4HD2qyo7hbfMpS2lZFm88HlmMW4qSPIiD0rMEq/fEhX0EPkL/kG2NU4gm0ezTQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778603309; c=relaxed/simple;
	bh=Wa7NpHKF7nL0Sj9JFI+m2JxaqGNaZ9G47B8JXLkGCI4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=evzUhoqsJNMvSe8NfBLE6qErqDKL0mV8Hty7BBpDtLEay6K0NtwEX6vmYgYw7vv+SlXcUn+YsKGEMvsPvPCFQLnmsNTjRkCYJttfGc5b2Z0cjwOuGLAyihI1H4PIBVzRFpOHgNCFMbxhjxQahXQPJJxZjofrB7LA6GSUxbMl+uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M79RpxzT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M79RpxzT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77382C2BCB0;
	Tue, 12 May 2026 16:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778603309;
	bh=Wa7NpHKF7nL0Sj9JFI+m2JxaqGNaZ9G47B8JXLkGCI4=;
	h=From:To:Cc:Subject:Date:From;
	b=M79RpxzT/Uhk3aRFTzqnwo3CmoqLKZilsk2rHUh2s/5Y7GSGU15MKpAj+KNfT/K3r
	 tIJg4GfaUbC2Dd0KXcVvwJdZCnojuTQ3YE0tGgf9ZnfWkB3jZBsobRiPaV9vjXHcD8
	 4jdt0072dhG3F7EDPA4Dzx7dznjyRQ3QI3ssC/98VZzBa6IMlqI0Yot4g0aO3kFb6e
	 LyJ6SCr3hSzhw9GXyfTmhZGuGndzXcaVmvl9MXcXw6OhTwLS9GIShN4MBhXTk5Y4co
	 UYOHxKtvBbRGKE8SVOypK5MRZOVHlAHlIQ0BOTHFM6hTr0fY+8L4Nsvt+ojGdWcJbn
	 XrdzcdP+NdBmQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] iio: light: acpi-als: Check ACPI_COMPANION() against NULL
Date: Tue, 12 May 2026 18:28:26 +0200
Message-ID: <2366919.iZASKD2KPV@rafael.j.wysocki>
Organization: Linux Kernel Development
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

Every platform driver can be forced to match a device that doesn't match
its list of device IDs because of device_match_driver_override(), so
platform drivers that rely on the existence of a device's ACPI companion
object need to verify its presence.

Accordingly, add a requisite ACPI_COMPANION() check against NULL to the
acpi-als IIO driver.

Fixes: d4243cb08a27 ("iio: light: acpi-als: Convert ACPI driver to a platform one")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/iio/light/acpi-als.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/drivers/iio/light/acpi-als.c
+++ b/drivers/iio/light/acpi-als.c
@@ -179,11 +179,15 @@ out:
 static int acpi_als_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	struct acpi_device *device = ACPI_COMPANION(dev);
+	struct acpi_device *device;
 	struct iio_dev *indio_dev;
 	struct acpi_als *als;
 	int ret;
 
+	device = ACPI_COMPANION(dev);
+	if (!device)
+		return -ENODEV;
+
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*als));
 	if (!indio_dev)
 		return -ENOMEM;



