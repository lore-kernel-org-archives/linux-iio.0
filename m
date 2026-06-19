Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56BDE1A23A6
	for <linux-iio@vger.kernel.org>; Fri, 19 Jun 2026 00:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781829198; cv=none; b=ig86wF2Sqp4HTjwslXv1sCricZvcr03kxtRFS/OStLoBhqbRzJoXj6eNOUoDunTzaD8/GKTiUIdeCY0TOjK/aERj53DLJEe6xUkeHSYgi71DIplSTcHfoRMu/dkPH+DwzUSDiGZmC0TaPyJG1A6NRWAxFnxn1ZYw4NtaxT0bOgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781829198; c=relaxed/simple;
	bh=HfDwPSM3AgwjPehs4wPAUk58oPTdqwzoGiKVwh6DUPs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=u+ig1e+3Q0eohPDVUxkDCbUkDm/3AgKzyy76zWySshpVW9l7rh6aM05noRdL5f+tKNYxEjR3uEGY4z0YMwlbmK7I2FDJGfhd85wugQajA0ZhpXgcIgXzEhYlY7pkGqNvRdJn8OEjjsg1BEYBZToqjmhEGrHsyOXoZdX8dbD78Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L1QvTRoH; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L1QvTRoH"
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-5b22b023e1dso960307e0c.2
        for <linux-iio@vger.kernel.org>; Thu, 18 Jun 2026 17:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781829195; x=1782433995; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=znQu5cFGcYeDF1LB9ZZhOnWvhk6kupYFyYu/ENFjpMc=;
        b=L1QvTRoHnjNmxzN2X48ewA4jCHcNbQ6ccDX5volKUW8f3FcjRhT6LSdB0GP/kT+8Rj
         /ZJL/xO1OLOv0BogOOv67X3U1U3xL/u7W3ltub5Cv85umlruysA2c2wO30Va/vwrrJp6
         AsxHGuk6equBXebPO9hboZcpTL4ZDTcD/X1gKl/2GEVGiQzUg8zKqdE+iy0UsGB6pSol
         lDHb0IDQFeknphtOapqG5ZnurnQOho3USYwdl6A6dGsVfpj6hh0NuXTjrqPNNx4QW+IV
         GOA540oIRD6YuKt8TX3SUD1Vehe6YIpPlW7VxyMRYNKIBefAWGyP/A0GIuR5oP93/Kuj
         iomQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781829195; x=1782433995;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=znQu5cFGcYeDF1LB9ZZhOnWvhk6kupYFyYu/ENFjpMc=;
        b=caNDlo+IlmjfoNaM+xierGfx/09he+GcW6Uwtw+MZcDsC1y7eu82gHqyrvhL5HZpAs
         VMFYsVi35WC5JDS51q7NtFxn5k3Ze1JQrbOoXtpd52E41wA691crnQp6HxCTooOK9zWd
         n1FT8nZdygGdmc3DWMXQPcjBG20U14TgXj13CuT4JJmhs0HOXjuLI8Eknn90Jv53zusn
         G436f6rOURgFO5O74YQAEW06OT/T9yPe7OCsySwjIIMpcDTk2zkes8Y7+wLwkxk6wEsH
         YGaWKQcWdqwCZYiFkY7wn4ilDpicpUTsa0e+vv74LR8qXQpA6Fnar8Lg3peM6F9O5mvF
         TUBw==
X-Forwarded-Encrypted: i=1; AFNElJ86yNq13qUnmUFl/5XIzTDEgOG1IRQpbGEKCScBcRgVyM/mnQDF3Zfyc2HcBxWRP+d1+xtwnWTrLwY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkE+9/yNViicr+nAF74+g98Hy3PyFVOY7K68LuBPy1PAvs0qkP
	vSUCQdexo7RF7SCEvB/ntbQTtXH6MnLuuWv7Brky+5Wf4eOjBmZcWQSE
X-Gm-Gg: AfdE7clSQY1ucn0ZlEdwGYBx59VW9DO33jRH71yZ4UtRKtq9iTu/BVX4stCMe4TSDEM
	wUuTUfeXczSw6qmSzItihrkqGeTuPgkKh70OmbFnq8rqeJ8wtlkUj4M+qPY2umyg0nxfJ4obTXF
	6kO86k7Uw3vFxJpn0mz7ghWQuZIE2Hhdv/o3P/ViHSOBXlLvo8wkhH5LO5y1AAAQjmuT0Vy3/i+
	uwh0Aju3t+dgJNJFzlunP66ygV5CbfCGyeUpdDtNH7dryxq0ez5SX7r7bdGGisIN2BFHY1dH2Qq
	VO+9V9I9zTgI0E3Yc8KkrKzqrb91vy9rJOrz2HxRSbyhUzsPOnA5YlX34c9zDY9dkTn2/X5VFrs
	sNZPWmiWCo0AvWLzdQs6jXy8T6tGOtrcmqduH4865AjI+Qnjb9mHR0AEdoi4a+T6VqU6zn6aob0
	9WnTfUcwh6SVaemhllNJs51A7h2Q==
X-Received: by 2002:a05:6122:4886:b0:59d:8734:e801 with SMTP id 71dfb90a1353d-5bbebc30bb9mr702133e0c.14.1781829195253;
        Thu, 18 Jun 2026 17:33:15 -0700 (PDT)
Received: from [192.168.100.222] ([2800:bf0:177:563:8f3c:3421:b12:7a09])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5bbea36b5e6sm861581e0c.9.2026.06.18.17.33.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 17:33:14 -0700 (PDT)
From: Kurt Borja <kuurtb@gmail.com>
Subject: [PATCH RFC 0/3] dt-bindings: iio: adc: Add reference, excitation
 and burn-out properties
Date: Thu, 18 Jun 2026 19:33:00 -0500
Message-Id: <20260618-new-channel-props-v1-0-963c1b5cf40a@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDM0ML3bzUcl2QTF5qjm5BUX5Bsa5JWlKKKVDeICXRSAmor6AoNS2zAmx
 mtFKQm7NSLESwuDQpKzW5BGSaUm0tAFaVyeN6AAAA
X-Change-ID: 20260618-new-channel-props-4fbd52020da2
To: Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>
Cc: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Kurt Borja <kuurtb@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2083; i=kuurtb@gmail.com;
 h=from:subject:message-id; bh=HfDwPSM3AgwjPehs4wPAUk58oPTdqwzoGiKVwh6DUPs=;
 b=owGbwMvMwCUmluBs8WX+lTTG02pJDFkmfc5Wl7WF7UtMBX5sMp7B4Wj36VXujJcVHJs1bc4Kc
 byuz5bvKGVhEONikBVTZGlPWPTtUVTeW78Dofdh5rAygQxh4OIUgImcns3wz+TD6oxHsfEqed8/
 ej0UXJ+ovW1J5yRhfknnhzNL2/Zxnmdk6J/2vyYmdcl17YSnMU9T9h8WXxV5kfsEk+IqaYY3B4/
 u5wQA
X-Developer-Key: i=kuurtb@gmail.com; a=openpgp;
 fpr=54D3BE170AEF777983C3C63B57E3B6585920A69A

Hi all,

After submitting a patch series adding support for TI ADS126X ADCs [1],
I was made aware by David [2] that at least two more chip families,
ads1220 [3] and ads1x2c14, share very similar features (though these
chips are not really compatible between them). After that, I found one
more chip with the same features which is already upstream, the
AD4170-4.

As David explained in [2], these chips are intended to be used with
RTDs, thermocouples or other resistive sensors so they share the
following per-channel features:

  - Configurable reference selection
  - Burn-out Current Sources (BOCS) for diagnostic purpuses
  - Excitation current sources (usually called IDACs TI) for sensor
    current biasing

Given that these three features are present in all four devices and
three of these drivers are still under review, my proposal is to have
these features be described in adc.yaml and have this series merged
before the three others [1] [2] [3].

This series is sent as RFC because I still don't have much experience
with dt-bindings and I don't know if this approach or the properties are
general enough to be described like this.

No dependencies between properties were provided because not all devices
may be able to configure each one of them.

[1] https://lore.kernel.org/linux-iio/20260612-ads126x-v1-0-894c788d03ed@gmail.com/
[2] https://lore.kernel.org/linux-iio/20260615-iio-adc-ti-ads122c14-v1-0-e6bdadf7cb2b@baylibre.com/
[3] https://lore.kernel.org/linux-iio/20260610151342.44274-1-zizuzacker@gmail.com/

Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
Kurt Borja (3):
      dt-bindings: iio: adc: Add reference-source property
      dt-bindings: iio: adc: Add excitation current sources properties
      dt-bindings: iio: adc: Add burn-out current properties

 Documentation/devicetree/bindings/iio/adc/adc.yaml | 47 ++++++++++++++++++++++
 1 file changed, 47 insertions(+)
---
base-commit: a50909aa46dec46de3c73235fc15a7d6f763d996
change-id: 20260618-new-channel-props-4fbd52020da2

-- 
Thanks, 
 ~ Kurt

