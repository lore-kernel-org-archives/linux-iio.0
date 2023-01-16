Return-Path: <linux-iio-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1843CC63797
	for <linux-iio@archiver.kernel.org>; Mon, 16 Jan 2023 09:51:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbjAPJvx (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Mon, 16 Jan 2023 04:51:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbjAPJvl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 16 Jan 2023 04:51:41 -0500
Received: from frolo.macqel.be (smtp2.macqel.be [109.135.2.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D6E3816AE3
        for <linux-iio@vger.kernel.org>; Mon, 16 Jan 2023 01:51:39 -0800 (PST)
Received: by frolo.macqel.be (Postfix, from userid 1000)
        id CAB3CDF00AB; Mon, 16 Jan 2023 10:51:36 +0100 (CET)
From:   Philippe De Muyter <Philippe.DeMuyter@macq.eu>
To:     lorenzo@kernel.org, linux-iio@vger.kernel.org
Cc:     Philippe De Muyter <phdm@macqel.be>
Subject: [PATCH 0/2] iio: imu: st_lsm6dsx: add 'mount_matrix' sysfs entry to gyro channel.
Date:   Mon, 16 Jan 2023 10:51:23 +0100
Message-Id: <1673862685-29308-1-git-send-email-Philippe.DeMuyter@macq.eu>
X-Mailer: git-send-email 1.7.10.4
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Philippe De Muyter <phdm@macqel.be>

A simple patch to add the missing 'mount_matrix' sysfs entry for the gyro
channel of the st_lsm6dsx 6-axes devices.

Philippe De Muyter (2):
  iio: imu: st_lsm6dsx: fix naming of 'struct iio_info'.
  iio: imu: st_lsm6dsx: add 'mount_matrix' sysfs entry to gyro channel.

 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h      | 5 +++--
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c | 4 ++--
 2 files changed, 5 insertions(+), 4 deletions(-)

-- 
2.31.1

