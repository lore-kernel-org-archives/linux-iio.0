Return-Path: <SRS0=6Bzt=VM=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5049C76191
	for <linux-iio@archiver.kernel.org>; Mon, 15 Jul 2019 21:42:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97BCE21721
	for <linux-iio@archiver.kernel.org>; Mon, 15 Jul 2019 21:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563226942;
	bh=szYjPvstFvXARXFg4uh3ZnKKbNTSIZgGBtZZdplCV/s=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=Cfu8cUca9qsA20+StibCXyJj6NYgpH54Bl0J4MSJ4GtyWAC2651v014cU1X2ma2KC
	 Dfm72lnRQLMlmh2cwo/uaUEydm6Ch2bgLJl81UPATFHk/O4GNGAoREAK1FQAY5TrzQ
	 80QMBbu1EXdFsumCjg2hvEw5EK3ak4K1b60iD99Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731534AbfGOVmW (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Mon, 15 Jul 2019 17:42:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:53774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730574AbfGOVmW (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 15 Jul 2019 17:42:22 -0400
Received: from localhost.localdomain (unknown [151.66.36.246])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B742F20693;
        Mon, 15 Jul 2019 21:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563226941;
        bh=szYjPvstFvXARXFg4uh3ZnKKbNTSIZgGBtZZdplCV/s=;
        h=From:To:Cc:Subject:Date:From;
        b=ePElIy/ljblXq7flo+xnLqF6EMcA6obT2ALzcW6jta3DNH45dx/bzDsqAkNE281in
         rivqTjoyd6NTzJS7RJuYeH5QGRQwW+UwA3CZRHoLwKNmLawu3HnCGiar0cTUY/0Toj
         OAXbbxeLqqB40tKVNCDujd3/m6KK1485zSxGRD7E=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     jic23@kernel.org
Cc:     lorenzo.bianconi@redhat.com, linux-iio@vger.kernel.org,
        martin.kepplinger@puri.sm
Subject: [PATCH 0/3] st_lsm6dsx: move {odr,fs}_table in
Date:   Mon, 15 Jul 2019 23:42:08 +0200
Message-Id: <cover.1563226641.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Move odr and gain table in st_lsm6dsx_sensor_settings maps in order to support
devices with different odr/fs definitions. This is a preliminary series to add
support for LSM9DS1

Lorenzo Bianconi (3):
  iio: imu: st_lsm6dsx: move odr_table in st_lsm6dsx_sensor_settings
  iio: imu: st_lsm6dsx: move fs_table in st_lsm6dsx_sensor_settings
  iio: imu: st_lsm6dsx: inline acc/gyro output regs

 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h      |   4 +
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 397 +++++++++++++++----
 2 files changed, 316 insertions(+), 85 deletions(-)

-- 
2.21.0

