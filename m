Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795695228;
	b=H35GC/Tq8tCARSW6UEQShTPxvejerjlaslNco1e3342aHjhRUM/2UofYq+gCv1eOPncw
	 DWxweUnEVaXA0AJRrPJMo5W99eFKbBDm8Me1IZPB9W1xykjb6NNlsTncmBnungFKiz+X/
	 MH2LqJLK5hCvQmMp/BDUDdyJjhz74wqxfuhqHuYmuxunV2Dzhqp+FNkkF9D3Tz4d9juwK
	 Qzr5LSrOt8/TIgxfZvVnZ7uJZnlx5QybcbHZMrvT60zMCY0qUzB/+OnH/OZXhvh7kFWca
	 o9IT0hzodOlRZP10+Ie2oZEjtgD7BTlIaLjyorWc6cRuZa1yafybfaMiC5eU1HPZ4bQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795695228;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=6jLIDA3Ejr90H9Zg8hbSIbmc5S8RY3wVmyD2CGchRzM=;
	b=ZQH+ipVT2dLrQdflXJqNrF4owNMmVR7T1gmz1dnAzOIjGew2GvNvcXJ341a2unvqnEoj
	 kIj+RYIXula4Y18vyXOB4LxpPf0TzzrvE2ul0EgHu5OHaeSqfoRXtNGSZqNoWqXp1/P68
	 19gc63IvHRcKnGaDX3RunoInE0m3fgM0xXoLYGZCeo3C7vsnhCPxcWxNTP8pEewWkX0rj
	 eMDemUhFqoZWcrGSg1uyg/XuGPAhk3mZHLHoZQHU2sASwKk/OU4IiiLTRw1zA3Ch4u/ay
	 +rPPsRUxgBY/blg3ihlwNbuoOoTcgCpWrBnxYR6y/KK9xTaqwLwhmITq90NmW9OdKCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="EVXs8yh/";
	arc=none smtp.remote-ip=209.85.208.180
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90901606A69A
	for <linux-iio@vger.kernel.org>; Thu, 26 Nov 2026 12:13:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 90901606A69A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EVXs8yh/
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-3adfc004920so65938531fa.3
        for <linux-iio@vger.kernel.org>; Thu, 26 Nov 2026 04:13:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795695227; x=1796300027; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6jLIDA3Ejr90H9Zg8hbSIbmc5S8RY3wVmyD2CGchRzM=;
        b=EVXs8yh/L+xJYUHOegpswY3XEw5d83Sf0dUzaY1LcMxI+gdpgTGyKdl6qaV7aaIQ0F
         y2HxEINWwimbGYG4qZazDP7cruA14USn84c/MrUgUCJhyHi2sfq4nkGpz9gyI9iR7lxN
         WUHEDBu4vBzo+D6YTWkJENjNL6VQrVSVjwXBaO4GKuqOXiVsMSd9Nm8+DVJg++2WZPTH
         L8BbtgSqmIzfDM0aoYceSkUBOFdzP2IO6IUY3sR0EDuyg95Va71T/D4FkcW28/AEIaHc
         dfiJSCvAgUjCL+IJVUFZ0BJGpUDswUPoXW1LrC/fjfMlTolS2TyoXGbcIuEUXwZSAQSr
         +fsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795695227; x=1796300027;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6jLIDA3Ejr90H9Zg8hbSIbmc5S8RY3wVmyD2CGchRzM=;
        b=t5UK9+Quijk/Zra5tnrfYIq0aXcED/EjWcFmL9AsaxBDhmfRwi5mjuS/+zvPg9jYt9
         8TqPnPB1YSLCyoIdJ6rZpFVG2Ux3P0bpEtzjys7Is9HZCyK2R3JjOV+JBCqQg0Txq64q
         ySPGmZ30ym+w4XnXh5j1OZt1A+sq+44fapINO+OEx2+Hz9oV52wEx6zqKCT1C9rXJtij
         a58b8ScZSiwIH2L63D9gfExVjq6iYbQDXVMHUfvXZGrnZnl7brVPl65KpwdObKj286oQ
         TdJTrWISXiFu4nhOcmNi0KbxClDRCZm8c0heaGzYcfGU5LDwSy3i9b4zXaUfmHrPYkZv
         5vMQ==
X-Gm-Message-State: APuU4Z8IUPfM/3gcM8gcpC/F5+SMxDDc1hMAyKtKFuf4+VoTt/PbOX0D
	8JKHLpI7bHiZXXj0SlTwDboFgPe5spGNbDt8Z84zkMYmQzqQbgLZioax
X-Gm-Gg: AZFdTZdiKJEGjn/8ogvBBe4WSmw1afGxMw4Uj8tTiYJW5ua97EkDnlYXv2vcDo8GbSw
	x6FDM9hRq2ul1Bl3NGYZEmNt0SnZGv9yrvst03iSN3a7gMlxMOIwFFYdVMemadxqZZfpH/aruJT
	ikcPlIUORdtER3N2+rxq7fkTCKzXOq0rk/w+sOOm/Jh+i50PzsV3gMKvWU/JqBk/MoPEEo8jUKZ
	DktYkYuREQtJ76qmPb9Vz4YSKz2pgN9f9fLrPRf+ibzE6sOV7QJEJ5a3mJFt4gs30Eqh53f/cZX
	6G1hgrX60BgdmeoWAZ4c71CA6+3CokrRMHmt7wxklodOlpglVeLBwQgCs0oCAfacyF8XXw3Tjce
	VWjIy1tCSY5QHB8rSjiegw6tMk/jJx58LG+docr72UeliC4OZV0shuSNSnP0/zMuGw9/j84o59H
	7J9BCLjodFBlu3eD1567gWzAcaCfXnRcrqWph+2uzZPBDky1pxIeY/+BFHkbf+9SHHi618xSvbZ
	jiKIhH4cqD4ok1zdRiHmchX3MfMdXqh1DLS03hfqLeExgX9TMMBov95DVeudFVohayaAaed6FGD
	GyIue3o9ppGcaQyVntmg7Br2MRjEeJLPdu/ciySrOpERMRPWp21qq/kkuQ4pIvEPv0mI3tFDyRb
	gtewk5jOl26fTAUIxB3iNT+VdUC7f5Jtgr9jS
X-Received: by 2002:a2e:b8c9:0:b0:3ab:1862:25fe with SMTP id 38308e7fff4ca-3ae7f9a4d78mr73688421fa.4.1795695226613;
        Thu, 26 Nov 2026 04:13:46 -0800 (PST)
Received: from yantra.. (nekmmqtmzjx8yvukhae-1.v6.elisa-laajakaista.fi. [2001:99a:d7d:c300:68b4:f70:61d8:6e86])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3ae8044e8e0sm56541791fa.5.2026.11.26.04.13.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 04:13:46 -0800 (PST)
From: Rupesh Majhi <zoone.rupert@gmail.com>
To: Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Eddie James <eajames@linux.ibm.com>,
	Jonathan Cameron <jic23@kernel.org>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rupesh Majhi <zoone.rupert@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: [PATCH v2 6/7] iio: pressure: dps310: drop the unused i2c_set_clientdata()
Date: Thu, 26 Nov 2026 14:13:29 +0200
Message-ID: <20261126121331.10438-7-zoone.rupert@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261126121331.10438-1-zoone.rupert@gmail.com>
References: <20261126121331.10438-1-zoone.rupert@gmail.com>
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

Nothing reads the client data back.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Rupesh Majhi <zoone.rupert@gmail.com>
---
 drivers/iio/pressure/dps310.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/iio/pressure/dps310.c b/drivers/iio/pressure/dps310.c
index 1d46817ad04a..72f62a1aa3ea 100644
--- a/drivers/iio/pressure/dps310.c
+++ b/drivers/iio/pressure/dps310.c
@@ -1633,13 +1633,7 @@ static int dps310_probe(struct i2c_client *client)
 			return rc;
 	}
 
-	rc = devm_iio_device_register(dev, iio);
-	if (rc)
-		return rc;
-
-	i2c_set_clientdata(client, iio);
-
-	return 0;
+	return devm_iio_device_register(dev, iio);
 }
 
 static const struct i2c_device_id dps310_id[] = {
-- 
2.43.0

