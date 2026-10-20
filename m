Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792454440;
	b=d2uWeiIWIfpNkJwRFqTOe3fE+yweW+X2EuNIAPuj/N8xvmd4CF8vEoB3HVwaVY1dWJWz
	 T4RLFDtIQ4ly0j89OhqqgfcqwuplHilSQBsCtdQ2UbshPx4Oc2dQPBG0e4EIrsb2wEXJf
	 KcVycnRLt7PbZchtCpKpewyWEu2dkSwrLNXkWRGDOYG/tkllNoRa5rdh+CGXYlhvCo64A
	 h1k0Xla8MkOwHHAAORCNXwjTksZIlMRm2RsTqe/uDIzQxFCrb5mqvzstByRWnP4Yu2upG
	 qyJloc3Uf8+KDbzeN3408NaV7LuPbLa42LC7IVjRnMeoqFuMMXbfHm9i4HQgwC5/Z+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792454440;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=7fUTkugE/ubN8HZ5/yUbmpM3BNuYlbvQ/qB5I5NZYCU=;
	b=wjPD/hnsHi0w4PxHIsXurzFkPT0tQsbzoHF8o1s8yBsffPC2dbFK5xwyOTid6SHOmvAR
	 lo4ZPlMiZEuK0rGFzMSJrl98ZvWYwvXGNGtZx4uEn4ZrBd75MP5IXBYbzXiD+fxGaOnC8
	 xKFtoKBlA1jC10h4XWxOV9fysJFQ6vOZ/NLIMJYPAszu0ztNICCKjFNsfw/SzDElg9kan
	 u0Le01XtDB8Yu8IHL4RE0MHuw6xbx5GVY5Fzc7eHDaTOV5ohGYJHqulMRknKKeFTj8wwk
	 o/0HIfmPWuPwrogoiClbzo0AaknrO4nUVuQOlNIw6VieGYzoeb5CsPdgDl/vTaQFNMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=m6oKOtnP;
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4E1606A31D
	for <linux-iio@vger.kernel.org>; Tue, 20 Oct 2026 00:00:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9D4E1606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=m6oKOtnP
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-3514b90bb89so6982343eec.1
        for <linux-iio@vger.kernel.org>; Mon, 19 Oct 2026 17:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792454439; x=1793059239; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7fUTkugE/ubN8HZ5/yUbmpM3BNuYlbvQ/qB5I5NZYCU=;
        b=m6oKOtnPo/2I5um0OGZ5G646AR42YdurL++ZVPDQDojft320mn3aJyVyh3u5bBBnmU
         kItDysR60NNVcj8YojuiQJwIr+506+OxCKCD8z9IW/9/C4IzKMyzES8tyspw7slaGup9
         VnDglr8JS7MzWc6t0gslon1wFa9+cThJO+RH/DZxtCrfMpbGy7MoecQUh5tQ1CQgWRgM
         C1ko12o1URbMQedFODTVXx0KrdztUN1b+ZGRtzziomp8FtWj9OXJpxaNDSEyOgf6Ogvo
         jvOVwEtP/0HITVOBBfjJAgQij5tnGpMpqdl1+0tjBRGFiM1uXG/e/CfQD4oXE2UAW0Zu
         vKUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792454439; x=1793059239;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7fUTkugE/ubN8HZ5/yUbmpM3BNuYlbvQ/qB5I5NZYCU=;
        b=rN/Vh+5FrWma2yIZyG94lv3ajAVjCg/bFnN8ZfUICm634r8Lk9LdRlaz+ZpXViUGsd
         PpAfSFpz1y/0z8QI4dDOJ+huC6rHshS0ceVlxtMGdzjSI4bS1+hNmeFURgOzdgJU/EbQ
         t2tCkNUTsfbUKH1YRXc77EnGFjLDWPRZBeybKwTPjV3mJIvsUfeJ2vTntVYYE8Jl2FlJ
         caABS/8JPBC5qEcfrKSnAgmgT6lzYSLBme8NlScrR8W7QAHiIIxOAHTfixQQSQDbAb82
         dTuAmbj7BETjAB2TPEV+OYMrW4UwytmyqbHVd1fY+FSJiFbQhLHd8UjtThn6oraaGRGa
         upxg==
X-Forwarded-Encrypted: i=1; AKwUvBxQHkQmV53tm0QAeFKGtw9xGDZsv+AClPwqKGaaw7Mo1AHQoxfRb7Ba1XPkblcN/HhgbU0Vt8RBBOg=@vger.kernel.org
X-Gm-Message-State: AFq9FYKa0htF3hNx321PywAeLgkdKKGi3J2rxhd44pAv6FbWFKjqu3c+
	ktPIOlB/fzS9+bsQlkkHrKDQ64/C7UoiI3qj+rWEKWS5BU5Q17W9C1cP
X-Gm-Gg: AYBFou2ygxqCoGxThGKyE2Zn8qIn60NXT+zD9hEtfAyhZKDsvmq/lOv/OkWkbu2cIvV
	2jaxLo5L6lVdhJH5b7aT2TrMaJ0TqbVsdep4yJHAASwJHmZWoK9IzmqATrHKAsdFmZ4o1JB2a4u
	XEqlwdUBfxN06w5Q97I3cul5Mp6s7NIBQsaAUfHcLpD7vO8MJZDegIbVIGnw1t+G9W0q/Ndi9Z+
	yVrhX1M8KCzDwSa+Ff5/TPaPSfcrxRdeSaBop2P136v0lH8GfTaYUKBxuAp14+BSIvB/gmsFA0j
	g4Wmyw7r+aBiRgEaAMkCrtbXWftvR8wk9wIQ3hcm/KOCTd6nJgfYyxOkphWXisrrbPRvctHDTet
	B7x7sqbPEbvLzMiq/oKlN/jfc7L3iILPSyjuF41dXjpsIsmbQ55pJxA25jqkXUb9cuVmdATTXDA
	KmtQ1DPYtrdYsP7d8CWTtdXB9tLmnbPe6XkbzobVz9Pz511B6eM1tJkbCOGe3hc9JDvAzdM5dUA
	CK4sqJk151iiyBCriEBwiYrAtGMdHPHZw==
X-Received: by 2002:a05:7301:f0f:b0:35c:6268:8127 with SMTP id 5a478bee46e88-361a146ee08mr11221357eec.13.1792454438391;
        Mon, 19 Oct 2026 17:00:38 -0700 (PDT)
Received: from stephan-Inspiron-15-3520.. ([2804:5d20:6009:6701:dfce:4d9d:7f44:24e1])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3607ee0d391sm36155038eec.4.2026.10.19.17.00.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 17:00:37 -0700 (PDT)
From: Stephan Costa Barros <stephanbrrs8@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
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
	linux-kernel@vger.kernel.org,
	Md Shofiqul Islam <shofiqtest@gmail.com>
Subject: Re: [PATCH 0/2] iio: adc: add TI ADS1299
Date: Mon, 19 Oct 2026 21:00:31 -0300
Message-ID: <20261020000031.14522-1-stephanbrrs8@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <atXuGv3esexdRJ4e@ashevche-desk.local>
References: <20261019001247.483005-1-stephanbrrs8@gmail.com> <atXuGv3esexdRJ4e@ashevche-desk.local>
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

On Mon, Oct 19, 2026 at 01:16:58PM +0300, Andy Shevchenko wrote:
> On Sun, Oct 18, 2026 at 09:12:45PM -0300, Stephan Costa Barros wrote:

[...]

> > A question on structure. The driver started from ti-ads1298.c, and in
> > this subset the two are close.

[...]

> Okay, I think you can try to rework this as a series on top of the existing
> code. I can't easily see if the above difference warrants a brand new driver.

Thanks, Andy. I'll do that for v2: first prepare ti-ads1298 for more
than one family (chip info for the gain table, the data rates and the
reference), then add the ADS1299 to it, with its compatibles in
ti,ads1298.yaml instead of a new binding.

Some background: this comes from my undergraduate thesis. The project
first planned a driver written from scratch; I then found ti-ads1298 and
built on it instead. Beyond what ti-ads1298 does today, the out-of-tree
driver that came out of it sets the gain of each channel, timestamps
each buffered sample, reports lead-off as IIO_EV_TYPE_FAULT /
IIO_EV_DIR_FAULT_OPENWIRE events, routes the internal test signal and
shorted inputs, reads the supply monitors and the temperature sensor,
switches SRB1 and SRB2, and runs a self test at probe; all of that is
tested on an ADS1299. The bias drive, GPIO1-4 as a gpiochip, the CLK
output, PWDN and suspend are written but not tested yet.

For mainline I cut this down to the generic ABI. The rest can follow as
separate series on top of ti-ads1298, where most of it applies to the
ADS1298 as well; only SRB1 and SRB2 are ADS1299-specific.

The automated review of this version also pointed at issues that the
new driver inherited from ti-ads1298 too.

I had missed Md Shofiqul Islam's series when I sent this one, and found
it only now: "[PATCH v2 0/2] iio: adc: ti-ads1298: add ADS1298/ADS1299
driver", sent on 6 July 2026 and reviewed by Jonathan on 11 July. Md,
are you still working on it? If not, I would like to take it on,
following Jonathan's review there (per-chip match data, the reference
voltage and the ID register), and I can test it on hardware: an ADS1299
with DRDY as an interrupt.

Jonathan, if you would rather keep a separate driver, please let me
know before I start.

Stephan
