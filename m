Return-Path: <jic23@hermes.cam.ac.uk>
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	greg@kroah.com
Cc: lars@metafoo.de,
	Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 19/19] staging:iio:buffer.h update struct buffer docs.
Date: Mon,  5 Dec 2011 22:18:30 +0000
Message-Id: <1323123510-21388-20-git-send-email-jic23@kernel.org>
In-Reply-To: <1323123510-21388-1-git-send-email-jic23@kernel.org>
References: <1323123510-21388-1-git-send-email-jic23@kernel.org>
Sender: "J.I. Cameron" <jic23@hermes.cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

These docs have lagged recent developments.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/buffer.h |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/iio/buffer.h b/drivers/staging/iio/buffer.h
index 9b1a4f1..c697099 100644
--- a/drivers/staging/iio/buffer.h
+++ b/drivers/staging/iio/buffer.h
@@ -70,9 +70,15 @@ struct iio_buffer_access_funcs {
  * @scan_el_attrs:	[DRIVER] control of scan elements if that scan mode
  *			control method is used
  * @scan_mask:		[INTERN] bitmask used in masking scan mode elements
+ * @scan_index_timestamp:[INTERN] cache of the index to the timestamp
  * @scan_timestamp:	[INTERN] does the scan mode include a timestamp
  * @access:		[DRIVER] buffer access functions associated with the
  *			implementation.
+ * @scan_el_dev_attr_list:[INTERN] list of scan element related attributes.
+ * @scan_el_group:	[DRIVER] attribute group for those attributes not
+ *			created from the iio_chan_info array.
+ * @pollq:		[INTERN] wait queue to allow for polling on the buffer.
+ * @stufftoread:	[INTERN] flag to indicate new data.
  * @flags:		[INTERN] file ops related flags including busy flag.
  * @demux_list:		[INTERN] list of operations required to demux the scan.
  * @demux_bounce:	[INTERN] buffer for doing gather from incoming scan.
-- 
1.7.7.4
