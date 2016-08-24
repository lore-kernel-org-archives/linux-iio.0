Return-Path: <gregor.boirie@parrot.com>
From: Gregor Boirie <gregor.boirie@parrot.com>
To: <linux-iio@vger.kernel.org>
CC: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler
	<pmeerw@pmeerw.net>, Gregor Boirie <gregor.boirie@parrot.com>
Subject: [PATCH v1 1/1] tools:iio:iio_generic_buffer: fix trigger-less mode
Date: Wed, 24 Aug 2016 15:28:27 +0200
Message-ID: <1358a1746e88f7b1bbd6173f1119f39755484ec8.1471946698.git.gregor.boirie@parrot.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

Passing the trigger-less mode option on the command line causes
iio_generic_buffer to fail searching for an IIO trigger.
Fix this by skipping trigger initialization if trigger-less mode is
requested.

Signed-off-by: Gregor Boirie <gregor.boirie@parrot.com>
---
 tools/iio/iio_generic_buffer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/iio/iio_generic_buffer.c b/tools/iio/iio_generic_buffer.c
index ae68bf0..f39c0e9 100644
--- a/tools/iio/iio_generic_buffer.c
+++ b/tools/iio/iio_generic_buffer.c
@@ -456,7 +456,7 @@ int main(int argc, char **argv)
 
 	if (notrigger) {
 		printf("trigger-less mode selected\n");
-	} if (trig_num >= 0) {
+	} else if (trig_num >= 0) {
 		char *trig_dev_name;
 		ret = asprintf(&trig_dev_name, "%strigger%d", iio_dir, trig_num);
 		if (ret < 0) {
-- 
2.1.4
