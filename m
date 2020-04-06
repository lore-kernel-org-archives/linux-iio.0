Return-Path: <SRS0=C9+x=5W=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E131CC2BA1B
	for <linux-iio@archiver.kernel.org>; Mon,  6 Apr 2020 19:00:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEFD72072F
	for <linux-iio@archiver.kernel.org>; Mon,  6 Apr 2020 19:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586199657;
	bh=CYi/4DIAxGhmSICktgYmuJ57TQM+QpqgKLhuBuYeqlQ=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=16uPAkhSgrI1zQaLyyqyPsN3wf2ge3TOJkeMImlO60IrgTYbcmid2iqjm1eOAhIIH
	 aVQAqyiNMXnyeNveokIB72DZYLJJRFokiXbPDVxGlwaRe9IJf9eUzi7lgxA0Q/CM5I
	 MeoyGDOkiGZrYJnTG5klbJkSpqYZ/RY6yDSeS7FQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725995AbgDFTA5 (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Mon, 6 Apr 2020 15:00:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:60380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725876AbgDFTA5 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 6 Apr 2020 15:00:57 -0400
Received: from lore-desk-wlan.redhat.com (unknown [151.48.151.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C152206F5;
        Mon,  6 Apr 2020 19:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586199656;
        bh=CYi/4DIAxGhmSICktgYmuJ57TQM+QpqgKLhuBuYeqlQ=;
        h=From:To:Cc:Subject:Date:From;
        b=SXkNHaAcGbwRE5xQsvTXA7PvKnShJp0YNTvdgXZFLjoOYUzgJRzNfLOF3CfB9HD/Z
         2hG+2gSPWlEj/MWbF7xtIZCVwvTaNYdjJuJctl3ODBhVHRTz0jjXobtbuoWTnRKvF/
         NrfJp8xfihAv9zs6/YtXc4CoUpzvP4tMpj9h0Q/Y=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     jic23@kernel.org
Cc:     linux-iio@vger.kernel.org, lorenzo.bianconi@redhat.com,
        jimmyassarsson@gmail.com, andy.shevchenko@gmail.com
Subject: [PATCH v3] iio: imu: st_lsm6dsx: drop huge include in sensor-hub driver
Date:   Mon,  6 Apr 2020 21:00:25 +0200
Message-Id: <d49d9b76fab1ba0e33034327864d25ff64545bd9.1586199565.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

st_lsm6dsx is a standalone driver for STM IMU sensors and does not rely
on st_sensor common framework, so it does not include st_sensor common
definitions.
In st_lsm6dsx_shub driver st_sensors.h is used just to introduce the
default wai address for LIS3MDL sensor.
Drop this largely unconnected include file and introduce the default wai
address for LIS3MDL in st_lsm6dsx_ext_dev_settings register map

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
Changes since v2:
- rewrite commit message

Changes since v1:
- improve commit message
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
index 280925dd8edb..947ca3a7dcaf 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
@@ -28,7 +28,6 @@
 #include <linux/iio/sysfs.h>
 #include <linux/bitfield.h>
 
-#include <linux/iio/common/st_sensors.h>
 #include "st_lsm6dsx.h"
 
 #define ST_LSM6DSX_SLV_ADDR(n, base)		((base) + (n) * 3)
@@ -93,7 +92,7 @@ static const struct st_lsm6dsx_ext_dev_settings st_lsm6dsx_ext_dev_table[] = {
 	{
 		.i2c_addr = { 0x1e },
 		.wai = {
-			.addr = ST_SENSORS_DEFAULT_WAI_ADDRESS,
+			.addr = 0x0f,
 			.val = 0x3d,
 		},
 		.id = ST_LSM6DSX_ID_MAGN,
-- 
2.25.1

