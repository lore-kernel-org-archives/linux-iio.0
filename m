Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795551750;
	b=S9vkvJbTDNAGnoMjKrVFmx/VQOdYYVkgogtrtymrhBZHrmjC+8eeiwPLzX0PUhUzQhRj
	 J0HcDhQcduU22rsLJgNsb3sHWzHJ/w1HDnWX89fwT6HhjJrSH5ShQ0L8Vu4gwSR4nqiwB
	 eQ5/0m5fUXFXCrIWfLla8+UhZJx6Z1RN4b6mbNSxNYS927pk7C4NrmrNlcPgq+bi5Zduc
	 lnX9MtpvD226cETkPvesnpkeylbtCQNm/eWzD3DQn6Hst4Go+XeQtuPcNDasvJhShe8x9
	 Qs6L5qdDXaLJAlc46P5xiec9DgLWoNOsrwh0odJWLL4S1VcbH8qQX3GbUTai/DGX9QA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795551750;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=LkNrwFCbU7RrRsMUzm/3wayhycT9k1ANM19ohVyL78M=;
	b=hVo9bBL9flfdesVUHjcIkrDq9sUHn9LUP4gGwUWrn2NbQtSnoIQdwt6eerMLnkGMx1PX
	 sVjU9T7iEFBg/+59LFS/H041qtBhn0GgdI65Q99OFI+evscHs+QP4LiNxOEEdLYR8gHFI
	 nsKtBTAq3Zn8vBrOpdRChyHp0CxEgOzv4qt9evRhihBNHFRlG3E7jEhq5zUVSvcwDZrJH
	 pTrf7lIG98kyySIOEDhStftU1foeAgHYDTMbWzO/RmQ2AC+/Lj3RKIZJmJO3m5xXx04uc
	 JNi/fDkMhyqA3tEY3EE3CnCBtzkOwn4nO96hG7YOHSkuStBZJfHmopenvddUAWBhoOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=teslabs.com;
	spf=fail smtp.mailfrom=teslabs.com;
	dkim=pass header.d=teslabs-com.20260707.gappssmtp.com header.i=@teslabs-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=jpihGz7J;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A824606A329
	for <linux-iio@vger.kernel.org>; Tue, 24 Nov 2026 20:22:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2A824606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=teslabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=teslabs.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=teslabs-com.20260707.gappssmtp.com header.i=@teslabs-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=jpihGz7J
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4bb70074ab2so54058475e9.0
        for <linux-iio@vger.kernel.org>; Tue, 24 Nov 2026 12:22:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=teslabs-com.20260707.gappssmtp.com; s=20260707; t=1795551748; x=1796156548; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LkNrwFCbU7RrRsMUzm/3wayhycT9k1ANM19ohVyL78M=;
        b=jpihGz7JRlpV8tsAAy8CKNKDq7hkZiDyVYqQNwoLCPSdb4ev2rvGCevESt4CGvU6E0
         U0MPcr+aXgKbhxXKMRxzs+dEcExjsq9chGoERlKpQW+JeHyhbV772JKUYg7K5QAlFhWK
         nYoxekOISw0CUeutsCbiLanTX77nXTZQKuLhfXVbn+DFJxyuphFOKptoOd5k0Qqw48hr
         G7qX20SuS6l/vOLPHEsNW72sLjP5mc/NxmVdNGGUodKnDW+A8BVIcOvZkZpDHpMmD86f
         ia8G0poBnd+6uZbpq3vMRLWA5DIYuDKJcUNtQqDdGixC7B9fmoeC9TZPPrLGUfNB93kW
         jKpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795551748; x=1796156548;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LkNrwFCbU7RrRsMUzm/3wayhycT9k1ANM19ohVyL78M=;
        b=Ccmu8sy4xYHOC3XMlhowrEgDJvfWGbGga3ebU9OoWNWClSvZJQPg4Fw4fz6eploOPP
         gY7wb5ZUhktfH22Z0tEZY5V92tneXcg5Psyby9H/+Ic409UlFDIVrZyQYstv+hm1lYUs
         xER0z+l6Ea+h882FbUOxJgOkIomAW6StWQL01ypinxiBoV1dmu13X5OXchduBRD53NXo
         qS0Qcp28/njSO4W6+hgiYnXnAI6ajLMRbJalxvp6NTyEKvuHahRUy14KDwLTsC32roAJ
         MTFRISKhfecXG4/PNgfqwquJk5cWEIsGUlNWnhwlpcJgGJzEIhPXMqFZXKSygESb61se
         fW+g==
X-Forwarded-Encrypted: i=1; AL+hErGFZHG3llfXNhhgMIKUFAXM/WCtV9ryYh54rDoX3DIwxHGl2yflY1VNvZm96dT4BuUHt46AI6BJI/w=@vger.kernel.org
X-Gm-Message-State: APuU4Z+koXABevd+WES9/njhLhVT4CpQ36lpH2oHzWS2TNyQlQe5CMBO
	suzYwiW3DpRa6jksI49FPslgOEJ1chC2sOkOs41qDgVEhryFHeYGA6b7LgIhdJIVZF4=
X-Gm-Gg: AZFdTZd4T55ocSFo9qobrlGNwoba4JJIhhzUQ9etcDuJpO5Xpch2L1eT4BczoUF4czj
	laM7Sg+nSBNi7kggEVCGeKEZliis7qhaxQYjps0QUy908WGSplUJUCJ6xO1CRoZRVAzmvNeEr0C
	roY49cUePre00VXw3Sy2a18weKbBNVA/mPndCSCOwCCtE5IX3f77QQrc/Oc8AKhw50rq3FG63pB
	EgCEVpltYRQNLH9pKLjE65Fd03WvYjbvSbk1fIw//Vp8KR26nKNtNX2kwSR6AFdMGyTpXbzrtFu
	WPoY6RfSwjfFC4/Vr+gFdIByoOIEmG+oPcHpYCApakDEGlxu6Kgj/CoxAvF8w0NiP5hUKLKnR+U
	HBa21KopSvylAih7ckGGn2xX7a+yX5a6KPUoXpcDHfWTu0Lueg6SDpeZeYz9IdCvAClEdcO0Cts
	pVCbiT0jxyNk6JYQN4psOB3oqv+mb8OiTYuAtgVbofgI5TWqln40EHM3rXkIxwGZBGJOHc1YbbO
	pMvQlzzK8QlO/AXy5jyacmMe+HgMdJiu4yZkYup7BY2W4hnHMXeNGXS0n+FFDzN6bRyIePylPvv
	Tdx4vNw+I+Zl1OZIaxmCVzl9yFyoNYLspOnXLheoPElzUL1qkjfvU4+arhUOEJGz9ft3pgfYb7i
	V8BEwZikqfaw=
X-Received: by 2002:a05:600c:840d:b0:4bb:6814:738c with SMTP id 5b1f17b1804b1-4bb88820cedmr326668745e9.22.1795551748576;
        Tue, 24 Nov 2026 12:22:28 -0800 (PST)
Received: from localhost.localdomain ([139.47.121.129])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6a67f204sm35130525f8f.21.2026.11.24.12.22.26
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 24 Nov 2026 12:22:28 -0800 (PST)
From: Gerard Marull-Paretas <gerard@teslabs.com>
To: jic23@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com
Cc: fabrice.gasnier@foss.st.com,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/2] ARM: dts: stm32: add the factory calibration data to stm32h743
Date: Tue, 24 Nov 2026 21:22:20 +0100
Message-ID: <20261124202220.23721-3-gerard@teslabs.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20261124202220.23721-1-gerard@teslabs.com>
References: <20261124202220.23721-1-gerard@teslabs.com>
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

The temperature sensor and internal voltage reference calibration data
of the STM32H7 are stored in system memory, at 0x1ff1e820 (TS_CAL1),
0x1ff1e840 (TS_CAL2) and 0x1ff1e860 (VREFINT_CAL).

Describe this area as STM32 factory-programmed data, and pass the
calibration cells to ADC3, which the temperature sensor and VREFINT are
connected to.

Signed-off-by: Gerard Marull-Paretas <gerard@teslabs.com>
---
 arch/arm/boot/dts/st/stm32h743.dtsi | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm/boot/dts/st/stm32h743.dtsi b/arch/arm/boot/dts/st/stm32h743.dtsi
index 2f19cfbc57ad..ecb6aba3b0db 100644
--- a/arch/arm/boot/dts/st/stm32h743.dtsi
+++ b/arch/arm/boot/dts/st/stm32h743.dtsi
@@ -70,6 +70,25 @@ clk_i2s: i2s_ckin {
 	};
 
 	soc {
+		romem: efuse@1ff1e800 {
+			compatible = "st,stm32f4-otp";
+			reg = <0x1ff1e800 0x100>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			ts_cal1: calib@20 {
+				reg = <0x20 0x2>;
+			};
+
+			ts_cal2: calib@40 {
+				reg = <0x40 0x2>;
+			};
+
+			vrefint: calib@60 {
+				reg = <0x60 0x2>;
+			};
+		};
+
 		timer5: timer@40000c00 {
 			compatible = "st,stm32-timer";
 			reg = <0x40000c00 0x400>;
@@ -572,6 +591,8 @@ adc3: adc@0 {
 				reg = <0x0>;
 				interrupt-parent = <&adc_3>;
 				interrupts = <0>;
+				nvmem-cells = <&vrefint>, <&ts_cal1>, <&ts_cal2>;
+				nvmem-cell-names = "vrefint", "ts-cal1", "ts-cal2";
 				status = "disabled";
 			};
 		};
-- 
2.45.2

