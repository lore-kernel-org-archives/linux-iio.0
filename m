Return-Path: <jj@chaosbits.net>
Date: Sun, 5 Feb 2012 01:40:09 +0100 (CET)
From: Jesper Juhl <jj@chaosbits.net>
To: devel@driverdev.osuosl.org
cc: trivial@kernel.org, linux-kernel@vger.kernel.org,
    linux-iio@vger.kernel.org, Paul Gortmaker <paul.gortmaker@windriver.com>,
    Michael Hennerich <michael.hennerich@analog.com>,
    Lars-Peter Clausen <lars@metafoo.de>,
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
    Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH] Staging: The header linux/module.h is included twice in
 drivers/staging/iio/dac/ad5686.c
Message-ID: <alpine.LNX.2.00.1202050138250.30244@swampdragon.chaosbits.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <linux-iio@vger.kernel.org>

Remove the unneeded duplicate.

Signed-off-by: Jesper Juhl <jj@chaosbits.net>
---
 drivers/staging/iio/dac/ad5686.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/staging/iio/dac/ad5686.c b/drivers/staging/iio/dac/ad5686.c
index ce2d619..2415a6e 100644
--- a/drivers/staging/iio/dac/ad5686.c
+++ b/drivers/staging/iio/dac/ad5686.c
@@ -15,7 +15,6 @@
 #include <linux/slab.h>
 #include <linux/sysfs.h>
 #include <linux/regulator/consumer.h>
-#include <linux/module.h>
 
 #include "../iio.h"
 #include "../sysfs.h"
-- 
1.7.9


-- 
Jesper Juhl <jj@chaosbits.net>       http://www.chaosbits.net/
Don't top-post http://www.catb.org/jargon/html/T/top-post.html
Plain text mails only, please.
