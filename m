Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C618DC432BE
	for <linux-iio@archiver.kernel.org>; Fri, 23 Jul 2021 18:31:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CB9F60F02
	for <linux-iio@archiver.kernel.org>; Fri, 23 Jul 2021 18:31:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbhGWRuu (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Fri, 23 Jul 2021 13:50:50 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:50942 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbhGWRuu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 23 Jul 2021 13:50:50 -0400
Received: from pendragon.lan (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 834BD3F2;
        Fri, 23 Jul 2021 20:31:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1627065082;
        bh=9cOAh/2P+qeSwfNSWVrGse7yKV2nCRJMElqi0UIGA/A=;
        h=From:To:Cc:Subject:Date:From;
        b=sugqkOMQjVZPhKULQ9VO8eabhHrFIbiv5lJwEP23uECSW32pYMjtol1ZoPGtkLQwE
         +RPf4IG1QYo+vAku4MjYo7139c6byIOm1eTLK0wWhOnKQudBbj/X+6yhi4DWKMb84m
         fuJkPQJnSyEE5OVk5iWL0urI02A2nKqD0gJZjkHo=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sean Nyekjaer <sean@geanix.com>, devicetree@vger.kernel.org,
        Jose Cazarin <joseespiriki@gmail.com>,
        linux-i2c@vger.kernel.org, Wolfram Sang <wsa@kernel.org>
Subject: [PATCH 0/2] iio: ti-dac5571: Add TI DAC081C081 support
Date:   Fri, 23 Jul 2021 21:31:12 +0300
Message-Id: <20210723183114.26017-1-laurent.pinchart@ideasonboard.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello,

This small patch series adds support for the TI DAC081C081 in the
ti-dac5571 IIO driver. Patch 1/2 addresses the DT bindings, and patch
2/2 the driver.

I've expanded the CC list to the I2C mailing list and Wolfram because I
think the second patch may not be the best option. Instead of addressing
this issue in all drivers, it wonder if it wouldn't be better for the
I2C subsystem to handle this internally. One option would be to extend
i2c_match_id to walk through the compatible values in case of an
OF-based match, but I'm worried this could introduce regressions.
Feedback would be welcome.

The series could still be merged as-is in the meantime if desired.

Jose Cazarin (1):
  iio: dac: dac5571: Fix chip id detection for OF devices

Laurent Pinchart (1):
  dt-bindings: iio: dac: ti,dac5571: Add TI DAC081C081 support

 .../bindings/iio/dac/ti,dac5571.yaml          | 24 ++++++++++-------
 drivers/iio/dac/ti-dac5571.c                  | 27 ++++++++++++-------
 2 files changed, 31 insertions(+), 20 deletions(-)

-- 
Regards,

Laurent Pinchart

