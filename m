Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53E2321F5E
	for <linux-iio@vger.kernel.org>; Sun, 25 Jan 2026 13:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769348598; cv=none; b=tkAuKv3c2/ggy0Stgt5+w5FZvNMd824HGtSF59bhB3Rx8Vre7qCAZpSZ08FA5G+MXbp0z9//aq7puDDyCVX6T1UOfO0Nu8eC/cV/lSA7S90glHrq7wIotu/7MAB55ZuToWic05HPM1sRo1wgH043yqfdnfNqHjXoI1pjl8+LcbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769348598; c=relaxed/simple;
	bh=hHWILRyUU54F+w7k7JPriQ6DmoCAg8TcBCDlQKA/teg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vBr6p18c2LOk5SF6LGGpZHtgo1PZuDEsc0laQFjObNi4fyHtjBWJ2vvZFuGmfqkYHNSDfJt5LYUKZRmXZyREACtiyyTlsJ7QWYOkvdVaRSagDLK2XRAXqzVUIqwMb0stbQ63L808OJyiEagJGvk+51J+Ywvmh0dPg8zVDnycH08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KkkAQa8p; arc=none smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KkkAQa8p"
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-432d2c7a8b9so3626141f8f.2
        for <linux-iio@vger.kernel.org>; Sun, 25 Jan 2026 05:43:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769348595; x=1769953395; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SM6Glg7veqcWlsyKtZF2bdqamcvshEMVFBWJQkCFRkQ=;
        b=KkkAQa8pk+K6A4UYfw61ESplTSO1FwqHE9aWvDVpOPFwJQUIV+ln1LAaxk9fNgE+/R
         YhbIncZI9Pw98gLno0610Y7X0NQoHNoQ3lHfnAk0iibeXhmb1IPqq9KG/c2Zf6n7Tfwe
         qN9bfojsh3di8hOMJZFAS6w6/EzcXzB4Ee/+VZxVQN6vlvLxwBcn6zaNniQ/CYEiTmtM
         0JWww2zno2CHh8zFkVEJQtdgqYqIPwIm19S8s+kbceNAumA5ImVckrxzgGXsOcBSMdId
         gNJKd9WT2DQGKHYKDbBwrA9RxSpjEeVvgJCCofbrCLUI+79fEISSdkb4VOWNcucjMD/K
         Ou5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769348595; x=1769953395;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SM6Glg7veqcWlsyKtZF2bdqamcvshEMVFBWJQkCFRkQ=;
        b=MBqLKJ4K4mBH5CQ4JGNM8GeC5dWJsf/hLnovvMvBqW9zbjZFpUF+kNgwWrpfyYJnqv
         CIDiOxXMVhfTZq5ypdmcGPw/Z/qaJQaeyVPZtaPtXimJ3/z5GnrFU9nT4mHD5+GT45gm
         k5Vzo0wQjTLdZyT2fAFuOAxwvo/4244Rqb/DttdclgBy2NgH/HwfwOhxrnrkt1jpzaZD
         QL5q0gusU28KEqzBgoWg8xhTZ1F6Z9yE7MWxZIJjC7jFFcO+L6LJbsWi6jrpY+gDPiYU
         bpYeM17xMIphlmLiS4CuFB6xPwM0NseA7IViQQutbKd556gBISqD40f+0OONIRbU4dLa
         Q6Ww==
X-Gm-Message-State: AOJu0Yz2HcSyOxtQcbZyJuF4UumvRdliLJBKYOIOQLSWFUBtV7KjkC6Z
	Y/+aOmQ6+fFiBHn2lCq2D5qeHPThs6isIWE5SOEBwUErtbBo5vha6s9J
X-Gm-Gg: AZuq6aIb3iEeST8HEsT6w+ElLV/LjjIZg8MD8ElD9bLDER7ho7xeIVpxOBZOUTeanG4
	MS2ZHcwdjPHXhAzI2AkAY2bRItxQTglUDMTm3zJ7vOaZ6yGmqety+0fUfoCiNALWc+dl7yN/Nac
	iW1Ldvs0qb4CjtCpT8xyRTNUEb7lGmFNsTMsSlMKf+ixRcZaIkslGUeSG4bPEJWbZLGLWDLd0fS
	d9jonEO8UujiqTW3EYVuVkSMBOvYF7Bloyxn9S7TchkB098vLibfpgU4k0s3o9QozI8ngi7XdJq
	CKTkAlSSE83Vs8IJhUiXOoDAJq2xlVVckPqBR+WE7Ek6XA7DmkOoHQk8chNTqHd0/hF8/WokW14
	uFF8pn05yX1TRYLIbtINvs+A/U0HUjuRqZKGryoo+zMxLurHMvmpGdaJmgLMYfl/F7RPGW00L5O
	Ex
X-Received: by 2002:a05:6000:2506:b0:435:b020:30a3 with SMTP id ffacd0b85a97d-435ca39b3c7mr3408860f8f.54.1769348595045;
        Sun, 25 Jan 2026 05:43:15 -0800 (PST)
Received: from xeon ([188.163.112.49])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435b1c246ecsm22459688f8f.10.2026.01.25.05.43.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jan 2026 05:43:14 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	Dixit Parmar <dixitparmar19@gmail.com>,
	Tony Lindgren <tony@atomide.com>
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-leds@vger.kernel.org,
	linux-rtc@vger.kernel.org
Subject: [PATCH v1 03/10] dt-bindings: iio: adc: cpcap-adc: document Mot ADC
Date: Sun, 25 Jan 2026 15:42:55 +0200
Message-ID: <20260125134302.45958-4-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260125134302.45958-1-clamor95@gmail.com>
References: <20260125134302.45958-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add compatible for ADC used in Mot board. Separate compatible is required
since ADC in the Mot board uses a unique set of configurations.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 .../devicetree/bindings/iio/adc/motorola,cpcap-adc.yaml          | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/motorola,cpcap-adc.yaml b/Documentation/devicetree/bindings/iio/adc/motorola,cpcap-adc.yaml
index 9ceb6f18c854..1f77da7f8e06 100644
--- a/Documentation/devicetree/bindings/iio/adc/motorola,cpcap-adc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/motorola,cpcap-adc.yaml
@@ -19,6 +19,7 @@ properties:
     enum:
       - motorola,cpcap-adc
       - motorola,mapphone-cpcap-adc
+      - motorola,mot-cpcap-adc
 
   interrupts:
     maxItems: 1
-- 
2.51.0

