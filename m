Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794657492;
	b=FS6QDwiMWlNtv0z/N5/CwkmR0mTrSM6Eg5XKHzasve+8T7Nel335tBj9uoySkak353d4
	 2jjgEGGkG8BUVOH2Bwb/o6INYvXIeBt/XShfEo9xDLsGYG4FAhnyZMKvC21kIFK3dJOKd
	 k4kPvj9IfTmvp7oDCdgRJ0TpWc0pBKlEBn/q/m4+9WFAujU549GWLZNQs4tZwvwnXnUM2
	 VmIn1/1wuPr7/dQ+VjfVYFArfWtSkC9mGtEBJqI0iaO4nVzaqTbSHfdtmrO8wRtaqtr6p
	 v5p33te0hP6gIdhPtvPSa8J/OSADIY+GnhCKnU+zVzKOf4A4L6CZKil2+hIYuZLtTEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794657492;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=biJ9EAFLEA1rR//T+aJGjeK6yGVa5a+nAsg2mX8Jh6g=;
	b=DEtZ1nAG5bR5CePSuAyMII2+fVJ2CIworQuyKhc5KjTiS9WaoZOGHZANMHEUndZSVSRN
	 fsazlUacoqCdUgFHDsxMr7sOp0M9KP9czzi+nAJIStS9vYrRLddSmgxW9WosIkmFKwGwL
	 T8kGZwdr25ywJJVEqpUxLUKAf2O7y0/3QWO2ump6+BUzOi5ycF5g8uJdalfqgOChFfVEu
	 rGbeoXVtnnZoMtSZdbqzRS3fKQfUEnP0nqetrBD3qq4zlz6yP9s/iVWL2dP97GKecGGKV
	 4r7mu6VzrxyN7wPh/aMNJwnVToMrTXFEjftxXrvucD33iLF1dJnHa1aLBPHeXAcE8Yw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jKHVAcOC;
	arc=none smtp.remote-ip=209.85.167.44
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1813606A32D
	for <linux-iio@vger.kernel.org>; Sat, 14 Nov 2026 11:58:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A1813606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jKHVAcOC
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5be3d5927ceso2738062e87.3
        for <linux-iio@vger.kernel.org>; Sat, 14 Nov 2026 03:58:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794657490; x=1795262290; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=biJ9EAFLEA1rR//T+aJGjeK6yGVa5a+nAsg2mX8Jh6g=;
        b=jKHVAcOCtl0g3TbME2TVA8rBXQlEpflGEVNVnIu8kkRI5VOx8kaxiHhfwPDIO6LDSN
         8PliQDEjRwUhhPY9pLFLX1VJCV+dZra1+K56u+DxkRa+PG4pvRAIcQMeR4mL7K2TF8/r
         d2dHkwnRQEfHTw2mD/w8VsBULvHZ0MP1M/2IzPLfj3Z5SyIlVvLW4xz6ilftQu8yVdBZ
         JLc6cTJsOHmku+brJT0yxgp2PJJ4bKk6NT2MCQgZmYBIf6XbxGOXIDERe6V8nkIhKOO9
         VgmyAZd4C1NTszBkb6wphO5xC/8wPMS8WjD3NKLHj8nTim2zvxbOnjJKBjei2qxK8wHs
         leew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794657490; x=1795262290;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=biJ9EAFLEA1rR//T+aJGjeK6yGVa5a+nAsg2mX8Jh6g=;
        b=TJ8fYt2LHMW47UOTX7R8KRAALNU9sarZcjnzxHAbY8ZkmGWNCjsh6jKenU9wwLZMdE
         bEckklfgyzfHxJdQ5+nhBUGUEwyhsnaCnkwJyJRwB7DbK9Cvjm9wAoPJfEpHe1b8t1Mg
         C1RS8Gf+Ovyb6EEBb21E6WsQBcEoOtixN7gIqwHwwIvGnrE241nEQNUmauCMyPyAmCLg
         pa0uKOkXHu8hFsjQxHNL9GGDXcOxIL+vCGPf+3HOGLoTUN5Av1Ch+UbxjzVbHRknsZwJ
         CdzcYkX+KU8gPY7HzP4A5eM6LTGWZK10pcuKV+T7yNfq51Hq2S9yjQfWvOYIC4E24AH6
         WIKA==
X-Forwarded-Encrypted: i=1; AL+hErGI+5ug3cWndggkUozQVzALIGumGE9twSqB4p6nC1a1EkMW6HAKaqMaIOS9dIEyFL/T2uB/wW6niXQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z8BcUY5VdeXoujDvJErR6OnhTGdajyr5M5vJBtFtHQZ51uhXIVY
	Hr2P6Ep46ddv1ttV1skMCW2BdMIzm7iVfmMrQgXIxREu0VaGIdn3aXoLbzuKT/my
X-Gm-Gg: AYBFou2m5HP+5R+Y7MCfVXQc+Z/nGwwZniLd4HTxV26RpDxnmj6T4kw2B7S54d99Twz
	djG/RrHJZ5cDomhWk/tjPFIK3xaqQiaQCeR1YbVn5vAVhEXW1qLQ+tJJrjri9YFGoz1drqhdOCG
	A76zpWqDUlXRZGRn2tVLboKb7LP3FwOtCIcfgHjgn5K4ReCJoI6iLIvqc930A8wruflJlckY5jG
	jJzOnQWGo5MPWApTo3QJTjsxa4regcrn7f2m+x2DxsjfvwD5QKVekcd2/FijmeRegOpvyDmCAEM
	KAN87RxwihQzpmRTOS24PmL946ioUm34HlXHIqr/eSMBXKJLjTgXjFRTtB+IcFilXO6g9OqY0eX
	q4uGlLLmq+/n4g7RMScEtijXvLlWBvcez2N0KSVe53+/s2/IbMqXJKcuKAYNDEi/thgfGcEc8N9
	HKxa5l4ORYeaSqezkRxWt17APvlbK6+QL4gAbo8QVZbHUhENVfn1+mAG4pwSp9/r2/0URKn4QWy
	UoMx1N7YuzxafWD1uXGvk06YTgWOPSyogG2PXs1f2FzeBveus7Y0peb6NKkonCITBL+G3Ra+oWA
	vcu9V05rr0tGznsQT18gz2hx+QS8kXnwpW3OmGIxGy6QSE3mmVqxb8FnQWKbbQX9ij5f4HdDae6
	5OZ55PTll9Xjc6VxafzgYxIcGQ/lUa1v+benfphs=
X-Received: by 2002:a05:6512:1048:b0:5c1:5958:a7e4 with SMTP id 2adb3069b0e04-5c17077eaaemr1886702e87.15.1794657489552;
        Sat, 14 Nov 2026 03:58:09 -0800 (PST)
Received: from yantra.. (nekmmqusxj170dz200l-1.v6.elisa-laajakaista.fi. [2001:99a:d7d:c300:b551:8edb:536d:8395])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5c17133c9d3sm1606436e87.38.2026.11.14.03.58.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 03:58:09 -0800 (PST)
From: Rupesh Majhi <zoone.rupert@gmail.com>
To: sashiko-reviews@lists.linux.dev
Cc: Andy Shevchenko <andy@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Eddie James <eajames@linux.ibm.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Rob Herring <robh@kernel.org>,
	devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Paulius Zaleckas <paulius.zaleckas@gmail.com>
Subject: Re: [PATCH v2 2/2] iio: pressure: dps310: add a data-ready trigger
Date: Sat, 14 Nov 2026 13:58:01 +0200
Message-ID: <20261114115801.57701-1-zoone.rupert@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <sashiko-outbox-214316@kernel.org>
References: <20261114083828.18059-1-zoone.rupert@gmail.com> <20261114083828.18059-3-zoone.rupert@gmail.com> <sashiko-outbox-214316@kernel.org>
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

On Sat, 14 Nov 2026 08:59:52 +0000
sashiko-bot@kernel.org wrote:

> Does triggering on DPS310_INT_PRS block in dps310_fill_channels() waiting
> for DPS310_TMP_RDY whenever the pressure rate exceeds the temperature rate?

Yes, without the trigger handler fix the cover letter points to:

https://lore.kernel.org/linux-iio/20261113230241.82046-1-zoone.rupert@gmail.com/

It is against the fixes branch, so this base does not have it. With it
applied the handler does not wait: 32 scans in 4 s with pressure at
8 Hz and temperature at 1 Hz, 5 without.

Rupesh
