Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:30929 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752999AbaBDJP6 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 4 Feb 2014 04:15:58 -0500
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N0G00CJWSEK9620@mailout4.samsung.com> for
 linux-iio@vger.kernel.org; Tue, 04 Feb 2014 18:15:57 +0900 (KST)
Message-id: <52F0AFCC.7030306@samsung.com>
Date: Tue, 04 Feb 2014 18:15:56 +0900
From: Beomho Seo <beomho.seo@samsung.com>
MIME-version: 1.0
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, ldewangan@nvidia.com,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Myungjoo Ham <myungjoo.ham@samsung.com>,
	Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH RESEND 0/2] iio: ak8975: Fix calculation formula and add device
 name
Content-type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

 Three months ago Peter Meerwald revised description of device driver[1].
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
