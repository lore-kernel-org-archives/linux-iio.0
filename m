Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F420F5208A9
	for <linux-iio@vger.kernel.org>; Thu, 15 Oct 2026 13:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792072555; cv=none; b=tShtR6GiDhQ3D/rH0MSsEq+umZoJjWdKhsKhKSaBd+BEEE3+YZjky8Y6tNZQTRoumTZYGGX+P8fz3WNKpL6Gg7caez4spp6IgbhOFF8oND60H3v6OtonIq/X6/YFczlm9MVjVSIGYHu6/IzxDJTNrAVqVt8HBv/DtxwwEa76fV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792072555; c=relaxed/simple;
	bh=gQYm17sa5ahRfisIIwGXqP6mPMhCqy1cszmuXqL0mgk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cV6cwvVtH4gxlBTuyMu9henJnHJcARkakT1PQLk8UnCTSTQa39U+tjbwDImoml3YmU5ECtaN7iIlI9bfJn75QRgDoSv5+i9kxj6VwvJKQ6PkqDY2bwxGtolzArRKs9HG5EGs+QUCq49FftzbtLKHYKDJjyL/iFUv7K9oPdhxE40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MvzDFfVY; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MvzDFfVY"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a0213948d3so32901365e9.2
        for <linux-iio@vger.kernel.org>; Thu, 15 Oct 2026 06:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792072552; x=1792677352; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LptXPwjGM5HMaBJ96EAadxxZVvp/oyED+Z19mhaxaso=;
        b=MvzDFfVYN3o9kBQhjMs5qlPXolXAS5aiR6m+d/NWmWMAdt8fPFkm9e2VyvuzE0A0mu
         ckuNwwyGuA2UWL1CR51yEGc8ltGqtM3WEK0dv9/q8d1qTsH1pqtj8W5w2E2ngIwIGEcg
         E02SmjZShNxTUIeowdjN6zV4Bh5kpsw8dEiJNQoJGboYQhH9SujGCq+KLRSap5LB71Mk
         k6NB92dUsGaNs9fI2OjjBHjoYw/AHL0xJtWACXAvp1ABHdrC1fnD1Tj2qRdoOh5u72zi
         Gwwhn6vdovpgY0+BGP2VsddTK4PaAU6zkShg3RarkdfarR5+WkZVJu0SdhOXkcbY9L9l
         l+hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792072552; x=1792677352;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LptXPwjGM5HMaBJ96EAadxxZVvp/oyED+Z19mhaxaso=;
        b=PcSCtUTikrYkh6MiHgxmzgp0B0WS5e9UlKsFTxHvP/q7VgfPRiIsg0VGS+tME6bl5I
         Hx445gwkDbn3n4VUYKBI+i51tUK9nv0QbNZtSh7fiw7ise37dzuL2pf5pbu2C4tABMXo
         qHHCfxZyhJlpW/plYEr42ZISuV4SnRMTnU+SkXBUZGJZKSG23vUDHfAMw3JQ/zJBUDZe
         k0HwuOQXw8qkkC/RsKvm4yfN9glWv2aizdwsv0XAD+uhE1yJAWZgpqtidP7f190O8W9B
         rSnyUCtHzQppbs0moggZIehwvX7RVAMoxvLOAY3zmpeeiPpeOzmrnVVVQmIfJFflsH64
         1nXQ==
X-Forwarded-Encrypted: i=1; AKwUvBwmE02GJwSuGVtqbzmp51fcgWny61Jufqn0/FldVPokorGbKRQTSqzfH49REdAlgs9eKCatfea6Na0=@vger.kernel.org
X-Gm-Message-State: AFq9FYJjjzl2pydN8EDVSVFARhZGe35N5ks/0U3b/cnGgM2uDKUxuuFj
	VYtNdC9wnsapZ9OMfe8hhpARdUYhdMHrCIZlprY+VZbUd290/bjS9EFkT45pYg==
X-Gm-Gg: AYBFou0Xq9XxZyhC+4v58kUhS/MHxqGlJgNrNQPLfH3a6yp8Dzrtsw5/G6DSBQQonLj
	+pNEsZL71SO6b7Ote94pDY2nDm4LQJyIovdd5Gn+YP9TWNs9kqdk6liuE+FFpKquDUCIIuy433D
	irG86dUHDysSuNBzY/N0swhLStRTM53Lu2KvYNIZBTL5A/4zzbegljhjBOGmny8loo095mgJHbv
	q74wc+EjVDbDDOaXhX2tJ+t9Kd3bY4uA70AxxwqEyvanzvDXn2HMOvreldhv10vKqHU+KiAfL7V
	8bGDauXGx31GFufk9OP1lnCzgH/yyOO4jYDubKRajzkn3ypCBPwTASXN/dmN5ngO2tYtlBph9bx
	251qCPXZR+oKv8YcR9JalmA35X1NUbuYp2cB/v07tkcJfPiZZLqohVlIkVn7qUBNbRdP5SzMsml
	olypuPGl0+vqZ7cdZWVZfmOL7QfPx6Glg0VjRDT3YKrNavQ0iV+ZX5/PIhp77lGNVEgo8S/yR4f
	3gQzCFWlRivb4ssYXcGgcnnngSUc4JODM7EUNp28RqRkc7Y8MnAEgLc0dDjFkJpgF5+2heRToc/
	JFZ4qceI0LJ3oDRDcTaausq+kwZQXvXdw7VORb+JrLpbksUCgWV+PBwtksyAmY804pxmpGla+tg
	m9Hvif8+GPXF406Vb8Sf6NDvi8Rm0LLuh1nR9qEWTBvcsBXhr6oS6n7K1KZJeHudauUCQ3f/gHY
	gvFnE/cg==
X-Received: by 2002:a05:600c:83c7:b0:4a1:698d:3044 with SMTP id 5b1f17b1804b1-4a18e493020mr381268955e9.11.1792072551887;
        Thu, 15 Oct 2026 06:55:51 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1bd97ed33sm84432685e9.5.2026.10.15.06.55.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 06:55:51 -0700 (PDT)
Date: Thu, 15 Oct 2026 15:55:48 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Nikhil Gautam <nikhilgtr@gmail.com>
Cc: anshulusr@gmail.com, jic23@kernel.org, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: chemical: ags02ma: Check for short I2C reads
Message-ID: <20261015155548.00005ad0@gmail.com>
In-Reply-To: <20261013171726.15670-1-nikhilgtr@gmail.com>
References: <20261013171726.15670-1-nikhilgtr@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 13 Oct 2026 22:47:26 +0530
Nikhil Gautam <nikhilgtr@gmail.com> wrote:

> Check that the I2C receive operation transfers the expected number
> of bytes before accessing the received data.
> 
> Return -EIO if the transfer is incomplete.
> 
> Signed-off-by: Nikhil Gautam <nikhilgtr@gmail.com>
> ---

Fine by me. This is more hardening than a fix so no need for a
fixes tag.

Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>

-- 
Kind regards,
Joshua Crofts
