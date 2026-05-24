Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902D13909AC
	for <linux-iio@vger.kernel.org>; Sun, 24 May 2026 08:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779612845; cv=none; b=ASBo8H4xLACvrr/dt/7FFELYp3eXuCSqNxVjTMV1Ve2C4m/OBKjPYWFy8TS1ioYEygoC9kGLve7SKIdJj5EX9O3a76M0pvZLDSKPOyjUI/thU4vA11vf62dxp5tIjabZzkajfGBug1T1ffTtPthUrmijOCedfnnU1ZfUbPZAU7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779612845; c=relaxed/simple;
	bh=KoZohLAP7FkG0DiqRHfnK9gUGT1fB3petwusbNr1K2A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WCXhisxPvr7gQTT8H+R+a+yE05o6pyMnO18uWAO+D85cVsus3tTMxaQauA+gOK40mFM1vEy1dwTjwsblx8spUc9ODgxr3i+uRw2QE3EUzhpR+h69/iwGSH3d17JDeUAxJEQ0Emg+HSRR98xBFfRz1ZLzP2EpK8GkooMPXqiJpeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cVypAtYq; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cVypAtYq"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-83537a80ab6so5996179b3a.1
        for <linux-iio@vger.kernel.org>; Sun, 24 May 2026 01:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779612844; x=1780217644; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LU/cOHKYJiwHIi210zVuGwmaJ7REyB2Sgsxuvm9SfTg=;
        b=cVypAtYq0H3iaxgMjzULJipOh4J4C4aXmwdu/PiyIyQmy8YS5xAAS/DT8/cxh2bBu6
         qrexfovdHBXPynz2/3RsSvwC9ZwNp1XvC4INqbmMhXPLieyl0kKIJ+KDOgGycTKagDby
         V4tMF//E+2h+I2LrEMdr1zlxLTxeAFTU0Ad9ALCLQgvZKDyEf9gMCzzpwposYHQi4l3y
         GE2LXKakOgbH6WqK8w8nEUBzGd39L60jmXCLsSk9pBBaxWrcdX4nauSzuV6clgqXXEaJ
         gb1pdH7Q+zriQQ9DhEouz+zUYEfpqjwB4hsJDaSAQ/b+PSe+Zmlq+G5Ds0Yem9bJ9+uH
         mI3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779612844; x=1780217644;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LU/cOHKYJiwHIi210zVuGwmaJ7REyB2Sgsxuvm9SfTg=;
        b=iYwpEJrnfLsAkIZ4B2JxdijD7yrYTW//gSiTi0FcwWJGxb0MyywQy02s0dmTtdklUI
         nR7yGCjVErrdFbmpL6fOc9t4UPYN7B6w91x7WTN1P1b/ZYKfDPN/w1rAVk4X1KfTKVib
         QSf+7gdFzCVJkUG43pid1fyaRb30SkjJYgGyGB/7k2uWqamqXFbFy18s9QHzEnaKVtqq
         aam1/5Du3XaCxWRJxRXrVS96pKAXIEe3U4XQ6q1PxOdmcYsm79Ld2EfPRxLHV5pZEZ05
         895Lw7to/tF5yhlF1By3edrDg8lq6DMw4N5KMk222uECVKXV0dGTm21GkEmLdZD7HtBL
         PRgw==
X-Forwarded-Encrypted: i=1; AFNElJ/aw2RASBBa49EoOZRcxufYR4DkWbOyqO58WJIqQhLLSBG+vX8k6tU2ANJhvj8czUuBD50838NJ9m4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLDKU2OYSbaupWwAoUMRRpgz31bLGHU8e9KlgcK66AaSpe94HE
	+t3tY+ZcIVQLbzNVq/3RXSXU/GGkeTDcv1urDlbvhTfu9vAuoFXFG3gb
X-Gm-Gg: Acq92OEEjv/GCrCB1pZA9UWwQOvdbOa2ssjAq4+rqWeQ8tx8Wn0bePBV2h1A53xMROl
	E6+dg7Pg6oEybTe0zRvIXYtv+QRr9glXyuwLy4a1f/Jxhd9fTGvSzoVMOfW8JDAumxUgFTFSUfZ
	sa6FjVjutmqI0LjpBkKh+du2zPFpGsvzyyG795KSiLDBETXlbg+GmZdBEK0vCrFY9T5jp8io6ln
	o9Yx1OvVIKS9VO08dBYabjC4ZVvJHtKw+Ostk8cwexdKHKH9zTvz/ubXGTUTGv5Tbz60PPn64+M
	AY/iDJa2OVsrZ5ADmL5yY1vq+A8/gkNX3r7a26FkO+fwYgv486SIGrHQu60kVvD8cdwV8bS3u8i
	pvc1BLz12utzFA6xcsMzR8lYMnnp+keADuiNx0TWMUjwIecpBpMIDRuhsROvJxv2+QAS8BPXTdc
	cFXro8oksi8noEK288KjlCmU0/b9bJw0nyRY1f71wogE0pQeEO8xCUxilNzGix9NbrKjWu+kJul
	T5F7S4bTbRWtDCZSbLNDRsMnfKuva7NwqKiRQ==
X-Received: by 2002:a05:6a00:3d11:b0:839:dd77:3501 with SMTP id d2e1a72fcca58-8415f11f2d9mr10041656b3a.1.1779612843893;
        Sun, 24 May 2026 01:54:03 -0700 (PDT)
Received: from DESKTOP-G3E0OSP.localdomain ([112.172.255.242])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84164ea4de4sm6353116b3a.35.2026.05.24.01.54.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 01:54:03 -0700 (PDT)
From: Jinseob Kim <kimjinseob88@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jinseob Kim <kimjinseob88@gmail.com>
Subject: [PATCH RFC v2 7/7] MAINTAINERS: add Open Sensor Fusion IIO driver
Date: Sun, 24 May 2026 17:53:12 +0900
Message-ID: <20260524085312.15369-8-kimjinseob88@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260524085312.15369-1-kimjinseob88@gmail.com>
References: <20260524085312.15369-1-kimjinseob88@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add file patterns for the driver, binding, and protocol reference.

Signed-off-by: Jinseob Kim <kimjinseob88@gmail.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index c2c6d7927..9238701f4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19977,6 +19977,15 @@ F:	Documentation/networking/oa-tc6-framework.rst
 F:	drivers/net/ethernet/oa_tc6.c
 F:	include/linux/oa_tc6.h
 
+OPEN SENSOR FUSION IIO DRIVER
+M:	Jinseob Kim <kimjinseob88@gmail.com>
+L:	linux-iio@vger.kernel.org
+L:	devicetree@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/iio/imu/opensensorfusion,osf-uart.yaml
+F:	Documentation/iio/open-sensor-fusion-protocol-v0.rst
+F:	drivers/iio/opensensorfusion/
+
 OPEN FIRMWARE AND FLATTENED DEVICE TREE
 M:	Rob Herring <robh@kernel.org>
 M:	Saravana Kannan <saravanak@kernel.org>
-- 
2.43.0

