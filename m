Return-Path: <SRS0=T1c/=2H=mail.ccsf.edu=kdunne@kernel.org>
Date: Sun, 26 Feb 2017 10:42:45 -0800
From: Katie Dunne <kdunne@mail.ccsf.edu>
To: outreachy-kernel@googlegroups.com
Cc: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	gregkh@linuxfoundation.org, linux-iio@vger.kernel.org
Subject: [RFC 1/3] staging: iio: meter: Remove unused definitions
Message-ID: <972438f1c7bc46153df933c5861fac91f6793e92.1488133199.git.kdunne@mail.ccsf.edu>
References: <cover.1488133199.git.kdunne@mail.ccsf.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1488133199.git.kdunne@mail.ccsf.edu>
List-ID: <linux-iio@vger.kernel.org>

Remove definitions not used in kernel code.

Signed-off-by: Katie Dunne <kdunne@mail.ccsf.edu>
---
 drivers/staging/iio/meter/ade7753.h | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/staging/iio/meter/ade7753.h b/drivers/staging/iio/meter/ade7753.h
index bfe7491..ea9284a 100644
--- a/drivers/staging/iio/meter/ade7753.h
+++ b/drivers/staging/iio/meter/ade7753.h
@@ -1,18 +1,12 @@
 #ifndef _ADE7753_H
 #define _ADE7753_H
 
-#define ADE7753_WAVEFORM   0x01
 #define ADE7753_AENERGY    0x02
-#define ADE7753_RAENERGY   0x03
 #define ADE7753_LAENERGY   0x04
 #define ADE7753_VAENERGY   0x05
-#define ADE7753_RVAENERGY  0x06
 #define ADE7753_LVAENERGY  0x07
-#define ADE7753_LVARENERGY 0x08
 #define ADE7753_MODE       0x09
 #define ADE7753_IRQEN      0x0A
-#define ADE7753_STATUS     0x0B
-#define ADE7753_RSTSTATUS  0x0C
 #define ADE7753_CH1OS      0x0D
 #define ADE7753_CH2OS      0x0E
 #define ADE7753_GAIN       0x0F
@@ -27,22 +21,15 @@
 #define ADE7753_IRMSOS     0x18
 #define ADE7753_VRMSOS     0x19
 #define ADE7753_VAGAIN     0x1A
-#define ADE7753_VADIV      0x1B
 #define ADE7753_LINECYC    0x1C
-#define ADE7753_ZXTOUT     0x1D
 #define ADE7753_SAGCYC     0x1E
 #define ADE7753_SAGLVL     0x1F
 #define ADE7753_IPKLVL     0x20
 #define ADE7753_VPKLVL     0x21
 #define ADE7753_IPEAK      0x22
-#define ADE7753_RSTIPEAK   0x23
 #define ADE7753_VPEAK      0x24
-#define ADE7753_RSTVPEAK   0x25
-#define ADE7753_TEMP       0x26
 #define ADE7753_PERIOD     0x27
-#define ADE7753_TMODE      0x3D
 #define ADE7753_CHKSUM     0x3E
-#define ADE7753_DIEREV     0x3F
 
 #define ADE7753_READ_REG(a)    a
 #define ADE7753_WRITE_REG(a) ((a) | 0x80)
@@ -52,7 +39,6 @@
 #define ADE7753_STARTUP_DELAY 1000
 
 #define ADE7753_SPI_SLOW	(u32)(300 * 1000)
-#define ADE7753_SPI_BURST	(u32)(1000 * 1000)
 #define ADE7753_SPI_FAST	(u32)(2000 * 1000)
 
 /**
-- 
2.7.4
