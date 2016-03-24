Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:7899 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753181AbcCXJJx (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Thu, 24 Mar 2016 05:09:53 -0400
From: Irina Tirdea <irina.tirdea@intel.com>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Octavian Purdila <octavian.purdila@intel.com>,
	Irina Tirdea <irina.tirdea@intel.com>
Subject: [PATCH 1/1] iio: fix config watermark initial value
Date: Thu, 24 Mar 2016 11:09:45 +0200
Message-Id: <1458810585-24555-1-git-send-email-irina.tirdea@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

config structure is set to 0 when updating the buffers, so by
default config->watermark will be 0. When computing the minimum
between config->watermark and the buffer->watermark or
insert_buffer-watermark, this will always be 0 regardless of the
value set by the user for the buffer.

Set as initial value for config->watermark the maximum allowed
value so that the minimum value will always be set from one of the
buffers.

Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
---
 drivers/iio/industrialio-buffer.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index b976332..90462fc 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -653,6 +653,7 @@ static int iio_verify_update(struct iio_dev *indio_dev,
 	unsigned int modes;
 
 	memset(config, 0, sizeof(*config));
+	config->watermark = ~0;
 
 	/*
 	 * If there is just one buffer and we are removing it there is nothing
-- 
1.9.1

