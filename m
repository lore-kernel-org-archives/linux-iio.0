Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:43447 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754881Ab2FHGyW (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 8 Jun 2012 02:54:22 -0400
From: Peter Meerwald <pmeerw@pmeerw.net>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-iio@vger.kernel.org, Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH 2/2] iio: max517: mark probe() and remove() with __devinit and __devexit
Date: Fri,  8 Jun 2012 08:54:18 +0200
Message-Id: <1339138458-22608-2-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1339138458-22608-1-git-send-email-pmeerw@pmeerw.net>
References: <1339138458-22608-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
Acked-by: Roland Stigge <stigge@antcom.de>
Acked-by: Jonathan Cameron <jic23@kernel.org>

---
 drivers/iio/dac/max517.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/dac/max517.c b/drivers/iio/dac/max517.c
index 352abe2..c3d748c 100644
--- a/drivers/iio/dac/max517.c
+++ b/drivers/iio/dac/max517.c
@@ -156,7 +156,7 @@ static const struct iio_chan_spec max517_channels[] = {
 	MAX517_CHANNEL(1)
 };
 
-static int max517_probe(struct i2c_client *client,
+static int __devinit max517_probe(struct i2c_client *client,
 			const struct i2c_device_id *id)
 {
 	struct max517_data *data;
@@ -210,7 +210,7 @@ exit:
 	return err;
 }
 
-static int max517_remove(struct i2c_client *client)
+static int __devexit max517_remove(struct i2c_client *client)
 {
 	iio_device_unregister(i2c_get_clientdata(client));
 	iio_device_free(i2c_get_clientdata(client));
@@ -232,7 +232,7 @@ static struct i2c_driver max517_driver = {
 		.pm		= MAX517_PM_OPS,
 	},
 	.probe		= max517_probe,
-	.remove		= max517_remove,
+	.remove		=  __devexit_p(max517_remove),
 	.id_table	= max517_id,
 };
 module_i2c_driver(max517_driver);
-- 
1.7.9.5

