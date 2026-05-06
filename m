Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D29283C9D
	for <linux-iio@vger.kernel.org>; Wed,  6 May 2026 02:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778034312; cv=none; b=QZUa3tZd/ioNQeLzHCUx+GD1/CbWZgyEwrtuIEbzE9DvvYdP//pFaVhhXpX9reExughjUDFJ2YqwHoF58wZjTeQ6maGyeJulIdAear8QHP7cMZyojf8he9h9Fe1TjYXqeLekdoZiaw1OQGsU8hamHBfoZj28FxaERKw2EsuUZLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778034312; c=relaxed/simple;
	bh=I1lPHAVhik2/qZiEG/gjONNJ/Zs0mWlMF7PpuRBph8s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PBaMpGSiY1NVoKeGR0yLDquhbzEub3YqaQQfmFcHGGEnn28bkJ3wVwmKED3zwKZs44mh8IrV4WM+KxaK/bQ2eMZGsomtN0eBA1oeZY0YAfFLz7bhBQwEhiCsvjzMTJ7G+78+cgheAdn1EMCuwE3De3vqnDZ981CSO+4Uit4OrkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ime.usp.br; spf=pass smtp.mailfrom=ime.usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=XdOy04Ri; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ime.usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ime.usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="XdOy04Ri"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-2ef38cf04f0so6222045eec.1
        for <linux-iio@vger.kernel.org>; Tue, 05 May 2026 19:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1778034308; x=1778639108; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TK318sW2EU9DAUWZ70nTfCW0Y3oKpFjEiSuIXY+LKMM=;
        b=XdOy04RivZLAKZC/bzmRxLM1/P1wQgnlka1J7K6bbp4q0RnOWpBZbuPMBBC9nuoXEA
         OFrxdk8j/XrGn0WDok5hNImvF3Ay/Tle8M27VKgn2b2E43BE3dcrIq4ITqDxvUvaWx0c
         HdUEtC2nlwWwS6A2WPY+NNkJiFLCuwJSBZfPzyiCs+fyAQKy23R+BlycVV6va1cVntpd
         92Jq7fGpAUd+WU9Al2ovUDI862pe6Cb7Ui2ys+/CnIn0/fmJVMASee3UDuusZIO9PWm2
         kLLi4dvA94tu3jN0FSi2nkfd1IGb0lJoRboWjgkq5r1DKjpkkV7rv3CxOdi3PYLtAB5h
         QoAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778034308; x=1778639108;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TK318sW2EU9DAUWZ70nTfCW0Y3oKpFjEiSuIXY+LKMM=;
        b=Hx2lr8SnSRAANDJ+leGIiwyhlJfIoXBBFKh6qnOvTRvtrAQK6FCDS0ZxULIJ56Rd/7
         wPjuOoRfnsqdaJ7X6Yl+BP7shjV9xiTUJmAdnGCk4xq+Fit3KWOcRD6aSaCEuShHWybx
         ug+ZXfrtWIfKnSruLam7rMzSH0IAY25zA+GQLy9KEjWzSvm3zuke97ygVtoMsVD2KreJ
         QjVZhew+byrmrBeuYHQ3wWceNtuBzS/APSDOcoepD2gInEKR45n77KxCgbjzgUMHFuC1
         axuSaK7DOU+ZFB/jiHpCJRqy/mPfyQrwRzvAbOgQrZyUTPr1kCsfDU1Q3jmVHW34AGmw
         XAcQ==
X-Forwarded-Encrypted: i=1; AFNElJ8QNSYR1Pe8tF4IXDOWfqj0mD3HPKgLahkJ3397qr0Qm6uth9CXPS6pjNsY3+IYqFHFF7NmBJNAx90=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkH4ofBuoxsqjb2YYDVXx602YqrbZuDA/sHJ8DYmATQkcUL8Mw
	zyEZUtVVoI+ZZNVTw/3o1ncyd9BHTbSzS+iicV4W1aI0ISafXsNodk08aQnSvXMiJUo=
X-Gm-Gg: AeBDievyVGnIsa4eJGEC41ErN3HRACIymVsFiq8ciFr5TYvXCBZ/VfZsz1ohKkfFNOl
	0T9vDDpehjkXcsP9HWQikQAEnyc8uyEEnZebpIvKKGPg9HJjLnlmzoPURPh3p4wA1P+x9h83tDl
	VHGzMX4VpZyQTkTcUh+7dWGZqJ1RNVPnqluGMBPosZNZn6/QTPxYe+icqt86m/DB4D4I6RkItrN
	G/DuFldiOHbuf2+2TB1VZBQS5TQmVG08FAQwD3nEKmwWoElnJB8/canua3W8uxMSBfvtAxzFJ5G
	6s0kSwJtXlv9qZ9GyKcuj8GcA/Z48EdNur1LIZpkukspfBtGu8n7hgaMenIIRJ7j1epHLkslhwx
	Y2G45OwfrgbzDq49IpwXgTNz9dH5rZ0GdI/Br46I77MKlmh1InRy12qPGUWJfi2KTs42CRuLmT2
	6pIrl1wv9GhI5k2mqLGvlhzdRLjogLgr7E/w7j9xs3CqdfGg==
X-Received: by 2002:a05:7301:5781:b0:2f5:3641:f126 with SMTP id 5a478bee46e88-2f54a383b37mr876178eec.24.1778034308481;
        Tue, 05 May 2026 19:25:08 -0700 (PDT)
Received: from localhost.localdomain ([177.81.10.105])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f56d5c3783sm1669552eec.11.2026.05.05.19.25.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 19:25:07 -0700 (PDT)
From: Felipe Ribeiro de Souza <felipers@ime.usp.br>
To: andy@kernel.org,
	dlechner@baylibre.com,
	jic23@kernel.org,
	nuno.sa@analog.com,
	paul@crapouillou.net
Cc: Felipe Ribeiro de Souza <felipers@ime.usp.br>,
	linux-iio@vger.kernel.org,
	linux-mips@vger.kernel.org
Subject: [PATCH v5 0/3] iio: adc: ingenic-adc: use guard()() to handle synchronisation and refactor lock-held helpers
Date: Tue,  5 May 2026 23:24:27 -0300
Message-ID: <20260506022454.128169-1-felipers@ime.usp.br>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In drivers/iio/adc/ingenic-adc.c:
- Refactor ingenic_adc_read_chan_info_raw() and ingenic_adc_enable_unlocked()
- Replace mutex_lock() and mutex_unlock() calls with guard()()

Felipe Ribeiro de Souza (3):
  iio: adc: ingenic-adc: rename ingenic_adc_enable_unlocked() function
  iio: adc: ingenic-adc: refactor ingenic_adc_read_chan_info_raw()
  iio: adc: ingenic-adc: use guard()() and scoped_guard() to handle
    synchronisation

 drivers/iio/adc/ingenic-adc.c | 68 ++++++++++++++++++-----------------
 1 file changed, 35 insertions(+), 33 deletions(-)

-- 
2.43.0

