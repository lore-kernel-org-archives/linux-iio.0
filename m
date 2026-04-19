Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D36B3793D5
	for <linux-iio@vger.kernel.org>; Sun, 19 Apr 2026 08:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776587514; cv=none; b=MLbQmAHmIc8AsdZA4FAwLg2TK2sSn30CrUqLvNmsRnqLvA0uK7kVTL7KWEDM4l2MubMeR4Xyf4euYO3inYpMv6xvx+6hAk+nh02rk/dIkxgykYgwX1U4pbYx2Y5Tq+AhzCq/dn4vmiMxD/QwsNz4d/CLkeiEZ+0rv61LAeLRXnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776587514; c=relaxed/simple;
	bh=1Jgb6/GbiYn+9y/qY8drz0ojO4Ovh+iCQsfw7Ms1hyY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XuWeOt7MXV/yn4Q8A5QUKgpNO2PWYRm/62AHyIaDfCfqZrSrEEPZrtVqJJGpCsCjBazOkshlyhzagArLtm/6ePZgt0y4oBEQCd5a/k/A2XDenPOdGzsfjKjgRod+H8DJ8JLBph/eb2BkW3z1JPO906WU4LR8Eycf9j7o6hauYyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XpDw5u+u; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XpDw5u+u"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-38df1889fb9so19641361fa.1
        for <linux-iio@vger.kernel.org>; Sun, 19 Apr 2026 01:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776587510; x=1777192310; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4TOenN1wWv7IAES6T4cFxNtUEJCBx2lMIL+l6+xDZLc=;
        b=XpDw5u+uX96w2pPAr/Yi8wsVCRona4gYll24j58DMOUWWWKbRsQMjHeda4BvbTRrJY
         CybB88R+M+YR2onpaYBrKycBS6p2O3RYBXeFXVBvDJmuzGP0az6ubYvz/hsSvWly4FWU
         lJJI2ZaNDdEMeMNQZZYTaoLjIX/SpF1oYDRKHDKDuqx0U6/pepXpyeYhxEuzFu3Own9G
         WEyN1FQUSKoNtvuupq5WnZ9Qxnro8FTYg/62jWKL+ejLSQmjHQUURye++3hv5i5Taanz
         di6URAnML3bb1c038d7fsSOwc/xa2rxr+UoZ8UitHTX8gGownd96UR3uCNs7IE+uJ7KA
         oVOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776587510; x=1777192310;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4TOenN1wWv7IAES6T4cFxNtUEJCBx2lMIL+l6+xDZLc=;
        b=qca8m6n8TqZkWHa63OfcXIsQ64J79BPA5+mGknmsz3vYkZtB+18RK7WP/bXx4nu68h
         qX/v2j92YHkkO9Iicz/2xBkGDQMb4u3zWAhAbcsF23hhzznHSKtFoN71GI8SVRvBRuzy
         VsaoKsb9ZrwhwNKgUQyTHgQMOFWR+1sCeRXviPb9JforcHdvUamyvmkrbO9FK60CZryA
         UJD0RH6cDzReazlYh7xenZoAuZ++CciRSYrKbnMy151EN+w3dChMN/H+CsB0USDpHy9D
         hi81NuE1ai8GJJDz8BQsn8F1woPfsnBQ9VpsL1yApfwWpl095+MDQgarfwfHCjL/Nx4J
         znsA==
X-Gm-Message-State: AOJu0YyLQABur7sGcyyq48I0feAjfBdPiszb9hGC+wwxunUhykOXSF1Q
	TpvPwGW8KJ/Z3RciiWv9yap2/fH92R+hpfjYLBQl1ADSgQAPmejb/PUf
X-Gm-Gg: AeBDietedq55NamC1mKGPPSHJ8m/KcGHRzH+/CMN6rAw1V6Wq/Fm/rKQL1Ag4fV7MbC
	Yo48uV7Eb+ZsKrbm0qQRB/xrMnJXZ8cKTJHLUb/JvlU2CQw0rpVv+Vo5a53/bnwotR6YYVnD3mw
	hS8fMA/jygVSUR5WrcmDw7l47AxfZt5A6AVE/k0lSKUc76K7pHD+2kkZuWBj2eb4S+HowBAE1h+
	OOEvW9knOMiFHFyu07OPMUmA8HI/fF8UVbiZiCJ4VekA9SPz1/G25yRA4HKp0J4+UOyk584BVvB
	1UoEjdKNnrb2CD1sjSH6R7hKaRYUDwTGMFXtjM+Bck9qdvyeKHqx37OgwMS6oO7zpRSiArtmgSV
	ZfWfGPPDv4xx9YTEf7t3DcGaInOXPbvNnFWOYeHcFz4s7oDDGoNnwcpyrJtVT5fUIad1roR3AUc
	6KLWU9cOAAyJP1G7ShJdTu4Ds=
X-Received: by 2002:a2e:2e09:0:b0:38e:94e3:206e with SMTP id 38308e7fff4ca-38ec7af74a5mr20338171fa.26.1776587509823;
        Sun, 19 Apr 2026 01:31:49 -0700 (PDT)
Received: from xeon ([188.163.112.56])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38ecb7613a9sm17852101fa.41.2026.04.19.01.31.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2026 01:31:49 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	Randy Dunlap <rdunlap@infradead.org>
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH v2 1/3] dt-bindings: iio: light: Document Avago APDS9900/9901 ALS/Proximity sensor
Date: Sun, 19 Apr 2026 11:31:22 +0300
Message-ID: <20260419083125.35572-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260419083125.35572-1-clamor95@gmail.com>
References: <20260419083125.35572-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document Avago APDS-9900/9901 combined ALS/IR-LED/Proximity sensor.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 Documentation/devicetree/bindings/iio/light/tsl2772.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/light/tsl2772.yaml b/Documentation/devicetree/bindings/iio/light/tsl2772.yaml
index d81229857944..9921ccaa64a0 100644
--- a/Documentation/devicetree/bindings/iio/light/tsl2772.yaml
+++ b/Documentation/devicetree/bindings/iio/light/tsl2772.yaml
@@ -26,6 +26,8 @@ properties:
       - amstaos,tmd2672
       - amstaos,tsl2772
       - amstaos,tmd2772
+      - avago,apds9900
+      - avago,apds9901
       - avago,apds9930
 
   reg:
-- 
2.51.0

