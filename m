Return-Path: <SRS0=UbNB=62=huawei.com=Jonathan.Cameron@kernel.org>
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: linux-iio@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 04/45] coccinelle: Add an iio_no_owner semantic patch to drop driver_owner
Date: Sun, 23 Jul 2017 17:25:46 +0100
Message-Id: <20170723162627.22534-5-Jonathan.Cameron@huawei.com>
In-Reply-To: <20170723162627.22534-1-Jonathan.Cameron@huawei.com>
References: <20170723162627.22534-1-Jonathan.Cameron@huawei.com>
List-ID: <linux-iio@vger.kernel.org>

From: Jonathan Cameron <jic23@kernel.org>

After some macro magic has made the core code assign this appropriately
the field isn't used.  This patch automates the removal of the relevant
assignments.

Will be removed again once all instances have been dealt with and the field
is finally removed.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 scripts/coccinelle/api/iio_no_owner.cocci | 94 +++++++++++++++++++++++++++++++
 1 file changed, 94 insertions(+)

diff --git a/scripts/coccinelle/api/iio_no_owner.cocci b/scripts/coccinelle/api/iio_no_owner.cocci
new file mode 100644
index 000000000000..964854f1119a
--- /dev/null
+++ b/scripts/coccinelle/api/iio_no_owner.cocci
@@ -0,0 +1,94 @@
+/// Remove .owner field if calls are used which set it automatically
+///
+// Confidence: High
+// Copyright : (C) 2017 Jonathan Cmeron. GPLv2.
+// Loosely based on platform_no_drv_owner.smpl
+// Copyright: (C) 2014 Wolfram Sang. GPL v2.
+
+virtual patch
+virtual context
+virtual org
+virtual report
+
+@match1@
+identifier I;
+expression E;
+@@
+static struct iio_info I = {
+       .driver_module  = E,
+};
+
+@fix1 depends on match1 && patch && !context && !org && !report@
+identifier match1.I;
+@@
+static struct iio_info I = {
+-       .driver_module  = THIS_MODULE,
+};
+
+@match2@
+identifier O;
+expression E;
+@@
+static struct iio_trigger_ops O = {
+       .owner  = E,
+};
+
+@fix2 depends on match2 && patch && !context && !org && !report@
+identifier match2.O;
+@@
+static struct iio_trigger_ops O = {
+-       .owner  = THIS_MODULE,
+};
+
+// ----------------------------------------------------------------------------
+
+@fix1_context depends on match1 && !patch && (context || org || report)@
+identifier match1.I;
+position j0;
+@@
+
+	static struct iio_info I = {
+*       	.driver_module@j0  = THIS_MODULE,
+	};
+
+@fix2_context depends on match2 && !patch && (context || org || report)@
+identifier match2.O;
+position j0;
+@@
+
+	static struct iio_trigger_ops O = {
+*       	.owner@j0  = THIS_MODULE,
+	};
+
+
+// ----------------------------------------------------------------------------
+
+@script:python fix1_org depends on org@
+j0 << fix1_context.j0;
+@@
+
+msg = "Setting .driver_module here is deprecated and soon to be removed."
+coccilib.org.print_todo(j0[0], msg)
+
+@script:python fix2_org depends on org@
+j0 << fix2_context.j0;
+@@
+
+msg = "Setting .owner here is deprecated and soon to be removed."
+coccilib.org.print_todo(j0[0], msg)
+
+// ----------------------------------------------------------------------------
+
+@script:python fix1_report depends on report@
+j0 << fix1_context.j0;
+@@
+
+msg = "Setting .driver_module here is deprecated and soon to be removed."
+coccilib.report.print_report(j0[0], msg)
+
+@script:python fix2_report depends on report@
+j0 << fix2_context.j0;
+@@
+
+msg = "Setting .owner here is deprecated and soon to be removed."
+coccilib.report.print_report(j0[0], msg)
-- 
2.13.3
