Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795670845;
	b=nW0PEqRETRV1HzZsMVbNqW1b2ze5Djqr+X63RTbrAa8NNMPunmoTTtG17HHw03RxCh9t
	 lPYbu+19k37emPbzCzXpZfyqeE7wHuhGgKUhTr0HLN+vNmH+ybFNpdBe77Jq5B9+cPTtq
	 JgCHUVQncpAjHOK4dw0sLb2O2zQonPVyRpByTs+qSlhI9ro3z1ePmVSO8AYAX3edA7P3E
	 sJdHpRmFPRkW9fJNhOrosD+YKVIEOb3ik5k4vk8Z2mr6R66gPIDwXzV57t1P9rW1Z6aKm
	 igYcFF1ZKbEPHJzOYIRaHYfACBpvldXSua3Y5p93cEG0gt46BY6wllNyWD1kkekhpNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795670845;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=VUov+GN2Pr0nsBo9baC7gvBiW9rNVC+tY20smPSc5DE=;
	b=2JCOOAzPI54gZ70HmAKPorHvE8i15Q7YRsVZWAsHOW7dgjYb3i6MGwElj7hxbUs1rInd
	 cvEKeHRJO+5j+fYvcnvkG0BejsVNLxQ8jaRThDGolPUmotvpdhPlpjE/RJGFtaN1zYPbl
	 X0qeFz6zZIXjmzi/Y/GI6jEPhweDlbD0/Mw+sj2FTii0JGvDo8kxeGUnmf50MzD116rk2
	 BcR0nM/B7mOj2mdF8K4sJVUHKjxIPr6VT6pEwe5Bh/oKlhJ/HIGkBadxAwKDsBAetC8+Q
	 rUhbi+6fHpsJYPuEd1q6klYg/wFLc/gA3B1si6VuJTjZ6GRfZbeqdtgr8p5iELNLA6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UNm3FXJ8;
	arc=none smtp.remote-ip=209.85.215.171
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA06606A31C
	for <linux-iio@vger.kernel.org>; Thu, 26 Nov 2026 05:27:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1FA06606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UNm3FXJ8
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-cc758830601so4946557a12.2
        for <linux-iio@vger.kernel.org>; Wed, 25 Nov 2026 21:27:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795670844; x=1796275644; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=VUov+GN2Pr0nsBo9baC7gvBiW9rNVC+tY20smPSc5DE=;
        b=UNm3FXJ85vCiM7t9rkXGuCTC23hx48n0ILtyFdoDnWUNs3mHacRX1rIydAmNlVc0ke
         lel2Z3sgM4HV8KwGzVxhlhlSKuEb7ISfi406gWxq2xDb+fdNYDaTg4RE5kmgOAWIeNjo
         BKsDXaJ/O4/AL/9K5xJ/iW8JCKM3Y1WV0kxEEpirp4uxlTMn2qDG5OBHMwjo81gViomZ
         k9BJQ7rlruarBc2RbprQBInj9IoPfR02P/xcqix8YpnWFbx0wUnj4gLgNkHKVuTWiSFI
         k8IdMt8Lp4H0EWN28MKvN7/gPn8mSg7k/AjVFU86TKUo0353l5IiVDCfrYX7DflVL+N1
         9xtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795670844; x=1796275644;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VUov+GN2Pr0nsBo9baC7gvBiW9rNVC+tY20smPSc5DE=;
        b=usKzLV6l6r8m6a1jtB7IEVD0gi1K4qlgTQg5Q/vCf4fKXF+vkUFU0eyTmMuZ7NyB7I
         wUnAZMuxZV+fZ1qzSA7GsQ6kMOgQIgeJu/epdk47jmGstEE8q24Fp4YoFARBE+VKvAWj
         pG9lJEFgF+r8kdLrNMatAxXoCgsCdcmiXFNwQElUg0VoG7FFopYqsbDhjn72rrYpgvdM
         kr+DAG+qU4Gi5VUMf67yQvoQLdpeYLKrmzyUoKM24U4eWSj2xB0Wba9ts5fM8s70vDTr
         EcPL+kOReTTlEYQYfZJYbfkL7rby65n3QGKNoQB0Khnw0D+LdOKo1fjO4hbewmZd+dj8
         v7Ug==
X-Forwarded-Encrypted: i=1; AL+hErGoB6ILeKN9whZKtdg9EEhcn8COiOv4WJ+l6WqdiGtK+KjD23uQj+Z4pjfZ0UQG7uyFhqbZFLnscdI=@vger.kernel.org
X-Gm-Message-State: APuU4Z+maEl1sia/xyto92aHObb3T7x5FcNyqEwq17KCpiQlh0tXCKH1
	SX3V1Csa+Vn9zKIRPhRDFN1pWpI3/D7vBCCwC1JrvK3yinFmd6Vos3m7
X-Gm-Gg: AZFdTZdKJ+EONMtxLk6NAukgtF4aOl2eagjc2o0Sx9XQ4tu4u7Pz3jmt7H/3Lb2LML2
	hFwY/pVz0otgXJlFVIqfo/MZzPI+zGmaI6MucXYUR9dgyaEHhzxQaNAh76wEg/IcbsyaHkijbm0
	VP94vr77bQkGwD3QFBbQwXKCjWS9rwpzObsEbxtNBUvHf1G5jmDaZyZaNLd7XAVwGDs1KqmSAgz
	tQc1mLhNekODib7Z5Xre888fNg9m92Ag5hl+OD8XeqLCBedy+GmbVoBK/33ls/4u7XJ+lBKWvkE
	Pw0/E3wxfqOlDs9g8ybj/wQEdwjeOoHNHFiI7T2KhyV1ojr7zi+7xo2MQcgkcaUvDgULWMPORhg
	BmMRfDU4XFtOl8cgmp1gSXMrXNfSADgZlJsA2TWcFwqt7muMG+ope0ftij/ku7J54YgSNR1yJ7+
	DfGI794Ki4KPVE55L0KwCFTsaN8cjibJsV55PV2Ztl3Xq2PcTm5czwYmIWyYWLETW9PnCHYwzG1
	Ouc7w/+GI+9BpHvfiSQhh0xReaQ/0D+WpuAt93MhCmtQL91n0vX9DX+jvx1L6OBEnlFiSDFjKJ6
	THxYc8DbXCgcW1Uk5T5pbX6SY9PyNhZnn7HMtiNO3kHK0TAUhbmTKmfOT/aS6tjNeSvMXQvfPkr
	I4flKXPLjCh9N55fK9LGS
X-Received: by 2002:a17:90b:498c:b0:3b0:a757:4f85 with SMTP id 98e67ed59e1d1-3b41c7c7a1dmr17853656a91.2.1795670844348;
        Wed, 25 Nov 2026 21:27:24 -0800 (PST)
Received: from LDYT9Q2G2M.pvgl.sap.corp ([2a09:bac5:cad0:1caa::2db:4c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b40578dca0sm34035791a91.2.2026.11.25.21.27.21
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 25 Nov 2026 21:27:23 -0800 (PST)
From: Zhiqi Zhang <zhiqizhangg@gmail.com>
To: Tomasz Duszynski <tduszyns@gmail.com>
Cc: Arnav Kapoor <kapoorarnav43@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	Zhiqi Zhang <zhiqizhangg@gmail.com>
Subject: [PATCH v2] iio: chemical: pms7003: Reject frames with invalid length
Date: Thu, 26 Nov 2026 13:27:17 +0800
Message-ID: <20261126052717.69095-1-zhiqizhangg@gmail.com>
X-Mailer: git-send-email 2.54.0
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

The PMS7003 driver accepts any frame data length up to the size of its
frame buffer. This lets a device send a frame with a length shorter than
the two checksum bytes. When that frame is completed,
pms7003_frame_is_okay() subtracts PMS7003_CHECKSUM_LENGTH and reads the
checksum from before frame->data.

Reject data lengths shorter than the checksum before storing the expected
frame length. Keep other lengths up to the frame buffer size accepted so
short command replies and compatible Plantower measurement frames can
still complete.

Tooling disclosure: I found this bug. OpenAI Codex helped prepare the
fix, and I reviewed the changes.

Fixes: a1d642266c14 ("iio: chemical: add support for Plantower PMS7003 sensor")
Cc: stable@vger.kernel.org
Signed-off-by: Zhiqi Zhang <zhiqizhangg@gmail.com>
---
Changes in v2:
- Accept frame data lengths from PMS7003_CHECKSUM_LENGTH through
  PMS7003_MAX_DATA_LENGTH instead of only PMS7003_MAX_DATA_LENGTH.
- Drop the extra length check in pms7003_frame_is_okay().

 drivers/iio/chemical/pms7003.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/chemical/pms7003.c b/drivers/iio/chemical/pms7003.c
index c50edb24a..70e7575c0 100644
--- a/drivers/iio/chemical/pms7003.c
+++ b/drivers/iio/chemical/pms7003.c
@@ -231,7 +231,8 @@ static size_t pms7003_receive_buf(struct serdev_device *serdev, const u8 *buf,
 			return 2;
 
 		num = get_unaligned_be16(buf + 2);
-		if (num <= PMS7003_MAX_DATA_LENGTH) {
+		if (num >= PMS7003_CHECKSUM_LENGTH &&
+		    num <= PMS7003_MAX_DATA_LENGTH) {
 			frame->expected_length = num;
 			frame->length = 0;
 		}
-- 
2.54.0 (Apple Git-157)

