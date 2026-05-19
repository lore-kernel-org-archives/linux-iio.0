Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4FE23F660E
	for <linux-iio@vger.kernel.org>; Tue, 19 May 2026 09:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779182522; cv=none; b=h3FqOa8kST0LDkymvMfsThP4GL+M9nRk3dHho1EGkWRRm9G08y8AdhwQRIyTtFWMx6fDXZIEsMElLIJCaUSynzHKY7lnrQf8moBcxAPYjiHbLFId0DzSi/re/QAvIENqQnTIekB7cJ2r+I7TMRJVG/CaFvHmoW+8/TIzJpHet+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779182522; c=relaxed/simple;
	bh=hNvx08rWnMQ5uxUvhF0vqwzutLouzrdyDnVsqcZvK48=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Xb7RsmpwZdLrmlvsKXVB7ZaPZi5Xn0TjGft0EmOCXin6ciIuyrEWjXTwEQkgyqrnLehWzOBOS+z2lDkLBlwHOeIZpNbdmM0I5FK55kfZptuktBgdaFRz9QYYkQ3eSS8qveqJNfqEdqetzHn5a5+yfDKx8mJoslopB4ZCL/H1jJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l8lUqjFP; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l8lUqjFP"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-67da63ae541so7319938a12.0
        for <linux-iio@vger.kernel.org>; Tue, 19 May 2026 02:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779182517; x=1779787317; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wARBLVyDz9S/ISHJEKmdBILI41iLg0qRlq3LtWnKe8Y=;
        b=l8lUqjFPfY7qN4ZjZo2qc/oxsuFGa3mehKmGXs9yfOyByPXCF4HBVtLThY3qOvDz2q
         963ckz+gnTt+KU9C5vPYmc1eA9peVJRXP9Q9V+8HDG6Tnz/PPoe1inBrQqpwoDUTh7yi
         bcNNT4Gq7+5WO+CII75ZHuLWrGsdEfdK6QIVNFmhsM78e9h39PRXjaglGKUUDvBwuB0u
         j27U0j2istdQW2eAf8bHoeNtMXpfJzMSd0CARsKZRjKXQJbqVS7+VDf+xZuOSuu1E8f5
         SuI3jZZaxG8+sIA4MQi2Pqj9vcNOvYRXZUbM3UtEogIe3g4UvEJ/vrCWKv4pQv6F6wGg
         wJZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779182517; x=1779787317;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wARBLVyDz9S/ISHJEKmdBILI41iLg0qRlq3LtWnKe8Y=;
        b=ai1YfFxJ1WA+02Vy0WmepaL7cpmDy0ux/dB3jBxAjZVerVvYCqk4JaAQfRBhEU8ELH
         Nv9cp+TST2SyVhnfz8la1EoFd1miRVDo+zJ6dUlnrM5Q+i4W+GtaG4hF14WkgFKUmYti
         y5Vt6BJTzFoxSfl60yAhm2FCPZLHMG9ZO+EnumNl+pxg1FRi9NcSgpAptzZLMHogHOI6
         XJZXH8GBz+qtKfRsKot9QuOE/hlkVzLUOIC5ZeSXeFjRp1HWZ1J98zH9pH0hr61NhI8c
         I8j0v+DCbM9XV8aCzhCNhwT6zImiWP9BMUwpEaw7/ayR13CELDvwb/ddg77IWStMD1Es
         4DSg==
X-Gm-Message-State: AOJu0YzO8ZDODAUiG4brqow7S21H8wFXrp/nZTlXvqGbDgQLcfFcqW/N
	c2w3XhPivBvuMG8iQ+0sKUXbVgZI6TZuDoCIxoAoYWvtTnjYwZVLRQNGo27CD2GU0xM=
X-Gm-Gg: Acq92OHuEAISGLPs42nwGy9j8aUTRZfL5krA/clrT1wLfdG/zuiBaEgMWX2IJzYIjhP
	vQdHp9orbjNRpTGP5nksVfy4lcGawqGnGX8PrmybaJFr0wDu+xGCqlmgwXF2XK4as4z3gp4rsv1
	CrzC5krUKIC8+jhq7575mb92GygOekf6pYXeFzGqJZh6aym/oYzqd/zGr8tB1geRKLxIZjPGf/u
	Rcn00O2lY/OFzCCL+Jy0/p/CMqpT2KDeAyFc5es92y2hBlpz3BDAqGTZKQI1axu0vjlJwVg7Guq
	R7DqvY4U1vArMZfUznkgpeVcOhlAGcl49UoQ6+QY3pBzAwK+w1bb2/8+to2nGBck6DV4lSEjh1P
	zJiUozhrSLI0OAz5xMlRNCbHGscmRp7D+nAOoGOMA8MP4KrutZOIp1cCA0n6QPBu0neoMHQ4Icd
	aV5xrf9b2P9QKmnL3SdcojWBThMb0=
X-Received: by 2002:a17:907:c206:b0:bd8:f7f1:d31e with SMTP id a640c23a62f3a-bd8f7f1d8acmr242648966b.49.1779182517087;
        Tue, 19 May 2026 02:21:57 -0700 (PDT)
Received: from gmail.com ([212.75.105.246])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-68310d58c79sm6320572a12.12.2026.05.19.02.21.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 02:21:55 -0700 (PDT)
Date: Tue, 19 May 2026 11:21:53 +0200
From: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>
Subject: [PATCH v3 0/2] iio: light: add support for Broadcom APDS9999
Message-ID: <cover.1779181370.git.azpijr@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Add IIO driver and DT binding for the Broadcom APDS9999 ambient light
and proximity sensor. The green channel uses optical coating technology
to approximate the human eye spectral response for ALS/lux measurements.
IIO_INTENSITY channels are also provided for red, green, blue, and IR
so userspace can compute its own weighted lux.

v3:
  - Dropped RFC
  - Fixed MAINTAINERS entry alphabetical order (B section)
  - Changed IIO_MOD_LIGHT_CLEAR to IIO_MOD_LIGHT_IR
  - Unified RAW read path via chan->address for all channels
  - Switched enum gains/rates to #define (hardware field values)
  - Used USEC_PER_MSEC for integration time table
  - Removed redundant comments from resolution enum
  - Added default rationale comment in _init()
  - Added ALS rationale comment on IIO_LIGHT channel
  - s/reg/regval/, fixed indent in poll loop, C99 .name for id table
  - Moved iio_info right after read_raw function
  - DT binding: expanded VCSEL acronym, explained separate binding
  - Commit messages wrapped at 75 chars, clarified RGB vs raw status

v2:
  - Added IIO_INTENSITY channels for R, G, B, clear
  - Switched to guard(mutex)(), devm_mutex_init(), dev_err_probe()
  - Replaced remove() with devm_add_action_or_reset()
  - Don't fail probe on PART_ID mismatch (fallback compatibles)
  - Replaced manual shifts with FIELD_PREP() / GENMASK
  - Used get_unaligned_le24(), sizeof(buf), NSEC_PER_SEC, fsleep()
  - Named gain register values, explicit resolution enum values
  - Removed section comments, grouped bit defines under registers
  - Squashed Kconfig/Makefile into driver patch
  - Split MAINTAINERS entry across patches
  - DT binding: added vled-supply, interrupts, required vdd-supply
  - DT binding: fixed title, added blank lines, full description
  - Dropped "DT binding" duplication from binding commit subject

Link to v2: https://lore.kernel.org/linux-iio/cover.1778659152.git.azpijr@gmail.com/
Link to v1: https://lore.kernel.org/linux-iio/cover.1778491503.git.azpijr@gmail.com/

Jose A. Perez de Azpillaga (2):
  dt-bindings: iio: light: add Broadcom APDS9999
  iio: light: add support for APDS9999 sensor

 .../bindings/iio/light/brcm,apds9999.yaml     |  54 +++
 MAINTAINERS                                   |   7 +
 drivers/iio/light/Kconfig                     |  10 +
 drivers/iio/light/Makefile                    |   1 +
 drivers/iio/light/apds9999.c                  | 337 ++++++++++++++++++
 5 files changed, 409 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/light/brcm,apds9999.yaml
 create mode 100644 drivers/iio/light/apds9999.c

