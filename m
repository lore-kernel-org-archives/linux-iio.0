Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1BF395D87
	for <linux-iio@vger.kernel.org>; Tue, 28 Apr 2026 02:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777344226; cv=none; b=nnNBk/2PkaTo/lZ+dTUPfITKSUNy5i8/ddElMjRSf3/h1gThoggreOLtL4EFwB7khr+n4gXizsDcc55tla8yWFuAXk4Nn7kVoAfr3VEavBLuGccaTzBBkZRzgtHWSncpPQDR3Y48tAXEr7dKIn+9OV+h7apPfBw89ZOG05Q2sHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777344226; c=relaxed/simple;
	bh=KaQ+WdAKFfqKTFp/tfCnBRQxmT/SyVndsAgxXfzkNgc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tr7lVhDhqpWGtzE8IBz/0eSkH6dUMEUQx4WBeb36UouapFMKvSyQxchvjPs6qiPk6WX4pHnLBSQvRDi8yR+I2dWFvt7iyI6iuOcNU5cYm+TOUz7WUzw5IO63u4DVOv1UWNJRw5sayrWevEMqB2ubI51H0dwKPqYkvAs2++sq4Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EB0P1Uwb; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EB0P1Uwb"
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-67e09232daeso6660566eaf.2
        for <linux-iio@vger.kernel.org>; Mon, 27 Apr 2026 19:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777344224; x=1777949024; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=73eztNPvUbceIU07UTl+YS2mjJFGWp/EmbZghnQULsc=;
        b=EB0P1Uwb4nF5qdixE860wiipCHec3QF5NIzZIgZaHxOByj4Rhtkly5hbuJY4fJGlXM
         ipJkw3lz2oa3we6OTnsUrNlHeTxqclaAK6FynsLNCfv+BHhqfMO5ECgrJyVKO/aYbIWN
         v81ux0o/hjCosKgCSwEN+2YdihTOy6hoJpzQImIKZy8jDMhlOFQ5t60etsrBjkfEAMPD
         N11ao5yUndbyIjJ8Tmkh5uVB5IL0r6Vy2sMMPqKd/BeGR3sfSkr6/9TWgMB7Ir4+1/f7
         6b4eBj+f5qRKPgbiWpFoYASkv2ZcbYVX38fFz4pcdh01aNVDYw5GqdaMM4WZj/Apl/Bn
         rGzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777344224; x=1777949024;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=73eztNPvUbceIU07UTl+YS2mjJFGWp/EmbZghnQULsc=;
        b=IxIP+dryZikNMGMhuteHRVBnlNFWImfGH14WPY37FL4mKE+IkKCNMeospL0hPeE0hh
         EfiEnW6xFYI6ZoB4MZeqQ4njiQP2wMcDVY8Dp5+ZtxT6df7CMIAm1LZS/NauvYFJ7v0W
         fryOU0J0V4xrHD/4xOBSaTXEYJZRCU6IUUSmwqQfF1hJgwh3JA5G/fbhBAOXO0WVw9i5
         KvmMQm2jKwTGjPErzzm0pTVOy90hN38ZpC8Yxfu+1qbS9l16aYejsBCdDTGjrQkTot2Y
         8zIIJCV1bX+QjNnoEdQTvWL3mOaLjO+I9RXGHDejzWpZecmKCnBW8UPS08pnxBssg6GG
         yI5Q==
X-Forwarded-Encrypted: i=1; AFNElJ9NqVexvHppcFjz8Zio7FRUXuaMkHHhCXT0Cf0tItG8K9ztktqCteU+d2ZYkGQ3mhmHU00LvlrWPpY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx23081oEmTNF0vEG+fvEmpcRO2wfo6zvAbIg677vtintCcgH1I
	EPDtOXiiGTEhsA8LAOImDInvoNb+smXsz5zUS+HZl12T11NHIn9jnV2Ue/FWNQ==
X-Gm-Gg: AeBDievHbBrMYSJzK+2bEytONdM/W1U3TbrFpBrETYf0Wzexm2k55t3eLu2DEaPyV8j
	fhZcBErcinzWRcV7v8vG5mEESWNOlK3ZquBkGy/vSVWMaGSLZZzy1Y6ZYdwOtV3K6qpnj58NT/T
	78suyQKdEvJ9oFbbys5i51CFYA1Hk+ZMKymugLcG+cQaBi9qb0+/q+g42eBajMCwI5LvY3ISji0
	plpDZ2f1ed5nuZFJXa2RB70ZfpoRMc0maLeidEAgx+fMCGl7kA6cohzjUMbvaKsPr4qXLvLM085
	XtzBrd831NB+68xIQNqqK7bw+JkWRjDQWksmv5e1zeS0sgHBKUOt0LtNkghVETkFPFA5ZifcHUP
	f/Fsbj3rvl8bgv+u9+/IEqYZVg6P1ouU1+1cPZHBtbB+MdDIBPFpf2pJcCe3xRaEjAdUR02bjD1
	E1UVhogkli7gSB/MYOVontjC6rqLaONQG5zdMxTiM07Vfua5hFs8tqJ1p30nMrMIppBqlH
X-Received: by 2002:a05:6820:605:b0:694:8576:5d7a with SMTP id 006d021491bc7-6965cb42780mr619410eaf.30.1777344223818;
        Mon, 27 Apr 2026 19:43:43 -0700 (PDT)
Received: from linuxescape.lan (23-88-128-2.fttp.usinternet.com. [23.88.128.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-433efb816e4sm958392fac.1.2026.04.27.19.43.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 19:43:42 -0700 (PDT)
From: Maxwell Doose <m32285159@gmail.com>
To: songqiang1304521@gmail.com,
	jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] iio: magnetometer: rm3100: Use scoped_guard() in rm3100_get_samp_freq()
Date: Mon, 27 Apr 2026 21:43:37 -0500
Message-ID: <20260428024339.45109-3-m32285159@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260428024339.45109-1-m32285159@gmail.com>
References: <20260428024339.45109-1-m32285159@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace mutex_lock() and mutex_unlock() calls in rm3100_get_samp_freq()
with the more modern scoped_guard(). This will help modernize the
driver and bring it up-to-date with modern available macros/functions.

Signed-off-by: Maxwell Doose <m32285159@gmail.com>
---
 drivers/iio/magnetometer/rm3100-core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/magnetometer/rm3100-core.c b/drivers/iio/magnetometer/rm3100-core.c
index a2bf6e504a15..76824dcb1b73 100644
--- a/drivers/iio/magnetometer/rm3100-core.c
+++ b/drivers/iio/magnetometer/rm3100-core.c
@@ -280,9 +280,9 @@ static int rm3100_get_samp_freq(struct rm3100_data *data, int *val, int *val2)
 	unsigned int tmp;
 	int ret;
 
-	mutex_lock(&data->lock);
-	ret = regmap_read(data->regmap, RM3100_REG_TMRC, &tmp);
-	mutex_unlock(&data->lock);
+	scoped_guard(mutex, &data->lock) {
+		ret = regmap_read(data->regmap, RM3100_REG_TMRC, &tmp);
+	}
 	if (ret < 0)
 		return ret;
 	*val = rm3100_samp_rates[tmp - RM3100_TMRC_OFFSET][0];
-- 
2.53.0

