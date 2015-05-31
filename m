Return-Path: <knaack.h@gmx.de>
From: Hartmut Knaack <knaack.h@gmx.de>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Roberta Dobrescu <roberta.dobrescu@gmail.com>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Irina Tirdea <irina.tirdea@intel.com>
Subject: [PATCH 07/32] tools:iio:lsiio: add closedir before exit
Date: Sun, 31 May 2015 14:39:47 +0200
Message-Id: <9fc774508b30727ae7576cbc4cae11fa6bfcd93b.1433072539.git.knaack.h@gmx.de>
In-Reply-To: <cover.1433072539.git.knaack.h@gmx.de>
References: <cover.1433072539.git.knaack.h@gmx.de>
In-Reply-To: <cover.1433072539.git.knaack.h@gmx.de>
References: <cover.1433072539.git.knaack.h@gmx.de>
List-ID: <linux-iio@vger.kernel.org>

In dump_channels() the DIR *dp was left open on exit. Close it and check
for errors.

Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
---
 tools/iio/lsiio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/iio/lsiio.c b/tools/iio/lsiio.c
index c585440..65a2385 100644
--- a/tools/iio/lsiio.c
+++ b/tools/iio/lsiio.c
@@ -56,7 +56,7 @@ static int dump_channels(const char *dev_dir_name)
 			printf("   %-10s\n", ent->d_name);
 		}
 
-	return 0;
+	return (closedir(dp) == -1) ? -errno : 0;
 }
 
 static int dump_one_device(const char *dev_dir_name)
-- 
2.3.6
