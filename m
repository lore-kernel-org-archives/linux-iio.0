Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-out-2.itc.rwth-aachen.de ([134.130.5.47]:29411 "EHLO
        mail-out-2.itc.rwth-aachen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751053AbdISDVg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 18 Sep 2017 23:21:36 -0400
From: =?UTF-8?q?Stefan=20Br=C3=BCns?= <stefan.bruens@rwth-aachen.de>
To: <linux-iio@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: [PATCH 0/4] iio: light: vl6180: Several fixes and enhancements
Date: Tue, 19 Sep 2017 05:11:40 +0200
Message-ID: <20170919031144.4968-1-stefan.bruens@rwth-aachen.de>
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

