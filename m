Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:38315 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726115AbeKTFaY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 20 Nov 2018 00:30:24 -0500
From: Denis CIOCCA <denis.ciocca@st.com>
To: Jian-Hong Pan <jian-hong@endlessm.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "Dominique Martinet" <asmadeus@codewreck.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux@endlessm.com" <linux@endlessm.com>
Subject: RE: [PATCH] iio: st_sensors: Fix the sleep time for sampling
Date: Mon, 19 Nov 2018 19:04:59 +0000
Message-ID: <04d0345d6c6c4ac0950ab0676ffd7689@SFHDAG2NODE1.st.com>
References: <20181119061219.14238-1-jian-hong@endlessm.com>
In-Reply-To: <20181119061219.14238-1-jian-hong@endlessm.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Jian,

Not clear to me why should be + instead of *.

ODR is expressed in Hz, so (1/Hz) = period in seconds (1 sample sampling time) [s]
1000 * (1/Hz) = period in milliseconds (1 sample sampling time) [ms]
n * 1000 * (1/Hz) = n times period in milliseconds (n times sample sampling time) [ms]

In your case you assume bootime is in milliseconds. Maybe we can change the comment and use 'number of samples ...'.

Br,
Denis



-----Original Message-----
From: linux-iio-owner@vger.kernel.org <linux-iio-owner@vger.kernel.org> On Behalf Of Jian-Hong Pan
Sent: Sunday, November 18, 2018 10:12 PM
To: Jonathan Cameron <jic23@kernel.org>; Hartmut Knaack <knaack.h@gmx.de>; Lars-Peter Clausen <lars@metafoo.de>; Peter Meerwald-Stadler <pmeerw@pmeerw.net>; Dominique Martinet <asmadeus@codewreck.org>
Cc: linux-iio@vger.kernel.org; linux-kernel@vger.kernel.org; linux@endlessm.com; Jian-Hong Pan <jian-hong@endlessm.com>
Subject: [PATCH] iio: st_sensors: Fix the sleep time for sampling

According to the description of st_sensor_settings and st_sensor_data structures' comments:
- bootime: samples to discard when sensor passing from power-down to power-up.
- odr: Output data rate of the sensor [Hz].

The sleep time should be
sdata->sensor_settings->bootime + 1000 / sdata->odr ms.

Signed-off-by: Jian-Hong Pan <jian-hong@endlessm.com>
---
 drivers/iio/common/st_sensors/st_sensors_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/common/st_sensors/st_sensors_core.c b/drivers/iio/common/st_sensors/st_sensors_core.c
index 26fbd1bd9413..6b87ea657a92 100644
--- a/drivers/iio/common/st_sensors/st_sensors_core.c
+++ b/drivers/iio/common/st_sensors/st_sensors_core.c
@@ -594,7 +594,7 @@ int st_sensors_read_info_raw(struct iio_dev *indio_dev,
 		if (err < 0)
 			goto out;
 
-		msleep((sdata->sensor_settings->bootime * 1000) / sdata->odr);
+		msleep(sdata->sensor_settings->bootime + 1000 / sdata->odr);
 		err = st_sensors_read_axis_data(indio_dev, ch, val);
 		if (err < 0)
 			goto out;
--
2.11.0
