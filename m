Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4AA4F30D1
	for <linux-iio@vger.kernel.org>; Mon, 12 Oct 2026 21:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791841719; cv=none; b=JmuHUu4JZLEhj56Wu3MEg22+ka0dtdgnIbC/ss2ICqS4gdJdUH0B+cFmLh2VLxfPHjKswkaSGuAdSoQxwbFUUHjtFzniV/1x2WIpjnA7cdBfMegDAzsI9a96HDbunHaHeUbw9tWKFuIehto6XKcH3BrojzGv79aDbFk6nYkC0Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791841719; c=relaxed/simple;
	bh=M8DED88FTt9vGdXSJgORPtM+dFk8rNOOwoXkojqQ0ME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BO4JP4fPKEG/hO1fI7XPmdrFjcGUApPU3o8A7GB8iUB/GAPj1ENVbZVj1U4DmvtZe83lz6T0dakENI9bCK1kVSNlGDbJsWqHHVCqtgGEaqPuiIbaoYIl9TNRUgkSthD+JelTiybeR0Aa2xbuvRbZEBKCgWkJ5TI2CM344KdeI5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j6SQyZx3; arc=none smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j6SQyZx3"
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-7cb6983cb9bso137483137.1
        for <linux-iio@vger.kernel.org>; Mon, 12 Oct 2026 14:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791841716; x=1792446516; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0HnRhY04PNKIblmopaFcCx+f2FeA60ZgfsKkxJFBzxg=;
        b=j6SQyZx3sPaIksG4x4b65KZxBMhJsxzFsDlySPoMpKh0OTkHOe57irh70AHvVAUylv
         cXQrxPWYCXAcy6kHi4OuTPw+ZZUkBuIM35UXK1SmU9QhysHk02fHiHp6LsutgBgo0RXw
         Vv9xIwdOujPaWzfmUs1/2M79ruXGbBbLzuJ5eG5xaD3fjSxOtomhK373LR6B4blptBCk
         t9JXOvyibHJzaSjVaI46ip0rRYRpUyc0Rzm4R8A9Xmvska/QS29m0OcH2r47MdPNVNdf
         cfPJZQnJjfb0gcqK98XSXe7+XV6tS889qTByRWazk6dOLyafksSPA2mzhNevTpO7Io0I
         qz7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791841716; x=1792446516;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0HnRhY04PNKIblmopaFcCx+f2FeA60ZgfsKkxJFBzxg=;
        b=G0siZnXZ5FADKql3EUHY2LKLQ4NMmWxSUrPJO8GKR5Ex9vNB0tucnNCvMpMiTOYysR
         4iOJdjmzaP6G+rKWXKxPN7G8ddw0r9+xOv28NrAKVKbjMBChUQ9yjZvebqqJi7kPBh0m
         1ZcK+/m1Y3oLzGjBHGqLKhKGYZ3bKk1eQpfpLj7vv438YrpPmEtlz7gCz1b5uGmyEu4+
         32qWdPf8h6o9LFyX7/4Y3EJEsC6CmtqFD8YiBbRM9nZ6czH2LamFefyoRWWiiTN4jixR
         1an/cHEoN7hX2rwbgtF31duWUcXqSakUrxfT3zigqPRKhwoqzs1PdsGJ3nXsC7JJAzJc
         Wk7w==
X-Forwarded-Encrypted: i=1; AKwUvBwOP1/uwEFsM49k3jbk1awOIUR6woLi79DT+cgojA15vRNt8iBWkYWMvZnQgxAyXROxvaxprDhqVis=@vger.kernel.org
X-Gm-Message-State: AFq9FYI7gk8SNYbsoX7QRM5Eu8u14pyh6EdlZpdLpFSO/ddO1NbJFExn
	wnCXRofmQRk6MiM/UIflMu+bsEbJESdFmOK0+Qb18VaHzVKWU0nkbSFY
X-Gm-Gg: AYBFou1p5R38xFIFKP+5N/wMCTfZrDhwPRM3cwktztBKUbuTFSjwobOZ+dBfqByJs6S
	BxUefvK7/o3w/FcNHvp9Mtn5HZKC9B+JEsDboMke3t8o7Ug+au5GbQnVg5SVMjcGHdxU8OaEqn6
	e5pA1/8cp6PzFRZsmybZ14W71ZUW051gQQrt3IYohIf8+//yusMvbwCwNuvA2sJoBKFJ6IY461t
	rNk5kFzgEHBESQpGE0oNg3/uz7w6f5/MAzMRg81y7rip97b69QIBpkyDHhOg+SjTP/7M6ujGuDO
	GbqUjfVkv2G4ecedfOTT9w8zbR1CmnBbvc2j5SoCs/vyCN4CBC/n2+SFfuDPKoOR2zTGPAY1T/m
	We/qid2KCAOBipRb58B/YvmOhqUrM5lCKjss6lfCQOHExKZMa3TXkGaruzwfFJkIEeV2IA1FI4Q
	VnuzQF1keiqnJGjKeyeYXXggBpoYOs+syoRvwKNkwyJJB8XjqnHcPPUCE8mlJfNxfSoQJ08a4H1
	ktg
X-Received: by 2002:a05:6102:f8b:b0:7a7:5355:7fb6 with SMTP id ada2fe7eead31-7cb3737be51mr2116910137.24.1791841716002;
        Mon, 12 Oct 2026 14:48:36 -0700 (PDT)
Received: from localhost ([2804:30c:96c:bf00:7844:c38c:894:4054])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7cbbd178e4csm1426250137.2.2026.10.12.14.48.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 14:48:35 -0700 (PDT)
Date: Mon, 12 Oct 2026 18:48:55 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Kanak Shilledar <kanak.shilledar@axis.com>
Cc: Henrik Grimler <henrik.grimler@axis.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	Joshua Crofts <joshua.crofts1@gmail.com>,
	Chris Morgan <macromorgan@hotmail.com>, kernel@axis.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 3/6] iio: imu: inv_icm42607: Initialize gyro based on
 chip_info
Message-ID: <as1Vxx7sz3gTfc-q@debian-BULLSEYE-live-builder-AMD64>
References: <20261009-b4-inv_icm42370p-v6-0-e53884f185ff@axis.com>
 <20261009-b4-inv_icm42370p-v6-3-e53884f185ff@axis.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261009-b4-inv_icm42370p-v6-3-e53884f185ff@axis.com>

On 10/09, Kanak Shilledar wrote:
> Update the chip_info struct with a new `has_gyro` property to support,
> devices which do not have gyro functionality. This is a precursor for
> adding support for the Invensense, ICM-42370-P. It is similar to the
> existing device except it only has accelerometer. Check all operations
> related to gyro with the boolean.
> 
> Signed-off-by: Kanak Shilledar <kanak.shilledar@axis.com>

Reviewed-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
