Return-Path: <SRS0=IObS=DN=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C953AC4363D
	for <linux-iio@archiver.kernel.org>; Tue,  6 Oct 2020 12:08:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 652AC20760
	for <linux-iio@archiver.kernel.org>; Tue,  6 Oct 2020 12:08:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1601986088;
	bh=Rs82oXgEO/fLE/bsxYaOo7eoUgdmEWRVIIksxivDUCc=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=kGUanKQTm0VRm0AbWXVHYX+EM847BVLfqFdRT2a1Te+P2m2I/VgQr/SKF89NtYu97
	 4nlxK74j0jH8q6xk4ZEJP46F18zV24hJt6AhJOm0fy321YwEnGLzORXv3izyYrt+Dq
	 Bz0n8TMohKmmnmpbtw/7OuU4gLy0j9Xp/YqQu5pE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726182AbgJFMII (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Tue, 6 Oct 2020 08:08:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:60088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726143AbgJFMIH (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 6 Oct 2020 08:08:07 -0400
Received: from lore-desk.redhat.com (unknown [176.207.245.61])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A35820663;
        Tue,  6 Oct 2020 12:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601986087;
        bh=Rs82oXgEO/fLE/bsxYaOo7eoUgdmEWRVIIksxivDUCc=;
        h=From:To:Cc:Subject:Date:From;
        b=EfBnBv6B2H9X55IKDd0hxSwS5wnklZUtphNge6EMR3SeNA9aiETeKQvQ14fIUoALG
         QNzD7eEx9RBgv+XOYfrq6j9cE473/BoBAirASAKNhSx9B2ZbB+rxkaT9QqpUH7d/p/
         vPGD9/vAJOSPOsw1XPWtd8zjx/IbXNm+l5YF3B6s=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     jic23@kernel.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        lorenzo.bianconi@redhat.com, mario.tesi@st.com
Subject: [PATCH 0/2] add support for LSM6DST
Date:   Tue,  6 Oct 2020 14:07:40 +0200
Message-Id: <cover.1601985763.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add support for LSM6DST IMU mems sensor
https://www.st.com/resource/en/datasheet/lsm6dst.pdf

Lorenzo Bianconi (2):
  iio: imu: st_lsm6dsx: add support to LSM6DST
  dt-bindings: iio: imu: st_lsm6dsx: add lsm6dst device bindings

 .../bindings/iio/imu/st_lsm6dsx.txt           |   1 +
 drivers/iio/imu/st_lsm6dsx/Kconfig            |   4 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h       |   2 +
 .../iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c    |   2 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c  | 207 +++++++++++++++++-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c   |   5 +
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c   |   5 +
 7 files changed, 222 insertions(+), 4 deletions(-)

-- 
2.26.2

