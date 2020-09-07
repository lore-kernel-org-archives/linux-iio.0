Return-Path: <SRS0=NC80=CQ=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02827C43461
	for <linux-iio@archiver.kernel.org>; Mon,  7 Sep 2020 16:12:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2C5221556
	for <linux-iio@archiver.kernel.org>; Mon,  7 Sep 2020 16:12:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599495142;
	bh=EgcGYI2rVd7bR3g7yzbftA3wisdwdNpGYVOuaoZF1uw=;
	h=From:To:Subject:Date:List-ID:From;
	b=AWPjAtRMh/nJcg57oKuVeDgLsX9GLdQB+fpYgYfa6bSdP2xxH51xETKA67WIrbX9O
	 kFsPDoun7QykDle9pTZj7/6LCty370xqz6Cye3G8kY/vRFqEBxaQyGQO/V99yAio5K
	 UUyVGEoR2BkfzcO9U41Q3UBKnQNNAwocGJg189pE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729923AbgIGQMI (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Mon, 7 Sep 2020 12:12:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:60616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729821AbgIGQME (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 7 Sep 2020 12:12:04 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0689C206E6;
        Mon,  7 Sep 2020 16:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599495124;
        bh=EgcGYI2rVd7bR3g7yzbftA3wisdwdNpGYVOuaoZF1uw=;
        h=From:To:Subject:Date:From;
        b=pxiV/AJBlGNy8ZHR6Z8x38a0poEEfzUKVHS7Cb32JKvz1ZgEt5gBx7TC3Q7J3BN8N
         rXRiyTmTsFpe9mITp5oU0WNAHgxcrxI+NUd2HmwG3HZtIt1Ahwp0Jc2Ii0nYuvRoJ/
         Pa7gelW4fJ1U+9Az06VsxsOKUk2phXa5amm7OPC0=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jonathan Bakker <xc-racer2@live.ca>,
        =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: [PATCH 00/25] ARM: dts: s5pv210: Cleanup - dtschema warnings
Date:   Mon,  7 Sep 2020 18:11:16 +0200
Message-Id: <20200907161141.31034-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi

The patchset tries to remove most of the dtschema warnings.  Due to lack
of hardware it was not tested.

Best regards,
Krzysztof


Krzysztof Kozlowski (25):
  dt-bindings: samsung: pmu: document S5Pv210
  dt-bindings: iio: adc: exynos-adc: require second interrupt with touch
    screen
  dt-bindings: iio: adc: exynos-adc: do not require syscon on S5Pv210
  ARM: dts: s5pv210: fix pinctrl property of "vibrator-en" regulator in
    Aries
  ARM: dts: s5pv210: remove DMA controller bus node name to fix dtschema
    warnings
  ARM: dts: s5pv210: move fixed clocks under root node
  ARM: dts: s5pv210: move PMU node out of clock controller
  ARM: dts: s5pv210: remove dedicated 'audio-subsystem' node
  ARM: dts: s5pv210: fix number of I2S DAI cells
  ARM: dts: s5pv210: add RTC 32 KHz clock in Aquilla
  ARM: dts: s5pv210: add RTC 32 KHz clock in Aries family
  ARM: dts: s5pv210: add RTC 32 KHz clock in Goni
  ARM: dts: s5pv210: add RTC 32 KHz clock in SMDKC110
  ARM: dts: s5pv210: add RTC 32 KHz clock in SMDKV210
  ARM: dts: s5pv210: add RTC 32 KHz clock in Torbreck
  ARM: dts: s5pv210: use defines for GPIO flags in Aquila
  ARM: dts: s5pv210: use defines for GPIO flags in Goni
  ARM: dts: s5pv210: use defines for IRQ flags in SMDKV210
  ARM: dts: s5pv210: use defines for IRQ flags in Goni
  ARM: dts: s5pv210: move fixed regulators under root node in Aquila
  ARM: dts: s5pv210: move fixed regulators under root node in Goni
  ARM: dts: s5pv210: replace deprecated "gpios" i2c-gpio property in
    Aquila
  ARM: dts: s5pv210: replace deprecated "gpios" i2c-gpio property in
    Goni
  ARM: dts: s5pv210: align SPI GPIO node name with dtschema in Aries
  ARM: dts: s5pv210: align DMA channels with dtschema

 .../devicetree/bindings/arm/samsung/pmu.yaml  |   2 +
 .../bindings/iio/adc/samsung,exynos-adc.yaml  |  16 +-
 arch/arm/boot/dts/s5pv210-aquila.dts          |  73 ++++----
 arch/arm/boot/dts/s5pv210-aries.dtsi          |  16 +-
 arch/arm/boot/dts/s5pv210-fascinate4g.dts     |   2 +-
 arch/arm/boot/dts/s5pv210-galaxys.dts         |   2 +-
 arch/arm/boot/dts/s5pv210-goni.dts            |  97 +++++-----
 arch/arm/boot/dts/s5pv210-smdkc110.dts        |   9 +
 arch/arm/boot/dts/s5pv210-smdkv210.dts        |  12 +-
 arch/arm/boot/dts/s5pv210-torbreck.dts        |   9 +
 arch/arm/boot/dts/s5pv210.dtsi                | 175 ++++++++----------
 11 files changed, 230 insertions(+), 183 deletions(-)

-- 
2.17.1

