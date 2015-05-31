Return-Path: <knaack.h@gmx.de>
From: Hartmut Knaack <knaack.h@gmx.de>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Roberta Dobrescu <roberta.dobrescu@gmail.com>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Irina Tirdea <irina.tirdea@intel.com>
Subject: [PATCH 15/32] tools:iio:iio_utils: mark private function static
Date: Sun, 31 May 2015 14:40:01 +0200
Message-Id: <b242bf0ae860f23449a40acb81f0ab641f8e2d32.1433072539.git.knaack.h@gmx.de>
In-Reply-To: <15952408423424396a4ace1522055e17da4afc80.1433072539.git.knaack.h@gmx.de>
References: <15952408423424396a4ace1522055e17da4afc80.1433072539.git.knaack.h@gmx.de>
In-Reply-To: <cover.1433072539.git.knaack.h@gmx.de>
References: <cover.1433072539.git.knaack.h@gmx.de>
List-ID: <linux-iio@vger.kernel.org>

Functions _write_sysfs_int() and _write_sysfs_string() are supposed to
be called only by public wrappers, so make them static.

Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
---
 tools/iio/iio_utils.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/iio/iio_utils.c b/tools/iio/iio_utils.c
index 60e5ec4..812153f 100644
--- a/tools/iio/iio_utils.c
+++ b/tools/iio/iio_utils.c
@@ -524,7 +524,7 @@ error_close_dir:
 	return ret;
 }
 
-int _write_sysfs_int(char *filename, char *basedir, int val, int verify)
+static int _write_sysfs_int(char *filename, char *basedir, int val, int verify)
 {
 	int ret = 0;
 	FILE *sysfsfp;
@@ -574,7 +574,8 @@ int write_sysfs_int_and_verify(char *filename, char *basedir, int val)
 	return _write_sysfs_int(filename, basedir, val, 1);
 }
 
-int _write_sysfs_string(char *filename, char *basedir, char *val, int verify)
+static int _write_sysfs_string(char *filename, char *basedir, char *val,
+			       int verify)
 {
 	int ret = 0;
 	FILE  *sysfsfp;
-- 
2.3.6
