Return-Path: <dan.carpenter@oracle.com>
Date: Tue, 11 Oct 2016 14:12:29 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org
Subject: [PATCH] Staging: iio: fix a MAINTAINERS entry
Message-ID: <20161011111129.GA16475@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-iio@vger.kernel.org>

The "drivers/" part of the path name was missing.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/MAINTAINERS b/MAINTAINERS
index 0c7d973..63f15c9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -779,7 +779,7 @@ S:	Supported
 F:	drivers/iio/*/ad*
 X:	drivers/iio/*/adjd*
 F:	drivers/staging/iio/*/ad*
-F:	staging/iio/trigger/iio-trig-bfin-timer.c
+F:	drivers/staging/iio/trigger/iio-trig-bfin-timer.c
 
 ANALOG DEVICES INC DMA DRIVERS
 M:	Lars-Peter Clausen <lars@metafoo.de>
