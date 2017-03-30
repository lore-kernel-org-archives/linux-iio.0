Return-Path: <SRS0=FWgg=3H=gmail.com=arushisinghal19971997@kernel.org>
Date: Thu, 30 Mar 2017 18:11:22 +0530
From: Arushi Singhal <arushisinghal19971997@gmail.com>
To: jic23@kernel.org
Cc: Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	outreachy-kernel@googlegroups.com
Subject: [PATCH] drivers: iio: replace comma with a semicolon
Message-ID: <20170330124121.GA29095@arushi-HP-Pavilion-Notebook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-iio@vger.kernel.org>

Replace a comma between expression statements by a semicolon. This
changes the semantics of the code, but given the current indentation
appears to be what is intended.
A simplified version of the Coccinelle semantic patch that performs this
transformation is as follows:

// <smpl>
@r@
expression e1,e2;
@@

 e1
-,
+;
 e2;
// </smpl>

Signed-off-by: Arushi Singhal <arushisinghal19971997@gmail.com>
---
 drivers/iio/chemical/ams-iaq-core.c | 2 +-
 drivers/iio/chemical/vz89x.c        | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/chemical/ams-iaq-core.c b/drivers/iio/chemical/ams-iaq-core.c
index 41a8e6f2e31d..c948ad2ee9ad 100644
--- a/drivers/iio/chemical/ams-iaq-core.c
+++ b/drivers/iio/chemical/ams-iaq-core.c
@@ -163,7 +163,7 @@ static int ams_iaqcore_probe(struct i2c_client *client,
 	mutex_init(&data->lock);
 
 	indio_dev->dev.parent = &client->dev;
-	indio_dev->info = &ams_iaqcore_info,
+	indio_dev->info = &ams_iaqcore_info;
 	indio_dev->name = dev_name(&client->dev);
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
diff --git a/drivers/iio/chemical/vz89x.c b/drivers/iio/chemical/vz89x.c
index 8e0e4415c161..f75eea6822f2 100644
--- a/drivers/iio/chemical/vz89x.c
+++ b/drivers/iio/chemical/vz89x.c
@@ -393,7 +393,7 @@ static int vz89x_probe(struct i2c_client *client,
 	mutex_init(&data->lock);
 
 	indio_dev->dev.parent = &client->dev;
-	indio_dev->info = &vz89x_info,
+	indio_dev->info = &vz89x_info;
 	indio_dev->name = dev_name(&client->dev);
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
-- 
2.11.0
