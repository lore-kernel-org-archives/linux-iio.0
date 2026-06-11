Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C72553F1AB1
	for <linux-iio@vger.kernel.org>; Thu, 11 Jun 2026 15:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781192472; cv=none; b=KyM5X4Mh3B+wOeswlfaI7mnkXy2WQOKQ5jkK7U7tY6BwunTCz7FJq7Af3F9H6b6LHX1rh2pa6sDS+8kV6/BPcatH8fRZ41dgziz/4AH8/dTGdDAoWLiYvb7n0m+fTeSoYbs3zvDBGecdykhXTJ1fUJ4Xty5S1JbBa1Dac6pkvfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781192472; c=relaxed/simple;
	bh=ebXLyVr3JOCPXclIGOJBUPNthHBwpZFkakdGzKqdBY4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eRKlz0E50YPMupUnSCdtVDN09efwHy2zggUlZkg6p2xsWpm9bZK95PCdZ7WMpbjHhYrRC1WUjnM1WFe1dcCwj9IywsjUhcDS/xht5MVO+OmcdZfznfSrWbV9qCbafzqhzehFLSMNDibPxSJk6i7W99XQ1LBupjZapYZcVD5bYJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=giJBuZFC; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="giJBuZFC"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5aa5edf347eso5564771e87.3
        for <linux-iio@vger.kernel.org>; Thu, 11 Jun 2026 08:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781192469; x=1781797269; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tzSm4Qq/KxzVj8u8GEGr0oKQBUxc9kOWfTUnQrB6WRI=;
        b=giJBuZFCTSIr3Dk87tE2YT5TCDSzlhs826gw0KZxeZUN5TYmEbOEgWGP3iLmES3bUQ
         I5UssPDloItTDzLUwLRzCO4ZQVdIw3vcrq+EhHIlygMrPaFaYabMDwfy8j0+JF3QS667
         A53lRR7s2zsvmb+F8N2WrNoKFGmcmXtiUXoPrFEA8kK0VRm6Rx8svKkHDT47dYDWy4Y4
         JpYQL9zdXX5X3kqzy2ESbxJNGkoKiu1/v83Z/Je2WKzGNnQqAx6ZUBPbu7YE26Z/QF3m
         fIQG62N06i5imdqNuIO/l3eX0SbJ2fFIArbn2cV2iSI9/weI3pkVyukRUIIJCi9lzB7e
         SlRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781192469; x=1781797269;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tzSm4Qq/KxzVj8u8GEGr0oKQBUxc9kOWfTUnQrB6WRI=;
        b=JvqHroEOc5moftumvad3U4vjA3XlBieaO+2sY1xENcN0e2ZC4NZH7DToHq4a6SSEVk
         AVGkqu7odFmj6D0MG97XyTwoTd4J4HrwzVpepEtDMjoXy8zNe7eFgPAaM70jg72g68bh
         XeFF1gP+P9ZpXC62SPmJKidEF/I++XPvci2dD08MIonyLCsYGGqHdrtRmcuxkYbiUT/F
         Tyg+stK/gl+/1Ck1TxH0D92imUJpoNX5nlBxwFs4nCcA5CMlwFQ+kiTfwm4fsK1AuY3M
         6n6LRakIyZm0atDuRCysT87n/+KeeALsIx6ZsDWFUDriFPXVxn9xBToF+au65+m+fmzP
         ZwYw==
X-Gm-Message-State: AOJu0YxbmHWSz54CYaFR4Hvvss8xvI6aDahzdJ5aXff0/w/wEuz4P1GI
	v+a5MdaQ4005UtrgKarNjVx/GeNqGVV7JybHGVtzume8UoXyQGeNKIWH7kXScexfzHE=
X-Gm-Gg: Acq92OEQDA6FqYw1kC7c/hxm2zv0553m8mwIV9V2cDCxmXS/qbpKDX8d+aJcvhVpZcV
	UprJxou3rgmo7V5oTuLvdpMcqvOJhWxH9T1zOsfRa4BL0aDicm6s3TAQ26mAu9zUyyPtlIkPpFc
	zMGjVl2bLTHlESpyWRygP8aFLgzBCvt2gogee93KPwP1ZW4ubqqXD9KCYzR45aJYKxC7oHQ3QQm
	uH/iPgMpUVBvTcYkiVGiQ+X7xKJ90lMG32/yUrCNN7bHGdnsjo3HkGxZq3eRlc/mpoTBzVA5dOT
	31j+lUv0/dRaNg0UTU8X1EMiRdn7I72B0YbZBb0WAt0pvr6XOx+Gz5QvvuJ86Sh7umHEu37ufEt
	owmzN+ndw6pOEFlS9eUmDh9ojxNCtTnZNDiU0qFmaaqnpOovUOgdXQfMhF9NCeGiwhhgbm9g4i8
	Y3nYGLohWQgQ/UDpd4FhV2d5aQELfZX6bqZMAO0boKICP98FTETk98nkjpmg7FFvkUcvIbOxc3i
	SEtsw==
X-Received: by 2002:ac2:51cb:0:b0:5ad:229e:385e with SMTP id 2adb3069b0e04-5ad27fb709dmr1021446e87.44.1781192468919;
        Thu, 11 Jun 2026 08:41:08 -0700 (PDT)
Received: from Shofiq.home (87-92-251-137.rev.dnainternet.fi. [87.92.251.137])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3991ac81488sm5994641fa.1.2026.06.11.08.41.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 08:41:08 -0700 (PDT)
From: Md Shofiqul Islam <shofiqtest@gmail.com>
To: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: jic23@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linusw@kernel.org,
	linux-kernel@vger.kernel.org,
	Md Shofiqul Islam <shofiqtest@gmail.com>
Subject: [PATCH v2 2/3] dt-bindings: iio: st,st-sensors: remove lis302dl and lis3lv02d from deprecated list
Date: Thu, 11 Jun 2026 18:41:04 +0300
Message-ID: <20260611154105.3727-3-shofiqtest@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260611154105.3727-1-shofiqtest@gmail.com>
References: <20260611154105.3727-1-shofiqtest@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

st,lis302dl-spi and st,lis3lv02d are being given their own binding in
Documentation/devicetree/bindings/iio/accel/st,lis302dl.yaml. Remove
them from the deprecated section of st,st-sensors.yaml to eliminate
the duplicate compatible string warnings reported by the kernel test
robot.

Signed-off-by: Md Shofiqul Islam <shofiqtest@gmail.com>
---
 Documentation/devicetree/bindings/iio/st,st-sensors.yaml | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/st,st-sensors.yaml b/Documentation/devicetree/bindings/iio/st,st-sensors.yaml
index a1a958215cdb..ebe9041f6326 100644
--- a/Documentation/devicetree/bindings/iio/st,st-sensors.yaml
+++ b/Documentation/devicetree/bindings/iio/st,st-sensors.yaml
@@ -88,12 +88,6 @@ properties:
         enum:
           - st,lsm303d-imu
           - st,lsm9ds0-imu
-      - description: Deprecated bindings
-        enum:
-          - st,lis302dl-spi
-          - st,lis3lv02d
-        deprecated: true
-
   reg:
     maxItems: 1
 
-- 
2.51.1

