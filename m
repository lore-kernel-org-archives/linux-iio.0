Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794329242;
	b=ucT1Jw07TobRVGKyuNDHzVnUJfiz4AgYbHsJ2su4DSbkhjaOVCN8m3+laJR2Qq2ysaSr
	 LewCi293ONNbQXovCshKHo0YXbLPLD2TfLX9VEQ0Kbfrjj/o2IKic0AiQ1EF5ADJb/ek6
	 cxScp5+Y+fSK06XExCQb1fMB3AijuHwOriKQOwUrDFrKCg0iY6qsAJbtom9l72YuOJZ0L
	 XLNDZBG6ZDrecWNy3zSsILyPdoG36JBXVqN0EI7zw5mUHreloj1xP7FTuu/BEFHfpxddP
	 yA7FJQuRIQfmuwu6vPVtr0b1gab7crylvN/FCCkKR9pl7K9Xb4bkpeK+v9GdUd+5Xkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794329242;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=UDRMQaN490Igz0plCrZ/DYl/p/Z4M+tLu42qQn9xGzM=;
	b=ue0x3U+l1ScfAT8mJgZZ1Q9tehbC4XFXW6CPFjDe39LOlxJt3NZjPkvFj+sW+iBkvln4
	 xQSgqhTTjnX1VuI5sHcNs/GiT94rypQazu6AkGP2R3qp2tO2/y/I8HWGSscWmbZVCCLQT
	 clPxDAz8LyI158qptq6EBVLmHfvTjkU5pgwIgqoafcFzIELTyJ5Tclq38J+0znlYQbLF5
	 GUSSYeXsH6gfC/orWTNt6ljy8Q5J0xMvP4wuJjwwsgFK35xb4LDcoOXdJnKoikRrv0Rle
	 DLkwePk+uQYfymqepbJ6xpnSelPNjBvtgd7u4AUXQ1XLhocAN9XdeJaDwHkWeoyvzuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tfEmc021;
	arc=none smtp.remote-ip=74.125.82.41
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A0C606A33E
	for <linux-iio@vger.kernel.org>; Tue, 10 Nov 2026 16:47:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B2A0C606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tfEmc021
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-170135e43c7so3484816c88.0
        for <linux-iio@vger.kernel.org>; Tue, 10 Nov 2026 08:47:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794329241; x=1794934041; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=UDRMQaN490Igz0plCrZ/DYl/p/Z4M+tLu42qQn9xGzM=;
        b=tfEmc021XtcNNXLoPLHhYdRbzlobH//iHlHvISNGq1uRSVvn/X1x1g0wCqT+UpI6NW
         hgyZnAdxvRNXMsPI+eSsyP7sZizkBYaNoN/fOXY6saDVpuH5WAtwOEGJQxasBLxl5ILG
         Q82nZ4TMhYtqQE9fAXmly6saMGDTDhCgWAUJ3L8fHeTDMPYazUleq/vAA8afTpmGzyrL
         1n4TiRVzmz4aJpck+nBDF27g3UafaOgrQuMxqup7d9cw47EYD1KIq/gLx+8ZOnPe+w3h
         06EqDi+WKIXzHNEbgbFIBgfc8es/cwfNP2fJYp115bFqU+lAKupfSZaUoGuArSDH3mtK
         zBAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794329241; x=1794934041;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UDRMQaN490Igz0plCrZ/DYl/p/Z4M+tLu42qQn9xGzM=;
        b=E0K8NF4Te+u4peV0Cg0aCjX0jMpGDLeUHDY7KqS5MdjIyvCeTQC9GIUPMY3IPLzIxq
         IWm1G2yTYNQ243bwCVLxO5kRxLCI76DyFt/sasNCyNeNL8wO8r+dCRIYIo+uNEz6kVbG
         erCQLWNLjMN14RRxU+xEbKo7V5bN12LZd9l4YwpBF4lRv/j49J48HED4gmLFQjzk+jZr
         AaBf4YoeGK0lQY+W/fWta4+5G/CU0tZlxfOuygYtgKO8nBpLPjMdIUMB76aFN3O8zmV5
         LyKHXLTHeElIiU2iAMgSq6sfyRD3unzVFVJHO0bn6EsY4u6/B0RKGXdX760sV0rhvJNW
         K4uA==
X-Forwarded-Encrypted: i=1; AL+hErEx5yRDZUbfb6mg4jeLgi//OSxwfffIclXsM3SZjlHratVskpgIkfdP7qk6mSM5/ArZu+BqjLCtwxk=@vger.kernel.org
X-Gm-Message-State: APuU4Z+cGqkYUaWWIF4RWQFVGDSY0cMALWsyUCrUN6Psrg+NqXD9wVbE
	xsVcWJYeJE0Dh5iCYXt7kT1A+KHIfeyvi35j6z0qywshKnphP2PAOwAA
X-Gm-Gg: AYBFou1lkp9W058Nugns0egC3hoFJIjzUvTLBuIltPHFgxCAhqxWTaeKf05HPknkZC4
	+L856ZPr+N9UQgORrhlcRrXFzPoxZLaReNiy/ai7cCxcb61dBSwgAtYAheclKfWZd94hG91HEnK
	yh0Hk0qmloJTotWA1PLbAg1Tk73V3z7gl2wOFYYibGVjhyslwDhq+1x9QSU+LQ8YprStBmEbjzw
	itEj9g+uqmlTtq2k+0+EICquor34iViXt+OJhHHmYyVfB8PviN96ONPXABMk9du5opTeVusbhui
	yfj640zok/rkqnTUIsFk5GbrJrfCb2Busr2HoZRbPZRSb8NysH2i76oRq4vv+5oeyaoeHJa9MKD
	yAbaEZzT5jmVJmVnLyMoy9ca67JkSQWY/EIcb3CphDE69+gFC34CYU10UMu51T+U7/CLCu/yxu9
	SM9CjCjsLuXO0bHqLpRSAS4GHS5JIP/IBmCi4oly+KWKOnsv+3zc/2Lr5FUnQ7KNXxcm9X8UpFN
	19mZ9kBgMQHfhhwGiGioRN/0mcxPnU+hYdjp9Uy1nqVmpkqqOhVRd+eTHTgfLjZgaJhKkXqWK9f
	JLUykTfFmCFmIu3rO7WObRCYASyvGwc/cSQhoRs4h3ztz2V4
X-Received: by 2002:a05:701b:281c:b0:1b2:5f31:21c9 with SMTP id a92af1059eb24-1b3b5e651e9mr3703067c88.6.1794329239066;
        Tue, 10 Nov 2026 08:47:19 -0800 (PST)
Received: from NithishVelan.localdomain ([27.60.174.111])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b54431sm7882587c88.17.2026.11.10.08.47.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 08:47:18 -0800 (PST)
From: Nithishvelan M <mnithishvelan@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Nuno Sa <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Nithishvelan M <mnithishvelan@gmail.com>
Subject: [PATCH] staging: iio: frequency: ad9832: use guard(mutex)
Date: Tue, 10 Nov 2026 16:47:11 +0000
Message-ID: <20261110164711.552-1-mnithishvelan@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use guard(mutex) to automatically manage the state lock in
ad9832_write(). This simplifies error handling by allowing direct
returns from each switch case and error branch, eliminating the
manual mutex_unlock() calls and the goto error label.

Signed-off-by: Nithishvelan M <mnithishvelan@gmail.com>
---
 drivers/staging/iio/frequency/ad9832.c | 47 +++++++++++++++++---------
 1 file changed, 31 insertions(+), 16 deletions(-)

diff --git a/drivers/staging/iio/frequency/ad9832.c b/drivers/staging/iio/frequency/ad9832.c
index 35f823f24..227dcd739 100644
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
@@ -188,52 +189,65 @@ static ssize_t ad9832_write(struct device *dev, struct device_attribute *attr,
 
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
 		st->ctrl_ss |= FIELD_PREP(AD9832_SELSRC, val ? 0 : 1);
 
 		st->data = cpu_to_be16(FIELD_PREP(AD9832_CMD_MSK, AD9832_CMD_SYNCSELSRC) |
-						  st->ctrl_ss);
+				       st->ctrl_ss);
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
-						  st->ctrl_fp);
+				       st->ctrl_fp);
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
 
 		st->data = cpu_to_be16(FIELD_PREP(AD9832_CMD_MSK, AD9832_CMD_FPSELECT) |
-						  st->ctrl_fp);
+				       st->ctrl_fp);
 		ret = spi_sync(st->spi, &st->msg);
+		if (ret)
+			return ret;
+
 		break;
 	case AD9832_OUTPUT_EN:
 		if (val)
@@ -242,16 +256,17 @@ static ssize_t ad9832_write(struct device *dev, struct device_attribute *attr,
 			st->ctrl_src |= FIELD_PREP(AD9832_RESET, 1);
 
 		st->data = cpu_to_be16(FIELD_PREP(AD9832_CMD_MSK, AD9832_CMD_SLEEPRESCLR) |
-						  st->ctrl_src);
+				       st->ctrl_src);
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
2.53.0

