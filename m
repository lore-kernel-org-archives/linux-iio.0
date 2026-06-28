Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1D436D9EE
	for <linux-iio@vger.kernel.org>; Sun, 28 Jun 2026 07:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782630862; cv=none; b=DJJtp9vSjUDOnI0qly2tyrYNF+MZ/Fysh3mHDvyDJ2rgfkF32G5ZnUo40mx/pgtSEJJzxfiyVUXKGAVuRIzUcaBUr5V5c1xjMWhi+MS6kcxjitLUpn7n+8bk48q2nz3rTyT7O3XTPz5B9Q1gmtUhI0MQt2RfHDdlE0rCslCaTzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782630862; c=relaxed/simple;
	bh=6KwVdXym8m9VmBu/yZDbGr4sR4go0nT/ImlSsY/m7K0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sn72pFWj4CLQ0vjZRB+QlAZOjxE47HUQ6NM+sp7dwgRLkpatgF3Powu1RnvEaLMejkr5TE2pkcE7KM/fmumhj8SFXrFVaBtBxLazr6vwCCCTeX3Bp/HmdLRilxg2N7mG/XzBVMr2Hy65r7n1yMhCpqrI3rfSUnBm4W3e1G18poE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VFcHIhtO; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VFcHIhtO"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-30bc871ecdfso3038035eec.1
        for <linux-iio@vger.kernel.org>; Sun, 28 Jun 2026 00:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782630860; x=1783235660; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EJM+v6mJ9RBfgqnA3JaL3CQXECHO5LJ7tpDsIB136Js=;
        b=VFcHIhtO3BOBgSdZODZSh4uOSGmDwVsHHSYE8DUbaPyR70mEz7mnQ91w+6SqpdyeMK
         o+T19aEZkFUOp6G/DFBiD7WmTFPweqcmWKAN1D0aaTGLZBSPwY0ID4QlxwzQdGMEnfbH
         muRhPlgyNpX+y1m3sAiy1kn13Ur/qeXMjR5boQckjr4vtrVd84c/pUDLmobt+OpPugX0
         oJxodN7CZ0C5fu8qa9ySOQLdJvqXkfbEuTQ5fqqN47Zw3dzNGCeJ5dCBFaOJyeicsWSk
         sGZoJID2r01JMz0OaHKUd6H+Uzj4eveZ98F56TLL4snAasOcIZrDxkrOeT2Dboc1yk40
         DfcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782630860; x=1783235660;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EJM+v6mJ9RBfgqnA3JaL3CQXECHO5LJ7tpDsIB136Js=;
        b=RG2rnAxTHX0SpmSkDClN9ekSkiFl3rdA/HLcTLjvseGmmgqOs7aOmN+mbj17iYAXMi
         2Kyk9CVvH9rDdDRhEM8DQuYQv8uyGZ/lvkgqJ4QS0Y1cxI1ulWDN8U62Vq5mxGR36xL/
         FeSFm3MjbrYNc7lUo9nUP+tnpgJ/Ch9xzRS6sCQTbyhrt65T5rpuDUA5XV0ZaG/SiUcu
         wSm2rjiI9pNFxzpSADUqKxRber7aOGLaXHuw8GcWLbR6eJYDO5LVTcHFoMOYGLHADEKV
         HjFzkgeQP+S7Av8exLhXWLBc/Zzw7w5UJJw3ysdf8urzk/JryzsLrnk6yqGy/wq89QhJ
         xS6Q==
X-Forwarded-Encrypted: i=1; AHgh+Rr66/mNcutOuI5p6fe0HgxIY9UiSYFQ9L5jo01me8YvMqZ7T9i0qV8s6UJDqfqoFEUtZwJDDONIRTc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTZo2aGYxhHL+n5Ngi7T4CHnl5I6Gt4ZV8l4tCTteKC7dcElW6
	px1hOWsQpqrq5hq2AJGkQlXI0GBXtptmQtrvhgTPGDb93EsCV+ppnI6l
X-Gm-Gg: AfdE7cl+sBcNyW5S7e/HvpmCgJ4NwaAfX5cRxU7qZW2tXrO5tUjaPB1r+wpl2XHhfjf
	mblt7FxigJot37vQaDI1qOOeAoHxFQ/DywUApM0R/dDpmu9KX3d6euYBC2sr7Mg4dz5COatY8wn
	2aEcbdY8NZwb72ED7lTiBluiEhP9eIW0c2jHAzSogpOckhiBg/EDFACsqADTZuthDLFclgmEXcl
	okoj7/wKelRU+SCgsNbbQNr1BFuhdStpmpzadtv7wMjIeQMcJtHC1T9vFlUKXjxhyBQ77UldVJd
	xhk+Yc0HQaNvdUCEFZ8tZV4eoMiQRL5Buz04hR3zOgOm6G1Hgf2Ttc57xm/UYtRCA4GiyolVO7j
	wDlMjzEXbfu4dCJgQReuIdib5A3xY3JYZLSSS/wG4PZnl9nrEGBquuQghn/jInXHRIBvulZ2gjK
	+FzXudDisSlfximwfmeQoZgmxfUh3v/KzVSzw2Sn61gO4/8eg8NttgjA0KpxqTPkIVIw==
X-Received: by 2002:a05:7301:4e8a:b0:303:f2fc:c483 with SMTP id 5a478bee46e88-30c84cf3f9cmr12151533eec.1.1782630860420;
        Sun, 28 Jun 2026 00:14:20 -0700 (PDT)
Received: from moksh-Nitro-ANV15-51.. ([45.118.104.214])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c7c9e9214sm34474940eec.20.2026.06.28.00.14.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2026 00:14:20 -0700 (PDT)
From: Moksh Panicker <mokshpanicker.7@gmail.com>
To: jic23@kernel.org
Cc: nuno.sa@analog.com,
	Michael.Hennerich@analog.com,
	dlechner@baylibre.com,
	joshua.crofts1@gmail.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	Moksh Panicker <mokshpanicker.7@gmail.com>
Subject: [PATCH 2/2] iio: adc: ad7779: Remove redundant dev_err_probe() after devm_request_irq()
Date: Sun, 28 Jun 2026 07:14:05 +0000
Message-Id: <20260628071405.51030-2-mokshpanicker.7@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260628071405.51030-1-mokshpanicker.7@gmail.com>
References: <20260627192638.5623df0e@systembl0wer>
 <20260628071405.51030-1-mokshpanicker.7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

devm_request_irq() already prints an error message on failure via the
IRQ core, so wrapping its return value in dev_err_probe() results in a
duplicate error message. Return the error directly instead.

Suggested-by: Joshua Crofts <joshua.crofts1@gmail.com>
Signed-off-by: Moksh Panicker <mokshpanicker.7@gmail.com>
---
 drivers/iio/adc/ad7779.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ad7779.c b/drivers/iio/adc/ad7779.c
index c1a99b4c1256..a5b8bfa99a74 100644
--- a/drivers/iio/adc/ad7779.c
+++ b/drivers/iio/adc/ad7779.c
@@ -842,8 +842,7 @@ static int ad7779_setup_without_backend(struct ad7779_state *st, struct iio_dev
 			       IRQF_NO_THREAD | IRQF_NO_AUTOEN, indio_dev->name,
 			       st->trig);
 	if (ret)
-		return dev_err_probe(dev, ret, "request IRQ %d failed\n",
-				     st->spi->irq);
+		return ret;
 
 	ret = devm_iio_trigger_register(dev, st->trig);
 	if (ret)
-- 
2.34.1

