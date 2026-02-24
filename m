Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B9331690A
	for <linux-iio@vger.kernel.org>; Tue, 24 Feb 2026 13:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771939639; cv=none; b=iBaXg5MfMMrxEmirrFoZ58UcBAg8tndrDc54/2jyDSlGdqE7J6HHtDsa3IxO7gHqNAr0D6L85XtHByp4Kc7Q0hRpW1cxDYYdAXamxJVTEDN3ZTgoc8oCaJPTAhlcuyj1lVhSJmDIQ0eB9fzm2irB79sAQCX00R//ePErQ5zyThQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771939639; c=relaxed/simple;
	bh=Cb5yQTOhcNN1lnWoSWykzEcKo09127hec9zRFna64Ek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WIn/FTYi/e4yHNcAsVHyiwo53cS7VfNq4iHiwCP2xu6tKCsMmejLaekqto3JcR31OYiwDNStL6F+M4BPOWwoBAo4WCCAXR5KcqNG5ZyIHTgEcyi5f9q+eEafmcD2gjJi81F6naxPryizBTyqkbLqgLYkO8ibkw3EeGFPCJ7wipI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e2KU52vx; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e2KU52vx"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-48371104ffdso7291335e9.1
        for <linux-iio@vger.kernel.org>; Tue, 24 Feb 2026 05:27:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771939636; x=1772544436; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SR74xNkGsiwFvIQU/vGkQT5n9cans+mvhPbg96wk2x0=;
        b=e2KU52vx4As4S7h6HjT4FuJ1Y/g9d/4A4HkSx51uD6tZZ2pTRPMlGMynwJw5QLjmg8
         9NKrA6WYSno3s/aHvy6UITpoyFwEIESOm16l4/5gElXJIDM9djz/rC8mDnFcq1WHSptI
         BWTZbLdRVNQSQfdJiCjGxzADVx/gjVtFdV6r3AiXpw68rjtxztJEDMOBt4thEEnBSJhb
         +cwh/J8/AIryjm0v7KPpjgBtxIo3VocyKGApU/zS4p553HE8mDKZ1eIsV838LRN1hFnh
         hiCHp5k2hHu41CLQXm7NAKUjnO/L/5H4oYJMRFNW+qEdljYRObBeMM3+tcQxfSSCjJJH
         PqAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771939636; x=1772544436;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SR74xNkGsiwFvIQU/vGkQT5n9cans+mvhPbg96wk2x0=;
        b=TQluBiWcliTFTIRHMi64kUCeGlSPy8bt2gAKOHRXz9vpHxKO3LCXZ+Yl4rrwE8GeNJ
         X+mR+EzBCeclO+OSUImXiQTVOfkC0rDqbOQ2yJxDGGLV/6yujqwA8orRibFFTlQTKJPA
         EdTcdELqJtj39SFB10wkThITYHo4e40iZutHPthexngDEZ17mFZ4gDeiVcn8KVjAgrk0
         Mx8b3yaFQzjrOZeJRFsj4O3IDNRY5/d3KAJE9J4QKANvIKAZuJPt2SVzgbd5mw5fBCPv
         RByX3gyf1Pw1o5cc4Nyf7NgH3MsTM+v43422SoOM+qwABTlPX//NWpIInwqtR6v3wfoX
         vt/A==
X-Forwarded-Encrypted: i=1; AJvYcCXbQ9bhJbcjMa2wshFXaOnFlUgA1whJWLNDa6isicGMPtCZgWbZ6RzJeUV8xzZKMHvIDJyQke66euo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHennANlfRth39zJ5DgRRhCesCt0/k2YwRICSiLCgf/G3yGNgW
	qRBx9TFkcCfJZsfnFY0GKKZqmXOmMcAsRI9UeqhGN+RO9M5JVmhQDV6I
X-Gm-Gg: AZuq6aLfzDQDNvtWzKjvQfal4r3C0/RanktgcBQ1YWBOnnQYG7HL8hoa0Nc/4+7jJiA
	UOJfaBVhCNuf0gZ/sATS3OXEb0BXEScUMkP0GIjrv4i13rJxEHmUj1I7xD58RIwjY57PcRJgqlD
	VWkfSP8kF8xJ7b7ngDn7s43MSnGzvUfb7fICMi5jdnYI8QYjlNNDIE170CeOkosg4dHLZONrBlQ
	9A20HWRK6CpWDNGddbDVdTIAutw/rtfUTOa7ckI1V3Hh2AbV2e/aq6bFS/ZUw3oUqtKgRZmjgmo
	0FFsR7y3XC/93l5Sjw661oh4xAZRXOnr278WGTOOwQUu0doU8XOm6YSqmYepBvdwA+wydTbnU+5
	Q/G2rjz2NO8JYfGY8S+/bAPzmEpNaFFhtf5Io2WfPgGjMjFJfgZ6kHQNQUCNM0aJBV9fqjUSNT4
	KQU3qPhrMww/WgrVqwfpcfVW/aATwGdZEwGNuigpGFu7Ks1MnFgu2B9TltedSPXWINuwuSEg4wk
	Kg/WIkCvVJze3EfnosI5qRHUrfhm6WOBrFggF6r9XkdsOvsvMJd
X-Received: by 2002:a05:600c:450c:b0:471:ab1:18f5 with SMTP id 5b1f17b1804b1-483a963d0e4mr108894325e9.7.1771939635980;
        Tue, 24 Feb 2026 05:27:15 -0800 (PST)
Received: from fedora ([149.3.87.76])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bd6854c7sm258445e9.0.2026.02.24.05.27.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 05:27:15 -0800 (PST)
From: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
To: Antoniu.Miclaus@analog.com
Cc: Nuno.Sa@analog.com,
	lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	dlechner@baylibre.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
Subject: [PATCH v2] iio: adc: ade9000: fix wrong return type in streaming push
Date: Tue, 24 Feb 2026 17:23:55 +0400
Message-ID: <20260224132354.76672-2-giorgitchankvetadze1997@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260224125921.70946-2-giorgitchankvetadze1997@gmail.com>
References: <20260224125921.70946-2-giorgitchankvetadze1997@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The else branch of ade9000_iio_push_streaming() incorrectly returns
IRQ_HANDLED on regmap_write failure. This function returns int (0 on
success, negative errno on failure), so IRQ_HANDLED (1) would be
misinterpreted as a non-error by callers.

Return ret instead, consistent with every other error path in the
function.

Fixes: 81de7b4619fc ("iio: adc: add ade9000 support")
Signed-off-by: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
---
Changes in v2 (Antoniu Miclaus):
 - Drop unrelated newline fix
 - Add Fixes tag

 drivers/iio/adc/ade9000.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ade9000.c b/drivers/iio/adc/ade9000.c
index 5dcc26a08970..5d659f1bd3f7 100644
--- a/drivers/iio/adc/ade9000.c
+++ b/drivers/iio/adc/ade9000.c
@@ -787,7 +787,7 @@ static int ade9000_iio_push_streaming(struct iio_dev *indio_dev)
 				   ADE9000_MIDDLE_PAGE_BIT);
 		if (ret) {
 			dev_err_ratelimited(dev, "IRQ0 WFB write fail");
-			return IRQ_HANDLED;
+			return ret;
 		}
 
 		ade9000_configure_scan(indio_dev, ADE9000_REG_WF_BUFF);
-- 
2.52.0

