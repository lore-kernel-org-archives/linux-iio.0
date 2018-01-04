Return-Path: <SRS0=B/GZ=D7=gmail.com=aishpant@kernel.org>
Date: Thu, 4 Jan 2018 20:08:39 +0530
From: Aishwarya Pant <aishpant@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Julia Lawall <julia.lawall@lip6.fr>, Joe Perches <joe@perches.com>
Subject: [PATCH 5/5] iio: trigger: sysfs: use permisssion specific variants
 of DEVICE_ATTR
Message-ID: <068e06d7a0a8081bb87698670543f9df8fd13c82.1515076155.git.aishpant@gmail.com>
References: <cover.1515076155.git.aishpant@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1515076155.git.aishpant@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

This is a clean-up patch which replaces DEVICE_ATTR macro with the file
permission specific DEVICE_ATTR_{RO/WO/RW} macros for compaction and
readability. Done using coccinelle.

Signed-off-by: Aishwarya Pant <aishpant@gmail.com>
---
 drivers/iio/trigger/iio-trig-sysfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/trigger/iio-trig-sysfs.c b/drivers/iio/trigger/iio-trig-sysfs.c
index 3f0dc9a1a514..281ed6602f35 100644
--- a/drivers/iio/trigger/iio-trig-sysfs.c
+++ b/drivers/iio/trigger/iio-trig-sysfs.c
@@ -99,7 +99,7 @@ static void iio_sysfs_trigger_work(struct irq_work *work)
 	iio_trigger_poll(trig->trig);
 }
 
-static ssize_t iio_sysfs_trigger_poll(struct device *dev,
+static ssize_t trigger_now_store(struct device *dev,
 		struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct iio_trigger *trig = to_iio_trigger(dev);
@@ -110,7 +110,7 @@ static ssize_t iio_sysfs_trigger_poll(struct device *dev,
 	return count;
 }
 
-static DEVICE_ATTR(trigger_now, S_IWUSR, NULL, iio_sysfs_trigger_poll);
+static DEVICE_ATTR_WO(trigger_now);
 
 static struct attribute *iio_sysfs_trigger_attrs[] = {
 	&dev_attr_trigger_now.attr,
-- 
2.15.1
