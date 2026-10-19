Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792454432;
	b=l7PZOpHP78LfjbM+0LvHqExOOeYOj0PsuiZc8tpmO5Woevj5m+ngl4xoLx0jyuEmKx09
	 pQOSL4xnU73ly2QtzUVuUKGWf1llmPAi++MmtanGumyfJoLYqJmzjJ4XOicOBfbGWTax+
	 JBiUlHUslmnj4Fbh66IYqbUKQ6aOxOwVYWoI1+gw4T5iUu9yd3Z96ZfQEr+p7Y8kRPekz
	 WYe6hSev2ZyfBkuHJg09IHfVEZC7KFjW+gsOLGKiuDDKZ6JZxXBy9aV4UVd0GnyJAg1h2
	 zBQ/4MVPrsV3ElYaQTmJkgVepJcsJF3OAIdierD9Q/7yOYTnux07Ky2pGk7rEYWGRsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792454432;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=kOEW7S9rMOKRcbBBo1xEhhJSd5nf3JnZXymk/xgXKU4=;
	b=1X8zOZCdVJJMgU18GFqTJ0uilLWufBXLL0bHCL2CjClePRHHssP24fz033Mu6juliAaO
	 sBT3mh+cMg35mHyUseaML5pkD29gCItdHM4yipb1Xe4wKwdgACpSLaWT8G/gkial5PfOn
	 url3dj7fMJjk7w4S4l5vcCUmhGINbHqYfpQGiZsEEr7fhVNZNvEvTa3lRjbS0jMNkzN6c
	 10S0dvFcI92zELv/wKQpbdD3FnxJiln3APbLKQPyy8pY8t0ThcZRxmbkzt4jrIaHCPVcS
	 KNtpcMAbcQ45ORJjR7XT4K4kxhZZ/Eh7r2cNjgWPJ4ktmSSQuJPrGM3JS45/URrFceg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=SCmOf8BC;
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A27E606A319
	for <linux-iio@vger.kernel.org>; Tue, 20 Oct 2026 00:00:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8A27E606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=SCmOf8BC
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-33fb4680717so4577621eec.1
        for <linux-iio@vger.kernel.org>; Mon, 19 Oct 2026 17:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792454431; x=1793059231; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kOEW7S9rMOKRcbBBo1xEhhJSd5nf3JnZXymk/xgXKU4=;
        b=SCmOf8BCqz1c78pw3ObHcpI6bBn3M/Of4yKhXYkhXq98ab4cFiCh499HcxncWxO2zI
         49ZrOKmdCfuWkwFoP376ZIzcgSVEtxeH3voW98E47ZAs544fDDQpRChC5xn1cofnD1qm
         feAiXoIiZTBcDOagr9ACtyGvkBfkq+NpnIVAJ7tKZkbQhduw3Ofnu/zZTW7x6awuw8Kw
         65dHNHyvTeI4yP6+NA2a2NRaaTJvZ2pHkf/919Mn+b4tT7cxceztYFUVyV7M7Ue6/lcw
         H9ZmqAE073s4ZBwNdkFbnpyvjMo1nl9DayGnAdvaKF4AEKCT7nj9ikJPJGVzjvk6PXwR
         vpiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792454431; x=1793059231;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kOEW7S9rMOKRcbBBo1xEhhJSd5nf3JnZXymk/xgXKU4=;
        b=07hs6ggvirYgsembmeK4EjvFh1dqX5JW/s7hpG7h7lpXyYqUebuozUrWYm/g4dPtDk
         I7a1xaZ89e9qMIxhKiUROKUF5YgHxniLLn/EjJLCS1zzSQbmdC7OSTyyGWXTf+oIyzIh
         qcVBG0rfxoY6MukmGg6OTH4plBu7SwtXr5ZUs3y3HR6foE5ZBhhfVXVuUUNnC7N8Ojti
         OfKsje6n43ygaqdcEvjvRT+smEaAWHW9knSXi5tfjEjynE0/k6btFFAleN4q+8dItwnv
         zZPnshy95lQBfKtJ4MMnL4wcbfpWE5VJLA3p+k9LARmP9E+Eathq39vyLKqelEh6D5rq
         ie8w==
X-Forwarded-Encrypted: i=1; AKwUvByplBHNNpuqdkh0rij4jFqb5enelVH41zAS6KkAnvbM14P4TLTJWiwvXHrWk2AQbmU5Q4CXAE+YLj0=@vger.kernel.org
X-Gm-Message-State: AFq9FYJwia4/75YHM/VGtLSsHrtZ4ruL/cAk8E42XplJPCHzIgLeHkhi
	xnY0xaeNLCj70QC43tYrB/Yrp+TMOS1h2H/f+uqGN8Shae9YMN2vjPd0eENztMFF
X-Gm-Gg: AYBFou1CK5nZrQCpIdMyvkt8dIFlckOtmJsB/+8AHQJ7udMUBbKDII1/SMccdLKFlB9
	0OdlqH5+0azkogwpHjezL+o7iafLwbUPcyW0t9PY2brFVNSepnlFZeoQA61R8ElsKYwr1pRkR8k
	9407c/X9nphWSP++qSxL0h0Tc06gWKjSJn2u5gWN1lNqs2hozKhWJrhX5JTZ0e/E+NB5/ZDtDFR
	NX1VfWB5bjnJSRPDeLe4S9vOEI+zmI/eOVOGAkgOjaqrA6gJg+lkjL+HKkEsMZMdz5dcjdBCVmZ
	1UlPMqFCsl8sLay2RY0bkESlfs1CigkbEAnrWufuHsdXsuYU7Yfe/iKzWx6kXs/oG0dnb1SFFxG
	kFEzulmvggTwtsUQSI7YUP96yqFf7xY9l3D2mzEk8xZ20oiOy9mUcqNTE7e/taRtdAkFsZvZM58
	pJneNnGrUNt6nuYQeZ/w8igUomaoir/em4eAbtuDl8FfMzbGn9cUk1L5dMz6zdzrNLmldLFGmZf
	nEaR3ufrRMVxF1cF3cb3FY=
X-Received: by 2002:a05:7301:6497:b0:35d:8c39:b2fd with SMTP id 5a478bee46e88-3619f1fe992mr13331411eec.1.1792454431316;
        Mon, 19 Oct 2026 17:00:31 -0700 (PDT)
Received: from stephan-Inspiron-15-3520.. ([2804:5d20:6009:6701:dfce:4d9d:7f44:24e1])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-360826875b3sm37371921eec.21.2026.10.19.17.00.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 17:00:30 -0700 (PDT)
From: Stephan Costa Barros <stephanbrrs8@gmail.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Mike Looijmans <mike.looijmans@topic.nl>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: adc: ti-ads1299: add driver for TI ADS1299
Date: Mon, 19 Oct 2026 20:59:56 -0300
Message-ID: <20261020000017.14331-1-stephanbrrs8@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <atXAQXmGEeGdJMZQ@monoceros>
References: <20261019001247.483005-1-stephanbrrs8@gmail.com> <20261019001247.483005-3-stephanbrrs8@gmail.com> <atXAQXmGEeGdJMZQ@monoceros>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, Oct 19, 2026 at 09:03:24AM +0200, Uwe Kleine-König wrote:
> <linux/spi/spi.h> provides both of_device_id and spi_device_id. So there
> is no need to also include <linux/mod_devicetable.h>. The latter pulls
> in a lot of useless dependencies, so there is actually some harm in
> using it.

Thanks, I'll drop it in v2.

Stephan
