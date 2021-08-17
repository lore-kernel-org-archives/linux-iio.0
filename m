Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFE7BC19F37
	for <linux-iio@archiver.kernel.org>; Tue, 17 Aug 2021 15:52:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C085860FD9
	for <linux-iio@archiver.kernel.org>; Tue, 17 Aug 2021 15:52:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240342AbhHQPxM (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Tue, 17 Aug 2021 11:53:12 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:38847 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240412AbhHQPt6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 17 Aug 2021 11:49:58 -0400
Received: (Authenticated sender: jacopo@jmondi.org)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 1A854200003;
        Tue, 17 Aug 2021 15:49:12 +0000 (UTC)
From:   Jacopo Mondi <jacopo@jmondi.org>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>
Cc:     Jacopo Mondi <jacopo@jmondi.org>, linux-iio@vger.kernel.org
Subject: [PATCH 0/2] iio: chemical: Add Senseair Sunrise CO2 sensor
Date:   Tue, 17 Aug 2021 17:49:49 +0200
Message-Id: <20210817154951.50208-1-jacopo@jmondi.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello,
   this is a small driver for the Senseair Sunrise 006-0-0007 CO2
sensor.

The driver supports continuous reads of temperature and CO2 concentration
through two dedicated IIO channels.

While the driver is rather simple I'm not sure calibration is handled in
the correct way. In this version, at probe time, a check on the general
error register is made to verify if a calibration cycle is required.
The calibration takes a time in the order of a few seconds, and currently
can only happen at probe time.

Is there a mechanism available in the IIO framework to expose a trigger to have
userspace decide when the calibration has to happen ? In my understanding IIO
triggers are meant to trigger read events, using them for calibration purpose
seems not the right thing to do, or am I mistaken ?

Thanks
  j

Jacopo Mondi (2):
  dt-bindings: iio: chemical: Document senseair,sunrise CO2 sensor
  iio: chemical: Add Senseair Sunrise 006-0-007 driver

 .../iio/chemical/senseair,sunrise.yaml        |  51 +++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 MAINTAINERS                                   |   6 +
 drivers/iio/chemical/Kconfig                  |  10 +
 drivers/iio/chemical/Makefile                 |   1 +
 drivers/iio/chemical/sunrise.c                | 310 ++++++++++++++++++
 6 files changed, 380 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/chemical/senseair,sunrise.yaml
 create mode 100644 drivers/iio/chemical/sunrise.c

--
2.32.0

