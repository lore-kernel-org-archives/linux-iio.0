Return-Path: <SRS0=W9FC=SG=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 309D5C4360F
	for <linux-iio@archiver.kernel.org>; Thu,  4 Apr 2019 16:02:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F18622147C
	for <linux-iio@archiver.kernel.org>; Thu,  4 Apr 2019 16:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554393767;
	bh=TGOMV5ksX5rnpDKCb706VGfgtOmS17Jg7O/zllnEzLo=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=HwMxtlZwDeZ7i8bdPEfzbqSfmIZrN5wrVigCy3/1Eb4P82SqgddkPfnItJc+kncxW
	 XsA1sLlOD9T/AIAkb3U4mVDoQ+F/Czev36lPH8yLE8RG5TkYwYUrNGeajrTtEFFCi3
	 Zo5bm+6qdif7UZis7v+qWCNjYwxGyqML4txxdFsA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbfDDQCq (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Thu, 4 Apr 2019 12:02:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:57036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727053AbfDDQCq (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 4 Apr 2019 12:02:46 -0400
Received: from localhost.localdomain.com (unknown [151.66.48.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9BDC32082E;
        Thu,  4 Apr 2019 16:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554393765;
        bh=TGOMV5ksX5rnpDKCb706VGfgtOmS17Jg7O/zllnEzLo=;
        h=From:To:Cc:Subject:Date:From;
        b=FhC6vDSL4L/P5TKsgJtMCBNLAdk9u4uz6pqvpY2a3JBnt1oy9sS7tL+FZks32ur7x
         YejO1gDAY4+KKoHJMA+LuZv9luhMMGsgHuLz+S49e0SBqxt2j8Fdc5in6eLqX1IqtQ
         1f2/DSRIvi2cZzLCnyNCHjSYNdR3zTekGMJYEcYg=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     jic23@kernel.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        lorenzo.bianconi@redhat.com
Subject: [PATCH 0/2] add support for LSM6DSR
Date:   Thu,  4 Apr 2019 18:02:33 +0200
Message-Id: <cover.1554393393.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add support for LSM6DSR IMU mems sensor
https://www.st.com/resource/en/datasheet/lsm6dsr.pdf

Lorenzo Bianconi (2):
  iio: imu: st_lsm6dsx: add support to LSM6DSR
  dt-bindings: iio: imu: st_lsm6dsx: add lsm6dsr device bindings

 .../bindings/iio/imu/st_lsm6dsx.txt           |  1 +
 drivers/iio/imu/st_lsm6dsx/Kconfig            |  2 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h       |  2 +
 .../iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c    |  8 +--
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c  | 67 ++++++++++++++++++-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c   |  5 ++
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c   |  5 ++
 7 files changed, 84 insertions(+), 6 deletions(-)

-- 
2.20.1

