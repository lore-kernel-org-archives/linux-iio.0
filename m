Received: from mail-ed1-f65.google.com (mail-ed1-f65.google.com [209.85.208.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD5D31E11C
	for <linux-iio@vger.kernel.org>; Fri, 20 Feb 2026 09:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771579157; cv=none; b=sL9sSBrqOsIpvbozb6nDLzr87OBkPL5GpfwB84utjQY+eMsjg/334zw3Yw9C011D0g4FvnHZqHPXhwkEEk+UXSGmeneFPXcvicl2R2CLfZehJ2tbXvax/HaoEt8m3hIN9sJLjvENF5nZVC/SULTEfGZIFpnwVPeyTgKG+t9iTDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771579157; c=relaxed/simple;
	bh=isDjg2KdEDAWzS8eIlvfXGW5pS+9OiwjRNsGXauVrws=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CHBKOMq6yfBEfKd8/4G1GWW8eqHVlPhb/blkPgBPA3urpZBoNXDQZuLDMW5MxOn+KHAcEnmOm0xj+jyiV295dNS2dwRFji82XKINnqEYrd+aJ4TIoxvDG6MBGldfIPp5JUJmVNmaP/Q+uOYa1yHRq0BG+OJl0gmtTVoJBju7Fok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=N9gjeNYo; arc=none smtp.client-ip=209.85.208.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="N9gjeNYo"
Received: by mail-ed1-f65.google.com with SMTP id 4fb4d7f45d1cf-65a1970b912so4716483a12.1
        for <linux-iio@vger.kernel.org>; Fri, 20 Feb 2026 01:19:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1771579153; x=1772183953; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xYkTpRjooi8HA/4JvTDsm3YoyWiVwSiSYVAVY34W7nQ=;
        b=N9gjeNYotHVttTLbIJ/8dDRB2Y6xz0zLJ50xkSPnY9oAweuDaRAgFdJtB54PuMzLt/
         J9REpQGOTlIzB5jetXjcWN7bx8IVE+SkDO4lfC5DN3Ycd/E8nxNiL72wO9iWf9UqouCi
         Xef1Ob1HSXJHwi90dLy1NoB/K4CU4AWSXkNW3EQOSioK6VI6QjyJsdr8cUeZkfIC7nsY
         CJTArJiSx9y0/ZlVg+ORCvBDpL+9zUPG0Beo2wtpcJfaawa7H67jz1fVWIkw4d0Lu/uD
         EtZdB4FlFFk1LJuWEZgK6e4RFtJDIvjfv/bdl9m+KOYlRUgJbSPUXBQ/Mvp4qN9JLqWL
         51JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771579153; x=1772183953;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xYkTpRjooi8HA/4JvTDsm3YoyWiVwSiSYVAVY34W7nQ=;
        b=MgjwwtXwAd/AzasFeLpeMHH6ZZT/sqqCR+qn4ij1xkOnaxVjB8kXg46CePp6fEArq5
         YMz629cyoW8cuD2Sw4FwyaeD1PP0DKv5VjqN4v0oF5XWKVREe+5J8wu5vMJJwrC4mX00
         2djjQXj0C45dska//J16JAxNVid1fpvYSWRc0cDJ9S/eMSzz1PooGbGofEgfLYPRTpPD
         bTrNtgYZXU1jD12Zr5h6eQcqxhHZssbLQ7g7g3Aar9ckbn++rKhNG/QcuOhb2qiILDdp
         feipshLKKbPqwPl7jEX5CNPlGxIPPeW4jQPhJ0Bssd/qRm7rYNWPF/PdK7IiAcwJTeyz
         k2zw==
X-Forwarded-Encrypted: i=1; AJvYcCWyFOhYE3p+lUg7SwlRGK5k2lH44e2u1TdQfaQzI3DknR3dp6z+8dAKJ19LK24vcZNBwEHy3Mh9krU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzB2s3Nf/LyFL12uCKOTuat4SqkA6Pr1LrhpbRKaiKU0/fUm3aW
	n9SGv1/ai5fvxsWR+zAtAnzq3p7QvsS9Z+84vS++iZABXIOHcSH2p7LvjUCWFpC3dCTf9JmylbO
	vILeD/0M=
X-Gm-Gg: AZuq6aKRlGOQVa/6ZbYcEqbOcLzMJomYZFoEVg4s22uoHB6ryCabHnBwdWNiIAMSP54
	/iwBUIuUf62J19fJdEQ4ryzGPyiV/saO4e1dj/6yugI+ruLz4Pk17boXA4elNT4lys0WGOVbyon
	pt6YmPljZsvwrPSqxeBDoxWpQqa9EvQPiXC6S7tIw6oW2WGtPEXrZp7hjjuZTlVgBRW2l2zB9ow
	V3n+RWjqSjHw5DACzN64zTIhlNw0CtgSOESSvsAhs7QcZ5gWcBa/1rOhfkpuk1NoUdS19+jNMYU
	ZJJOF3NkiToV+pE1wTNkjeyQBIPJ5pKYy5d4weg13dRybYeyUK6eRuj2Bx6y86iJ83IEsgXaLOD
	p0tCw+ohQpW2rx+GZuitj9aiRUZeKvGv4jDcYV5LuGYxlUneb0x4faIm2v2zGDUOlUR5RC4WE9v
	DtnGPgboC0ESEz/WUAXMZQR3DAJAXGTl3sH+bEmwnIlbZUKaVxpcnBjLThb0CwIpeM3g/1jLllx
	J9QsVmhLLbRzbjV
X-Received: by 2002:a17:907:1c28:b0:b88:4224:815b with SMTP id a640c23a62f3a-b9073049b87mr76905466b.3.1771579152977;
        Fri, 20 Feb 2026 01:19:12 -0800 (PST)
Received: from [172.16.220.101] (144-178-202-139.static.ef-service.nl. [144.178.202.139])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8fc769111fsm667098666b.57.2026.02.20.01.19.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Feb 2026 01:19:12 -0800 (PST)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Fri, 20 Feb 2026 10:19:06 +0100
Subject: [PATCH v2 2/5] dt-bindings: thermal: generic-adc: Document
 #io-channel-cells
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260220-bat-temp-adc-v2-2-fe34ed4ea851@fairphone.com>
References: <20260220-bat-temp-adc-v2-0-fe34ed4ea851@fairphone.com>
In-Reply-To: <20260220-bat-temp-adc-v2-0-fe34ed4ea851@fairphone.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Laxman Dewangan <ldewangan@nvidia.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Hans de Goede <hansg@kernel.org>, 
 Jens Reidel <adrian@mainlining.org>, 
 Casey Connolly <casey.connolly@linaro.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1771579150; l=1052;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=isDjg2KdEDAWzS8eIlvfXGW5pS+9OiwjRNsGXauVrws=;
 b=ZSVbqDHsSdLJsSwCkOzI7OsESGGyedhA0OT2p64wvJLLGx+vATaufPEQiebJ2HAoVmJZuf7QM
 fP2hUioU8+mB979BlBrTDKKHkKWw0KhWvQYmWm2xVr4I1nKLQZDoVeb
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

Document the property to allow using this sensor with io-channels.

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
2.53.0

