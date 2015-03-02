Return-Path: <harald@ccbib.org>
From: Harald Geyer <harald@ccbib.org>
To: Jonathan Cameron <jic23@kernel.org>,
	John Stultz <john.stultz@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: linux-iio@vger.kernel.org,
	Richard Weinberger <richard@nod.at>,
	Harald Geyer <harald@ccbib.org>
Subject: [PATCH 1/3] timekeeping: Provide new API to get the current time resolution
Date: Mon,  2 Mar 2015 20:56:04 +0000
Message-Id: <1425329766-14703-2-git-send-email-harald@ccbib.org>
In-Reply-To: <1425329766-14703-1-git-send-email-harald@ccbib.org>
References: <1425329766-14703-1-git-send-email-harald@ccbib.org>
List-ID: <linux-iio@vger.kernel.org>

This has been tested on i386, sunxi and mxs.

Signed-off-by: Harald Geyer <harald@ccbib.org>
---
 include/linux/timekeeping.h |    1 +
 kernel/time/timekeeping.c   |   18 ++++++++++++++++++
 2 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/include/linux/timekeeping.h b/include/linux/timekeeping.h
index 3eaae47..983b61e 100644
--- a/include/linux/timekeeping.h
+++ b/include/linux/timekeeping.h
@@ -163,6 +163,7 @@ extern ktime_t ktime_get(void);
 extern ktime_t ktime_get_with_offset(enum tk_offsets offs);
 extern ktime_t ktime_mono_to_any(ktime_t tmono, enum tk_offsets offs);
 extern ktime_t ktime_get_raw(void);
+extern u32 ktime_get_resolution_ns(void);
 
 /**
  * ktime_get_real - get the real (wall-) time in ktime_t format
diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 91db941..b823eba 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -586,6 +586,24 @@ ktime_t ktime_get(void)
 }
 EXPORT_SYMBOL_GPL(ktime_get);
 
+u32 ktime_get_resolution_ns(void)
+{
+	struct timekeeper *tk = &tk_core.timekeeper;
+	unsigned int seq;
+	u32 nsecs;
+
+	WARN_ON(timekeeping_suspended);
+
+	do {
+		seq = read_seqcount_begin(&tk_core.seq);
+		nsecs = tk->tkr.mult >> tk->tkr.shift;
+	} while (read_seqcount_retry(&tk_core.seq, seq));
+
+	return nsecs;
+}
+
+EXPORT_SYMBOL_GPL(ktime_get_resolution_ns);
+
 static ktime_t *offsets[TK_OFFS_MAX] = {
 	[TK_OFFS_REAL]	= &tk_core.timekeeper.offs_real,
 	[TK_OFFS_BOOT]	= &tk_core.timekeeper.offs_boot,
-- 
1.7.2.5
