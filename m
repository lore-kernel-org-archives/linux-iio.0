Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:12998 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932224AbaLWNV2 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 23 Dec 2014 08:21:28 -0500
From: Daniel Baluta <daniel.baluta@intel.com>
To: jic23@kernel.org, knaack.h@gmx.de
Cc: lars@metafoo.de, pmeerw@pmeerw.net, daniel.baluta@intel.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	srinivas.pandruvada@linux.intel.com
Subject: [PATCH 04/10] iio: imu: kmx61: Fixup parameters alignment
Date: Tue, 23 Dec 2014 15:22:27 +0200
Message-Id: <1419340953-23161-5-git-send-email-daniel.baluta@intel.com>
In-Reply-To: <1419340953-23161-1-git-send-email-daniel.baluta@intel.com>
References: <1419340953-23161-1-git-send-email-daniel.baluta@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Daniel Baluta <daniel.baluta@intel.com>
---
 drivers/iio/imu/kmx61.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/imu/kmx61.c b/drivers/iio/imu/kmx61.c
index 4fc4f63..2652179 100644
--- a/drivers/iio/imu/kmx61.c
+++ b/drivers/iio/imu/kmx61.c
@@ -926,11 +926,11 @@ static int kmx61_read_event(struct iio_dev *indio_dev,
 }
 
 static int kmx61_write_event(struct iio_dev *indio_dev,
-			    const struct iio_chan_spec *chan,
-			    enum iio_event_type type,
-			    enum iio_event_direction dir,
-			    enum iio_event_info info,
-			    int val, int val2)
+			     const struct iio_chan_spec *chan,
+			     enum iio_event_type type,
+			     enum iio_event_direction dir,
+			     enum iio_event_info info,
+			     int val, int val2)
 {
 	struct kmx61_data *data = kmx61_get_data(indio_dev);
 
@@ -962,10 +962,10 @@ static int kmx61_read_event_config(struct iio_dev *indio_dev,
 }
 
 static int kmx61_write_event_config(struct iio_dev *indio_dev,
-				   const struct iio_chan_spec *chan,
-				   enum iio_event_type type,
-				   enum iio_event_direction dir,
-				   int state)
+				    const struct iio_chan_spec *chan,
+				    enum iio_event_type type,
+				    enum iio_event_direction dir,
+				    int state)
 {
 	struct kmx61_data *data = kmx61_get_data(indio_dev);
 	int ret = 0;
-- 
1.9.1

