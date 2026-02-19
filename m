Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1367E2C1589
	for <linux-iio@vger.kernel.org>; Thu, 19 Feb 2026 21:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771536984; cv=none; b=I5bsyZWoPxZflRxmtYq3AdWnxTgqZOxJV9XG6oK6RgOlLUAxwpW2JPHCDffGREjEHFxVY75padKsK8+5pruO7UHHSXIV+nNuVJ/4HuOeHPQhtrhNyGgIzY8MTef936sQm9zMYgegwiUSaMLQq+v8XSEheiRYhXyLWVdBGB/CKJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771536984; c=relaxed/simple;
	bh=oXvAdN2AtcWVRwwQBrKaem6YW+NGB+zO/K1Zlwao3CQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S1s80htRDN7xypLu807NCbmQcoZrE9HrI2L8IGxbVVrzvwgDQ+UkhXtZ8n7EDRkwZNvomyH3p1QS3Or9PxxPJJwBeB6bQ5mK0PFG8y1TBPCHVOx/TWzSombm4FOHhs83h7Rnnz26QKwe8mB1TW46CkiscMrDv0AayTkp442y1po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KOjVLtPY; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KOjVLtPY"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b6ce6d1d3dcso525751a12.3
        for <linux-iio@vger.kernel.org>; Thu, 19 Feb 2026 13:36:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771536982; x=1772141782; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yRjmtmqlhxUMat6OJrfhRoijlU84UH5Ws0UPOOfI92s=;
        b=KOjVLtPYDJCSi/wiRB8Rg4qKu+Ddo5eeYr73/WMNGa4M0XCrg3Bwbn32ilUuloRj3X
         60lqoQZJVxPcDwr6ciqu8XASrl7GaJxYSxRLfOvUR9iBp9PUQugKccGhHKaLcDY/eDvJ
         KSFN0/pYw47qoM0aW2Ra0w6A9vwjbgu0sFWJcuHv6TCaLdAmLYQCZFsgFXl9HtgNACvm
         OXs/5ncKjehR33yC5VxWu0pOuhz85bXiPCsG2nNAKAIeSY74gBRERxhmNsoaEXzCqZ0S
         aV4CBjxjOPMd0XkWkgVRaZqWujCut8nYENwqAxhWb5agZY8/Cozyo0acH6jNnw3E7HVp
         qxOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771536982; x=1772141782;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yRjmtmqlhxUMat6OJrfhRoijlU84UH5Ws0UPOOfI92s=;
        b=Z1fZjkge21zWgOPrup2VeXtbSg3F4VsY+D1kyvKdHdJag3nkmQZtzF0c0N6vDyBrWh
         yH3S9CuzhLFHrZYC3TUbNWsLSDxbNWa0q9E2bwWj+bQ+A77xlUt1wJYv2i3lXDipwTyl
         6BtH8P0uz1L6bf/2GxFBTyP/+rabQLJb3xq3JtAltOM47fPayI1N3swN64OhSEEAVKNe
         665qmKdVRtkgN3qPUeSzGdy4Jnhsfjw0ShNvSY8pwPYVQ/jKpb8N0vuDVuqQ7em1212Y
         9BmFirmSyJQ3d6WdKYzUvRTu/Lku+SCbwxrrzPS5xj9JJterkzPaeh0gzWWefGzzcps0
         Jcsg==
X-Forwarded-Encrypted: i=1; AJvYcCWxT2F4ZtDejMNSEXbu3OjlM7u9ntu5pNpLRsOcqgVeF/OWZ+BQP4ghTMhi9s0whs7Yf7fsZyOUE9E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSuU7rwYT+4gWPwW0+EW9rCK6V4njFFr1usPiLbXrr4aOYacKi
	H+HY1LKIG5oqkJyc8lnM2y1+AsQtNDiaBsr1mf8Fkt2ZrXelLM5G8Bsg
X-Gm-Gg: AZuq6aJcCthVPths3DJFk7oqcyiBCL1fn12wH3tJLlMfJPkwgMSsVVCwtJgmEccx0HT
	P6wzxQQ3o78MrygQdUIow3LYi0/EGTbtVhLWpYZwk5FnTcguOQ5YAEQvJCNaW5QMoqLL1I7/7K8
	fdlFQYcLzuZcilnt0QsCaDHQYo6vYNJVuPk60bG1fpuLVyEbNE8HwQ74jYvKZQsag4iLxyObYPI
	LWQIH324zO9swaKhDYkcQlJnEQek6ntbeVqWMlI/4KPEn0GLX8zDnWxWSv79JgXumElpeUgWr89
	jLY/3qlATHLaMpsrybB9f/TxG3I10B5hxIrwdjgEN+zDCIFPY9e+SL5eD0B6wsTLgxvPWI2Scw1
	i9VEOAMX5rjiRbPLQ7RJAB1J18aH6QBtosM1kjO6bzEPvJb9zSUmUYaLc9dqbBAaDVtBZt3dE/U
	9JpjJ/Dqztt/+bqyoY2Y854BEc
X-Received: by 2002:a17:902:f612:b0:295:8a2a:9595 with SMTP id d9443c01a7336-2ab505d7b3cmr227428925ad.39.1771536982412;
        Thu, 19 Feb 2026 13:36:22 -0800 (PST)
Received: from arch ([2409:40c2:5415:8e16:49a5:aac1:3b74:3ed7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad1a7145cbsm238938475ad.30.2026.02.19.13.36.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 13:36:22 -0800 (PST)
From: bhargav <rougueprince47@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rougueprince47@gmail.com
Subject: [PATCH v3 0/3] iio: frequency: ad9523: fix checkpatch warnings
Date: Fri, 20 Feb 2026 03:05:46 +0530
Message-ID: <20260219213549.59645-1-rougueprince47@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <aZd2jAVnTIuz2o7h@smile.fi.intel.com>
References: <aZd2jAVnTIuz2o7h@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes in v3:
-Patch 1: updated macros to use '(x)' instead of 'x'.
-Patch 2: collected reviewed-by (no code changes).
-Patch 3: fixed vertical spacing and broken indentation.

These patches address several checkpatch warnings in the ad9523 driver.

Patch 1: Updated the macros to properly use their argument x.
Patch 2: Fixed the multi-line pointer dereferences.
Patch 3: Updated symbolic permissions to octal (0444/0200).

bhargav (3):
  iio: frequency: ad9523: fix implicit variable usage in macros
  iio: frequency: ad9523: avoid multiple line dereferences for pdata
  iio: frequency: ad9523: fix checkpatch warnings for symbolic
    permissions

 drivers/iio/frequency/ad9523.c | 88 +++++++++++++---------------------
 1 file changed, 33 insertions(+), 55 deletions(-)

-- 
2.53.0

