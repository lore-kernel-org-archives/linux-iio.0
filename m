Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794731472;
	b=Vrq13d8cy5T0KU/18pZpW/c3IaTaboenKaCzesSncfvxeyPGphzYdk+6+x/Tra49UcxF
	 goxnOGIcsk/ZIunHYnAQO0tHLiXmhHSdw53IrRnpM/rEHGqfyYFLorvfWeFP7E2ZslGTh
	 Jaa4JCOrvNJeWewC5P4FSQfd0u3IK1bYMDKr5kAsVS9FQulz2G6VWSUUOcNt/oJRzQEed
	 UjBEO0OvAGhtmC61Rh9AclkhrgByM5dsoB/ZoV5A1frMvbFMPPhowFpoqbdqHSBpY68Ym
	 b+xvKnPRtCYNQX9bG/V7CeaP9xY9VAgh8Fqp8jH6FenEAo7sZ8G9nAtLCOjo1uQwk6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794731472;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=zuSlxP/wZehSt0jCPWAa5AKI3q/TR1ZMAo89fzmDo6s=;
	b=OrAxua6gccRgbHDyPemnoDZJtgW9X18xFkl60GtMCtKpxMrBJKuIBL2muKh8/1DdxdzE
	 YG7kJLRt0QYbSf3UHsW/MTJockyLQWb41YW54XKRotZoMXnfG/7vBRYEtCXF2ggkpf8zv
	 h8bCVCP6M+G3oAyvl2IvyzU/+ZbF7Z/OHzYE5vTuTSh/ksYBNJIsvGEwaur+HfLZXoMSU
	 5H5Ts0eoDX5Du4v/RpAVT1UdJBTN5+JyMf/HsG8q1gnOPKn28VyB/YcZLyHpdqbsfy7l+
	 s7vHc1kiyCBWtWpodM8jhZrNu/InG1VFXRXNTaQONBx3CiIABlAo9jR38Z9Fm36taLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=b1ZcCoPt;
	arc=none smtp.remote-ip=209.85.208.53
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA844606A31D
	for <linux-iio@vger.kernel.org>; Sun, 15 Nov 2026 08:31:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DA844606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=b1ZcCoPt
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6b785ca42ebso3785277a12.2
        for <linux-iio@vger.kernel.org>; Sun, 15 Nov 2026 00:31:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794731470; x=1795336270; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=zuSlxP/wZehSt0jCPWAa5AKI3q/TR1ZMAo89fzmDo6s=;
        b=b1ZcCoPtryXV2AC72mGe3XYRkd6Hb9ynWgrJFia3BIgx4xI+Y/7FZ8ELverDnFrmfh
         KtJANrjQtLz5C7dpINAV+qb1ZbFmoR0ZtdnlLwJBkjRQRf3+KaU93X1E0rz+WixvlcsH
         Xn9R5YFcZ2iKe+V5CexVcEZOpV+UuZyoY8M29oPnrFQuyB1+5v2MvZx4iy8j5lCZeDhM
         Q+2whO4e/XF+u7DDPYaS0D7Iw1KmS6TEuVwoyR51VUl1CzjsUV93ra/H/buP12zXquNI
         7OkkM70vS2uRgz0Id/W0DID0tZBCazEGwsM1QBBMYGX2fvdUAIEJzefTBwAK1QtpiAho
         plzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794731470; x=1795336270;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zuSlxP/wZehSt0jCPWAa5AKI3q/TR1ZMAo89fzmDo6s=;
        b=EekAuTZgY2MPgblaGgCFaPz6nAIz9v4ArUI51VgAMtdc2i9emZdFzFJnSzGnocrbhL
         Fq46SQ1aQyA/Wba08gIE4959HikNkSYug98iBc2pFVSpNKbarKbS5zfXLNrTDVde0PHz
         GEiQ6sx0hikJtgMrxj0rAxPtsDvC9ycFC8eeuJvWXRVFimFe9W7l9W+VgLyrqev32NqR
         2HrAmjNCe4LxqJeIu632S7XefvAygBfPQ65IBNmVo/0CeorxjewAUy9mW8n19JkBNYop
         xwv5GAWCAHUKb4wU2pzaTiMMYsjaxGyzbSD6Z1AMi4vaY9wnVjtyWem15iXqpW+rYsKe
         fbKw==
X-Gm-Message-State: APuU4Z/1D5UcZ3YJAy2pnk21flbL/OwiIBDC/sT2szwBNHHfY9r8kgTp
	QpNT/n6m469bt+POXRDbc5YFAnENhh0xlppV5ydeErs+E6mr/S/6puGc
X-Gm-Gg: AYBFou19jXjeFUYZj2EuMTtRxEiBJH4zVEMMvtWvQEuLYmj3XdwrLG3WUQGIPDyShxx
	iJu9diKJUsOU4rKu7K/jKwB4qYqIAyiuoFC7H0ZjQenY2vUIFkFGoq+wM2Y6MNJfeX9ihP2B21P
	6wBJPfZYUpYgA+qCxFV+bNVRpENWl6TquEbBIJdPvH5LbUzptyq1dT80wsItbbZY3kWfmJNProb
	QyEpqfkAgcBxvZnBY6t5v+OEeNbOiSO586lWLzLZRs7xsBFZ+ATfWWBJH54nGXEbrjkTyXyXt5K
	g0E1BxwoCMLzt5Jq3tR0bxAQZMiRbZoAs/IalzIxC1Z5P6NAWiNoSIQ6yBvmWSWXYgmHxsjPWN3
	czjKp2OH299NfoJZUDE7lHy2+wzGYM6cxjORiOnOlxyqYDgacyeDMM8Uh1iJo7jwZqmy2l5/LL/
	ljN09IWgJ9hdasHfaYSTQJRaEywfmLrLIT9MEvB9V+VvLUgur3hj96bgz7pbOM7HS5xxdzp7aBw
	mjGvYYsYCDX06EGqeLvESQwY4Zs93eDNu7IUQZEXmeZjuBcgwvku8efEFOr7gAe2Txxmnw1eGXS
	GHzK05tB1qgQp2AzGck+LhP9hDIWO9njbKEDjlBUtPLIA6J1B11JLQUgtIfhx2kIXbs9pTLm0/q
	nBFrkwHr1Qg==
X-Received: by 2002:a17:907:96a3:b0:c1c:4a80:30c4 with SMTP id a640c23a62f3a-c50962eeff0mr571434666b.11.1794731470128;
        Sun, 15 Nov 2026 00:31:10 -0800 (PST)
Received: from xeon ([188.163.112.62])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c50d9009bc9sm14019666b.15.2026.11.15.00.31.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 00:31:09 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] iio: core: Export iio_find_channel_from_si() helper
Date: Sun, 15 Nov 2026 10:30:49 +0200
Message-ID: <20261115083049.46840-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
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

Export iio_find_channel_from_si() in the Industrial I/O (IIO) core to
allow modular drivers to locate channel specifications by scan index.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/iio/industrialio-core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 825cf7f32059b..b59983d35239f 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -325,6 +325,7 @@ const struct iio_chan_spec
 			return &indio_dev->channels[i];
 	return NULL;
 }
+EXPORT_SYMBOL_GPL(iio_find_channel_from_si);
 
 /* This turns up an awful lot */
 ssize_t iio_read_const_attr(struct device *dev,
-- 
2.53.0

