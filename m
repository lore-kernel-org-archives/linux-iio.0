Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14CB2D7DEF
	for <linux-iio@vger.kernel.org>; Tue, 11 Aug 2026 02:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786415777; cv=none; b=mA03iYnEiusSHIiVy2aCWLc+tfZ+9eN8idDp/RebZwCeN+sal8/A2FvyFH1BYU1a10/cs4DwXs1OM5aVPt3bhCZOod3jvcTTj0k97vv0enMLW5+XaTD7CT34fG2+ImZSYpM6DgA8fV0fLqFWLpDzNX2g9qXeVwrm5rR0zio75jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786415777; c=relaxed/simple;
	bh=OwadaKmvAZfvAcDlcxt3do8qvSPnGOxzuLy54LNDrH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AKnSeSqIHWcgWQEB3/zuA1OS1pUFRs09WLOaYEBWNjp6sfediWnVao8elVth4G7fBtnryyHsOa2fRXPBxuqQ2e8eYjVmi+LJkOhKvPS44A9RLrPVlwTud5xlbadjKvtIzWxbmptRWiJagjIfpGwBV0dcc9kIUrWTi/uGATNyjfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qODjUfVs; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qODjUfVs"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-81ee6b2da98so35923947b3.3
        for <linux-iio@vger.kernel.org>; Mon, 10 Aug 2026 19:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786415775; x=1787020575; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=h4b2OZ2aRrsF4ECqruG3+CkREyKbFfFDK+SPOWLJqx0=;
        b=qODjUfVsz8FLlVofRm7cSKXBo7Rz4E/IUKJnJ1otkKu0/t0YzptyeIGon++hzuB0EB
         TcYGM1pXm2+CEJyE8Yqjv1KrVqG+Xo9hMyePC0IxlGfU37ieovE4GjzDhXeaXexTXpmP
         1nr7TIWvikIbReCAQNbo4sKh7AEKsGN543EUX8jvFR/Hsxvtr758AbvkCmk9trqZDHYc
         DO6MDPdfWmvcBP5ue7DI/2d1THD48T/O2KI7k5ws0Ck1Mty/uKQWyxGEbwlnu0FUkHsC
         8DN/1bFLcdvF5ynVFwyCgiLFgd9MnVMnw8TFRlpUJYRVEtxRkkI8XLns18/PYf4ypncz
         SO5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786415775; x=1787020575;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=h4b2OZ2aRrsF4ECqruG3+CkREyKbFfFDK+SPOWLJqx0=;
        b=GsrGbe8W6euuOJpCHyYoBkpuu08bL1y5k2E+h3YlUBdl0ib27BsKGcBM4oO77G4bqh
         DT9+qv1HhFYtCrpZBm+ov/SC/P+98e6a66SSzZdjhCOgZmbwnDaL0nvwMxRgdHiv9CuR
         jQZ1nGEkbN7oMmHa4gsuQNF9KxDbZcGtRNpUgzXZnC1xuiBBO0OCEskNaJOIgdajFxTq
         9rMVWKyn/J3h9P+anpANUxBKOAwGM/EFyARhkwnjNYg59j+ZD9AoEGQh15I+6N4ka0gX
         tfXPV5tljt4t7qnLjvAM9O8Uv01bimMKpif0AQ5mm0xUOoEtSbl0ttojs4WTvCMcIYxG
         Wr6A==
X-Forwarded-Encrypted: i=1; AHgh+Rprmsi6UzIBQ/GN2Qz1WJIq3ZK4icjb0qU8HRvUsOWG8GfHEN1HzlxFw6U4HfrTRTdYnzK5OR7npvo=@vger.kernel.org
X-Gm-Message-State: AOJu0YydpiZfyDl4Bz4Sp83N2buMCFrbkH+GNDNrSH2PZu3sMC4zKz9y
	5kJOIDSoHzXzox0+UJx4LQ73pcCbSPvSAv/gpNfZcm00fBN++qEct4/W
X-Gm-Gg: AR+sD11chi4mQvz84x0g1X36EruzR8IzRt80iZ7iMsOc+2sQI+9ix9RM4vq+NE6CMQf
	F5YQlwDu/tnRo7QKQ5uWbsbbUILqRbM4hzeJ7Cxx9/4bnRZcM3XGru1LlhePTNYFh2+2120nnTS
	1I8We66kjN3w8OXi2RextKK/GWAxSylCqt76TdNLE1oYMaUNoerT2uvbd2/F8PlZtK+9HFr1npf
	m0xqx0JY649WaYbN5ax/kzEYh9cSLq7jWdEJRUgfIddrzCDyygZTD3kMUqOA53QyzJyuTicc0GF
	6Hj0Xkd1W7NtsKTFeVZFBEGs3gcT/CBveXr4IpXklWyKwfY6W9PKXrDQyfV3YsMzaFHL6Z9abTU
	Fi4SMcZUNB+peMYzdVosTCFYrG/9voStjCBbsc6rHKFvgjhCUOidB+be4qMKlFvRiD8BTNv1y7P
	iX/EEYeHca4r9UZMOZ1y6wXyaZvIZtjVOpdJ33V315RIJ++TAiKVJ1jXai4xtiLtYIbW57UQ==
X-Received: by 2002:a05:690c:31e:b0:81e:fe1c:2de8 with SMTP id 00721157ae682-825728d1041mr174909857b3.3.1786415775409;
        Mon, 10 Aug 2026 19:36:15 -0700 (PDT)
Received: from localhost ([2804:30c:4018:dc00:8be4:f5b8:4af1:4728])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-82ebeb0da41sm1984107b3.22.2026.08.10.19.36.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 19:36:14 -0700 (PDT)
Date: Mon, 10 Aug 2026 23:36:48 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: =?iso-8859-1?Q?Nicol=E1s?= Antinori <nico.antinori.7@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>,
	Brigham Campbell <me@brighamcampbell.com>,
	David Lechner <dlechner@baylibre.com>,
	Jori Koolstra <jkoolstra@xs4all.nl>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Shuah Khan <skhan@linuxfoundation.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH v2] iio: humidity: am2315: add am2320 to i2c_device_id
 table
Message-ID: <anqKwJOkl_cxzCT6@debian-BULLSEYE-live-builder-AMD64>
References: <20260810183337.451812-1-nico.antinori.7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260810183337.451812-1-nico.antinori.7@gmail.com>

On 08/10, Nicolás Antinori wrote:
> The AM2320 is fully compatible with the AM2315 sensor in terms of I2C
> communication protocol and measurement conversions.
> 
> Add the "am2320" entry to the i2c_device_id table.
> 
> Signed-off-by: Nicolás Antinori <nico.antinori.7@gmail.com>
> ---
David's comment about the IIO device name sounds appropriate.
The am2315 driver might use a chip_info struct to hold the name of each specific design.
There are many drivers in IIO that already have such things.
drivers/iio/accel/adxl372_i2c.c is one example.

An alternative might be to use the device id.

	const struct i2c_device_id *id = i2c_client_get_device_id(client);
	...

	indio_dev->name = id->name;

Not sure if the second option works well for both i2c and dt (probably not), so
I'd suggest the chip_info approach if you intend to add a device tree id table.

> v2:
> - Adapted KConfig text using the suggestions from v1 by Nuno Sá and Andy
>   Shevchenko
> 
> v1: https://lore.kernel.org/all/20260805183733.1000550-1-nico.antinori.7@gmail.com/T/#u
