Return-Path: <pmeerw@pmeerw.net>
From: Peter Meerwald <pmeerw@pmeerw.net>
To: gregkh@linuxfoundation.org
Cc: linux-iio@vger.kernel.org,
	jic23@cam.ac.uk,
	lars@metafoo.de,
	Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH] iio: call iio_device_unregister() in max517_remove()
Date: Wed,  2 May 2012 01:13:33 +0200
Message-Id: <1335914013-27747-1-git-send-email-pmeerw@pmeerw.net>
List-ID: <linux-iio@vger.kernel.org>

Reported-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
Acked-by: Jonathan Cameron <jic23@kernel.org>

---
 drivers/staging/iio/dac/max517.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/iio/dac/max517.c b/drivers/staging/iio/dac/max517.c
index 60aef18..672fa51 100644
--- a/drivers/staging/iio/dac/max517.c
+++ b/drivers/staging/iio/dac/max517.c
@@ -264,6 +264,7 @@ exit:
 
 static int max517_remove(struct i2c_client *client)
 {
+	iio_device_unregister(i2c_get_clientdata(client));
 	iio_device_free(i2c_get_clientdata(client));
 
 	return 0;
-- 
1.7.9.5
