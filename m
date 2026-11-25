Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795593046;
	b=L0xqD5ew6NZzFBAuavim0OkimKh7wW2BO++5RVfzWoOVQfqBiLTTgk5WkOXIsrc3drZt
	 p1078iSjvLV7YLkSsOTxeIyglj/aPu7GmOOCMBTFoLivIkuqzS4smDTLsAJjxUlIDc3ro
	 pTbf3qq7yQoDYDsXb6zhqP8i1+HfRBLy1RZjrMeZerSsY0TBGpvyQsVAAr7xE2eqS8QO2
	 fancuTruiElKfyMd9Jp2WbvFksY4I7ft3IVKk9evXYhO26NXB8yiw1+a6ZiVBNzZdah0u
	 S6ZaIXTYxBJ/YJ+ZgVqBJUaHwT7xCDGIfqNM3SnE3X6WPcNEfK+Ta454D6GGsSg5gQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795593046;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=RoGfdVKoLAwGf8hBsFOIgO1GBBzJky9wJZFQWuH3Kg0=;
	b=0QJtNd1iZOaCSVLWqwOyFoRjoLTCwaCRSWh9eus60Qy42Ka7XJhR182su97qPNHKm9pJ
	 vW27zGymmCRPmjH+J/CBIB9odVrejttJkbXvwTNBkjJA26LbFE3Vc6hwmBg6Q09dHj7xu
	 KVkWtZa5x+lsZKqKRNt66lNN/ra01KAxMzOZ38U1osAvZV+4fZ2WQMuLNm7bNZ0S71zDT
	 jbXPXUpUgw1fKnj1Nf+PMGUfKbyTdC+0JhDCP8rexM8QGx0G+QR8owlEq5fDVT2hg2Ei1
	 0qx1GqECY+CedM6WfhwUt8lWxbogPnUWC00ZFoOpxYQlZuOSBbgur/oNUoLYOmEjGkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FQffE2mQ;
	arc=none smtp.remote-ip=209.85.208.170
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4FD5606A321
	for <linux-iio@vger.kernel.org>; Wed, 25 Nov 2026 07:50:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A4FD5606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FQffE2mQ
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-3ae85e3685cso35903601fa.2
        for <linux-iio@vger.kernel.org>; Tue, 24 Nov 2026 23:50:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795593044; x=1796197844; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RoGfdVKoLAwGf8hBsFOIgO1GBBzJky9wJZFQWuH3Kg0=;
        b=FQffE2mQ2P25rO3ut5p+5WVLyoXys0IdcPrk3UxOYiiwifz5T+Y0Ed8RzkviTr19cs
         t1l92nGZciGC5CFiqO9ookwfTlhxAGdhW/b7xlR31axF9Ebb12xJfB/S+HSZrUM5CJa7
         rXc/3p0/nrMXBjwYJ614/y3VA673f280JsqLw/cKvP4qLiKvtY5mg+HTj9MrTkZsMGQ2
         W55BvFKiwOP3Hti9J7LwAdd9CVuocDhQNbHX8u333MixMMLPq8YR1wT+lnYiiR9NgOmF
         W0g6xnNgAsVw1YGU7urpo32bQDZZRJ0HmFkBbMCM7wsgvHTtdoB97kBxhpJuxRY1y2+d
         6UxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795593044; x=1796197844;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RoGfdVKoLAwGf8hBsFOIgO1GBBzJky9wJZFQWuH3Kg0=;
        b=aW/q/zPh+nFHAKuT4ktRNmxJPqSJrs+4OB+M4tWZenIPf66x37V/0TQodvejf+Rh5k
         W1lrefUmMoIDLw52UHQDppx5Pg5gDrLVvokh10zqOFfH20iWNSeMXb7nQTdFZBRV9jXP
         TFcUD5mbE9YijJ5lQdOBhBTKxU20jXwKo2Bd6p3/YEUOWaROAI/OvyzBNdBPg2EllCh8
         rTlzJULK+alQW4U3KlFYESKhqSLlxTsrEYFNB9z8iG1zXm9QgXWWG65wiw+bkpklye0E
         /slOIxODkVEBe/wfFybdypJzUZaO2wRAgxtY2QpRPnKA6KWRWEjEZBbHhezY2n6BnqcK
         65ow==
X-Forwarded-Encrypted: i=1; AL+hErGgrprvYGLyKMuTohDaEwlAHOG+CyOMWjPzNt2oFrNlFGzwfLkUrmcjjFC7mZrj6tIjP1MYBwvFrA0=@vger.kernel.org
X-Gm-Message-State: APuU4Z8Xcdyg7Klrlj7P1Bw9a0E4tiXN1XIiUXNaQetgFqIkDctI+P3P
	31y9Cqt275b0nks8/B7HCB9JbpHQN07YnabdMTiW8j68JUKE5JuV6BZO
X-Gm-Gg: AZFdTZfhEckcWYpkaO7rt8Bo43fzXnWP7/bRnll2mYAK73aWWZ52W53QDYi2arjsHV8
	pKfBzCmEvfrYe3zR7gRaeQMk5SBrcL+ojgif/wd6AQseIDCwaTky2jDMX58g3Vmu3S5OcWa/dyO
	5RjXyqoUi2XmsF6pViy+ko/9Nx6i7HPfrRHQXG9hp7s9dX8h4jYwUHd5kRwAdwEiZ5Tg5NMkZTg
	u5XkNON73+/gED9Fj5AYvxvHANkLC6N9enpiTRVkd21dTR13eCrFoRd/krq8SXhLsV5sdr1QHSd
	5yvzT6extG5WwVi4+mi1f0HCcXiDJtvgdTVBXATGXP+ZwB+Rp660H/AZX3rKqd2dMAyFYfXRWDg
	RCj9woVHHLq7HNMwedj9P8Mf4sPltAmPCp46/S88Cj7XYupE/aAq4XOFHJ0oTVhyvnPeXN/Iw7Z
	AyHhfpixpiHhTS6MchlXcXYoL9EwjCQpa3tylnyAcS8kodJnApWcOjTompWW0ZCxowA8/KqHpMa
	OqWRpOfQb4UT0agaAQePyCysxG1MZRdZ7ZY6SJb1f9EFhPQF3XTs9KOeJfeLcjGb7W2NqTq4qcD
	HB6gT+YuzyCwmkqU0lvEnWvyp2tb3kpqROmfPOThtakUJSDEgeS5KB1O0GTHo6SPSocoRgbZvBu
	h+LMvCJcIs+1oAbF4sc8gjkGCDeV70gIZ+ucZNdcJntC1AKt8+YlHwlv+gGc=
X-Received: by 2002:a05:6512:1244:b0:5bf:d1e4:a034 with SMTP id 2adb3069b0e04-5c1bc7d025dmr5262307e87.21.1795593043584;
        Tue, 24 Nov 2026 23:50:43 -0800 (PST)
Received: from yantra.. (nekmmqvppk9cj8danf8-1.v6.elisa-laajakaista.fi. [2001:99a:d7d:c300:f131:5b16:1fac:1214])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3ae8044df03sm41686411fa.1.2026.11.24.23.50.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 23:50:43 -0800 (PST)
From: Rupesh Majhi <zoone.rupert@gmail.com>
To: andriy.shevchenko@intel.com
Cc: Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Eddie James <eajames@linux.ibm.com>,
	Jonathan Cameron <jic23@kernel.org>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] iio: pressure: dps310: sort register field defines low to high
Date: Wed, 25 Nov 2026 09:50:36 +0200
Message-ID: <20261125075036.37378-1-zoone.rupert@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <awVHFUVYPE6W4izB@ashevche-desk.local>
References: <20261123220649.36887-1-zoone.rupert@gmail.com> <20261123220649.36887-2-zoone.rupert@gmail.com> <awVHFUVYPE6W4izB@ashevche-desk.local>
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

On Tue, Nov 24, 2026 at 10:13:09AM +0200, Andy Shevchenko wrote:
> On Tue, Nov 24, 2026 at 12:06:43AM +0200, Rupesh Majhi wrote:
> > Some field defines run from the high bit down, others from the low bit
> > up. Sort them all low to high.
>
> Have you checked which change is less invasive? Can you do it locally and
> provide diffstat

High to low is less:

 drivers/iio/pressure/dps310.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

Went low to high as David asked for that, but datasheet lists
the bits from 7 down, so I will sort high to low in v2.

thanks,
rupesh
