Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795866979;
	b=kLTTvLDsGMMUHF8TSVIT/Lgw8v3xC+HZpwzquPawZCeih5yByyAwFAnw+YJeYP7iRpil
	 ylOhCs2bfoeKWWLAWKyMRD3uH6jsI9M4hvKshX/shUx9AbLB0c9DGSg4/E6J3xLQ+o1pF
	 BsQomkPE0od1seFNncCDsIeIA9K2ZeDaelR4SvtuCIJ/MwhjUQmhqrtWlA554o78HthWs
	 LRkHO3FnE18q6KlofoIOkrjl5wCLt6Bw+tERyaamZRSOx3WgEe+kfXI1wBayrlbNF9OEV
	 A/v95L0FGEaVzSphIzGGrWbgoveMtHentZADD4q11maPpLN45m5w2kuHqFrrDr+Nu1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795866979;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=IKfrKBdHp1p/3dKcSiRvczq1zRYGfEHZWOwCgXIb+40=;
	b=z912JCZMLlEUN/81vzD3f2dMvOliZWMMEfgvq34AdZZktBjy0WaOl/T1TTXQF8I6ckxP
	 bBra3V4mrKHH4No/t9xDtbbKU7wcEv/pufzKb9xO4phmPnWhRMr103939Lt6V+22K15ys
	 xW3MVaYFokCfYrYPA6A/f2bWK/TnHhauH0B5nPm/EApyonWKMAU/a8AcapUbd0gfR+1pk
	 1p5DECQ4QOuBbMhyhvva93b4JgI3TF+SySNkMevJsTvN5Dk3sWWFFmHJhWy1eU2yW1UBd
	 VF3A9IHjpctDpj+aCc9taQZsb8pNBClWypVRooALaNZPmh8yT1MkoX/yJzxBbLHXqLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=e4ZvGN+v;
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B99C606A324
	for <linux-iio@vger.kernel.org>; Sat, 28 Nov 2026 11:56:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4B99C606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=e4ZvGN+v
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-38190551625so16962475eec.1
        for <linux-iio@vger.kernel.org>; Sat, 28 Nov 2026 03:56:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795866978; x=1796471778; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IKfrKBdHp1p/3dKcSiRvczq1zRYGfEHZWOwCgXIb+40=;
        b=e4ZvGN+vto5zXBUNPA6YbVWLUF/1ivFDEsyf9G8oshmjO5VjoW56dNfcyUFBP1DrwH
         BTQRsLhr5kkPKTCUOUYEUEURmuKMICwSmt/2dsCD1K7mGfOTxgVRJ0sSOuTauyxrb6kw
         JGn931WeC5W8+OtDZvSVqlBlQXGg5VAWwHdK2i8Z8vV5vwwTcsxtAio0snR2gprMgaE1
         2a5TgTTpbSdSJDnD0RKzRDSATmPpDvFvJTNK+2oY4khqGkMCeD1CYYeH3cmhLTpgwSU4
         Ia0p0bxaiZNcFJj3M1L2rTjjnn0vjBGmQ8W8yoE8g0G5mDV673WQ17/D4En7Z9QyR0/p
         plvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795866978; x=1796471778;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=IKfrKBdHp1p/3dKcSiRvczq1zRYGfEHZWOwCgXIb+40=;
        b=e23C7xiMP0whyS97kld+wnlyyz3+omgsHVuYKK+KmtzADfMSKZgWAYwaAHa/+76GDI
         0Taq1Oj9pkKbVQJQaUulnz6LRZo12cW1kzmEy8agDr3F34xWMMf9Zq59hyzzhsd60Kae
         hALUWinKjmQTCuHfTaH6vSqBdeIb2go5KJuU62ctxteHT9dK9Sd5811rgimdbaR6sB4I
         Ks5EBpfFg0oob7jQFEKCUJW+8beOqMgFs8i5kQS/dFXo62GD3o3bqzgloavgl5Wjg1/U
         kMVCclnQxYPKBkBXLw5kz5CyMMMzGMDgC9VmE6UXEFmZVXpOSSFLecFBUzI+ZjTWIXWf
         qH5A==
X-Forwarded-Encrypted: i=1; AL+hErGev2zLXz7AUJzJJF3sO/6B13WZU/VqNEQjCSxISx8XJ9kFhVYWf8a7x2z53hZIb9FzYQs70MlyvDQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z84DurKCQxraPOALimKM3Qzz4Rr+68ENw4KJJFv8w+NEeTzCuvT
	0S33NrabcJvuAfmzSJi9Dxco310ofDCu24TQ0hs8zXEvfqcKwQS1mSnJ
X-Gm-Gg: AZFdTZdcNwwPXqzhifmlKx52V5eVouQfgv0EWfuOtwRujnZKRIX69ImuvL2qCSxPWPf
	o04GR61AHAoLw2D+crtx6z5AtBU5SoBQ9Nyq3ZjDq7adiy9lp7eOgNagRWWFN+p6kyfKIqW7Mp8
	SNPixQ7tLy/8r0aQCmNME+mlaX43IFHSLHJXy4cZWxHo0/XzquncRjWbUx0u34WgQamO/b7gIDM
	dJ7DLkurlaOXsCG01eC78OYOB/kR2YcpHAszT9Ea8LhSwge4MYCbOWHC2966sPHm6E3r7GDanET
	r1ANIIwxnIhJzuny2x4epoEplpOb6ls6HKNjr3FHR6Rl+YGiSYAGydcFXnTyJ1DThcQxn1OB+EB
	6y/0GqQ5uROjf2Yfp/zxXPq3zB0GsVpgXabQk+cnvbvObpaRqGEOSeTsnj7+xzqjfnNnAVNEWZj
	Kj24f9Zf4+4wXbPfSIeaUuVK4V2PGHWA1B+nNRj6lFzLFO9pxeJv17DnIe6fBl0OGOm9FXocAPO
	UaBqSS076DDsI6d2dd+wRFEpEZ3dL/nyHPrJ5JT9ThX3UTDBs/TBLg22FtB59xOc9J9Y73KDdZE
	IcAsUJX4Yf7G9TJtRYLNLzNUfYYGD07VOxOrK1LCGwKkRP033fhNA/OjsVK/VOtRvD8/gFt8xOB
	ztorazihJHCBJNBd2+jMmDpd2pdampOAroeO5Q07kxjXoHLotRfQE4BkDK5BOjK+S/fv72y62bQ
	jh8IYRxcAAHbJB9cykrdRs1wWD8W+U65ctF9K3nfdkyg==
X-Received: by 2002:a05:693c:69c7:b0:386:b745:ac60 with SMTP id 5a478bee46e88-386b745b019mr15169711eec.18.1795866978349;
        Sat, 28 Nov 2026 03:56:18 -0800 (PST)
Received: from kapoor.iiserb.ac.in ([203.18.51.239])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385f68bc0adsm76783178eec.13.2026.11.28.03.56.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2026 03:56:17 -0800 (PST)
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
Subject: [PATCH v3 6/6] iio: proximity: sx9360: reject negative hysteresis values
Date: Sat, 28 Nov 2026 17:24:54 +0530
Message-ID: <20261128115534.558478-7-kapoorarnav43@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261128115534.558478-1-kapoorarnav43@gmail.com>
References: <20261128115534.558478-1-kapoorarnav43@gmail.com>
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

sx9360_write_hysteresis() copies the value into an unsigned int before
comparing it with the threshold, so a negative value becomes a large
one, passes the "val >= pthresh >> 2" check and sets the largest
hysteresis instead of being rejected. The comparison is done in
unsigned int, so this happens on both 32-bit and 64-bit architectures.

Return -EINVAL for negative values, before converting them.

Fixes: 1cdb4c47f7f5 ("iio:proximity:sx9360: Add sx9360 support")
Signed-off-by: Arnav Kapoor <kapoorarnav43@gmail.com>
---
 drivers/iio/proximity/sx9360.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/proximity/sx9360.c b/drivers/iio/proximity/sx9360.c
index 2d1525547ce9..b03149344e69 100644
--- a/drivers/iio/proximity/sx9360.c
+++ b/drivers/iio/proximity/sx9360.c
@@ -545,9 +545,14 @@ static int sx9360_write_thresh(struct sx_common_data *data, int _val)
 
 static int sx9360_write_hysteresis(struct sx_common_data *data, int _val)
 {
-	unsigned int hyst, val = _val;
+	unsigned int hyst, val;
 	int ret, pthresh;
 
+	if (_val < 0)
+		return -EINVAL;
+
+	val = _val;
+
 	ret = sx9360_read_thresh(data, &pthresh);
 	if (ret < 0)
 		return ret;
-- 
2.53.0

