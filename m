Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([46.235.227.227]:40672 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754638AbdIROxe (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 18 Sep 2017 10:53:34 -0400
From: Thierry Escande <thierry.escande@collabora.com>
To: Benson Leung <bleung@chromium.org>,
        Jonathan Cameron <jic23@kernel.org>
Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] platform/chrome: cros_ec_lpc: Add support for Google Glimmer
Date: Mon, 18 Sep 2017 16:53:16 +0200
Message-Id: <1505746398-13934-3-git-send-email-thierry.escande@collabora.com>
In-Reply-To: <1505746398-13934-1-git-send-email-thierry.escande@collabora.com>
References: <1505746398-13934-1-git-send-email-thierry.escande@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset = "utf-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch adds device information to the DMI table of the cros_ec_lpc
driver for Google Glimmer devices. Since Google BIOS does not enumerate
devices in the LPC bus, the cros_ec_lpc driver checks for system
compatibility and registers the cros_ec device itself.

Signed-off-by: Thierry Escande <thierry.escande@collabora.com>
---
 drivers/platform/chrome/cros_ec_lpc.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/platform/chrome/cros_ec_lpc.c b/drivers/platform/chrome/cros_ec_lpc.c
index ccdb270..8e76ca5 100644
--- a/drivers/platform/chrome/cros_ec_lpc.c
+++ b/drivers/platform/chrome/cros_ec_lpc.c
@@ -365,6 +365,13 @@ static struct dmi_system_id cros_ec_lpc_dmi_table[] __initdata = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "Peppy"),
 		},
 	},
+	{
+		/* x86-glimmer, the Lenovo Thinkpad Yoga 11e. */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "GOOGLE"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Glimmer"),
+		},
+	},
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(dmi, cros_ec_lpc_dmi_table);
-- 
2.7.4

