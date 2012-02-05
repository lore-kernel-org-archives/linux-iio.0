Return-Path: <jj@chaosbits.net>
Date: Sun, 5 Feb 2012 01:42:09 +0100 (CET)
From: Jesper Juhl <jj@chaosbits.net>
To: devel@driverdev.osuosl.org
cc: trivial@kernel.org, linux-kernel@vger.kernel.org,
    linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
    Paul Gortmaker <paul.gortmaker@windriver.com>,
    Michael Hennerich <michael.hennerich@analog.com>,
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
    Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH] Staging: Don't double-include linux/module.h in
 drivers/staging/iio/gyro/adis16060_core.c
Message-ID: <alpine.LNX.2.00.1202050140430.30244@swampdragon.chaosbits.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <linux-iio@vger.kernel.org>


Signed-off-by: Jesper Juhl <jj@chaosbits.net>
---
 drivers/staging/iio/gyro/adis16060_core.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/staging/iio/gyro/adis16060_core.c b/drivers/staging/iio/gyro/adis16060_core.c
index c0ca709..02cc234 100644
--- a/drivers/staging/iio/gyro/adis16060_core.c
+++ b/drivers/staging/iio/gyro/adis16060_core.c
@@ -14,7 +14,6 @@
 #include <linux/spi/spi.h>
 #include <linux/slab.h>
 #include <linux/sysfs.h>
-#include <linux/module.h>
 
 #include "../iio.h"
 #include "../sysfs.h"
-- 
1.7.9


-- 
Jesper Juhl <jj@chaosbits.net>       http://www.chaosbits.net/
Don't top-post http://www.catb.org/jargon/html/T/top-post.html
Plain text mails only, please.
