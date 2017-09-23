Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-out-1.itc.rwth-aachen.de ([134.130.5.46]:57310 "EHLO
        mail-out-1.itc.rwth-aachen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750839AbdIWW6d (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 23 Sep 2017 18:58:33 -0400
From: =?UTF-8?q?Stefan=20Br=C3=BCns?= <stefan.bruens@rwth-aachen.de>
To: <linux-iio@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: [PATCH v2 0/4] iio: light: vl6180: Several fixes and enhancements
Date: Sun, 24 Sep 2017 00:58:20 +0200
Message-ID: <20170923225824.8435-1-stefan.bruens@rwth-aachen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Currently, the vl6180 driver reports bogus in_illuminance_scale values
when the integration time or hardware gain are changed from its default
value, i.e. it always reports a fixed value.

To avoid readback of the register values in case integration time, gain
or scale is queried, save the register values. Use the saved values
to report the correct scale value.

v2: removed redundant parenthesis, add missing spaces

Stefan Brüns (4):
  iio: light: vl6180: Move range check to integration time setter,
    cleanup
  iio: light: vl6180: Avoid readback of integration time register
  iio: light: vl6180: Cleanup als_gain lookup, avoid register readback
  iio: light: vl6180: Correct ALS scale for non-default gain/integration
    time

 drivers/iio/light/vl6180.c | 125 +++++++++++++++++++++++++--------------------
 1 file changed, 69 insertions(+), 56 deletions(-)

-- 
2.14.1

