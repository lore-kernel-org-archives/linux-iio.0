Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD1C2EBB84;
	Fri, 12 Jun 2026 13:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781271942; cv=none; b=JvQUdV+36CbFg1n5EHYRezvyNhJ1oLLXNHGcZAg+N+gq/KHi8U6mfPprKUB97QOOKnb0F+z9GcE3B6N9BcztLC3u/GvTF1Yu2U/oESVORoBhzCILfHDg6icIeiNRU/TrAiZCZJIJIsV5faVz6cgO3U0w+4aZDqWzOmXwlJ9mtP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781271942; c=relaxed/simple;
	bh=U+AL8YQxNoixascqa6LFWQb2CdLVd2EEI1v2adAZ7Zo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ltKDWMYYft4HOp2d/i8d6ysc8SPWEMKB0X3XH96X2oMnn95E0JEKrJATywnGfSSe4EdqhHlxzHGpmJFXuR7Qfyy9DEnD5qbwIRroM6fvDCekhwT4mrqruLUDkSxo7hqVigRjlf8bS8vmc+ju2yt+qp5F/ObEPKjkjRvu6E8BOv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iy2YMBIh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iy2YMBIh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42A2E1F00A3E;
	Fri, 12 Jun 2026 13:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781271938;
	bh=sfXcAH2A72IMkIjh42ixGSorgDULhXECePZilDfjQxk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=iy2YMBIhsRsZ036EhK7e3iKAMcv3TUqvSKAVvMw13O0XORiipDJbuMuZwp11hvZPv
	 gMM6SZgE9nqQDbU4B+Kms1HNms/IXpfCHaddl9Fb4+3bAaWV88v96UX0Q0NLRHirsf
	 IsI70taAiPrdWu+WXhlPpKnwX6ARQ+XLgzcl4FADg5k78Z2sKOQwqjomIM2QEONjMv
	 VKlpDllYeWWRlcyfR75xwFEhiu1e33R0kxK4EMDu0DmvTD3VzHk5ubbQKe6U260Zru
	 6Vo/htRGb9KN1WMhA3h3GJra4u4sPex4kHSI3JxRMGZuipML4dFIfKnj38t+tuxc12
	 uChj9r3Hr/x+A==
Date: Fri, 12 Jun 2026 14:45:29 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Siratul Islam <email@sirat.me>, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: iio: magnetometer: add QST QMC5883L
 Sensor
Message-ID: <20260612144529.7521b4f8@jic23-huawei>
In-Reply-To: <20260612151324.0000704d@gmail.com>
References: <20260612124557.13750-1-email@sirat.me>
	<20260612124557.13750-3-email@sirat.me>
	<20260612151324.0000704d@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 12 Jun 2026 15:13:24 +0200
Joshua Crofts <joshua.crofts1@gmail.com> wrote:

> On Fri, 12 Jun 2026 18:45:26 +0600
> Siratul Islam <email@sirat.me> wrote:
> 
> > +QST QMC5883L 3-Axis Magnetic Sensor
> > +M:	Siratul Islam <email@sirat.me>
> > +L:	linux-iio@vger.kernel.org  
> 
> There's no point in having the IIO list in your MAINTAINERS
> entry, get_maintainer.pl would return it automatically based
> on the driver file's path.
True, but I'm not sure there is a standard convention for whether
lists should be added in this case or not.  

One of those things where we should decide on an answer perhaps
and stick to it.  Andy, Nuno, David, Dt folk what do you think?


> 

