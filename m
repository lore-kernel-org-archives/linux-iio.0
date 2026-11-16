Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794862444;
	b=A31yDR9iKViFih4r4RxspQgqWhoEbNfj4f4dhkUOZK38WMKEWSh+2ygpVqnA+AiC69GL
	 giPOz5BJggYmkMosxK8jEEUb5DbyK7TAoe1jD/0tVd2nAUukTYq8dVz9APpyvEorF1V9O
	 IrKXHjZYMGm2Mp615X7oKRV1O0DgtnffjcsjLKlWVlUHGStN3W1L6SrDt9lh2TEIVwJZQ
	 RqcuaxhP1TphgE+AHUN5WlcSGQcSxwk3Xc6pU97AVI9qpXpMsZUtyJpd984AWu0xNckc/
	 K2reUkr2dGccnC+HrGcUWjoXHt9ppotAxxfn0NFiB5VaqjpoCB283jh6ujqR8vfDRWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794862444;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=lks8iSR/YB9Fv1EKmwN4RwxJYQhW1H8zwNcnF60o0Bg=;
	b=ay84+UICnZj1RLFrj4fBLHWanVhDqACjiLtbhe5Pos8M3YeyIQAZWppQl+aSZpJPa2BJ
	 eFsnOc5leRjPFtslDuH8QS7BA6FaFPhVxrbjzm51G09HXFPOtFIWicLdmCb1rUvdaqvjI
	 FGCyAvUCI15r+VlZDVEbUKjgpS8mrZY6KVhvsp/UayWyqJVBxwz24t5K9ryeV12gy6YWv
	 aWQHVHS8qyVxZs2a+P4UdK+V5gruU56aOLkeNfy0ms8ci55yy+KxBdRxVKTuK5MWG3rvV
	 Enn7DhpoluPBaW0TNbv4xtZJI7CROoSER2mLP39gI9jeRR+dyGJqtmoy16fMYUCTogw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=J2vettTH;
	arc=none smtp.remote-ip=74.125.82.53
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E7B606A885
	for <linux-iio@vger.kernel.org>; Mon, 16 Nov 2026 20:54:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A5E7B606A885
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=J2vettTH
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-1a8cc11ac42so3921914c88.0
        for <linux-iio@vger.kernel.org>; Mon, 16 Nov 2026 12:54:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794862443; x=1795467243; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lks8iSR/YB9Fv1EKmwN4RwxJYQhW1H8zwNcnF60o0Bg=;
        b=J2vettTHgsS3OLXWhZpK71if72T6oJJ5C9sEEdbna2c8iwlSnH996+tXAzKcgCa/MK
         i6BilnY49BHNkt8TGEXFgyEMbw59KzEqMejO5gKAJx1oAoBFE+x/5LmhyiVswt3dJj2l
         HCKhHT2UKcwBSgrR9t02XBj8iYFtYC0/ntdcytpJJrd4BXG9E3J2xpMEoP0KIag3sJet
         paOXKI8MBwKyNp9VFZXUHoOMIs0b6nHqwuKSkqFJiM1cu+XBfQScuCSQ4+hyY/j0+iuc
         N/tfv44r3j6lFxSGEmHIs+lZyMiQFyOT9GCtxOUbx/EtdZ/JzTGuVooHN3y3j+wkm7fX
         S17A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794862443; x=1795467243;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lks8iSR/YB9Fv1EKmwN4RwxJYQhW1H8zwNcnF60o0Bg=;
        b=hRIQlYHv/DSzacwP/RWc4fNDZvcVbivL+Qjfq0cyhFiGI2QSJYHMHTHVrzA1l9oqZn
         yi0uh9W2p1VghNx1kMOA2rQ92DngcEQq+tANXx4Slsgo0k5nPxOd9SNZ9vRGpmZZoGNB
         Xz9cYTDXSw6OxdZWUNtRFP/nV92EuJGLHcohaJIxirirGZWA/iCwJFcY5O1qs4TH3wHJ
         FHLJT0yqlSSRTJt2PGP7SdKAQ9MnQ/PQTbNmdk4sPSZx3CBHZu8mARixaP8VhaTr/zgF
         XPNNoKjxwsS8EjBJD+Rijy2RbUhQZiahOYC4haIZRJMI791UTDpN7FAVpbCCWn7q9P+g
         BqPA==
X-Forwarded-Encrypted: i=1; AL+hErGhWi95nJ+CnF79m2kZmhWq13U551X+E37Xv35oqBuHrKq3SB4aJTqV+UpZhLqzqG2himeN0Qnrjc0=@vger.kernel.org
X-Gm-Message-State: APuU4Z8NJyMCQIRJIc3q9NSi6hH4lIvLGqAkTzhpn7fSL2QFP+fPq4nb
	stkxyn/C9FkPGOF2TaA5eZt1ElTy2+oB3oyFdg7M6+EAKuDtoIvqsQaC
X-Gm-Gg: AYBFou0EJY0Mv/ddbcMXM9E06hEQFQKTyu/xrZetFRVdKa2+c17w6C0V806ubqY6Ip9
	d6f5vnC89yW9SYvqTmtNQQdJAnwwIqFS4jhSJrTsFf1jEWD6VuUcFdU7TWSuS2gC6OTYCdF0sPu
	fVcuQRHY54TSZWlwHX7EABi9X3pEfZPIVCxvA1xg2S3gHEwg/VJij/RP7IdVpIpK5j9gSQOPTx5
	bMiiu6uJG4wej9CJnr2pqViocjtNPex8AIiLq+NxH0j2+VVm+1Gf5LihgcyKTGqXj+B/PgtEkkO
	5ATD0vkcTJ+MFJKff93tJcry4SReKUCyg4G/B0WzRgficOrTzUVECf430p0UlsFN0ArksxLmAnt
	XTmHNApBbaUktu30Hea06Um7tMmdTuCdZG/6M1tpCf5JrBBkrX3hzsQy2je73CJDQwsZLVYoWvq
	ZQc5/NXnD13mpShHST3udWoRiyYIOJv6SloKvtJXoPlNwXnEAiasp+3JOysrjtOG9Q0g/LhacKw
	DWN0qXrnWWJ0xOILvlbdalCMSgwdi5arV/iP8K0PzLCPffk2luqWlLIajBjzLdOs48wGnu9biun
	i//TE4XsaVkDa4YX+1TwrMnc0uw4byEPt76athTUPs7W4MSrPLGlupi83u0BX5uD9f4XQdXbY4R
	SO2+hhZ4ZRhopJTuPvQSedgYNjOf5K2mH1OEgDikjyMzQP4Dbg9wYFq8VL4/7gZfTzOBNXwEK9U
	Gb/tA4JtsWCCKS1IeV51pTTbs4f7yGDk+bxyPC5EjCcQ==
X-Received: by 2002:a05:7022:130a:b0:1b3:beea:eee5 with SMTP id a92af1059eb24-1b5030613cemr9666041c88.1.1794862442632;
        Mon, 16 Nov 2026 12:54:02 -0800 (PST)
Received: from kapoor.iiserb.ac.in ([203.18.51.239])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b524049e0asm15293497c88.4.2026.11.16.12.53.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 12:54:02 -0800 (PST)
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
Subject: [PATCH 6/6] iio: proximity: sx9360: reject negative hysteresis values
Date: Tue, 17 Nov 2026 02:23:14 +0530
Message-ID: <20261116205320.26070-7-kapoorarnav43@gmail.com>
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

sx9360_write_hysteresis() copies the value into an unsigned int before
comparing it with the threshold, so a negative value becomes a large
one, passes the "val >= pthresh >> 2" check and sets the largest
hysteresis instead of being rejected. Return -EINVAL for negative
values.

Fixes: 1cdb4c47f7f5 ("iio:proximity:sx9360: Add sx9360 support")
Signed-off-by: Arnav Kapoor <kapoorarnav43@gmail.com>
---
 drivers/iio/proximity/sx9360.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iio/proximity/sx9360.c b/drivers/iio/proximity/sx9360.c
index 26190f9c6c1f..9989b0dbeae0 100644
--- a/drivers/iio/proximity/sx9360.c
+++ b/drivers/iio/proximity/sx9360.c
@@ -529,6 +529,9 @@ static int sx9360_write_hysteresis(struct sx_common_data *data, int _val)
 	unsigned int hyst, val = _val;
 	int ret, pthresh;
 
+	if (_val < 0)
+		return -EINVAL;
+
 	ret = sx9360_read_thresh(data, &pthresh);
 	if (ret < 0)
 		return ret;
-- 
2.53.0

