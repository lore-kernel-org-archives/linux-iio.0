Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F02C2C11F67
	for <linux-iio@archiver.kernel.org>; Tue, 29 Jun 2021 22:03:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D017161D70
	for <linux-iio@archiver.kernel.org>; Tue, 29 Jun 2021 22:03:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233660AbhF2WGN (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Tue, 29 Jun 2021 18:06:13 -0400
Received: from relmlor1.renesas.com ([210.160.252.171]:61189 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233487AbhF2WGN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 29 Jun 2021 18:06:13 -0400
X-IronPort-AV: E=Sophos;i="5.83,310,1616425200"; 
   d="scan'208";a="85915372"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 30 Jun 2021 07:03:43 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 241BE40108F4;
        Wed, 30 Jun 2021 07:03:40 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 0/2] Renesas RZ/G2L ADC driver support
Date:   Tue, 29 Jun 2021 23:03:26 +0100
Message-Id: <20210629220328.13366-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi All,

This patch series adds DT binding and driver support for ADC block
found on Renesas RZ/G2L family.

Patches are based on top of rzg2l-update-clock-defs-v4 branch found on [1]

[1] https://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers.git/

Cheers,
Prabhakar

Lad Prabhakar (2):
  dt-bindings: iio: adc: Add binding documentation for Renesas RZ/G2L
    A/D converter
  iio: adc: Add driver for Renesas RZ/G2L A/D converter

 .../bindings/iio/adc/renesas,rzg2l-adc.yaml   | 121 +++++
 MAINTAINERS                                   |   8 +
 drivers/iio/adc/Kconfig                       |  10 +
 drivers/iio/adc/Makefile                      |   1 +
 drivers/iio/adc/rzg2l_adc.c                   | 489 ++++++++++++++++++
 5 files changed, 629 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc.yaml
 create mode 100644 drivers/iio/adc/rzg2l_adc.c


base-commit: 06c1e6911a7a76b446e4b00fc8bad5d8465932f8
-- 
2.17.1

