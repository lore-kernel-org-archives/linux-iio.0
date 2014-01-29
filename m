Return-Path: <beomho.seo@samsung.com>
Message-id: <52E88BFC.6080704@samsung.com>
Date: Wed, 29 Jan 2014 14:05:00 +0900
From: Beomho Seo <beomho.seo@samsung.com>
MIME-version: 1.0
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Myungjoo Ham <myungjoo.ham@samsung.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, ldewangan@nvidia.com
Subject: [PATCH 0/2] iio: ak8975: Fix calculation formula and add device name
Content-type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

 Three months ago Lars-Peter revised description of device driver[1].
Correctly, device's sensitivity is 0.3 uT/LSB typ and One micro tesla equal 0.01 gauss[2].
So I have fixed calculation formula,And then add RAW_TO_GAUSS macro.
Scale are returned as VAL_INT_PLUS_MICRO.
Additionally, I have add device name.

Tested on exynos4412 board, with following result:

-sh-4.1# cat name
ak8975
-sh-4.1# cat in_magn_x_raw
80
-sh-4.1# cat in_magn_x_scale
0.003609

Calculate the result 80 x 0.003609 = 0.28872 Gauss.
0.28872 G equal 288.72 mG

I think this magnitude value is proper level[3].

[1] http://marc.info/?l=linux-iio&m=138220306822747&w=2
[2] http://en.wikipedia.org/wiki/Gauss_(unit)
[3] http://en.wikipedia.org/wiki/Orders_of_magnitude_(magnetic_field)

Beomho Seo (2):
  iio: ak8975: Fix calculation formula for microtesla to gauss unit
  iio: ak8975: Add device name

 drivers/iio/magnetometer/ak8975.c |   17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

-- 
Best Regards,
