Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:42683 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751821AbdLDPcY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 4 Dec 2017 10:32:24 -0500
Received: by mail-wm0-f66.google.com with SMTP id l141so6548182wmg.1
        for <linux-iio@vger.kernel.org>; Mon, 04 Dec 2017 07:32:24 -0800 (PST)
From: Crt Mori <cmo@melexis.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Rusty Russell <rusty@rustcorp.com.au>,
        Ian Abbott <abbotti@mev.co.uk>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Niklas Soderlund <niklas.soderlund+renesas@ragnatech.se>,
        Thomas Gleixner <tglx@linutronix.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Crt Mori <cmo@melexis.com>
Subject: [PATCH v2 3/3] lib: Add strongly typed 64bit int_sqrt
Date: Mon,  4 Dec 2017 16:32:12 +0100
Message-Id: <20171204153212.26270-1-cmo@melexis.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

There is no option to perform 64bit integer sqrt on 32bit platform.
Added stronger typed int_sqrt64 enables the 64bit calculations to
be performed on 32bit platforms. Although int_sqrt() is a rough
approximation, the same algorithm is used in int_sqrt64() as good
enough on 32bit platform.

Signed-off-by: Crt Mori <cmo@melexis.com>
---
 include/linux/kernel.h |  1 +
 lib/int_sqrt.c         | 27 +++++++++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 0ad4c3044cf9..09f53063f2c9 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -459,6 +459,7 @@ extern int kernel_text_address(unsigned long addr);
 extern int func_ptr_is_kernel_text(void *ptr);
 
 unsigned long int_sqrt(unsigned long);
+u64 int_sqrt64(u64 x);
 
 extern void bust_spinlocks(int yes);
 extern int oops_in_progress;		/* If set, an oops, panic(), BUG() or die() is in progress */
diff --git a/lib/int_sqrt.c b/lib/int_sqrt.c
index 1ef4cc344977..3a106ffb1069 100644
--- a/lib/int_sqrt.c
+++ b/lib/int_sqrt.c
@@ -36,3 +36,30 @@ unsigned long int_sqrt(unsigned long x)
 	return y;
 }
 EXPORT_SYMBOL(int_sqrt);
+
+/**
+ * int_sqrt64 - strongly typed int_sqrt function
+ * @x: 64bit integer of which to calculate the sqrt
+ */
+u64 int_sqrt64(u64 x)
+{
+	u64 b, m, y = 0;
+
+	if (x <= 1)
+		return x;
+
+	m = 1ULL << (64 - 2);
+	while (m != 0) {
+		b = y + m;
+		y >>= 1;
+
+		if (x >= b) {
+			x -= b;
+			y += m;
+		}
+		m >>= 2;
+	}
+	return y;
+}
+EXPORT_SYMBOL(int_sqrt64);
+
-- 
2.15.0

