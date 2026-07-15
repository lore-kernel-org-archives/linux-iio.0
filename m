Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A4B43B6DE
	for <linux-iio@vger.kernel.org>; Wed, 15 Jul 2026 10:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784110265; cv=none; b=WeHclYyuL3L086GotfyqSWPX1AFXUkdoJDWWwW0YlT4g/y0Qmgi8mEN1EAs2C0r0RZA3xzVRXycC1y85ruwkog7DSLJj/0+XAcUHJwVd3zGEP/9Z4GrkFkTdA5Z9dueUvzYGLXOAkeo4AiJocCdygkI0KxaNo9qSlVOY06C2vr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784110265; c=relaxed/simple;
	bh=yXQameaNSRa+QXBKj6CBG0heh79Z1cjYE9sx8sHKO3w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dbVQ1fRZJYj4VQrNJ1Y0jzTEDvHD6MK4wpOaKNjlUZ2HfB0X5yTMnPXWgFe2zWxao55dhf/8+npHu44CyRrhWO7kSMzIrwJfvpXa+U6X94HVQvluORJbdkKTP86aA21n3yjVAx2EAZqzes+vEz3rKj11cIBowRv19Pz177ByBMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y4/onsmn; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y4/onsmn"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-381891a9525so5599452a91.3
        for <linux-iio@vger.kernel.org>; Wed, 15 Jul 2026 03:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784110263; x=1784715063; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gBNL9jZr+BjLwoEnPOS4tAnKcJKl6B6YE59NAlSHzw0=;
        b=Y4/onsmnAskXenXpCeVxbGxc+TXpe3pIuBFrpYX7Y1kB0MGKCONi3s/d+yeh+GEqyF
         LndMf2Bv+Pq5oN2MWyeKdvsY+XHU0RZXVkLX1O4AGqPxLQH62i+qDED05lVFxmm9ftlH
         BZzWszxQgy3fPeUNdrO8PLoTmQzMxju49NZkUL+yVTrA3mQM7dZTBt6tsGLUPHjhvUyo
         QnxCOTQ1MEkBNJ3Nza5qsxlyUhUBRyGli5lbZIx7FyhXDw7fEeGzbwizZqkr6TygtBBI
         DKd351njxAWtFmm599MYrg3fVsNymSyhqaju7xlYpAlvSVjrPW3OtE2nvmo/I7e5ZMKj
         jLSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784110263; x=1784715063;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gBNL9jZr+BjLwoEnPOS4tAnKcJKl6B6YE59NAlSHzw0=;
        b=AyloJP2n0urjhCLaC2Jq7j3jat5TBwMUP2m1YGdJuI6zkIIhsgCaac6eYvY3nn+zEH
         NKcOrxbjv2ddsmnv9eAb6Pknvh1TUDGkzXVprkUm2ZyFJfzcTjbni83w9yqvEcfB7Gfd
         3rSR8/UDBB7nZw1ihl1jPJfZmUYHYDv9hOYDKK3ou36qEmtUTzMkd3VPyhCsaxejt4Sp
         6uM+ZVpUTaWTaf0S4MCpQe0AIPrINEptIJZGz7hPH1A01d10nY6oM79q+KHxUdVlnSCL
         Lw0lcBH6LcHIRAbS774YdmS+fNmjdl1ANmw1zbNgHV+1Y2NytMhkSbBfiBfPtV73uOc+
         zhcQ==
X-Forwarded-Encrypted: i=1; AHgh+RqacVeN5NyfQnPyWI9NJaOaA6xI8BKBi7N2/4ZFHVQ9KA9OwLgOfJe9r7V2ICTfcspEd2BIiHeMB5A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7Yhtt3UzRm8zUzFpYt6vNfiPWkPQycrLXSvyZnnmaNB1N0lNR
	i7yJPECDHPOR2zX/5NC+8x7h1A9k2nRYNwk//Sy9MCPICLvxPxyZtpN9
X-Gm-Gg: AfdE7ckm9ndPlxtFauDCWPN7o8B3put88aEHl7rQoo05BfVUNReRns2x7Z4SN2pUdZg
	fqhioIfNmUMT0exJyC/5tsGAYE3cNmpP1CHZ7b1PhezOyG5XdgChJjaIhXNZEf9XoWrjKFN0rJ4
	t1rFfwSLf9SC4WXKJoJIgtVeipXTHMFzOCd9JUjxMv5TqZcpHZpnJin8zWRNgLQ6faNP72l1fFH
	mKKL4CQq2POC/8mcP4LsyTh+wrp3PG3Ha1DxSDIqF1xiVWe+CdMv9+xfWX+REgK94U6654x6JRd
	nMRnNUTKQnJiZXAjWWrquFbRpS9jK0rMEntDw138V423h+YLJty3ENx3BRtqTml8j5+CadywxLj
	hZgozDpoZUdhNtQ4W9EWWlmkEeKGqf1m5rgayBcokgEaQQVyFU5uK5L4WYeiSgvjHYFNCsPgVLb
	r7NmrurM8KZ8FzkLNPvsfepUT4qxciSXZKfhkd8gvEa1/AslmkNLE=
X-Received: by 2002:a17:90b:55c5:b0:381:77cd:38d1 with SMTP id 98e67ed59e1d1-38e1ae2679fmr5266216a91.10.1784110263189;
        Wed, 15 Jul 2026 03:11:03 -0700 (PDT)
Received: from primary ([223.181.23.34])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3119c2a7bb5sm62079757eec.25.2026.07.15.03.10.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 03:11:02 -0700 (PDT)
From: Vidhu Sarwal <vidhu.linux@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Per-Daniel Olsson <perdaniel.olsson@axis.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev,
	Vidhu Sarwal <vidhu.linux@gmail.com>
Subject: [PATCH 2/3] iio: light: opt4060: Fix pointer type passed to div_u64_rem()
Date: Wed, 15 Jul 2026 06:45:43 +0530
Message-ID: <20260715011544.281148-3-vidhu.linux@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260715011544.281148-1-vidhu.linux@gmail.com>
References: <20260715011544.281148-1-vidhu.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

div_u64_rem() expects a u32 * for the remainder, but
opt4060_read_ev_period() passes val2, which is declared as an
int *. While this has no functional impact, it triggers a pointer type
mismatch.

There is no behavioural change because int and u32 have the same
size and representation on all supported architectures, and the
remainder is always less than MICRO, so it fits within the positive
range of int.

Use a local u32 to receive the remainder before assigning it to
*val2.

Fixes: 0c6db4506ad0 ("iio: light: Add support for TI OPT4060 color sensor")
Signed-off-by: Vidhu Sarwal <vidhu.linux@gmail.com>
---
 drivers/iio/light/opt4060.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/light/opt4060.c b/drivers/iio/light/opt4060.c
index cf6f69e5be35..e3aabfb14d5d 100644
--- a/drivers/iio/light/opt4060.c
+++ b/drivers/iio/light/opt4060.c
@@ -713,6 +713,7 @@ static ssize_t opt4060_read_ev_period(struct opt4060_chip *chip, int *val,
 {
 	int ret, pers, fault_count, int_time;
 	u64 uval;
+	u32 rem;
 
 	int_time = opt4060_int_time_reg[chip->int_time][0];
 
@@ -738,7 +739,8 @@ static ssize_t opt4060_read_ev_period(struct opt4060_chip *chip, int *val,
 	}
 
 	uval = mul_u32_u32(int_time, pers);
-	*val = div_u64_rem(uval, MICRO, val2);
+	*val = div_u64_rem(uval, MICRO, &rem);
+	*val2 = rem;
 
 	return IIO_VAL_INT_PLUS_MICRO;
 }
-- 
2.53.0

