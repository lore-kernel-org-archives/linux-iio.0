Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793956818;
	b=OsuXurXv9V2yKHs5VGJ0M9sxNMoJ3QgKTpKnPO05rrGXhLnUSw8pzDI6eztytFrSo6hh
	 jqCnf5/aZz/GedBw4AyvCV4k3ZuBfppzaH9kkcq8KVbKaVHBnBLXqKojrc6HadoMF/1cY
	 faE++bN0QqKA6iGvPIUv78mFhJilp4aJtMRgM0cfJI8cd+sr45Q6RT1ZSUlo1imRfIZmw
	 FlrxphrOA35bQhxKFtDbixKJBPFKr73KfsYSulg5OwXULBn4sF7JNHWKmHHvjZwFx3a1R
	 HIr1WH+Yv4efwDpojBPBqklthNRJt020uRC+NKDBkPAiwFFWL4IMmy9Hj4GiGwoi1Dw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793956818;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=xu7FC3Q8JkhKAZXkmoQyecqo7Y03cSTT/z26JLOH2q8=;
	b=qRTCn9qWpFljUvCMQAwDab+j1qVcQyxDfCnRZk0k9OcAHja4WiKa1p+AU+bbah4dRE5d
	 Y8k9S/MIwFCzxmZDoB5ltfQ4oO9y1F6gmPVCBqfWlcjlxzxBN3eBJg+hwVPAy+3ebXzhB
	 LErLk7Aygg4g9W3Cyx7Q8TRFuRObu+bran6CeAsbC5zgVf1YTkSSF3+jzl1SEl3Vd8aoT
	 V3+yPh5T/ATicQ8McD9SFy/Sx7r/cuRzveyDkfh/cdiblgDaFaHwgXA0zQI3omhCASlE2
	 hns6+Dn7FxPz0B9h09fszxfd+yvqNKYyOt8kVcFZoe9A26NjK2Q9VZaJjr25Q5ZhcGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oN93Xil6;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0010606D838
	for <linux-iio@vger.kernel.org>; Fri,  6 Nov 2026 09:20:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C0010606D838
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oN93Xil6
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a2069b9710so3267335e9.2
        for <linux-iio@vger.kernel.org>; Fri, 06 Nov 2026 01:20:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793956816; x=1794561616; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xu7FC3Q8JkhKAZXkmoQyecqo7Y03cSTT/z26JLOH2q8=;
        b=oN93Xil6UfBn7yVRhg6frgSrSIimFgqT44JhM7qqaPimBhIWP5FBUZFJkH+KfzHsgZ
         2SLQnmaAStlJcdtt00AdNoLKpHgC6fl5p7Ml7m7Q+2AkatDQYyPZJ8iwaRsZL9twxKR3
         81tb4SRPMpBNziBbDUcidG0uKjjXEiGk+zoGZCh/gX0+Vx1abnP74JwqEAaXqdc5g1gS
         zdFkhDe7CPMRRpxsKmzwYUXTTST3k/RzVaQL/Tj8+PQrvXCCrhIcyO0wiW9/BX8QbwkP
         QQ0LD54NiFGhmcOnDdJlDKQXXao/roCWrl5WZrg0KzT8ydxhHdvmu88vvR+EMCE15xed
         4maw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793956816; x=1794561616;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xu7FC3Q8JkhKAZXkmoQyecqo7Y03cSTT/z26JLOH2q8=;
        b=lpNTWfXy6YGVjVWDzQeWy9Y0jpIyB1AhAgCmZnzIiv7t3NsZ8C1OkOGti+seQR9qc/
         9WS7gAdjI4BRUF6XpbQTWmWj3a5UpCzD07d/6+T2wpwdtMNbTkwCxA66UinDCOOykwNa
         I5WmQ2adMe4iTFJEEodbMifg31Kc9zH+ASn+DK5wXxaK79sXNZdjgWTnQpXFWJKTJH65
         i5YlIABHwA2F5MOHaZLMf4rI/72gfu9NFtRsV1LM9QT6St50xbKNKGL8ZUJV4XEmhs70
         5aeK64SOB69T3HoChZXNndzTfldR0gN94hM9BuuTrftKhGzvpqDfjweyxO/WI1bIwJ7q
         jgiA==
X-Gm-Message-State: APuU4Z98Bjw4BFGxMz+Fg4EyMK4TywmVEFr+La2qCRB55sdodc8XHyC6
	EsPaTxpHltv7GAYz2qXcLKvyEn+ktDigwLeEuJP/BA8b5qyXRxqrsZrn
X-Gm-Gg: AYBFou3aZSNYhQNNNS9Wx+8SjFsoJugoOBzHIIJ6y5GzmKnTOBUGP1Dz39RDovup5TF
	kIUAbynWzc5EXQctdgrljmZ5D1JOF9LwN5bXBoFplvHsSWaSCwg2Wl1UYtGcNXIhh9g04kAf+YU
	59ObCAYpZO0UmQUeBp6exOPwR8C8RJumbmK26Es0ocROEkpOFAWSAoHmT4KRLo4BZW1nTB3tZV3
	jaxq+zZtteS+UQa1z8jPemirIDIYmQl3vseSCAwq7G7Od2PqnuELmgKISzrobvDIWAqT1jSeqHg
	EPPQ9sggQTSJHwHM7DEw4MID6Gf8nQBGWtdKTDcTFEgGE6ClxdX+MnY601RVbuTpVogDbI6fFdR
	U5vu3dukLMGsnUMUEAI0eFH2CeaOXw36YdJw5vtJ5eHPmQ76XPUUMgf+xhCVp95WP2egD9YZPT2
	Aco8TKz3O1dT+C6mVEgpetzld9HFbNrCer+2/eme/XDVrSzFnJ/PmZ+Dfdo94C5uGdvfXJSyh5y
	gkR17syjlDAUinoi1HzKD8Lwa0Kl+goKXF7XfbQz/qPFzWC0tt86LbBVUcTFqPf/P4XriO6Oo8z
	/NBH6KCfLrh26ttgirHzQG4+ulBbMyYv6al3+P90R/1YdmXfKfWaHjMwYPZQs0usLfapen8EHNp
	35wmdDlVapQ==
X-Received: by 2002:a05:600c:1d0c:b0:4b2:612d:908c with SMTP id 5b1f17b1804b1-4b6df9beb91mr29536225e9.34.1793956816082;
        Fri, 06 Nov 2026 01:20:16 -0800 (PST)
Received: from xeon ([188.163.112.62])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b57203a98fsm108358935e9.4.2026.11.06.01.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 01:20:15 -0800 (PST)
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
Subject: [PATCH v2 3/4] dt-bindings: iio: light: ltr501: Document LTR659 proximity sensor
Date: Fri,  6 Nov 2026 11:19:42 +0200
Message-ID: <20261106091943.35783-4-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261106091943.35783-1-clamor95@gmail.com>
References: <20261106091943.35783-1-clamor95@gmail.com>
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

