Return-Path: <knaack.h@gmx.de>
From: Hartmut Knaack <knaack.h@gmx.de>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Roberta Dobrescu <roberta.dobrescu@gmail.com>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Irina Tirdea <irina.tirdea@intel.com>
Subject: [PATCH 11/32] tools:iio:generic_buffer: pass up right error code
Date: Sun, 31 May 2015 14:39:57 +0200
Message-Id: <5de1f1440a05a62bac6ecbddb63bd2de97583e20.1433072539.git.knaack.h@gmx.de>
In-Reply-To: <15952408423424396a4ace1522055e17da4afc80.1433072539.git.knaack.h@gmx.de>
References: <15952408423424396a4ace1522055e17da4afc80.1433072539.git.knaack.h@gmx.de>
In-Reply-To: <cover.1433072539.git.knaack.h@gmx.de>
References: <cover.1433072539.git.knaack.h@gmx.de>
List-ID: <linux-iio@vger.kernel.org>

find_type_by_name() returns a valid error code in case of an error. Pass
this code up instead of an artificial one.

Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
---
 tools/iio/generic_buffer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/iio/generic_buffer.c b/tools/iio/generic_buffer.c
index 7e6f3f1..a3cf8e3 100644
--- a/tools/iio/generic_buffer.c
+++ b/tools/iio/generic_buffer.c
@@ -202,7 +202,7 @@ int main(int argc, char **argv)
 	dev_num = find_type_by_name(device_name, "iio:device");
 	if (dev_num < 0) {
 		printf("Failed to find the %s\n", device_name);
-		ret = -ENODEV;
+		ret = dev_num;
 		goto error_ret;
 	}
 	printf("iio device number being used is %d\n", dev_num);
@@ -228,7 +228,7 @@ int main(int argc, char **argv)
 		trig_num = find_type_by_name(trigger_name, "trigger");
 		if (trig_num < 0) {
 			printf("Failed to find the trigger %s\n", trigger_name);
-			ret = -ENODEV;
+			ret = trig_num;
 			goto error_free_triggername;
 		}
 		printf("iio trigger number being used is %d\n", trig_num);
-- 
2.3.6
