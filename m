Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0A5426D14
	for <linux-iio@vger.kernel.org>; Fri,  6 Feb 2026 17:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770398964; cv=none; b=DI1PSBfagVtxkzglGHwHZsMBw/91e9djq4FjSsJnNbqV2c/JMGyFbbmyBYFxOaVmB18XRM8AfW+aBVdQL7vlAiw3kpBJJ+WyC0BbXBAMDxuw7fmFUjpgrRkiCLRF1I1UhGGV86UZ6wI718Q3iZhyA3Id96aPO+oF6YXRL5+8rJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770398964; c=relaxed/simple;
	bh=JmoAM65kp4SCHWds8aEZYvgwgyS/3LXvEs/CupbV0Jg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cg6pi0ijpsHiQmVx13j9/jfqm5OE8Ltna4+fhmv03kmK11nhQELD6btaD9i7HQd+El0k3zQ3/23+17XyhuBsDGeGx9E5+YrzOx3SxYPWoFd1s/qJuXstRvNgvlkqoyqfU4XUKDH/Lk/5Efp60dQlGGcejKOXCzCkyKC6Oee5qcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dEpGYbG1; arc=none smtp.client-ip=209.85.221.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dEpGYbG1"
Received: by mail-wr1-f66.google.com with SMTP id ffacd0b85a97d-43590777e22so642631f8f.3
        for <linux-iio@vger.kernel.org>; Fri, 06 Feb 2026 09:29:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770398962; x=1771003762; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yHanamLMxlv1uWVeIDwySoE8PM7DR+kxlL5JLXtsy0o=;
        b=dEpGYbG1Bo30cStqn4SNvOPvz9HQ1AJN1IirUXq8oTBCshw43DTVJtsAv+yPHmjL1c
         HDUOvQLLi/HYqrR5JAdhYmPoH4v3cAjCMn7kZDLe6oyITaUeQIvbaeg/SDfMHz5tdy/Y
         bSaVKqW73bBaOzjndCN8Btk4WZ6+uORXX41gd5hF2EmVNWO4nweFfUTEoAfDzmPveCBS
         YtXY/+lcHQpE9QlUefAU88KyhkslcSivoP9NVGHAuyRHrkfeJQREzvXgFMlmb7zP4z1W
         aQFrnXm0pImEs4Il5Qf6eQmHoRtfoo0s4LwaJGdqZm7Rm+13COKTQUkHeAHG2SUVcNKR
         FjFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770398962; x=1771003762;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yHanamLMxlv1uWVeIDwySoE8PM7DR+kxlL5JLXtsy0o=;
        b=jYBoJuJisVCKOiV50cICspAJIukn8ilYPe8jbaP3r7ZlDEVuoA+C+6pknQFhlg68gE
         TyfXJlMABBVQ883HgmQ60Pa8R+KjgNAbEHclM+M3TVYakwzoEB9veYn+Kh9Yu+vT1p7I
         xQ9szGE6WQUgT65Ex/ZThIGmSyP939fF6r6N41Gk+p02JEXroz4ssqgSkqM0jq4UtgML
         /I1JpJcfusE1BWMYiXu+PxWx7/9RC9NSR6q7Kga5RYoljxlOzqmEbskrZfBlfk+wQf0V
         LneNKTf6XvWXYME+/rP2/V9lyhLb8M20bI1ZnVK4bPig8t9gkOLp5vV9OO4uj77LTk/E
         TUVg==
X-Gm-Message-State: AOJu0Yw0F/PxJq66zoeI9bBs+JzD/YHPOmd4PWa6JgemxI2q2TwiXLs/
	RTBxxc5D1utkedqAfpw36A14aCpLDk3XJcPCUraBmpssTlhCO4/RJ160
X-Gm-Gg: AZuq6aIEaqMoo+AeTmykvHF6ehTyzcvp0yvN1l7gKv1G6IBbNaW9GVpSDLxsdi+62vZ
	f1WvMr9eOcpcD7ccbd487b1EhVD67f5H6hqiZFVobg0ffw6YKoTzv3s4TlgPideTNqWHEHcQSIV
	NyHKgGGMW7TvzX3bFBBK+GNATih25nG9/hgDMf/tJyvIxUvr1eCls6HQMjISqNgmXJjJBKGps3k
	hZVNW5YpEZgDVQgmMhN2qveqc7H6kKl7bca6ElVmfMI6C3fO5zhx5gMYiEaeCFj2aq1ZDTgIhF4
	RoiHQWDVHE2M42l9gJnB9pK/nY+7RTQB/PKcAo9AgMhUPHrDhJCgkBboY95HErWOxH6ooO+Iydu
	URE/PBrRZVB1LYN15etCCwap5qB57ocF/WUlc6iLK+Kqx0mmKW8RN1d2hc5aUd0LzYnKLEMnOIK
	6/
X-Received: by 2002:a05:6000:25c5:b0:435:a160:4480 with SMTP id ffacd0b85a97d-436293b3972mr5583800f8f.29.1770398962093;
        Fri, 06 Feb 2026 09:29:22 -0800 (PST)
Received: from xeon ([188.163.112.49])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43629734268sm6846033f8f.24.2026.02.06.09.29.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 09:29:21 -0800 (PST)
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
	Svyatoslav Ryhel <clamor95@gmail.com>,
	Dixit Parmar <dixitparmar19@gmail.com>,
	Tony Lindgren <tony@atomide.com>
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-leds@vger.kernel.org
Subject: [PATCH v2 09/11] dt-bindings: mfd: motorola-cpcap: document Mapphone and Mot CPCAP
Date: Fri,  6 Feb 2026 19:28:43 +0200
Message-ID: <20260206172845.145407-10-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260206172845.145407-1-clamor95@gmail.com>
References: <20260206172845.145407-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add compatibles for Mapphone and Mot CPCAP subdevice compositions.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 Documentation/devicetree/bindings/mfd/motorola,cpcap.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/motorola,cpcap.yaml b/Documentation/devicetree/bindings/mfd/motorola,cpcap.yaml
index 7e350721d9f6..714d2645d6b7 100644
--- a/Documentation/devicetree/bindings/mfd/motorola,cpcap.yaml
+++ b/Documentation/devicetree/bindings/mfd/motorola,cpcap.yaml
@@ -17,6 +17,8 @@ properties:
     enum:
       - motorola,cpcap
       - st,6556002
+      - motorola,mapphone-cpcap
+      - motorola,mot-cpcap
 
   reg:
     maxItems: 1
-- 
2.51.0

