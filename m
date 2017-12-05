Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lf0-f67.google.com ([209.85.215.67]:39866 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752911AbdLEK5e (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 5 Dec 2017 05:57:34 -0500
Received: by mail-lf0-f67.google.com with SMTP id l81so22698835lfl.6
        for <linux-iio@vger.kernel.org>; Tue, 05 Dec 2017 02:57:34 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>,
        Gregor Boirie <gregor.boirie@parrot.com>
Subject: [PATCH] iio: ABI: Fix name of timestamp sysfs file
Date: Tue,  5 Dec 2017 11:57:27 +0100
Message-Id: <20171205105727.3737-1-linus.walleij@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The name of the file is "current_timetamp_clock" not
"timestamp_clock".

Fixes: bc2b7dab629a ("iio:core: timestamping clock selection support")
Cc: Gregor Boirie <gregor.boirie@parrot.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 Documentation/ABI/testing/sysfs-bus-iio | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 2e3f919485f4..fdec308a5041 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -32,7 +32,7 @@ Description:
 		Description of the physical chip / device for device X.
 		Typically a part number.
 
-What:		/sys/bus/iio/devices/iio:deviceX/timestamp_clock
+What:		/sys/bus/iio/devices/iio:deviceX/current_timestamp_clock
 KernelVersion:	4.5
 Contact:	linux-iio@vger.kernel.org
 Description:
-- 
2.14.3

