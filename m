Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtprelay0237.hostedemail.com ([216.40.44.237]:36891 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S932984AbbHJWBu (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 10 Aug 2015 18:01:50 -0400
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
	by smtpgrave06.hostedemail.com (Postfix) with ESMTP id EE552174450
	for <linux-iio@vger.kernel.org>; Mon, 10 Aug 2015 21:52:24 +0000 (UTC)
From: Joe Perches <joe@perches.com>
To: devel@driverdev.osuosl.org, Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 05/19] staging: iio: Remove unnecessary externs
Date: Mon, 10 Aug 2015 14:51:20 -0700
Message-Id: <fba2902597293652f4d8561730c0cf16cd4369a0.1439241825.git.joe@perches.com>
In-Reply-To: <cover.1439241825.git.joe@perches.com>
References: <cover.1439241825.git.joe@perches.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Using 'extern' is not necessary for function prototypes.

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/staging/iio/meter/ade7854.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/meter/ade7854.h b/drivers/staging/iio/meter/ade7854.h
index 52ca541..52f4195 100644
--- a/drivers/staging/iio/meter/ade7854.h
+++ b/drivers/staging/iio/meter/ade7854.h
@@ -168,7 +168,7 @@ struct ade7854_state {
 
 };
 
-extern int ade7854_probe(struct iio_dev *indio_dev, struct device *dev);
-extern int ade7854_remove(struct iio_dev *indio_dev);
+int ade7854_probe(struct iio_dev *indio_dev, struct device *dev);
+int ade7854_remove(struct iio_dev *indio_dev);
 
 #endif
-- 
2.1.2

