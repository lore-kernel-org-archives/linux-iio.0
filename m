Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.19]:50749 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751933AbbFOVsm (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 15 Jun 2015 17:48:42 -0400
From: Hartmut Knaack <knaack.h@gmx.de>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Octavian Purdila <octavian.purdila@intel.com>,
	Laurentiu Palcu <laurentiu.palcu@intel.com>
Subject: [PATCH 1/3] iio:accel:bmc150-accel: fix counting direction
Date: Mon, 15 Jun 2015 23:48:24 +0200
Message-Id: <905a190eec730a8e31863e079a55029612784d93.1434404216.git.knaack.h@gmx.de>
In-Reply-To: <cover.1434404216.git.knaack.h@gmx.de>
References: <cover.1434404216.git.knaack.h@gmx.de>
In-Reply-To: <cover.1434404216.git.knaack.h@gmx.de>
References: <cover.1434404216.git.knaack.h@gmx.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

In bmc150_accel_unregister_triggers() triggers should be unregistered in
reverse order of registration. Trigger registration starts with number 0,
counting up. In consequence, trigger number needs to be count down here.

Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
---
 drivers/iio/accel/bmc150-accel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/accel/bmc150-accel.c b/drivers/iio/accel/bmc150-accel.c
index 4e70f51..cc5a357 100644
--- a/drivers/iio/accel/bmc150-accel.c
+++ b/drivers/iio/accel/bmc150-accel.c
@@ -1464,7 +1464,7 @@ static void bmc150_accel_unregister_triggers(struct bmc150_accel_data *data,
 {
 	int i;
 
-	for (i = from; i >= 0; i++) {
+	for (i = from; i >= 0; i--) {
 		if (data->triggers[i].indio_trig) {
 			iio_trigger_unregister(data->triggers[i].indio_trig);
 			data->triggers[i].indio_trig = NULL;
-- 
2.3.6

