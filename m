Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A71433056
	for <linux-iio@vger.kernel.org>; Tue, 14 Jul 2026 23:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784071366; cv=none; b=Npv3CsZS0lLQCJMJxJKk9dGbU6+PUHdtiZNC6XdV+BOwwGsfdyEvXU2Lxme3iySiFNDJqmC26HUTpiBekK0qfl0KUrIIGfqj1jgfIaAvBRHHMiWdmXbW7mua/by+frMJFSjbe1bUKfSMlKiF+IPj2+BGj0EHPU8Zfio9cO6YN58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784071366; c=relaxed/simple;
	bh=cf5Ks91V+FV1OeZSu4m+D3/RV9+xpKfFeOldmIGe4HE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Anb/D7sXV6bDwKuKRiMhPldqlE9/Vt48p65tQlj6t4a/axfW3zuFj3oCJjftcrLmUzkfuYT6PpfBujl33VF1YPyyaWuAHefRuww6Lly/3vJxjWEcxf/TsuAy2Ux+skHnb4RqR1CEZ3Rnq0HksJ8O+aJmUllZ4zjHWGie/mfYZNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=K1F64YGN; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="K1F64YGN"
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-6a3da2369bbso134306eaf.0
        for <linux-iio@vger.kernel.org>; Tue, 14 Jul 2026 16:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1784071357; x=1784676157; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0aFWak/uGWDymyQKgtlo8JRo2a4gxl1rRFf3YC4pSso=;
        b=K1F64YGNoAm5tdULtF+KiEi/s959fF3VTQ2CpqwOBsUOrlsM5JrASUw9zvVUreeFJa
         0Tfu1lX1KM43XtSslxM0PxBSo0e6OR1gm3e/sWhD7NiN311/+3UesG4rtT9qqdupNvXu
         ZfvMx7i1aF9n+PqH9PI4wzaHrp1wjjCioXAjm9T3grq3s0XGc5rLJBvIaQozui9/8W4k
         7BF62fu/PDD9q4ljntCPAtJoijKx3dZ18madAxoZ7VDK3uYnm6sSwWT9Arx0pCKvInYI
         81dLQRvdNW14oWrdgoYREzIM8bHZnUg5op1FDobkzJb4AwU5lNhM8lVHa+aABriFNwZy
         Eqow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784071357; x=1784676157;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0aFWak/uGWDymyQKgtlo8JRo2a4gxl1rRFf3YC4pSso=;
        b=K+cJm624P7yIwKHf4jjsr0eKXsMAXT0YYGzOrxy2tC5BSpk45nabmTvLHRjWpajICe
         kauz6fc+2c7GHAbQsHU7wrbQk1bEwCeXdIUoXqvUZGttYVbalPJANE2FgSfWssY9Qzg1
         NqK4U1Z+XpJM4Ry6jmIQsD1IGPEVEkywEaOfxDpRHTsWBrW6bYs3VdtKp3+qV6ldwa/A
         0ZC7MUkP2q47ZKJ8HSC59sCHlusePQvcj4G/6Kp6l4c2vQ6tqI9KpqLlKvRLIjFbPDUE
         cz0GyJXMtGTqoBiBFeX6bAMPbtv/guRc3MUEaJxLJJYBnIoJiiG7iFF70TOjkZlzyjka
         6cPQ==
X-Forwarded-Encrypted: i=1; AFNElJ/VNYVeWdafY+Wl3Pd4JpLn6qMcXnVEFkb70SmYbWhZX8FSspyVx6xoOt0MvGN+WQCy3LLTw2+rHAo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxO+aE245kDXicQdCgefDjKBPsIBcqVUr4rOCP9Fh+HsSMjb/oQ
	0paRJe4IsJ7nqNRbl9wksAHwvcOXmY31kxOueCvkV2OLe0WdUReEriLx8EBuo0R3FQg=
X-Gm-Gg: AfdE7clOA7P6RsQIC/bHOljXLiKLdBTWAoEdwTiITkzaDslJ3tdwrYXVRgAGi2zbJB6
	FRjSCpI6c9m4cmUYIpefhlrFhYsAkI1BWHfPhsyi+hdZahk0nK6DmNwCjSoyw1OJS1zCXY9UjUI
	87fcV2jpJkyi+V97qco4KCvxDShEEYndzonCutc9I+qNUpu7brRWYUfR7iwmjGYwLLjut2s0MJS
	pVE73qZ1n14FDiY+0A72pp5mt5WckVAamCfLaxD4llRIpJToxUyxNktzvvslnE68UBjO5AK8fzC
	WoUg/lMpDs/I7sLiJvOZ5xDQSounA4sX7ABOdK5rPxCuFtOiAioV8IVf/x6/EpBbFDCnI7lPL0b
	67si/DagkqnF61EbZ4f7+saqAwOH59Guc7qHxrVvtTrl2pzhvEC98w8mUi4ciFtz0TEMbBoDFN1
	9ESqJUZYfwSA7AlnmAzw==
X-Received: by 2002:a05:6820:61e:b0:6a1:805b:5288 with SMTP id 006d021491bc7-6a39a6cd0e0mr9428120eaf.33.1784071357582;
        Tue, 14 Jul 2026 16:22:37 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:280e:69fd:7612:d5a9])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6a39af0e953sm7561978eaf.3.2026.07.14.16.22.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 16:22:36 -0700 (PDT)
From: "David Lechner (TI)" <dlechner@baylibre.com>
Date: Tue, 14 Jul 2026 18:21:26 -0500
Subject: [PATCH v4 4/8] dt-bindings: iio: adc: add input-chopping property
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260714-iio-adc-ti-ads122c14-v4-4-25f8e3084485@baylibre.com>
References: <20260714-iio-adc-ti-ads122c14-v4-0-25f8e3084485@baylibre.com>
In-Reply-To: <20260714-iio-adc-ti-ads122c14-v4-0-25f8e3084485@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Chris Hall <c-hall@ti.com>, Patrick Edwards <pedwards@ti.com>, 
 Kurt Borja <kuurtb@gmail.com>, Nguyen Minh Tien <zizuzacker@gmail.com>, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1835; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=cf5Ks91V+FV1OeZSu4m+D3/RV9+xpKfFeOldmIGe4HE=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBqVsSQIUCy+7Iq2Zt0ba4F16qvgMo/ITDKsC05c
 x9/lyVegXSJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCalbEkAAKCRDCzCAB/wGP
 wF3bB/0VW8ob08RG7FhpIU/BQV+J8P1JMvgheTNUJpptDztsshivaiRL7TO4h6wS7LRVuEfD+x7
 89xWHDwfzelaqq5BzLuGwqvn8l4dhLgtUyRtmzUmwF1Wd2SywlUGaBfKfCzACEnyaEvVg/8XbmC
 5Ng1EwAsmz8LamDfHgGCjMYqk6BgkMUdRiHElDe2X+Z09mStGbMgr1Rqyrn/LsPsKOjUqs1hRkz
 Cq3H7Wh4wCnFvla0c1nlLhM1B42gWM1wW+sTNsg5Y97A1l5nj0D6JCLmuiMAy2fZeeWBMPeRvwm
 MWDYMP/K/6c6nLOVTLJYzdhZGwaQNTE2/61esjpTXXzz3O2p
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Add a generic input-chopping property to adc.yaml. This is a feature
seen frequently in ADCs that are designed to measure resistive loads,
such as RTDs and strain gauges. Enabling this can reduce offset errors
by swapping the positive and negative input channels on every other
conversion. This can have side-effects in timing and filter response, so
it is not always desirable to enable this feature in some applications.
Therefore, it is best to make this a property that can be enabled or
disabled in the device tree.

Signed-off-by: David Lechner (TI) <dlechner@baylibre.com>
---
v3 changes:
* Renamed property to input-chopping to reflect more common terminology.
* Removed "allowed" from the description.
* Extended description to explain when it should not be used.

v2 changes:
* New patch.
---
 Documentation/devicetree/bindings/iio/adc/adc.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adc.yaml b/Documentation/devicetree/bindings/iio/adc/adc.yaml
index e1da63119648..b673eaa5d072 100644
--- a/Documentation/devicetree/bindings/iio/adc/adc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adc.yaml
@@ -80,6 +80,14 @@ properties:
       ADCs usually allow choosing between internal reference sources or a pair
       of external pins.
 
+  input-chopping:
+    type: boolean
+    description:
+      If set, the positive and negative input channels are swapped on every
+      other conversion to reduce offset error. This generally comes at the
+      expense of added settling time between conversions, so should be omitted
+      on systems with high-frequency signals or high data rate requirements.
+
   excitation-channels:
     $ref: /schemas/types.yaml#/definitions/uint32-array
     description:

-- 
2.43.0

