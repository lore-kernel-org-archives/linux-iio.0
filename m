Return-Path: <leonard.crestez@intel.com>
From: Crestez Dan Leonard <leonard.crestez@intel.com>
To: Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Crestez Dan Leonard <leonard.crestez@intel.com>
Subject: [RFC 5/7] iio: generic_buffer: Use current_trigger_id
Date: Mon, 23 May 2016 21:40:00 +0300
Message-Id: <292e8079a077ecc66f87327b777ef13dde0f21b4.1464027859.git.leonard.crestez@intel.com>
In-Reply-To: <cover.1464027859.git.leonard.crestez@intel.com>
References: <cover.1464027859.git.leonard.crestez@intel.com>
In-Reply-To: <cover.1464027859.git.leonard.crestez@intel.com>
References: <cover.1464027859.git.leonard.crestez@intel.com>
List-ID: <linux-iio@vger.kernel.org>

This is a preferred alternative to 'current_trigger'.

Signed-off-by: Crestez Dan Leonard <leonard.crestez@intel.com>
---
 tools/iio/generic_buffer.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/iio/generic_buffer.c b/tools/iio/generic_buffer.c
index e8c3052..b23371a 100644
--- a/tools/iio/generic_buffer.c
+++ b/tools/iio/generic_buffer.c
@@ -582,12 +582,12 @@ int main(int argc, char **argv)
 		 * Set the device trigger to be the data ready trigger found
 		 * above
 		 */
-		ret = write_sysfs_string_and_verify("trigger/current_trigger",
-						    dev_dir_name,
-						    trigger_name);
+		ret = write_sysfs_int_and_verify("trigger/current_trigger_id",
+						 dev_dir_name,
+						 trig_num);
 		if (ret < 0) {
 			fprintf(stderr,
-				"Failed to write current_trigger file\n");
+				"Failed to write current_trigger_id file\n");
 			goto error;
 		}
 	}
-- 
2.5.5
