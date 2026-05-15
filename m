Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB812D877D
	for <linux-iio@vger.kernel.org>; Fri, 15 May 2026 01:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778807803; cv=none; b=qLGfYZw7/NTRnXAGDUHdUWp5JR115xSDOekKVqZawV78rTXq3uNovBymlQnKsnm5IdjqBY3lzvJIt1ftcvxKDNaMYGu/WyTug6y3b5gCUF+tofVcl3+Cp7p9ICb3ZXpXJRXLQ3iGZxpq6yyUrb7YMRQW3iaJAQWy4WpnqnwujFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778807803; c=relaxed/simple;
	bh=JC8T4gNfzFadEg85bIUUZFK4R4slQOBV7n/tMER/kEc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VHIYFbepGG2rk6+2+30KO4vw2Oe1qu05N85ut3I76d6/0ldq1zfKAQPaHzCFFw7Wwqh5fFY/JLWUCaAjz4Flzn8cnaJtKF0l5zEUXbBIjgW74wdfx70FcT2n8d49XHfmvmunJz9Vi5BkZrsv+3NABXsMcrjBX7sYcoZu6EYiMNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LVkteZQs; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LVkteZQs"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7dccb8644c4so4491734a34.0
        for <linux-iio@vger.kernel.org>; Thu, 14 May 2026 18:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778807801; x=1779412601; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=etZdfywDlWxrGaBS3U+i8QZ6+5a6GwMR13z8kxUpdWc=;
        b=LVkteZQsyqF80ODMYmOeLU1JeM+HAt2ouVTZcrkpUbcRikVls+Uqwj5YyhIBEnToqk
         FRjZQQBlFrDXBu2hyFT4DUvg32nlDNdfu9Tudb1P6uat8jrwsS41vv6/iNb0Z43rO08P
         QxmGOFAieK5YnIRuhT2QSySsgaUcayg9owYBfU4bdbx3/RzYMjZCpc//oaoAG60d0e0R
         Bc5T2CsW5jAaiZeHlEHXfBawbm0fyzURulUrTOa/j5gMzYx9y7lgZw4bV0EZWrt9lhPC
         surDjgMUknKNr2DdMfWlcyqe5gyXLJpkZr1UTJra/qq1n6zuPYfpQ4CHG4wLd7IiSJpJ
         wMfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778807801; x=1779412601;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=etZdfywDlWxrGaBS3U+i8QZ6+5a6GwMR13z8kxUpdWc=;
        b=LdORA6/56l+t88GteTB6/WtPgpC067cDzAvK76b/49BoJQP88l5r9B8cPOZc916aoQ
         SqF2Vit3BRdbAGw7+QW4EcG+dOul0z/k52HwYkTnbj7SLMGAKhdjH+m8ceNSFtzQ9Y0P
         2686B77m2cJlwjqoBDH0f25r9/p/9iQtCoOuqtc+oqEz8MsQpZhVR5+h2vfKbqnxh+9M
         SdZzIS63UtIoFOJeRoZCpJjo37+GALboXN7/4oOYUeoBoLGYtS5fziEAESkd7JD2P3ue
         LhYbTmZBPArT+c+A03j2o0s4keT6m8IjH8TfIe1yLYqYOA287zW0usUMRDAFyguZyF/h
         DWTQ==
X-Forwarded-Encrypted: i=1; AFNElJ8RlNsafFszxbv0eQcwxZq0fKshUsrK4p5HCbTO72Iv5phwD5FEpkRYCPu7bO3bfk4z2YKFW8drvT8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYDlLu4n2EmerYzRy4NN4/ommKINNRboaq/puEU3j3TTKIlR6a
	aXCVN0jlqZHwnAPIfV+I9cOiUWk8liSQQbE/L/KU06v/vaLBLzrTYdpC
X-Gm-Gg: Acq92OGaQlFKwGifTOvqDI+CTAT9CUtJcqnD1z6NvgsikuG+96icpzcKHJ3Ijhh7vgi
	HKafGh0oJq9ycAe/d6+trJTKxIaHAhyr3VKb06dYFdgSoEvWeRksty1Fz/fYWxu2jzjsbuSitZf
	VtXKoIRPPWb491j5H77zwPeFinqmvH9qOjZlHdBX/nTpEEUUpIVIPMsW2OY3+MM2axTbCtDkta2
	Gqnn0bW6PiJB0+ADNoDd2/NoB58+grKKzfhce1cV2owijiHLnJntc3VhgmhKXa1AXDa2Mr9VM13
	s5AhPYq0P8krQo1AFCMWcaOrMD0+WsC5O62uetVjyoo8/SAehnkSGe86lzQ4MQ6+bNySDPLN3k0
	WIpGCH7kKJmwO4sOdq3piWGQzZMzFGcA6ts3OnPQlIRgElq6IBQoix/kqWaC3hbyvTqVlS9WUKP
	vFNEXN3W0k1q25B1/qp+14Ts6eKGppuYdcyUjBETatsCTIHkXS0UtclSKiLQ==
X-Received: by 2002:a05:6830:d01:b0:7d7:ed69:81b2 with SMTP id 46e09a7af769-7e4ea071959mr1148758a34.5.1778807800752;
        Thu, 14 May 2026 18:16:40 -0700 (PDT)
Received: from linuxescape.lan (23-88-128-2.fttp.usinternet.com. [23.88.128.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e55bc4983asm110362a34.26.2026.05.14.18.16.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 18:16:40 -0700 (PDT)
From: Maxwell Doose <m32285159@gmail.com>
To: jic23@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: Tomasz Duszynski <tomasz.duszynski@octakon.com>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] dt-bindings: iio: chemical: sensirion,scd30: Update maintainers field
Date: Thu, 14 May 2026 20:16:39 -0500
Message-ID: <20260515011639.28570-1-m32285159@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Tomasz Duszynski is no longer the maintainer of the SCD30 driver.
Replace his entry with mine.

Link: https://lore.kernel.org/linux-iio/20260507172404.80435-1-m32285159@gmail.com/
Signed-off-by: Maxwell Doose <m32285159@gmail.com>
---
 v2:
 - Replace link to git.kernel.org with link to patch at lore.kernel.org.
 - Fix typo in subject.

 .../devicetree/bindings/iio/chemical/sensirion,scd30.yaml       | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/chemical/sensirion,scd30.yaml b/Documentation/devicetree/bindings/iio/chemical/sensirion,scd30.yaml
index 40d87346ff4c..a5b0debe85b1 100644
--- a/Documentation/devicetree/bindings/iio/chemical/sensirion,scd30.yaml
+++ b/Documentation/devicetree/bindings/iio/chemical/sensirion,scd30.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Sensirion SCD30 carbon dioxide sensor
 
 maintainers:
-  - Tomasz Duszynski <tomasz.duszynski@octakon.com>
+  - Maxwell Doose <m32285159@gmail.com>
 
 description: |
   Air quality sensor capable of measuring co2 concentration, temperature
-- 
2.54.0

