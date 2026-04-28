Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3891943901E
	for <linux-iio@vger.kernel.org>; Tue, 28 Apr 2026 12:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777380412; cv=none; b=CnJ53TARYs4DB2DdNcmWlLHe65wNpfsfqgjbbmYNxuXviLkCCVUeNGQ34sFEHTzOooaDUZUT9SKaAbFUs3CJ52XOYDCwWLTN3KIxDBrQqnn33pqkJklvikqZGa2wv8z7zfYh+9CrG63WhDGiBN+NpRrBoVMX4T6HPq67xjy1irM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777380412; c=relaxed/simple;
	bh=Szqoqlf6r3PtT3dYd2Gr2nMvHc0AnHZ9jFMZ5ZHEEmE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=enqo12FtCrIMbAbO19bf/fY4yLqvJyEc09pWbisTQg2ctERPDp6ndjR1rpLkoJy8zxiZ0FuLkAEow1dcZ8rIDZ7StRv9ZsVk7WfB6zq8owb3cfIVifp4f3gHuojUzELbL14wuHaSUQ/2t7olTeu9BDqmRvCI8WwyF2NtHWKUWZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VcheByFg; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VcheByFg"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7de4ed0593fso2875281a34.1
        for <linux-iio@vger.kernel.org>; Tue, 28 Apr 2026 05:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777380407; x=1777985207; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2maPP+Sn0SquGJSG5S39jmmzG5ZaI++3zMHiBnWmo4o=;
        b=VcheByFg7lT7A32k7J8XN2+EqvsZK/xoUcalTZHYjrUXj03CEmIn6L5cRW3cLKwQWp
         XQGkaW/2FhzVvpWI6zuwfhCsm+hLhSwfZ5EkNt5ssnnllMkIZxk6vJ7TdHjYA+3GaGPi
         zig/nEsfw2GOhBSBt8/5/EK1ov/K6cswH5NqotYPmcas5l7Tt/Y2Th4aARgTBSw10My8
         QX+Ot0WylMUMyCUqSyPA7dwAEViGSe2GA3Rn16Xc5vj7nVuAXeW9lZonyyQgh7BlUVef
         Xn6lNjDhPzhUH6ufGzrBNx/UEK3+O/+qnt0po5LnX/ohYh6AFkGvsH7AcnF1DfYDuv7M
         HzLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777380407; x=1777985207;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2maPP+Sn0SquGJSG5S39jmmzG5ZaI++3zMHiBnWmo4o=;
        b=qVWJLc+Ow+ioi9GRwFBLP92rjslzvWqDHbve0TajrTDBlR0Q6uIyRt8/muExMaQ1JS
         krmtzVZg/Ke8XpnneC3hai/Pf1Rm7LMdqcmNdCEsMwUjrmM6lOiRN1+6uIVenR2lNjHK
         62/LAiCIiUmeHYtAeEVDbJg7Id82UsxeXaYqqJYNQU924by2RYMPQZbYtXXSk+Jxs9qF
         fzxOghtvsycxAPpcOaAa/Tzp8N3wXdl5a0sTnt1T599XkAd7unkYxck5NqOCmiIXqLj1
         J1gwNUYWyGuVIICM/Jzxe4UGj4Ye0ygStewXdCqv2ds3kiRYORXfwJSA8y6M1rgxz/Kh
         KR0A==
X-Forwarded-Encrypted: i=1; AFNElJ8i7IFXXt+WUhpjUGS4n9mfvycrhZyPjzMJoEdCLjXTuWIw2DSR1xITZeon6Mb5YpKBXnOq6M1pWGU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhpxISZvRaXXLJBPC+jHCZfMyTg96yr20gcMfYFL++qSR7OCDv
	VH3eWHGrFS/QIUo+FdpB8yCoLS3BY7GokuXxzRuLMT1HeaNNPSc7IjiK
X-Gm-Gg: AeBDiet+FZYhuJW9k/BfpNqcrZMYjqf2wUs/PL5wbCoi4PFW/9sj4Ux9L0DCVveyDe5
	v1ql3zgDajYJuv2UYFmIPclldD0Nlj02DdIAAGF+FnJhe/rqvoY6fExbuwFdh4CeaGylPq0CyE/
	8buIx1G8eD5fotg4FCNsSAZaIQx54EdX+EseI+thlLi0ld6U9ozz2yC7udzK0YRhBBCVQnmSZzE
	sNvX4erJK5qB3drvQ2G+AAsAj8kdEwt2eOEpoQdpdZYXs1kOJetylhWIO0nEFHemk84mMAWAe+C
	drvSxe01A76l/Pib2rEq7rv1qMleszJnhETg+8thzX0Xah5vfvs6Jq+DUDZYinWwGgPVDFt4jPF
	2Okf36I539c6NFzJyPtPBwSPI2AT3LcsduIKgWSfyCPknWh3XJrDhdP/XAPJldyqvugQw32PqMf
	BQIOtJdzSQpJI2943lH4mdOcmbUXBUvMO4eXTh1fELuGIWmJqaNipsNEeOhqrUepqMGuiX
X-Received: by 2002:a05:6830:3142:b0:7d7:5b78:ef31 with SMTP id 46e09a7af769-7de9a00d5dbmr1843887a34.12.1777380407397;
        Tue, 28 Apr 2026 05:46:47 -0700 (PDT)
Received: from linuxescape.lan (23-88-128-2.fttp.usinternet.com. [23.88.128.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7de986a5601sm1683041a34.19.2026.04.28.05.46.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 05:46:47 -0700 (PDT)
From: Maxwell Doose <m32285159@gmail.com>
To: songqiang1304521@gmail.com,
	jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/4] iio: magnetometer: rm3100: Use guard(mutex)() in rm3100_read_mag()
Date: Tue, 28 Apr 2026 07:46:41 -0500
Message-ID: <20260428124644.49707-2-m32285159@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260428124644.49707-1-m32285159@gmail.com>
References: <20260428124644.49707-1-m32285159@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace mutex_lock() and mutex_unlock() calls in rm3100_read_mag() with
the more modern guard(mutex)(). This will help modernize the driver and
bring it up-to-date with modern available macros/functions.

While at it, remove the now unnecessary "unlock_return" goto and
directly return in if statements.

Signed-off-by: Maxwell Doose <m32285159@gmail.com>
---
v2:
 - Switch out scoped_guard() for guard(mutex)() per Andy.

 drivers/iio/magnetometer/rm3100-core.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/magnetometer/rm3100-core.c b/drivers/iio/magnetometer/rm3100-core.c
index 2b2884425746..426963935d60 100644
--- a/drivers/iio/magnetometer/rm3100-core.c
+++ b/drivers/iio/magnetometer/rm3100-core.c
@@ -204,27 +204,23 @@ static int rm3100_read_mag(struct rm3100_data *data, int idx, int *val)
 	u8 buffer[3];
 	int ret;
 
-	mutex_lock(&data->lock);
+	guard(mutex)(&data->lock);
+
 	ret = regmap_write(regmap, RM3100_REG_POLL, BIT(4 + idx));
 	if (ret < 0)
-		goto unlock_return;
+		return ret;
 
 	ret = rm3100_wait_measurement(data);
 	if (ret < 0)
-		goto unlock_return;
+		return ret;
 
 	ret = regmap_bulk_read(regmap, RM3100_REG_MX2 + 3 * idx, buffer, 3);
 	if (ret < 0)
-		goto unlock_return;
-	mutex_unlock(&data->lock);
+		return ret;
 
 	*val = sign_extend32(get_unaligned_be24(&buffer[0]), 23);
 
 	return IIO_VAL_INT;
-
-unlock_return:
-	mutex_unlock(&data->lock);
-	return ret;
 }
 
 #define RM3100_CHANNEL(axis, idx)					\
-- 
2.53.0

