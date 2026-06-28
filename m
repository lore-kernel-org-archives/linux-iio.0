Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE703AEF43
	for <linux-iio@vger.kernel.org>; Sun, 28 Jun 2026 14:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782658714; cv=none; b=kvLQ4tEeUOVAsn9I7SikVseFuybLZtVIr/xmbcjIGPPQxuWUK4asl73VXSk7CAAvc9113vAO1iiOxGb2GfMa+6uZjk9MBV+b94HrUISG67S+mK6xi3R1J36413frR39DSTSrlK4ctfK0PHfI0eVvXgQHv653SpYjUMZ3xwMYOJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782658714; c=relaxed/simple;
	bh=xmwWSaBy4FHvE2lZSfawLpH4uzj+yitUohO7k8IBseA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=r2TVEJQHpq5c7czNs0clmrXjXj8QxMgaowziBlT7BuLPnUfoBVg5L31KNMuZmQHeLU5LfwMrVHk8fmxtNMX+12OmTMsLP2ARlxBnZAhBx0mGL16O6Z0UWKOXOa/P7NVODGGaPnH80704UzX66JxG9atuGBpqZp+f3tXlm+RHyfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=keeQARtV; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="keeQARtV"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-30cac93dfd7so1046133eec.1
        for <linux-iio@vger.kernel.org>; Sun, 28 Jun 2026 07:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782658712; x=1783263512; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iBiW+Jb5ofAnhQsaYWPoJcN5SGqMaVDonBUCRupHVH8=;
        b=keeQARtVmlJd7EUXeW5hTHFVTO9IoL7tuTnEFoKxN2ERMoROuJ0J3BAWra90BjxRQ1
         1iEKYYhno3AhCi0AW0es/0X11AHSwq5lJf/lddhyoB5iKXDz4d5ex/y36r96ohyVFYjF
         yMHz8xNsFQtuGdEomdtn3PXTTlsw4YK6DwvqnSbTxlMVe9Ny5dPg1HvELKpFo0vsVqMe
         6V7y+0y0L1L/SOBmE969r1EQac6X2dVCn3kXVY9O1i13iXf+VBhvymFlVUgdEY1vOmjR
         ORrgWsDu9o+yLH8gbEhexxHUlSowxSIEr7T7HypTQuzgxGMqQjiJbRzRAJxRPqihbsIL
         2TIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782658712; x=1783263512;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iBiW+Jb5ofAnhQsaYWPoJcN5SGqMaVDonBUCRupHVH8=;
        b=Telsd8qZij2ucXPEwZOtUG75IT9Ti9SJOVelxv8cStOFCIpqzI2tZNSr4PF52Wfuxp
         JWQU7CwKMZ69Ts64NRX8ttBdIZ4IqJdHjHRnNxM2wMhKECtr9AxnutH2Usptff4k7uHV
         pqVXBBXgBINgGpQX+n0ToSn1J00ErRz7JADYOBIvo5/ycnMsmRw0wAp7j263H+V+1tLd
         URHrLKf/4DKR186iDxc2SWXewP2PosjEUqA1ClbWzRfLNaeRDig8gmzhY+RiA2U3yj6c
         FUrGC61TZssmqyH1WWdb7KhzJWQZdCae4DVvWVy91AyvznXeQOhRiDKgg7AounWpeQ/W
         LQdA==
X-Forwarded-Encrypted: i=1; AHgh+RprkGmgYiABS5fxL0J41cq+ZU0BxfhpHstjDp0SCaQiMrVs4ZIhM46GW7w8lIaMYo5tt5nQEOy4DeI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywn44YpNgtj5FDjjT7I5Uqs8yfRs5tH3z4p7j29QgKU7Y0ocvwm
	b6YoXityJ+Z2lnUX1pseKx5xYuu4gsiEsLTuh9Xn/ojKHsZCGkpz79b5
X-Gm-Gg: AfdE7cn/v/lK7gszIrlTSP+LqLRyKcu6WeKagg8UeB053ifHuFSI7Ei50l8lS+9wviw
	BhCPmYXEgbNRvjq3QK6H8N8Ae8cm0o5+W5kaQ1t4v0PShIatdb6QhSdqGbmHhNPyPjb3Mvt73lO
	cTlGVBYQ1XSW37g05uiKw6/0+ZTosGATX3/72iWBsbfDEji4OtFq15altDp3ALAY+kG0emEfex3
	9sFB0MBREsZvS6E/eAfxoE9hYmGAyx489GC462fQPRm8R0tAWHzXfuRx+C20aDn5qCsXnwbGpk4
	dVFwMq09AWwZTqHCHTCu7ohl+co32t7yYA2UaMY4woOQOjo4D2H9ulBqxs9wbpJ8GR2sUepj7vn
	ghVGMTlVBTLK/JNysxsRWYbNkkAO9KchUEr1JCR0YBNGyvw0a459jfDYKlKfo/0tpgmT7WitS9i
	bDgzveG7dGF2UuvOhyn4HiCxADDdUd3RLgm3JPppe/ivtXKU+/JJoyhJg87vsJTADHFg==
X-Received: by 2002:a05:7300:7c21:b0:30c:a1ef:816d with SMTP id 5a478bee46e88-30ca1efab13mr7496851eec.0.1782658712382;
        Sun, 28 Jun 2026 07:58:32 -0700 (PDT)
Received: from moksh-Nitro-ANV15-51.. ([45.118.104.214])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c944999adsm31307072eec.24.2026.06.28.07.58.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2026 07:58:31 -0700 (PDT)
From: Moksh Panicker <mokshpanicker.7@gmail.com>
To: jic23@kernel.org
Cc: nuno.sa@analog.com,
	Michael.Hennerich@analog.com,
	dlechner@baylibre.com,
	joshua.crofts1@gmail.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	Moksh Panicker <mokshpanicker.7@gmail.com>
Subject: [PATCH v2 1/2] iio: adc: ad7779: Remove unused completion field
Date: Sun, 28 Jun 2026 14:57:33 +0000
Message-Id: <20260628145734.77191-2-mokshpanicker.7@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260628145734.77191-1-mokshpanicker.7@gmail.com>
References: <20260628145734.77191-1-mokshpanicker.7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

struct ad7779_state contains a completion field that is initialized
in ad7779_setup_without_backend() but never waited on or signaled
anywhere in the driver. Remove the dead code.

Suggested-by: Joshua Crofts <joshua.crofts1@gmail.com>
Signed-off-by: Moksh Panicker <mokshpanicker.7@gmail.com>
---
 drivers/iio/adc/ad7779.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/iio/adc/ad7779.c b/drivers/iio/adc/ad7779.c
index 695cc79e78da..c1a99b4c1256 100644
--- a/drivers/iio/adc/ad7779.c
+++ b/drivers/iio/adc/ad7779.c
@@ -143,7 +143,6 @@ struct ad7779_state {
 	const struct ad7779_chip_info *chip_info;
 	struct clk *mclk;
 	struct iio_trigger *trig;
-	struct completion completion;
 	unsigned int sampling_freq;
 	enum ad7779_filter filter_enabled;
 	struct iio_backend *back;
@@ -852,7 +851,6 @@ static int ad7779_setup_without_backend(struct ad7779_state *st, struct iio_dev
 
 	indio_dev->trig = iio_trigger_get(st->trig);
 
-	init_completion(&st->completion);
 
 	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
 					      &iio_pollfunc_store_time,
-- 
2.34.1

