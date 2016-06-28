Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:64814 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752091AbcF1OWe (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 28 Jun 2016 10:22:34 -0400
From: Crestez Dan Leonard <leonard.crestez@intel.com>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Crestez Dan Leonard <leonard.crestez@intel.com>
Subject: [PATCH] iio: Fix missing unlock on duplicate trigger
Date: Tue, 28 Jun 2016 17:12:01 +0300
Message-Id: <55aace217d3212cc2662d5dd010c7e5c8c0e357d.1467123107.git.leonard.crestez@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Since duplicate trigger names are supposed to cause errors at probe time
anyway this issue is unlikely to affect anyone.

Fixes commit 2e2b6a13f5f5119c36551c1ab99b85e0ad1a2105:
iio: Refuse to register triggers with duplicate names

Signed-off-by: Crestez Dan Leonard <leonard.crestez@intel.com>
---
 drivers/iio/industrialio-trigger.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
index 0f03523..68466be 100644
--- a/drivers/iio/industrialio-trigger.c
+++ b/drivers/iio/industrialio-trigger.c
@@ -89,6 +89,7 @@ int iio_trigger_register(struct iio_trigger *trig_info)
 	/* Add to list of available triggers held by the IIO core */
 	mutex_lock(&iio_trigger_list_lock);
 	if (__iio_trigger_find_by_name(trig_info->name)) {
+		mutex_unlock(&iio_trigger_list_lock);
 		pr_err("Duplicate trigger name '%s'\n", trig_info->name);
 		ret = -EEXIST;
 		goto error_device_del;
-- 
2.7.4

