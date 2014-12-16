Return-Path: <roberta.dobrescu@gmail.com>
From: Roberta Dobrescu <roberta.dobrescu@gmail.com>
To: jic23@kernel.org,
	linux-iio@vger.kernel.org
Cc: octavian.purdila@intel.com,
	daniel.baluta@intel.com,
	lars@metafoo.de,
	Michael.Hennerich@analog.com,
	knaack.h@gmx.de,
	pmeerw@pmeerw.net,
	Roberta Dobrescu <roberta.dobrescu@gmail.com>
Subject: [PATCH] iio: trigger: Add a blank line after declarations
Date: Tue, 16 Dec 2014 11:16:06 +0200
Message-Id: <1418721366-5566-1-git-send-email-roberta.dobrescu@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

This patch fixes the following checkpatch.pl warning:
WARNING: Missing a blank line after declarations

Signed-off-by: Roberta Dobrescu <roberta.dobrescu@gmail.com>
---
 drivers/iio/trigger/iio-trig-sysfs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/trigger/iio-trig-sysfs.c b/drivers/iio/trigger/iio-trig-sysfs.c
index 254c7e9..3dfab2b 100644
--- a/drivers/iio/trigger/iio-trig-sysfs.c
+++ b/drivers/iio/trigger/iio-trig-sysfs.c
@@ -135,6 +135,7 @@ static int iio_sysfs_trigger_probe(int id)
 	struct iio_sysfs_trig *t;
 	int ret;
 	bool foundit = false;
+
 	mutex_lock(&iio_sysfs_trig_list_mut);
 	list_for_each_entry(t, &iio_sysfs_trig_list, l)
 		if (id == t->id) {
@@ -185,6 +186,7 @@ static int iio_sysfs_trigger_remove(int id)
 {
 	bool foundit = false;
 	struct iio_sysfs_trig *t;
+
 	mutex_lock(&iio_sysfs_trig_list_mut);
 	list_for_each_entry(t, &iio_sysfs_trig_list, l)
 		if (id == t->id) {
-- 
1.9.1
