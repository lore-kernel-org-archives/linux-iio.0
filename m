Return-Path: <SRS0=n4Xm=XI=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD0F8C49ED7
	for <linux-iio@archiver.kernel.org>; Fri, 13 Sep 2019 09:07:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7805620717
	for <linux-iio@archiver.kernel.org>; Fri, 13 Sep 2019 09:07:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="dnTjqtx9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387794AbfIMJHP (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Fri, 13 Sep 2019 05:07:15 -0400
Received: from first.geanix.com ([116.203.34.67]:49546 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387594AbfIMJHP (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 13 Sep 2019 05:07:15 -0400
Received: from zen.localdomain (unknown [85.184.140.241])
        by first.geanix.com (Postfix) with ESMTPSA id 24306650BD;
        Fri, 13 Sep 2019 09:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1568365588; bh=Oj9vfl9l2RqBtzNM7JyRuRb19P4GF7MmcR328CVAxrI=;
        h=From:To:Cc:Subject:Date;
        b=dnTjqtx9jJgp9CkRqLKOLUvwO8mGHBjgiG9z2xo3qFutBJh2pzpCuFGPD+QvHyoIa
         YXda1mvsutYndypp+jASCs2RBgYd+CeQjN+XqYTqZDEIzORLbyTLXlJbgp5oQvaqX0
         IOQRvj/3TOPLnHI51oYUOw6hdlenvPhTGuLHjVJurMGndjqNfCt4nfuGTj8nXRUQTP
         6sznqIIt6KIbdTiy/+ugRaJBVQAh+GITh8A2qFOBDJw/77MdMJIIigvjtui3f3/whK
         dHpk14B1A8qE7Kjl+MZREsG4cuQkqosbTlvu/Wid/k9lK5KJV7RakQMZYtSsQp0J8V
         Lo7s+oKcOLKeA==
From:   Sean Nyekjaer <sean@geanix.com>
To:     linux-iio@vger.kernel.org, jic23@kernel.org,
        lorenzo.bianconi83@gmail.com
Cc:     Sean Nyekjaer <sean@geanix.com>, denis.ciocca@st.com,
        mario.tesi@st.com, armando.visconti@st.com, martin@geanix.com
Subject: [PATCH v8 0/5] enable motion events for st_lsm6dsx
Date:   Fri, 13 Sep 2019 11:07:03 +0200
Message-Id: <20190913090708.1442057-1-sean@geanix.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This patchset depends on:
[PATCH 0/2] enable LIR and clear_on_read for st_lsm6dsx

@Jonathan if this is accepted, will it go in 5.4?

Sean Nyekjaer (5):
  iio: imu: st_lsm6dsx: move interrupt thread to core
  iio: imu: st_lsm6dsx: add motion events
  iio: imu: st_lsm6dsx: add wakeup-source option
  iio: imu: st_lsm6dsx: always enter interrupt thread
  iio: imu: st_lsm6dsx: add motion report function and call from
    interrupt

 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h       |  46 +++
 .../iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c    |  78 +---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c  | 361 +++++++++++++++++-
 3 files changed, 404 insertions(+), 81 deletions(-)

-- 
2.23.0

