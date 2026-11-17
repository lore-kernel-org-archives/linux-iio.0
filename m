Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794904164;
	b=K5BhFyk5g3mtd/d/9LEJn5fcTjaXH+wg/J4lrvieL3qslXyMp2dKKUZuTrj6pCUjo9Ez
	 9d2zktKf6M5SBM2umOWTdHTi74L/RAUF8cFGlDH5nVUqxQ0yss/MkbG5L4yLjagFeMeq7
	 N3Nq3OoYTGTlupeXg+QmimPtjs2wHR3UNgFg5cGk4ALOSF4cE6K8q+A+Ra59vX0c+3y0d
	 XbtSruqNabUGFklGlLi+lLMhwSyx7O/9Fe+uPfTW3aLra/Na+5tMBy2g7bxHZY6lzakQR
	 CDMDSMkBp027RhZIBODJoyAdvd28Lr4cbUGB5olbdO4GxA47fknXrkBOkNpR0pCJIWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794904164;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=6XcB4arin6kXu9NlMnDxTtU/2P/BU+JHWJo9WuFtq8g=;
	b=sDWXuS+AehXKwGfaZno87uqtU33hzVf7hlPGYafL1Fu03RmGNkTG+bdMTP9RGgLVfnY9
	 G3SWDtzpdTUIoBuD7mU+5SVf7iZwEUjK6NNuyHmB0jTj+lBBdo6z//Na7Alq7JS+8Uvaf
	 hRcYqpgv0SQQOeBEp39lXl8N3x9RN6g2HYlBAQZgNZJgLmFug7EijJCSIvSUXsBycLmjp
	 mVOWw0mWnzQhDmcc/tbVQIyU6UodEoILyB22Ke+BkGRlZIZmeNKIvvo772Q6gntWD3L9C
	 jseThg7o5my+4kO6YQKSspYQ7zpGr7gF4lMpOJvZYMQO/+9wWK4Pz7uFXZAmQOD0apg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qiAqStaa;
	arc=none smtp.remote-ip=209.85.215.181
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E626F606A31C
	for <linux-iio@vger.kernel.org>; Tue, 17 Nov 2026 08:29:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E626F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qiAqStaa
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-cdb45e96d2bso1896206a12.0
        for <linux-iio@vger.kernel.org>; Tue, 17 Nov 2026 00:29:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794904161; x=1795508961; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6XcB4arin6kXu9NlMnDxTtU/2P/BU+JHWJo9WuFtq8g=;
        b=qiAqStaa6W3hlpe3ZAs6sHR9yMPN6PLsFW6ZzeFt4hda0n5n3P0osrYWl5X/0kzotG
         3AhUgsj6WcpJa/336qEOZmnrk1tjc0SDDNmWLO9GkuF5LjWn/4wGGPsuPkXp7j1I6g5r
         nYivVY1sZdwguqOCAAG82rh/+4U2/l0D7WKTgOL/Vteth3vv33MHDNrdkwN5EKWrJN6V
         EeqdeQewBBaHS+lSytJ5MjCiFFetHqpmjzExNAU+dkUvG/bNSyi55ZvHf+X9Vlw/fczt
         Zxv5+P9rmnx8RRIEQ/jksaZj72uxFqhsjzbVwJWTgrglAUN9yly1I3f3SzYQ9q0KAoED
         UGgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794904161; x=1795508961;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6XcB4arin6kXu9NlMnDxTtU/2P/BU+JHWJo9WuFtq8g=;
        b=we+pqkJ27DENh6pgHx/1uCjf6bO4eM0GlIc3yT3kHK8/4ENKHVj1fXheY85FtqpT5I
         Kqq6BJ+FMc3CK59h6jTd+QIdv9A2G+b4exgHkyHu8RYigfPdlmNQ0KlXTZvwefMbfuC0
         a3iv9usw7cOAtVsqSXJNiss8K4glMDVksxsykcBn+sKGjFoXg8IUGE4PmMSP9vFBR0I/
         2OwIVakHZcACgY7C5Pu7BSzWAviYsEwgRHBoOiC9XHU08NsfOsUcMwXN/Zk4Or5foiE3
         KhjpbwXguiqdtOelfdfVVx79Uw1a9LVbS+9HcrmoBk/ALqxhS4lVi21DKF51My8nQw0P
         WrlA==
X-Forwarded-Encrypted: i=1; AL+hErFOCJevU3JxVbgAiIplG5/g08mJk/2GlvhPVgRGGlHxD0lqO4y0U787zlN9OvPtyJmG/8IWtJ3bZ/Q=@vger.kernel.org
X-Gm-Message-State: APuU4Z9VyXMbUhBPL/oh+b5smjG0J++7hWDaKFWxnhaO4eZ04AYp6XkX
	s+wLVGMIQ8lo+mcOKqD9ywVm8nn6+lyLycKEZ7hHlvde587ep5gUAmE8
X-Gm-Gg: AYBFou0Cwwl8fR+GWhMe2T7nQE6YBFKUQA1ndGeiLptadY3SRse55acAS8DyUEnfHwQ
	AZ/+5FsyNK5HB/wvP+QRRvVGytg2MAX+MUVTjJneQakrnJefEGKR6PB0V3DFkHoYuL9TGiKWlAw
	PbWO3M+O4o4P8GAtrUwj0htp1LSEMPFTqtngztN7gziTkxwt98KTW6bxq+Y/Sis+fWUxDck0fzG
	xmB+2MM4NhcPpNX7SUddky8u/8Ffja0ysWpdhbpcfUwps/hnSYIkLk1o+c9309XLZ60BykhXF86
	VC2pi4qnt4Hv5PI9S7QUij925RQrajJZXhrCMJTHOZTcAOrYVSOexBjMyEO+MlbNYxwc6akPvc6
	4Q2PniDtKtkNtbwnVLfuOJYiPxzGJt25RzrgjbIHe5VilfLQbw/jORQTPg2ni4paIjM4mlUuVbN
	1tSVrnobi8EB9u+NdlRN4Pw17gkDG8WK9oXn/gKUOQnNr7xhIORLayb+QKrkuT7Q0mKSFBk/tDU
	2e14r9znd2cMjCPfe6Kdmf3Xvp1pMNrxqLH0qR5PNUnm9qnn5jfIgT/QzycOsYUkA04bqzAjhD9
	ApBEAgZFxg2xq3po9O+hn2UGmirFLep+cul8Vl89oGNTsKwiu4YE35EmzUKdzuLu+fBkW77vSqx
	TnBuyxW5vzapAEm8=
X-Received: by 2002:a05:6a20:431f:b0:3fa:f6c0:331a with SMTP id adf61e73a8af0-3faf6cf78b5mr6473329637.61.1794904161230;
        Tue, 17 Nov 2026 00:29:21 -0800 (PST)
Received: from localhost.localdomain (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cddc18a2191sm5422907a12.21.2026.11.17.00.29.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 00:29:20 -0800 (PST)
From: Chi-Wen Weng <cwweng.linux@gmail.com>
To: jic23@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	chernyakin.victor.j@outlook.com,
	cwweng@nuvoton.com,
	cwweng.linux@gmail.com
Subject: [PATCH v5 1/3] dt-bindings: iio: adc: Fix channel property validation
Date: Tue, 17 Nov 2026 16:28:30 +0800
Message-Id: <20261117082832.1551574-2-cwweng.linux@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261117082832.1551574-1-cwweng.linux@gmail.com>
References: <20261117082832.1551574-1-cwweng.linux@gmail.com>
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

From: Chi-Wen Weng <cwweng@nuvoton.com>

The common ADC channel binding currently uses an anyOf constraint
to require the reg property and select between single-channel and
diff-channels.

However, the reg-only branch allows validation to succeed even when
both single-channel and diff-channels are present, bypassing the
intended mutual exclusion.

Replace the anyOf constraint with an explicit reg requirement and
a not constraint that rejects channels specifying both properties.

This preserves support for reg-only, single-ended and differential
channel descriptions while rejecting conflicting configurations.

Fixes: dd471a2b7759 ("dt-bindings: iio: adc: Add single-channel property")
Suggested-by: Rob Herring <robh@kernel.org>
Signed-off-by: Chi-Wen Weng <cwweng@nuvoton.com>
---
 .../devicetree/bindings/iio/adc/adc.yaml        | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/adc.yaml b/Documentation/devicetree/bindings/iio/adc/adc.yaml
index b673eaa5d072..f2a16b896630 100644
--- a/Documentation/devicetree/bindings/iio/adc/adc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adc.yaml
@@ -114,15 +114,12 @@ properties:
       Burn-out current sources provide current to the channel's input pins for
       open-circuit or short-circuit detection.
 
-anyOf:
-  - oneOf:
-      - required:
-          - reg
-          - diff-channels
-      - required:
-          - reg
-          - single-channel
-  - required:
-      - reg
+required:
+  - reg
+
+not:
+  required:
+    - single-channel
+    - diff-channels
 
 additionalProperties: true
-- 
2.25.1

