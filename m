Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from eu1sys200aog118.obsmtp.com ([207.126.144.145]:60615 "EHLO
	eu1sys200aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753136Ab3EINgB (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 9 May 2013 09:36:01 -0400
From: Denis CIOCCA <denis.ciocca@st.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org, denis.ciocca@gmail.com,
	Denis Ciocca <denis.ciocca@st.com>
Subject: [PATCH] iio:common: added disable function after read info raw data
Date: Thu,  9 May 2013 15:35:49 +0200
Message-Id: <1368106549-6352-1-git-send-email-denis.ciocca@st.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Denis Ciocca <denis.ciocca@st.com>
---
 drivers/iio/common/st_sensors/st_sensors_core.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/common/st_sensors/st_sensors_core.c b/drivers/iio/common/st_sensors/st_sensors_core.c
index bd33473..ed9bc8a 100644
--- a/drivers/iio/common/st_sensors/st_sensors_core.c
+++ b/drivers/iio/common/st_sensors/st_sensors_core.c
@@ -312,6 +312,8 @@ int st_sensors_read_info_raw(struct iio_dev *indio_dev,
 			goto read_error;
 
 		*val = *val >> ch->scan_type.shift;
+
+		err = st_sensors_set_enable(indio_dev, false);
 	}
 	mutex_unlock(&indio_dev->mlock);
 
-- 
1.7.9.5

