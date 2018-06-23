Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([217.72.192.73]:40997 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751724AbeFWSyi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 23 Jun 2018 14:54:38 -0400
Date: Sat, 23 Jun 2018 20:53:51 +0200
From: Andreas Klinger <ak@it-klinger.de>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, robh+dt@kernel.org, mark.rutland@arm.com,
        mchehab@kernel.org, davem@davemloft.net,
        gregkh@linuxfoundation.org, akpm@linux-foundation.org,
        linus.walleij@linaro.org, rdunlap@infradead.org,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] iio: hx711: add data-ready-delay
Message-ID: <20180623185351.GA17830@arbeit>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch adds an additional property in the device tree for adjusting the
delay between a rising edge on PD_SCK until data is ready on DOUT.

This is necessary because of parasitic capacities on different systems.

Furthermore a maintainer for this driver is added.

Andreas Klinger (3):
  iio: hx711: add data-ready-delay-ns property in DT
  iio: hx711: add delay until DOUT is ready
  iio: hx711: add maintainer for driver

 .../devicetree/bindings/iio/adc/avia-hx711.txt     |  9 ++++++++-
 MAINTAINERS                                        |  7 +++++++
 drivers/iio/adc/hx711.c                            | 23 ++++++++++++++++++++++
 3 files changed, 38 insertions(+), 1 deletion(-)

-- 
2.1.4
