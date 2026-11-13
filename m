Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794585903;
	b=Vnbk53QkVZnuqoVzgRR21/OKN4bEsf/KQ8s7R46pSdpKsBy9Hylb3SGbU4ddQZugYHlc
	 yD/WwkZ9BDq9lCHGt68HEUnJTTshsN326itsPiIsWcXghKuwq943U4otcP7RTKayeV9gI
	 V71AmG7KjauS450tNvPbumXgk6P8IFrcnXceUm/v/0czIZIfTnuQsdAt9Qci9yO1V3MJA
	 vBSHrZezKJMMKdJXIDdVihUICwfHZ0GO9LQPQ6IsmuaZE11CSy7w+Z90GhwMB7Z1C+g2J
	 pcbsaUHOBxqDfQ+b+BTR2bpDsxN+xuhh/apTQeq49/XXqPi4bSCPmScJG3NqVrTjDWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794585903;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=qnzy4BU7CFfQoiDwnU+oR7x0cJx2X4FyBHG/I6YKRMg=;
	b=bvM5PVhNRSEM0uslLbf0f4cWLa1TiyF0stQweQHsC96ouiaXF4CK5W2hXK8RrIm+6Fa+
	 Vx8byItGoeSKoVbf+dxRbifcgGy7TBUdwGwmZc7y6nq1pRCyib/k3fM0jfcMMEwJSpzZu
	 GA152by0DZrYeVknYUtvgrOAELZWKp00nByIjYwC0kTtwnoa/66AVANl2oQxZHrp/5W/v
	 4qRYlCQ+gL5i/gc5H2VFjMQ7e0fe6BHMxCDjUEXCq+NJLCls0MTbE3k8VO58YMAoPUXxx
	 lpiEr3k9LHNlAcbnGWDmCVPA/PvuG+sKmYd2r3tV+CpovQsbzOgE28Btxc4us1DEYrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fairphone.com;
	spf=pass smtp.mailfrom=fairphone.com;
	dkim=pass header.d=fairphone.com header.i=@fairphone.com header.a=rsa-sha256 header.s=fair header.b=NXWuRo4o;
	arc=none smtp.remote-ip=209.85.208.54
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4B2607094A
	for <linux-iio@vger.kernel.org>; Fri, 13 Nov 2026 16:05:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5A4B2607094A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.a=rsa-sha256 header.s=fair header.b=NXWuRo4o
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6a642495d81so2201258a12.2
        for <linux-iio@vger.kernel.org>; Fri, 13 Nov 2026 08:05:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1794585902; x=1795190702; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qnzy4BU7CFfQoiDwnU+oR7x0cJx2X4FyBHG/I6YKRMg=;
        b=NXWuRo4onYFiw2I9QVxX5OPcgg0tUYOXHsV+WLZ1UsLq8W44JTs5HZvfoNvfPYwfqZ
         aVOf4cZpXSmdau56AKXJsV6WLFeanx3/L6Gy6RdjXG+kl/zXHoy4cJaHlVW/zPs9kBuO
         oemMwQSPJYV6h+bJqG1F2EHGrXxt0dOlLnWgwF5Ulcpq9oM3p2swIXKrikcx1BuL3LKA
         qkXPq+g8+NN0qbt24tDmj702nIBntuPk1JB/r2+AInsFcJ5NXND1Shy8zA+xJm/itwf7
         6pWUpFjQRQUasOfYu6ayS094qOl1VpxnYcWG7zeE1bwzTUM3WF9GOAAo4Y/Fbxs7+9Rr
         ydCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794585902; x=1795190702;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qnzy4BU7CFfQoiDwnU+oR7x0cJx2X4FyBHG/I6YKRMg=;
        b=cFjwdtlDiAOSKgfJrNA2t5UlBR4yok7oifdgvoWBeWqqy82wOxvzcwF9N+Q6WUR9G+
         lEvd/27c2WUxXJHoeNTEDwt5hKeebms+ZNywk9qAitplIxoZX9dZt2om+yxwinmGEMbh
         v/BugTaAK9nQ2r6L3g1M0icdGVhiOxlaE1XIzfqEdEqkqn0UhpEQe9kiXbWsqKaOIuB2
         oCoVK+4d6HQatSN2u2YWAQbgl9MEa0cHkbNO9kziF7WcgEVn8pac5X76Jy4WXxQXvd9U
         bJefTUhLovfmJoSBCOCzhA9BvbXuq0B5RyfTsRBkiBE9zORhov5LawK9+0fMkyuDc0PU
         IrTw==
X-Forwarded-Encrypted: i=1; AL+hErHocv0QJikd5hSVQTTRQEC4fKmEa+pmZtUfHBx06F/Xl5PTTqmGxjnIKFywtWFMpwVE9qs9rTZi5Yo=@vger.kernel.org
X-Gm-Message-State: APuU4Z8gOMNVxVTSvaTDNnWGrDG1uvFwORYSJ3kgprLjKrjrMXiFwS6w
	bHPIoJ0d+NEE9GyFDjmoGWCFXEjmfgXqTEJVUSGfNVLBLQDjeZkP9k6tgZbosz/nVqM=
X-Gm-Gg: AYBFou3KnzMLnmuEbIz7jShFle7XCAYHFUHmawtPsfhCNqViEJvRYTjEb/fAWWFMgeM
	sd9XXYo0OjCLmy08WSaHnjK+xy/Y6dBDg/31noNc/Fpw8sd6hvCoUO+1XautpNZeOt3d7gVKfEh
	pZH3VEDhSs+KE2ej2Ox9KLzMjivgZHt8KRwUqdaOG3kYt3yFTXtGP9CUOM45tn+078QkfjULNT+
	bUPraRlrTsKOYL/JUxbW1aED8Nqmlbbg6IqEEX+QcmLWPNUWS4Yfdgf1R+iN7Naxcm+vxS1hv+f
	N565zQX6NyaBw64KjMsailIbNg7A7NPXma/iWCJEK/zQ80VOerriC3eQlXs8joFPUg+4b9kSWRH
	5CSZ5y57JwYQiTR4TxFtwKFl0KE0czhbdTbo8ghwRIu3HRAxHqyvoGQ73b4fN04ioA5sG0B4A6P
	SmtECfjYIF/laDhJnxAE/MKZ1fgERjbjYEcDmEdz2ojQ2trXXzEDTLJjUbnkCwW0U4F+yriAd+j
	2wLx8YqVD/JLhxFq5JwjZJRoX3SXIM/jAu8S8+y9CKcBOACXJb8Bx6wc1Py6C2tHBhH3nfjSdpS
	ClNaUjAe/RYSZPnob+KIvEk8eRVI88ZwqTNpDwVUQ9+iwmouKEshGquc9/D9R/ektvr9kmRoEHL
	cD24k8M4=
X-Received: by 2002:a05:6402:c6d3:10b0:6b5:8719:6d51 with SMTP id 4fb4d7f45d1cf-6b7c0c1661amr2023087a12.32.1794585900329;
        Fri, 13 Nov 2026 08:05:00 -0800 (PST)
Received: from [172.16.240.104] (144-178-202-142.static.ef-service.nl. [144.178.202.142])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b7c264d99csm1123946a12.36.2026.11.13.08.04.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 08:04:59 -0800 (PST)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Fri, 13 Nov 2026 16:56:43 +0100
Subject: [PATCH v3 2/5] dt-bindings: thermal: generic-adc: Document
 #io-channel-cells
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261113-bat-temp-adc-v3-2-743979a8fd90@fairphone.com>
References: <20261113-bat-temp-adc-v3-0-743979a8fd90@fairphone.com>
In-Reply-To: <20261113-bat-temp-adc-v3-0-743979a8fd90@fairphone.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Laxman Dewangan <ldewangan@nvidia.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Hans de Goede <hansg@kernel.org>, 
 Jens Reidel <adrian@mainlining.org>, 
 Casey Connolly <casey.connolly@linaro.org>, Val Packett <val@packett.cool>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794585895; l=1375;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=I/NJZJX7ehckBNBNEstT8hdZRvbJ5dgDjnQjjzYNTLs=;
 b=Ht22iLsedKZL83BN0JDY5PWcB8ObVo0t6BTxz26Nw19xpDmgxebf+ud/QHUeqUQWi425ecQ3+
 SxCjc8QTNEyDHbneK6kZJZLlWO3P5cfHB1Ugyxv5BwyqSTZWKUV7rxS
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

Document the property to allow using this sensor with io-channels.

This means that the output of generic-adc-thermal can be used as an
input into a different node.

As a specific example, generic-adc-thermal takes in an ADC io-channel in
Volt, outputs temperature in degC, which can then be consumed by a fuel
gauge driver to provide the battery temperature readings to user space.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 Documentation/devicetree/bindings/thermal/generic-adc-thermal.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/thermal/generic-adc-thermal.yaml b/Documentation/devicetree/bindings/thermal/generic-adc-thermal.yaml
index 12e6418dc24d..317fc39ed46a 100644
--- a/Documentation/devicetree/bindings/thermal/generic-adc-thermal.yaml
+++ b/Documentation/devicetree/bindings/thermal/generic-adc-thermal.yaml
@@ -24,6 +24,9 @@ properties:
   '#thermal-sensor-cells':
     const: 0
 
+  "#io-channel-cells":
+    const: 0
+
   io-channels:
     maxItems: 1
 
@@ -58,6 +61,7 @@ examples:
     thermal-sensor {
         compatible = "generic-adc-thermal";
         #thermal-sensor-cells = <0>;
+        #io-channel-cells = <0>;
         io-channels = <&ads1015 1>;
         io-channel-names = "sensor-channel";
         temperature-lookup-table = <

-- 
2.56.1

