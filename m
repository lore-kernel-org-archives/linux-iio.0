Received: from mail.noirlang.tr (mail.noirlang.tr [217.18.210.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F25546DFF6;
	Sun, 18 Oct 2026 10:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.18.210.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792319558; cv=none; b=NVNx6qdUqyQepfSzXObK2tNXWeF0hlj4r94ERHHuplcsWD/OeCJOzWZSBGtRP2z2lQGykhNYMd43/FKE62ems9hduKfvWxqC//AnemfQGZW+va+v32u3sOpc44ZhStS2ED3rXw+5Nw1sr0Jsa1YKTL5OFG9tde76XTVbl1sGs8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792319558; c=relaxed/simple;
	bh=EW81mHSnECRyDkttSlVIQyg2dRwHKSHOpABalQKpu+A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c/eWzwNHRQeGpoavvnf+nFfY6I7UfX5gaaZtF41nGNrZeDQkM5QLx6l1LVt15MIvWLep3OVm7HpVSoFz3GTUdaQ0VRO8k8Wh4sAhKdDHTW8bOxc23Ci6NCxQ6edJ0UFHilP5Hn96mQjQkXgXd0hNDyOXfsBvIe0f0eFmxJQWxTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=noirlang.tr; spf=pass smtp.mailfrom=noirlang.tr; dkim=pass (2048-bit key) header.d=noirlang.tr header.i=@noirlang.tr header.b=gdKzT3Lp; arc=none smtp.client-ip=217.18.210.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=noirlang.tr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=noirlang.tr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=noirlang.tr header.i=@noirlang.tr header.b="gdKzT3Lp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=noirlang.tr; s=mail;
	t=1792319166; bh=EW81mHSnECRyDkttSlVIQyg2dRwHKSHOpABalQKpu+A=;
	h=From:To:Cc:Subject:Date:From;
	b=gdKzT3Lp8d9B7JiNa61Ep5EbsMkh6l7wKba7hgmLPgxS5bYLCeeYxrAumKTNjeKsT
	 AdbQk8om6pEYpRwfWdsNh6jzx+j+S2mGxyn2O8OtKtzwFu/6G6dJlg9q0m4DJ5r+D8
	 57ax2L0q4ee9TKxDRi2TKiBr06kzQJyG5ukZtsTJVYxQZFobx3OF4fXIA3xabpNW3L
	 yqmEXvSZZE4GzdqkyhUs4SfFVA1+bnlpl9j8MbNPWwBxjXWbxqnNkuUZAJtTBUdwT2
	 Dq/RGVkY+QGw6HPwYrh0N4+IZJGcYv7CiC6O7o0dM4iqgaHGImASQoZtfEPAiGDcir
	 igPdnfncqtNdw==
From: Melih Emik <melihemik@noirlang.tr>
To: jic23@kernel.org,
	gregkh@linuxfoundation.org,
	nuno.sa@analog.com,
	Michael.Hennerich@analog.com
Cc: dlechner@baylibre.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux@analog.com
Subject: [PATCH] staging: iio: frequency: ad9832: use guard(mutex)
Date: Sun, 18 Oct 2026 13:26:04 +0300
Message-ID: <20261018102604.73380-1-melihemik@noirlang.tr>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In ad9832_write(), manual mutex handling via mutex_lock() and
mutex_unlock() necessitates error-exit trampolines (goto error_ret),
intermediate variables, and deferred returns. This pattern is prone
to unlock-omission bugs during refactoring and clutters the control
flow.

Modernize the locking by using guard(mutex) from <linux/cleanup.h>.
Scope-based resource management automatically releases the lock upon
exiting the lexical scope, which enables immediate error propagation
at call sites, removes the error_ret label, and simplifies the control
flow across all switch cases.

Tested:
- Compiled with W=1 on x86_64 with zero warnings.
- Verified with lockdep and debug mutexes enabled
  (CONFIG_PROVE_LOCKING=y, CONFIG_DEBUG_MUTEXES=y).
- Boot-tested full bzImage in QEMU with initcall_debug, confirming
  successful driver initialization (ad9832_driver_init returned 0)
  and zero lockdep warnings.
- Disassembly inspected via objdump to ensure mutex_unlock on all
  exit paths.
- Verified with scripts/checkpatch.pl (0 errors, 0 warnings).

Signed-off-by: Melih Emik <melihemik@noirlang.tr>
---
 drivers/staging/iio/frequency/ad9832.c | 39 ++++++++++++++++++--------
 1 file changed, 27 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/iio/frequency/ad9832.c b/drivers/staging/iio/frequency/ad9832.c
index a78249812b26..3ae5defec615 100644
--- a/drivers/staging/iio/frequency/ad9832.c
+++ b/drivers/staging/iio/frequency/ad9832.c
@@ -8,6 +8,7 @@
 #include <linux/array_size.h>
 #include <linux/bitfield.h>
 #include <linux/bitops.h>
+#include <linux/cleanup.h>
 #include <linux/clk.h>
 #include <linux/dev_printk.h>
 #include <linux/err.h>
@@ -182,19 +183,26 @@ static ssize_t ad9832_write(struct device *dev, struct device_attribute *attr,
 
 	ret = kstrtoul(buf, 10, &val);
 	if (ret)
-		goto error_ret;
+		return ret;
+
+	guard(mutex)(&st->lock);
 
-	mutex_lock(&st->lock);
 	switch ((u32)this_attr->address) {
 	case AD9832_FREQ0HM:
 	case AD9832_FREQ1HM:
 		ret = ad9832_write_frequency(st, this_attr->address, val);
+		if (ret)
+			return ret;
+
 		break;
 	case AD9832_PHASE0H:
 	case AD9832_PHASE1H:
 	case AD9832_PHASE2H:
 	case AD9832_PHASE3H:
 		ret = ad9832_write_phase(st, this_attr->address, val);
+		if (ret)
+			return ret;
+
 		break;
 	case AD9832_PINCTRL_EN:
 		st->ctrl_ss &= ~AD9832_SELSRC;
@@ -203,24 +211,27 @@ static ssize_t ad9832_write(struct device *dev, struct device_attribute *attr,
 		st->data = cpu_to_be16(FIELD_PREP(AD9832_CMD_MSK, AD9832_CMD_SYNCSELSRC) |
 						  st->ctrl_ss);
 		ret = spi_sync(st->spi, &st->msg);
+		if (ret)
+			return ret;
+
 		break;
 	case AD9832_FREQ_SYM:
 		if (val == 1 || val == 0) {
 			st->ctrl_fp &= ~AD9832_FREQ;
 			st->ctrl_fp |= FIELD_PREP(AD9832_FREQ, val ? 1 : 0);
 		} else {
-			ret = -EINVAL;
-			break;
+			return -EINVAL;
 		}
 		st->data = cpu_to_be16(FIELD_PREP(AD9832_CMD_MSK, AD9832_CMD_FPSELECT) |
 						  st->ctrl_fp);
 		ret = spi_sync(st->spi, &st->msg);
+		if (ret)
+			return ret;
+
 		break;
 	case AD9832_PHASE_SYM:
-		if (val > 3) {
-			ret = -EINVAL;
-			break;
-		}
+		if (val > 3)
+			return -EINVAL;
 
 		st->ctrl_fp &= ~AD9832_PHASE_MASK;
 		st->ctrl_fp |= FIELD_PREP(AD9832_PHASE_MASK, val);
@@ -228,6 +239,9 @@ static ssize_t ad9832_write(struct device *dev, struct device_attribute *attr,
 		st->data = cpu_to_be16(FIELD_PREP(AD9832_CMD_MSK, AD9832_CMD_FPSELECT) |
 						  st->ctrl_fp);
 		ret = spi_sync(st->spi, &st->msg);
+		if (ret)
+			return ret;
+
 		break;
 	case AD9832_OUTPUT_EN:
 		if (val)
@@ -238,14 +252,15 @@ static ssize_t ad9832_write(struct device *dev, struct device_attribute *attr,
 		st->data = cpu_to_be16(FIELD_PREP(AD9832_CMD_MSK, AD9832_CMD_SLEEPRESCLR) |
 						  st->ctrl_src);
 		ret = spi_sync(st->spi, &st->msg);
+		if (ret)
+			return ret;
+
 		break;
 	default:
-		ret = -ENODEV;
+		return -ENODEV;
 	}
-	mutex_unlock(&st->lock);
 
-error_ret:
-	return ret ? ret : len;
+	return len;
 }
 
 /*
-- 
2.56.0


