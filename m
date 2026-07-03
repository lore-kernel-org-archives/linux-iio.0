Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B5C37E2F9;
	Fri,  3 Jul 2026 10:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783073523; cv=none; b=ozqecRSsPG8sWILnLUKF+uUuCZm8PW3XxH26ikbs+ajtL+BPzs++oKsnb4a+PwfDgM77+3//u0kKXwiPAGcoeds3gj0jOsprdqNi+o/sgX3ufHsQXeSsD+uNIbN3z+gaa8vPg0IHqbfJtseFPpkApxsKybqB/lc6i2cuoqZAZxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783073523; c=relaxed/simple;
	bh=xaeLw9hijM3wYnYy2PwnW+fADz/zDVkwJHwP4OJMsGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W1KMb6V9HgGLFudGvGmC4hoy3Y8mwsXoSVQ3CvV7mug9+vZFb5uqQlyz3bXm9F8fEIrwFIJmNiXDZvLa++mv4buniHPjwMfU78kPbV/KslU9pebeTz92o4g3VJ2J5lNPoEx+lkbCBbfjmGqf+ihE/ikkpQYwavA7B3oputdfWoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZVjN5mZP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZVjN5mZP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 436091F000E9;
	Fri,  3 Jul 2026 10:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783073522;
	bh=m3dzBCdMVP2Co2+t3pO5FRa/gNVqzVGpE8QphSLUvgw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZVjN5mZPl6Zx3xBjHnV9r6Kz83oN29zpkuKOWTUMV3CtchXJZq5zR2YMvc9GsLSyr
	 6RLxaDlVfcuOLeDj9/E3i/fMXgshO2bsP2ESxkrDScNQoixHBQmkynaxa/IEcL0LcN
	 AR9XsflynI3h01jYcaq3TbhO83l2Y52dvujjrkxkli3nBN4r3iNjHASjAUS1hShOdp
	 8pWzZXP43aZ37Nq6JupfnpMpyMqJxfD3miOVeKZPlah74gxiGPRIlR3a1iwwYUEneY
	 RuxiHi71xKszPSESUXuT+HwFpmFNO/+4n3CW0n1G3pKIxryWVTm0ednc56/LZaTNeg
	 ptd5WuZCgqJiQ==
Received: from johan by xi.lan with local (Exim 4.99.3)
	(envelope-from <johan@kernel.org>)
	id 1wfasJ-00000000iPm-3czo;
	Fri, 03 Jul 2026 12:11:59 +0200
Date: Fri, 3 Jul 2026 12:11:59 +0200
From: Johan Hovold <johan@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Helge Deller <deller@gmx.de>,
	dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v5 07/14] mfd: lm3533: Use dev_groups in struct
 device_driver
Message-ID: <akeK78tkmUE-TDhF@hovoldconsulting.com>
References: <20260617080031.99156-1-clamor95@gmail.com>
 <20260617080031.99156-8-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260617080031.99156-8-clamor95@gmail.com>

On Wed, Jun 17, 2026 at 11:00:24AM +0300, Svyatoslav Ryhel wrote:
> Instead of creating and removing the device sysfs attributes directly
> during probe and remove of the driver, respectively, use dev_groups in
> struct device_driver to point to the attribute definitions and let the
> core take care of creating and removing them.
> 
> No intentional functional impact.
> 
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>

Reviewed-by: Johan Hovold <johan@kernel.org>
