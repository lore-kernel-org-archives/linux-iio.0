Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:41071 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753244Ab2DRNOE (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 18 Apr 2012 09:14:04 -0400
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: lars@metafoo.de, Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 14/14] staging:iio: pull out demux cleanup for a particular buffer.
Date: Wed, 18 Apr 2012 14:13:54 +0100
Message-Id: <1334754834-13622-15-git-send-email-jic23@kernel.org>
In-Reply-To: <1334754834-13622-1-git-send-email-jic23@kernel.org>
References: <1334754834-13622-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This will come in handy again when we move to multiple buffers
so lets pull it out into a little utility function now.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/industrialio-buffer.c |   22 +++++++++++++---------
 1 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/iio/industrialio-buffer.c b/drivers/staging/iio/industrialio-buffer.c
index 6c329f9..b409b95 100644
--- a/drivers/staging/iio/industrialio-buffer.c
+++ b/drivers/staging/iio/industrialio-buffer.c
@@ -655,19 +655,25 @@ int iio_push_to_buffer(struct iio_buffer *buffer, unsigned char *data,
 }
 EXPORT_SYMBOL_GPL(iio_push_to_buffer);
 
+static void iio_buffer_demux_free(struct iio_buffer *buffer)
+{
+	struct iio_demux_table *p, *q;
+	list_for_each_entry_safe(p, q, &buffer->demux_list, l) {
+		list_del(&p->l);
+		kfree(p);
+	}
+}
+
 int iio_update_demux(struct iio_dev *indio_dev)
 {
 	const struct iio_chan_spec *ch;
 	struct iio_buffer *buffer = indio_dev->buffer;
 	int ret, in_ind = -1, out_ind, length;
 	unsigned in_loc = 0, out_loc = 0;
-	struct iio_demux_table *p, *q;
+	struct iio_demux_table *p;
 
 	/* Clear out any old demux */
-	list_for_each_entry_safe(p, q, &buffer->demux_list, l) {
-		list_del(&p->l);
-		kfree(p);
-	}
+	iio_buffer_demux_free(buffer);
 	kfree(buffer->demux_bounce);
 	buffer->demux_bounce = NULL;
 
@@ -742,10 +748,8 @@ int iio_update_demux(struct iio_dev *indio_dev)
 	return 0;
 
 error_clear_mux_table:
-	list_for_each_entry_safe(p, q, &buffer->demux_list, l) {
-		list_del(&p->l);
-		kfree(p);
-	}
+	iio_buffer_demux_free(buffer);
+
 	return ret;
 }
 EXPORT_SYMBOL_GPL(iio_update_demux);
-- 
1.7.0.4

