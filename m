Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92917374192
	for <linux-iio@vger.kernel.org>; Sat, 27 Jun 2026 13:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782566759; cv=none; b=Kc+In2pGPOwDLgRFYeRa/vIqqRKsFChA5FDCk0xQDJspc6g8yqPc4EijNx+0bPU3S341OCULJf2iVSIFGRyurugs9q+JWKSCWR32OrqSMBre6zgzLA0ruKcu4NWJrVhbKFSvEtCiRrIil5VVtwPVF/uuc1v9s7V1wIOM4sIu8Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782566759; c=relaxed/simple;
	bh=bTgAWl0aMuZggxL6S2YfcZkHPhtQwlNDjrT5kTr4OG0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DuLemwe+ltTBTnmyMaBCfu2T62Ch1GN/KZrmxRcIO0kayktRbq0m3fvDv+rXpfHr5zaLQ2r4ZuAoamPT+MzKsz2Sy0GGz8n7LNLHiShyBYhk0N+CFJS3IjPoMNfsCVjk/yPjpvBssifI1wXrb29HmpnXhl1BEJQOE9i1JsMlw/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br; spf=pass smtp.mailfrom=usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=GuaDdzHp; arc=none smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="GuaDdzHp"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-13810b63a1aso4431675c88.1
        for <linux-iio@vger.kernel.org>; Sat, 27 Jun 2026 06:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1782566757; x=1783171557; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2nT4+64T+6iyEjv1kvvsBVN7Pj/dKZkN6SoluY839/k=;
        b=GuaDdzHpoxqs660z2qYbjcw2R7zAXybxpPaeLY/6cH7cIl31EIoycAio3E+5ArvBG5
         AyFph1whYhxcKEua1A5slItxwt1aM+iG2qhrZ9k+sSxxvR+3TeWDWH1XujuwhmIqWhLn
         GYck1PJaiWJnkKqx+dY8wggnlykPwszWQ6Rb5L7oab/tUJCunVF/+f3yF/8xXZa8756W
         ED4QVkN6zHSJt8nts+mwA7+OQD1shxbtmbSeW/ljrdzF7iuPl+0g9YQsK95GL2Rvx6Hu
         8vkqcYlPIfqZzx0BBAi/VFhXO63Bwbno9TXyjF0M2A0G4nYhL+AyVeFBh3fZxJcAF/4j
         ja6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782566757; x=1783171557;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2nT4+64T+6iyEjv1kvvsBVN7Pj/dKZkN6SoluY839/k=;
        b=OOq/4x3Xhtk7tx5hv6GPvWwGhOtcjvx4Zdx8xEeG2e7SlytaAycVUgKik8UvUcfFwM
         m5I55R6y5Ar+Nk8/GLGzK8syf8NbSTa9TWNA6GiGQxEDVRhLbFVi21uWq5J+NX3BK8EC
         VYvQVvwL4ix+QH79MPmJaS8xTl7WTw1dORCDt9SVmK9tridT1AZdgxs6pUVr/ZuDRHKX
         RFKvMqSOxH5zuYiUVSzGyFBKBoq4egAajMM6E++s2rwiL3El50mXLQao0WnKB5y1IaAB
         cS0uVkbfBHEiLTJpYbzvBJxQYIZSSzMFqrd4TaIUez7nJ+6BLx9URxueUmmDA+RjYd4Z
         e7RA==
X-Forwarded-Encrypted: i=1; AFNElJ9yi+VKR7fhnPEpAB/PMh/i3FbiO40igkzsT7xpc2XpUKHRRApii9jSkTRfjmRoqSoB97+YciexEX8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuMeMUavrVfdLUDtwWMJNQrt0aS1agjXU9WdnOL7c0561043mH
	iai37eQK9sNWVIZz1UVT32Dn9xEk24MVPY1pwjgxlDHJDu3umkVcAHz6XQWQryWd+TS5JzQHOD7
	sDa0J4oA=
X-Gm-Gg: AfdE7cmLDE3sQY2N5DiHpoUzY4Ay7Bw12x+/6br32xD8Kr7CpSxckdUpc27+lISoO9r
	B+PG04bhJKEjl9vfy+5jOITTt0SS+OIO4OcHj0ImdbpqduK11JXfgXbgTZhZt+5yI3dy9MiIxwd
	hH04ktm0HquiIP7St4zevn7gbngFx0/KUrZMgg9Hkw02VGzca4+L6TZCuXmhFPZO2Tjvs56ewrh
	V3zt/U5BgsZdRcr3WwK7ofvbyr9aq2Xj2PxU5qaO99C9DA5bLDyUY4NwnI9qF9kWnSYcrwb9beG
	EQhTjVbiZ2GYIIjJNQQbvlttBkmS5rhLQl15HL61kp9HqMYptpo52fPKFdEKxpYE/7+wkERiVi8
	1DvSLOuGAMWZHqGkpZvhr5PPeDpFpVuLQD2d+cQbrpIraVG4SvjE/Ofu49FVIUiymlhuW60Bi+l
	DJEinby/W/pya7M848EK1/+eRfT+g=
X-Received: by 2002:a05:7022:6b9d:b0:12d:de3e:86a8 with SMTP id a92af1059eb24-139eb5253acmr3369515c88.38.1782566756741;
        Sat, 27 Jun 2026 06:25:56 -0700 (PDT)
Received: from localhost ([2804:1b3:aa80:ec21:dab8:1927:ea27:9d41])
        by smtp.gmail.com with UTF8SMTPSA id a92af1059eb24-139d8f31866sm39761163c88.1.2026.06.27.06.25.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jun 2026 06:25:56 -0700 (PDT)
From: Erick Henrique <erick.henrique.rodrigues@usp.br>
To: jic23@kernel.org
Cc: andriy.shevchenko@intel.com,
	andy@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	linux-iio@vger.kernel.org,
	Erick Henrique <erick.henrique.rodrigues@usp.br>
Subject: [PATCH v4 3/3] iio: dac: m62332: Use guard(mutex) for locking
Date: Sat, 27 Jun 2026 10:25:30 -0300
Message-ID: <20260627132530.96680-4-erick.henrique.rodrigues@usp.br>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260627132530.96680-1-erick.henrique.rodrigues@usp.br>
References: <20260627132530.96680-1-erick.henrique.rodrigues@usp.br>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace mutex_lock()/mutex_unlock() calls with guard(mutex)() to
simplify locking and make cleanup automatic when the lock goes out
of scope. Also simplify the i2c_master_send() error handling by
using sequential early returns instead of a combined condition.

Signed-off-by: Erick Henrique <erick.henrique.rodrigues@usp.br>
---
 drivers/iio/dac/m62332.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/dac/m62332.c b/drivers/iio/dac/m62332.c
index ee8fd3a71315..10ff6727b76c 100644
--- a/drivers/iio/dac/m62332.c
+++ b/drivers/iio/dac/m62332.c
@@ -47,33 +47,26 @@ static int m62332_set_value(struct iio_dev *indio_dev, u8 val, int channel)
 	outbuf[0] = channel;
 	outbuf[1] = val;
 
-	mutex_lock(&data->mutex);
+	guard(mutex)(&data->mutex);
 
 	if (val) {
 		res = regulator_enable(data->vcc);
 		if (res)
-			goto out;
+			return res;
 	}
 
 	res = i2c_master_send(client, outbuf, ARRAY_SIZE(outbuf));
-	if (res >= 0 && res != ARRAY_SIZE(outbuf))
-		res = -EIO;
 	if (res < 0)
-		goto out;
+		return res;
+	if (res != ARRAY_SIZE(outbuf))
+		return -EIO;
 
 	data->raw[channel] = val;
 
 	if (!val)
 		regulator_disable(data->vcc);
 
-	mutex_unlock(&data->mutex);
-
 	return 0;
-
-out:
-	mutex_unlock(&data->mutex);
-
-	return res;
 }
 
 static int m62332_read_raw(struct iio_dev *indio_dev,
-- 
2.51.0

