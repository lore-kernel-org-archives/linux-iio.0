Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794862422;
	b=jbWJOvslgAIpWkQSDnijkVkojDb3vO727mf2Cr29Rwqb8n0e745GovvFSTlv5KzSt9rx
	 VKTTOf2xf+Y6yfTTqpIvNrQgV5uKHoDcEotAVLjaBu/WmND2jR8V7mpvyEYk54421qpv9
	 Fg1T0vfLJw9bAMoaXH39kuks/MoYC+x4hK5VCcRaS8xrgJSE811tnl217HcjiAjfnTyoS
	 Hep8PkFpTgGxZAIE7raQr52/Zgo+ALnsZeKShaY6gUew1iJ+tAAUZhWmeT8l7a/zsGBc3
	 MEFIVaw8WDqwGJLHPO8HdDoamQM0csFfwkJ4JMSJs1yG2RR4VuAk0QDA8IdCi5vc08w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794862422;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=et8BZDPK3IqwhJJygWhGMdcldXGkpkfpRn1M7UllLC8=;
	b=vtszafQFESt+Iwdaj9pgRla5077TRaBi/It+xzIC7ZvPx7JcZVIkTnwD4GAk5B55atg7
	 YlS/JON+noks9aqU5uBurlWLmX0GxAfLOHTVs3rZZjo78NHrsu4k1t+91V67KcN3GGSOG
	 Z3vfcsYmbsCC71H5SbVP7Gi/stOviZj/VYngZs1fKALRfa0H5pQ0mpS4WrfGoGvQCraGz
	 p1XaqDh5cupLG0oNI9souO9K/d+xcD1Cg+/h1tQwNkn+TF//i3M/77nH46ESqtkAvw1Jg
	 zRjzhyyLE3zSRLF82wysGxLiXZZr0vUvxUnKV5MTUgXXrl4TqjY6Ssrb8p5NF3KaLJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zmpao8n3;
	arc=none smtp.remote-ip=74.125.82.43
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32509606A322
	for <linux-iio@vger.kernel.org>; Mon, 16 Nov 2026 20:53:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 32509606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zmpao8n3
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-1b3ada81853so3594212c88.0
        for <linux-iio@vger.kernel.org>; Mon, 16 Nov 2026 12:53:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794862421; x=1795467221; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=et8BZDPK3IqwhJJygWhGMdcldXGkpkfpRn1M7UllLC8=;
        b=zmpao8n3WNOs4kj5j6g6PlfLwITwpUjUxRTaTPV2pqSkv5rzZ2LJMWIZyVeM3Bm90z
         Wq8kumxBJnmunE+koK0CQN8uJogAyX2rNbAu39ZrrX5M/+nsjMPjqkEV2LWKyJKGeSTQ
         A7qfZV3/Fkht06AwfGV2sRU9u2DxHR4GbQJQnbxIly/hEF1AeBvCNcquXNeAZYzRx8br
         M6M1aQvDwYwWXfye6wSXJ790fl6qD17Ahwtv+vMn1j7imSlmI6b/Kc/PU2Gk5uVv31HF
         j2BM0PLPH8cctkt091hBpw6dd1S2aewoyeD35Lkd1gj61K/pG8ovRNmIW4dcYIYeZfKf
         UKZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794862421; x=1795467221;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=et8BZDPK3IqwhJJygWhGMdcldXGkpkfpRn1M7UllLC8=;
        b=yFyJNT1K7JKIBIs849B3VZS/MLIHz/wOEy0e0h3yz+XkJ5A6YxVhHSqzx0+BxN6wrp
         ylfvtud/zt+qlcMErX263wl/Ol4V3kLSaVCtMqUNTDpjL/ms0ZgAq0/fgR2BgsBbPzA7
         Rs5LSrA9CImmFuJM7taHeQe4p5jB6hWGT870TnSOrllqnT634I9cZEyBp23fljeE4uXE
         jaFzwVYJcKsQrZG7XKGyK8PESjU3aDMVxL7xUY3dmVNjtR6nOQSj/pkuPfPgkkoh1+Q/
         Km7ghNg+ZcnQGOA3glrCf0OzPRdNzV5NtbNg3QlMdsbhubeTIpczzIBs7BL1k2kAX6Qu
         jHBQ==
X-Forwarded-Encrypted: i=1; AL+hErHo4B9V5ZmZ0JGoaV2MLoUEgAHz1odBlrew6WbVvpderbdbpgsYBuVf6BL/19tdc6vOZZZ9dHdjqBo=@vger.kernel.org
X-Gm-Message-State: APuU4Z957x/yTC5c5ZQHZrg0DfuSWPtiNFR2wQhj5FpGEB30hEttba7X
	U2iiCTgWMRNBbmwiu/q2oXyFZBzXuQeKRFqzeLEYTYp8lx393rP1Hucy
X-Gm-Gg: AYBFou2k1TnHl4yTc1KfXy72g35VOsyQx2TZ+K0iesRP7jdCUwDaZTU9klh6+UxrG/m
	1b7z1gullXGSCNS7rSFLv74+7FNBJlGsWjKa01qtPlBM0UdbB9KP567XdMfpgfxQb7s1qKWc3mB
	PXB4P9aTSg3lKBl5UJEUiXSs65cwRzyHPurzxP7nU61fZab6f4gpJwcmgKsD4izcrw5qY+bd5/o
	zeQnLHCRi74OsTRs5vvP2ip1xvrJm+DrMsNiDB6pj0xFcq6wfJwvaYoFSA7weBcNqxoJN1lihOW
	qLwwiprqyoR+wUKiz8WtHqWOIh5duSuR01e8Y191QHVjedvuUTZyfYSCmCItpKp0sE5N2Aaxp+Q
	C1RDlvv89Na/45IY64AL7oAv/KY7t2sm/ruk3CCg0mfq9cDP30I/3Mp8TWycfactE3G+pKoqPoR
	Rph25FgwsY6I5oina1d/3OvmORBanwRVqYfkELxW78Qmbr16GDxhfCV1BKEw/G04uARD/Ej0cQS
	32+bS9w1GI7yfGDCbqF3NEVljaHNl/qp7uR457hSvs6YBV6h/S0uiUB8hdHsFRY1GrIF2DGUBSP
	YspxGGKq5HSzT0GmULnlZs9qSp/tqK0ien8B8sL0epo6CUGRAkdbmvdXp1WRZw9d3qCvXp/+v62
	66tHo4yIdPV7Rxhhy1lXdrfUpDX7fVO3VtKr7c09DxuVLVu/4L7apSnF9nUke6YmQ4hGe7Hv6O7
	ZP9VUiv5oXZunJu8ynuTNLzTovI1a4ZOz6dm4ZPQXWHw==
X-Received: by 2002:a05:701b:2608:b0:1b3:a22c:7f68 with SMTP id a92af1059eb24-1b50311d3d5mr9990641c88.29.1794862420977;
        Mon, 16 Nov 2026 12:53:40 -0800 (PST)
Received: from kapoor.iiserb.ac.in ([203.18.51.239])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b524049e0asm15293497c88.4.2026.11.16.12.53.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 12:53:40 -0800 (PST)
From: Arnav Kapoor <kapoorarnav43@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Gwendal Grignou <gwendal@chromium.org>,
	Stephen Boyd <swboyd@chromium.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Arnav Kapoor <kapoorarnav43@gmail.com>
Subject: [PATCH 2/6] iio: proximity: sx9324: fix proximity threshold writes
Date: Tue, 17 Nov 2026 02:23:10 +0530
Message-ID: <20261116205320.26070-3-kapoorarnav43@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261116205320.26070-1-kapoorarnav43@gmail.com>
References: <20261116205320.26070-1-kapoorarnav43@gmail.com>
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

sx9324_read_thresh() reports a PROX_THRESH code r as r for r <= 1 and as
r * r / 2 otherwise, but sx9324_write_thresh() converts back with
int_sqrt(2 * val). For odd r the read value is (r * r - 1) / 2, so
writing back the value that was just read programs r - 1: setting the
threshold to the value it already has lowers it, for 127 of the 256
codes (3, 5, 7, ...).

The int to unsigned int conversion also lets some negative values
through: 2 * val wraps, so e.g. INT_MIN is written as 0 and values just
above INT_MIN as small thresholds instead of being rejected.

Reject negative values and use int_sqrt(2 * val + 1), which picks the
largest code whose reported threshold does not exceed the requested
value and makes read_thresh() and write_thresh() inverses of each
other for all 256 codes.

Fixes: 4c18a890dff8 ("iio:proximity:sx9324: Add SX9324 support")
Signed-off-by: Arnav Kapoor <kapoorarnav43@gmail.com>
---
 drivers/iio/proximity/sx9324.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/proximity/sx9324.c b/drivers/iio/proximity/sx9324.c
index 93f9577bbda7..39760c92552b 100644
--- a/drivers/iio/proximity/sx9324.c
+++ b/drivers/iio/proximity/sx9324.c
@@ -617,8 +617,12 @@ static int sx9324_write_thresh(struct sx_common_data *data,
 
 	reg = SX9324_REG_PROX_CTRL6 + chan->channel / 2;
 
+	if (_val < 0)
+		return -EINVAL;
+
+	/* Inverse of read_thresh(), so that writing back a read value is a no-op */
 	if (val >= 1)
-		val = int_sqrt(2 * val);
+		val = int_sqrt(2 * val + 1);
 
 	if (val > 0xff)
 		return -EINVAL;
-- 
2.53.0

