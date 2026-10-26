Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793003317;
	b=gM2lcfXdxw2Ipj026hpDBN2OSpA1wiOic/5WeMWHapkwn4nqZ6GKkKRpIAwYZ88Y7c1x
	 WiZVeWIBNhXSgogAnPQiiZJnDqiRV0d5E7MzZx9n9vxcWH3j3HzKqa16pCQk/Lai6ng5U
	 LOZJZOTvRhinMN71kEplV1YRot23IRRdCRgGXyCIKqlBIokdx4+h18xF88aGk77vESlYb
	 7t9Mcdk8sAXICP5oNYgKZcKiWCo6RvjRB8rLkFpozXncx3lH6xvKzY34OIBHdrDRJZf19
	 QleG5DGujjRiHflJoJoS+uBPQIFKiVKUlE7iVfzdk8vY7AGL6O9PmxpXguXLGGTev9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793003317;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=EjCtGVYy8oVZbBDhEOaUUsJdWh7LVDwBlPS7EGRKlGg=;
	b=lU6oTmUxQZngVjteSo94W6zQpAvUjRCeXEvjZPNFcYSQBVJGYJfW6RjERLKExx5wDfyS
	 T0CkCJrxEqJius0wU7PlGTzPLXv2Ctc/rkbZsxxTNNpiA2FTUszb8LRPUE50WWZocuSka
	 ihpevTzIxJxvpyCxQlGoN3Cer1rA6Qh4Y4MRxfN2JWSsdq28eC5csW4np7OZEHf6lyLIf
	 6SWW8j5Iq53H5LxChy+Bzz81od1b3iJ15wlmgIiq56x8/lnk6cL5fYUdtT5vI/DfWs0As
	 E6fH23FTINO0ucsAqAIrs8uhZu+ibBHCF3haEPW+H6X9gAYcZAaNma4ZzmXUUn6Y3ZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="lGX6M/cV";
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006D9606A31B
	for <linux-iio@vger.kernel.org>; Mon, 26 Oct 2026 08:28:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 006D9606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=lGX6M/cV
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-35b2c599f43so124048eec.0
        for <linux-iio@vger.kernel.org>; Mon, 26 Oct 2026 01:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793003316; x=1793608116; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=EjCtGVYy8oVZbBDhEOaUUsJdWh7LVDwBlPS7EGRKlGg=;
        b=lGX6M/cV1LoTJcMaZ/TBu0ayjwwhkTFtefO3b5Z2FSFZQOzdhpxLHaHavxIAHNeVI1
         pBdtkgHwt66JEEAeYYiTO7+zXlSTIZDGL5nFe5xT77m+N2aeTBwroww9yk9WVTaoK8XI
         6tDN6XZ4XM5LNEBEo+GLGe+yLz6jZFqgsTbwU8W84yXv/K9oPSyF3V/Emda0gwqp5E0k
         pfjWNw39FaHJ18VyEevYiXfzmjZrIq8P+NcmqKvXGF3ktuSy27Rnmi4ygmH1GQysaVk6
         CbNZiV0IT/vT+3f5AnHM94QYUYpQGKdk/HPQWJ5a7C86QbayikziLADK98rwCLJH2YRx
         a9Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793003316; x=1793608116;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EjCtGVYy8oVZbBDhEOaUUsJdWh7LVDwBlPS7EGRKlGg=;
        b=Wu/jm63kZpeFbuqMJtbzq5MHfKBIuak4xVST0DiKQ0f7T9IMBJ6JPLOMHOC0Xe5+fg
         /eulCo/byQp/GfLql70fJUdWcbozBujX+PDkW2XAMbYtqZRY/ejj5ka5ZBbrDNMbeLsf
         tCWmIsbVQPg7gDX6ZIzDlnJOg15GXtD0zGapSc2iF9544wf4eQBR416atabfGYQM6GNu
         erpisYXOc4QY7QDpVTCU//yB5NxmPW3T1ufgBZ//dp5ScOBj4RciNIDWOUVmJwPpYXI5
         tBM5cIBmc2c95SjcGXdamg0WY0bHwelavGSEoC1IOsgbWGf/vRCoyiiWA9nLKGit/GK6
         VR8w==
X-Forwarded-Encrypted: i=1; AKwUvBxOgHs30xmPPFH4iY9KtagPtfSX49dCXTiaiqA8lEn/2pc1uy7gm46WizoUJ79OeuZ+WrpGEXq0O54=@vger.kernel.org
X-Gm-Message-State: AFq9FYJF63xQRlLKjirvDcNZJW2tW16o4W2u2BR9qPpXbWJYZbBFpWS0
	tLlUhHVzaem3v+ZobDiN6gW0Dd7Jyk8/GCMIilQChIbb0IBOCo0RLxnzehbFg6Oqq1cuoe54
X-Gm-Gg: AYBFou3/2HSDUBPVrXchyf9fVknHesCIgJiCk3uvI4tQ3QrVaQBok0bDO+7YBNJ/DPd
	EYR4mR8rPDJZzUrBN0cW7ThUTXt6JzrVKjY9/3xCmPvEXPQdMay6jHS8p1PCT2xUrmkPSQG1elJ
	8gADkof2h6cb4Oh39RQFeczhkC/6gyRUBoAlI7mFtkDSQKTXNGEEFwHhoiwSUSnQgJICJulEcLe
	fAiy9ooh/Lta7L1hhsKePBQP5thNmbpL+WcKaPrBtS07d9kBUBDMAvsrNW6lprzCYd7BmEDawN6
	D79+wKQHf/m+qEKzba7KsRF/XuaD5Jmt+0dohiD7E3hR+ypUFm8ciSGgujOxXm2hXNwVZKxQ45O
	SIK8rseMvqFnggsA+nCPU/dYHYx7iAzIMbGbPaKlZvVpRBKg3xbiaEPcgO84HRTErgUDV7CBo30
	dpSMwWKU6iG6IeX/7NJODknhFJC10W+ISbSl/q9SZLRBYzXCYYsdqZx+Wsp/v5cG4ExtdkCzryY
	UwZ/KoTUDNwjbghpKjERXOQG5HtrrIfDrg79+UXUD9P2YvojJciyu2LXpqE9jVKhitFX1UEN5CF
	duT1
X-Received: by 2002:a05:693c:87c4:10b0:36a:43d:8ef7 with SMTP id 5a478bee46e88-36a043d9429mr1824611eec.18.1793003315844;
        Mon, 26 Oct 2026 01:28:35 -0700 (PDT)
Received: from NithishVelan.localdomain ([152.57.83.124])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369ef6a71a4sm22301819eec.8.2026.10.26.01.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 01:28:35 -0700 (PDT)
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
Subject: [PATCH v3] staging: iio: impedance-analyzer: ad5933: use guard(mutex) in ad5933_show()
Date: Mon, 26 Oct 2026 08:28:28 +0000
Message-ID: <20261026082828.652-1-mnithishvelan@gmail.com>
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
ad5933_show(). This simplifies the function by allowing direct returns
from each switch case, eliminating the mutable return variables and
manual mutex_unlock() calls.

Signed-off-by: Nithishvelan M <mnithishvelan@gmail.com>
---
Changes in v3:
 - Rename local variable 'ridx' to 'val' to avoid conflating range index
   with PGA gain bit (Jonathan Cameron).
 - Re-use 'val' in AD5933_IN_PGA_GAIN to keep sysfs_emit() simple
   (Andy Shevchenko).

Changes in v2:
 - Extract range index into local variable 'ridx' to prevent static
   analysis warnings (Andy Shevchenko).
 - Keep short return sysfs_emit() call on a single line (Andy Shevchenko).
 - Split AD5933_OUT_RANGE_AVAIL arguments logically across lines (Andy Shevchenko).
 - Remove redundant parentheses in AD5933_IN_PGA_GAIN ternary (Andy Shevchenko).
 - Resend using git-send-email to preserve tabs and whitespace.
 .../staging/iio/impedance-analyzer/ad5933.c   | 38 ++++++++-----------
 1 file changed, 15 insertions(+), 23 deletions(-)

diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
index 798e62bae2..c05a5f4b42 100644
--- a/drivers/staging/iio/impedance-analyzer/ad5933.c
+++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/bits.h>
+#include <linux/cleanup.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/device.h>
@@ -333,39 +334,30 @@ static ssize_t ad5933_show(struct device *dev,
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct ad5933_state *st = iio_priv(indio_dev);
 	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
-	int ret = 0, len = 0;
+	unsigned int val;
+
+	guard(mutex)(&st->lock);
 
-	mutex_lock(&st->lock);
 	switch ((u32)this_attr->address) {
 	case AD5933_OUT_RANGE:
-		len = sysfs_emit(buf, "%u\n",
-				 st->range_avail[(st->ctrl_hb >> 1) & 0x3]);
-		break;
+		val = (st->ctrl_hb >> 1) & 0x03;
+		return sysfs_emit(buf, "%u\n", st->range_avail[val]);
 	case AD5933_OUT_RANGE_AVAIL:
-		len = sysfs_emit(buf, "%u %u %u %u\n", st->range_avail[0],
-				 st->range_avail[3], st->range_avail[2],
-				 st->range_avail[1]);
-		break;
+		return sysfs_emit(buf, "%u %u %u %u\n",
+				  st->range_avail[0], st->range_avail[3],
+				  st->range_avail[2], st->range_avail[1]);
 	case AD5933_OUT_SETTLING_CYCLES:
-		len = sysfs_emit(buf, "%d\n", st->settling_cycles);
-		break;
+		return sysfs_emit(buf, "%d\n", st->settling_cycles);
 	case AD5933_IN_PGA_GAIN:
-		len = sysfs_emit(buf, "%s\n",
-				 (st->ctrl_hb & AD5933_CTRL_PGA_GAIN_1) ?
-				 "1" : "0.2");
-		break;
+		val = st->ctrl_hb & AD5933_CTRL_PGA_GAIN_1;
+		return sysfs_emit(buf, "%s\n", val ? "1" : "0.2");
 	case AD5933_IN_PGA_GAIN_AVAIL:
-		len = sysfs_emit(buf, "1 0.2\n");
-		break;
+		return sysfs_emit(buf, "1 0.2\n");
 	case AD5933_FREQ_POINTS:
-		len = sysfs_emit(buf, "%d\n", st->freq_points);
-		break;
+		return sysfs_emit(buf, "%d\n", st->freq_points);
 	default:
-		ret = -EINVAL;
+		return -EINVAL;
 	}
-
-	mutex_unlock(&st->lock);
-	return ret ? ret : len;
 }
 
 static ssize_t ad5933_store(struct device *dev,
-- 
2.53.0

