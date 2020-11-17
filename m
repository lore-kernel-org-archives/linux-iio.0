Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6AAFC2D0E4
	for <linux-iio@archiver.kernel.org>; Tue, 17 Nov 2020 15:12:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8611724654
	for <linux-iio@archiver.kernel.org>; Tue, 17 Nov 2020 15:12:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="hZ4zUGZ+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730209AbgKQPLq (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Tue, 17 Nov 2020 10:11:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:59026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730067AbgKQPLq (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 17 Nov 2020 10:11:46 -0500
Received: from lore-desk.redhat.com (unknown [151.66.8.153])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1530524654;
        Tue, 17 Nov 2020 15:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605625906;
        bh=3BRrV2qw21QdH29QcBdpoYAneWj1CurWbTD5IG8BUG8=;
        h=From:To:Cc:Subject:Date:From;
        b=hZ4zUGZ+EogD7iRtzjDK6vX01CdjBxx7qgk8Ka+CMF7c917SRsY9AsXRVhinttIFc
         HpuRfDZP2e0W8/v9cNBBKQ6H+sLe/QlMpZzB8dvgGJVvLi7CUp17jpbT3Af4iwI04s
         Lur2NbzfbcWZ9ARfu1qTWzNIPOAd8poUBPtFj1U4=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     jic23@kernel.org
Cc:     lorenzo.bianconi@redhat.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH 0/2] st_lsm6dsx: add vdd-vddio power regulator
Date:   Tue, 17 Nov 2020 16:11:36 +0100
Message-Id: <cover.1605625579.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Introduce support to control VDD and VDDIO power lines available on
st_lsm6dsx devices

Lorenzo Bianconi (2):
  iio: imu: st_lsm6dsx: add vdd-vddio voltage regulator
  dt-bindings: iio: imu: st_lsm6dsx: introduce vdd-vddio regulators
    bindings

 .../bindings/iio/imu/st_lsm6dsx.txt           |  4 ++
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h       |  3 ++
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c  | 42 +++++++++++++++++++
 3 files changed, 49 insertions(+)

-- 
2.26.2

