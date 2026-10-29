Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793311603;
	b=jeraNMU9Ah9D4/tR/xxELaOrJxfDZOh3y1n1gxA5pIPpDFaGJs2enTYphE2jxnwfERuL
	 Wkd4sZ1P/OzVfCxqTcKzCH1SX2DGsUWQI8pfWrgWtULK2gmP23/k5e18PpI3BIUTw+prB
	 W9GgK+C8O0hqpDguzAebBGRXdMJkXmGO5nMJEl0e+NNWP6Kz0fItI+WyPfQ/m118ZQIVS
	 tLNXxUBKypclXe7WdyXhnTNOoZdPVs2HI2AYFHVBqX1+XfzQVHK8YhrkTclmyZwyT7jCz
	 o7jQhc4lulFuljg0aq6QzbEKjkbDJqqbqDawOZFSAwhvbULCfVutVC4XkkDePX6cHCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793311603;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=AUotzmCqd9glGddS9PxvEgwMOpXMRn5H2iSsgciQMXU=;
	b=wG+3IsRyqd51sYO1JhrKkgHHiyIrZsVoMu4SuCJMiTICvfycvuzIYW8xXC7Vj48VDUEV
	 BK55DitGH7F7xY+i0dNJcFwXeRPba+lOnmE1mP/tkgvjbq/xentI4W+zd2GxYSLThONCU
	 LAuMbI0kFTbcbb2C/Z36t32I9YmZGvqo0bAUJpVgVxVDqFOejccWXBkzIAkzP9Yv+erC8
	 B/VpQsjqL/7g0vl3EP0NOLmKy0Xp41TD/DbgbUkM/xIvT8vUyNcuks0jrnA6fcKyYkylQ
	 Ek2EKJIW16edqeMPIsX728d1f471G8XGHyqx0fnwX6wOsg7E/eY6Xgt3SF8CgE6HNrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NnB0sgLD;
	arc=none smtp.remote-ip=209.85.167.54
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC6E606A33D
	for <linux-iio@vger.kernel.org>; Thu, 29 Oct 2026 22:06:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0BC6E606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NnB0sgLD
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5ba3ec92031so149603e87.2
        for <linux-iio@vger.kernel.org>; Thu, 29 Oct 2026 15:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793311601; x=1793916401; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AUotzmCqd9glGddS9PxvEgwMOpXMRn5H2iSsgciQMXU=;
        b=NnB0sgLDS2ZMBmgaEiUGFTcmHWOr7URX6Rw26uk5dFTM7J4ZYxVfLMPiJa9Dn9y2Cb
         OpbGWJpRFZfupU/+Fv3CufKcyImPGRXL9NRG6E+ayF9ODU/fsLXKDuyLu97dZsa5pUFJ
         92hc/PMIFUBoy307czLIlTTGden+l93KKWGWBvHphY/8OuXX21gfP05cLhUXjFio7bO2
         ifNRt2w8+c9To8yVaDcMq1l8SGbOyKgrnHtGqvIk5e0RUmeCw91iaZ07ZqLhtDPeUaAe
         DJB6SXZyMtP1/+RAuvUcZ4mqoj8YSFJxs5esfyq2XMMcdelq+aiAN/6hG5K+3upiLS7N
         a/xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793311601; x=1793916401;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=AUotzmCqd9glGddS9PxvEgwMOpXMRn5H2iSsgciQMXU=;
        b=Y7/CSZWxPJDWzORhAvyxM7eeAvnSDEQbzCL8daiiJAo5W7x0+nxwltW/iHvX/ifdsC
         aNyCEwOURJdJwdl+lMKFarysanka2+ZehNWk4Iz/Dx0GW2i/9dFsLbUuqi/zbLxaLwg0
         NSr+6XgmOuhxjreumilD6DcYtYueqOrCIhkvZInwhxbLmSzYWONnTzaCRefeC7qzWB0m
         fZ9/KYijaqjQdu9bCW+QPFp7Y0y5yiHq551/Fygt0qqLUDI1VYcQe4SOnf2On1phS7F6
         3IGZAdQtqVnZnN3wjeti0pZCNwOK7v+f9Kiz+byGOxMDwh8NbxjK845a3cOhzyveCskH
         QPGA==
X-Gm-Message-State: AFq9FYKbuReaGzV5wQEozdOxTrjC1+cEq+cI3tDZlhAqJFYnnrq6LVsG
	vLLpsbuhk2To53Y1E4wP71p2XQTEThcYDnEjK1lcFtcqanXmr4ch6tdE
X-Gm-Gg: AYBFou2rtNQc6dRJie9lX2BMT2YgYPOT04RccAMb8o9xP7gCheV7+gzvBXQ8ZrkgAwt
	7nGGGbHXH3CAm5hFVLZk0YfDfgQ0FdbZvEkjm5XffjZNEygcliphlD9w3Wi4Y9+EFhCp+TaWG7o
	z3rbjUaBf0WMumgoMo1o2VEfwFBqUNkopNF8yXQcZ3WV920R49R8TPGS4KDZfG5/h+GoRhf4IOo
	AXVNkuyesEX+DAn+bsWctIKTdbDj+EaT08UOJJZ8uIode5Qxlimo06x/PBZqeGODpyvnHnOz647
	G7pV5tJIVx3rx+D6fLvRaEpNAkGy6ARF9AfjKCMl6TxtNEMr262vEnhirZ/7QKU1ML7szLMMgye
	8EJdr+Xbr9lARgCy62wj+7BAgcm4pShbJ3nFDeIC8W4Ep/1eWnxdOBRgyalUIeEJCxVhWG20YVX
	rce6CeX3LFqE6qP/ZKaLlvE0iWnBTWInY4bzWEuluwH2rGP5uCzhPyAsBzrrtgKxF0/1GQF+zBK
	aQhpi3qpRlqlalX6Fku8ln9P9qrBaK5VjU5oUbrdztkPPjhgeqUWvPmYv1oNBpNAV6LKoN30GET
	UwFG6l8e/9OJI9LCN4kM3O2WDrcMK6C50KaDHxTnZrJGCn+oh1Z29IdANe3CjvRCijDymJ63zYT
	NOclpW9/vzZEqjKIHcF4eot5/cm1PPNtgbCRQS7pkuEyDYu27lkBV4/xQ/zE=
X-Received: by 2002:a05:6512:b94:b0:5bf:cabe:23b5 with SMTP id 2adb3069b0e04-5bfd9595416mr56362e87.60.1793311601021;
        Thu, 29 Oct 2026 15:06:41 -0700 (PDT)
Received: from yantra.. (nekmmqtmquaao4qwdoc-1.v6.elisa-laajakaista.fi. [2001:99a:d7d:c300:6842:e549:8c95:f73c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5bfd9c507adsm9605e87.65.2026.10.29.15.06.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 15:06:40 -0700 (PDT)
From: Rupesh Majhi <zoone.rupert@gmail.com>
To: Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Eddie James <eajames@linux.ibm.com>,
	Joel Stanley <joel@jms.id.au>,
	Jonathan Cameron <jic23@kernel.org>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Rupesh Majhi <zoone.rupert@gmail.com>
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sashiko <sashiko-bot@kernel.org>,
	Paulius Zaleckas <paulius.zaleckas@gmail.com>
Subject: [PATCH 2/3] iio: pressure: dps310: reset the chip at probe
Date: Fri, 30 Oct 2026 00:06:34 +0200
Message-ID: <20261029220635.18816-3-zoone.rupert@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261029220635.18816-1-zoone.rupert@gmail.com>
References: <20261029220635.18816-1-zoone.rupert@gmail.com>
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

The chip keeps its registers across a warm reboot, and probe changes
only the shift bits in CFG_REG. A reboot during a FIFO capture leaves
FIFO_EN set, so the ready bits never come and every raw read times
out. The timeout reset does not clear it either, since the CFG_REG
update that follows writes FIFO_EN back from the register cache.

Reset the chip first, as remove already does.

Fixes: 90f0d1016398 ("iio: pressure: dps310: read buffered samples from the hardware FIFO")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260921183132.233136-1-zoone.rupert%40gmail.com
Signed-off-by: Rupesh Majhi <zoone.rupert@gmail.com>
---
Cc: Paulius Zaleckas <paulius.zaleckas@gmail.com>

 drivers/iio/pressure/dps310.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/iio/pressure/dps310.c b/drivers/iio/pressure/dps310.c
index b6aa5dbe2bcd..29778f25bb33 100644
--- a/drivers/iio/pressure/dps310.c
+++ b/drivers/iio/pressure/dps310.c
@@ -1445,6 +1445,11 @@ static int dps310_probe(struct i2c_client *client)
 	if (rc)
 		return rc;
 
+	/* The chip keeps its state across a warm reboot */
+	rc = dps310_reset_wait(data);
+	if (rc)
+		return rc;
+
 	rc = dps310_startup(data);
 	if (rc)
 		return rc;
-- 
2.43.0

