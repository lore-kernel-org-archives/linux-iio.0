Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wg0-f46.google.com ([74.125.82.46]:34992 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751966AbbGMNSc (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 13 Jul 2015 09:18:32 -0400
Date: Mon, 13 Jul 2015 16:17:47 +0300
From: Cristina Opriceana <cristina.opriceana@gmail.com>
To: jic23@kernel.org
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	daniel.baluta@intel.com, octavian.purdila@intel.com
Subject: [PATCH 2/3] tools: iio: Remove unnecessary braces
Message-ID: <45661e14b247cebfc130518e0c1c44fcec339f0d.1436789446.git.cristina.opriceana@gmail.com>
References: <cover.1436789446.git.cristina.opriceana@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <cover.1436789446.git.cristina.opriceana@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Single statement blocks don’t need braces.
Found with checkpatch.pl.

Signed-off-by: Cristina Opriceana <cristina.opriceana@gmail.com>
---
 tools/iio/iio_event_monitor.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/iio/iio_event_monitor.c b/tools/iio/iio_event_monitor.c
index 703f4cb..9ee1959 100644
--- a/tools/iio/iio_event_monitor.c
+++ b/tools/iio/iio_event_monitor.c
@@ -262,9 +262,8 @@ int main(int argc, char **argv)
 		printf("Found IIO device with name %s with device number %d\n",
 		       device_name, dev_num);
 		ret = asprintf(&chrdev_name, "/dev/iio:device%d", dev_num);
-		if (ret < 0) {
+		if (ret < 0)
 			return -ENOMEM;
-		}
 	} else {
 		/*
 		 * If we can't find an IIO device by name assume device_name is
-- 
1.9.1

