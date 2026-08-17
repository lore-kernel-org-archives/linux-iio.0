Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069693EC83B
	for <linux-iio@vger.kernel.org>; Mon, 17 Aug 2026 09:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786959584; cv=none; b=vCo9U1DvBEWGpP8ggvufy88Er6XUHZZa5aaHOjF8b6iM/kcKuY5WHp5xT0foo+eFzlvW5LHsQ0557lADVbuESyvAu2q7EYFGgmUeW5qkTou+b3kShb/++1imgcPZCZM9+gcbbJ3UaQIn/AAmRcENriLJSpJ66q8tXJfHDWzsG58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786959584; c=relaxed/simple;
	bh=dtk6e7DXkab0Wi6uKJ4HjHzWIAKxI0jK8NztSrr+wKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u4P7CqSvs/He3BTf+Ajxl4sZ57/dz6BFR+Ft3TLfUhtz4UEH9A/wsAINNgJndSagbWHtKrnDT7RSX1cZRC3Dm5nw9xweORYd+WNLvRR1QvUWlzJCOEMBciZ2TOKm+U6UJERXGEHsXPorSWJn7I1LhZRP/mgdIBFCpiYsw7rXbaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=hDHFMeiv; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="hDHFMeiv"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-49556f97a9dso21297605e9.1
        for <linux-iio@vger.kernel.org>; Mon, 17 Aug 2026 02:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1786959579; x=1787564379; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dtk6e7DXkab0Wi6uKJ4HjHzWIAKxI0jK8NztSrr+wKk=;
        b=hDHFMeivnqgaKc+0lZ93f98BgXbzgnxU3Ky/WbFz1oZPuM93N2vbfUSzt7WX7xQNZ4
         IJc7twCldleo7/B430+SRGv34cEn9G834h7wlUXuQXGkyozNDRowruON2bS8FQwesTp1
         jxY+ox2LQy6qF+0z/RyxRHKl+sBVwkdtK4oebDRIuueFloW4Jw/OxostUmk1SPyfxVZ1
         Or9GM2v3mTfzqv9VATtVzpbgn39+vkAMKrlo6Z458IKTXsTZ2qhoHzbFWgGEqEeJbJm/
         jDOxRdBbimbQBqz/0nQlvmMWUMlS/CpnEdHMEsY1t+5F6upQp9HKhXGq/CQPUzOT8/FR
         Fp9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786959579; x=1787564379;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dtk6e7DXkab0Wi6uKJ4HjHzWIAKxI0jK8NztSrr+wKk=;
        b=TytG3P6Av/QkXdeWkYiNyF2hf4Jq5c43iBPXnQEFkIb6lb5B555qgNwfkSWr7gU1Ti
         C9j1Iodemxy8INiiXtHOR14ogZaFedNVXHGHUcuJKbT0hrLw7g1O9FtAft2zXDBpaVaV
         06J0d9ze6aTVWtGqd/277hg5L56rhcnM0ovM6NzMe8+9G5Kr7bPYm/k1P5STyn6zC67c
         zWgEcsgzjFePpPBtZm1skCyOybuvgLyIEH0pXBDpcK0g/CY7sOYykEYLL7FYTXs5ymZo
         1FdjBPSsczLBw0OmQ/WAsY+vjzgLOGcSDKkb6unBh992G4Tkc9+uUbnHDbX5wDhXAOc0
         5B3A==
X-Forwarded-Encrypted: i=1; AHgh+RoUX6hKbh8FCDjVqqf8odvp7kA/E8A1MpQSlGrgTN6j2tE8j+1lEo70KJ5/2CVB8uUX4t4N98sGp9U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWO0Mh1aEmMkiPmqeQPY9acddi5xL2N01reYbOtWoHbLgLjxvs
	V9MqQjDXYd3HEkPCY7qFNR+IPd476MG/A8odkB0KPW9LGDTObmWbxsaUdOfc2xA8YpI=
X-Gm-Gg: AR+sD10BKdIhn7ZBPV4T9gfas0GlIyajCSKELcsflN5B63GleOESGw7VS3J/Qf+U3MD
	SuilEgWe1bMc0yAGIYi9YisVdhVGJzPXCMm+kGWaXx0T8JyJGNfXwSBUejP6IehPTTRjqjWd89t
	ku8d37DoH2/Y3YuOK6DXbA1t5m1nn0ew5gUvDkzpKZmRX00TxfMwAcSz38iDLOmTiB8+VIXWmHs
	PcD6jtikT5cB16vBnIJcxp1BOHzsyDZYYkZbDNBcpnIGV+Ah13RMYq53sGRg0chwBzzhp8q/Cw7
	BU4ygJSaMQ1qVooMJMdYQyhcm3cvyaBWi9JfrekKDNhJY21yceEoKy5JoyHVAktJI22PLiFYdFd
	jDbMf06B2XAf5uga0jAT0Cp0lJQxDUYGiRZL0KoVCGwgH8LgrLWmpL311bfYo4Qb6Un9l8rkWpl
	54yU3Gt8o8WF3GBxyWV9g0vpxrCz/3xud+I4e8pKYoCDCSi16Y61f4INqBnKyGKOV9cN2HPGzAk
	+UTO3/GHSCH0kCz0shq6qFUkbOCxCrPmsGCszJhSpG2GgpGHzCQAZY9UOkj9i5PZYdcYFgUY0Fu
	416hZ0zZZjzuXyCQhspj9abVyUDgDK8mYlOiaT7TMfkCew==
X-Received: by 2002:a05:600c:4f12:b0:499:491e:4b0d with SMTP id 5b1f17b1804b1-499879c627bmr387093535e9.19.1786959579385;
        Mon, 17 Aug 2026 02:39:39 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4999610ed6dsm169142985e9.8.2026.08.17.02.39.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 02:39:38 -0700 (PDT)
Date: Mon, 17 Aug 2026 10:39:36 +0100
From: Daniel Thompson <daniel@riscstar.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Svyatoslav Ryhel <clamor95@gmail.com>, Lee Jones <lee@kernel.org>,
	Daniel Thompson <danielt@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Helge Deller <deller@gmx.de>,
	Johan Hovold <johan@kernel.org>, dri-devel@lists.freedesktop.org,
	linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	mfd@lists.linux.dev, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v6 04/14] mfd: lm3533: Pass only regmap and light sensor
 presence to child devices
Message-ID: <aoLW2Lo7LDD-OcWF@aspen.lan>
References: <20260731113632.158440-1-clamor95@gmail.com>
 <20260731113632.158440-5-clamor95@gmail.com>
 <20260815025203.2618cf8f@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260815025203.2618cf8f@jic23-huawei>

On Sat, Aug 15, 2026 at 02:52:03AM +0100, Jonathan Cameron wrote:
> On Fri, 31 Jul 2026 14:36:22 +0300
> Svyatoslav Ryhel <clamor95@gmail.com> wrote:
>
> > Instead of passing the entire lm3533 core data structure, only pass the
> > regmap and the light sensor presence flag to child devices.
> >
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> Acked-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com> #for-iio
> (I didn't read the rest on this one)

... and it looks like I overlooked that there were backlight changes in
this one:
Reviewed-by: Daniel Thompson (RISCstar) <danielt@kernel.org> #for-backlight


Daniel.
