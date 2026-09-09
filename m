Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495E0563FA3
	for <linux-iio@vger.kernel.org>; Wed,  9 Sep 2026 13:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788961535; cv=none; b=ZwdYVQdyQcJqfwZ4gkwac1BkPQcbFWB7L9ODz0b8mCoacYP9w8ferC25SmvhWtl9+p5CeozfaGwsj+JC+5zbc3DKqC9t8WKDt5esn6fkFlSeYrEhvYjx7p73GK5fnJ3DEj9uUmwxX/C6WLWxtsrCsUyMNJQwWBKktle+gz2wEAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788961535; c=relaxed/simple;
	bh=i0VT1OqBwdS71Uf2IVo6PfkEcn4RaE4yYClA5DJrApM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TR1GsOfWg/uRS2L+rwRIBRnD8ZQCLxHJ+xPq6D4TInrf83kHkfNeKpy/lzg7Be9rHTsdjlAlLVnjjJKqtTTqi8c4raUZizvasowaQQNsMJ7cXrQc5Sgbo8Xa2dfgMDDXgvWqmLK6toR8VQoywQv6aXmOm8bpvOoqBSdPztjyzKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f3CzoA5s; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f3CzoA5s"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-49d05d51553so35609325e9.2
        for <linux-iio@vger.kernel.org>; Wed, 09 Sep 2026 06:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788961531; x=1789566331; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=b8YKB3/dJvd9GLizbpdWgBqtE5BIptbKHlbLLtYjluU=;
        b=f3CzoA5sQghKNhyeFM0SByTb417WCMUIosqI9SPLPTaFsENGmWVMlyNfajctG1FJOA
         gjqLXKsybDbQzNB3v3siu4ydu1oEz/QMeHcQoZgOK1I+RkNkMidEB9v9CfwA/6Y/ze6b
         uR+Go3acgcl7gw7GjmpEHyN3GVXOh2SKLtd0LZBunrzsbvkVEaY25llAzbdChYHzyJCG
         oOfPvu7QrBeZ2/HepX/0mrWPXUCEl3ZMOnRrl2peLFtNIvt8F3fmhE+0rtQdftTMMhCb
         BcanwuhEyQkzLaQeF6rzgp4yalzfMV+Iqo6qAlNV0v6T6Bby0RrM+2sFc5Dyb5K8P2kM
         7NJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788961531; x=1789566331;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=b8YKB3/dJvd9GLizbpdWgBqtE5BIptbKHlbLLtYjluU=;
        b=Qc6oVRKcIQhUFG1CtegHH45ZGsH7l80fxkXtqhdWukOIh0zaoDGgQ4DcLrEvmIVcnC
         ho0UBabEw7wF7QACe9Ax2R5CigZI6yxchI6zlfgiM6D1+m/bP2XEFO+klD/p+iHe8cXV
         KpZsXYyZpw0AR/AC4fYh+RvN8FqhVbESVLAGvWTVoDBMo6DklIkK0rx6k4Rk7JMLa3O7
         lnpXxFAFw9vOJJAerDD4hDeHjzJbgvLWpuJ/8up32+PxrAFN0YCaFQ2PSouqM3KM9OZT
         MGYAMEPFCZ3/VRm81x1RLcfkpNl70Pl/ZypRmRd/tXPtdiwHwdNAlW12T9y7SGg0VUh/
         9EXw==
X-Forwarded-Encrypted: i=1; AKwUvBwVayJ3HU/vExOhAKkxQ31be5OxTb9RnLY2BHz2snRnu9bBbvU+woSTIvfmxHa5xk3zswxt6Q22N84=@vger.kernel.org
X-Gm-Message-State: AFuF++ni5NwvOAxTyzbs/D7X19fzZ9OJLgcj4CPOqFDoKf7hDou+AwYQ
	rjlkFP51mVTMIE3gab/+Wuk5Prr4p/ozL77HtgbUuABE79Klb+zBg5oq
X-Gm-Gg: AYBFou1MNw2vUvsTur+a7DNOA4SBvyGTKhG3IhC+xRO3+BNouNcHlGw83Adh5jtmqsh
	W9Alrzz+XyxJjiKypbuXQLKfU5MCdlCK5HPdBZCxAGPVCXF2jtsno61GV36jKc7iUtWxF3uV0qS
	/SVisOfbNe0wniczs5F3CzdaQpWWwGC1BlbFWhku3jO6iM+6o0nnT0Iy5BduASYW8CZR+lWMRYb
	CbdYf6n+gDcvgu/5a07mF/nV05UvSwKfdB90wqDx0Yqb/7uoLBJmmuDIRliUN+yxle1laMel4x/
	BrHIhM0Dqbn8qoBuFq94l1UB0d93DKXS5IjsH75l9UJbLC/wPblsbA4vMCOdabuUgebqUSD/1qJ
	7K6eYx2mF/THoe11dr3Rt+1J4p00LkobRWFZ+MZkCYIKA/gNAars1pvqsFoK/ezI5DxzuDTJJNj
	ORZDGPwwkET/RjLgtTaAhgIjqvt5EXBc4mP4RIiL2XEhAH0vsLjJB7s5Kd4PKQRxX9hEO3JNZvq
	HCd5lmuG8JfMtjfLfc1Xu35d0rK0CyCbBv0xOkg112VPhKCbnP43wjLqSpvzkwai2w8tqOiaEBr
	VD0ZJ8807Kn4/eAAjsNXa2l+sjRHooKN1vrXbHNdN23DtHexBHyFgrJkCaZT5PoQTtBj+/zRJZI
	WPRTLMirSMARzDLox77RR0Y6BAWO6giCDVr3ltrFvyd4pwZ1jvCOYKl7ru3NQ89e6mkeR1z3uXS
	DUvGmT
X-Received: by 2002:a05:600c:8b88:b0:49c:fc6e:a3d8 with SMTP id 5b1f17b1804b1-49cffde8d95mr318555215e9.23.1788961531014;
        Wed, 09 Sep 2026 06:45:31 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485883953cfsm36848889f8f.13.2026.09.09.06.45.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 06:45:30 -0700 (PDT)
Date: Wed, 9 Sep 2026 15:45:26 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Kim Seer Paller <kimseer.paller@analog.com>, Marilene Andrade Garcia
 <marilene.agarcia@gmail.com>, Jonathan Cameron <jic23@kernel.org>, David
 Lechner <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH v2] iio: adc: max14001: add missing MODULE_DEVICE_TABLE
 macro
Message-ID: <20260909154526.00002640@gmail.com>
In-Reply-To: <aqFhagdhM4Z57eqh@ashevche-desk.local>
References: <20260909130304.1395-1-joshua.crofts1@gmail.com>
	<aqFhagdhM4Z57eqh@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 9 Sep 2026 16:38:50 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Wed, Sep 09, 2026 at 01:03:04PM +0000, Joshua Crofts wrote:
> > The MAX14001 has an SPI ID table, but does not export it with the
> > MODULE_DEVICE_TABLE(spi, ...) macro. Because of this, SPI-based module
> > autoloading fails on systems that don't use devicetree (e.g. via
> > spi_board_info).
> > 
> > Add the missing macro to export the alias information.
> > 
> > Fixes: 59795109fa67 ("iio: adc: max14001: New driver")
> > Cc: <stable@vger.kernel.org>
> > Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
> > ---  
> 
> Changelog?

God, I should start using AI to check my patches before sending.
Appending below.

Changes in v2:
- edit commit message (expand on module autoloading and SPI)

-- 
Kind regards,
Joshua Crofts
