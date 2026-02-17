Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2090C338905
	for <linux-iio@vger.kernel.org>; Tue, 17 Feb 2026 12:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771330418; cv=none; b=kkH3Tb2nohfk/pzSnbzb/4n3v5laWWaCUBYbs+Yrb+WNyNQeD13tB9NogR/WUacOlvfjKZ7QXsDuI5a/5Gbf+97DDbdu8yg5eDak9uNu6okmF8LnsxoDHfmmEHw5TsRq92cVPmb2kme8RNbDQX5o7yRfRdEZjh6FdwfpmvnLJY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771330418; c=relaxed/simple;
	bh=TfAEQ0DQqlw+rJE5RLoCHxNI1QmA0myGlCXlHcg8C9w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uwLiBf9ne/oWfPkHwogoB9HYKNUgF/el10vwZL3KEzzqv2cFYk4nO/YmNRx9wmkSJvrSsv7lXkgz6Ya1gSb6zyUOVQijgCzxXAeVCxSoKAFealox3wv6b/nvo/pEBEEoTeiQMuDL8CzZ9ij8i6rtqPZNc3RZXl1c7XObFqCfeZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EvzjbAcx; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EvzjbAcx"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-7927261a3acso34895457b3.0
        for <linux-iio@vger.kernel.org>; Tue, 17 Feb 2026 04:13:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771330416; x=1771935216; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=470sTxAyW3pl5tkqZsSbPmdvi73tkPic1jpEvnpVzmk=;
        b=EvzjbAcx9q/AhIcTj6BwiXAlF+071Bo3wrCZhVs5HymHKawwwaU7mRx7B7O4nbc1Yr
         YeYBYC/06W421UOOvHYny+GkHhbu/s9nNm0roWXoPqTFgVD6FAaF3dV1SYIOxIfuTv1B
         urLOAltgfaD68GZ58j+KTQKIVriMqGhLwUWgZaPlMFptJEQhWOrDt1MzKXv/stKlqEmT
         wlyrXTzOjPRAQPOpFtsHJUtF9WoGf8bGsHy108CBI4mXMcRK/GkQ+doATH1rUUZ3t63j
         tE7eDuL/n8JsaloVIi0o9YhF0BVfErbS+RX1v2QPIPJiOIVbhLFSBv0LbNUC+1DvSPTP
         oLXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771330416; x=1771935216;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=470sTxAyW3pl5tkqZsSbPmdvi73tkPic1jpEvnpVzmk=;
        b=vTP0ZlYOMTqcLwMWOSVfFx5nKeASxN3IURiWkWSrOlE9j6WD9rcslDvjANNGeWwD5R
         INRFmEvFOgUO4I15b872eNIpvTEbI6Mr32kZ8g4s5UeIPDtZGu8S7/roaFvlhK6/FJo7
         m1GSsS3LjemnqhgHbKUKYjHy8K3guImb0qONRORGDjCFCBSRae2Vx/w93dekQnnXvdzA
         p8nATpMHYHJ+e54bPMb/3jb4yFNsQz0I9e6bBQZzT1dWgrtMxPln6OyKxF2kwbatE0Fx
         ja0GGqpGL6uxGCvhU7ZI58FJTLVW4FE4jlIkwBH5veWUpgH7QBcayHStuROfq5ZeDrS8
         XilQ==
X-Gm-Message-State: AOJu0YzfieAMARdMtLMLhfsADy/Q11EJf0JO1/ixdXD9LTW3lzjLitFU
	ncaf25L+vH+nM08GB4Mfn2IFEdgHNavVmdp7Wv8QN7N7LZNVKQrGcCSA
X-Gm-Gg: AZuq6aIwLH05gZXxNMCX0a7KbTSC/+r7KDz2sLcKIyBPfRXikhL2DAKjD9Mz8Bb4hRK
	VL0aY3zjOBAS3ljSTaNQa2YLk6+r1LmqJdoRrCg8VIdL/hN4Qw/Uo7pID7inaeaB82KLyn0M6uj
	/GM7s0OxRsSQYh9vIMnFfbfAeUGrs2m72x5ir/oJbCDmbdBJ6LZS7G79m81k+gbOOpWYXscmQ3P
	2RQ0kh2ACq1+SKHDKKMHRXBYzbu52iyLK6xtpSCAaZAVRGG/tfeS/SXMzFXrxyloW1X09olmV45
	vhoO9gTO/bCHQUg7a4bh9I5HI5O+sSecVXJRGJYKOfoOm4ZFsYLMIWMa6VQgPY7JS6/ZEr1lAUE
	UWJDO3J69AMS30zDynxF9PkYu4Qi1gI29KUMrhPfTNREPZmJVdQo7eP6UbzfIuOp5ZrYaTSxcmi
	2Pi4CZ/FqqPeX/S4GNGI90rF9eZA==
X-Received: by 2002:a05:690c:600d:b0:794:d8a8:674 with SMTP id 00721157ae682-797ac62991amr89062877b3.53.1771330416112;
        Tue, 17 Feb 2026 04:13:36 -0800 (PST)
Received: from [192.168.0.40] ([79.133.247.80])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7966c16eb07sm115610727b3.7.2026.02.17.04.13.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 04:13:35 -0800 (PST)
From: Erikas Bitovtas <xerikasxx@gmail.com>
Date: Tue, 17 Feb 2026 14:13:15 +0200
Subject: [PATCH v5 1/2] dt-bindings: iio: light: vcnl4000: add Capella
 CM36686 and CM36672P
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260217-cm36686-v5-1-63c2de9709d8@gmail.com>
References: <20260217-cm36686-v5-0-63c2de9709d8@gmail.com>
In-Reply-To: <20260217-cm36686-v5-0-63c2de9709d8@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Peter Meerwald <pmeerw@pmeerw.net>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht, 
 phone-devel@vger.kernel.org, Erikas Bitovtas <xerikasxx@gmail.com>
X-Mailer: b4 0.14.3

Capella CM36686 is an ambient light and proximity sensor developed by
Capella Microsystems, now a subsidiary of Vishay Intertechnology Inc. It
has an I2C address of 0x60 and is fully compatible with an existing
driver for VCNL4040. Capella CM36672P is a proximity-only sensor that
is partially compatible with CM36686 - they share the same register
fields for proximity sensing, but ambient light sensor register fields
in CM36672P are reserved. Add compatibles for cm36672p and cm36686,
with a fallback for cm36686 of vcnl4040.

Signed-off-by: Erikas Bitovtas <xerikasxx@gmail.com>
---
 .../devicetree/bindings/iio/light/vishay,vcnl4000.yaml  | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/light/vishay,vcnl4000.yaml b/Documentation/devicetree/bindings/iio/light/vishay,vcnl4000.yaml
index 4d1a225e8868..2ba4d5de4ec4 100644
--- a/Documentation/devicetree/bindings/iio/light/vishay,vcnl4000.yaml
+++ b/Documentation/devicetree/bindings/iio/light/vishay,vcnl4000.yaml
@@ -18,12 +18,17 @@ allOf:
 
 properties:
   compatible:
-    enum:
-      - vishay,vcnl4000
-      - vishay,vcnl4010
-      - vishay,vcnl4020
-      - vishay,vcnl4040
-      - vishay,vcnl4200
+    oneOf:
+      - enum:
+          - capella,cm36672p
+          - vishay,vcnl4000
+          - vishay,vcnl4010
+          - vishay,vcnl4020
+          - vishay,vcnl4040
+          - vishay,vcnl4200
+      - items:
+          - const: capella,cm36686
+          - const: vishay,vcnl4040
 
   interrupts:
     maxItems: 1

-- 
2.53.0

