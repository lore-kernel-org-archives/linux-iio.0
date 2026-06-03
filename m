Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0574779B3
	for <linux-iio@vger.kernel.org>; Wed,  3 Jun 2026 17:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780506780; cv=none; b=QHptmKQdhtUWIvd1bP9lMMGkOdAZ/sIcUY5E9BeW88rooiqooUSs/W/wXoD5dX9ZNYChM98Mi8jxQVFaVF1lIc+NCO8hUHeG4/UDMFJo3kCD2+YFs1M+bYiClfCICUi8yU70bGK2aBE7aACgK6T1R4PsBntp7lQnhJhKgwGD1Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780506780; c=relaxed/simple;
	bh=LykF7kDE88zomYF6W/24KVDMDse9RknyfnBW2IyXgj8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VHxTYQEldEWgWqmI+gndURqRZR4TqXUMa9CEjoKjQylaUiEbooMvvyA+9jZ6Qod2XriKaoXvEsrPOiE2vgtRYIlkIlMg8G2A8UnjTNmZcDKLNN2lmtgUDG4Ld2K5Nr2gjWERhK4wlh0f4EVQCy3x1KGNTAABu2O05kgatNaGItc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BBywPZmY; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BBywPZmY"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-45ef1629ff4so4413364f8f.0
        for <linux-iio@vger.kernel.org>; Wed, 03 Jun 2026 10:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780506777; x=1781111577; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4BYCzX7AdlAVMBcwi37iulKK+FCsXHV5sM1hbNOOcUo=;
        b=BBywPZmYAXfZiGOSxxLx7PuWvjggXqbhCaRnK/oNRZoUzvyQ0yi6k4ljswqWtAstVa
         wxMxIEQelKlibGVQZvFAClGAqeN5MqtgBowrseRCKDUU7sAm5Sa6d60SlDbrVpSKPgc4
         48jUBzD3RPXBXxXdiL7CkUsulH3oybHLsNwDPcSwo3ZX3nq0b4X+3yThMvXxTTaM++6T
         fY4HLdEMWr0DDYd2UH7Ut7BfUj6tLkfVzt3VWYQwa62uXmhBKOP8XBA6mdJkkc+RO+g8
         q0u0+Un/WwLJi3zvhXpFVPeHX+r2BDmXdB0Rx2qjlqOcN8VqlnTC2QxHC8fJ1VcFtlPs
         VaSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780506777; x=1781111577;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4BYCzX7AdlAVMBcwi37iulKK+FCsXHV5sM1hbNOOcUo=;
        b=VY3R5PfzS97wAj5BjRCITS90QsWZkhep0oUB71OwRdZZi/8a0+NJTjCakYSCO5Zcol
         aV1ArCOJycXNfkccN49Sdz8Ts+8D0eOkua3RQM0lfgjHvHJxtDCCPr4fka0TAbNUM0JV
         OC1sUlmHDKtHzTgPrJiRPHGrHwZfYa9WfenyuWvDbmorW+e2VKFYabehTz+qDyFoDUK7
         S5YseL+KwzYGbZIuTrf82fS/BlNB6RXtFlz6cIhrDlsZoGTplXRPkNHf9AEgyDMWvYjk
         asCPnoNPNIZ+SnL1+w5dmdJmSe1VsBWZQ7x7pHdQnsJJ7l7x4pEQtlSqEmocEOn4SmJo
         LOTg==
X-Gm-Message-State: AOJu0YwroVHo07lneugonRmyxOQDRK+Esxu6ruWc+f2T9+DSorOvFV6z
	zc4AEX4mUli03hGyaXB6iX55M/5b4/u8mIgZ42ZfiWQ0wT0sHhsMsE0g
X-Gm-Gg: Acq92OEiwutOSMu3gpBWM82BShVRAcrsDAv2ie78p6TfFrUYrxqaDZez7L2VIwjnxJc
	KWNnAfaSHKhwnpEw7fgp8aoYmglALQvW8yy8z2sPQXPxJ3P8tLVhUHqkiY2iogBUIbeoIaVulPa
	PuuivDcHb3+JNbBfgdwj/l0TL6Wp3MBrUdjn5v9VM7TenzkBFX+R1OjlBcbJt52DErrxfV80Wn1
	//+dbmF2y/dZP6xAv4e4ViGeVntbOIX0ETKKgryLUHPlRmzNK8iwr31phKiF2/3+EmJ7kjds98p
	ji8IDwjdr6DE6XEgXoUE1tZpnDm9LEiYvNEdWZ5PZ9AHkqr+TuKpez4cg5FSSK+aLKEfvSVWe5k
	0lNzGPX+twa/f4x6+ZSpnWhF/tugNh8AMB7PYbVj2mSrZhRoh3sIe4QyNQJtK5udPBezg73s5Bn
	s8cj2VQMhjpCwEqmr7ga+CGg2x043Ygj2+6tE3OHKc3GOn3d0tcyU3wNlaKYobMFaxBE/MzDQkz
	uH1riqM2dpo7YJExgdJsi+buxHhqh+Aq5VypJgdL8YyNmm7oHCtpud8yXgL+VHP7XZebS7gfcEt
	ULgdePMXRNqyq2DlExY6pdmbgtNvI/VEUZOSthIrX3+HskiAi94=
X-Received: by 2002:a5d:4bc7:0:b0:45e:f266:f4c4 with SMTP id ffacd0b85a97d-460218433c0mr4918691f8f.29.1780506776796;
        Wed, 03 Jun 2026 10:12:56 -0700 (PDT)
Received: from [192.168.1.187] ([2a02:8308:4092:11f0:c287:187e:fb7a:66a4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f345209sm8797506f8f.17.2026.06.03.10.12.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 10:12:56 -0700 (PDT)
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Wed, 03 Jun 2026 19:12:55 +0200
Subject: [PATCH v5 4/8] iio: light: opt3001: localize for loop iterator
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260603-opt3001-cleanup-v5-4-3ef7b926d555@gmail.com>
References: <20260603-opt3001-cleanup-v5-0-3ef7b926d555@gmail.com>
In-Reply-To: <20260603-opt3001-cleanup-v5-0-3ef7b926d555@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>, 
 Maxwell Doose <m32285159@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780506773; l=996;
 i=joshua.crofts1@gmail.com; s=20260530; h=from:subject:message-id;
 bh=LykF7kDE88zomYF6W/24KVDMDse9RknyfnBW2IyXgj8=;
 b=Bvbs2pLL2mxZoNXDVpUjIR6KNtp0668oR/vrErINol1P1xY52vE+d2py1n/KTZ+RexIOfgWN8
 NZgO8rCNl0LDsjBpBu6EF7kR8yMPMG/1TXXznEvCfWSvdZNHakbfUXZ
X-Developer-Key: i=joshua.crofts1@gmail.com; a=ed25519;
 pk=RTDOoVwgeL4oFdASj9U+cxJuIjXuXk73zkjnGOJKbEo=

Localize loop iterator to tighten scope and improve code style
per checkpatch.pl report.

No functional change.

Reviewed-by: Maxwell Doose <m32285159@gmail.com>
Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
 drivers/iio/light/opt3001.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/light/opt3001.c b/drivers/iio/light/opt3001.c
index 532929e8fa8b..777a54753b0c 100644
--- a/drivers/iio/light/opt3001.c
+++ b/drivers/iio/light/opt3001.c
@@ -226,8 +226,7 @@ static const struct opt3001_scale opt3002_scales[] = {
 static int opt3001_find_scale(const struct opt3001 *opt, int val, int val2,
 			      u8 *exponent)
 {
-	int i;
-	for (i = 0; i < ARRAY_SIZE(*opt->chip_info->scales); i++) {
+	for (unsigned int i = 0; i < ARRAY_SIZE(*opt->chip_info->scales); i++) {
 		const struct opt3001_scale *scale = &(*opt->chip_info->scales)[i];
 		/*
 		 * Compare the integer and micro parts to determine value scale.

-- 
2.54.0

