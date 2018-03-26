Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-sh2.amlogic.com ([58.32.228.45]:47302 "EHLO
        mail-sh2.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751748AbeCZJCZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 26 Mar 2018 05:02:25 -0400
From: Yixun Lan <yixun.lan@amlogic.com>
To: Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
CC: Yixun Lan <yixun.lan@amlogic.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>,
        Xingyu Chen <xingyu.chen@amlogic.com>,
        <linux-iio@vger.kernel.org>, <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH 0/3] iio: adc: meson-axg: add saradc driver support
Date: Mon, 26 Mar 2018 16:46:26 +0800
Message-ID: <20180326084629.100070-1-yixun.lan@amlogic.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

 The patch 1 is a general small improvement, no function changed!
 The last two patches try to add saradc support for Amlogic'S Meson-AXG
SoC platfrom.
 I will send the DTS part patch in another thread, since it depend on
the clock AO driver[0].


[0] https://lkml.kernel.org/r/20180323143816.200573-1-yixun.lan@amlogic.com

Xingyu Chen (2):
  dt-bindings: iio: adc: document the Meson AXG support
  iio: adc: meson-axg: add saradc driver

Yixun Lan (1):
  iio: adc: meson-saradc: squash and share the common adc platform data

 .../bindings/iio/adc/amlogic,meson-saradc.txt      |  1 +
 drivers/iio/adc/meson_saradc.c                     | 83 +++++++++++++---------
 2 files changed, 51 insertions(+), 33 deletions(-)

-- 
2.15.1

