Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF7F2494F0
	for <linux-iio@vger.kernel.org>; Sun,  2 Aug 2026 02:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785637777; cv=none; b=WacIF07OWhT6QZAgfKs6E67cEKzdix+JYuvMUxcbRlOjtAIojM3D36MxFIrd/ULRJoufLUqETO3sokkV05fqj53J1H8Qlkv4Kkp10BwJTE4iQ7NbZscjVgepYQ81QiH2dXDTkDEwDhG18I8weEZFf37rpo7XPjOlrQ1oXwd7LS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785637777; c=relaxed/simple;
	bh=m0LO42+wSFkD3zvU+UTFyTbOs+ixM6ivuQ3oUBeH9Vw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JdvN12MVTnPilAuxAYEGRBiqYejt0bbMT5LVLk1/C4UcC5aMOfF+HWhunVLlAYB2Imd0xS+RLI20Hg2J9hkl8sqc0PnjgRJBFUN5MzBf5JZQxJi8ze1j0o0VOtSNBVi5LRE4XNrlfAv2vWlD2xAc+QX5MWMfBcc5KlwuEU5kthc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SspBBmtf; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SspBBmtf"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c998fd549a8so1785741a12.2
        for <linux-iio@vger.kernel.org>; Sat, 01 Aug 2026 19:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785637776; x=1786242576; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OER6JPCaTkm5KRkSvzvVyVEwdjpOA0SgyH6QrFA8oUw=;
        b=SspBBmtfaVpTGBb6DdO8agGsbpVWx7MxbAPQtVfnmWA6HuBQOXj7tWzS5lbOa3Pg0/
         y6k66fMInh4SxdFifZaXLOSMQrBlswl71mkuwx8Oqr3UygyYIqEGY5sqQ61yhZS+Lk5u
         mZw4PsUB8zX3hJ2+D/jH/n1TOVv9OpJkCTmUamvSTjxMUP2D1UFK6HGUXENuiUYvnnE1
         aeIfFQFYzYvD6mTESAKuvUCUYKg+GzzAHkQ/h2n6o3Pj97IKRScdWU6CLrx9U4dwBUcT
         Q49+MNWi6PNkdPEj9tWbUlS5WA5u2NYzrBvXeFvt7TXlH2ZzuZf0s9SlMb2xwTLcajMV
         oNMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785637776; x=1786242576;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OER6JPCaTkm5KRkSvzvVyVEwdjpOA0SgyH6QrFA8oUw=;
        b=DWugWQVqocfuPVGuG/LSpDuzJmkR505G3ClzuU5NtJlFIdfa/875woGpchdDfZxWdd
         j3c4V3hNMxEMQB2pWaaMArrcRYrqpeXf7ovyzRQ+nyzfspuAMafMtoR3JSJLws2462Bp
         MjJZwin1C2ZPiKOWLDFhcRhWMhXLrrbBk5ppAa/ohAzs09efPwSPxLdIYOC4/kwYLMzF
         4wxAQTE28Cjqee5e5DXZLBNLcz8e30Qq5YJPxx93Oz7eBRdXI0jDlrkFUPjNXuoSLgUm
         SIDShdjHcg6+2dzG6d+gvxmbBcIO3+wyhrt4lEbk+EQCvfmqaplWvg+zc2FSQOTuP/OU
         HCQQ==
X-Forwarded-Encrypted: i=1; AHgh+RqHngMX2/5vFo3s0sU2yMiVtcSWuvgr0l2f1rl/xcjCR7TKMvxsnDrYpPByHY8yn+pP/NcHtzch/2E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/hsHQ7T1A2XlAk8byO1F4/hcJT4rrmFT+Ib+O8DuH59PNWc68
	z/oGCeulXIdNGpY6rmrYm7A6GFg0wJ6JDkrSAyuCaxG7lFqiTIl0EEDy
X-Gm-Gg: AR+sD13quD2+xYscXJ6kvAkQBOmvTI+cd8xr/KTJ5/pPaQWK/VzFQuMeSqCsRsoBTSH
	rjow79yHJoFFdm+DiMWZGOggB5xo6+jzfRU4BVWqGmeMF/5ZeoT7zbFbfYdjPxCbhrNrp8C+2ax
	AQrvn+YxxXVb5rAL6JTgmxkCwF0dresturfbw6ra+1aMusgWvri5uvdWPqyoGK1opGJC1iIEpc7
	o30Q4bIFow3tUwRGa6sePWflRXWSUC3HEH2mA/8r4DHUdiDoCBBI0M5tYBFfnG43e/4tKdTPjcX
	IMBAaDicyu0nmrxSKSqOVjem9KuEcFiuREq4huVg8gLL7kDWcPg3mYR9EWxbdXVTcisQXqZVKxB
	P5NOBFADI+QKWir0FgKVGZjqicwWpUikFZ43gvn/5raiN3nUC5bzOtqqefBiv5zTColS/EdmEcA
	nF+WGG8H+l0lQk9avZkre4t75moysltSxzgpCUctVpxTmfzh6ABf5couGzyJ1ndnkmFsQS3nYT+
	57ECHoZ/2rjvKsVCn9CrNTTYPjPnTi07sdFNKucpIrcYKodjSKruqpdsfb3QA==
X-Received: by 2002:a05:6300:189:b0:3c8:ead5:bf58 with SMTP id adf61e73a8af0-3c92a889565mr5350108637.51.1785637775787;
        Sat, 01 Aug 2026 19:29:35 -0700 (PDT)
Received: from debian13.localdomain (bb219-75-96-14.singnet.com.sg. [219.75.96.14])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13fab132cc4sm17296155c88.2.2026.08.01.19.29.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 19:29:35 -0700 (PDT)
From: Adi Nata <adinata.softwareengineer@gmail.com>
To: joshua.crofts1@gmail.com,
	jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	u.kleine-koenig@baylibre.com,
	email@sirat.me,
	adinata.softwareengineer@gmail.com,
	mazziesaccount@gmail.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: linux-kernel-mentees@lists.linux.dev
Subject: [PATCH v2] iio: chemical: ccs811: cleanup checkpatch __packed warning
Date: Sun,  2 Aug 2026 10:25:56 +0800
Message-ID: <20260802022559.23138-1-adinata.softwareengineer@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260723235312.432a895c@systembl0wer>
References: <20260723235312.432a895c@systembl0wer>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change instance of __attribute__((__packed__)) to __packed per
checkpatch.pl warning.

Reported by checkpatch:
FILE: drivers/iio/chemical/ccs811.c

WARNING: Prefer __packed over __attribute__((__packed__))
+} __attribute__((__packed__));

Signed-off-by: Adi Nata <adinata.softwareengineer@gmail.com>

v2:
- Rename commit message to include driver name

---
 drivers/iio/chemical/ccs811.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/chemical/ccs811.c b/drivers/iio/chemical/ccs811.c
index ce7187ccd706..0e5c79b775a2 100644
--- a/drivers/iio/chemical/ccs811.c
+++ b/drivers/iio/chemical/ccs811.c
@@ -70,7 +70,7 @@ struct ccs811_reading {
 	u8 status;
 	u8 error;
 	__be16 raw_data;
-} __attribute__((__packed__));
+} __packed;
 
 struct ccs811_data {
 	struct i2c_client *client;
-- 
2.47.3

