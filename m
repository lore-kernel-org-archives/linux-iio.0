Return-Path: <knaack.h@gmx.de>
From: Hartmut Knaack <knaack.h@gmx.de>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Roberta Dobrescu <roberta.dobrescu@gmail.com>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Irina Tirdea <irina.tirdea@intel.com>
Subject: [PATCH 02/32] tools:iio:generic_buffer: free dev_dir_name on exit
Date: Sun, 31 May 2015 14:39:42 +0200
Message-Id: <b8a6d2c4d9671026a3386e2d05008a33a0ba87c6.1433072539.git.knaack.h@gmx.de>
In-Reply-To: <cover.1433072539.git.knaack.h@gmx.de>
References: <cover.1433072539.git.knaack.h@gmx.de>
In-Reply-To: <cover.1433072539.git.knaack.h@gmx.de>
References: <cover.1433072539.git.knaack.h@gmx.de>
List-ID: <linux-iio@vger.kernel.org>

Make sure to free dev_dir_name in case of an error or regular exit.

Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
---
 tools/iio/generic_buffer.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/iio/generic_buffer.c b/tools/iio/generic_buffer.c
index 15f2a40..7859ee9 100644
--- a/tools/iio/generic_buffer.c
+++ b/tools/iio/generic_buffer.c
@@ -220,7 +220,7 @@ int main(int argc, char **argv)
 				       "%s-dev%d", device_name, dev_num);
 			if (ret < 0) {
 				ret = -ENOMEM;
-				goto error_ret;
+				goto error_free_dev_dir_name;
 			}
 		}
 
@@ -354,6 +354,8 @@ error_free_buf_dir_name:
 error_free_triggername:
 	if (datardytrigger)
 		free(trigger_name);
+error_free_dev_dir_name:
+	free(dev_dir_name);
 error_ret:
 	return ret;
 }
-- 
2.3.6
