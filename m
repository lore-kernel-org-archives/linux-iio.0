Return-Path: <roberta.dobrescu@gmail.com>
From: Roberta Dobrescu <roberta.dobrescu@gmail.com>
To: linux-iio@vger.kernel.org
Cc: daniel.baluta@intel.com,
	octavian.purdila@intel.com,
	jic23@kernel.org,
	knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	Roberta Dobrescu <roberta.dobrescu@gmail.com>
Subject: [PATCH 5/5] tools: iio: lsiio: Remove unused variables
Date: Thu, 26 Feb 2015 10:49:27 +0200
Message-Id: <1424940567-24877-6-git-send-email-roberta.dobrescu@gmail.com>
In-Reply-To: <1424940567-24877-1-git-send-email-roberta.dobrescu@gmail.com>
References: <1424940567-24877-1-git-send-email-roberta.dobrescu@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

This patch removes unused variables from lsiio.c in order
to get rid of the warnings regarding them.

Signed-off-by: Roberta Dobrescu <roberta.dobrescu@gmail.com>
---
 tools/iio/lsiio.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/tools/iio/lsiio.c b/tools/iio/lsiio.c
index 98a0de0..c585440 100644
--- a/tools/iio/lsiio.c
+++ b/tools/iio/lsiio.c
@@ -95,12 +95,7 @@ static int dump_one_trigger(const char *dev_dir_name)
 static void dump_devices(void)
 {
 	const struct dirent *ent;
-	int number, numstrlen;
-
-	FILE *nameFile;
 	DIR *dp;
-	char thisname[IIO_MAX_NAME_LENGTH];
-	char *filename;
 
 	dp = opendir(iio_dir);
 	if (dp == NULL) {
-- 
1.9.1
