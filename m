Return-Path: <SRS0=G/1T=DQ=melexis.com=cmo@kernel.org>
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
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Joe Perches <joe@perches.com>,
	Crt Mori <cmo@melexis.com>
Subject: [PATCH v10 1/3] lib: Add strongly typed 64bit int_sqrt
Date: Wed, 20 Dec 2017 15:20:01 +0100
Message-Id: <20171220142001.18161-1-cmo@melexis.com>
List-ID: <linux-iio@vger.kernel.org>

There is no option to perform 64bit integer sqrt on 32bit platform.
Added stronger typed int_sqrt64 enables the 64bit calculations to
be performed on 32bit platforms. Although int_sqrt() is a rough
approximation, the same algorithm is used in int_sqrt64() as good
enough on 32bit platform.

Signed-off-by: Crt Mori <cmo@melexis.com>
---
 include/linux/kernel.h |  9 +++++++++
 lib/int_sqrt.c         | 31 +++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 0ad4c3044cf9..e4a3dc64e650 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -460,6 +460,15 @@ extern int func_ptr_is_kernel_text(void *ptr);
 
 unsigned long int_sqrt(unsigned long);
 
+#if BITS_PER_LONG < 64
+u32 int_sqrt64(u64 x);
+#else
+static inline u32 int_sqrt64(u64 x)
+{
+	return (u32)int_sqrt(x);
+}
+#endif
+
 extern void bust_spinlocks(int yes);
 extern int oops_in_progress;		/* If set, an oops, panic(), BUG() or die() is in progress */
 extern int panic_timeout;
diff --git a/lib/int_sqrt.c b/lib/int_sqrt.c
index 1ef4cc344977..184da54677ec 100644
--- a/lib/int_sqrt.c
+++ b/lib/int_sqrt.c
@@ -7,6 +7,7 @@
 
 #include <linux/kernel.h>
 #include <linux/export.h>
+#include <linux/bitops.h>
 
 /**
  * int_sqrt - rough approximation to sqrt
@@ -36,3 +37,33 @@ unsigned long int_sqrt(unsigned long x)
 	return y;
 }
 EXPORT_SYMBOL(int_sqrt);
+
+#if BITS_PER_LONG < 64
+/**
+ * int_sqrt64 - strongly typed int_sqrt function when minimum 64 bit input
+ * is expected.
+ * @x: 64bit integer of which to calculate the sqrt
+ */
+u32 int_sqrt64(u64 x)
+{
+	u64 b, m, y = 0;
+
+	if (x <= 1)
+		return x;
+
+	m = 1ULL << (fls64(x) & ~1ULL);
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
+
+	return y;
+}
+EXPORT_SYMBOL(int_sqrt64);
+#endif
-- 
2.15.0
