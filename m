Return-Path: <SRS0=s3vC=37=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95FF4C35242
	for <linux-iio@archiver.kernel.org>; Tue, 11 Feb 2020 19:12:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79F0B20873
	for <linux-iio@archiver.kernel.org>; Tue, 11 Feb 2020 19:12:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730030AbgBKTMo (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Tue, 11 Feb 2020 14:12:44 -0500
Received: from ip-78-45-52-129.net.upcbroadband.cz ([78.45.52.129]:53636 "EHLO
        ixit.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729547AbgBKTMo (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 11 Feb 2020 14:12:44 -0500
Received: from localhost.localdomain (227.146.230.94.awnet.cz [94.230.146.227])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id 60E0F2517B;
        Tue, 11 Feb 2020 20:12:40 +0100 (CET)
From:   David Heidelberg <david@ixit.cz>
To:     Dmitry Osipenko <digetx@gmail.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     David Heidelberg <david@ixit.cz>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v5 0/7] iio: light: AL3010 introduction
Date:   Tue, 11 Feb 2020 20:11:54 +0100
Message-Id: <20200211191201.1049902-1-david@ixit.cz>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

These patches implement support for simple iio light sensor AL3010 and
also improves and align formating of AL3320a which is origin of al3010
driver.

AL3010 is used in many devices, mostly tegra2/3 based.
This effort is aimed for reducing number of out-of-tree patches for
tegra tablets and phones.

This sensor is tested on Nexus 7 (2012, grouper/tilapia).

David Heidelberg (7):
  dt-bindings: iio: light: add support for Dyna-Image AL3320A
  dt-bindings: iio: light: add support for Dyna-Image AL3010
  iio: light: al3320a slightly improve code formatting
  iio: light: add Dyna-Image AL3010 driver
  iio: light: al3320a implement suspend support
  iio: light: al3320a implement devm_add_action_or_reset
  iio: light: al3320a allow module autoload and polish

 .../devicetree/bindings/iio/light/al3010.yaml |  43 ++++
 .../bindings/iio/light/al3320a.yaml           |  43 ++++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 drivers/iio/light/Kconfig                     |  10 +
 drivers/iio/light/Makefile                    |   1 +
 drivers/iio/light/al3010.c                    | 240 ++++++++++++++++++
 drivers/iio/light/al3320a.c                   |  72 ++++--
 7 files changed, 394 insertions(+), 17 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/light/al3010.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/light/al3320a.yaml
 create mode 100644 drivers/iio/light/al3010.c

-- 
2.25.0

