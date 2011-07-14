Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:34260 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752521Ab1GNJYG (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 14 Jul 2011 05:24:06 -0400
Message-ID: <4E1EB5B2.6000105@cam.ac.uk>
Date: Thu, 14 Jul 2011 10:24:02 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Randy Dunlap <rdunlap@xenotime.net>
CC: driverdevel <devel@driverdev.osuosl.org>,
	linux-iio@vger.kernel.org,
	"Hennerich, Michael" <Michael.Hennerich@analog.com>
Subject: Re: staging/iio/meter/ade7753: 406:19: warning: right shift by bigger
 than source value
References: <20110713084909.8ee94a75.rdunlap@xenotime.net>
In-Reply-To: <20110713084909.8ee94a75.rdunlap@xenotime.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/13/11 16:49, Randy Dunlap wrote:
> 
> static ssize_t ade7753_read_frequency(struct device *dev,
> 		struct device_attribute *attr,
> 		char *buf)
> {
> 	int ret, len = 0;
> 	u8 t;
> 	int sps;
> 	ret = ade7753_spi_read_reg_8(dev, ADE7753_MODE,	&t);
> 	if (ret)
> 		return ret;
> 
> 	t = (t >> 11) & 0x3; /// HUH?
> 
Excellent question. Honestly I've passed that line by several times but always whilst
working on something else and had no real idea of what it is actually meant to be
doing.  Clearly it's garbage.

So time for some datasheet trawling.  The mode register is 16 bit, so I'm guessing that
should have been u16 t; and ade7753_spi_read_reg_16.  I think this is a cut and paste
bug form the ade7754 driver where the equivalent is an 8 bit register.  Patch below.

Michael, do you have access to test hardware for this one?  I might do a more general
tidy up of that driver whilst I'm here. Something fun to do before coffee ;)

Thanks,

Jonathan

Subject: [PATCH] staging:iio:meter:ade7753 should be 16 bit read not 8 bit for mode register.

Build tested only.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
Reported-by: Randy Dunlap <rdunlap@xenotime.net>

---
 drivers/staging/iio/meter/ade7753.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/meter/ade7753.c b/drivers/staging/iio/meter/ade7753.c
index 59f47fd..482e16a 100644
--- a/drivers/staging/iio/meter/ade7753.c
+++ b/drivers/staging/iio/meter/ade7753.c
@@ -398,9 +398,9 @@ static ssize_t ade7753_read_frequency(struct device *dev,
 		char *buf)
 {
 	int ret, len = 0;
-	u8 t;
+	u16 t;
 	int sps;
-	ret = ade7753_spi_read_reg_8(dev, ADE7753_MODE,	&t);
+	ret = ade7753_spi_read_reg_16(dev, ADE7753_MODE, &t);
 	if (ret)
 		return ret;
 
-- 
1.7.3.4

