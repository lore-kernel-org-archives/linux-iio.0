Return-Path: <SRS0=RKAC=RS=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81101C43381
	for <linux-iio@archiver.kernel.org>; Fri, 15 Mar 2019 10:08:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 476CB2186A
	for <linux-iio@archiver.kernel.org>; Fri, 15 Mar 2019 10:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552644525;
	bh=XW3X7Tgwo19FaBK41bcSpwSjQgkZkvcJU3MpoK+tG8A=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=uZUxVePoHLbxiwLM0MvkfilptVFLwBUJHPVjcrSEOazJ3NcCSlhpJVvv7vDQntH3G
	 Mmyh1K6CGCSc0bxpiH6opOXAhAF9QgDbDhZCnEdPEnrojz5c5cqgesHmgw5BZbgskY
	 BDJgsjYpP3TgEiR9LfDrKydz1+yWIA3T1KD5kC1A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728719AbfCOKIo (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Fri, 15 Mar 2019 06:08:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:59550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727469AbfCOKIo (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 15 Mar 2019 06:08:44 -0400
Received: from localhost.localdomain.com (nat-pool-mxp-t.redhat.com [149.6.153.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BEE942186A;
        Fri, 15 Mar 2019 10:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552644523;
        bh=XW3X7Tgwo19FaBK41bcSpwSjQgkZkvcJU3MpoK+tG8A=;
        h=From:To:Cc:Subject:Date:From;
        b=f5Mgt6LFb8y0okqKjUZ2/k+t1B+dTys0HTadf9D84VLMHoEgFpdHEs75rb6ChZI4n
         VlHG6d3MA2v0xLFD3+sw68Gd26NAjNH8zR6ULZs0BNn39dkLPWXFjUybQwcGz47RZ4
         hde+fO93wEOXTEQzoEc2RXtwHu/fSQy0NXik0GIw=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     jic23@kernel.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        lorenzo.bianconi@redhat.com
Subject: [PATCH 0/2] add support for LSM6DSOX
Date:   Fri, 15 Mar 2019 11:08:23 +0100
Message-Id: <cover.1552643968.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add support for LSM6DSOX IMU mems sensor
https://www.st.com/resource/en/datasheet/lsm6dsox.pdf

Please note I just compiled the series since I have no adapter for this sensor
but according to the datasheet it has a common register map with lsm6dso (at
least for supported features)

Lorenzo Bianconi (2):
  iio: imu: st_lsm6dsx: add support to LSM6DSOX
  dt-bindings: iio: imu: st_lsm6dsx: add lsm6dsox device bindings

 Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt | 1 +
 drivers/iio/imu/st_lsm6dsx/Kconfig                       | 2 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h                  | 2 ++
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c           | 4 ++--
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c             | 3 ++-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c              | 5 +++++
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c              | 5 +++++
 7 files changed, 18 insertions(+), 4 deletions(-)

-- 
2.20.1

