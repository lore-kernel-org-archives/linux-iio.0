Return-Path: <SRS0=YYtU=XN=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82679C4CECD
	for <linux-iio@archiver.kernel.org>; Wed, 18 Sep 2019 01:35:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F67F20665
	for <linux-iio@archiver.kernel.org>; Wed, 18 Sep 2019 01:35:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728330AbfIRBfc (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Tue, 17 Sep 2019 21:35:32 -0400
Received: from 68-189-91-139.static.snlo.ca.charter.com ([68.189.91.139]:42474
        "EHLO rjones.pdc.gateworks.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728164AbfIRBfc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 17 Sep 2019 21:35:32 -0400
X-Greylist: delayed 374 seconds by postgrey-1.27 at vger.kernel.org; Tue, 17 Sep 2019 21:35:32 EDT
Received: by rjones.pdc.gateworks.com (Postfix, from userid 1002)
        id 5FE621A48110; Tue, 17 Sep 2019 18:29:17 -0700 (PDT)
From:   Robert Jones <rjones@gateworks.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, Robert Jones <rjones@gateworks.com>
Subject: [PATCH 0/2] iio: imu: add support for FXOS8700
Date:   Tue, 17 Sep 2019 18:28:54 -0700
Message-Id: <20190918012856.18963-1-rjones@gateworks.com>
X-Mailer: git-send-email 2.9.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

- Document the FXOS8700 device tree binding.
- Implement basic iio driver support for FXOS8700

Robert Jones (2):
  dt-bindings: iio: imu: add fxos8700 imu binding
  io: imu: Add support for the FXOS8700 IMU

 .../devicetree/bindings/iio/imu/fxos8700.txt       |  15 +
 drivers/iio/imu/Kconfig                            |   1 +
 drivers/iio/imu/Makefile                           |   1 +
 drivers/iio/imu/fxos8700/Kconfig                   |  32 ++
 drivers/iio/imu/fxos8700/Makefile                  |   6 +
 drivers/iio/imu/fxos8700/fxos8700.h                | 183 ++++++++
 drivers/iio/imu/fxos8700/fxos8700_core.c           | 517 +++++++++++++++++++++
 drivers/iio/imu/fxos8700/fxos8700_i2c.c            |  75 +++
 drivers/iio/imu/fxos8700/fxos8700_spi.c            |  63 +++
 9 files changed, 893 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/imu/fxos8700.txt
 create mode 100644 drivers/iio/imu/fxos8700/Kconfig
 create mode 100644 drivers/iio/imu/fxos8700/Makefile
 create mode 100644 drivers/iio/imu/fxos8700/fxos8700.h
 create mode 100644 drivers/iio/imu/fxos8700/fxos8700_core.c
 create mode 100644 drivers/iio/imu/fxos8700/fxos8700_i2c.c
 create mode 100644 drivers/iio/imu/fxos8700/fxos8700_spi.c

-- 
2.9.2

