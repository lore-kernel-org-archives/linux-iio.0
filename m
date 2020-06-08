Return-Path: <SRS0=Co8Y=7W=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D871C433E2
	for <linux-iio@archiver.kernel.org>; Tue,  9 Jun 2020 00:29:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD5872078B
	for <linux-iio@archiver.kernel.org>; Tue,  9 Jun 2020 00:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591662596;
	bh=i3SMjkDTekRiVkaB8I7Uy/nuh03l3LqJmw7nClDogTE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1NaktnxpOkZpEEADyuR4LLaKYsERafpY+a0ZIg7LPT8c6nqxAiXF0YbN75upGa/QX
	 aBIDtkU2S4gHxNtbPcCIidA7R/jAwSx5IdzNmoq+GH0K7R4KE5ICqXMYcwqlZrtyhb
	 dsV67zPiVCYM0CMRIbNeLdTiheXsjgBI/Pg8Wh6g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730171AbgFHXQF (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Mon, 8 Jun 2020 19:16:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:37330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729344AbgFHXQE (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 8 Jun 2020 19:16:04 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F3FB820760;
        Mon,  8 Jun 2020 23:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591658164;
        bh=i3SMjkDTekRiVkaB8I7Uy/nuh03l3LqJmw7nClDogTE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W7jC6BCaRUkWeTOMSp3NyEbRntGt9AVIYRGXX7xuD1In+WoFAOwMl2EKPqlXTB3T/
         I+xn8kULHGDGOYCC4en3j1qpLHkVjRqxVJvfuXzD30sUXrANz/e7jP5C3NmLBNlIPN
         H2GuVFL08QIt+gyk1ureOUu2BLLMzrjjsn6bYj70=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org
Subject: [PATCH AUTOSEL 5.6 193/606] iio: imu: st_lsm6dsx: unlock on error in st_lsm6dsx_shub_write_raw()
Date:   Mon,  8 Jun 2020 19:05:18 -0400
Message-Id: <20200608231211.3363633-193-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200608231211.3363633-1-sashal@kernel.org>
References: <20200608231211.3363633-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

commit 115c215a7e5753ddf982c8760ce7904dd3fbb8ae upstream.

We need to release a lock if st_lsm6dsx_check_odr() fails, we can't
return directly.

Fixes: 76551a3c3df1 ("iio: imu: st_lsm6dsx: specify slave odr in slv_odr")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
index 64ef07a30726..1cf98195f84d 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
@@ -544,8 +544,10 @@ st_lsm6dsx_shub_write_raw(struct iio_dev *iio_dev,
 
 			ref_sensor = iio_priv(hw->iio_devs[ST_LSM6DSX_ID_ACC]);
 			odr = st_lsm6dsx_check_odr(ref_sensor, val, &odr_val);
-			if (odr < 0)
-				return odr;
+			if (odr < 0) {
+				err = odr;
+				goto release;
+			}
 
 			sensor->ext_info.slv_odr = val;
 			sensor->odr = odr;
@@ -557,6 +559,7 @@ st_lsm6dsx_shub_write_raw(struct iio_dev *iio_dev,
 		break;
 	}
 
+release:
 	iio_device_release_direct_mode(iio_dev);
 
 	return err;
-- 
2.25.1

