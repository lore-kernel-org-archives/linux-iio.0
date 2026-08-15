Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD631B87C0;
	Sat, 15 Aug 2026 01:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786758612; cv=none; b=Kx/kP3ARghG4hddWXk0oiWEj7gzcXw6T4mu3NPzXeeTWhJ9Qa+eanddjbEY2jpNdz3ihVmeTJ67j183CA8utrZXXUR3EhffZ26qGeKqsqi8e3lwWqYY3fHWzkw+RyJBm0G2Usbdsto3N60kW3+cep8qhiTb4ubtuJdCIWkXtEq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786758612; c=relaxed/simple;
	bh=OC+2rLmgdtdiM6IH50iRNE3vyDDiuAg7ntOEwOiFsHo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PNPloTE98zLSmN+vu0Xf1Ph2kwpT5iQGdXpOYtkUY+aq7m5GtZpOuZudEsZV1rxPUAlZ+aGKAcASjHapBxoSOeauvQbndlbh1UdfcQGh9Y6Am5iw06qB0kCpJcpBJF2/Apn5QHYrfCIRTXgRu81BRDnSmO9KgDcnQ34nOaL9dH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W+WLRV4F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W+WLRV4F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 978641F000E9;
	Sat, 15 Aug 2026 01:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786758610;
	bh=ypH4yKyAk/pJH123N3O/sqv1uP1nyrfrsBdWm0d36VY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=W+WLRV4F20VcooCsrC8/7Cjf03Th7CgOf9PWVDkOwkqzxFXAy/lQRYYV4ep1Tm+pI
	 iyEubOSK3u519Ncr9ERMyBnnUYKeN1ll98sfOCYhRhaxoi8HbqmW6/6rOeuuuvcIa9
	 WbEmQ9DCl4kogtdd6QtzBhzOqqKMi4VpQecMoP9aNHb6Xo0lSYDkHpqSCxJbVVxd96
	 RVDgSEBOoZAX5RKAAs1PSen88QHww8B49HeKo1EtwaQL18lWpwnAcxg2LA1rinLtX5
	 eRM6Ugk6pDyKMt/DOfhTm4le/yV6dtlCKFlXM8f0Hdt5PuJBJI3hgwBHfsaYqujSkG
	 myj9GG5mDPmKw==
Date: Sat, 15 Aug 2026 02:49:49 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, Jingoo
 Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Helge Deller <deller@gmx.de>, Johan Hovold <johan@kernel.org>,
 dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, mfd@lists.linux.dev, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v6 02/14] mfd: lm3533: Remove driver specific regmap
 wrappers
Message-ID: <20260815024949.110c2ef9@jic23-huawei>
In-Reply-To: <20260731113632.158440-3-clamor95@gmail.com>
References: <20260731113632.158440-1-clamor95@gmail.com>
	<20260731113632.158440-3-clamor95@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 31 Jul 2026 14:36:20 +0300
Svyatoslav Ryhel <clamor95@gmail.com> wrote:

> Remove driver-specific regmap wrappers in favor of using regmap helpers
> directly.
> 
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> ---
>  drivers/iio/light/lm3533-als.c      | 79 +++++++++++++----------------


Acked-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
