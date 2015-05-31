Return-Path: <knaack.h@gmx.de>
From: Hartmut Knaack <knaack.h@gmx.de>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Roberta Dobrescu <roberta.dobrescu@gmail.com>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Irina Tirdea <irina.tirdea@intel.com>
Subject: [PATCH 27/32] tools:iio:iio_utils: move up reset of sysfsfp
Date: Sun, 31 May 2015 14:40:20 +0200
Message-Id: <564df06b5e0dc5911a68b208eeb0687a772ac5bf.1433072539.git.knaack.h@gmx.de>
In-Reply-To: <6915cdc58104e623ad388787b9069337f1950614.1433072539.git.knaack.h@gmx.de>
References: <6915cdc58104e623ad388787b9069337f1950614.1433072539.git.knaack.h@gmx.de>
In-Reply-To: <cover.1433072539.git.knaack.h@gmx.de>
References: <cover.1433072539.git.knaack.h@gmx.de>
List-ID: <linux-iio@vger.kernel.org>

In iioutils_get_type() it is logically better fitting to have sysfsfp
assigned zero right after closing it.

Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
---
 tools/iio/iio_utils.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/iio/iio_utils.c b/tools/iio/iio_utils.c
index c83f4df..7c0abb3 100644
--- a/tools/iio/iio_utils.c
+++ b/tools/iio/iio_utils.c
@@ -175,10 +175,10 @@ int iioutils_get_type(unsigned *is_signed,
 				goto error_free_filename;
 			}
 
+			sysfsfp = 0;
 			free(filename);
 
 			filename = 0;
-			sysfsfp = 0;
 		}
 error_close_sysfsfp:
 	if (sysfsfp)
-- 
2.3.6
