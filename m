Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.218]:11398 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726356AbeKZE5E (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 25 Nov 2018 23:57:04 -0500
From: Stephan Gerhold <stephan@gerhold.net>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH] iio: magnetometer: ak8975: Add the "AKM9911" ACPI HID
Date: Sun, 25 Nov 2018 19:02:40 +0100
Message-Id: <20181125180240.9885-1-stephan@gerhold.net>
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This HID is used on the ASUS MeMO Pad 7 (ME176C) tablet.

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 drivers/iio/magnetometer/ak8975.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
index 42a827a66512..d430b80808ef 100644
--- a/drivers/iio/magnetometer/ak8975.c
+++ b/drivers/iio/magnetometer/ak8975.c
@@ -790,6 +790,7 @@ static const struct acpi_device_id ak_acpi_match[] = {
 	{"INVN6500", AK8963},
 	{"AK009911", AK09911},
 	{"AK09911", AK09911},
+	{"AKM9911", AK09911},
 	{"AK09912", AK09912},
 	{ },
 };
-- 
2.19.2
