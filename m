Return-Path: <SRS0=RKAC=RS=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC1B3C43381
	for <linux-iio@archiver.kernel.org>; Fri, 15 Mar 2019 10:01:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95ED22184C
	for <linux-iio@archiver.kernel.org>; Fri, 15 Mar 2019 10:01:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728783AbfCOKBm (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Fri, 15 Mar 2019 06:01:42 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:60629 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728779AbfCOKBm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 15 Mar 2019 06:01:42 -0400
X-Originating-IP: 109.213.80.250
Received: from localhost (alyon-652-1-57-250.w109-213.abo.wanadoo.fr [109.213.80.250])
        (Authenticated sender: gregory.clement@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 1F30BC0026;
        Fri, 15 Mar 2019 10:01:37 +0000 (UTC)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Cc:     Vladimir Zapolskiy <vz@mleia.com>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-arm-kernel@lists.infradead.org,
        Gregory CLEMENT <gregory.clement@bootlin.com>
Subject: [PATCH v2 0/4] Adding scale support to the lpc32xx ADC driver
Date:   Fri, 15 Mar 2019 10:52:27 +0100
Message-Id: <20190315095231.17001-1-gregory.clement@bootlin.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello,

This is the second version of a series adding the support of the scale
feature to the lpc32xx ADC driver. In order to use it we need to have
the voltage reference as a device tree property, however in order to
be backward compatible, this property is optional and do not prevent
to use the driver if missing.

I updated the binding documentation accordingly.

Gregory

Changelog:
v1 -> v2:

 - "dt-bindings: iio: adc: move lpc32xx-adc out of staging" and
   "iio:adc:lpc32xx use SPDX-License-Identifier" has been merged

 - split "iio:adc:lpc32xx use SPDX-License-Identifier" in 2 patches
   one foe sorting and the second one for removal

 - add reviewed-by from Rob Herring on the binding documentation patch

 - add default in the switch/case in lpc32xx_read_raw()

 - no more use scan_type.realbits and directly put the value in the
   IIO_CHAN_INFO_SCALE case

 - keep the const for the struct iio_chan_spec and declare 2 of them.

 - remove the unrelated and bad whitespace change.

Gregory CLEMENT (4):
  iio: adc: lpc32xx: Sort headers
  iio: adc: lpc32xx: Cleanup headers
  iio: adc: lpc32xx: Add scale feature
  dt-bindings: iio: adc: lpc32xx-adc: Document vref-supply

 .../bindings/iio/adc/lpc32xx-adc.txt          |  5 ++
 drivers/iio/adc/lpc32xx_adc.c                 | 59 +++++++++++++------
 2 files changed, 47 insertions(+), 17 deletions(-)

-- 
2.20.1

