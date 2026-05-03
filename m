Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2156C3AEF3B
	for <linux-iio@vger.kernel.org>; Sun,  3 May 2026 12:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777810252; cv=none; b=d7PC5o4KtoaYbvbMUv+qIbbpm4uWmNfyVIg/CmcEi5Bx2ntgR+bZgJxDLYRQYuz3ox9rtgv713bLkkfMaWOix62D0uIIUbP7ACWMnu9qVd0dCs2qT1oZRFdb9uGm1s5mYzo4agkA/BVLg4aT5X4iBU8v1zQI+o/aGM3vUUrlFUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777810252; c=relaxed/simple;
	bh=OvByowY5AkD+6XxbWpU7e3CK9GMCI7JhmFpONYFhBxM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uAOe1bgho9JKCZmh8h+H36ofVGRk6HDyDpmk+Hz2/u2Lv3YePQcC6/nbmxWkhg+uO+IfUxxXc/UgYwR8cjbfMzcrbzNCEspoOHRQ8LhuTvVrGoi1ujh9+8FTzfTFyqueZTUNNgrKMbdsObnBruSMlwTnQZdWqVWWoNZQ7UkZ5z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tNprjW3K; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tNprjW3K"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-835b78c3797so97149b3a.2
        for <linux-iio@vger.kernel.org>; Sun, 03 May 2026 05:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777810250; x=1778415050; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uZXP+KkBGD3rO/JBi4lfVCJXw9tpw0NHQd9gpIHkSxI=;
        b=tNprjW3KZ21ZYjAEKBrmlAtYf1NUcn85zyCIuc9s1T/SHBaG1+aZnkXTg/jPSk8aa1
         BFTrOWFG8UvNDq2Pfg6Nbkrclgdv5ktonsDnkelpjmdviKflnFbzIGdyuIrsFXbcfb3D
         5FisoKMsvm146Q9xyqQXoxNMODpLNKH1a/Wq9Cz6Mns0tB9iiKAx0AOR4CDg+Lh21u7g
         K9DD4+ZMcNZHVwQlkEOzPs01lKW+ddhBgTnADsDAC2kEbVExfCtFTAnDwfDcfk6UcRT/
         W07H1xRTA823L7UNlJFlmX7U0ZZkzAe8pXOACzt8NUNAst45oI5sGADJa0/V4Vk1w+lC
         cwOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777810250; x=1778415050;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uZXP+KkBGD3rO/JBi4lfVCJXw9tpw0NHQd9gpIHkSxI=;
        b=F0r+pksRLkrJjdtICCwSSKNE/WdfLmDr2kiIwg0V/c5XZJk9aJEMhyPagN3h+NEQ9Q
         M6t7WmcgQrCZwMg7gG9PfC8injribPCHyIf+6afpqs4xggGgJ0XZPk8scNSudJzMlOiF
         umTUOvHtzRvB+mTbzo4Y3ej8zmu4qSAbZ0IxHeenp1Qjf3j9P0S6qVrIvB7ottLEtTvl
         Zpihq+MFODshrCKwryYULjz4yllOetVu6CFmqi5PJh/z0S9Ntnvct4KrDmYDBaEY47V9
         MIiVEvtgIqh3bDJkCaftD5gpXwQFETitvnY+284dYbD9kVqH0FSiys+tQ9cfz8gLJ2Bq
         OZZQ==
X-Forwarded-Encrypted: i=1; AFNElJ9db7VnIsDZsnjajLs8wq7l3S/Kynsw60XfqTmj2Ln4c+KDaVuzwnAOR94Wkpjvb3KXGpt1p9pQ/Pw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxT46OzHytQIXjMg2aR/HnkzQSumBrxzU1miiLfcCGVlKrO6XU/
	On5eUYA3bG26PXX5H/RWWBI55uJVVTf7RRWUW3RjJ+81n6WnA7jIPw8V
X-Gm-Gg: AeBDiesHq1kUvUKbWvRA+gTDv/rVAXFfmJDcjK2vS6pyXjAndau2qkxeWp8/WkRkGdz
	86h9gLVPuz/wUD0H3ZGfIU52EI5ptcky8Kkt4lYVnqVx3kKxS0N1K4h9IXWa+FhMo2k77rpfrHA
	3P18JvnetPU2250S3VcizPQ3+nx7uxFizk2yjOpVYj5obf5oLqr0AcvQ9bEApIvAopml+D0T/B2
	rqAbycZyAuPlxcqlyqwAQ2DljfoTMI+Idgw+0GbKUyKAvMLKb1SpSs500p1rkcIHolx7EMVkBf2
	rNRTJN3OV1SXUpNSyFdK1SKTmzDqJDrdsAwldeS+WuH4tbLcsMk2lnpK0DsJmlHjuZf241i7tFz
	ayaoJaKagDb2LrlDyZZpn/hTL+5JZAkYQNANxzmwrzxxMF6bSYNUEmR88fEOEMPjG+awbLe6v61
	FbxyhnltLCgzXy9VXsC2ZubdJ3RBWlp4JNdQjjkeZ3H91PMHpaEkg4ro2auAPXKS4aH4WQ2HL1S
	PAhbD5QSPkY52Fm1g7HVvOG67PRSbB9MAi8iea+++yt2rUu/V2j/q+6YsJU5ZZ4JOngz+0=
X-Received: by 2002:a05:6a00:4b4f:b0:833:2398:cde2 with SMTP id d2e1a72fcca58-8352d29aa43mr5125855b3a.43.1777810250423;
        Sun, 03 May 2026 05:10:50 -0700 (PDT)
Received: from lord-daniel-VivoBook-ASUSLaptop-K3502ZA-S3502ZA.www.tendawifi.com ([14.139.108.62])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8357c4f4530sm1474364b3a.9.2026.05.03.05.10.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2026 05:10:49 -0700 (PDT)
From: Piyush Patle <piyushpatle228@gmail.com>
To: Andreas Klinger <ak@it-klinger.de>,
	Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 08/11] iio: adc: hx711: split variable assignments in hx711_read and hx711_reset
Date: Sun,  3 May 2026 17:39:37 +0530
Message-ID: <20260503120949.80292-9-piyushpatle228@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260503120949.80292-1-piyushpatle228@gmail.com>
References: <20260503120949.80292-1-piyushpatle228@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Separate the initial value assignments from the declarations in
hx711_read() and hx711_reset().

This is a small preparatory cleanup before the later loop-iterator and
variant-specific changes adjust the local variable layout in these
functions.

No functional change.

Signed-off-by: Piyush Patle <piyushpatle228@gmail.com>
---
 drivers/iio/adc/hx711.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/hx711.c b/drivers/iio/adc/hx711.c
index 637114635867..b2de8db285b2 100644
--- a/drivers/iio/adc/hx711.c
+++ b/drivers/iio/adc/hx711.c
@@ -159,7 +159,9 @@ static int hx711_read(struct hx711_data *hx711_data, int trailing_pulses)
 {
 	int i, ret;
 	int value = 0;
-	int val = gpiod_get_value(hx711_data->gpiod_dout);
+	int val;
+
+	val = gpiod_get_value(hx711_data->gpiod_dout);
 
 	/* we double check if it's really down */
 	if (val)
@@ -204,7 +206,9 @@ static int hx711_wait_for_ready(struct hx711_data *hx711_data)
 
 static int hx711_reset(struct hx711_data *hx711_data)
 {
-	int val = hx711_wait_for_ready(hx711_data);
+	int val;
+
+	val = hx711_wait_for_ready(hx711_data);
 
 	if (val) {
 		/*
-- 
2.43.0

