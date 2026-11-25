Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795616627;
	b=jJ1zElWyRvf1lIiZzV5dNS8csc7Zy3UTz/pDDz0wI2Yb0sp3E9l2CDvErT1cCazaZ7mL
	 DcFNwBhvsuf9aJOJ0kZwSxOa5x8Mfjhe0U7F2MYSjaOOpmQ0tnugLIJJbAoxf7xsApYcB
	 L6YdgJjcd9oE5nTv6pZso7RoIgEXKn8Ycw3KpJesh1wK36XSEryvS5CU9s/jrSkutLohd
	 0idYjzBVdeQ4UaK+5cLLAxbecPn6tAx1XUUJaVhGL8T3jZdxJTozjjiDg1Mf+vAd0BjeH
	 LeW5DjbPZMrElgZJwBX8L9HHwL2P02CITPrM47BlW7USLA95jIjX1RyY1sbz57cnRIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795616627;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=Ny39IB2+v/C8PeHVkJtEArwIrXSQ2C53NR3LzL5C2wQ=;
	b=Qjqh9XhCl/gd2wQUAKBVYa2q8nDW+T7QuFSfPdWpW9E6mqh+/5h5MJNmT7XkXtZ6lEku
	 yiefTmoPodXDM0zAeQB/Gsifa26xGMMI81nGrv3gMMjal/r36e/DO7XfD7nYiwwdMG+N2
	 flWaEYAuDOU5i7eBKC96moUUGuVrS3g2y55aOB8iSctJscbItSJzpTNzIW/ZgH1MBO4UD
	 jCcFmKlv5xVYGg347mRgAPDhyCMIGaeP3+FG8gJI9doVpnk1w1FEyus5h1JZLMJHr3R/K
	 cReoXkFtDHq7vqrM5lI5g9lEgH6CguWMVFwc7KRcwtja51n+8GnGsYStGPwxx1voWqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=izlRGHSP;
	arc=none smtp.remote-ip=209.85.221.47
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C5FF606A332
	for <linux-iio@vger.kernel.org>; Wed, 25 Nov 2026 14:23:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1C5FF606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=izlRGHSP
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-48e47347279so3530659f8f.1
        for <linux-iio@vger.kernel.org>; Wed, 25 Nov 2026 06:23:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1795616625; x=1796221425; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ny39IB2+v/C8PeHVkJtEArwIrXSQ2C53NR3LzL5C2wQ=;
        b=izlRGHSPk22Pur8KnK80kIAy9Me7FWkb05DdT2sFdYCSPlI+/bTGF27iUjHjw+Nipc
         X3MKhms6E4YCZM/I2CdXMBy83WPurlDASiPn1RsO/1SKm6EWYtxJU3VY0Rj2/3ygjY3i
         FL4gzAG9koSN3qQF8HhR71CAz15ItOYTmdqwUUe7x0d112vku2Whlbnm33QUK5oIQVjM
         9pcCFBCvZkfdTj7yUOcLOjwWvevosMHHPyFThtM2vkA8ZQ815jFJGM8LHyoGJwZiB/fh
         eTrv1LCuV37cVTlZKdIvzsBd4W3tTw1AwjMF721yFpJuQqn+HNoVREFfR+Qtc4j242/c
         SF2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795616625; x=1796221425;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ny39IB2+v/C8PeHVkJtEArwIrXSQ2C53NR3LzL5C2wQ=;
        b=s+nAur8yi4MeJMgmbcssmDjKbQzKfNlLCuWb0S3Pd4O94euYkTcbZ9jH2fnkgnEpvZ
         XBKRi9yoHrOMlP6OLmcuhC6/3+DiS/FzXOIlI3vNAlteWFtr03cZAJ5k9cR3rYu6VzKl
         icFdewD3q0v3xHahIHWBMq+h/AEsrz4agmikaOJHvNw268ajY+PTTBYkZDkTuZBxWJEE
         jd8JZQzt35cxrRJNVadU7ihlT1nL4fugEnCB4A770ybaeMBFb5gu3KMkZz9/OhG9fm4K
         7dq0vD1g07R5WQTMwp6JgMx4H/OBc7zVZp7Lz95zv6kNEoiige5OpqExWFtO5Zu4qjKY
         PORw==
X-Forwarded-Encrypted: i=1; AL+hErH5kPjmNMKVBAHznas1udjWRwRx/IDDvfPik8LCJC1KR+bGyXRbDL6h+Ux9mW6PO0+gRYFfgUfPecI=@vger.kernel.org
X-Gm-Message-State: APuU4Z8mlvbH26HmH1mlLibsuUvi2SuX+cnjl7+K/noqqIIDx4KNLmeT
	V0YIguuqSNIRVVnFTTUDeFhP8GgjYdDZHfy5/8rSGImBudstAQ7Q9HaOBAqQAm5Q0o4=
X-Gm-Gg: AZFdTZfF2SRPr4mojmNa2v1rF36C2c/qGRiqY3vwT1zv8NsP7ot/JDT5STrCzKexhIU
	EmF9Wje2XeRirzc/e2+UFwKmh566ymL9BT/T7+dVX0pFL+bhTht5Czorb0cgD4ilGOuZKO332Iv
	+m3ZH3pd47KFZPMvQ8ngvomxKEavZfm2pw6njy707Va7P4lKDFiPOck6QcuvWiMXGkagSoVpU4y
	+La8oO0y0fhMyzmpBrez6BTs1dNLLXSyHNUo1hgb3MdyKy0xyeMJrUu/SRjYXG1BIzEkk0k7AuD
	LI5BIwmW3z8tFcrcXx0hZttgTU3sI3oVSRUKw2ZjPR0RQy4MsRuZSXvVwvA/VFFzuEsJ3vPDjJV
	cFWfKFHSC0kDGtbhUWR9CR5HiiEWo2njS/7DuEYJQb+wEOOsoKloe/tCDyYZfHDSRDmG3iQx85N
	JiVU+5hGcHZP5BZz6Yv8lZIyrW0Inpek11RIU/FWQ0QHUlQLlPVWneLj0vZC96Paa4d3QRkS1yE
	fhaHBjvL2f8dhIoHLGKnQlkTalMtZaGDZjfFwizJVipgb1/eygGRzx9iXNMCt0DzvxtLWzrs4gJ
	SxgTuFRqx3KF1xypV9GMldHfhhsYYLm23vj2M00pjCNGSI4V5HarP1/fDFFvw6qRR3pFqVHJ0RZ
	ulNHV/Yu7FK7jEqgQj3CBJA==
X-Received: by 2002:a05:6000:2883:b0:4a7:a52f:a2be with SMTP id ffacd0b85a97d-4abb3678d88mr30767537f8f.13.1795616625424;
        Wed, 25 Nov 2026 06:23:45 -0800 (PST)
Received: from [127.0.1.1] ([2a02:c7c:5e34:8000:720:5dc9:500c:65bb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6bc8ce06sm33638667f8f.47.2026.11.25.06.23.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 06:23:45 -0800 (PST)
From: Alexey Klimov <alexey.klimov@linaro.org>
Date: Wed, 25 Nov 2026 14:23:37 +0000
Subject: [PATCH v2 5/5] arm64: dts: exynos850-e850-96: add soc thermistor
 node
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
Message-Id: <20261125-exynos850_adc-v2-5-26de1c6f1717@linaro.org>
References: <20261125-exynos850_adc-v2-0-26de1c6f1717@linaro.org>
In-Reply-To: <20261125-exynos850_adc-v2-0-26de1c6f1717@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: Sam Protsenko <semen.protsenko@linaro.org>, 
 Sam Protsenko <joe.skb7@gmail.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org
X-Mailer: b4 0.14.3

The WinLink E850-96 board has a Murata NCP03WF104 NTC thermistor placed
near the SoC package die and connected to channel 0 of the CMGP ADC.

Enable the ADC node, define a dummy 1.8V regulator supply for ADC, and
add the board-level thermistor node linked to channel 0 of exynos_adc.
Regulator is represented as a dummy one because we lack PMIC support and
should be replaced with a real one when PMIC support will be implemented.

Reviewed-by: Peter Griffin <peter.griffin@linaro.org>
Signed-off-by: Alexey Klimov <alexey.klimov@linaro.org>
---
 arch/arm64/boot/dts/exynos/exynos850-e850-96.dts | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/exynos/exynos850-e850-96.dts b/arch/arm64/boot/dts/exynos/exynos850-e850-96.dts
index afef32ad4ee2..1abae8b9fa49 100644
--- a/arch/arm64/boot/dts/exynos/exynos850-e850-96.dts
+++ b/arch/arm64/boot/dts/exynos/exynos850-e850-96.dts
@@ -126,6 +126,14 @@ reg_dummy: regulator-0 {
 		regulator-name = "dummy_reg";
 	};
 
+	/* TODO: Remove this once PMIC is implemented  */
+	vdd_1v8_dummy: regulator-1v8 {
+		compatible = "regulator-fixed";
+		regulator-name = "vdd_1v8_dummy";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+	};
+
 	reg_usb_host_vbus: regulator-1 {
 		compatible = "regulator-fixed";
 		regulator-name = "usb_host_vbus";
@@ -166,6 +174,20 @@ rtcclk: clock-rtcclk {
 		#clock-cells = <0>;
 		clock-frequency = <32768>;
 	};
+
+	thermistor-soc {
+		compatible = "murata,ncp03wf104";
+		pullup-uv = <1800000>;
+		pullup-ohm = <100000>;
+		pulldown-ohm = <0>;
+		io-channels = <&exynos_adc 0>;
+		#thermal-sensor-cells = <0>;
+	};
+};
+
+&exynos_adc {
+	status = "okay";
+	vdd-supply = <&vdd_1v8_dummy>;
 };
 
 &cmu_hsi {

-- 
2.53.0

