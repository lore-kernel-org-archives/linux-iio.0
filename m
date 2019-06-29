Return-Path: <SRS0=duTD=U4=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20F05C4321A
	for <linux-iio@archiver.kernel.org>; Sat, 29 Jun 2019 10:14:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCFCC21670
	for <linux-iio@archiver.kernel.org>; Sat, 29 Jun 2019 10:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561803243;
	bh=moQlfPAMjOa6uyPq6FEFz2uPwgDciwkvitY9uyUvuk4=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=HvUZyr9xxg8M79LfdRZLRx6/KEuya2mg8KYmhzt4B9Z05jv8FeWwYpxM9G7i9+DWt
	 uIhbpvtmwkpHCHxUal1UqsZjGV8AwFwaCc+qumOGZtJ1USfGjbDyOHRDiJFyok8Tfs
	 4TE3hQU1i/ypLop5ZYq+OZ42mgqv059nmBslCFuI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbfF2KOD (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 29 Jun 2019 06:14:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:34992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726895AbfF2KOD (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 29 Jun 2019 06:14:03 -0400
Received: from lore-desk-wlan.lan (unknown [151.66.61.123])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 320F1214AF;
        Sat, 29 Jun 2019 10:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561803242;
        bh=moQlfPAMjOa6uyPq6FEFz2uPwgDciwkvitY9uyUvuk4=;
        h=From:To:Cc:Subject:Date:From;
        b=SVr0ARyPmrqPYgo0rtuiT0U9z+1BQsSGT9tK/vlFGenjBSqfc3Bqn0qOmqrMNKOvF
         EBXa6KKqpDIHTaIx7aSo/yHbq/lx2mgOh2B/H3lt9LjCBOPg6C6Yyf4xs/CIQm3VOO
         AmrYKti8x9GwaHzObtiq/5yK60sRxrRAHCvkG858=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     jic23@kernel.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        lorenzo.bianconi@redhat.com
Subject: [PATCH 0/2] add support to STM LSM6DS3TR-C 6-axis Mems sensor
Date:   Sat, 29 Jun 2019 12:13:52 +0200
Message-Id: <cover.1561802767.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add support to STM LSM6DS3TR-C 6-axis sensor
https://www.st.com/resource/en/datasheet/lsm6ds3tr-c.pdf

Lorenzo Bianconi (2):
  iio: imu: st_lsm6dsx: add support to LSM6DS3TR-C
  dt-bindings: iio: imu: st_lsm6dsx: add lsm6ds3tr-c device bindings

 Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt | 1 +
 drivers/iio/imu/st_lsm6dsx/Kconfig                       | 2 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h                  | 2 ++
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c           | 8 ++++----
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c             | 5 ++++-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c              | 5 +++++
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c              | 5 +++++
 7 files changed, 22 insertions(+), 6 deletions(-)

-- 
2.21.0

