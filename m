Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B7B4AAC5A
	for <linux-iio@vger.kernel.org>; Wed, 16 Sep 2026 15:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.225.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789573788; cv=pass; b=ZlY9ztzJxYy3wfagR+fsyKo7kQU7nU1aafNzVoh1LT34GQ8tCmG6QLqgXJ4z41KKKbNJ21G9S84+DE6/pJUO1yxoOjLkZYjpupUYq9HwCh4WAhxzn/SSBhdnQRwdNrliumhts2Onbi01luXhrGQ5AAScqbgaInpnP0fWKl57Ki0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789573788; c=relaxed/simple;
	bh=fwqarN10NUClOZtA7yaqargVTx8zWL1mtttjSy8NhoI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eQQcVXxbpH6K3Nf69lhwY2KJyF/4UoI7BAc41asnWatNwXlVsFPT9EALhh178ULyBN8acMnToSu5eWGCykWk76U3h3jne32g6/1GXYzjEEdoxY9x8HL7HxOkwIoz56J+b72m8Ix1gbr1hHeq2P8qeY9p8E8DGHkseYejkYhCrR4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XmittU9B; arc=pass smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XmittU9B"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-4843172bff4so571282f8f.0
        for <linux-iio@vger.kernel.org>; Wed, 16 Sep 2026 08:49:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789573784; cv=none;
        d=google.com; s=arc-20260327;
        b=gvOFxTdSl7T9ak1VcY4hiJZYXRbn/Fue1/vKQBe6l5gAfw7joKaa2LrBSREB8iRU4f
         OHauXpRHyK+Wzx8OtQxyouSHIvVcH4kSarpqVCzhwhIl3SzwGgcSKqD7BMQAFb/nbeBG
         0Hl0cejlED3PP05GgAx6dr1l+wOPZY16XFknQ5Nmv9G6fZwNK123EA7I8T/WQuUIh3mY
         qaPGWkpNqgR+PYRnCxUw/j4SC+MQG0uQM604GW2bz69GItWp+k5KCwVC8iyVPprT2tUD
         Ha4Zk6CWxAzC3stQ0Vfu7gBSR5KDV1TrpJMcNsDNHGFVPk+EM9WyQOjPrdoC164FHflZ
         u35A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=fwqarN10NUClOZtA7yaqargVTx8zWL1mtttjSy8NhoI=;
        fh=aTA5O13+SBlFyhAzRrhn/Waz1ctyW9m5givOzhPDr88=;
        b=oKdyF0FYzRmUg/NCAY3IB9Um/CSddjosY9hOfB6rPAr9e1OModiM8kLSlM4qKIk7or
         SMpmU3YkpSGOjE3Mhol8wN4MI06IkDLbfQnboshaTULgdYlQvhlL9h9kz1nbHnrxRiNs
         3YOGD5/2O6msPjzXsUb9jcvSKSWA6QReBte7Rekdh2AIUeriRr3jUs9SmZnWdiVm2Ko1
         dKaa4zNcH82+OZ60Ux7ZzqdYFJRLSgM+ItyAbFW8MOmIhCgv2Rwlcnl+1y6Kjq8AtmJW
         7ILpl2+EB8lz7ZNmIz/go7xUD3xoETJF+o8cYEGsCyvxx3IcUwvVbgDIDo0lBQG98uc5
         hdmA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789573784; x=1790178584; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fwqarN10NUClOZtA7yaqargVTx8zWL1mtttjSy8NhoI=;
        b=XmittU9BA6gPn54I8BeGRku+QMkRWRO35mHcQwvQHHMbAzXuWAzJS9AusPJOpy7+M8
         ULEcOtxpwZBv2xeB/Ii8IJ1xX6939S4xM9R9aXCQZC+5bpjR7Gl5ZZw0skJvLNqtZpTj
         T+P5HejGIuH89N5KIc2qyKy1DGge/h6RyjbpZua97KQpTlkhs9PRqP7In6qRdF/MSiFK
         ZFVLICCDbLYfqcPeJoerrSUlcXEQ0YvXJb2hc0mej1mvnIWJceawO7/dQsLSrvaaoTeM
         gvXFqAHkLlsToJZQNJZ4imPeoSS6/l73snygS4o9HZibBjrCy0gUU6h6KmICWcVFPQ92
         q75Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789573784; x=1790178584;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=fwqarN10NUClOZtA7yaqargVTx8zWL1mtttjSy8NhoI=;
        b=Eq8LQ86sEMbAQfrV/mEOymBQkIa/ibYyQ/WWWdKjWELdHs7PvCbPQZLoSvwGFo6TZj
         Sg0c/PpJZOoRnBUxVC3EUjsxY34ydJ8UJNTabW4vUBJDXPRQL2mgHcLlRHTrMf9rPver
         h8HabgzHY3gG7E9sZbrsGOC7PTMXX8y0OPn8QRcRSWKKLprBQWFWJZLSlZkJhxywkWia
         3yEwEBUg566111WR0ED9EmIkMD9sTR/gjXE5KRKkEVS2q/cy02eko1h6pkI3FKWhf6bl
         nHU4mWj2lAXgUdar2XniJWR8z+0ZaB01XSnW5CXcR28YOou71zdTPDvSEVdZKCE0dVG4
         /pCQ==
X-Forwarded-Encrypted: i=1; AKwUvBzA6s56EHMgqgtF82EVwCoyZdCao0OjSWVyW0sjbayLhxMrfym3ltONryyJsI7sKG8STU+neiGju+M=@vger.kernel.org
X-Gm-Message-State: AFuF++ngVQBCMaFUPOxT4E21EzTpTv9UW1EyRe4Rv+AiWYStBzOi7ZuN
	tsKsK0mHSk1e9hhMqbIxbimeaSjQDDPeGT/CFIL0H7mViyak6xtVyZhoJfTJtOq7LICKeKbJZGx
	Yyb/Xg5yhQLRxiG5tgho1Nea2HxJHyKU=
X-Gm-Gg: AYBFou3zzCZNPnx//ORJym/MxRO3l3LxETXBUWk+DLnFMc1/xZOPv+RwxEF8S4gnv61
	fR5NDddG6vaUMq1144gvu9g+pkHitiMqNSTcgQu4yZH8t0ciHSwQQCokiFCd5dR+2g1n1BT05AO
	ctHtrx5Q/vI12VzYEJNEuUx0JSfR1QG12HyQpty0exDMczEq060ah3EYSYqHkF0nEKclHGLBVUx
	38xFW0ZB1etNjsMKwweWyed2mMRfi4RTC4HC98yQBMukC5s6BzZxdlMVf6S9cmeQKDO/rI4d3Pu
	uCJ4P92VThq5rGAIlBd2QtS/mpXXzIw5OvdjoXpCNjCNHjdBa50GdC+U3fcKy1spkFmh6vAcDbp
	86X/NkHTlNyCx7A/pOhOmpuaTOC87rcIPsk2N2Nr7n6o1MZ5nUODL17lKKJFSmjK5L8ob+2IkIv
	mvB0wgVjLkmvWeiz4dxH0Dx9Lxw4AuisEBsXEX5N0nI38m/qX1YRhuqybgFgrIsYFtoKheFcBKL
	h90G5PZ+TqsHhvR+TvwVLOuIA==
X-Received: by 2002:a05:6000:2506:b0:486:f18b:3cf8 with SMTP id
 ffacd0b85a97d-4870cf1abd1mr4010532f8f.22.1789573784237; Wed, 16 Sep 2026
 08:49:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260916-mcp47feb02_refactor-v6-0-285464651f89@microchip.com> <20260916-mcp47feb02_refactor-v6-7-285464651f89@microchip.com>
In-Reply-To: <20260916-mcp47feb02_refactor-v6-7-285464651f89@microchip.com>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Wed, 16 Sep 2026 17:49:33 +0200
X-Gm-Features: AcwNN1X2bljHln1P6cvv3RlFUVReGuhE23EsCuuOlpyh9vJw40krWIbRB4NBzJE
Message-ID: <CALoEA-wmUAtHjjWB4xOgZxPZyoHAhJ_nywoLjNTkkfCdkMrB7g@mail.gmail.com>
Subject: Re: [PATCH v6 07/11] iio: dac: mcp47feb02: correct typo from a comment
To: Ariana Lazar <ariana.lazar@microchip.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 16 Sept 2026 at 16:19, Ariana Lazar <ariana.lazar@microchip.com> wrote:
>
> Typo corrected to 'Register' in the comment regarding defined masks for the
> gain register.
>
> Reported-by: Joshua Crofts <joshua.crofts1@gmail.com>
> Link: https://lore.kernel.org/all/20260723231859.03f92ce6@systembl0wer/
> Signed-off-by: Ariana Lazar <ariana.lazar@microchip.com>

I agree with what Andy said on the cover letter, Suggested-by is better in these
cases.

--
Kind regards,
Joshua Crofts
