Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55EC02472AF
	for <linux-iio@vger.kernel.org>; Fri,  8 May 2026 22:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778280904; cv=none; b=CbWEsLspc/GJ6K67WhRwhnEf91AxzVezEmy/MqDt0M+fgWdd/nUOWF48MEGGp8JiEBE8iKIgH5/mF2tKMuUhVSba7y9oVHlnQJfxr8qXUxXDccic65Db6WMehPm1beLy2o7cMW/I2N9wwgHqr4jM53ls1CzVPgLn3H5VzD20aeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778280904; c=relaxed/simple;
	bh=C4DdioHlKblR2pOalMhqvj/UrE6TkBew9JMitN6z9+o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TslmdHr1KEvaLk4RwpPpEXNKYw9KCa/yy42H+bc9DZrlyGSnwDCV0jHAjmIdRwxzNE0J/Dzml5r0CkwkZHqNuTby4mrJS1ahI4gU0XdpBHomzl4AgUhjueTSO3pF37t1xWv6oPRmAQPQVeMA0Lt+mWe3dr6HBKHlSFJ0Ec29nqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gAgZFIWR; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gAgZFIWR"
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-479d9b155deso953926b6e.3
        for <linux-iio@vger.kernel.org>; Fri, 08 May 2026 15:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778280902; x=1778885702; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ysm2TozgbUsrtjJq9sRb2YZ4RYrD6/2s+NSBPl2/roA=;
        b=gAgZFIWRb0lPxOn4tdk/AUfpLswHVvhIPShVTWjx5ZcVJhiRpd682qxWo0zXlt9zTO
         3PtaZ+0A3TjcFvMSBrQrOQEoPOOsGr1N9FWXNn+JX2SySK+yeswA5PgsRy82QIxYxGWn
         s9jog92vcvDEcYkIBouS8f3eYTHceCzTb+RuoJnyrVfxia8avSr0Lq86esz1KOmkqBKM
         OB9T1asjzwxfybRAkRr1HidKE9gfz1i4fyDv9lMp1pfbzAcfmcfcDfoSHCtVS5zxbuDM
         0d5qUfBgIVeTST5cs5qiZ0qX6p2hOvteewRPMPsikxNxhtMAkBF8GEGaBk3Iy+TdtXcV
         dyTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778280902; x=1778885702;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ysm2TozgbUsrtjJq9sRb2YZ4RYrD6/2s+NSBPl2/roA=;
        b=FBZWDh3rRMA00i8E2XzqKeXJgWkS/Ai7c8C526DKFLMpHVCzZldenQQXRkbMfT9xAl
         kaqMlnf9iskBirBRxICg0jJCeEIOzQ1nXkT5CzxZBRMnqu5kndfkr+bzHxT9HiLf5rkx
         FAMc/VldQbzv7+iQuCrnFg+a9x0laiFRkbh9/GSuyYb2/W07TmIPoVjOmO8abEe1uQVp
         4PHSoB9GLS+4iBtCl0ga12HEPKZZ8i1Er6K8g70hk2QeW+F4cKNyqMCzTKHZK2VMRSSc
         qjlejC4a+CA+0rCJLC1vXd+u+epXfeZ06qfp8jrB+wbb+T5Xap9W90o3zkLiQjyD0PX/
         0Wwg==
X-Forwarded-Encrypted: i=1; AFNElJ+4gfJ0fjb1VBrBOLdWidGSb+u44OLI0vEgPg2BVBQcRDKw+MYkB1LzP+DgL00HOal8OV5GObYEPvk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywk6gGWNcMyDobH8u1eejPSBnQjPiT7c5glODDACOozZSCJujwt
	qxBTz60JwxbiPABYFXTas7WTd/0VVlPexoZOKmx9U6+tKu0sIrlCUE4t
X-Gm-Gg: AeBDieuXPPrUE440mL+Nz10D4UlT9VZbPz0P5WdiLxMyHC7YdQTLWjnz3RAor5EiH61
	6SMf6VDyy+CgQKHioLEa375dqmzEDkiTAjc4N7JQiCEgE1ozz9cAPh6y3bac++yQZFUfGHKhMpG
	TdP0atEAEKxD9TQFxyjLe9HBSvcXCoWfgjsTff6lzKIaKl5ZWGwW02/WxO9jNTpeINiX6ZPctcx
	pvs4aEniZuV0FCbSvU8B50//RpXTFYCBkWysM9gPlxuTtDBfrr1/GskUWcxbGUmcI/D1vAViz8n
	ghfs30ey6eWWGH4Cj0qIAwKtdfhgC6yQGk0HDGaeIRlEVHjHyj4HR2WeJlmxl4WsQkIK01OKyw0
	B799MSvxN+9wwI42kIuenw5B6wfWAAR4xweC1NfMXtnisyl2rQ9Per9GIOv62wV6gXInutjYzok
	TWWKwPxxQpashXPKsWNjsfCDTa2WvdPQuiGJ7iukHdENBJFGTeTxYVa8cGyA==
X-Received: by 2002:a05:6808:e3c1:b0:479:f526:a148 with SMTP id 5614622812f47-48042496b34mr6549527b6e.25.1778280902291;
        Fri, 08 May 2026 15:55:02 -0700 (PDT)
Received: from linuxescape.lan (23-88-128-2.fttp.usinternet.com. [23.88.128.2])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-47c763ffe6csm15629558b6e.6.2026.05.08.15.55.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 15:55:01 -0700 (PDT)
From: Maxwell Doose <m32285159@gmail.com>
To: jic23@kernel.org
Cc: Tomasz Duszynski <tomasz.duszynski@octakon.com>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] iio: chemical: scd30: Cleanup initializations in scd30_float_to_fp()
Date: Fri,  8 May 2026 17:55:00 -0500
Message-ID: <20260508225501.86448-1-m32285159@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current variable declaration and initializations are barely readable
and use comma separations across multiple lines. Refactor the
initializations so that mantissa and exp have separate declarations and
sign gets initialized later.

Signed-off-by: Maxwell Doose <m32285159@gmail.com>
---
 ps:
 Hi Jonathan, I noticed a potential divide-by-zero bug on line 241 in
 scd30_read_raw(), where the value of tmp is dictated by hardware.
 If the scd30_command_read() call on line 236 assigns 0 to tmp, then
 when we run:
 *val2 = 1000000000 / tmp;
 we'll get a divide-by-zero. Will send a patch for this later.

 best regards,
 max
 
 drivers/iio/chemical/scd30_core.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/chemical/scd30_core.c b/drivers/iio/chemical/scd30_core.c
index a665fcb78806..be8c055be184 100644
--- a/drivers/iio/chemical/scd30_core.c
+++ b/drivers/iio/chemical/scd30_core.c
@@ -89,10 +89,15 @@ static int scd30_reset(struct scd30_state *state)
 /* simplified float to fixed point conversion with a scaling factor of 0.01 */
 static int scd30_float_to_fp(int float32)
 {
-	int fraction, shift,
-	    mantissa = float32 & GENMASK(22, 0),
-	    sign = (float32 & BIT(31)) ? -1 : 1,
-	    exp = (float32 & ~BIT(31)) >> 23;
+	int fraction, shift, sign;
+	int mantissa = float32 & GENMASK(22, 0);
+	int exp = (float32 & ~BIT(31)) >> 23;
+
+	/* Determine sign of received float based on IEEE 754 standard */
+	if (float32 & BIT(31))
+		sign = -1;
+	else
+		sign = 1;

 	/* special case 0 */
 	if (!exp && !mantissa)
--
2.54.0
