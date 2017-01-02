Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from tarvos.retrosnub.co.uk ([217.168.153.95]:60408 "EHLO
        tarvos.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933929AbdABT3C (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 2 Jan 2017 14:29:02 -0500
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Daniel Baluta <daniel.baluta@gmail.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 10/11] iio:dummy: Stop enabling timestamp by default.
Date: Mon,  2 Jan 2017 19:28:33 +0000
Message-Id: <20170102192834.26546-11-jic23@kernel.org>
In-Reply-To: <20170102192834.26546-1-jic23@kernel.org>
References: <20170102192834.26546-1-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

It's bad practice and only done in this fake driver + it breaks my
attempt to take struct buffer opaque. Not worth an access function
as it shouldn't be done anyway.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/iio/dummy/iio_simple_dummy_buffer.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/iio/dummy/iio_simple_dummy_buffer.c b/drivers/iio/dummy/iio_simple_dummy_buffer.c
index 26bddb2464b7..744ca92c3c99 100644
--- a/drivers/iio/dummy/iio_simple_dummy_buffer.c
+++ b/drivers/iio/dummy/iio_simple_dummy_buffer.c
@@ -132,9 +132,6 @@ int iio_simple_dummy_configure_buffer(struct iio_dev *indio_dev)
 
 	iio_device_attach_buffer(indio_dev, buffer);
 
-	/* Enable timestamps by default */
-	buffer->scan_timestamp = true;
-
 	/*
 	 * Tell the core what device type specific functions should
 	 * be run on either side of buffer capture enable / disable.
-- 
2.11.0

