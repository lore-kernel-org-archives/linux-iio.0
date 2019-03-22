Return-Path: <SRS0=R23/=RZ=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 400CDC43381
	for <linux-iio@archiver.kernel.org>; Fri, 22 Mar 2019 11:11:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 092CD21917
	for <linux-iio@archiver.kernel.org>; Fri, 22 Mar 2019 11:11:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727895AbfCVLLX (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:11:23 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:42243 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726667AbfCVLLX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 22 Mar 2019 07:11:23 -0400
X-Originating-IP: 109.213.38.144
Received: from localhost (alyon-652-1-47-144.w109-213.abo.wanadoo.fr [109.213.38.144])
        (Authenticated sender: gregory.clement@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id DBECFE000A;
        Fri, 22 Mar 2019 11:11:16 +0000 (UTC)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-arm-kernel@lists.infradead.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>
Subject: [PATCH v2 0/2] Add support for the TI ADS8344 A/DC chips
Date:   Fri, 22 Mar 2019 12:11:06 +0100
Message-Id: <20190322111108.19383-1-gregory.clement@bootlin.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello,

this is the second version of a small series adding the support for
the Texas Instruments ADS8344 ADC chip. This chip has a 16-bit
8-Channel ADC and is access directly through SPI.

The first patch add the binding documentation and the second one, the
driver itself.

Changelog:

v1->v2:

 - Remove the mention to the #io-channel-cells in the first patch, as
   there is no consumer.

 - Remove scan_index and scan_type, they are not used.

 - Use defines for building the command and remove the comment.

 - Remove the goto and the label in the probe() function as the label
   was only use once.

 - Remove the "#ifdef CONFIG_OF", the driver already depends on OF.

 - Don't use of_match_ptr and rename ads8344_dt_id to ads8344_of_match.

Gregory

Gregory CLEMENT (2):
  dt-bindings: iio: adc: Add bindings for TI ADS8344 A/DC chips
  iio: adc: Add driver for the TI ADS8344 A/DC chips

 .../bindings/iio/adc/ti-ads8344.txt           |  19 ++
 drivers/iio/adc/Kconfig                       |  10 +
 drivers/iio/adc/Makefile                      |   1 +
 drivers/iio/adc/ti-ads8344.c                  | 200 ++++++++++++++++++
 4 files changed, 230 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/ti-ads8344.txt
 create mode 100644 drivers/iio/adc/ti-ads8344.c

-- 
2.20.1

