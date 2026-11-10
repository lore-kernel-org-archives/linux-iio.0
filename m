Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794325381;
	b=r6ixVe3IOlKS1ACproom5bfS7nqdP8+gw5mEhTXRm/LjaInn/FpdgE7fXXoQcGt7T35S
	 NJZ9omBdxQjsrxYPaAkXRlvstmck1HYo6wxo54/LICFKV95JMK5XwKnVzoosU4SFHcam2
	 obFQwqoSPuMU9H0DFJWG2Ubcx93qusY1etpvkvnbLrfzl4vVMeqJtaGsi3tHfa5g5w1l9
	 9xLRlzJd5IPsHPeHCanpKISDgzV6mEHLI/DHn8XLGjF9vyFk+8Y5BqMwuLzVpsHw/PKfv
	 Ds2pwYkyPqjnJgSs2aiI/WEO+yOkbGCF1n4f5XoejEDXF/sWj4wAD6s2J9noEW+PVhQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794325381;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=mcH0VH9d1TflRVvDyREb8NEQ6oBVJ5eOfoPTcpv7Fok=;
	b=nch5aZEXJ0OAKe+7p2dZOf8NO1kd05hj+nhIBbrH6CEExvTievpcP3PcEic+9ocrJZxM
	 iFqTERnokCcVg9KVhAoQB7eI/mQ2f5DjksUqhEm/lp8aPFTGiAisnKMPjdyG+ClNBVoOc
	 WlvFj0fEGfAVSapObBGChi1L41vZbOKzXaegd/ckhRnLxLD3PSCnr2PpdTvoyuLwaGT7n
	 IuuHpzjw/67BVz3MDW2WOQEQGC12XtkOlAA6drWqj2cBc60rXBcoVMPcL0Y+GOPW++8PM
	 ojLNq3YCYYwHK38G1yjkF3FEcTjDa7MNuzctSFFCn7KpEJw5bnWHKyLhRc9BvsVbxdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=juPNybO9;
	arc=none smtp.remote-ip=209.85.208.171
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819DC606D761
	for <linux-iio@vger.kernel.org>; Tue, 10 Nov 2026 15:43:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 819DC606D761
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=juPNybO9
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-3adfe77d336so17046741fa.1
        for <linux-iio@vger.kernel.org>; Tue, 10 Nov 2026 07:43:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794325380; x=1794930180; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mcH0VH9d1TflRVvDyREb8NEQ6oBVJ5eOfoPTcpv7Fok=;
        b=juPNybO9ob3cWcrZLpGvPTYrhVk12lb5syJQk4janFfUd2bd2ELKI82pjVPIWTcz0B
         PvncSwO8k5BJg9+a1rWN+agfrvu7xWYAgGv06+hhQuwu7cOKId5DsTYN3pQ3mH9BdOrg
         8YD6u91iV+RBapoG4c1sk63alTFIJUMGy+W7cnEVyc/MbixacMqy/HiOM1TxHvwzyFTr
         KNMoEmLyCCJYaR6LfSS542oid00zkMjstykGx8JNKFmTjlJA2Gz+rnnVyTP34OlVNy6U
         EdF3edsZ4t618mW0x09KicJsr0Pdh81Ed2BuV3olYmf+dJIFb8/4+yeGLrC/GoF3DIxC
         Azug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794325380; x=1794930180;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mcH0VH9d1TflRVvDyREb8NEQ6oBVJ5eOfoPTcpv7Fok=;
        b=1p7MQDS93ryiOH3RFJkERQVSWj8r0pfv7wxQzdbJt0qEU3FfyXoNYeZmL3X9arlk6g
         5xk8T5zx8d4LwDX0bCpF5rAOe75H95KPmQJfSESk7pYGcw6LTMF+BbRVEQ4LVWUcfhy5
         erS4xJeev9RoVzbmLzYj0F+7Dhix4o1tJKu1MiUKsWBdaMI8Qhr3yP9LOfeCtfZIEl8y
         oxZkhPCwBTPpU/yGLu42zUot6OdYYd7iWsSNV9fAh6SOtDBf8X50bn7sQaXgTVmDYAQ6
         Qx8NlKb/n4H+LiiFu6jxA0j2nlPo6h3fI4hIhqmDnffAT+ywlDJVYqttd2XnZYkNcccw
         Bklg==
X-Forwarded-Encrypted: i=1; AL+hErHVurNfhMrqVxo0yFQht4vLuPjH+UiCS/zgaS5y5lhoWlvWc6OQxF+La8dC6ZldMLFDt5GZ8u0mRIc=@vger.kernel.org
X-Gm-Message-State: APuU4Z/6jdXQBOh04+L244j7yvNgoworEP7Ye7jVvtKpcsQWUl7zvtoJ
	s9fALXPJ8qqaw+BPv+7jYEtOeydxvyi9IBYIircs/wXKhzvtMyUA0tUS
X-Gm-Gg: AYBFou0FaZCo35L/HGqf39OyAj7isU0qM8ELUnXcYpxQOzijfQN83BMIb6pffMqN/vM
	wL5yzopSnMWYnVw2c7sxjjQqhgwXBLDdLAMVuFKG5jwCS7TaPMDI1x2iShKT5QgMGmnMGiCGdFR
	PWJv02rPvocFF+mjZRRkui6k1wwv+KDefGwtG5/ZD7HVPja1tXShuFWpykOVyo3hHhtFt/LNuNF
	+A/toMghlWJLfjKqFK8BCuILOr9XcWtVi3uFixtYfwCgM3yn7z/GsPgP16DCQxcU3gKGJpyPGI6
	2U6ci/YQnmaOaLZT7/zC8u0fX2cjLlTn5uzbeemhd/XCHs+aSwmwTLXAsU9mfug6OpD1Hw0ItW5
	IUnBay9XPHpQ8L54g1PzYoDvvuTHIm2e0e6cOD/vWIFUS6a8fwvFnpiYCfq/+K8agLyTnfVAzoy
	AAnHKoBeOD/2wpOfd1Uglf6KRWLjyxjCmad/n46Q7LUZVAilNqkiZ8SV320QyE+yVs7rI3h1qI1
	DwrXGiKXJ8Lqty2J+cjqL1xGaEkcihwnbrKYUzl3rmqNUw/dNxzQhwXqSFPJerD2PTOhKE5oI0s
	DgFNTVBdiysvF1kXsObNO2WFq39fot39iyW4QMOq6J/n7z3XmXPj2p+hUGgUc6qu3zNVwEz/CmW
	H4o4QUfeJW1gIiHHE0rvpWfW/iJPJTfpXrh/UtA==
X-Received: by 2002:a05:651c:1608:b0:3a6:10d4:61c4 with SMTP id 38308e7fff4ca-3ae0964783cmr6048041fa.28.1794325379385;
        Tue, 10 Nov 2026 07:42:59 -0800 (PST)
Received: from yantra.. (nekmmqt3kfwnocz4ivv-1.v6.elisa-laajakaista.fi. [2001:99a:d7d:c300:453b:19fe:80e1:2b9b])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3ae0923d583sm5751481fa.21.2026.11.10.07.42.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 07:42:59 -0800 (PST)
From: Rupesh Majhi <zoone.rupert@gmail.com>
To: Andy Shevchenko <andy@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Eddie James <eajames@linux.ibm.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Rob Herring <robh@kernel.org>
Cc: devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rupesh Majhi <zoone.rupert@gmail.com>,
	Paulius Zaleckas <paulius.zaleckas@gmail.com>
Subject: [PATCH 1/2] dt-bindings: iio: pressure: infineon,dps310: Add interrupts
Date: Tue, 10 Nov 2026 17:42:53 +0200
Message-ID: <20261110154254.39092-2-zoone.rupert@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261110154254.39092-1-zoone.rupert@gmail.com>
References: <20261110154254.39092-1-zoone.rupert@gmail.com>
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

DPS310 signals new results and a full FIFO on its SDO pin. In I2C mode
the same pin sets the address LSB, and interrupt polarity must be the
opposite of how SDO is strapped.

Signed-off-by: Rupesh Majhi <zoone.rupert@gmail.com>
---
Cc: Paulius Zaleckas <paulius.zaleckas@gmail.com>

 .../bindings/iio/pressure/infineon,dps310.yaml         | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/pressure/infineon,dps310.yaml b/Documentation/devicetree/bindings/iio/pressure/infineon,dps310.yaml
index 416117dfd927..cded6e0af147 100644
--- a/Documentation/devicetree/bindings/iio/pressure/infineon,dps310.yaml
+++ b/Documentation/devicetree/bindings/iio/pressure/infineon,dps310.yaml
@@ -23,6 +23,12 @@ properties:
   reg:
     maxItems: 1
 
+  interrupts:
+    maxItems: 1
+    description:
+      New result or full FIFO, on SDO pin. SDO also selects I2C address, so
+      interrupt is active high at 0x76 (SDO low) and active low at 0x77.
+
   "#io-channel-cells":
     const: 0
 
@@ -42,6 +48,8 @@ additionalProperties: false
 
 examples:
   - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
     i2c {
         #address-cells = <1>;
         #size-cells = <0>;
@@ -49,6 +57,8 @@ examples:
         dps: pressure-sensor@76 {
             compatible = "infineon,dps310";
             reg = <0x76>;
+            interrupt-parent = <&gpio0>;
+            interrupts = <17 IRQ_TYPE_LEVEL_HIGH>;
             #io-channel-cells = <0>;
             vdd-supply = <&vref1>;
             vddio-supply = <&vref2>;
-- 
2.43.0

