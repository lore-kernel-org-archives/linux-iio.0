Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout01.posteo.de ([185.67.36.65]:58172 "EHLO mout01.posteo.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755934AbbIALzP (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 1 Sep 2015 07:55:15 -0400
Received: from dovecot03.posteo.de (dovecot03.posteo.de [172.16.0.13])
	by mout01.posteo.de (Postfix) with ESMTPS id 39D3620BB9
	for <linux-iio@vger.kernel.org>; Tue,  1 Sep 2015 13:47:16 +0200 (CEST)
From: Martin Kepplinger <martink@posteo.de>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
	pmeerw@pmeerw.net, mfuzzey@parkeon.com, roberta.dobrescu@gmail.com,
	robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com,
	ijc+devicetree@hellion.org.uk, galak@codeaurora.org
Cc: devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	christoph.muellner@theobroma-systems.com,
	Martin Kepplinger <martink@posteo.de>,
	Martin Kepplinger <martin.kepplinger@theobroma-systems.com>
Subject: [PATCH 5/6] iio: mma8452: add copyright notice comment
Date: Tue,  1 Sep 2015 13:45:12 +0200
Message-Id: <1441107913-4112-6-git-send-email-martink@posteo.de>
In-Reply-To: <1441107913-4112-1-git-send-email-martink@posteo.de>
References: <1441107913-4112-1-git-send-email-martink@posteo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Martin Kepplinger <martin.kepplinger@theobroma-systems.com>
Signed-off-by: Christoph Muellner <christoph.muellner@theobroma-systems.com>
---
 drivers/iio/accel/mma8452.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index 59b4455..15d50c9 100644
--- a/drivers/iio/accel/mma8452.c
+++ b/drivers/iio/accel/mma8452.c
@@ -6,6 +6,7 @@
  * MMA8652FC (12 bit)
  * MMA8653FC (10 bit)
  *
+ * Copyright 2015 Martin Kepplinger <martin.kepplinger@theobroma-systems.com>
  * Copyright 2014 Peter Meerwald <pmeerw@pmeerw.net>
  *
  * This file is subject to the terms and conditions of version 2 of
-- 
2.1.4

