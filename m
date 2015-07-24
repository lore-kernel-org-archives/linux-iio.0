Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:35118 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754681AbbGXN3I (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 24 Jul 2015 09:29:08 -0400
From: Irina Tirdea <irina.tirdea@intel.com>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	Hartmut Knaack <knaack.h@gmx.de>
Cc: linux-kernel@vger.kernel.org, Irina Tirdea <irina.tirdea@intel.com>
Subject: [PATCH v2 2/2] tools: iio: print error message when buffer enable fails
Date: Fri, 24 Jul 2015 16:28:06 +0300
Message-Id: <1437744486-16456-3-git-send-email-irina.tirdea@intel.com>
In-Reply-To: <1437744486-16456-1-git-send-email-irina.tirdea@intel.com>
References: <1437744486-16456-1-git-send-email-irina.tirdea@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Running generic_buffer without enabling any channel of the
sensor will fail without printing any error message.

Add an error message that indicates buffer enable failed.

Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
---
 tools/iio/generic_buffer.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/iio/generic_buffer.c b/tools/iio/generic_buffer.c
index 32f389eb..9f7b85b 100644
--- a/tools/iio/generic_buffer.c
+++ b/tools/iio/generic_buffer.c
@@ -364,8 +364,11 @@ int main(int argc, char **argv)
 
 	/* Enable the buffer */
 	ret = write_sysfs_int("enable", buf_dir_name, 1);
-	if (ret < 0)
+	if (ret < 0) {
+		fprintf(stderr,
+			"Failed to enable buffer: %s\n", strerror(-ret));
 		goto error_free_buf_dir_name;
+	}
 
 	scan_size = size_from_channelarray(channels, num_channels);
 	data = malloc(scan_size * buf_len);
-- 
1.9.1

