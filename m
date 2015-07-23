Return-Path: <irina.tirdea@intel.com>
From: Irina Tirdea <irina.tirdea@intel.com>
To: Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Hartmut Knaack <knaack.h@gmx.de>,
	Irina Tirdea <irina.tirdea@intel.com>
Subject: [PATCH 1/2] tools: iio: fix mask for 32 bit sensor data
Date: Thu, 23 Jul 2015 20:22:51 +0300
Message-Id: <1437672172-21189-2-git-send-email-irina.tirdea@intel.com>
In-Reply-To: <1437672172-21189-1-git-send-email-irina.tirdea@intel.com>
References: <1437672172-21189-1-git-send-email-irina.tirdea@intel.com>
List-ID: <linux-iio@vger.kernel.org>

When the the sensor data uses 32 bits out of 32, generic_buffer prints
the value 0 for all data read.

In this case, the mask is shifted 32 bits, which is beyond the size of
an integer. This will lead to the mask always being 0. Before printing,
the mask is applied to the raw value, thus generating a final value of 0.

Fix the mask by shifting a 64 bit value instead of an integer.

Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
---
 tools/iio/iio_utils.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/iio/iio_utils.c b/tools/iio/iio_utils.c
index 1dcdf03..a95270f 100644
--- a/tools/iio/iio_utils.c
+++ b/tools/iio/iio_utils.c
@@ -168,7 +168,7 @@ int iioutils_get_type(unsigned *is_signed, unsigned *bytes, unsigned *bits_used,
 			if (*bits_used == 64)
 				*mask = ~0;
 			else
-				*mask = (1 << *bits_used) - 1;
+				*mask = (1ULL << *bits_used) - 1;
 
 			*is_signed = (signchar == 's');
 			if (fclose(sysfsfp)) {
-- 
1.9.1
