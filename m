Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([46.235.227.227]:48157 "EHLO
	bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751389AbcGRHDM (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 18 Jul 2016 03:03:12 -0400
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
To: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Cc: Olof Johansson <olof@lixom.net>, Lee Jones <lee.jones@linaro.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Guenter Roeck <groeck@chromium.org>,
	Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH 03/10] iio: core: Add double tap as possible gesture
Date: Mon, 18 Jul 2016 09:02:43 +0200
Message-Id: <1468825370-20075-4-git-send-email-enric.balletbo@collabora.com>
In-Reply-To: <1468825370-20075-1-git-send-email-enric.balletbo@collabora.com>
References: <1468825370-20075-1-git-send-email-enric.balletbo@collabora.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Gwendal Grignou <gwendal@chromium.org>

This is an interface change: however, the sysfs entry is based on string,
so if other gestures are added on the trunk in the meantime, we will
still be able to merge this change.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
Signed-off-by: Guenter Roeck <groeck@chromium.org>
[enric: Rebased and resolved conflicts]
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---
 drivers/iio/industrialio-core.c | 1 +
 include/uapi/linux/iio/types.h  | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index e6319a9..f700e67 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -119,6 +119,7 @@ static const char * const iio_modifier_names[] = {
 	[IIO_MOD_Q] = "q",
 	[IIO_MOD_CO2] = "co2",
 	[IIO_MOD_VOC] = "voc",
+	[IIO_MOD_DOUBLE_TAP] = "double_tap",
 };
 
 /* relies on pairs of these shared then separate */
diff --git a/include/uapi/linux/iio/types.h b/include/uapi/linux/iio/types.h
index b0916fc..c290167 100644
--- a/include/uapi/linux/iio/types.h
+++ b/include/uapi/linux/iio/types.h
@@ -79,6 +79,7 @@ enum iio_modifier {
 	IIO_MOD_CO2,
 	IIO_MOD_VOC,
 	IIO_MOD_LIGHT_UV,
+	IIO_MOD_DOUBLE_TAP,
 };
 
 enum iio_event_type {
-- 
2.1.0

