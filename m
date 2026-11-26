Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795729071;
	b=hS9/dfWW/qZ/pyCWO1ZWDu+p7JnMXE7yF9ptNFDrDRgNVxdJTG7VJNRebNvZIs4e0oqk
	 21xzK6hBDvBhoDhsx2bzBt+x8OAAkZxq95gGRt0Nc2nV1SgmDRDDwHlGVFpP4wug+91IP
	 jCBNwDFwpZUqwH+hcOC5FRUHcvTM0RbXehE2Z8YyShFY84UwUg/T+l1KfP4AOoOnI0y0g
	 AhL/D2fcX2jUNyajXF4qyNl7JpGOBfAgvYpYWDJpH8rcJCPwajndQNstJwg8SPCfcdnZt
	 2OXb9BBIttWVEk3UPAdgeSFHsTota1WfMP4txkDu9yVrtQyqyce5xyXgp20Fhkzt8cw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795729071;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=rTynq6lcaX88KnM2KiakTF5u9vz9SlmUwghXiVPF/vk=;
	b=k1AjdL2Rq5i7TSAjh/jDVd8sTmqqfpo0x8AAXoINQzJ0vI/Re6X+oiAK1hyotPAy6IFC
	 mkEf2+jjj0tfRL2QXAcMOHymIR3p3o9O7IICkUhS9pd7FtGgQsd4ZMlPC6n6J6nJjf++K
	 9JeTJ5eZ79cQDBJENbMU06ICG+uCe3vz9BblvZBcTdpkeRukTY6A2t//ng3yGYxRemFnB
	 RMGJ6nex8YPaaNeRI8XAvusQxtmgP5dpwrfIakQaiYsaGhhD5hC2ixuoHcMra2V1J5jvj
	 btN2ennRiHf9sEsOl+wawCCwkDGpH838MR80re86TO/EeL+MwaJb7EQoOhvW3LWJWng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FYJdK2le;
	arc=none smtp.remote-ip=209.85.216.51
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1AF606A330
	for <linux-iio@vger.kernel.org>; Thu, 26 Nov 2026 21:37:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4F1AF606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FYJdK2le
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3b532e633e1so50382a91.0
        for <linux-iio@vger.kernel.org>; Thu, 26 Nov 2026 13:37:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795729071; x=1796333871; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rTynq6lcaX88KnM2KiakTF5u9vz9SlmUwghXiVPF/vk=;
        b=FYJdK2leuJc0wKyHr8Utf/JCiuUiElvSD4mRQPE7LDHvoRXwg+fkuhy6hNbupkWj7F
         JPNnSRoGeuPpflmyH9PGKlb2tLm/gHBAVFkJ3nZdTaBXoDd+WUSeMXiFg0uEN4jX9b3k
         q5mW/zQvDw6LjKhf80DpuOpPrey8iYe3BLtk7OYCZPpoHiAI2rQCdbBQWEyfhBAOzpi5
         k5cwWstJCtFwIc0ZZjESkDjM1i+OvsqZih3Ejr8RsNkgEkSeKustz06ylaPI4EUf8ODy
         nKR5LrhOfGT4qOcl+TUGA3+zNYrHIePN+RwFNY0dAu/kiakgqYO/K+sf5oX4zXySNH1U
         OtCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795729071; x=1796333871;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rTynq6lcaX88KnM2KiakTF5u9vz9SlmUwghXiVPF/vk=;
        b=lluu9S9Bw9/Ii2opTob+FfRd8CUKPJYu50kClwblbOnqX/NW0DNqXWUfOHHKokVZCX
         MZ4fglionRKr4z3c7dWcV1XJsLk7hSA5aAjLQ8yXsm4ZhH/gER/cGi7g1Y+agTAD9sBS
         J9V93uNxzPTyWgyqgMnccocJRALDjZ0JVrf4z/Q+30JftaWff8jYfXv+/iGDElc/rLE2
         AqI2Qe8bG2w7SZXIGDPdZg+IapLo4UfWAJfLwhiAPt/ho53Xpl87ClhqlTWliob2Fm9H
         GYg+/gXoUe/EBTDDchaP+5g95kTOEPD+XKi5YsUbgqKhN8VGrAMMoSaYu+4Erddu2Yvu
         lbxw==
X-Forwarded-Encrypted: i=1; AL+hErGg1WaMrkRxS75QE3ShzphiLgvZk3bKwMzzrO+d9CcKgg6hUGIVKI6x6ymxU+ZMtobgST0RKXGHKF4=@vger.kernel.org
X-Gm-Message-State: APuU4Z9HiOq/wpvrskNMXxLT1Ra8uYhX2AD+jYa0/EfW/6+DwQF4UG8N
	3vQXXTI0Istet/6pzWdJ6B4c1+3J7P/rDN1ABHrDVbYKAV2jicuEUyDB
X-Gm-Gg: AZFdTZcZuHOzUoygf1TcirXTZgO+i3TFPvGqc2difwxeNbguST1DN25xoMMD+Vho8dH
	BwvLAgpyyPEGbdBwm3NYJRpe7/mf7Li91AYfsrgo9aXDRDGk7JzLaYRB38yya8b7EldtFEAf0W5
	KzqpTlQWmDMkOc0pO6vPkb3LaijyP8m0rSOtnthDzsL5t3ymWFMM8oTkJb5uUnek8UCsTkZY4/E
	Zi9RDBX2Q9QmcWijHOya0fzSqEQrSjG1PSdg12HdUvDG/mSJg07Rp8fS55IjV1KLTaTNxrueV0T
	qkOJClcqCUnQRbftJKQHUuBblGxXsXq1PgCl5bstIr5KwcKkiu6zbXQoH1Mx4qGu/aowicGUSVi
	ppzP+rABYrmp5nadG86FGU9dOzXutYmiu7ZlCIEi4SrIzH6TZOtl3tsPO0E5wrWgprXF3KdbTUQ
	EAYl8/OyXJWlyC/zibkbxR937XgF8Pp2FqQcDkLMBTDAKBmlGvO1ITv3HNn7mSfvUWVqovzdm57
	4R7zcu2ypKwiZkRdyOhJOICPUurkEVcAFVyk6S5o95iF6HU0BwY1qA9p/nx58+BnC820uT0ImQZ
	NZCRMfApV7SpcEwK6JJU1MMTc+lRRWHHhm8oNk3lPCyYl8wlI24eRmFwkVZBHpxxjroei7haXP4
	p2Q1DYYWv2GGDA7XNsCVwTUZa5PFESggGL7X9xnrTj2H2ZDJdrR1L5jdcH5TCMxseXCodpDW9Qb
	2ub6epUJfThGTL5Cr7jimQsQ==
X-Received: by 2002:a17:90b:57c4:b0:3b0:9cc6:62ba with SMTP id 98e67ed59e1d1-3b41caead33mr20255446a91.38.1795729070725;
        Thu, 26 Nov 2026 13:37:50 -0800 (PST)
Received: from kapoor ([149.40.62.9])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cde6cea7c38sm11703905a12.2.2026.11.26.13.37.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 13:37:50 -0800 (PST)
From: Arnav Kapoor <kapoorarnav43@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Yasin Lee <yasin.lee.x@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Arnav Kapoor <kapoorarnav43@gmail.com>
Subject: [PATCH v2 3/6] iio: proximity: hx9023s: re-enable interrupts on resume for events
Date: Fri, 27 Nov 2026 03:06:48 +0530
Message-ID: <20261126213710.1047676-4-kapoorarnav43@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261126213710.1047676-1-kapoorarnav43@gmail.com>
References: <20261126213710.1047676-1-kapoorarnav43@gmail.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The chip interrupts are enabled at probe (INTERRUPT_CFG = 0xff in the
register defaults) and stay enabled while only threshold events are in
use. hx9023s_suspend() disables them, but hx9023s_resume() re-enables
them only if the data-ready trigger is enabled. With events enabled and
no buffer running, the interrupts therefore stay off after the first
suspend/resume cycle and no proximity event is reported any more, until
a buffer is started.

Re-enable the interrupts on resume if any event is enabled as well.

Fixes: 60df548277b7 ("iio: proximity: Add driver support for TYHX's HX9023S capacitive proximity sensor")
Signed-off-by: Arnav Kapoor <kapoorarnav43@gmail.com>
---
 drivers/iio/proximity/hx9023s.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/proximity/hx9023s.c b/drivers/iio/proximity/hx9023s.c
index 030a6265f896..d509de6e265b 100644
--- a/drivers/iio/proximity/hx9023s.c
+++ b/drivers/iio/proximity/hx9023s.c
@@ -1192,7 +1192,7 @@ static int hx9023s_resume(struct device *dev)
 	struct hx9023s_data *data = iio_priv(dev_get_drvdata(dev));
 
 	guard(mutex)(&data->mutex);
-	if (data->trigger_enabled)
+	if (data->trigger_enabled || data->chan_event)
 		hx9023s_interrupt_enable(data);
 
 	return 0;
-- 
2.53.0

