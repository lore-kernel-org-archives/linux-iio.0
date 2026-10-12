Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267D3463B95
	for <linux-iio@vger.kernel.org>; Mon, 12 Oct 2026 11:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791805616; cv=none; b=D0dePzy7IqTDshl95bQdglluNzlCxwxfLTn6TspudEP85eUOHB93QoMxcdiiYSYNl+nqrTu+6tz7nSuETy9FsJhBqppwCB1J6mAIEUW9Lu3fm1ZSlihqOvVnqsZzM2dQGBCPHvm25k27AqNLNe57ybfUAvuZWUS9b5jpBRlA24c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791805616; c=relaxed/simple;
	bh=kOtSbLd6nPkVAypRizwU3RkuyPhSMyz3meHYQL7tWgM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GScg87/jHTKr12xKJ6SwywhYXpojHIqJ2324H+01ni25dpTrYpjhJhvV4nrQdUPJKk4UrTz9ORmCLdYFC2179kl9ZXqGS1jnm9fzj2Zbi6985ZFLqP43gUsCcMfvJ9dnNoML4wuKVNfcxLow9hb+PTy0p18vE1EB4YmOVbmOtYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CVjePypT; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CVjePypT"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-3115c4451c8so1902794eec.1
        for <linux-iio@vger.kernel.org>; Mon, 12 Oct 2026 04:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791805614; x=1792410414; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7zTI0hmCmOtumhgEB/n0nTLbFM3KmZEkOPpjnq9rAvY=;
        b=CVjePypTbQNjymDGi45ljhTDKw8NnC4JQjIEPprHE9ZeDNhe35NPAGMXbUKcL5hyEg
         mnZaNvcfsoeXGeSAT4tQDK5VpUWAUPzpksUKIBRTeHiiLChZCsLpoGeUPMXs3PnX99tD
         +xcpwrYlDpu9ITFHA0e90ozuG5VEf1jDMu44SiMcseIk/BQaN+hQFo/DroI67Z7oQLU7
         ONVik/StXSbsZ9bk1dNBXdP6Nu7U7JRboyDsxOoJslid4jUDIKnco61SelkImSqmkHNe
         4EBkoBeC6YPFr2SVQO7lyChzxgzUuIMcLT4f6NwMPJfxMWuGCpMgT6bFF66UBqe36BzC
         RLIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791805614; x=1792410414;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7zTI0hmCmOtumhgEB/n0nTLbFM3KmZEkOPpjnq9rAvY=;
        b=1Ucj58jGlA54hwv+IA5vup0JcNBWU8MpLyf5mwUCUNNh+wdvjJvssHSF192ToRU+7p
         8kP/7c0osR5tqNGnJw3G/jf8CEFDZqMVH9SEMuy/UwbRCaj8lQvWkVbeJTn3/JiOZoS4
         jV6RlLB2i1TH5vVf6kFC6kASdNXePfqrZjb4iuDlcHNAJFuGJDvGqekvVbFbQKQqrTkR
         Dlau+xFPoEOdWdJN6ATZcQl1ZmUN0DonJtnB9yr08zeEgG3O69dd0HgAIhnk4VzqIWfi
         2wA3ZBDFIbwGmZluLm9RyccEJkiuJAA9/PGOZR5z3YWHmeo5PcTDZsOZzIy2SGQAntOb
         /yDg==
X-Gm-Message-State: AFq9FYJVCRQRbzSNdG+wt1D4XfRmACXtOIK5sYVvU0Y0rsmgEn94jm2y
	bFQFg+w1ScOLUj32bXt/Uo8augqko9j7Cb/XDMrJTj/i1sMWaSo/FcicsClBkhl03A==
X-Gm-Gg: AYBFou14vSE9GUjZBQh/wEpdB3MwaHPt03zl12cPf7fbuKNGoOlxcgAGEfJfvmPlOig
	URpaB5ur9zHjqL6y1mwRS7YLKWX9UinEIAyX/rI0FqMLq4AtqOZ37I71EnyxjnZitzmIWjtGCHJ
	bt9piJabNc5GaFtiiWm5MhJw+J1OHzH3YvVPI9ql9jTDKv/S17a2+rw0inypAsrvzZw//ZP1Bwc
	dcwMA1daCZsg00DyZOyqU0tQzj/8AMK1soWo36FgzgOmTRqLwQddgfcIO0XWY/NXNtOoZ5Go5kW
	AhVgKNRRVDFjQ5amr+gTDRiG5CfnvBk7qbg+CpGsdUignvHrE0fZ6XZrjTUYibbm22K/DTdykXh
	8l4cJHM6LwcHkrrEZ0i1zLJ3MHoHCpCkqWTqg9JHa6UN5cYDuhNB7tqGCXp5O9yUmBpZSv/EwrP
	KFzCi/ilhrbS9OkvqdSgQkvkvAD2zuSzwWFoq6ePF2JYSAh29koePKj+DwwwdjTpqifeCys5gQC
	ssEGUrcOYnRF54BU3zg1pjpz0JHQNcvm1xMTA==
X-Received: by 2002:a05:7300:42c5:b0:351:7848:85ca with SMTP id 5a478bee46e88-3536c4bed2bmr14875589eec.7.1791805614099;
        Mon, 12 Oct 2026 04:46:54 -0700 (PDT)
Received: from localhost.localdomain ([101.0.62.171])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537c841648sm37311334eec.3.2026.10.12.04.46.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 04:46:53 -0700 (PDT)
From: Nikhil Gautam <nikhilgtr@gmail.com>
To: linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	Nikhil Gautam <nikhilgtr@gmail.com>
Subject: [PATCH 1/1] iio: atlas-ezo: Fix humidity channel read support
Date: Mon, 12 Oct 2026 17:15:53 +0530
Message-Id: <20261012114553.3327-2-nikhilgtr@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261012114553.3327-1-nikhilgtr@gmail.com>
References: <20261012114553.3327-1-nikhilgtr@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The atlas_ezo_read_raw() function rejects channels that are not of
type IIO_CONCENTRATION, preventing the relative humidity channel
from reading raw and scale values.

Remove the early channel type check to allow both concentration
and relative humidity channels to reach the mask-specific handling.

Signed-off-by: Nikhil Gautam <nikhilgtr@gmail.com>
---
 drivers/iio/chemical/atlas-ezo-sensor.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/iio/chemical/atlas-ezo-sensor.c b/drivers/iio/chemical/atlas-ezo-sensor.c
index de0b87edd188..ee939e74bdae 100644
--- a/drivers/iio/chemical/atlas-ezo-sensor.c
+++ b/drivers/iio/chemical/atlas-ezo-sensor.c
@@ -117,9 +117,6 @@ static int atlas_ezo_read_raw(struct iio_dev *indio_dev,
 	struct atlas_ezo_data *data = iio_priv(indio_dev);
 	struct i2c_client *client = data->client;
 
-	if (chan->type != IIO_CONCENTRATION)
-		return -EINVAL;
-
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW: {
 		int ret;
-- 
2.39.5

