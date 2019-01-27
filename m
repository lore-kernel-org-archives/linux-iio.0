Return-Path: <SRS0=pB1S=QD=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE350C282CA
	for <linux-iio@archiver.kernel.org>; Sun, 27 Jan 2019 20:39:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 887602133F
	for <linux-iio@archiver.kernel.org>; Sun, 27 Jan 2019 20:39:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=martingkelly-com.20150623.gappssmtp.com header.i=@martingkelly-com.20150623.gappssmtp.com header.b="vmb91WlJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726232AbfA0Uj1 (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 27 Jan 2019 15:39:27 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33514 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726867AbfA0Uj1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 27 Jan 2019 15:39:27 -0500
Received: by mail-pf1-f194.google.com with SMTP id c123so7075202pfb.0
        for <linux-iio@vger.kernel.org>; Sun, 27 Jan 2019 12:39:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=martingkelly-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=ncFwd11+Q5jpEtp2fzuVcDCvWzhxR5Y6lqxkasMiQZc=;
        b=vmb91WlJmrOSoQ/yqKs0yjlh6s41xxLsWeD7iqsz6lunSVGuCfiM6SjDTfE6gc9X6C
         blmVO4hlcPCyXn+xf66xErhIauqIobTwri+l37uNBkbpI6tU6F0sduJZwa4wjUUFBrv5
         9qRaI4pgxOPpJfhi8x1/aQewaGWuur6oBPMxfrG0F+lNywphccD+LatVNlPHlXVEHxa9
         5TFwYCGVT78oK/hbMnD0wLiYQ6TtKQjq24ykw+/9l6YuJqoIcOOjIYNnfS/vd3FSfLug
         xS348pPUSDgWbR6CbDOXJu0QptQoNtK1W/EjYm6tuntn/VMALnChuQ10eLs6LFU23qk9
         FvPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ncFwd11+Q5jpEtp2fzuVcDCvWzhxR5Y6lqxkasMiQZc=;
        b=l/nx1Aep7qI2zNsdwbnPIpP7KZc+H9OUZo5bfEN1p3fiajnB69DOq6221qZOqXhGoz
         0/jtgA8j65o9QzLxjdyvLWDz6/PMPwPA8Lbw0aV35LFqvBOVwY5VdarogZhOn1wYrepj
         BeM3XdoiV/ZuJ3DFF/RHd+LvnR3u5LKwuAb/0NTF/wvk3+JjEOh83PiS2NS6TBNmbbNN
         JrdBhgtI67PrgqCcfMiX+3LjI6okkduLf0+igfgy8ej6np/lCQKHA9GlpnrXJkzscd9Q
         Q0uXUfaFJ6EpXnnTXH0G15NKYkfZQydfyOt5MOYO08bzON5ACgkSJmVX5HS9qt0DyYrl
         4eYw==
X-Gm-Message-State: AJcUukdhA3eUdRdS1+oinLtG6Gxknz3T+463IBmXljsRI4rYHeCNSGgh
        RQERNFJLJc+N7yA2/gbiyd3sJ+mTHbaNgg==
X-Google-Smtp-Source: ALg8bN7BkEoi1RX4C48qwWBDSf7hibyUZbnwO3QB+UDLlDxUoWjAmsrSoBrb2rDUeKPssFsLMqm1hQ==
X-Received: by 2002:a65:6215:: with SMTP id d21mr17466815pgv.289.1548621566684;
        Sun, 27 Jan 2019 12:39:26 -0800 (PST)
Received: from cascade.Home (174-21-177-9.tukw.qwest.net. [174.21.177.9])
        by smtp.gmail.com with ESMTPSA id a4sm33049912pgv.70.2019.01.27.12.39.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 27 Jan 2019 12:39:25 -0800 (PST)
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
Subject: [PATCH v3 0/6] iio:bmi160: add drdy interrupt support
Date:   Sun, 27 Jan 2019 12:39:05 -0800
Message-Id: <20190127203911.8696-1-martin@martingkelly.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Martin Kelly <martin@martingkelly.com>

This patch series adds drdy interrupt support to the BMI160 IMU. It also updates
the relevant DT bindings and does a little bit of related cleanup.

v2:
- Drop "BOTH" interrupt setting.
- Change to "if (ret)" instead of "if (ret < 0)".
- Stylistic changes suggested by Jonathan Cameron.
- Fix bogus return check after iio_trigger_get.

v3:
- More cleanup changes.
- Directly get INT1/INT2 by name instead of using I2C/SPI IRQs. Move this code
  to the probe function.
- Fix EDGE/LEVEL #define naming. The code was correct but the names were wrong.

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

