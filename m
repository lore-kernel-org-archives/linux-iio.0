Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629F73B14D3
	for <linux-iio@vger.kernel.org>; Tue,  9 Jun 2026 16:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781021852; cv=none; b=CIhV+TNJdcrW8mPT0CdoKqX36W5Lwv6KduYBF8mzaJOaGmRmrT9YIwA89qBvEEiaZvbQnLoJt0f+9LLt6mfimDXNlxMdan8QmAdS3+pIuceKXNPwSoNUVsFzuc8Yz1Kokmvq0O8K0u07NJ61xf9NoWCKKVh5cayf9BqBewuQTkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781021852; c=relaxed/simple;
	bh=UE9YrE2v+vWOrb9zJC/jPk8oe5sMJhvINlq5ICoXTjk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BxBOk9hQnZ7xXKnekW/SW23WgWWPLZlue3+7nMrjd7i84TP+MSaP+1uoe2VhnRyjOiH2TXvpt/Vrb2BFttEd4rHGCkir5j50IZgJQHs6VEs2sRsrkb6jDiUKDtEv04+vJ7yhxoEODcy5lemvadjmwJUl98Hpl8VfHaPWJAnUDpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T88FraFu; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T88FraFu"
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-43ccdc20e67so2649630fac.1
        for <linux-iio@vger.kernel.org>; Tue, 09 Jun 2026 09:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781021850; x=1781626650; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jmbg0V7VWVis+O/gLXuP54Yt+uK8k6/dFNi9df9HTAo=;
        b=T88FraFuK8wFkJ2SyJ+tFCMyFFZlYVbcHoGd7C5dL57ddjIwIFuw+guzxhQJqqf6t6
         189Dc/UEvdfeLtPcveMxrpuj0c3V35iMxpFSUjXor/KMCMvgBZKaK6TNz0A14SIlpvZz
         ZPp2RC8XNgJIiVuyEzhRfxU3HVIuoaI1iPWk7OU8mnaRtCdcOMjRroj8kIJK5rMXdkwX
         F6bFzGJAPZWPliAO1aErsLbdOjgmmujz9ut/ieRRhWwM+wUahIawxoB4mVG+NuuEhquo
         XIsa3kYQy9pyUYVx5vgTmktArXEkcsASmFwKCc+VSsuZ/C0ZoeQmCUnfsOFyMnQt1tzV
         er9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781021850; x=1781626650;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Jmbg0V7VWVis+O/gLXuP54Yt+uK8k6/dFNi9df9HTAo=;
        b=AMJGNjFgDk+op5Mqyfi+WgRHZhINLtA1HBtdklbPKUqb6C1S7laIGLFf6CXDURgjmi
         WjEehy79lFsvdD5CYmO5AXUKXulwT0scX3NSlNO0si+2e7hidbTNiGhxjW03euhJzOTm
         tT74ebSXu7UY7YG3VmD8bMKnkBjxQgqQ79BqhoX5S25z8CbAm8csZY0Lbgh/3yyTdLVR
         DSB1vl9Wd4KuxqBIKqtV1jmBJayFHepsb97GxPch2ZA0EbKPfvJvtxTreu2vFXDZVADe
         zw91RPYZwjLz4Z5yrvFxmmn7PgVIa5rljRT6bKbG+PC+Y/CAX+UkwGYigRZKbcdspLHC
         X2og==
X-Gm-Message-State: AOJu0YzguZ+BFgBFtoohwgAw+a7M6oCR8v3cxL3zsoVxf7vvqXPx8ajq
	YqNP9NsoQW6uaC8NX//Tp77C0J5cdbTI+YdpCOsWTwnFg9mT7wdubwE6
X-Gm-Gg: Acq92OGXNNVyuwepZLfbweN70a/n5L4vH7Skn/H0Bh4P4v8EHWGC0UYozr92AgTM7Bd
	naITvJplJtmxH+bJkBfSWbTKxH2u0C7a6DjAFCGUJu8A5X3c8BssSyz8Ri82CKRQfdR3EGlyav7
	L6WEDwwLuhRVx4Mscuc6dBRwynxsbyn2RmOBjSJPiEJpnN1u90uuPXLv4pM5WOHmSqCRaN3KgHL
	sHkwGBIM2AwO7E0Fu5fCytxlZOMa02Z4qc+ILRqI/1ehhQgrKZhUTPREI63A+VEyvZu4XDfvzmg
	Z/tnYhIgAPgCf6URRARayEnRV+0Fb0V3CPb1ICqYjx2oy5HTFjW7+GbP7UdUe6MfrZGDiBunF5Y
	dfj2egti+xRcMwVXjG1Scxw3Z4JTfN7DqOC1MOh7EF3PQliJcMYS4RVTeV9+80LWb8vCNPABi/f
	LTybLUL6b2oaZidT0+SpmqiKgOGRZf5l02wJq0c44J24Al5/Dm2zXgcilHj6KnWxIk/3iZHqBg6
	L55wzk=
X-Received: by 2002:a05:6871:729:b0:43b:a0fc:f6bb with SMTP id 586e51a60fabf-4413d634d3emr11999885fac.8.1781021850351;
        Tue, 09 Jun 2026 09:17:30 -0700 (PDT)
Received: from linuxescape.lan (23-88-128-2.fttp.usinternet.com. [23.88.128.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-440d8448e3csm18797906fac.13.2026.06.09.09.17.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 09:17:29 -0700 (PDT)
From: Maxwell Doose <m32285159@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tomasz Duzsynski <tduszyns@gmail.com>
Subject: [PATCH 1/2] dt-bindings: iio: sensirion,sps30: Add myself as maintainer
Date: Tue,  9 Jun 2026 11:17:00 -0500
Message-ID: <20260609161701.52513-3-m32285159@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260609161701.52513-2-m32285159@gmail.com>
References: <20260609161701.52513-2-m32285159@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Tomasz's entry is no longer valid, as he is not active anymore. Add
myself as maintainer for the SPS30 to replace his entry.

Link: https://lore.kernel.org/linux-iio/20260609140712.2e5d1640@jic23-huawei/
Cc: Tomasz Duzsynski <tduszyns@gmail.com>
Signed-off-by: Maxwell Doose <m32285159@gmail.com>
---
 .../devicetree/bindings/iio/chemical/sensirion,sps30.yaml       | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/chemical/sensirion,sps30.yaml b/Documentation/devicetree/bindings/iio/chemical/sensirion,sps30.yaml
index 967500b7e773..a31a68caa5d3 100644
--- a/Documentation/devicetree/bindings/iio/chemical/sensirion,sps30.yaml
+++ b/Documentation/devicetree/bindings/iio/chemical/sensirion,sps30.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Sensirion SPS30 particulate matter sensor
 
 maintainers:
-  - Tomasz Duszynski <tduszyns@gmail.com>
+  - Maxwell Doose <m32285159@gmail.com>
 
 description: |
   Air pollution sensor capable of measuring mass concentration of dust
-- 
2.54.0

