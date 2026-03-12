Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F7838D008
	for <linux-iio@vger.kernel.org>; Thu, 12 Mar 2026 11:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773316402; cv=none; b=aSCXD9R0FovxZ1Vh8vkzuHZ4UQImuyQZh0W1qBeDJnxqcOvimThCxx/USxeOjC2ECDteTmLJiXIbHmN0/OuvZZR2c4yNQKmNIhr3gbqxd9XYFNzIIqaM/+h2SpTzw88X2qI9CvlpmdSDNcfEI1zSshbHyPw4gF1gTKLCdx1mQjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773316402; c=relaxed/simple;
	bh=2iIh6/jj/6H6G9sjbI72U6v40DlA/kmaSOoZzH3A9CA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TVaIXIHJrgm9EpXBUOPgVj2TJwe+lkY6qd44wqMojmjfuxMn1H+7+7kf8tEH8nmKFTBmnQpiCyne8b0VEbxeu0q9nHAPERQmz/D1IoKj5r7n5KrNTxin2pS9jvcAnWgWP0U1BWxRY0oKquip4zfEAcOt79e5mfXgSkoxdz1jm/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FkyYbbL7; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FkyYbbL7"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-439b9b1900bso617165f8f.1
        for <linux-iio@vger.kernel.org>; Thu, 12 Mar 2026 04:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773316400; x=1773921200; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gk8qVbjj9bf3D7zS5clldQ8atXUlML3S3z10DBlLuFw=;
        b=FkyYbbL7aZoySwQlbBWia42i5HN4GslFA78IhvI6pIY+6+AvbjC3AItvOu/Pev3iNS
         WmLqRlhsTE4yMJSdFXvWI6xt5q1ibXqyuMeTfFtVWkLGSc1JhRDVz9qiUJNlm1p+hmgR
         x3kk+0KA36ukzsm4I0rKPqwTWfHSGXD4Vfo4kq2vyE0f5AEm32EM5Ln3DwagqGAiBTGr
         SLiM9Bz70dahF3Rm2aXvgtnb8yu0QHYXxxx2Pm/LgdF+X/TD8rJfaMY9tAsp+Pj4Tu/h
         4jr60MHL0vNERXC0Wr4BXE7p/lwxbc4Mgo4egckQFTdDLPVSDztgK+kZyoUEuEv/IDfh
         Qprw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773316400; x=1773921200;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gk8qVbjj9bf3D7zS5clldQ8atXUlML3S3z10DBlLuFw=;
        b=XXfmyPa9wHQ+SSLVqZQwYHnDEUvKc3lHFT+GOUHJmHQCzjyCaVmE4sww9nCltQc+Ew
         wsPp+v1m4OINDzZeC2TSS/3aQI2R99EADvVbDx5VOUcDjmKyNTe9BuxveN5bO0k8ockK
         4oh44DK6bNMY4u+aMfezacGk7r4WKUzk52tl76LgJzsWMwkRubdGuh5jTajWHO6IOLuD
         FxrHbG0+fak54vQbK75MylOwNXSXMLNb69chwk+fCvFKdm9Ra9yhVUPN5oY8eQM+/xPP
         Ega3DpytxnzUfGEUK1Zh5qj0FUWrFSo5rjUZ5WNnUow9W0iRXav3ugb9E1NgZiBdA9C+
         SDIA==
X-Gm-Message-State: AOJu0Yzp5HKh1u/EUy2YgFsD7rGcKK51J5Pwf60oWOxwOqw7QPjMJSDu
	dFXCsHc4YsKYbC6Ijq9e7dzLF9N0cJ3YeBpxMaFzdNV5k7Ok63tQmG99
X-Gm-Gg: ATEYQzwvYms4ausLB+QwETtw4TSFkAi33GcbqeDvpgqhXG36H8hO0ZQ0WGhaiSCqee1
	0ebXpL2f9vRTXP3b8JaMn8PLo64Bw2JTo1NTzMG/uVhviLg1VNt9a8q2JLnFDqUJisii1is1zg2
	5D41xnCJcJ7qL63f+bhSoMd719R9qQpIX2CTuwSbVYHHSCpbIl+YMmJpvaAYyvmlL+fQeCFKeOs
	vPDUxW2FoVtysBZNNJBxexRT/d5vL+RNU5MHMSwaacnqOvi2KCsV4o+z5E1ucjm3mf5WjsAJxQ8
	VEWBcZ3k+dYwh36yC4aeOKZldoULAQt/+gsZmEaq/J4wpjovsNOxwCy3V/360FqpkOB2/tsv1os
	RhM4XVNG1GymSFWdINBRqbxpzrgxsyg2t0ylgfi8HrymnduuwCkKjcIyRjwYd+vaKErdyWG8uRE
	hiLaVOBTZ8yZfjUl2Xg2B9kEE5Cw==
X-Received: by 2002:a05:6000:40de:b0:439:be86:5051 with SMTP id ffacd0b85a97d-439f8415d9amr11408103f8f.59.1773316399868;
        Thu, 12 Mar 2026 04:53:19 -0700 (PDT)
Received: from [192.168.0.39] ([79.133.247.80])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe22529csm7044960f8f.31.2026.03.12.04.53.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 04:53:19 -0700 (PDT)
From: Erikas Bitovtas <xerikasxx@gmail.com>
Date: Thu, 12 Mar 2026 13:53:12 +0200
Subject: [PATCH v2 1/3] dt-bindings: iio: light: vcnl4000: add regulators
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260312-vcnl4000-regulators-v2-1-2bdebbcbb58a@gmail.com>
References: <20260312-vcnl4000-regulators-v2-0-2bdebbcbb58a@gmail.com>
In-Reply-To: <20260312-vcnl4000-regulators-v2-0-2bdebbcbb58a@gmail.com>
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

This commit adds regulator properties for vcnl4000 ambient light and
proximity sensors.

Signed-off-by: Erikas Bitovtas <xerikasxx@gmail.com>
---
 Documentation/devicetree/bindings/iio/light/vishay,vcnl4000.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/light/vishay,vcnl4000.yaml b/Documentation/devicetree/bindings/iio/light/vishay,vcnl4000.yaml
index 2ba4d5de4ec4..a1b4c02db246 100644
--- a/Documentation/devicetree/bindings/iio/light/vishay,vcnl4000.yaml
+++ b/Documentation/devicetree/bindings/iio/light/vishay,vcnl4000.yaml
@@ -33,6 +33,10 @@ properties:
   interrupts:
     maxItems: 1
 
+  vdd-supply: true
+  vddio-supply: true
+  vled-supply: true
+
   reg:
     maxItems: 1
 
@@ -54,6 +58,9 @@ examples:
             compatible = "vishay,vcnl4200";
             reg = <0x51>;
             proximity-near-level = <220>;
+            vdd-supply = <&reg_vdd>;
+            vddio-supply = <&reg_vddio>;
+            vled-supply = <&reg_vled>;
         };
     };
 ...

-- 
2.53.0

