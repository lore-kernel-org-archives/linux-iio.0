Return-Path: <leonard.crestez@intel.com>
From: Crestez Dan Leonard <leonard.crestez@intel.com>
To: Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Crestez Dan Leonard <leonard.crestez@intel.com>
Subject: [PATCH] iio: generic_buffer: Fix --trigger-num option
Date: Fri,  3 Jun 2016 21:56:29 +0300
Message-Id: <d3181955589a6b6745cb008edbc24d2a1b8b0892.1464980098.git.leonard.crestez@intel.com>
List-ID: <linux-iio@vger.kernel.org>

Initialize trig_num to -1 and handle trig_num=0 as a valid id.

Fixes: 7c7e9dad (iio: iio_generic_buffer: Add --trigger-num option)
Signed-off-by: Crestez Dan Leonard <leonard.crestez@intel.com>
---
 tools/iio/iio_generic_buffer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/iio/iio_generic_buffer.c b/tools/iio/iio_generic_buffer.c
index e8c3052..0e8a1f7 100644
--- a/tools/iio/iio_generic_buffer.c
+++ b/tools/iio/iio_generic_buffer.c
@@ -341,7 +341,7 @@ int main(int argc, char **argv)
 
 	char *data = NULL;
 	ssize_t read_size;
-	int dev_num = -1, trig_num;
+	int dev_num = -1, trig_num = -1;
 	char *buffer_access = NULL;
 	int scan_size;
 	int noevents = 0;
@@ -456,7 +456,7 @@ int main(int argc, char **argv)
 
 	if (notrigger) {
 		printf("trigger-less mode selected\n");
-	} if (trig_num > 0) {
+	} if (trig_num >= 0) {
 		char *trig_dev_name;
 		ret = asprintf(&trig_dev_name, "%strigger%d", iio_dir, trig_num);
 		if (ret < 0) {
-- 
2.5.5
