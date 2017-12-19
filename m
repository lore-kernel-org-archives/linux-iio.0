Return-Path: <SRS0=aVgU=DP=melexis.com=cmo@kernel.org>
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
Subject: [PATCH v8 1/3] lib: Add strongly typed 64bit int_sqrt
Date: Tue, 19 Dec 2017 17:05:54 +0100
Message-Id: <20171219160554.30729-1-cmo@melexis.com>
List-ID: <linux-iio@vger.kernel.org>

There is no option to perform 64bit integer sqrt on 32bit platform.
Added stronger typed int_sqrt64 enables the 64bit calculations to
be performed on 32bit platforms. Although int_sqrt() is a rough
approximation, the same algorithm is used in int_sqrt64() as good
enough on 32bit platform.

Signed-off-by: Crt Mori <cmo@melexis.com>
---
 include/linux/kernel.h |  6 ++++++
 lib/int_sqrt.c         | 31 +++++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 0ad4c3044cf9..f3bebd3a9213 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -459,6 +459,12 @@ extern int kernel_text_address(unsigned long addr);
 extern int func_ptr_is_kernel_text(void *ptr);
 
 unsigned long int_sqrt(unsigned long);
+#if BITS_PER_LONG != 64
+#define int_sqrt64 _int_sqrt64
+u32 _int_sqrt64(u64 x);
+#else
+#define int_sqrt64 int_sqrt
+#endif
 
 extern void bust_spinlocks(int yes);
 extern int oops_in_progress;		/* If set, an oops, panic(), BUG() or die() is in progress */
diff --git a/lib/int_sqrt.c b/lib/int_sqrt.c
index 1ef4cc344977..41338f1194b2 100644
--- a/lib/int_sqrt.c
+++ b/lib/int_sqrt.c
@@ -36,3 +36,34 @@ unsigned long int_sqrt(unsigned long x)
 	return y;
 }
 EXPORT_SYMBOL(int_sqrt);
+
+#if BITS_PER_LONG != 64
+/**
+ * int_sqrt64 - strongly typed int_sqrt function when minimum 64 bit input
+ * is expected.
+ * @x: 64bit integer of which to calculate the sqrt
+ */
+u32 _int_sqrt64(u64 x)
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
+
+	return y;
+}
+EXPORT_SYMBOL(_int_sqrt64);
+#endif
+
-- 
2.15.0
