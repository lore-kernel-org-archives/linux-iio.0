Received: from mail-wr2-f35.google.com (mail-wr2-f35.google.com [74.125.225.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590F1499F2C
	for <linux-iio@vger.kernel.org>; Mon,  5 Oct 2026 14:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791208971; cv=none; b=X/hJsu+mNS1cgZqJT69Ku5RZYrRFUNmme1/carB4TEyjvaxYFZ3kMiOEAxojnDExzfP2j83DPtAdhrSVc73GWfStrc/rVBdwWd08n8AgScuPVeh4VWGaxmH7QO/hYDnvPiijLNWcYgDW5mGhqFPl+r0kp5QBgXYdqVcKnppXApk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791208971; c=relaxed/simple;
	bh=dT34M2N6KZshqeX60njvtq1+UUYQ+5bXzcxncuz8vP8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Xc0/NvFej6pswhEOauwofNG91EP9BaLectAKvKQJ2jfQKKeKiGW8Wx3haC0frIH8yRogQlstEzajZ9lGm6TWsF4UGT0MiN/L8/zsuayvGU4DjqyF/QVRCxxwZtHk36/k5uTw+/3YfITuJsymQAUf+4JNVCefXGq8Z1eCR0k39Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk; spf=pass smtp.mailfrom=thegoodpenguin.co.uk; dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20251104.gappssmtp.com header.i=@thegoodpenguin-co-uk.20251104.gappssmtp.com header.b=OmbijKqe; arc=none smtp.client-ip=74.125.225.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20251104.gappssmtp.com header.i=@thegoodpenguin-co-uk.20251104.gappssmtp.com header.b="OmbijKqe"
Received: by mail-wr2-f35.google.com with SMTP id ffacd0b85a97d-488811c9ebaso941022f8f.2
        for <linux-iio@vger.kernel.org>; Mon, 05 Oct 2026 07:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thegoodpenguin-co-uk.20251104.gappssmtp.com; s=20251104; t=1791208965; x=1791813765; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=q6Y/nsLBkI52hE4IZtiOJg2rBIV1fG0I6ZMA6H98b3c=;
        b=OmbijKqepe6HgpKZrHfHD7HsS9apSPcXYjLRZgw89QM63y5kXXl43FSBzwwhMfNZic
         q1NoA18z9Z65Gf1Wxqb1M9s1NEXZ6ejjE6Lvc7HSbNoDTMejonxlCPD7ngc1be+/4zrj
         ptYZE1Z6PvWAOUl1Q05A9hSC+gw3ty1ww+lnK1oOZTdrWCCgJCdyFdLBN3JFh+Sdfq7Q
         NXNh0o26aqAuliXQzsym9ZGsrQKCXf3ywjk+z6hT/GMslhbVt45C3c0XDAC7EvkhXSox
         iIl9NO81YjHRAOlTtz0P72ZVuuzmCvgUt3ewdT91jEFm4WxqtsTr1tZ6s/eMeUXvgtUW
         5R1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791208965; x=1791813765;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=q6Y/nsLBkI52hE4IZtiOJg2rBIV1fG0I6ZMA6H98b3c=;
        b=BiguJULz4Sy0GyB4xs8usvyaDG9Ran34L4yNWAOjXWqNLmYxkhmfQ0s0lXDhTPeZHL
         ejzlZzz3JVnho7PrU/fG9DX1uSDqyi2zPFScUb7Qk4B7DZdHeNvOxQNEfQ8EiHVprIcu
         kcaVkGgXp3XHN88BZby69qRTgqGzDUzX8SgyKewH98pN2PshdCGAn9DYh4mejSzSmQEp
         33NCGMIyDiO4wHpfHa+MZ2ikMdv75d2GUrdGtPk/cxQnHz57gfetSj3oL/cNEQNboP1o
         uIXDj5RQ7GUT10uOKSQa5r6S/KgX/hl76ItYLWA3REKJtPhWn5AS3qhPmeH8+6sApZWA
         y5CQ==
X-Forwarded-Encrypted: i=1; AKwUvBxRkX3IcRfSxCPnpoS7gfgigC+caWcvby4vbScCynggnMgSO22gwHc718LH0JCzqLkDgYBw57utaXE=@vger.kernel.org
X-Gm-Message-State: AFuF++mp1Ub2MR1+3H1lG8xXnE1h0PrMEtI1FNlgJm6n8/swyof41+PG
	0t5gFXmVcRJdfNA7r+zBmqsTecqFKwdPRQoe3IqDSytBIGQ1ec8e0HsJ06ME/wZZzfo=
X-Gm-Gg: AYBFou04qBizR8YrD+Z0Iy4NJvYBqoKjXRUm68wDRQoy7OOPd05NG1DGY88JqhrfOiI
	Vx/1Zd5Ac20KPWnWXqeEy/rCQAtMzEupDErhpfkoe+djj8HCXiOimsDhjAcaJOj3VElCDJrInrR
	mbzGRAHlrMiiqPT66nVyJrcOA76oTy5t6tHXi2uysYwgHC9gf8yBCWyhqsvowp2bVve3DoWhQ4e
	Hk86UP0HmMvu9/sptENvit710kboxW4oT1ggLZxbUFCiv8b8vxBMwvilagerd147su5zlSagS5c
	9SHohf8A/CmWpkL27OmGQQzgsXIhp50GESbXAOubJna3lvI5XQdgdYI40hzoQkVXPX+t9Vbgba9
	nvaQC84aPZnPzmUjF/WbY8QXtsp0y/O8g6eRIB/gjPMOjH3bTsDuu+aHk9lofygW03wjMuH22CA
	175mzagfLKG7NwVU2PgRCkwjFtw9LLuTQIcjjn42AV97aLRZpm3k6FSa9HDU3U21OZ4CYjdFV0A
	yWAmSHkLkAMMVLa1AoG49za
X-Received: by 2002:a05:600c:c16e:b0:49f:ffdc:939d with SMTP id 5b1f17b1804b1-4a02755fd8bmr170760675e9.9.1791208965024;
        Mon, 05 Oct 2026 07:02:45 -0700 (PDT)
Received: from [10.42.0.1] ([2a00:23c7:1d1a:9c01:9c1b:24c4:d43:125f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a162e867e8sm324052715e9.15.2026.10.05.07.02.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 07:02:44 -0700 (PDT)
From: Pawel Zalewski <pzalewski@thegoodpenguin.co.uk>
Date: Mon, 05 Oct 2026 15:01:59 +0100
Subject: [PATCH 03/12] iio: dac: use named initializers for acpi_device_id
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261005-acpi-iio-v1-3-2796f713945a@thegoodpenguin.co.uk>
References: <20261005-acpi-iio-v1-0-2796f713945a@thegoodpenguin.co.uk>
In-Reply-To: <20261005-acpi-iio-v1-0-2796f713945a@thegoodpenguin.co.uk>
To: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Petre Rodan <petre.rodan@subdimension.ro>, 
 Matteo Martelli <matteomartelli3@gmail.com>, 
 Marius Cristea <marius.cristea@microchip.com>, 
 Matti Vaittinen <mazziesaccount@gmail.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, 
 Alex Lanzano <lanzano.alex@gmail.com>, 
 Jagath Jog J <jagathjog1996@gmail.com>, 
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, 
 Kevin Tsai <ktsai@capellamicro.com>, Eddie James <eajames@linux.ibm.com>, 
 Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: linux@analog.com, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Pawel Zalewski <pzalewski@thegoodpenguin.co.uk>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791208959; l=1319;
 i=pzalewski@thegoodpenguin.co.uk; s=20260430; h=from:subject:message-id;
 bh=dT34M2N6KZshqeX60njvtq1+UUYQ+5bXzcxncuz8vP8=;
 b=pc7OPk4/68di0S50upYc4AFKyOH06OKtNXgdBM7mIgkdrUSWLs5cmGPKodlSYFTRBTeGO2Ptl
 IG/RwqCv9iJAjY03Xwp+Ffa1lD08ackp7Dj42of597CR73Gq7Vbw9RH
X-Developer-Key: i=pzalewski@thegoodpenguin.co.uk; a=ed25519;
 pk=vHq4n9IonORH2GTzLv8r6CWAFHzgfBuNkQPXA8NSly0=

Use a designated initializer for the acpi_device_id fields which makes the
code more readable and consistent with how lists are initialized in the
rest of the kernel code base.

Signed-off-by: Pawel Zalewski <pzalewski@thegoodpenguin.co.uk>
---
 drivers/iio/dac/ad5592r.c | 2 +-
 drivers/iio/dac/ad5593r.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/dac/ad5592r.c b/drivers/iio/dac/ad5592r.c
index 88197bc6a70b..3a71b23f85d6 100644
--- a/drivers/iio/dac/ad5592r.c
+++ b/drivers/iio/dac/ad5592r.c
@@ -147,7 +147,7 @@ static const struct of_device_id ad5592r_of_match[] = {
 MODULE_DEVICE_TABLE(of, ad5592r_of_match);
 
 static const struct acpi_device_id ad5592r_acpi_match[] = {
-	{"ADS5592", },
+	{ .id = "ADS5592" },
 	{ }
 };
 MODULE_DEVICE_TABLE(acpi, ad5592r_acpi_match);
diff --git a/drivers/iio/dac/ad5593r.c b/drivers/iio/dac/ad5593r.c
index 3e4215f0ca7e..520170c44c51 100644
--- a/drivers/iio/dac/ad5593r.c
+++ b/drivers/iio/dac/ad5593r.c
@@ -126,7 +126,7 @@ static const struct of_device_id ad5593r_of_match[] = {
 MODULE_DEVICE_TABLE(of, ad5593r_of_match);
 
 static const struct acpi_device_id ad5593r_acpi_match[] = {
-	{"ADS5593", },
+	{ .id = "ADS5593" },
 	{ }
 };
 MODULE_DEVICE_TABLE(acpi, ad5593r_acpi_match);

-- 
2.53.0

