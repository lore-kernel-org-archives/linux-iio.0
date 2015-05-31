Return-Path: <knaack.h@gmx.de>
From: Hartmut Knaack <knaack.h@gmx.de>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Roberta Dobrescu <roberta.dobrescu@gmail.com>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Irina Tirdea <irina.tirdea@intel.com>
Subject: [PATCH 13/32] tools:iio:iio_utils: check amount of matches
Date: Sun, 31 May 2015 14:39:59 +0200
Message-Id: <88d7a7f972f2ae63457e5dcbfb25306c417715bd.1433072539.git.knaack.h@gmx.de>
In-Reply-To: <15952408423424396a4ace1522055e17da4afc80.1433072539.git.knaack.h@gmx.de>
References: <15952408423424396a4ace1522055e17da4afc80.1433072539.git.knaack.h@gmx.de>
In-Reply-To: <cover.1433072539.git.knaack.h@gmx.de>
References: <cover.1433072539.git.knaack.h@gmx.de>
List-ID: <linux-iio@vger.kernel.org>

fscanf() usually returns the number of input items successfully matched
and assigned, which can be fewer than provided (or even zero).
Add a check in iioutils_get_type() to make sure all items are matched.

Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
---
 tools/iio/iio_utils.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/iio/iio_utils.c b/tools/iio/iio_utils.c
index f12bc2e..c5b4136 100644
--- a/tools/iio/iio_utils.c
+++ b/tools/iio/iio_utils.c
@@ -144,6 +144,10 @@ int iioutils_get_type(unsigned *is_signed,
 				ret = -errno;
 				printf("failed to pass scan type description\n");
 				goto error_close_sysfsfp;
+			} else if (ret != 5) {
+				ret = -EIO;
+				printf("scan type description didn't match\n");
+				goto error_close_sysfsfp;
 			}
 			*be = (endianchar == 'b');
 			*bytes = padint / 8;
-- 
2.3.6
