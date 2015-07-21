Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:36445 "EHLO
	mx08-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754088AbbGUIgq (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 21 Jul 2015 04:36:46 -0400
From: Giuseppe Barba <giuseppe.barba@st.com>
To: <linux-iio@vger.kernel.org>
CC: <denis.ciocca@st.com>, <jic23@kernel.org>,
	Giuseppe Barba <giuseppe.barba@st.com>
Subject: [PATCH V4 2/5] iio: st-sensors: add support for single full scale device
Date: Tue, 21 Jul 2015 10:35:42 +0200
Message-ID: <1437467745-18435-3-git-send-email-giuseppe.barba@st.com>
In-Reply-To: <1437467745-18435-1-git-send-email-giuseppe.barba@st.com>
References: <1437467745-18435-1-git-send-email-giuseppe.barba@st.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Some sensors could have only one full scale value. This means that the
sensor hasn't a full scale register. This commit add a check on the
configured full scale address to support such kind of sensors.

Signed-off-by: Giuseppe Barba <giuseppe.barba@st.com>
---
 drivers/iio/common/st_sensors/st_sensors_core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iio/common/st_sensors/st_sensors_core.c b/drivers/iio/common/st_sensors/st_sensors_core.c
index d44bf16..2e7fdb5 100644
--- a/drivers/iio/common/st_sensors/st_sensors_core.c
+++ b/drivers/iio/common/st_sensors/st_sensors_core.c
@@ -126,6 +126,9 @@ static int st_sensors_set_fullscale(struct iio_dev *indio_dev, unsigned int fs)
 	int err, i = 0;
 	struct st_sensor_data *sdata = iio_priv(indio_dev);
 
+	if (sdata->sensor_settings->fs.addr == 0)
+		return 0;
+
 	err = st_sensors_match_fs(sdata->sensor_settings, fs, &i);
 	if (err < 0)
 		goto st_accel_set_fullscale_error;
-- 
1.9.1

