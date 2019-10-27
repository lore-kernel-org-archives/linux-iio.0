Return-Path: <SRS0=gq1U=YU=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9F56CA9EAF
	for <linux-iio@archiver.kernel.org>; Sun, 27 Oct 2019 19:21:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77A01208C0
	for <linux-iio@archiver.kernel.org>; Sun, 27 Oct 2019 19:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572204099;
	bh=jc2qJL3d0hxr6O0yv80+80mFXn6fD1GCox7HWWaMC3E=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=YUauAXRoUD18Sts+ZoBE55QY2Wu5W/CA6LrI/398ue8/tjCy3j3fedxDHnCLGOt4Y
	 X29rTnGzai8wYBH7xpMbDcmAqzH6/z9yNxrv/EEkXwzPoWYhPAdSKUnVyIMhmrfZiu
	 NBwS1WQRYZYxiloxeLKFhDXgumOUrc3J5pUBKHvQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbfJ0TVj (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 27 Oct 2019 15:21:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:39140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726985AbfJ0TVi (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 27 Oct 2019 15:21:38 -0400
Received: from localhost.localdomain (unknown [151.66.57.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 67FD220717;
        Sun, 27 Oct 2019 19:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572204098;
        bh=jc2qJL3d0hxr6O0yv80+80mFXn6fD1GCox7HWWaMC3E=;
        h=From:To:Cc:Subject:Date:From;
        b=nTSlu7R3t5rweRfMhq7NuRFrYZTjNIxgd1462Z2O5q7B9wUBDs9HahESGwQsekwVI
         OOQx6++V3WscsU8E8X/dCGFOyw6SEyUZlLvuOKBMM5mB6CRMpaS0WWtpkcLnRJxFJ/
         LRfdx59Bw73RfBcg9oYAFkisFbuTyhuyTaGpkVqk=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     jic23@kernel.org
Cc:     lorenzo.bianconi@redhat.com, linux-iio@vger.kernel.org
Subject: [PATCH 0/2] support rational ODRs in st_lsm6dsx
Date:   Sun, 27 Oct 2019 20:21:22 +0100
Message-Id: <cover.1572203759.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Express ODRs in HZ / 10 in order to support rational ODRs (e.g. 12.5Hz).
This series will fix an Android CTS failure.
Explicitly define odr table size.
This series is based on 'iio: imu: st_lsm6dsx: fix ODR check in
st_lsm6dsx_write_raw'
https://patchwork.kernel.org/patch/11214281/

Lorenzo Bianconi (2):
  iio: imu: st_lsm6dsx: explicitly define odr table size
  iio: imu: st_lsm6dsx: express odr in HZ / 10

 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h      |   4 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 206 ++++++++++---------
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c |  33 +--
 3 files changed, 133 insertions(+), 110 deletions(-)

-- 
2.21.0

