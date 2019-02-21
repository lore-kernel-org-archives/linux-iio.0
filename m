Return-Path: <SRS0=ELbO=Q4=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AABF4C43381
	for <linux-iio@archiver.kernel.org>; Thu, 21 Feb 2019 15:20:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74C3120842
	for <linux-iio@archiver.kernel.org>; Thu, 21 Feb 2019 15:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550762433;
	bh=s/0CoespfKGo1Bwh8IiFPEQR0RLo5ZHMEoQjAZImrAw=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=kce5vY251hB//hBrGzOulsYA2Mi3Sy+w4jbZlsC00vQcgWhkgTmM1beeDFj76/O8z
	 WC/K/4Ho+G4LbVO8Cb9Mt9S3UNrdf7ZsnTutFXxE/u7crvwHNMcq5FweUfxyOEqTNk
	 aikC0XW5C+URUsWN7LvwFxGNSGlyAeOmqtELfDvY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728027AbfBUPUd (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Thu, 21 Feb 2019 10:20:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:59428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725866AbfBUPUd (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 21 Feb 2019 10:20:33 -0500
Received: from lore-desk.lan (unknown [151.66.48.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3D76D2083B;
        Thu, 21 Feb 2019 15:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550762432;
        bh=s/0CoespfKGo1Bwh8IiFPEQR0RLo5ZHMEoQjAZImrAw=;
        h=From:To:Cc:Subject:Date:From;
        b=qJufN2MTE/vO2mQOQp25BO5/ZRSTUXlEbdzsu7hNKsQwCifnaMeQN7Q+co8F8HewS
         4+KRO4K8pSqPqcyZ0uMCTZ6hiYOS9tV1gTJ2zfKIMjdAwABNkdpxCyzwjnfYt/Oq3h
         LbvqK9Oje/1Efm65iPovXCHOKzwzTR03fl+CbdG8=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     jic23@kernel.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        mario.tesi@st.com, lorenzo.bianconi@redhat.com
Subject: [PATCH 0/2] add support for ASM330LHH
Date:   Thu, 21 Feb 2019 16:20:19 +0100
Message-Id: <cover.1550753006.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add support for ASM330LHH IMU mems sensor
https://www.st.com/resource/en/datasheet/asm330lhh.pdf

Lorenzo Bianconi (2):
  iio: imu: st_lsm6dsx: add support to ASM330LHH
  dt-bindings: iio: imu: st_lsm6dsx: add asm330lhh device bindings

 .../bindings/iio/imu/st_lsm6dsx.txt           |  1 +
 drivers/iio/imu/st_lsm6dsx/Kconfig            |  2 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h       |  2 +
 .../iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c    |  8 ++--
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c  | 41 ++++++++++++++++++-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c   |  5 +++
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c   |  5 +++
 7 files changed, 58 insertions(+), 6 deletions(-)

-- 
2.20.1

