Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:33005 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752146AbdGIQ5I (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 9 Jul 2017 12:57:08 -0400
From: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        lorenzo.bianconi@st.com
Subject: [PATCH 0/9] hts221: add new features and fix power-off procedure
Date: Sun,  9 Jul 2017 18:56:55 +0200
Message-Id: <20170709165704.26311-1-lorenzo.bianconi@st.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Patches 1-3: fix a bug in power-down/suspend procedure
Patch 4: avoid useless sample rate configurations
Patches 5-8: add active low and open drain support with corresponding
dt-binding
Patch 9: improve code readability

Lorenzo Bianconi (9):
  iio: humidity: hts221: refactor write_with_mask code
  iio: humidity: hts221: move BDU configuration in probe routine
  iio: humidity: hts221: do not overwrite reserved data during
    power-down
  iio: humidity: hts221: avoid useless ODR reconfiguration
  iio: humidity: hts221: support active-low interrupts
  dt-bindings: iio: humidity: hts221: support active-low interrupts
  iio: humidity: hts221: support open drain mode
  dt-bindings: iio: humidity: hts221: support open drain mode
  iio: humidity: hts221: move drdy enable logic in
    hts221_trig_set_state()

 .../devicetree/bindings/iio/humidity/hts221.txt    |  11 +-
 drivers/iio/humidity/hts221.h                      |   5 +-
 drivers/iio/humidity/hts221_buffer.c               |  43 ++++++-
 drivers/iio/humidity/hts221_core.c                 | 124 +++++++--------------
 4 files changed, 93 insertions(+), 90 deletions(-)

-- 
2.13.1

