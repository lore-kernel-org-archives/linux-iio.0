Return-Path: <knaack.h@gmx.de>
From: Hartmut Knaack <knaack.h@gmx.de>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Roberta Dobrescu <roberta.dobrescu@gmail.com>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Irina Tirdea <irina.tirdea@intel.com>
Subject: [PATCH 26/32] tools:iio:iio_utils: refactor assignment of is_signed
Date: Sun, 31 May 2015 14:40:19 +0200
Message-Id: <85426b9fbf8cdaafa602984df5d9d1889aeab261.1433072539.git.knaack.h@gmx.de>
In-Reply-To: <6915cdc58104e623ad388787b9069337f1950614.1433072539.git.knaack.h@gmx.de>
References: <6915cdc58104e623ad388787b9069337f1950614.1433072539.git.knaack.h@gmx.de>
In-Reply-To: <cover.1433072539.git.knaack.h@gmx.de>
References: <cover.1433072539.git.knaack.h@gmx.de>
List-ID: <linux-iio@vger.kernel.org>

Change the assignment of *is_signed in iioutils_get_type() to a one-liner,
as already done with *be.

Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
---
 tools/iio/iio_utils.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/tools/iio/iio_utils.c b/tools/iio/iio_utils.c
index 0524725..c83f4df 100644
--- a/tools/iio/iio_utils.c
+++ b/tools/iio/iio_utils.c
@@ -168,10 +168,7 @@ int iioutils_get_type(unsigned *is_signed,
 				*mask = ~0;
 			else
 				*mask = (1 << *bits_used) - 1;
-			if (signchar == 's')
-				*is_signed = 1;
-			else
-				*is_signed = 0;
+			*is_signed = (signchar == 's');
 			if (fclose(sysfsfp)) {
 				ret = -errno;
 				printf("Failed to close %s\n", filename);
-- 
2.3.6
