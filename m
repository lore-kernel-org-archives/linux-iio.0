Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795551748;
	b=QQHnqNks2e1dCEJeE9VeNzGpv1zpwUvGOtjZW29V84SxLaSwVgy27+LTJXwARAige1cn
	 2vW8JtDX1xY8IS8HY5yBhjpAAlvblJDTh/Dd4tvr/JOH5rxqRePoDHy0RCTkIk2WWfy7N
	 Iz6TWktGwD0Sx7djwBfmGkTvu21RVYUAf/dhDI5KoUKuh+kc9EKZROkmbmlDH8vThNRMT
	 PUkrybw5Ep+VyEJhPKuKVGPdv4OdLoNsPzT1cUrktt4AEykeGO7EHc/BHb6hZN0y2ojjD
	 8VUtkW1pTNijp/cXrsa1vd9Z4BrrbrEIUmHJLyglhe+nKBLwUS5O6cFcoiGspZpofXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795551748;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=+e9UoPHz2Rclxvw+oydXmBdhJXKaRdS1Zd9q7gn1BEQ=;
	b=Q5+afGnZsuQhsLzs3x+Smb6q08OE1au1aftRboeI8qRoSgHDZF5vrUHAlz2Vo/f766FY
	 YbhrskHXBB15MbBlDbZnxIuB/Jy/afk60du7YOG50VdV3nIsdhUanyb425qbPHMrekOLA
	 6Jy+7uGN7xWZ/S8TC3D1NGfO/BaNGcmGfRGnQa5cQfC+uTU54xzQ2uKhdDoV0XgFjYG0w
	 pxm6L71V22VPHw+pWmLYTCviruDL9CoQCd5D15UxxLJ7Abzkb2kzkUZXAQ2aZrzDuimOn
	 TnP0ehe3W7y14JkSi8cH5VhxJayDk6vZf8J0MibaQzQ82h7L9tadY9HYMBl8/WSP5NA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=teslabs.com;
	spf=fail smtp.mailfrom=teslabs.com;
	dkim=pass header.d=teslabs-com.20260707.gappssmtp.com header.i=@teslabs-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=QkmzviiU;
	arc=none smtp.remote-ip=209.85.221.44
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07808606A31E
	for <linux-iio@vger.kernel.org>; Tue, 24 Nov 2026 20:22:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 07808606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=teslabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=teslabs.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=teslabs-com.20260707.gappssmtp.com header.i=@teslabs-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=QkmzviiU
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-491f34b4e0fso2309238f8f.2
        for <linux-iio@vger.kernel.org>; Tue, 24 Nov 2026 12:22:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=teslabs-com.20260707.gappssmtp.com; s=20260707; t=1795551746; x=1796156546; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+e9UoPHz2Rclxvw+oydXmBdhJXKaRdS1Zd9q7gn1BEQ=;
        b=QkmzviiUMzmxjYNjShvRooQEisS3oaHHl7hmfxHKjsnewD+4ZnAEqLC77hPlZlwRxp
         kxd2lGnqF8Nvt5vc0rLYQA4teDKlmqVUlCNgSw0ceoPpNuwUC5xnIraz2sRE54q8TUHu
         URyX9bngJa5Ng1KQDzK/Fp0xro4FJYHDI2FNgQdGRvXELVMuuy/4KwDXQzrLcgOYARYT
         qEaQVNKKPvoCs2rz3RemC+U6A1VJKoaebI0zMuZJc3pGF2IIWUnmlFQ1QWzp2AlfM4q+
         33Ju/ldqUrtVj26BJ9GFJtHhGmCBlSuEFJ9q7k4mSzd77o15PgyY0kfwY72NNTPp0Pfu
         oxjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795551746; x=1796156546;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+e9UoPHz2Rclxvw+oydXmBdhJXKaRdS1Zd9q7gn1BEQ=;
        b=vJTH4iN5j+HuBnt8Hhxg0n+PPFZ5tsgvaXsGWuQR0F5IDkv6qpCYwtgtqYRfMTHiyN
         uvdv4up64x5kSvi4ooDj99Kc01N17d9HedGMc0A4B5uczQJjSTNLsoOCNQGL1Sw+7MFs
         A4DRiWwY47SqiwPYLfSFZJwJx/HAqoP9IU74vZjf/pXz5T/+gge4DgkA1lCQCLiXFdou
         qjKwhI5a4pI2CmGTeh83f5zHS7bRifXmb9qxCicAMZcvQMyfWzZt5EAWyCtHw+UQoHFE
         gUT5/FXBi20K3lTp1GNwgypD9iDVa2s3CRihKIstLfbZabHc0vnX5m10gSHz1gCF0vOA
         3gsQ==
X-Forwarded-Encrypted: i=1; AL+hErH7BblfAka7Dr9FjbGRpH7kJsWi8QwLM/7lbLn2qI97Lz99H9Gn92y5DoLGRcjfz0kKSgnuGCT63ds=@vger.kernel.org
X-Gm-Message-State: APuU4Z9CDAqWCuO/+74S27zOEu3mvFw/g7VxJKaBWWhZcDCrTOIcpHuJ
	X8J08AONdGMaMcEqyc+8iZK9h5QYWB+cmcIJ1CD1Ecn/NMXHgTd+Fw9DH/nySgg6/yo=
X-Gm-Gg: AZFdTZd3ijKubsC0AM3FiSgM1vE/rLZx4JvGk/1AHX4zyzO/ANP9GoLc5EfTyzsLG9s
	LcvGh0bZzr2DXaWo2AFw2djU1a8uPpFcSlMJdbbJVJCuiDlQvDZEXMPL/uC0OIxqLqfhj6SPyON
	Jk9Be3cTeehvJm8zob3EiLjptr+JozEzZT+nUPwDGWYhxPoPQEGSsidS3nx7jtIMWsUsCFEuVqb
	sUyl+zbfl3eUbg6jOxxsRoxqCoBOM4JF9d7A+LUUJnXtwzDyPe/dMUiYusyIo3qCH/8E42ExdFQ
	3WR4fqBc+znAwzgAUCJ1RhfSa0vIczxAZMWXokxZM+YHAMIimlMq2U+r+8TlEP3MfNheDCf6Yla
	Uph2yB98/uXnGQhoMjECqvy6ksCdVIkVikoxvlITIAIilXAU7JWwqCtqIQW2e7BzY0GSeA7y+Tf
	3QNTqRln4Z90M9s99tJsGmvxVhPVlcI7gcE77dAcqcT30mMeQR3hEqjEtqRvJS9kFSqM0bUrubi
	MmFzl1bqiZo0vy7uQpSIxNh/QT00DoRyF7n3Olr+sKPpv8fN0MKRlGDgrF8KsMUdh5+JNT1dDnx
	nNgGrTB7KabFG1QfOgyH+1i7RZzCo6IL40yv0s7kNeN0Tgyp55itR8iNVPzKnaBmIi3if1+4b4V
	GV29SXzdINFs=
X-Received: by 2002:a05:6000:299c:20b0:4aa:2bf2:4d98 with SMTP id ffacd0b85a97d-4abb0f3b4b0mr23117524f8f.29.1795551746271;
        Tue, 24 Nov 2026 12:22:26 -0800 (PST)
Received: from localhost.localdomain ([139.47.121.129])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6a67f204sm35130525f8f.21.2026.11.24.12.22.23
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 24 Nov 2026 12:22:26 -0800 (PST)
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
Subject: [PATCH 1/2] dt-bindings: iio: adc: st,stm32-adc: add temperature sensor calibration cells
Date: Tue, 24 Nov 2026 21:22:19 +0100
Message-ID: <20261124202220.23721-2-gerard@teslabs.com>
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

The internal temperature sensor of STM32 ADCs is calibrated in the
factory at two temperatures, and its calibration data (TS_CAL1 and
TS_CAL2) is stored in a read-only area, along with the internal voltage
reference calibration (VREFINT_CAL). On STM32H7, the temperature sensor
is connected to ADC3.

Only the vrefint calibration can be passed to an ADC today. Allow the
two temperature sensor calibration points to be passed as nvmem cells as
well, so the ADC the temperature sensor is connected to can convert its
readings.

Signed-off-by: Gerard Marull-Paretas <gerard@teslabs.com>
---
 .../devicetree/bindings/iio/adc/st,stm32-adc.yaml      | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.yaml b/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.yaml
index c4c4575d3fa9..9fe41b89982e 100644
--- a/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.yaml
@@ -337,12 +337,22 @@ patternProperties:
         deprecated: true
 
       nvmem-cells:
+        minItems: 1
         items:
           - description: Phandle to the calibration vrefint data provided by otp
+          - description:
+              Temperature sensor calibration data at the first calibration
+              temperature (TS_CAL1)
+          - description:
+              Temperature sensor calibration data at the second calibration
+              temperature (TS_CAL2)
 
       nvmem-cell-names:
+        minItems: 1
         items:
           - const: vrefint
+          - const: ts-cal1
+          - const: ts-cal2
 
     patternProperties:
       "^channel@([0-9]|1[0-9])$":
-- 
2.45.2

