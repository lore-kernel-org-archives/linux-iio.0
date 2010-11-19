Return-Path: <Michael.Hennerich@analog.com>
From: "Hennerich, Michael" <Michael.Hennerich@analog.com>
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"device-drivers-devel@blackfin.uclinux.org"
	<device-drivers-devel@blackfin.uclinux.org>
Date: Fri, 19 Nov 2010 08:33:07 +0000
Subject: RFC: more consitent DAC sysfs attributes naming
Message-ID: <544AC56F16B56944AEC3BD4E3D591771312EE15286@LIMKCMBX1.ad.analog.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

Hi Jonathan,

I wonder if it would make more sense to use this...

drivers/staging/iio/dac/dac.h |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/iio/dac/dac.h b/drivers/staging/iio/dac/dac.h
index 55005ee..62620ed 100644
--- a/drivers/staging/iio/dac/dac.h
+++ b/drivers/staging/iio/dac/dac.h
@@ -2,5 +2,9 @@
  * dac.h - sysfs attributes associated with DACs
  */

+/* Deprecated */
 #define IIO_DEV_ATTR_DAC(_num, _store, _addr)                  \
        IIO_DEVICE_ATTR(dac_##_num, S_IWUSR, NULL, _store, _addr)
+
+#define IIO_DEV_ATTR_OUT_RAW(_num, _show, _addr)                          =
     \
+       IIO_DEVICE_ATTR(out##_num##_raw, S_IWUSR, _show, NULL, _addr)


Greetings,
Michael

--
Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft Muenchen, Registergericht Muenchen HRB 4036
Geschaeftsfuehrer Thomas Wessel, William A. Martin, Margaret Seif
