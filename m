Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4CDC3ACA77
	for <linux-iio@vger.kernel.org>; Mon, 13 Apr 2026 09:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776073508; cv=none; b=Y5u/U6ouHDbujiAXVLc4oNXznurO4/pDGOkvYIRXj5mahdMuQsp6m86blc1D7rKAOe/VZ5735gaB+TSk1JRUMD61uMGyArX4YvIast+8Y7+UrWvC35psRXQwWt4WSg6wcJFzn2EtxgKTlv97nwZl6cRNz8e5u7kG+USjEaKKOoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776073508; c=relaxed/simple;
	bh=tRM2XEviYmzNpHxmiQmJb5o76ONqFqD1f4YKUuNLChA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gtp6PRIO6S9UBAlfF/b/Er67aKrzael7b0nZRTC7hZAG+1/GQl4MTcOja3FWXES/ieiqYXby7xFOgie6+hLDA8pntrSKMgobU3R8yawDQI5dztKFxBAa2km9x+7TXoazQ6OOrCIZjH7F3/KmBtaX/OCXQzrTEyE5hf94Xbqhfa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dwUmGdUX; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dwUmGdUX"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-358e3cc5e7eso2229746a91.0
        for <linux-iio@vger.kernel.org>; Mon, 13 Apr 2026 02:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776073506; x=1776678306; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aIhihVi4VLqcB9n/cdIcJVpsz7JzIYL5F/BJQAyNyLg=;
        b=dwUmGdUXY1/1vcOZvh9MFq8tXXjBw8rk62gYQKwWbCRnt6C66mDrlg5ePuMwaumln/
         GPeYlYo7XLKKXPoQh//5sMrMrcDtO6OYj5oWD/ctOaMO4I1mQGwqH29Esa+2oNCs4wCd
         WRLBAaR6P5lxjs/ztdKHSQgGdbFBfvMDqzUbonS8E8YQhfnR62iMNAOjtT7Jon2JKP/1
         2DVBu1vpoYFwRUrIZpAA6WNKjDh/OeAOCXi+oPon+aV/a2MG7HWktjMRhJfLnoSPB5gw
         NGDXYE5Bi97o2k4F4RUfKCsyfhZxGVQ38Q+3V1D28vxqqtXM1lEv59mm9vQRdxX/5ikv
         3V7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776073506; x=1776678306;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aIhihVi4VLqcB9n/cdIcJVpsz7JzIYL5F/BJQAyNyLg=;
        b=jTZqP4097stxXCwt34UuHqZTG2rFqf27orXBf2ccCX1srEXZlD6d/TfWPm4VqAfa2B
         KoPaU0SSL4LbWLlxnvcsmyyva8u8YzRiuKGpVws20Hj7k88ddMSFWn23aO3hrtc2sidb
         OuNKku3OLcSJQdWsB20qCdKZnUJLsw9naUoWE4f4nGGs0e1cgzaTcxg5p3VwmCRG9706
         Wg25JfxpdfHh57MyWIlAbOIHgjr3Co9JYTpTdvoPLGxg/sRVPD1+pcUjQ7K3uQ0aRsiR
         uDZD2V0Wqc4xyVGmiSoep8YlAXy/XkdRXupQ1oagbQXjuu+1MlUqhUuTGcoAe6cl319S
         oOAw==
X-Gm-Message-State: AOJu0YxxhqxPynC9AJHhBWUdBvdSZvpgjGvjVlLyK8WJviy3JijecWaX
	csX1sKd7PC8DFKlgf+3ZmyJr3FJBRFof/m+H2D3T0P3KpwpJpNmpvZ4ZqJ+Reww=
X-Gm-Gg: AeBDieuAGQhh8mgiCx4pvuho/rtooEQfnmbNRx4jiCeF1lgkRT6cXi5Sv7WVfSlVMJ8
	Q3KbGc9Bg24Mdz5dP5T0CA7aKYgWdTtxBJ6OQTelXiBqksiGB5mmxV7dcUCclJch8FXHbkOHV/r
	xm550hTiWuuL+pMl4BG5hyAT+1rOal21QRYHllF2PEQZM/hTTYz0GBhHfm6mGtq6S5H05gjVXCv
	dnuY5hFWFtfNHYnZ67fXpUiUfVKeDc105bphoFj57zHEMzgeLxK/zI4Ze1qfVhQzTbXDZFppUBS
	1sjx4CgDou34L16PDNQh6PZQ7YvvMt03fPElX7j9mO5i1ZhURRQ3Zq2syLw83BARV6oQGG/skQJ
	PmWWUktVsbr/mEldxGi+qEvYcp52H8oZyV24BvbhEKaTLddqR8XrUkHS0IRBzdzbgbh+7R6Pv8R
	jiGyhBZupJnpiLNVAMz/O4E4j6vmw5+jICa0DOXcKb05rFNHMJuvY9PvW0gi2rH4EFzL5/CyxO9
	1Rlawxa2M7KDMhklboOacf0aRK0QVEhP/pdVB+nmIDvQRjnskagTPQz
X-Received: by 2002:a17:90a:1188:b0:35f:b4c1:91e2 with SMTP id 98e67ed59e1d1-35fb4c19596mr2351554a91.29.1776073506513;
        Mon, 13 Apr 2026 02:45:06 -0700 (PDT)
Received: from nik.wlan.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35e42db1b51sm4832562a91.3.2026.04.13.02.45.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 02:45:05 -0700 (PDT)
From: Nikhil Gautam <nikhilgtr@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	dlechner@baylibre.com,
	Nikhil Gautam <nikhilgtr@gmail.com>
Subject: [PATCH v4 2/3] iio: dac: mcp4821: move state initialization outside switch
Date: Mon, 13 Apr 2026 15:14:48 +0530
Message-ID: <20260413094449.18837-3-nikhilgtr@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260413094449.18837-1-nikhilgtr@gmail.com>
References: <20260413094449.18837-1-nikhilgtr@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the iio_priv() call outside the switch statement in
mcp4821_read_raw() to avoid repeating it in multiple cases.

This is a cleanup change with no functional impact.

Signed-off-by: Nikhil Gautam <nikhilgtr@gmail.com>
---
 drivers/iio/dac/mcp4821.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/dac/mcp4821.c b/drivers/iio/dac/mcp4821.c
index 29187f2a9d3c..6b732db1cf49 100644
--- a/drivers/iio/dac/mcp4821.c
+++ b/drivers/iio/dac/mcp4821.c
@@ -116,10 +116,10 @@ static int mcp4821_read_raw(struct iio_dev *indio_dev,
 			    int *val2, long mask)
 {
 	struct mcp4821_state *state;
+	state = iio_priv(indio_dev);
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
-		state = iio_priv(indio_dev);
 		*val = state->dac_value[chan->channel];
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
-- 
2.43.0

