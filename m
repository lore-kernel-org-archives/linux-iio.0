Return-Path: <SRS0=e+7m=X7=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 855B0C4360C
	for <linux-iio@archiver.kernel.org>; Sun,  6 Oct 2019 13:22:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F7512133F
	for <linux-iio@archiver.kernel.org>; Sun,  6 Oct 2019 13:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570368139;
	bh=/zepCTBJ3GHTUatmhflnQEFbJaXx0DIBJMqxGDgQG/M=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=krKGWFZxvpQJmCXZNUvQmHJ5cfPP30YKCntFTIYwA0WdGAudcCb9vG0cQH+BtKEvP
	 so3gl2w7qH68D8JO+vRUt2XSTTWFsoeeEoxdEUuKH+Pv+CtX/ACPDavZ81gcMk5LL4
	 o8wJoEYjRnxk3agKqlL24hpGfqcswg4XDEcZ54+E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbfJFNWS (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 6 Oct 2019 09:22:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:38264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726060AbfJFNWS (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 6 Oct 2019 09:22:18 -0400
Received: from lore-desk-wlan.lan (unknown [151.66.37.67])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E5CEB20684;
        Sun,  6 Oct 2019 13:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570368137;
        bh=/zepCTBJ3GHTUatmhflnQEFbJaXx0DIBJMqxGDgQG/M=;
        h=From:To:Cc:Subject:Date:From;
        b=ox90VbE0wCg8RwVuHcB76g2g9Ub3QGfDzcNJ7ZjV3rD50fOWIBwKTrZ+ir+LePgGu
         skAJ4r8pY+q2plud+zWNs/Bcpgma4VSwGS03DVul16kDJELkChJA2O9QC6XqncGMJm
         W8VqnSuEQ1zy6ae782NfQaRNqsD0CUBYGkUzFRsM=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     jic23@kernel.org
Cc:     linux-iio@vger.kernel.org, sean@geanix.com, martin@geanix.com,
        rjones@gateworks.com, lorenzo.bianconi@redhat.com,
        devicetree@vger.kernel.org
Subject: [PATCH 00/13] various st_lsm6dsx fixes and missing bits
Date:   Sun,  6 Oct 2019 15:21:54 +0200
Message-Id: <cover.1570367532.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This series fixes some corner cases introduced with LSM9DS1 support and with
the one that has added wake-up event support. In particular it fixes a crash
due to missing HW FIFO support for LSM9DS1.
Moreover I introduced the missing wake-up event support for LSM6DSO/LSM6DSOX
sensor
Add missing dts documentation for wake-up event and the capability to enable it
through platformdata.
Code cleanup.

Lorenzo Bianconi (13):
  iio: imu: st_lsm6dsx: use st_lsm6dsx_read_locked in
    st_lsm6dsx_report_motion_event
  iio: imu: st_lsm6dsx: add sanity check for read_fifo pointer
  iio: imu: st_lsm6dsx: move irq related definitions in irq_config
  iio: imu: st_lsm6dsx: do not access active-low/open-drain regs if not
    supported
  iio: imu: st_lsm6dsx: move bdu/boot and reset register info in
    hw_settings
  iio: imu: st_lsm6dsx: always check enable_reg in
    st_lsm6dsx_event_setup
  iio: imu: st_lsm6dsx: rely on st_lsm6dsx_update_bits_locked
    configuring events
  iio: imu: st_lsm6dsx: grab conf mutex in st_lsm6dsx_write_event_config
  iio: imu: st_lsm6dsx: fix checkpatch warning
  iio: imu: st_lsm6dsx: add wakeup_source in st_sensors_platform_data
  iio: imu: st_lsm6dsx: add missing kernel documenation
  dt-bindings: iio: imu: st_lsm6dsx: document missing wakeup-source
    property
  iio: imu: st_lsm6dsx: enable wake-up event for LSM6DSO

 .../bindings/iio/imu/st_lsm6dsx.txt           |   1 +
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h       |  35 +-
 .../iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c    |   3 +
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c  | 588 ++++++++++++------
 .../linux/platform_data/st_sensors_pdata.h    |   2 +
 5 files changed, 440 insertions(+), 189 deletions(-)

-- 
2.21.0

