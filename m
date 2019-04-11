Return-Path: <SRS0=YN3l=SN=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CF63C282CE
	for <linux-iio@archiver.kernel.org>; Thu, 11 Apr 2019 00:36:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9C8420818
	for <linux-iio@archiver.kernel.org>; Thu, 11 Apr 2019 00:36:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726517AbfDKAgg (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Wed, 10 Apr 2019 20:36:36 -0400
Received: from lists.gateworks.com ([108.161.130.12]:25495 "EHLO
        lists.gateworks.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725982AbfDKAgg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 10 Apr 2019 20:36:36 -0400
Received: from 68-189-91-139.static.snlo.ca.charter.com ([68.189.91.139] helo=rjones.pdc.gateworks.com)
        by lists.gateworks.com with esmtp (Exim 4.82)
        (envelope-from <rjones@gateworks.com>)
        id 1hENUR-0003WC-0L; Wed, 10 Apr 2019 17:22:51 -0700
Received: by rjones.pdc.gateworks.com (Postfix, from userid 1002)
        id 2E3D81A42DCB; Wed, 10 Apr 2019 17:12:12 -0700 (PDT)
From:   Robert Jones <rjones@gateworks.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Robert Jones <rjones@gateworks.com>
Subject: [PATCH v2 0/2] iio: accel: add support for LIS2DE12
Date:   Wed, 10 Apr 2019 17:12:07 -0700
Message-Id: <20190411001209.29488-1-rjones@gateworks.com>
X-Mailer: git-send-email 2.9.2
In-Reply-To: <20190305203252.13647-1-rjones@gateworks.com>
References: <20190305203252.13647-1-rjones@gateworks.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

- Document the LIS2DE12 device tree binding.
- Add device tree support for STM LIS2DE12 accelerometer sensors.
- Add new st_sensor_settings entry for .wai == 0x33 devices with
  5376Hz capability.

Changelog:

v2:	- Removed "-accel" postfix to device tree bindings and compatible string
	- Updated .drdy_irq field to follow updated structure format

Robert Jones (2):
  dt-bindings: iio: accel: add LIS2DE12 sensor device binding
  iio: accel: add support to LIS2DE12

 .../devicetree/bindings/iio/st-sensors.txt         |  1 +
 drivers/iio/accel/Kconfig                          |  2 +-
 drivers/iio/accel/st_accel.h                       |  2 +
 drivers/iio/accel/st_accel_core.c                  | 76 ++++++++++++++++++++++
 drivers/iio/accel/st_accel_i2c.c                   |  5 ++
 5 files changed, 85 insertions(+), 1 deletion(-)

-- 
2.9.2

