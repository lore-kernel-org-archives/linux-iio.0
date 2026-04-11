Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC43266581
	for <linux-iio@vger.kernel.org>; Sat, 11 Apr 2026 13:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775914970; cv=none; b=Yy69T8MHNpeau4RECu5k1+jKh1kt7wobeVEEp5kWc6CSPEndp/pjVxB7YRQNICiWnhsKqTd0zCSx+cEo18NdZojTRCFS9kMTWRjUKIrHhf22NlwzQ3YWWXt6a+QDctVihLrSBQO6xPI0fub0SrotiLXj99XoZn1S9ZOAnQl+xfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775914970; c=relaxed/simple;
	bh=R/TqCiWCIzn4/vtN8yh2bzIUxADossHVkhRjXL16E3c=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YGRB0EPu911gtqYzo7QosoG8GV+Mbn4jgI7QAQBJS+b1Kwc9AVskt1tSmF8ZjpmTB+kuZ9veQbhABnJKk0EpUIwU0FLP67DVdYiibV2nl1ssjVO4hiBjrqQueFhjzFkzM/EXRwLbztLybUVlV9u0FZLh2XBE//PV7QuBPST1dcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yi2Ry4ZU; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yi2Ry4ZU"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-43cfb723793so2006861f8f.2
        for <linux-iio@vger.kernel.org>; Sat, 11 Apr 2026 06:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775914967; x=1776519767; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=R/TqCiWCIzn4/vtN8yh2bzIUxADossHVkhRjXL16E3c=;
        b=Yi2Ry4ZUL9IvpvX0s0DTyOzG71BZoRUvpStTrTlQplWzNNwaUx24T5MfeZ5ezCjaJy
         5ZojxwJoqerH+L0CoSmLfxnua6rplGYuBbHCZq3cKrMH3V9m2AjrrszkQv/tuWONde8k
         p4QfrADNOa/ACRv/klU9UrKpqWqR+htwyOZyWQuQOIqP39PiRZY9j5OUblygUsneCThk
         p1FqBvGAZbTW3ssIxVhH9TuSJu7R7ub0XWrJpwhINm3SUZIWKVKWepOmNyVWEeaz86Hd
         38HWXSLMFD3r8WQlhcocf33udxQaLczvRAs8ELkNrz6VGJ0gYqfeXr3M0mLtBg7a9JML
         uRSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775914967; x=1776519767;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R/TqCiWCIzn4/vtN8yh2bzIUxADossHVkhRjXL16E3c=;
        b=gfMkALE5hgJpTk3HxWPSNG3pKOllzeFPUomaMqIooiTO4WLpvw82IHP4+oVYAVkBqJ
         8rSE1MseQWhuw/ymGjYrMSlJVB9rfov0X5bx7i731RuKx0qHtk6R/twqzT7Z+znyuZFA
         H9o3RhUuXrh+2uhF/7tMaIXftAth28UNQ9LFkhRIb3wY+ktwRhcngRalInpyMFJETwEj
         1eBtHeDGACcSZqnqQ4aNOWaB65jSSznM/Ev2yqQj+VgCCFWH+PuUMeTMA8VTROhNg5pU
         H6EPctslORMmzAVGg6OnslpZgN+rhtr5zZiChd5wQp1xjHts3kD1gPlWeX4H/RSefy3t
         UttA==
X-Forwarded-Encrypted: i=1; AJvYcCX9iA/ZgJjv2/SE1E/eD/XNNxkgpATuPZpV0mfrob+ZiMF8NefnCNntv9CCxqfeUnmC4Iz5wR/VVJI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi1ejX2IuQFz8Mo5oE6kctcWWqVvzGJSNwwmglAFSDRaACTXAT
	K0BcvjNGNd1EVhw+dCUp8OpzLWTw9de6LN8YBnG5LbOH3OmlojoXIcwS
X-Gm-Gg: AeBDieviCCJvUAhPCJSF9cZPjOuAO8IWzyQ8UvP9phFoT+8R8SQQY+sRlo8uRllX+Eg
	DQ1T/qC8Hui9Z2XFVAt2ahs72vwKA/cmdKG4MUTCV4vNzc6D6TLp+XcO4H1hhbGUpg1pvOGwgk1
	xQ1aIiG6Hag3u30XQlzXFE16Qr2FoDlyOYul0v6tiFnQaWMNw41b2PIEv21vH4aPbzW0w1pSgXQ
	KBRwEXNBzlahuMO8d8qMIqV73u+bscyNTJfph2vrUgdaiBk7uYksLb2N9yyPKhlvWjlvPwvsPT8
	tddAw/K/DyaHd7tE5kxBIF6WflBubLbMZUklZul9JoBTYjX5bbwcLFveOAiymwEIV4yFcuUEtSQ
	oOlPT/P7h8RMT0r/ZyGSIdkbHVjiaKvbPQ1DTuIVwHCFTEAz6EJJo88SC26qH34zZcbzmbYGxuA
	M5hvKSRwL5x0kWd/wLdWU1E1J0bE7Cr0aHnLKglXD/K7qUQxSwqPjL/dQnQ3iSNefQFQdjgancp
	g==
X-Received: by 2002:a05:6000:2c0a:b0:43c:ef70:d69a with SMTP id ffacd0b85a97d-43d642dcc6fmr10004329f8f.50.1775914966879;
        Sat, 11 Apr 2026 06:42:46 -0700 (PDT)
Received: from ?IPv6:2001:818:ea56:d000:56e0:ceba:7da4:6673? ([2001:818:ea56:d000:56e0:ceba:7da4:6673])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63e469ddsm15988205f8f.17.2026.04.11.06.42.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2026 06:42:46 -0700 (PDT)
Message-ID: <6db4332ece9b86ce9b13565677b2962f01eebd3b.camel@gmail.com>
Subject: Re: [PATCH v2 0/2] iio: frequency: ad9832: cleanups
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Joshua Crofts <joshua.crofts1@gmail.com>, lars@metafoo.de, 
	Michael.Hennerich@analog.com, jic23@kernel.org, gregkh@linuxfoundation.org
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, 
	linux-iio@vger.kernel.org, linux-staging@lists.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Sat, 11 Apr 2026 13:43:56 +0100
In-Reply-To: <20260411084402.71837-1-joshua.crofts1@gmail.com>
References: <20260411084402.71837-1-joshua.crofts1@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2026-04-11 at 10:44 +0200, Joshua Crofts wrote:
> This series cleans up issues in the AD9832 driver,
> including proxy header removal and bit math
> simplification.
>=20
> v2:
> =C2=A0- PATCH 1: removed redundant bits.h include as it
> =C2=A0=C2=A0 is implied in bitops.h
> =C2=A0- PATCH 2: changed ull to u64 type
>=20
> Joshua Crofts (2):
> =C2=A0 iio: frequency: ad9832: remove kernel.h proxy header.
> =C2=A0 iio: frequency: ad9832: simplify bitwise math
>=20
> =C2=A0drivers/staging/iio/frequency/ad9832.c | 7 +++----
> =C2=A01 file changed, 3 insertions(+), 4 deletions(-)

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>
