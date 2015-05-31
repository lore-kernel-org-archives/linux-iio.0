Return-Path: <knaack.h@gmx.de>
From: Hartmut Knaack <knaack.h@gmx.de>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Roberta Dobrescu <roberta.dobrescu@gmail.com>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Irina Tirdea <irina.tirdea@intel.com>
Subject: [PATCH 03/32] tools:iio:iio_utils: free scan_el_dir on exit
Date: Sun, 31 May 2015 14:39:43 +0200
Message-Id: <86123bc570f6eff3b6a0a033cc17a296b3107d45.1433072539.git.knaack.h@gmx.de>
In-Reply-To: <cover.1433072539.git.knaack.h@gmx.de>
References: <cover.1433072539.git.knaack.h@gmx.de>
In-Reply-To: <cover.1433072539.git.knaack.h@gmx.de>
References: <cover.1433072539.git.knaack.h@gmx.de>
List-ID: <linux-iio@vger.kernel.org>

In the error path, the string scan_el_dir got freed, while it was missing when
build_channel_array() finished without errors.

Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
---
 tools/iio/iio_utils.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/iio/iio_utils.c b/tools/iio/iio_utils.c
index 6f64521..f879ad7 100644
--- a/tools/iio/iio_utils.c
+++ b/tools/iio/iio_utils.c
@@ -403,6 +403,7 @@ int build_channel_array(const char *device_dir,
 	}
 
 	closedir(dp);
+	free(scan_el_dir);
 	/* reorder so that the array is in index order */
 	bsort_channel_array_by_index(ci_array, *counter);
 
-- 
2.3.6
