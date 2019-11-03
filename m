Return-Path: <SRS0=ct+5=Y3=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DF83CA9EB0
	for <linux-iio@archiver.kernel.org>; Sun,  3 Nov 2019 19:47:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 353AF21D71
	for <linux-iio@archiver.kernel.org>; Sun,  3 Nov 2019 19:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572810463;
	bh=7z0ukquQ36ZywYWolkCTnwbMFv38A643nAtzIcbVu+M=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=l8mK+xp3tbVsRRleY3MUCXCCSojGcnNHEflQvF8k8Sx6D1tdWCWe0L7jeHxONNnrY
	 Yv/Vv1TN42bd6B8Pk4rC/IcvtSk26NeHvLJfZYub6fZsNV19PdiRiL1n3FFvgcQgTv
	 5O6LyhhqobkCc2zh2u+euR6xxr10bFqcxQ76aN0U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727913AbfKCTrm (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 3 Nov 2019 14:47:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:55958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727343AbfKCTrm (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 3 Nov 2019 14:47:42 -0500
Received: from localhost.localdomain (unknown [151.66.0.231])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E50E821929;
        Sun,  3 Nov 2019 19:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572810462;
        bh=7z0ukquQ36ZywYWolkCTnwbMFv38A643nAtzIcbVu+M=;
        h=From:To:Cc:Subject:Date:From;
        b=A8YLIlx4DDSlAq9paU+aV/ZWcmn6MtiIukZ65yKTll78wKXhtPOQ4HtppCUQsitl1
         MBhrGGYgTI57n+RlmCDdo3U1sIFD1i5DvpDgoYOM0miBwNN5G1cpAwL46xErrPuc/1
         gLQFgLpOmt/GLJwq7OvtCfO34GxkSqPTWp3/Voqs=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     jic23@kernel.org
Cc:     lorenzo.bianconi@redhat.com, mario.tesi@st.com,
        linux-iio@vger.kernel.org
Subject: [PATCH v2 0/2] support rational ODRs in st_lsm6dsx
Date:   Sun,  3 Nov 2019 20:47:16 +0100
Message-Id: <cover.1572810064.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Express ODRs in mHZ in order to support rational ODRs (e.g. 12.5Hz).
This series will fix an Android CTS failure.
Use u32 for ODR variables.
Explicitly define odr table size.
This series is based on 'iio: imu: st_lsm6dsx: fix ODR check in
st_lsm6dsx_write_raw'
https://patchwork.kernel.org/patch/11214281/

Changes since v1:
- express ODRs in mHZ and not in HZ / 10

Lorenzo Bianconi (2):
  iio: imu: st_lsm6dsx: explicitly define odr table size
  iio: imu: st_lsm6dsx: express odr in mHZ

 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h       |   8 +-
 .../iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c    |   9 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c  | 222 ++++++++++--------
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c  |  41 ++--
 4 files changed, 153 insertions(+), 127 deletions(-)

-- 
2.21.0

