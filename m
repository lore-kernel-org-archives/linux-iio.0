Return-Path: <SRS0=e/h2=QJ=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7B17C282D7
	for <linux-iio@archiver.kernel.org>; Sat,  2 Feb 2019 21:56:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DB8A2084A
	for <linux-iio@archiver.kernel.org>; Sat,  2 Feb 2019 21:56:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=martingkelly-com.20150623.gappssmtp.com header.i=@martingkelly-com.20150623.gappssmtp.com header.b="dA6mw7AQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726569AbfBBV4Q (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 2 Feb 2019 16:56:16 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37418 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726652AbfBBV4Q (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 2 Feb 2019 16:56:16 -0500
Received: by mail-pf1-f194.google.com with SMTP id y126so5011547pfb.4
        for <linux-iio@vger.kernel.org>; Sat, 02 Feb 2019 13:56:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=martingkelly-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=gw5cch49UKkwT26HoOa0bEAcusup08NCfkSL4ViUvo8=;
        b=dA6mw7AQ/89637lHUhe587FaUrXJcjkrmRD74UGIQrFzrVrFfXZQSTbEOUNt4wkxxm
         W/nAUuazqDmTpQ5yp+nVTbwO2ZhRl1A0n0NOkS2J3liBUnthmI5Dy6J21c3lxA/GwGta
         lZafttQ1HPs7HWCMBh0QwlSj971Ctl4aWDz7XWkbU+XPfmwmKiemSt+bSEI3xW+DZde8
         gAVLlZBZHtiS/UqJAPA5AIH3vnlQ/LmIQ48KDVGt+DRfuf02HkeAVTeMsbOrszmcfNtB
         HzQZecl9cQNDIGOgM2UyH1zKzPvDsZszNYbMbG5xh9BmEgCUFOQju5X1x0v935aN1Kfu
         WyeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=gw5cch49UKkwT26HoOa0bEAcusup08NCfkSL4ViUvo8=;
        b=TqAcobxDcFezJYvlUZM279iZz/eqngnhzqgREIP/FYjU2S+DgQOz8fmU9ADY2UuSoa
         ZJlUqHmZW7hYtQ+S4c1v21TsbiD+hMrxlRGoXfXN4f64YaDRsQZCOHUvsef1FOjrzXKC
         cG+pv9+B2h1pkWzn6UJzoj8vy4jUFYjDGG9TLCZJUl0SSwJzQxqbepdfVyeoU8USE469
         QrduEOv4puv5mpLDe5uG1SkJgiXhzWH6J9YBJCL9sJwd2zUCa0tRONhlVq5QbvdIkd3R
         RaDr5ToFdjbnQLII1IiWsJ0cZKvrIC25C35N3EvO/dnVjvjOeh/OLbg8PJzBBTbx+mPv
         GZNw==
X-Gm-Message-State: AJcUukdYPgIrCqnVifBcxCHJzIsN/6T4x/K94P056uun1PqnTfUiaVDI
        /Lc/+5z+do4DIotA11zrRuIm2Y/FoYI=
X-Google-Smtp-Source: ALg8bN4IJFpCZaqQbGwxvGDYHSyDAhinPs6vv6J56ehBYZV6+9KzCvl9CHCXjG+F0rxGhUmBmy38mg==
X-Received: by 2002:a62:62c5:: with SMTP id w188mr45363184pfb.160.1549144574671;
        Sat, 02 Feb 2019 13:56:14 -0800 (PST)
Received: from cascade.Home (174-21-177-9.tukw.qwest.net. [174.21.177.9])
        by smtp.gmail.com with ESMTPSA id z127sm20082025pfb.80.2019.02.02.13.56.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 02 Feb 2019 13:56:13 -0800 (PST)
From:   Martin Kelly <martin@martingkelly.com>
X-Google-Original-From: Martin Kelly <martin@martingkelly.com
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Daniel Baluta <daniel.baluta@gmail.com>,
        devicetree@vger.kernel.org, Martin Kelly <martin@martingkelly.com>
Subject: [PATCH v4 0/6] iio:bmi160: add drdy interrupt support
Date:   Sat,  2 Feb 2019 13:55:55 -0800
Message-Id: <20190202215601.20275-1-martin@martingkelly.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Martin Kelly <martin@martingkelly.com>

This patch series adds drdy interrupt support to the BMI160 IMU. It also
updates the relevant DT bindings and does a little bit of related cleanup.

v2:
- Drop "BOTH" interrupt setting.
- Change to "if (ret)" instead of "if (ret < 0)".
- Stylistic changes suggested by Jonathan Cameron.
- Fix bogus return check after iio_trigger_get.

v3:
- More cleanup changes.
- Directly get INT1/INT2 by name instead of using I2C/SPI IRQs. Move this
  code to the probe function.
- Fix EDGE/LEVEL #define naming. The code was correct but the names were
  wrong.

v4:
- Use standard "drive-open-drain" DT name.

Martin Kelly (6):
  iio:bmi160: add SPDX identifiers
  iio:bmi160: add drdy interrupt support
  dt-bindings: fix incorrect bmi160 IRQ note
  dt-bindings: document open-drain property
  iio:bmi160: use iio_pollfunc_store_time
  iio:bmi160: use if (ret) instead of if (ret < 0)

 .../devicetree/bindings/iio/imu/bmi160.txt         |   6 +-
 drivers/iio/imu/bmi160/bmi160.h                    |  11 +
 drivers/iio/imu/bmi160/bmi160_core.c               | 317 +++++++++++++++++++--
 drivers/iio/imu/bmi160/bmi160_i2c.c                |   5 +-
 drivers/iio/imu/bmi160/bmi160_spi.c                |   4 +-
 5 files changed, 304 insertions(+), 39 deletions(-)

--
2.11.0

