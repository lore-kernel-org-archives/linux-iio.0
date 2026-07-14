Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A762181334
	for <linux-iio@vger.kernel.org>; Tue, 14 Jul 2026 11:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784028708; cv=none; b=AR9VDyIORf474ll9QY/KphQA/GmF1AggmqpLA0HqLKykjcnkUSJaeARQmWSF9kgDTLfKN14Pa6M0xCc+TYiDMR6lZEyAmnlexbL1FEk4Hna0npkn7OlVJKjj+Mhia32gefRPmXedZ3ZvhBxW7qQ6psPada+AtmSOTCqeifP9LOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784028708; c=relaxed/simple;
	bh=xxgwCeT3dSPUCMHW5OXfv9VTnN/cr+L941sj/wmgWQk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Obl5ul80egvnt2i+T3ekk6DR5CEyX5UxBev2+jdXJ/lp5IanLo1XNl9FzdWBI7/MIWR24fHYtKnEGIIzEKNFN91UTXkPx+dsVxu/8yxXYU66VrzH7FHdXq3lGnuuP/5hb6AYEwlbutLIN+/O+olcWmyrQjuKZx1Jh2KJ5Dn8+7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m4TK0FZX; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m4TK0FZX"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-84536ecfc5bso613013b3a.2
        for <linux-iio@vger.kernel.org>; Tue, 14 Jul 2026 04:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784028707; x=1784633507; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UQkjz4SLBwT2GueIM4+tWAz99xBrKedDThFl6sdTxH8=;
        b=m4TK0FZXFw/7luCgZ+72YHNV/0IX92yLgt0D4aQovBZZVQf5Gor/pMZNr5DW15eez2
         dmeE6NS4xytwHIuPdsAcTdVgeN/sKb3jMLiItFY8qRrDcm7HmpED80kgf+a13/ongl0v
         70kt6Ya5Bm+9DpIBFezGuJKqNcvn/NeYgtxPv5ODkm3QWyDTtb/QR+t7mZCveAFdS11a
         ZCr50+PL1ODZEcftzF1ousR5MCcAcOMtGZXz2yzNtTb8i+fErwRn9tBS72kJo1BT1yYd
         bnzXzg7mQpJ6MfwkNFOtho0sy65KKuUPxRjKWMm2PrTR0D5Rl55f9EbRSz7TowevjM8C
         pzdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784028707; x=1784633507;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UQkjz4SLBwT2GueIM4+tWAz99xBrKedDThFl6sdTxH8=;
        b=r7SWSiMy6DWMt8ATBUXV8O2j0Zp1Vrj4A5bhgRIvJrI5y3Rdg9GzCRm9VFcTGzTl2F
         X15KQqfLDaCcEcRowDwNkDH0f6jPH4J7ckyRuP/zrjgofQARIztJiUvgAehERXAUvLh6
         N7ra3qaDC2fdBwpiRZo/pU9Y2Ve/SFcMPULZDq0uEywmzknnbXIStgBnVr2ipXV0nory
         812wmlw6gREIKHFfi1pZxSrqfmP8xR1+te6DB6nCJiRfp/Oh29AcijTMZkPNpQrjUlP9
         FSHPERWMKpuVLHU1mteLScVHY0Mq8JlxWLCDoJlCeeQaadNY1898dnJtEW4pbdfSfg+6
         ZRYw==
X-Forwarded-Encrypted: i=1; AHgh+RpUWpV0j6zw2+YSPACPz7I8KmUSISrKqprlv6tgQv/ZpKKyGf9nYZGMGecv4L8RdBl1UdKI/U/WDwM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxsjhGXwvmQ+yJlIXNtAjHNdyqiK7KUhVbvenlzD5lLwdmO4CJ
	Lf4k20wF1S/VHcrhVk1wvAiNgSZlBROjEfwfBYhcgqKC0NjcvZsmLfCNdq2QICw=
X-Gm-Gg: AfdE7cmjyX42mVDZH0DbfC5oLo0Yzakqy5Iy9iHfOu1hgmIF1hbegghJd5OdJFjRrnx
	/dZNfV+7JXzOO5tAEBvgftia7euEAT/AsRprt1SYScmkSOJORPAYxSIlOpn+P8B5inRni+4CqKH
	+46IAc9VP5oadayzLozZC161MCYBHFnNONCfEgpCQ9436IKgKIwkswLGmI/8nRBtZ+tDmS50Kxs
	Ih+vHdyRtX+hAeAxr8Ni/9Vh4PoX08cmx96aGQbj3NubPgadZiifXYx+Ji3R9KJKnFwLrxr3F2U
	H8xXcbSMCF6MpyE4rqHL0oODy9b6Hvdw5iEkFS2eIMvwYkzev4Ipk7rT5HkSc1yDIo8zhoEaAUY
	IM1DQ8k019R3R00oaeEpa6Boe3vr6hsk03/sSJhMtQUXotwGBec0r9H+l08xlW5IE/lFkIK3a6G
	m2pXAR3PQBEfzSugU4RpoGeA9A2+ecyykduQq212rYJM89iI1E0NTA
X-Received: by 2002:a05:6a20:7283:b0:3b4:6f7e:d0f9 with SMTP id adf61e73a8af0-3c1100308f2mr13749870637.3.1784028706648;
        Tue, 14 Jul 2026 04:31:46 -0700 (PDT)
Received: from localhost.localdomain ([101.0.63.168])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-311747f72a6sm95357368eec.1.2026.07.14.04.31.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 04:31:46 -0700 (PDT)
From: Nikhil Gautam <nikhilgtr@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nikhil Gautam <nikhilgtr@gmail.com>
Subject: [PATCH v3 1/4] iio: light: opt4001: Fix power down clearing bits of the wrong register
Date: Tue, 14 Jul 2026 17:01:31 +0530
Message-Id: <20260714113134.3445-2-nikhilgtr@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260714113134.3445-1-nikhilgtr@gmail.com>
References: <20260714113134.3445-1-nikhilgtr@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

opt4001_power_down() intends to clear the operating mode bits in the
CTRL register but reads OPT4001_DEVICE_ID instead of OPT4001_CTRL, so
the value written back to CTRL contains device ID bits rather than the
current configuration.

Fix and simplify this by using regmap_clear_bits() on the CTRL register
directly in the devm action, and drop opt4001_power_down() which has no
other users.

Suggested-by: Jonathan Cameron <jic23@kernel.org>
Fixes: 9a9608418292 ("iio: light: Add support for TI OPT4001 light sensor")
Signed-off-by: Nikhil Gautam <nikhilgtr@gmail.com>
---
 drivers/iio/light/opt4001.c | 27 ++++-----------------------
 1 file changed, 4 insertions(+), 23 deletions(-)

diff --git a/drivers/iio/light/opt4001.c b/drivers/iio/light/opt4001.c
index ba4eb82d9bc2..66563000d081 100644
--- a/drivers/iio/light/opt4001.c
+++ b/drivers/iio/light/opt4001.c
@@ -222,33 +222,14 @@ static int opt4001_set_conf(struct opt4001_chip *chip)
 	return ret;
 }
 
-static int opt4001_power_down(struct opt4001_chip *chip)
-{
-	struct device *dev = &chip->client->dev;
-	int ret;
-	unsigned int reg;
-
-	ret = regmap_read(chip->regmap, OPT4001_DEVICE_ID, &reg);
-	if (ret) {
-		dev_err(dev, "Failed to read configuration\n");
-		return ret;
-	}
-
-	/* MODE_OFF is 0x0 so just set bits to 0 */
-	reg &= ~OPT4001_CTRL_OPER_MODE_MASK;
-
-	ret = regmap_write(chip->regmap, OPT4001_CTRL, reg);
-	if (ret)
-		dev_err(dev, "Failed to set configuration to power down\n");
-
-	return ret;
-}
-
 static void opt4001_chip_off_action(void *data)
 {
 	struct opt4001_chip *chip = data;
+	int ret;
 
-	opt4001_power_down(chip);
+	ret = regmap_clear_bits(chip->regmap, OPT4001_CTRL, OPT4001_CTRL_OPER_MODE_MASK);
+	if (ret)
+		dev_err(&chip->client->dev, "Failed to power down\n");
 }
 
 static const struct iio_chan_spec opt4001_channels[] = {
-- 
2.39.5

