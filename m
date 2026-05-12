Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3B739D6E9
	for <linux-iio@vger.kernel.org>; Tue, 12 May 2026 22:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778624345; cv=none; b=lhH2IYBJWfg5vyfvGfwOwRtBTYB9OIEtznFqVEDWQg49unlAWSZoWwoLtlP/Nih27y4yXDbk3TcZHL8ph349guD3saoSqOBN7DysUWS5GoSarGJ/crsX+MrjpPQfZtN7D9HdmxMc6SyqnzRzwMFg+40/aAfltDArZP72TLLLR6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778624345; c=relaxed/simple;
	bh=rzSuhraAI4cLyzTVmma+9iEM834IMLSQLVOxkCesmqI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nZHs5gCN97e09B/Srld+bVrxwl10AH/nplC2RfsnYQNVwi8WYuRiJX6/+IQTB3CHV0GlHLj8zDnwgpcBoeKfPcr2fOX0s2ORegJOkH2NnnwFw5emROpj9+0P5GwH38HQ5pZWzCuCzt6IZS+FAx7yqjq8P4FwDUTF748RU0CrNY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Os/6+FTr; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Os/6+FTr"
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-4824176bbbeso1624702b6e.0
        for <linux-iio@vger.kernel.org>; Tue, 12 May 2026 15:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778624343; x=1779229143; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A10z2V6mAiVce4BytYqy/qmrWiH198BizlsZzZUSoec=;
        b=Os/6+FTrF6sOE0KLI5E70a8KOzVFxbHPSMkr1/rrne7MrXTc2MN+lEGRHO2fvjSi16
         67B52hOESa1qQNlVfMqpQ+99j6PkHfIzTivuMOQqVY5UTU+eaazbRgM2wCGgaIrVP8/A
         HK7QYN+xHt1B+aaiD81a36cS1yDRpE7B+tiKA2h4pVL9gKu5YNTWHPuFurmsEEc+E57V
         U9MXzXmQUPpSHyjC/idjSKBmBHnAbEqBuY0A88avwwswyiUrrA/cnT0CM4VughKrOZPJ
         L5dKdFqVGtz6suj32GGrKqEVTJEmbL4rHV8OYKWZzhngh2HzQ+cUeYJcouCT1Zp0yj2/
         lZbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778624343; x=1779229143;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=A10z2V6mAiVce4BytYqy/qmrWiH198BizlsZzZUSoec=;
        b=FE+D/VZJ1sqZ+vhNCdKCUkyWbhdubW/vXWKpLun7IAI/r3BENvYpBRwP7yJ9b+GbJH
         R3PrAmLopgcTZkumySRaGLfH6GwisIFrZdKVS7Tjg9Gh+oELS9SnTD3dTYgqQ60Ulkck
         JIw9s7Yj3Bz5zR0RyFcoqegZHrdEACfcXA6yjUhWG4oYl3fJ0TztDO8yO/EZK05AMd7A
         whRu/TsKc//dpCLNbRrh4QS3EIL4oK9GEL5knsEkomVcPpvbs42uDp0+sBA30+3hEQhu
         NNP/I6RHc4e83CEMuGNhdMuNFiJQD14UoUtDcKZBNlChOfbjpRam19ijKjWmDiK3qunn
         4v+g==
X-Gm-Message-State: AOJu0YzbiN/jlNjOxxruzhfC2x/3ApjSuesnldI22CgGW2/4pWdSPWKy
	n22+QnfC4AMgzkytl62x/OpibVei8HUxpJl6ZCI1UkMUjWSds2Qc1QluhSQe93YU
X-Gm-Gg: Acq92OHkwG0uw3zMP3XxVmPKDxAMeogIkX0pEGzRQ8vtk0G/VHnUYedYicBgRNJiMgq
	PjXmz8aw2ZDxuCNChnqYeJDQyf+iKOyOZ+KBYT8jjHsmdXLwLzZrPuGeP44dDTYF4LEeejzNBxo
	gYmQ8cwdZOodIJe9NmgQmF2WAWyXC6qk57TzKOsqCzau/A1DerFB9S72aGjD+r2kL1uLvvts+Ep
	yvtbEulk/b1qGQI0/34GWTxIFBz5Oqd2JdaUUihCjF3p/NRFlqfTj7cTcaJZtxi5Tt+Ggi27YOm
	8kTUEFVQqlQR9AwhBZlWp7kNRVpGnuZ7OiD4xaX9ghKwAKLer+w33yM37YTCFqipMi8bD0EG9PF
	q63LTp8aYc0TCAoYz4OWVmlWLcknACm5RxaOJEixfffZeXpXiiiBbi/eiMWKpgzp8ko2OEK6nSI
	ejTJaYVdD/cAP+qrNM/Imp
X-Received: by 2002:a05:6808:444b:b0:479:ac7d:6da8 with SMTP id 5614622812f47-482b2b2187emr786356b6e.18.1778624343187;
        Tue, 12 May 2026 15:19:03 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bc0::54])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-47c76986f87sm23291473b6e.13.2026.05.12.15.19.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 15:19:02 -0700 (PDT)
From: Chris Morgan <macroalpha82@gmail.com>
To: linux-iio@vger.kernel.org
Cc: andy@kernel.org,
	nuno.sa@analog.com,
	dlechner@baylibre.com,
	jic23@kernel.org,
	jean-baptiste.maneyrol@tdk.com,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	heiko@sntech.de,
	conor+dt@kernel.org,
	krzk+dt@kernel.org,
	robh@kernel.org,
	andriy.shevchenko@intel.com,
	Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH V6 01/11] dt-bindings: iio: imu: icm42600: Add mount-matrix to icm42600
Date: Tue, 12 May 2026 17:16:22 -0500
Message-ID: <20260512221634.256747-2-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260512221634.256747-1-macroalpha82@gmail.com>
References: <20260512221634.256747-1-macroalpha82@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chris Morgan <macromorgan@hotmail.com>

Add mount-matrix attribute to schema. This attribute has been supported
since the first revision of this driver, but was not documented.

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 .../devicetree/bindings/iio/imu/invensense,icm42600.yaml        | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml b/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
index 119e28a833fd..9b2af104f186 100644
--- a/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
+++ b/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
@@ -53,6 +53,8 @@ properties:
   drive-open-drain:
     type: boolean
 
+  mount-matrix: true
+
   vdd-supply:
     description: Regulator that provides power to the sensor
 
-- 
2.43.0

