Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5BE33067C
	for <linux-iio@vger.kernel.org>; Fri, 29 May 2026 11:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780053043; cv=none; b=KcSdQ0l5GxWzUP0djcKxV1RDh0znzKribdqZbff2Tc3aOWTep4nhDFtrdY6R3Wai8aaToXo0N0zK/t+bynlbX6yqgyoZKCxgVXvuu7oPc5mQLJLOofZJCooARRANP5nPIQkuZ01LPYCMVeVIZ8CoSeuzQL4Lix2rU+IN0eT+HlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780053043; c=relaxed/simple;
	bh=VwGJ1aVISsmjGLnoNcjoGKPnok5e19Xi0seckWEDRu0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DZYyNyzDMWuLq11c3/B9ZxbcKS/nyLlF+gyL7EX+YXX9uzgKEAAQ2ZWicSK/QTAUf2XPG+UttaP8poZDM0ghSqnk0yI4qaffpHpKY3hM+0aRmsA34t92GM/Lh88S73J4y3wOdONaoPJ1OEO1c0PG1jpKeW2Wdv+VcRr8GpjqFUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=zHK8lmBu; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="zHK8lmBu"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-48984d29fe3so143929855e9.0
        for <linux-iio@vger.kernel.org>; Fri, 29 May 2026 04:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1780053040; x=1780657840; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VwGJ1aVISsmjGLnoNcjoGKPnok5e19Xi0seckWEDRu0=;
        b=zHK8lmBucbZ1kGYWNxWdhPPADUlkMHzI3vr/HtsrxyRdyVZ5iG3yZ9ZYZ57JdWiK8O
         Nj8/ghwxaaR9CN2MwOzZftw6rWW5HY0/VgIk8uWJEEVMnvoeR0jiiV4j2K+iPZNDHjY/
         9OgFRmOq6lzmOS7R44nxtdSpkaGmRKzaIuG6GxMxUpR+4ix131SJVw4fclFmord8xWV6
         5qP0M0B+H24ll019X3oA1PztnydZq7Xmwq4/8bvp+VbE/UP9UETZ5zybyKl7IoBreLZm
         1wEMEitUqJog6Sz0xtKz1eCC7dgcDpPmMf746vzVqLxWRsu8QSDGuJgSik4+lf1xmny5
         Pjgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780053040; x=1780657840;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VwGJ1aVISsmjGLnoNcjoGKPnok5e19Xi0seckWEDRu0=;
        b=PDy6JOQx9aWDrk236LrHqQDxOOeYIDi2MlvYUcAr34zmN7IoUhWSvBevCc5j02f175
         nuN0kyafStdQ5Ht5V0+abT0XgucYhhOWMR9UzA5pUulWgP3qVhXp5BGuXNnwiizkJO2Y
         cTQmtM3csMr25sV9YyJh3PwsWkiVaekTiUsBR8M/qk80r2zeVI4+AeA10Pz5VC+8GVOX
         uop+n0PIS5DnxuGItCxqGklJnolkBCUXBSiGwrnkqDnLm8LudJWnFRn3SdETThzxfjxF
         8gR9v5onP8nBQau29RYs6uUHRDNmn8GwPepn7aXLRlEebOVXh80U3qVHwl1479/fO7rb
         4jiQ==
X-Forwarded-Encrypted: i=1; AFNElJ/Oq8ThQ+sthJ3i0lMfyq6dPnfrLjS2Pw+mW6UehtWmSvrLn8viycQ08hVj8n85Q47cGMpaXMs/IaA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUmbHJnM9Ls95jxPr00t4WSwkPs44YO7Pqu6r6Zk550TBFUvR1
	jnuRvVxU+u5zvUZhaiQU4hWxEfnNtUSD2P3IHK1Ukc8AqgXUYmUp6eZGDFmjP9UTuEg=
X-Gm-Gg: Acq92OEYe+KqmhHKV0JROFvpjlrjYCSRlzpUCgMYaJvHObUWDuOtAr+GqLyDoANfw8O
	hhjuBU5R75pu+YokhqQTit8z+e5VpN2Ylw2ayT/d11KZbntxJI6s7fJTqKDTBiLlhWMOA1KorDb
	Fuwb6lPaJDSwMmRkuqHQfd0Vzunvog9P/J95gQqN9SmKiTZh5FOq/hmX/dt0mgiSUg5PGHudtCB
	02MYlh3xVeX464cgkcBl6eRRlmFb+5c2UgkF2lTT/IQ0wE58oI0e7hCgL5wk9ZahSa3pp97Xj6J
	6q7L4ZSyQmWZI4jcp/WiU/IyB8tC1SRam7oC1jfvxIRgWF7SzzAUEhOHjEcwTZQB0LCRaw54cYX
	b2hlKZbQw4pX5pTPhoJQOsCUJ0yjxEQxFL6+K1TtiaXYfyJFsebUR6R19eFo+X1ISEGS4oi308+
	SE/UlI7GMqIDR30bWOuombDUZ9XKyE43CSF/zz3cdoN3gPPPrRPGKNynFj4fgOmFueh1weqUa1H
	tPmN4XpXualMol8itPI5bEJFBq5H0d6sE8T6rLBDUMPA3XBCxUx6ZrEn28R1ea8iF8jua1UYjqC
	yoJ4AAjMRPRBxtMt/N2aR90Ly0dTtA==
X-Received: by 2002:a05:600c:4595:b0:490:52fb:12dd with SMTP id 5b1f17b1804b1-4909c0a4c85mr41540435e9.10.1780053040047;
        Fri, 29 May 2026 04:10:40 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909c103b98sm11912765e9.19.2026.05.29.04.10.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 04:10:39 -0700 (PDT)
Date: Fri, 29 May 2026 12:10:37 +0100
From: Daniel Thompson <daniel@riscstar.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Helge Deller <deller@gmx.de>,
	Johan Hovold <johan@kernel.org>, dri-devel@lists.freedesktop.org,
	linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v2 5/6] video: backlight: lm3533_bl: Set initial mapping
 mode from DT
Message-ID: <ahl0La8OQHXAlV3m@aspen.lan>
References: <20260528135123.103745-1-clamor95@gmail.com>
 <20260528135123.103745-6-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260528135123.103745-6-clamor95@gmail.com>

On Thu, May 28, 2026 at 04:51:22PM +0300, Svyatoslav Ryhel wrote:
> Add support to obtain the initial mapping mode from DT instead of leaving
> it unconfigured. Additionally, update the linear sysfs code, which uses a
> similar coding pattern.

Words like "additionally" in a patch description can be a sign the patch
should actually be two patches. In this case the patch would be a lot
easier to read if you cleaned up the linear sysfs code (patch N) and then
added the new DT logic (patch N+1).


Daniel.
