Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from tarvos.retrosnub.co.uk ([217.168.153.95]:60322 "EHLO
        tarvos.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933921AbdABT2y (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 2 Jan 2017 14:28:54 -0500
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Daniel Baluta <daniel.baluta@gmail.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 02/11] iio:buffer.h Reformat structure comments to be inline.
Date: Mon,  2 Jan 2017 19:28:25 +0000
Message-Id: <20170102192834.26546-3-jic23@kernel.org>
In-Reply-To: <20170102192834.26546-1-jic23@kernel.org>
References: <20170102192834.26546-1-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This should make it easier to see how the structure is split into
public and private parts - reflected in the generated documentation.

Deliberately use /* instead of /** for the private elements to avoid
warnings when kernel-doc script runs.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 include/linux/iio/buffer.h | 100 ++++++++++++++++++++++++++++-----------------
 1 file changed, 63 insertions(+), 37 deletions(-)

diff --git a/include/linux/iio/buffer.h b/include/linux/iio/buffer.h
index 889d0f2f5d7b..4a65a7bb40a4 100644
--- a/include/linux/iio/buffer.h
+++ b/include/linux/iio/buffer.h
@@ -74,45 +74,71 @@ struct iio_buffer_access_funcs {
 
 /**
  * struct iio_buffer - general buffer structure
- * @length:		[DEVICE] number of datums in buffer
- * @bytes_per_datum:	[DEVICE] size of individual datum including timestamp
- * @scan_el_attrs:	[DRIVER] control of scan elements if that scan mode
- *			control method is used
- * @scan_mask:		[INTERN] bitmask used in masking scan mode elements
- * @scan_timestamp:	[INTERN] does the scan mode include a timestamp
- * @access:		[DRIVER] buffer access functions associated with the
- *			implementation.
- * @scan_el_dev_attr_list:[INTERN] list of scan element related attributes.
- * @buffer_group:	[INTERN] attributes of the buffer group
- * @scan_el_group:	[DRIVER] attribute group for those attributes not
- *			created from the iio_chan_info array.
- * @pollq:		[INTERN] wait queue to allow for polling on the buffer.
- * @stufftoread:	[INTERN] flag to indicate new data.
- * @attrs:		[INTERN] standard attributes of the buffer
- * @demux_list:		[INTERN] list of operations required to demux the scan.
- * @demux_bounce:	[INTERN] buffer for doing gather from incoming scan.
- * @buffer_list:	[INTERN] entry in the devices list of current buffers.
- * @ref:		[INTERN] reference count of the buffer.
- * @watermark:		[INTERN] number of datums to wait for poll/read.
+ *
+ * Note that the internals of this structure should only be of interest to
+ * those writing new buffer implementations.
  */
 struct iio_buffer {
-	int					length;
-	int					bytes_per_datum;
-	struct attribute_group			*scan_el_attrs;
-	long					*scan_mask;
-	bool					scan_timestamp;
-	const struct iio_buffer_access_funcs	*access;
-	struct list_head			scan_el_dev_attr_list;
-	struct attribute_group			buffer_group;
-	struct attribute_group			scan_el_group;
-	wait_queue_head_t			pollq;
-	bool					stufftoread;
-	const struct attribute			**attrs;
-	struct list_head			demux_list;
-	void					*demux_bounce;
-	struct list_head			buffer_list;
-	struct kref				ref;
-	unsigned int				watermark;
+	/** @length: Number of datums in buffer. */
+	int length;
+
+	/**  @bytes_per_datum: Size of individual datum including timestamp. */
+	int bytes_per_datum;
+
+	/**
+	 * @access: Buffer access functions associated with the
+	 * implementation.
+	 */
+	const struct iio_buffer_access_funcs *access;
+
+	/** @scan_mask: Bitmask used in masking scan mode elements. */
+	long *scan_mask;
+
+	/** @demux_list: List of operations required to demux the scan. */
+	struct list_head demux_list;
+
+	/** @pollq: Wait queue to allow for polling on the buffer. */
+	wait_queue_head_t pollq;
+
+	/** @watermark: Number of datums to wait for poll/read. */
+	unsigned int watermark;
+
+	/* private: */
+	/*
+	 * @scan_el_attrs: Control of scan elements if that scan mode
+	 * control method is used.
+	 */
+	struct attribute_group *scan_el_attrs;
+
+	/* @scan_timestamp: Does the scan mode include a timestamp. */
+	bool scan_timestamp;
+
+	/* @scan_el_dev_attr_list: List of scan element related attributes. */
+	struct list_head scan_el_dev_attr_list;
+
+	/* @buffer_group: Attributes of the buffer group. */
+	struct attribute_group buffer_group;
+
+	/*
+	 * @scan_el_group: Attribute group for those attributes not
+	 * created from the iio_chan_info array.
+	 */
+	struct attribute_group scan_el_group;
+
+	/* @stufftoread: Flag to indicate new data. */
+	bool stufftoread;
+
+	/* @attrs: Standard attributes of the buffer. */
+	const struct attribute **attrs;
+
+	/* @demux_bounce: Buffer for doing gather from incoming scan. */
+	void *demux_bounce;
+
+	/* @buffer_list: Entry in the devices list of current buffers. */
+	struct list_head buffer_list;
+
+	/* @ref: Reference count of the buffer. */
+	struct kref ref;
 };
 
 /**
-- 
2.11.0

