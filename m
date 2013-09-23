Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from eu1sys200aog111.obsmtp.com ([207.126.144.131]:58125 "EHLO
	eu1sys200aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752630Ab3IWKwn (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 23 Sep 2013 06:52:43 -0400
From: Denis CIOCCA <denis.ciocca@st.com>
To: jic23@kernel.org
Cc: hennerich@blackfin.uclinux.org, linux-iio@vger.kernel.org,
	Denis Ciocca <denis.ciocca@st.com>
Subject: [PATCH] iio:trigger: fix sysfs name on list mutex
Date: Mon, 23 Sep 2013 12:49:10 +0200
Message-Id: <1379933351-27498-1-git-send-email-denis.ciocca@st.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Denis Ciocca <denis.ciocca@st.com>
---
 drivers/iio/trigger/iio-trig-sysfs.c |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/trigger/iio-trig-sysfs.c b/drivers/iio/trigger/iio-trig-sysfs.c
index effcd0a..15e3b85 100644
--- a/drivers/iio/trigger/iio-trig-sysfs.c
+++ b/drivers/iio/trigger/iio-trig-sysfs.c
@@ -23,7 +23,7 @@ struct iio_sysfs_trig {
 };
 
 static LIST_HEAD(iio_sysfs_trig_list);
-static DEFINE_MUTEX(iio_syfs_trig_list_mut);
+static DEFINE_MUTEX(iio_sysfs_trig_list_mut);
 
 static int iio_sysfs_trigger_probe(int id);
 static ssize_t iio_sysfs_trig_add(struct device *dev,
@@ -135,7 +135,7 @@ static int iio_sysfs_trigger_probe(int id)
 	struct iio_sysfs_trig *t;
 	int ret;
 	bool foundit = false;
-	mutex_lock(&iio_syfs_trig_list_mut);
+	mutex_lock(&iio_sysfs_trig_list_mut);
 	list_for_each_entry(t, &iio_sysfs_trig_list, l)
 		if (id == t->id) {
 			foundit = true;
@@ -169,7 +169,7 @@ static int iio_sysfs_trigger_probe(int id)
 		goto out2;
 	list_add(&t->l, &iio_sysfs_trig_list);
 	__module_get(THIS_MODULE);
-	mutex_unlock(&iio_syfs_trig_list_mut);
+	mutex_unlock(&iio_sysfs_trig_list_mut);
 	return 0;
 
 out2:
@@ -177,7 +177,7 @@ out2:
 free_t:
 	kfree(t);
 out1:
-	mutex_unlock(&iio_syfs_trig_list_mut);
+	mutex_unlock(&iio_sysfs_trig_list_mut);
 	return ret;
 }
 
@@ -185,14 +185,14 @@ static int iio_sysfs_trigger_remove(int id)
 {
 	bool foundit = false;
 	struct iio_sysfs_trig *t;
-	mutex_lock(&iio_syfs_trig_list_mut);
+	mutex_lock(&iio_sysfs_trig_list_mut);
 	list_for_each_entry(t, &iio_sysfs_trig_list, l)
 		if (id == t->id) {
 			foundit = true;
 			break;
 		}
 	if (!foundit) {
-		mutex_unlock(&iio_syfs_trig_list_mut);
+		mutex_unlock(&iio_sysfs_trig_list_mut);
 		return -EINVAL;
 	}
 
@@ -202,7 +202,7 @@ static int iio_sysfs_trigger_remove(int id)
 	list_del(&t->l);
 	kfree(t);
 	module_put(THIS_MODULE);
-	mutex_unlock(&iio_syfs_trig_list_mut);
+	mutex_unlock(&iio_sysfs_trig_list_mut);
 	return 0;
 }
 
-- 
1.7.9.5

