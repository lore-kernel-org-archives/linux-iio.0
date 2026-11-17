Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794903868;
	b=rI9Qk1igtBygF5+4+ct4G30RIclYU2eT/IXaDZyo98vs9hBzZUP+NSDJTTn1ecURuJQo
	 ijLOtZbvTFhqBrDmjRsN0LHjKa4W4D2ODCOiZaWUoHCYMl7Ka0RLlduuCjstKTi1Sk9nY
	 uth79Yz8jT7I9zw/ndQSnJWuMEgtZbYJy9OSkr+KFnBLf7ZQ6uv1pZmPPAxvvBWZZEDLB
	 RAnJKf4EcSg4RQ5IJ4TIEAC+lkvHKkjNidRHty2FL2tyE1kTVyrbZpEPb3iRtqtX9iNMl
	 6OLwq0VIorDSEHWOL9R0+o/sNHnYTRWDWaRxzpyOQXZvdfrhqrAiXDdNu98hF3Ry9tg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794903868;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=qnzy4BU7CFfQoiDwnU+oR7x0cJx2X4FyBHG/I6YKRMg=;
	b=x54R/llPZdLZFSw/Di4BkbADzeMnSo3xGRvW9g5hGvoK3DU9Kdj7sJWHLDgCgUgjjPhI
	 0ilgk1YKQY25WKE8CNHPpViNsc84Mj/JSnmJhl9gH0NYZD/9EPOfkwhOVpTysXAP8e8SN
	 Ti/YFbotU0VcPV/QKxuYicHR8JQg5+goaahkMEyUwc95gTOh/dIE1rndk3MLSdBrAHgKi
	 yCeTrtj/47Y6qDoI928MV97Eyik+1P2nxKqvDiK2wDgIvHpPXEcEjbQKgNUtzOOFWx851
	 7v++PGhSiZUqOG7LachEo5aEGHGrXhH+3x6Vra2GbPEYYFFP0NRUWPFYstamNEsyFyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fairphone.com;
	spf=pass smtp.mailfrom=fairphone.com;
	dkim=pass header.d=fairphone.com header.i=@fairphone.com header.a=rsa-sha256 header.s=fair header.b=OOSmJG84;
	arc=none smtp.remote-ip=209.85.208.41
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA13B606A894
	for <linux-iio@vger.kernel.org>; Tue, 17 Nov 2026 08:24:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CA13B606A894
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.a=rsa-sha256 header.s=fair header.b=OOSmJG84
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6b596afb4c5so4986738a12.1
        for <linux-iio@vger.kernel.org>; Tue, 17 Nov 2026 00:24:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1794903866; x=1795508666; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qnzy4BU7CFfQoiDwnU+oR7x0cJx2X4FyBHG/I6YKRMg=;
        b=OOSmJG84RijGLublSYWVTMpImlN/WVaYVWH8oU+ddcnl85mJ/nXFQyXqkaCNhDH+47
         KhPkhKvIgNqhs/kM6bF4Bjnb8RAXPDNiq+6SRu1e4EJd5VM2sQCBSKFGSnfCqWk9sOeV
         MIVJpk5h3nFj9f/1YrTEHJMEXcWrwO99d/pZ5BtX58KFjfbONFw225vcTxt9ec8AUS/y
         2axT99gaXokVpb6sSCIlV0RXDZWOkSp2aDJuhAZhA3KYRVANLXZ0bHRnUjRTl+KsPlKC
         aKx7YZKcZ3YEuWgllL/cLAeG8Fp9dk+/dWZQ1/7ZMIicNIKl+4smwKMlxNp6B8uf2lWw
         hoig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794903866; x=1795508666;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qnzy4BU7CFfQoiDwnU+oR7x0cJx2X4FyBHG/I6YKRMg=;
        b=W1DVsZ7WouIA3czmWLv9K6Mf7Az8Y+A+DeAVCsaZ3Rd4X0n8lAsVRTLWYEEyevFSPV
         nTRXSAVrUUfbCyQUXiLmi7ViTkyWDve0T8qZmWhLDGQ8m0Ga4QY8JiYHeAc7pPJZU6eP
         K2seqixRk2AfcMZs9SLqzwcuW4NQ8S+Gvj33HJbLgZsLaIPK2OAtPd5WpkqmiVle634s
         QQ1P+Yp0CmaH8RJI9zuDsbDdXqaN8JnW9u/Tf+iLROLZDm6Y2Y3S9jtR5pFdV4rRy6MT
         lI3i3VROgxwVtUDHDvOvk95fI2cjjYNgcil6OMgWG68EahDPR8UD0NkKzwC0S81vA3mV
         8eYg==
X-Forwarded-Encrypted: i=1; AL+hErEm1pfO93kV/CAgMoFj8GpUx6BZSbgPWaNlCPjHafFd8H58ZQumDVjT3qiUclXYl0fV27Pj7cPhC0w=@vger.kernel.org
X-Gm-Message-State: APuU4Z/cbLr6+5cOmPeSfxqvXTYmc4+wF3Nhv5bGgc2KnJZwOuF56doR
	pkDzuBZxEFjewPMrGtxEvSIec2kzzjutRkrJI8sest/9SM8+hToE0wy43jdZ5E1FYVw=
X-Gm-Gg: AYBFou3mmkkgOHheXjZTXwhUsiXQetVRbUOr8kqQC+k5b6uFv9a5iHC7egIy5mYq+zW
	Cpov9mNBAWxB11DCxi6oniLHHPXMj6J4/OYrmSR1W7dp/ljiWPfMClchyDYMzWPbPQLJ6TwL9PQ
	zygVlgI4hyYq0CCQ3SftlYOD9IibQs2huGsjZIhdSBRmZEvS7QEbyF9IW1q6WE9azswyeNgFGRB
	egr8HUqq86PfYe5RM00cLc4Y+MAV3JZdKdxhzVSvMMMvrsFxO1JjNIQWBq72TYaRI+L0+8FKB3M
	o5LRfC/JeF4bGmCKxTc2fXXanf95Aenqy+Wwb9b6cJnUJiX00v7QoimfHQjZ+OXorf0X9mTQA0V
	BUXQ38y3r5s8HxEdHuw9VAcjUXSv5jsQYjMEFovueea2zPMBZ2Iq7syofSPwzPlshx/fn1cF33j
	hRUEqF/Rul0xaXcpl94DKA75/p90AjOVICIo6R6TFRlLHywDNEcj/G0BGpnn4qpcBFIwS+49gL6
	Q8QJgpOSOAkhbuw39qdfq3b0fjpRrLmOCaPuSAeNk0pve2NdlPxRC3PmOnTAqF352BlzZc7s6k6
	35FlGhY//3TkkQk3JmHGXtvZ5YAlLSLjiPKehXQL7vi6pwQVU1SgN9ALuUbfx3NwxkThOcWHgVF
	7nJIcwfaUsJOkEzyaZ6NhVTv0R3qapAC1AikBtFTiGxAsGNL7
X-Received: by 2002:a05:6402:210d:b0:6b7:9ced:824 with SMTP id 4fb4d7f45d1cf-6b7c0c6f70amr9699533a12.26.1794903866141;
        Tue, 17 Nov 2026 00:24:26 -0800 (PST)
Received: from [192.168.101.179] (2001-1c04-0504-7401-4b2e-1820-6d24-b264.cable.dynamic.v6.ziggo.nl. [2001:1c04:504:7401:4b2e:1820:6d24:b264])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b7c23611casm5616953a12.9.2026.11.17.00.24.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 00:24:25 -0800 (PST)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Tue, 17 Nov 2026 09:23:12 +0100
Subject: [PATCH v4 2/5] dt-bindings: thermal: generic-adc: Document
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
Message-Id: <20261117-bat-temp-adc-v4-2-14d5d309ebfa@fairphone.com>
References: <20261117-bat-temp-adc-v4-0-14d5d309ebfa@fairphone.com>
In-Reply-To: <20261117-bat-temp-adc-v4-0-14d5d309ebfa@fairphone.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794903862; l=1375;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=I/NJZJX7ehckBNBNEstT8hdZRvbJ5dgDjnQjjzYNTLs=;
 b=Va/ZiG9pLV9kgIqnenCHkblc6VfgP1Axc4rzf1uTf/VYu24H6meIDJzjF7cPq8pDHyZN9T6da
 Mb3xtpa7EcBDjzIwW6JQazspouxo37NOrWeZduY4MV8OdBzf5BelcoA
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

