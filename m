Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:36741 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751796AbdGEVOo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 5 Jul 2017 17:14:44 -0400
From: Jack Andersen <jackoalan@gmail.com>
To: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Jack Andersen <jackoalan@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v5 3/3] mfd: dln2: Send restart command if HW init fails
Date: Wed,  5 Jul 2017 11:12:48 -1000
Message-Id: <1499289168-14392-3-git-send-email-jackoalan@gmail.com>
In-Reply-To: <1499289168-14392-1-git-send-email-jackoalan@gmail.com>
References: <1499289168-14392-1-git-send-email-jackoalan@gmail.com>
In-Reply-To: <b5ede0cc2cb36695b86edf44c0dddbc4736a6420>
References: <b5ede0cc2cb36695b86edf44c0dddbc4736a6420>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

There's an issue with reinitializing DLN2 hardware if ADC channel event
configurations aren't reset before suspending the driver. A physical reconnect
of the device solves the problem, but restarting the machine without a power
cycle leaves the device state inconsistent.

This patch transmits a restart command in the event of a failed init.
To the kernel's perspective, this is the rough equivalent of a disconnect and
reconnect, so another probe occurs shortly afterwards.

Signed-off-by: Jack Andersen <jackoalan@gmail.com>
---
 drivers/mfd/dln2.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/dln2.c b/drivers/mfd/dln2.c
index a22ab8c..1eb0056 100644
--- a/drivers/mfd/dln2.c
+++ b/drivers/mfd/dln2.c
@@ -40,6 +40,7 @@ struct dln2_response {
 #define DLN2_GENERIC_CMD(cmd)		DLN2_CMD(cmd, DLN2_GENERIC_MODULE_ID)
 #define CMD_GET_DEVICE_VER		DLN2_GENERIC_CMD(0x30)
 #define CMD_GET_DEVICE_SN		DLN2_GENERIC_CMD(0x31)
+#define CMD_RESTART			DLN2_GENERIC_CMD(0x43)
 
 #define DLN2_HW_ID			0x200
 #define DLN2_USB_TIMEOUT		200	/* in ms */
@@ -531,6 +532,12 @@ int dln2_transfer(struct platform_device *pdev, u16 cmd,
 }
 EXPORT_SYMBOL(dln2_transfer);
 
+static int dln2_restart(struct dln2_dev *dln2)
+{
+	return _dln2_transfer(dln2, DLN2_HANDLE_CTRL, CMD_RESTART,
+			      NULL, 0, NULL, NULL);
+}
+
 static int dln2_check_hw(struct dln2_dev *dln2)
 {
 	int ret;
@@ -782,7 +789,9 @@ static int dln2_probe(struct usb_interface *interface,
 
 	ret = dln2_hw_init(dln2);
 	if (ret < 0) {
-		dev_err(dev, "failed to initialize hardware\n");
+		dev_err(dev,
+			"failed to initialize hardware; attempting restart\n");
+		dln2_restart(dln2);
 		goto out_stop_rx;
 	}
 
-- 
1.9.1

