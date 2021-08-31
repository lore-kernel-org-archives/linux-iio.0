Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69781C43214
	for <linux-iio@archiver.kernel.org>; Tue, 31 Aug 2021 08:00:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 549DA60C3E
	for <linux-iio@archiver.kernel.org>; Tue, 31 Aug 2021 08:00:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240136AbhHaIAx (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Tue, 31 Aug 2021 04:00:53 -0400
Received: from protonic.xs4all.nl ([83.163.252.89]:46072 "EHLO
        protonic.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240093AbhHaIAx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 31 Aug 2021 04:00:53 -0400
Received: from ert768.prtnl (ert768.prtnl [192.168.224.11])
        by sparta.prtnl (Postfix) with ESMTP id B23D744A0250;
        Tue, 31 Aug 2021 09:49:54 +0200 (CEST)
From:   Roan van Dijk <roan@protonic.nl>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Tomasz Duszynski <tomasz.duszynski@octakon.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, david@protonic.nl,
        Lars-Peter Clausen <lars@metafoo.de>,
        Roan van Dijk <roan@protonic.nl>
Subject: [PATCH 2/3] MAINTAINERS: Add myself as maintainer of the scd4x driver
Date:   Tue, 31 Aug 2021 09:48:27 +0200
Message-Id: <20210831074832.16310-3-roan@protonic.nl>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210831074832.16310-1-roan@protonic.nl>
References: <20210831074832.16310-1-roan@protonic.nl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Signed-off-by: Roan van Dijk <roan@protonic.nl>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index c6b8a720c0bc..7398ee8fda22 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16732,6 +16732,12 @@ F:	drivers/iio/chemical/scd30_core.c
 F:	drivers/iio/chemical/scd30_i2c.c
 F:	drivers/iio/chemical/scd30_serial.c
 
+SENSIRION SCD4X CARBON DIOXIDE SENSOR DRIVER
+M:	Roan van Dijk <roan@protonic.nl>
+S:	Maintained
+F:	Documentation/devicetree/bindings/iio/chemical/sensirion,scd4x.yaml
+F:	drivers/iio/chemical/scd4x.c
+
 SENSIRION SPS30 AIR POLLUTION SENSOR DRIVER
 M:	Tomasz Duszynski <tduszyns@gmail.com>
 S:	Maintained
-- 
2.30.2

