Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:39836 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753578AbcJIKia (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 9 Oct 2016 06:38:30 -0400
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        Gregkh@linuxfoundation.org, Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH] staging:iio:TODO drop outdated entries in this todo.
Date: Sun,  9 Oct 2016 11:38:19 +0100
Message-Id: <20161009103819.8751-1-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

There is still stuff to be done in the remaining drivers but pretty much
nothing was left from this original TODO.

Sorry Greg, should have been keeping this up to date.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/TODO | 70 +-----------------------------------------------
 1 file changed, 1 insertion(+), 69 deletions(-)

diff --git a/drivers/staging/iio/TODO b/drivers/staging/iio/TODO
index 93a896883e37..4922402e2e98 100644
--- a/drivers/staging/iio/TODO
+++ b/drivers/staging/iio/TODO
@@ -1,76 +1,8 @@
-2009 8/18
-
-Core:
-1) Get reviews
-2) Additional testing
-3) Ensure all desirable features present by adding more devices.
-   Major changes not expected except in response to comments
-
-Max1363 core:
-1) Possibly add sysfs exports of constant useful to userspace.
-Would be nice
-2) Support hardware generated interrupts
-3) Expand device set. Lots of other maxim adc's have very
-   similar interfaces.
-
-MXS LRADC driver:
-This is a classic MFD device as it combines the following subdevices
- - touchscreen controller (input subsystem related device)
- - general purpose ADC channels
- - battery voltage monitor (power subsystem related device)
- - die temperature monitor (thermal management)
-
-At least the battery voltage and die temperature feature is required in-kernel
-by a driver of the SoC's battery charging unit to avoid any damage to the
-silicon and the battery.
-
-TSL2561
-Would be nice
-1) Open question of userspace vs kernel space balance when
-converting to useful light measurements from device ones.
-2) Add sysfs elements necessary to allow device agnostic
-unit conversion.
-
-LIS3L02DQ core
-
-LIS3L02DQ ring
-
-KXSD9
-Currently minimal driver, would be nice to add:
-1) Support for all chip generated interrupts (events),
-basically get support up to level of lis3l02dq driver.
-
-Ring buffer core
-
-SCA3000
-Would be nice
-1) Testing on devices other than sca3000-e05
-
-Trigger core support
-1) Discussion of approach. Is it general enough?
-
-Ring Buffer:
-1) Discussion of approach.
-There are probably better ways of doing this. The
-intention is to allow for more than one software ring
-buffer implementation as different users will have
-different requirements.  This one suits mid range
-frequencies (100Hz - 4kHz).
-2) Lots of testing
-
-GPIO trigger
-1) Add control over the type of interrupt etc.  This will
-necessitate a header that is also visible from arch board
-files. (avoided at the moment to keep the driver set
-contained in staging).
+2016 10/09
 
 ADI Drivers:
 CC the device-drivers-devel@blackfin.uclinux.org mailing list when
 e-mailing the normal IIO list (see below).
 
-Documentation
-1) Lots of cleanup and expansion.
-2) Some device require individual docs.
-
 Contact: Jonathan Cameron <jic23@kernel.org>.
 Mailing list: linux-iio@vger.kernel.org
-- 
2.10.0

