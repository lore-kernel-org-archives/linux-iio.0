Return-Path: <SRS0=BsLG=PW=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46AF6C43612
	for <linux-iio@archiver.kernel.org>; Mon, 14 Jan 2019 03:56:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 154B320870
	for <linux-iio@archiver.kernel.org>; Mon, 14 Jan 2019 03:56:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=martingkelly-com.20150623.gappssmtp.com header.i=@martingkelly-com.20150623.gappssmtp.com header.b="MreOt5i9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbfAND4f (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 13 Jan 2019 22:56:35 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37551 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726697AbfAND4f (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 13 Jan 2019 22:56:35 -0500
Received: by mail-pf1-f196.google.com with SMTP id y126so9713056pfb.4
        for <linux-iio@vger.kernel.org>; Sun, 13 Jan 2019 19:56:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=martingkelly-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=3h+VgbrMmJ9x3M6MNEzWZSNUNQNHuuS96aiYjnz/gNc=;
        b=MreOt5i9E5fhdMyXoJIXU4x432u61F62S+U8LdG+yI83f1FZWag/YydcfF3QECoahb
         8s+4uUH/XP4HFxp1Sk7PgFKVVW9n2mbD6wGCAQVaMX5tZcUjghbfHCyVbYYTgkkYWXFk
         L3Nv1Wpxr8Li+LkflTpcDKMwiODfj0h+RmHDBnFXUnBOE2kTrnUuWCs/KFzbNKqLozJ8
         r2qyPN8qeEz6HgZFNy9m2wFkb0pJI3O6G8OAZYt/bF/6jqBjk0mT9PdUkieMnlxfdAbl
         jkmQskc5r4to282uBc1xyEFGrswY9VHnIJMY172RUDIlJu69H9oQO8YHhyzyJtbBFEH8
         wePA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3h+VgbrMmJ9x3M6MNEzWZSNUNQNHuuS96aiYjnz/gNc=;
        b=Km4n8gE1nNw7RPKFatkyPrN675FQ0sYgTkXSspAsxN+MXvDHO8kilYT2qsjiDmj7eV
         +WmlhLwIuw2h0z+iiyUQEgNdRfv+GJpA4y4EuOiryRr1PkZ2WCwXzffND0/o2jj89xJv
         5uxDrU44qaf3RlC1NkzQHgkGzpAwJXTgSohUeOWy+3mndoTciab0z789GLHC1XlxuvA0
         GT8BxOa31q9rOZuiwS2sYuNJjK5DQBNM2zyDdKG5sHkilreLHjfvBnouK5XgxhV50J5S
         GR8/lpDOd7d+nvjydUCumR8y43jWfQRnGfagOTnWT5uNp/g8+qy5/JNoA7/6CUSnalnK
         k+RQ==
X-Gm-Message-State: AJcUukefa6OTCxEXUoscpK5b8h5mfDkctVHLE1deJbFpBKALZBO4sVbX
        e3IOVKtefwqGMMI3KLS59bsyBTvWdhY=
X-Google-Smtp-Source: ALg8bN6GiD/91fzr2Oaeo6O7QUZygNyIK4+QphOkycPVPKQnx+yfUcoqSqSue4Qny/btlorf3Lpxvg==
X-Received: by 2002:a65:63d3:: with SMTP id n19mr21690926pgv.179.1547438194017;
        Sun, 13 Jan 2019 19:56:34 -0800 (PST)
Received: from cascade.Home (174-21-177-9.tukw.qwest.net. [174.21.177.9])
        by smtp.gmail.com with ESMTPSA id l70sm93582741pgd.20.2019.01.13.19.56.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 13 Jan 2019 19:56:33 -0800 (PST)
From:   Martin Kelly <martin@martingkelly.com>
X-Google-Original-From: Martin Kelly <martin@martingkelly.com
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Martin Kelly <martin@martingkelly.com>
Subject: [PATCH 0/5] iio:bmi160: add drdy interrupt support
Date:   Sun, 13 Jan 2019 19:56:16 -0800
Message-Id: <20190114035621.5252-1-martin@martingkelly.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Martin Kelly <martin@martingkelly.com>

This patch series adds drdy interrupt support to the BMI160 IMU. It also updates
the relevant DT bindings and does a little bit of related cleanup.

Martin Kelly (5):
  iio:bmi160: add SPDX identifiers
  iio:bmi160: add drdy interrupt support
  dt-bindings: fix incorrect bmi160 IRQ note
  dt-bindings:bmi160: add "BOTH" int pin type
  iio:bmi160:snap timestamp closer to event

 .../devicetree/bindings/iio/imu/bmi160.txt         |  17 +-
 drivers/iio/imu/bmi160/Makefile                    |   1 +
 drivers/iio/imu/bmi160/bmi160.h                    |  13 +-
 drivers/iio/imu/bmi160/bmi160_core.c               | 280 ++++++++++++++++++++-
 drivers/iio/imu/bmi160/bmi160_i2c.c                |   8 +-
 drivers/iio/imu/bmi160/bmi160_spi.c                |   6 +-
 drivers/iio/imu/bmi160/bmi160_trigger.c            |  60 +++++
 7 files changed, 360 insertions(+), 25 deletions(-)
 create mode 100644 drivers/iio/imu/bmi160/bmi160_trigger.c

--
2.11.0

