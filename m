Return-Path: <linux+jic23=kernel.org@arm.linux.org.uk>
Date: Mon, 2 Dec 2013 11:25:58 +0000
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
To: Jacek Anaszewski <j.anaszewski@samsung.com>,
	Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org
Subject: [PATCH] Fix build failure for gp2ap020a00f.c
Message-ID: <20131202112558.GF16735@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: Russell King - ARM Linux <linux@arm.linux.org.uk>
List-ID: <linux-iio@vger.kernel.org>

drivers/built-in.o: In function `gp2ap020a00f_thresh_event_handler':
powercap_sys.c:(.text+0x15f90c): undefined reference to `irq_work_queue'
make[1]: *** [vmlinux] Error 1
make[1]: Target `uImage' not remade because of errors.
make: *** [sub-make] Error 2
make: Target `uImage' not remade because of errors.

You need the IRQ work support, but GP2AP020A00F is not selecting this
symbol.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/iio/light/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
index b0d65df3ede2..a022f27c6690 100644
--- a/drivers/iio/light/Kconfig
+++ b/drivers/iio/light/Kconfig
@@ -43,6 +43,7 @@ config GP2AP020A00F
 	depends on I2C
 	select IIO_BUFFER
 	select IIO_TRIGGERED_BUFFER
+	select IRQ_WORK
 	help
 	  Say Y here if you have a Sharp GP2AP020A00F proximity/ALS combo-chip
 	  hooked to an I2C bus.
