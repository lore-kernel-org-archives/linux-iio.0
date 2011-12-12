Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from faui40.informatik.uni-erlangen.de ([131.188.34.40]:33964 "EHLO
	faui40.informatik.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750952Ab1LLPsa (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 12 Dec 2011 10:48:30 -0500
From: Stefan Hengelein
	<stefan.hengelein@informatik.stud.uni-erlangen.de>
To: devel@linuxdriverproject.org
Cc: linux-kernel@i4.informatik.uni-erlangen.de, gregkh@suse.de,
	linux-iio@vger.kernel.org,
	Stefan Hengelein
	<stefan.hengelein@informatik.stud.uni-erlangen.de>
Subject: [PATCH] Staging: iio/industrialio-core.c: Fixed call of obsolete function
Date: Mon, 12 Dec 2011 16:40:59 +0100
Message-Id: <1323704459-32235-1-git-send-email-stefan.hengelein@informatik.stud.uni-erlangen.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

As scripts/checkpatch.pl suggested, there has been a call of the
obsolete function strict_strtoul which should be replaced with a
kstrtox-function.

Signed-off-by: Stefan Hengelein <stefan.hengelein@informatik.stud.uni-erlangen.de>
---
 drivers/staging/iio/industrialio-core.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/industrialio-core.c b/drivers/staging/iio/industrialio-core.c
index aec9311..7319de8 100644
--- a/drivers/staging/iio/industrialio-core.c
+++ b/drivers/staging/iio/industrialio-core.c
@@ -785,10 +785,10 @@ static ssize_t iio_ev_value_store(struct device *dev,
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
-	unsigned long val;
+	unsigned int val;
 	int ret;
 
-	ret = strict_strtoul(buf, 10, &val);
+	ret = kstrtouint(buf, 10, &val);
 	if (ret)
 		return ret;
 
-- 
1.7.5.4

