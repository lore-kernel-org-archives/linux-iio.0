Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:42916 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755179Ab1I3WHS (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 30 Sep 2011 18:07:18 -0400
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: gregkh@suse.de
Cc: linux-iio@vger.kernel.org, linux-next@vger.kernel.org,
	Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH] staging: add module.h to various iio drivers
Date: Fri, 30 Sep 2011 18:06:58 -0400
Message-Id: <1317420418-28335-1-git-send-email-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Since they are assuming it is there implicitly and will fail otherwise
with things like:

drivers/staging/iio/impedance-analyzer/ad5933.c:816: warning: type
 defaults to =E2=80=98int=E2=80=99 in declaration of =E2=80=98MODULE_AU=
THOR=E2=80=99

drivers/staging/iio/adc/ad7280a.c:990: warning: type defaults to =E2=80=
=98int=E2=80=99
 in declaration of =E2=80=98MODULE_AUTHOR=E2=80=99

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>

diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/ad=
c/ad7280a.c
index ab6cf9c..6ca4532 100644
--- a/drivers/staging/iio/adc/ad7280a.c
+++ b/drivers/staging/iio/adc/ad7280a.c
@@ -14,6 +14,7 @@
 #include <linux/err.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
+#include <linux/module.h>
=20
 #include "../iio.h"
 #include "../sysfs.h"
diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/=
staging/iio/impedance-analyzer/ad5933.c
index acc0e69..5783742 100644
--- a/drivers/staging/iio/impedance-analyzer/ad5933.c
+++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
@@ -16,6 +16,7 @@
 #include <linux/types.h>
 #include <linux/err.h>
 #include <linux/delay.h>
+#include <linux/module.h>
 #include <asm/div64.h>
=20
 #include "../iio.h"
--=20
1.7.6

