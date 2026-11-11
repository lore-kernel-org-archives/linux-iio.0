Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794426685;
	b=et9J6ek7qdmXOHUfi1ABO9gK1nfm8T3JFvW4dRUPYxYaAvEShcaV2+4lrzhbrxg4BzBv
	 jpfIzRYO+bpUu+jo/cpv6iIFKISHHOizl2Z+obG3jznT0JKZ48lMGFBApG+AGEjPfZLG5
	 j2LCqKrGRG5dDwRhzy/0ROZ2K9ET9DiMp27Xd3OufHCMG5EnB19fjp7095OUxAVPGpJhU
	 YP+ZnA9O9R2U3lbEKXmLDUCEZ9aCeyJmlDcMH5ENThjC8MaGNZ9NUQNg5oBF+dUTJm2WY
	 DYbUI3MxsKPwlJWT1l6T6p/rxf+4q155nK2Sh1ig8+r5hhkKsCuDa8bcf0LmU97vzsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794426685;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=EHqk5x0/CdtJJ9kWtMupw3SjoX3qOmIdHB2cbrSmA1o=;
	b=3kgeuMTXFz+IbkRMgOqKNZIpRI3h4uu3QCxZRXNtzUzHY9/OITsqGftQalucxaKQDIj2
	 URQAoKIMr+DztasrmAvCHIqZXdGmyzRsB8KydngSrpM7kdAu8rxMPjT1G1dztufA0a+/J
	 idJa9yyy+Sd4FDMOdZcXcY+mgxkPLkRNj6fHsFAAf+pJsc7pzKUCRujxmx9wI2sCLF3Vy
	 SUDGVYQxs9AXt5Eh+5U2Xrw5PcnR5rmTAUD2OXKEaCz1Tb2npLFAatv8dz2U2UcocfAmK
	 KeCHILJ3G4SA73jVdvJbl/H2hWVZYpQeM7WtK0vxldBttihUanSut3G3Ten9Y3IqEZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TTUsavW6;
	arc=none smtp.remote-ip=209.85.208.170
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F53D606A31C
	for <linux-iio@vger.kernel.org>; Wed, 11 Nov 2026 19:51:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1F53D606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TTUsavW6
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-3ae0eb56ba1so18456311fa.2
        for <linux-iio@vger.kernel.org>; Wed, 11 Nov 2026 11:51:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794426683; x=1795031483; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=EHqk5x0/CdtJJ9kWtMupw3SjoX3qOmIdHB2cbrSmA1o=;
        b=TTUsavW6f+bJswyOgz2ua6vEAAfh43q2oOBQvLQ+dTaempbqyL3YYlFGjC1MWfvvFK
         gCeAbR34ULFr1ma9GHqqNk2GHifHebsOeIrfteb8KApcrNXzX6dHu39m4NG1mjQpQy0v
         hNlASEZUsh/EoEfKbFR0fJ5m9r26a6bNMlJ+wDq8ca8oEyArnskGhmChATV16JG56tyH
         2ksn3cEfiMvXC6C2lKeV1mqqQU0hcku2GzY7EolJbh7s+n/JLCjWNC2wp/x6HTZPIZkC
         A3cbQmEmopiUBePR/+ky0bLB4hhdnJlxkQSyXhWceB/9zZw8LDvs4H/FTebWRY/SFIzs
         N2Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794426683; x=1795031483;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EHqk5x0/CdtJJ9kWtMupw3SjoX3qOmIdHB2cbrSmA1o=;
        b=BGcnqViYiLruel0qnDbFELy9QA1qsALTFA9vKRn2GJsuE0yxs6RuXbDx2mvkvxqOwC
         3eFPhvp49p//rq+/IJ3/24Nde81JXGFEwgsztxTcdt3/iy1hXXvO6Jj8nyVDdysRxeX0
         Lpazc4m9ePap0SOh6V8RUbIGnY02Tj57F+8a/iRENrHkvzUMpVUEkuOhDJeGkv4i8EZI
         qWqfBFXs9QhlV6WitYXr5lMSEVhCTTOQ9BSZINIzHD3Fr1GJO+ZEJd0HmIsptR0aEMS1
         yorxsOxkh95ugipi+60nc2EzBrjCCxxjj5jJopLrGBPLUJ4cy5RxAyaXafT51GLIyqaQ
         r6gg==
X-Forwarded-Encrypted: i=1; AL+hErGeaWCt+/guhgPUNd4PBfDhuwlUPJ44d9wVSSjD3RDsggr3L35PPudviD8gBirJK86MxIpeXVrWJVU=@vger.kernel.org
X-Gm-Message-State: APuU4Z+FjJOplZuMP2d5/CD1IgZff1wIFqElVDSWmuUUIFK4ycn5lM9H
	Iv9R7A4Fmb6ML6OsScpsKoiGwy1WttueCtlp5IM9I7z1JWzbeu3y6orX
X-Gm-Gg: AYBFou2ulqxvd9QxvtTNb36x2aXniDpOWmVfgu5MGWiC+0HwZPf7QcZOXW/+9EbwstB
	0bw0buaSqhIP30ZxwQi4y9Jj/HIbPmdRoinbiNBVAjvbNhuo/hdsc2P3cOYcR8hX8oSA1mmHhFo
	nRSWfPfqVc/01yS9KaoEg/V2bm0Lx64RCI11dGQOlKQmXck/2U/2oJTymCl4QVVFAergGNdyJA6
	WoL5F6H59FYFEMnZU3n7pNGglO95iioObVh9li4MuFOZha8pFO2qCryai+6+iW4e6k1Te9557ni
	t95TJX5bLt0GS/mMU7KsYG4u69pC7ld1pUcSpP7jbWl23kwofTwEzTG4lH7SdQIMmdeM8Uz7wjv
	EBoBCL9scrC4DrsC3ipD77Lu1n7PmpX6KDxcbUMJqZDQP61zLAdNWeiGe0KqTegcQtcDjPOzyuH
	frnXjvvMoT6ypQ4MKoex5/XpKqxLx46oQ0Qc2XqRBwQ3RqZASnghcETLuS5y/Nlg8vDLzXUEjbV
	l3D53ek5hYQDE+hHQI0AwSzyGruYu14QO+5ROo3BUcTIHETAHufFWmPTmpgJdVE6g9Tz8iGaZN8
	SwzhgLt1eE8lJQmIZNaUT0Z7dqNgmIkT+jXt1bCItMcq8/iuO1U3+4e8o/ud4zuUnfjGuEZUA5L
	xfgITWBtFAR/+FIzcFGIeOoMsm71GIQ3arCP6
X-Received: by 2002:a05:651c:146f:b0:3ab:3bf3:1604 with SMTP id 38308e7fff4ca-3ae126bac4bmr7165201fa.26.1794426683005;
        Wed, 11 Nov 2026 11:51:23 -0800 (PST)
Received: from yantra.. (nekmmqtce067ylb1za0-1.v6.elisa-laajakaista.fi. [2001:99a:d7d:c300:5558:447:baa4:a7d8])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3ae091739edsm13147341fa.1.2026.11.11.11.51.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 11:51:21 -0800 (PST)
From: Rupesh Majhi <zoone.rupert@gmail.com>
To: Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Eddie James <eajames@linux.ibm.com>,
	Jonathan Cameron <jic23@kernel.org>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Rupesh Majhi <zoone.rupert@gmail.com>
Cc: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH] iio: pressure: dps310: don't wait for new temperature in trigger handler
Date: Wed, 11 Nov 2026 21:51:18 +0200
Message-ID: <20261111195118.36853-1-zoone.rupert@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Each scan waits for a new temperature result before reading pressure.
With pressure sampled faster than temperature, scans then come at the
temperature rate: an 8 Hz trigger with temperature at its default 1 Hz
gives one scan a second.

Read pressure first and take the latest temperature, as a direct
pressure read already does. Wait for temperature only when pressure is
not in the scan.

Fixes: 9b7cad9ce2ed ("iio: pressure: dps310: add triggered buffer support")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20261110154254.39092-1-zoone.rupert%40gmail.com
Signed-off-by: Rupesh Majhi <zoone.rupert@gmail.com>
---
 drivers/iio/pressure/dps310.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/pressure/dps310.c b/drivers/iio/pressure/dps310.c
index 85df58ac1809..c4d779f8bbc6 100644
--- a/drivers/iio/pressure/dps310.c
+++ b/drivers/iio/pressure/dps310.c
@@ -910,10 +910,18 @@ static int dps310_fill_channels(struct dps310_data *data,
 	unsigned int i;
 	int rc;
 
-	/* Compensation needs a temperature, so it is sampled either way */
-	rc = dps310_read_temp_raw_locked(data);
-	if (rc)
-		return rc;
+	if (test_bit(DPS310_SCAN_PRESSURE, scan_mask)) {
+		rc = dps310_read_pres_raw_locked(data);
+		if (rc)
+			return rc;
+
+		/* Waiting here would hold scans to the temperature rate */
+		dps310_refresh_temp_locked(data);
+	} else {
+		rc = dps310_read_temp_raw_locked(data);
+		if (rc)
+			return rc;
+	}
 
 	i = 0;
 	if (test_bit(DPS310_SCAN_TEMP, scan_mask)) {
@@ -924,10 +932,6 @@ static int dps310_fill_channels(struct dps310_data *data,
 	}
 
 	if (test_bit(DPS310_SCAN_PRESSURE, scan_mask)) {
-		rc = dps310_read_pres_raw_locked(data);
-		if (rc)
-			return rc;
-
 		/* Pascals, see the channel definition */
 		rc = dps310_calculate_pressure(data, &channels[i++]);
 		if (rc)

base-commit: 79c8dffd84e9784ec05bea68dbe5e71f7ec9941a
-- 
2.43.0

