Return-Path: <SRS0=EHnK=CU=samsung.com=m.purski@kernel.org>
MIME-version: 1.0
Content-type: text/plain; charset="UTF-8"
From: Maciej Purski <m.purski@samsung.com>
To: Jonathan Cameron <jic23@kernel.org>, Stefan Bruens
	<stefan.bruens@rwth-aachen.de>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org, Javier Martinez Canillas
	<javier@osg.samsung.com>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Lars-Peter Clausen <lars@metafoo.de>, Hartmut Knaack <knaack.h@gmx.de>, Jean
	Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, Marek
	Szyprowski <m.szyprowski@samsung.com>, Bartlomiej Zolnierkiewicz
	<b.zolnierkie@samsung.com>, Maciej Purski <m.purski@samsung.com>
Subject: [PATCH 0/2] Make calibration register value fixed for ina2xx
 drivers
Date: Wed, 22 Nov 2017 16:32:13 +0100
Message-id: <1511364735-16818-1-git-send-email-m.purski@samsung.com>
References: <CGME20171122153241eucas1p26b8796ba5427a64c2e742a728666e4b2@eucas1p2.samsung.com>
List-ID: <linux-iio@vger.kernel.org>

Hi all,

this patchset contains work based on discussion with Stefan Brüns <stefan.bruens@rwth-aachen.de> and Jonathan Cameron <jic23@kernel.org>:
https://lkml.org/lkml/2017/10/14/198

on my previous patchset:
https://www.spinics.net/lists/devicetree/msg196452.html

The same changes are applied for both iio and hwmon ina2xx drivers.

Best regards,

Maciej Purski

Maciej Purski (2):
  iio: adc: ina2xx: Make calibration register value fixed
  hwmon: (ina2xx) Make calibration register value fixed

 drivers/hwmon/ina2xx.c       | 87 +++++++++++++++++++++++++-------------------
 drivers/iio/adc/ina2xx-adc.c | 59 ++++++++++++++++--------------
 2 files changed, 82 insertions(+), 64 deletions(-)

-- 
2.7.4
