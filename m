Return-Path: <knaack.h@gmx.de>
From: Hartmut Knaack <knaack.h@gmx.de>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Roberta Dobrescu <roberta.dobrescu@gmail.com>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Irina Tirdea <irina.tirdea@intel.com>
Subject: [PATCH 28/32] tools:iio:iio_utils: initialize count during declaration
Date: Sun, 31 May 2015 14:40:21 +0200
Message-Id: <fe981c1a50daa8bd7aef36061cccdd376894fda0.1433072539.git.knaack.h@gmx.de>
In-Reply-To: <6915cdc58104e623ad388787b9069337f1950614.1433072539.git.knaack.h@gmx.de>
References: <6915cdc58104e623ad388787b9069337f1950614.1433072539.git.knaack.h@gmx.de>
In-Reply-To: <cover.1433072539.git.knaack.h@gmx.de>
References: <cover.1433072539.git.knaack.h@gmx.de>
List-ID: <linux-iio@vger.kernel.org>

In build_channel_array(), count can be initialized already during variable
declaration.

Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
---
 tools/iio/iio_utils.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/iio/iio_utils.c b/tools/iio/iio_utils.c
index 7c0abb3..dfee1a3 100644
--- a/tools/iio/iio_utils.c
+++ b/tools/iio/iio_utils.c
@@ -312,7 +312,7 @@ int build_channel_array(const char *device_dir,
 {
 	DIR *dp;
 	FILE *sysfsfp;
-	int count, i;
+	int count = 0, i;
 	struct iio_channel_info *current;
 	int ret;
 	const struct dirent *ent;
@@ -370,7 +370,6 @@ int build_channel_array(const char *device_dir,
 		goto error_close_dir;
 	}
 	seekdir(dp, 0);
-	count = 0;
 	while (ent = readdir(dp), ent != NULL) {
 		if (strcmp(ent->d_name + strlen(ent->d_name) - strlen("_en"),
 			   "_en") == 0) {
-- 
2.3.6
