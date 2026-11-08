Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794131009;
	b=JPT6eB8onviy86wCtyCsaIndGQmVrId0uq7BZcrbXSjL+N93tPugkZD1BrmM+fL7XuHb
	 0qgwiYYJBGbp1V/Yqqe4wUaFXWEPNg/k4S/71G9SY/20+6PPX5JbReH7c38V8dP/8oQdq
	 +Y5hawCksnYB/FvZm97xrZenScY6OUAQlS58dOESsG4cEnubgeGOi6YxQocOjbDUNi8cZ
	 ia2LuMF2nrsUObQfB9/2m1biRgJ4pI8AumQcnjxpwtLdmI6kBWGfMHrLTNrj0hRy96hnJ
	 veRFKk8aM9rFgj80mWnr6xmfPeMaLNqV6wOQcb8gb6NETctxPJjS/ySl4sB6WHYilNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794131009;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=g+JNwiCu6bm0rcLmuJWSYeAtStEl9n5lsa7a5i38a1Q=;
	b=TOOTOvlhB7BmKvrFE5D+Gkbx/J3tQs3faM7Q6nDMHW1pJHnAzc1Tv0bIslXfN5kNAs2U
	 gI/qHmy4oVdF0HxWl2Tm6aksAOXSP1u3HV4Zf7sP/H2BnxUi9C2GC2KbpNu67rIC7ZdHD
	 pTrWfqLmloi2oGt5DvvmJiiUYcaZ0WPgPMVhx3WZc+ug0oXB4f6Frk+KNrL1Y7T2suxFH
	 Dlhfbxyw8cKmxG2q2GHc1L2MJWLvBzaGTXdDqvL47oj3x/iHPHTPk37QYbAlfGBJHmTz4
	 9ySiyfQkLBaZZpXaZ/PDu+htCeU6pe/BmKZBUj6/dYIDED5IrgjMmMoUQ4FDPpUmSlw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=waq5Jg1J;
	arc=none smtp.remote-ip=209.85.208.49
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B772606A33A
	for <linux-iio@vger.kernel.org>; Sun,  8 Nov 2026 09:43:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1B772606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=waq5Jg1J
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6b587591414so17299a12.0
        for <linux-iio@vger.kernel.org>; Sun, 08 Nov 2026 01:43:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794131007; x=1794735807; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=g+JNwiCu6bm0rcLmuJWSYeAtStEl9n5lsa7a5i38a1Q=;
        b=waq5Jg1JaS41DmS5x9j24tn4y6UrddE8wBQdKIUpsgUBmu8gnbHKLIY4QLb0KcKjMw
         1Dm8+xteo4Kl0L+sJ+l/GIKcpGAC1DXHMzPZwEdOsOR0su+Mn5LOL6D1aEXBshD//TY2
         Y4QsTZSakwnVUOKF0/AwVj8kAZtdSfZ3oHLfDWg5eWdO4gzqH2mUHt+LGK8PSm1T+7r3
         79geyjJJZQuhJkyxUVZ4zOgQMezN3fe5nVYLk0AOcvCfR45wVwnPHKLSKdurO1+6Wkjy
         uPI1dywmmZTwJoYAmr7yIIhnPhAtt4wKs/lO8Q9Nk8gshaov3CBp9IBTd3OoB2cncv6c
         c/Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794131007; x=1794735807;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=g+JNwiCu6bm0rcLmuJWSYeAtStEl9n5lsa7a5i38a1Q=;
        b=KCm+PDS7x4URKSCrSunAEVFNVTFi9QHYgpVAM/XdMrxNcNibELEp97SP3ZHENmtBI0
         kxqNrYAsD4whhZmRhjFSYLGjxIPZ4iMQ/Bj+ehaZeX0aUxARqKKPkqS7dG5ADmbpPct+
         PWbVJD8CeXBBQxMB0AjlUI2Npaw4d0S4ELr7Vmbl6FehYofptfG7vRZ4HHviy/xrXiv4
         96lNnUQBTuc43Dw7NpMKG9s3KEjuud3WLzvXkPhTbQx0wtY9tvTyGD4ftsG1EaW17RU8
         +BrS527s3BZnTMn+M6ZzwW2j+J100nTeACp9jRJHfpx8bUlHa7T3ZzY9KcWcuj9bx9Oi
         tIag==
X-Gm-Message-State: APuU4Z+V4qHkAjOu7nDz3VR2bEfEMRNu41DdRxNqGgBFd95LaYvuV7LQ
	bZ7ojz47zy1SIUJuIe/Q/9SEQQcwHoyA5mxs8dEl2qdED5s8a1FPtN5e
X-Gm-Gg: AYBFou0BU6Lca8ZxIxL74H/w3xGoy4eKZhk4JjRXi0CArbXsIt6MUN6ozDuRgc16lz2
	x50eeVnL/PNR0Jz5JromJB/30PqRzNHr2wUj5gdJckci3NsJz8BQx8qBPvjKlSURnET/XTN98xm
	ow92g1e5YoBfNmwX8hUH1Y9LgatG4p1VLzzv+Zw8Nb9spIOiN9nS50YhqZghgjQEtxiDshBYHu+
	UdNB2YxzIJtvKHOMVAib2rxFmCG+YADELl3gDd3G9aR9Y1wZ8dat6ci2TX5vdBDvULr9nupe2+3
	7harxBtqjfPeAWqKQr5hyY3BxnM04+NTPT/uedJWJnfde6/D2YS/+9aNtSKShyKdQTWz7wcT/Og
	sO/m7FBGyVfetEcJNgPdKzhaRb2MfMNDxxzG0Q2ETsUGgeL4xoNL3oWTsp75ynT4ggTYSneNjEK
	gElz5Pd+zXo6voDHwL2hqLxUEaUoEtlTm1mcOwT5KbcMcsdtjs2hm0sSDVJcah0GL6fxQrqQ85F
	SaIAsrLXdXtFERlOwsu728Ta9CGunE+ebdyY6gz7Or+ba8T8PAuKvCAQEyv1T6Bdb44A/Bv1YS3
	Ls8v0nx0BYO0UTFY3c/GOnTH6mM9DJcmmWh0xgQtSaZeP3Z/98RWhM8Img6ecRbXRQckySwFysC
	4rzdWzbXP7A==
X-Received: by 2002:a05:6402:518a:b0:6b6:eefc:ae7a with SMTP id 4fb4d7f45d1cf-6b7223c0e17mr600130a12.4.1794131007486;
        Sun, 08 Nov 2026 01:43:27 -0800 (PST)
Received: from xeon ([188.163.112.62])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b721ea56f2sm436321a12.8.2026.11.08.01.43.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 01:43:25 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Esben Haabendal <esben@geanix.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>,
	Pan Chuang <panchuang@vivo.com>,
	Hemanth Selam <hemanth.selam@gmail.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Nikita Travkin <nikita@trvn.ru>
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/4] dt-bindings: iio: light: ltr501: Document LTR659 proximity sensor
Date: Sun,  8 Nov 2026 11:42:52 +0200
Message-ID: <20261108094253.83899-4-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261108094253.83899-1-clamor95@gmail.com>
References: <20261108094253.83899-1-clamor95@gmail.com>
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

The LTR-659PS-01 is a proximity sensor similar to the LTR-559ALS-01, but
without ambient light sensing support.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 Documentation/devicetree/bindings/iio/light/liteon,ltr501.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iio/light/liteon,ltr501.yaml b/Documentation/devicetree/bindings/iio/light/liteon,ltr501.yaml
index 20abd7da080d6..85ac3b540c206 100644
--- a/Documentation/devicetree/bindings/iio/light/liteon,ltr501.yaml
+++ b/Documentation/devicetree/bindings/iio/light/liteon,ltr501.yaml
@@ -17,6 +17,7 @@ properties:
       - liteon,ltr329
       - liteon,ltr501
       - liteon,ltr559
+      - liteon,ltr659
 
   reg:
     maxItems: 1
-- 
2.53.0

