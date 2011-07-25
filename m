Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: arnd@arndb.de,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 3/7] ioctl region for IIO.
Date: Mon, 25 Jul 2011 14:18:37 +0100
Message-Id: <1311599921-15729-4-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1311599921-15729-1-git-send-email-jic23@cam.ac.uk>
References: <1311599921-15729-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 Documentation/ioctl/ioctl-number.txt |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/Documentation/ioctl/ioctl-number.txt b/Documentation/ioctl/ioctl-number.txt
index 3a46e36..dcf2b8f 100644
--- a/Documentation/ioctl/ioctl-number.txt
+++ b/Documentation/ioctl/ioctl-number.txt
@@ -220,6 +220,7 @@ Code  Seq#(hex)	Include File		Comments
 'i'	00-3F	linux/i2o-dev.h		conflict!
 'i'	0B-1F	linux/ipmi.h		conflict!
 'i'	80-8F	linux/i8k.h
+'i'	90-AF	drivers/staging/iio/chrdev.h
 'j'	00-3F	linux/joystick.h
 'k'	00-0F	linux/spi/spidev.h	conflict!
 'k'	00-05	video/kyro.h		conflict!
-- 
1.7.3.4
