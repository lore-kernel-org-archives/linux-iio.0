Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-out-1.itc.rwth-aachen.de ([134.130.5.46]:51883 "EHLO
        mail-out-1.itc.rwth-aachen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751761AbdJATsc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 1 Oct 2017 15:48:32 -0400
From: =?UTF-8?q?Stefan=20Br=C3=BCns?= <stefan.bruens@rwth-aachen.de>
To: <linux-iio@vger.kernel.org>
CC: Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        =?UTF-8?q?Stefan=20Br=C3=BCns?= <stefan.bruens@rwth-aachen.de>,
        <linux-kernel@vger.kernel.org>, "Andrew F . Davis" <afd@ti.com>,
        "Javier Martinez Canillas" <javier@osg.samsung.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>
Subject: [PATCH 0/3] iio: adc: ina2xx: Fixes and extensions
Date: Sun, 1 Oct 2017 21:48:15 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Message-ID: <54bbda3c-412b-462a-92ff-659dab103f67@rwthex-w2-a.rwth-ad.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The first patch fixes an issue with the conversion-ready status flag showing
up in the bus voltage raw value.

The second patch changes the the shunt resistor value attribute to
ohms (instead of microohms), to match both ABI documentation and other shunt
resistor users, i.e. the MAX9611 IIO driver.

The third patch adds support for the INA219/220 specific bus voltage range
and shunt voltage PGA.


Stefan Brüns (3):
  iio: adc: ina2xx: Mask flag bits in bus voltage register
  iio: adc: ina2xx: Adhere to documented ABI, use Ohm instead of uOhm
  iio: adc: ina2xx: Allow setting Shunt Voltage PGA gain and Bus Voltage
    range

 drivers/iio/adc/ina2xx-adc.c | 143 +++++++++++++++++++++++++++++++++++++++----
 1 file changed, 130 insertions(+), 13 deletions(-)

-- 
2.14.1

