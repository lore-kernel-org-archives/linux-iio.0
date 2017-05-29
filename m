Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:36881 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751062AbdE2PwK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 29 May 2017 11:52:10 -0400
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 03/38] coccinelle: Add an iio_no_owner semantic patch to drop driver_owner
Date: Mon, 29 May 2017 16:51:19 +0100
Message-Id: <20170529155154.22580-4-jic23@kernel.org>
In-Reply-To: <20170529155154.22580-1-jic23@kernel.org>
References: <20170529155154.22580-1-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

After some macro magic has made the core code assign this appropriately
the field isn't used.  This patch automates the removal of the relevant
assignments.

Will be removed again once all instances have been dealt with and the field
is finally removed.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
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
2.13.0

