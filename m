Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04BE9332902
	for <linux-iio@vger.kernel.org>; Thu, 26 Feb 2026 14:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772114939; cv=none; b=uCeweRSlMdSVZC1xJZTBDJQdF0CMsBw7oy5XadKncKyU6Cp8jwTZvdCDHlgRheHOVAzSFvstOYEqAsdMtBhq+m4TsHTdEqZb88msVIcNJB4Ii85Dcjcu/jEn+VzPR2drTcoU/43CgzAnSyidegXhSiiX3krON5wvCdsIPbyjZ4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772114939; c=relaxed/simple;
	bh=oBywhqwQ3NuuW7HpvW8cGpArRPBK0BosoB3SD+Jy5mE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ijj52lTbOHFUSaE8oYaK2TmvtVOYRYYEU4f4NuGncnAtfBIIfsroDwNppGjfzO53AeZZAtKBV1OOQL4CHdfCazpojOX0BssXBO5HHP29cPe2iIJ3U7M0RB5r8a1LJCCK8m4PK87EEEbWLU5pB8xUBMyLkVciRYTnfFooC2WBHqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f8ppcmDx; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f8ppcmDx"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-483ad568d68so1519755e9.2
        for <linux-iio@vger.kernel.org>; Thu, 26 Feb 2026 06:08:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772114936; x=1772719736; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=e8CGDEkXyAlDrk2ZX9C97+DX4JOqZgHJ4c1D8odhccs=;
        b=f8ppcmDxhChq7CrrHf6iHNNJmMN3FjTN/lX0oi4mFZML2BC7DkUa++od+FDr5dpe/a
         N5xnX0cxnjVqPLkpJ8mfAHQ081tNMgGKGGdCzrRJPGbj4RekIvItlP6CbPg8xt1yD1nP
         QdXfCJPf/SNiepDLd7FVNI80n12jAVRQFMLocoGtgFECC8PuebsvNNux//+o1bUmqRtn
         BkgyLj0DjNbudwGKWq3BpVPn06B0oS3z3hxg5H53fw/RNg7XnC7SXGMkRK7JiR7u0gzP
         VpGwWXBdLvQ/Mr+CEK43GPi3U39W0BQr++lU1FuM2VqDoe5flbVQ15d8JkiJeCyO0OeY
         DfIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772114936; x=1772719736;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e8CGDEkXyAlDrk2ZX9C97+DX4JOqZgHJ4c1D8odhccs=;
        b=UUMrrE7HZPc9ZbeINAeJPdtDj4Zh1xXoNPtWSLRZBLwpxYcHqC7y/GeWujlWOJS1Q6
         5HF526DBqKQTgPCgg+cOzjbkMN8N+T5rr5zZKtprGT0O0zDTM0PvsQLHOxuE0AHNziKZ
         PEy2QoaUowINfTPjhm/xmySvKC81xx8p0+rSeFZCXzMeO5yfL1ce8Iak7qUBUdWp/t+B
         iJCJmz14p9dpYYrMJCNBCW7dQ5N5i6VHR8q3vxgshsNdg/EP6FxXi2+wp7jwmtPC1yil
         dSbu2Co/WZKEJ0ZIpbClyKR67FCtvmHYjA+qBdqGxmZIApvdA/awulryYKk063dyBGT/
         d8xw==
X-Forwarded-Encrypted: i=1; AJvYcCU7djLsoyHhMfqlexJLhVkBir3wJ0W/4NO1zjOcHH8FaDHBlo+hGaC2kaz3Jf5sW7igc7GHrql3jow=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDJFeWgSQNB4iN6PMmZfeHPrJ1JoEapdA98Hs+Z3yJksLYH8Kl
	64xQonzTojU6xtE5sh7+iQqF2nt4CuEAkjyd7arCcXS6qXEUQRmGRYGp
X-Gm-Gg: ATEYQzyfq445x9BrR8xGdlqBwBBgiu8j+Y2Sk29M73iUGZxjz2TAgI0KWo39fp5nZCj
	mtd5DqVuXpRZ8vyziJ8dghurJxID7lXVweMxwXgvK4NVXxdVwAr9T6nWDq032vTdTMviWCZ/Vmn
	ypTH0z0EfpYYBF4jOrua2T5JqTCtldaby0gKnZYXcTvvWtgYO9FtZoScWC09YAnz0mgdI0u+PoQ
	3iryXjRmBsLQpd5jTIqttVF0zxzkb5TrcEsTZiTCBLd/DxQ85mxXEI+SJgP0BwvY9nnzHBfdfLk
	bdxGOFc/KV0IUtl473P0hgZVdHJErHxQwEsGG0le3gW56Dh2QwMvRHaAAvvq/e9VEniCG68+l7V
	NjxLoGnjMqy5FjoEF9ylP0Z9ewXhNSl9phVAkti2QGmxpBo32xSHEExGA3AT/DINfzIl1lCvvWO
	+3A3Urt49QY03ZjXMHsBZAVAlNfm5HAYP4QJ9y1x6h0oiqGsqjurgHOwN//Yn/gz6VMQhVftQco
	ED7Sn+07poC2FMVc8/w2SUenCnDdZIwPFwaBOkUtz6i3HjAcPP4
X-Received: by 2002:a05:600c:450c:b0:471:ab1:18f5 with SMTP id 5b1f17b1804b1-483a963d0e4mr183011585e9.7.1772114936190;
        Thu, 26 Feb 2026 06:08:56 -0800 (PST)
Received: from fedora ([149.3.87.76])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483c3b346ccsm43771845e9.2.2026.02.26.06.08.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 06:08:55 -0800 (PST)
From: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
To: antoniu.miclaus@analog.com
Cc: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
Subject: [PATCH v2] iio: adc: ade9000: fix wrong register in CALIBBIAS case for active power
Date: Thu, 26 Feb 2026 18:07:02 +0400
Message-ID: <20260226140700.481317-3-giorgitchankvetadze1997@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The switch statement in ade9000_write_raw() attempts to match
chan->address against ADE9000_REG_AWATTOS (0x00F) to dispatch
the calibration offset write for active power channels. However,
chan->address is set via ADE9000_ADDR_ADJUST(ADE9000_REG_AWATT,
num), so after masking the phase bits, tmp holds
ADE9000_REG_AWATT (0x210), which never matches 0x00F.

As a result, writing IIO_CHAN_INFO_CALIBBIAS for IIO_POWER always
falls through to the default case and returns -EINVAL, making
active power offset calibration silently broken.

Fix this by matching against ADE9000_REG_AWATT instead, which is
the actual base address stored in chan->address for watt channels.

Reference:ADE9000 datasheet (Rev. B), AWATTOS is the offset correction
register at 0x00F (p. 44), while AWATT is the total active power
register at 0x210 (p. 48).

Fixes: 81de7b4619fc ("iio: adc: add ade9000 support")
Signed-off-by: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
---
v2:
 - Added Fixes tag (Andy)
 - Added datasheet reference (Rev. B, p. 44 and p. 48) (Andy)

 drivers/iio/adc/ade9000.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ade9000.c b/drivers/iio/adc/ade9000.c
index 5dcc26a08970..1499fb1c718a 100644
--- a/drivers/iio/adc/ade9000.c
+++ b/drivers/iio/adc/ade9000.c
@@ -1123,7 +1123,7 @@ static int ade9000_write_raw(struct iio_dev *indio_dev,
 			tmp &= ~ADE9000_PHASE_C_POS_BIT;
 
 			switch (tmp) {
-			case ADE9000_REG_AWATTOS:
+			case ADE9000_REG_AWATT:
 				return regmap_write(st->regmap,
 						    ADE9000_ADDR_ADJUST(ADE9000_REG_AWATTOS,
 									chan->channel), val);
-- 
2.52.0

