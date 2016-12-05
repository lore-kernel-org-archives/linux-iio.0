Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([46.235.227.227]:40655 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751592AbcLEJN1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 5 Dec 2016 04:13:27 -0500
From: Thierry Escande <thierry.escande@collabora.com>
To: Jonathan Cameron <jic23@kernel.org>,
        Gwendal Grignou <gwendal@chromium.org>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: [PATCH 2/3] iio: core: Add double tap as possible gesture
Date: Mon,  5 Dec 2016 10:13:17 +0100
Message-Id: <1480929198-13671-3-git-send-email-thierry.escande@collabora.com>
In-Reply-To: <1480929198-13671-1-git-send-email-thierry.escande@collabora.com>
References: <1480929198-13671-1-git-send-email-thierry.escande@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset = "utf-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Gwendal Grignou <gwendal@chromium.org>

This adds the IIO_MOD_DOUBLE_TAP entry to the iio_modifier enum and the
corresponding "double_tap" string to the iio_modifier_names array.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
Signed-off-by: Thierry Escande <thierry.escande@collabora.com>
---
 drivers/iio/industrialio-core.c | 1 +
 include/uapi/linux/iio/types.h  | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index fc340ed..82ce05f 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -120,6 +120,7 @@ static const char * const iio_modifier_names[] = {
 	[IIO_MOD_Q] = "q",
 	[IIO_MOD_CO2] = "co2",
 	[IIO_MOD_VOC] = "voc",
+	[IIO_MOD_DOUBLE_TAP] = "double_tap",
 };
 
 /* relies on pairs of these shared then separate */
diff --git a/include/uapi/linux/iio/types.h b/include/uapi/linux/iio/types.h
index 22e5e58..47d2768 100644
--- a/include/uapi/linux/iio/types.h
+++ b/include/uapi/linux/iio/types.h
@@ -80,6 +80,7 @@ enum iio_modifier {
 	IIO_MOD_CO2,
 	IIO_MOD_VOC,
 	IIO_MOD_LIGHT_UV,
+	IIO_MOD_DOUBLE_TAP,
 };
 
 enum iio_event_type {
-- 
2.7.4

