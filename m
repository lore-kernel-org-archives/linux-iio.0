Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5034D36BCC4
	for <linux-iio@vger.kernel.org>; Tue,  9 Jun 2026 16:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781021262; cv=none; b=LIuigiMyCS4wGFhN/45ZOmcVsdmV/2jNhmtmfo8misrebOETaI5RY2hHzTCRnqYned+hEFqIHWOTr7w7KczgEd6ZGqZKzHfGsfwcAiY/ZiRDH9Pe2kdOUopT1zlW6Cz6QlPNDuA2yH9p6HRsbTqa42YoTk8ZPoXzJ0iv8c4hPiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781021262; c=relaxed/simple;
	bh=361oEKtxig/ZO4ZBGEPBYw1FqFEZJe2SX/B1yZfG8zg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qGrxM4yE2ymyBu9dSPJ04DOVAUHFf6O90UMsGV2DcE7aal8H4b3h8H9n+niDw8y7HeV3QClaWvi0dkhA0MaMXpDzZWdB1yIz/Xol32+/mW3Uxx+qvg04FnADpC7YUa6U2yi2dAg9VpQ1uYYJgpSPWAi7/ZUdMwvwODt+8Dsj7N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mHQgtB0i; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mHQgtB0i"
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-43ca73487d2so3504306fac.1
        for <linux-iio@vger.kernel.org>; Tue, 09 Jun 2026 09:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781021260; x=1781626060; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uRgcfOA2oS4UODi/g3jRay2TiYVv7cy0S1ZZ/4hXi6o=;
        b=mHQgtB0il5002K27XzTJ0nEOiDEeu4jpXNmJeCWshk9/ccnRBFtFE5APt42AHJ8B6w
         SKDUm8CHayF9yr+vJ9oSYBpcHi3oBq6LHRl/wat3IkYPiMZ3KaS5BUcBZ2sIuEDixT57
         jJ6uQBrTP1tYp8KbHXcQzwfsjuDTFtIncj/AayfLEIF67zwEGrY9JrAxYSZdSUZLoxqU
         qxurnChCARs8+7Yq/rWJX+sCfjkqLWfv1yQjtC9XquCTNZR4G1oT/8qMmBpfq10FZwVi
         6TwzXMBnvhCwjsGiilRLQgqIrod6NatgPVjt5J8Z+ZRw+k7QPM0hJNm6lg1hHcSecFiv
         2odA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781021260; x=1781626060;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uRgcfOA2oS4UODi/g3jRay2TiYVv7cy0S1ZZ/4hXi6o=;
        b=iwEY3oGA+wJ7UkkzgpRL4LcRFn5KywNzmPSUEffbEj7kZ+g6TErGDuSzgNIjS7O3OK
         l7orlRyLRiX4OBs6qM9jCGeescv5YKCTh1oOz90ZYFFjVVji0QBIp+DXAlb0sUzkRThU
         UnCVLLCGTzLkTR09fbqLkKo38WqZ0/fxIzB3aROEgBnn2/kOFcZl+A8B17szYUbc5zRx
         ueeDSU/mSdvTBilgpaSeAsuxVZwwP+kfUmBpP6U6NMbTrF8iQTO4OVVJ0g3B3lYjOOnh
         TSGfDiMLuiBx6sfSZTBnF1Xb/cO2tIw0cGQ8v1qHYeTieA6O7jlUfIbcZ9xv9/ZepP4o
         A/mw==
X-Gm-Message-State: AOJu0YxHJClIbbOVt7rHhcRG+fYXcaqxeIOghP3VSaUJRebwTxIDF90s
	8TuDi7PGr8B8XfzbZv8SXtIZYAGomdTQxqfPGrXoEgEhYYtVsFpLu+n5
X-Gm-Gg: Acq92OGivaLj79GBY/ceoW916nfr9cNmYS1UQRPTdgN0/JQ8S3+8+vo9GBoXrKv2Gy+
	O9KGq5ZG3vyhsRG3Pwj3QaPkn0Yz6g1yqUXtzg29PPWol0aOEIOUDD//gFV6Dwc/2dIzPYYS6EO
	LssdpFmdFwYii7AId++4ONU9PWrP27alwzS2mJltLROqcvixGfIbIH7dKF8H1k/1RaxlwDTTZuK
	232Nfx/n1AzPnmAiukGpKDvE+vcbUUnD2E8XiQ/xn90vYPFS40+yNhqwfpJcbI7wXq/xDx+LdOF
	BpahU/G4SeJhlsWGQ4tHb+ejLEEATLcrnISMcgFuN1pSS8hijv/qqJ6flm/WedjCFGrOzs9+ltn
	orIm9nsBlqBESS6AysqB1CHG73bZIcP/lhjFAdGGYHyJfCrASaeWu7CAu59Cxayt1OJKNYi4zlC
	eCXIwDDDaLeSDjefmn1I1J1ncOP3kSC1KoERCL5VmVCTelGLUQlUCz9/yU1Dc5orG3JleU
X-Received: by 2002:a05:6820:81e:b0:69e:3360:6338 with SMTP id 006d021491bc7-69e6d3bca9bmr6683557eaf.13.1781021260326;
        Tue, 09 Jun 2026 09:07:40 -0700 (PDT)
Received: from linuxescape.lan (23-88-128-2.fttp.usinternet.com. [23.88.128.2])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-69e464050fasm11393859eaf.9.2026.06.09.09.07.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 09:07:39 -0700 (PDT)
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
Subject: [PATCH 1/2] dt-bindings: iio: plantower,pms7003: Add myself as maintainer
Date: Tue,  9 Jun 2026 11:03:25 -0500
Message-ID: <20260609160326.45123-2-m32285159@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260609160326.45123-1-m32285159@gmail.com>
References: <20260609160326.45123-1-m32285159@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Tomasz's entry is no longer valid, as he is not active anymore. Add
myself as maintainer to replace his entry.

Link: https://lore.kernel.org/linux-iio/20260609140712.2e5d1640@jic23-huawei/
Cc: Tomasz Duzsynski <tduszyns@gmail.com>
Signed-off-by: Maxwell Doose <m32285159@gmail.com>
---
 .../devicetree/bindings/iio/chemical/plantower,pms7003.yaml     | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/chemical/plantower,pms7003.yaml b/Documentation/devicetree/bindings/iio/chemical/plantower,pms7003.yaml
index 1fe561574019..292e32d9645b 100644
--- a/Documentation/devicetree/bindings/iio/chemical/plantower,pms7003.yaml
+++ b/Documentation/devicetree/bindings/iio/chemical/plantower,pms7003.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Plantower PMS7003 air pollution sensor
 
 maintainers:
-  - Tomasz Duszynski <tduszyns@gmail.com>
+  - Maxwell Doose <m32285159@gmail.com>
 
 description: |
   Air pollution sensor capable of measuring mass concentration of dust
-- 
2.54.0

