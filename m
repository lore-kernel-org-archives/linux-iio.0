Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0331F2253EC;
	Mon,  4 May 2026 16:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777913498; cv=none; b=bdxNhEzdSn7hubN5R2T1jqZwqEHrIIvMDz71J17ei+VStQU6K53dVu6wD7m9W1j7fgYCXaTx9L39jXBegK1Uug/qKAKNbHxEbI2YPkuMj/yZLbK+BhYpRAvMesCyfhqJGt9Jp//pLpaBzsO124QAKD18F/Kw8xOmeN/Ep1G2B+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777913498; c=relaxed/simple;
	bh=582ffjRQ2Uc7xO+mybW8CfmzvW/0hm+vSpZmgcG8WHA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pQeegZAWJEmTOYCMSHw6uCAvTLrnWEtgbwIbg7nSozTlwm3e/H/Hr7Ua7G7z7g/wknYXpl70A1DJ74noCO9b2MuC2xZjamhyQJncRL5o39b99YgJDBxwn8a1NAlkhm4IeD+GVUZFqacyGVJxU5DKNO1xSIkk6liexJSihA8asmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V+wV8L06; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V+wV8L06"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92EF5C2BCB8;
	Mon,  4 May 2026 16:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777913497;
	bh=582ffjRQ2Uc7xO+mybW8CfmzvW/0hm+vSpZmgcG8WHA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=V+wV8L06C5RT90jT8FE5GFQPRbYwdI48y0F1bgt/y2s73vyfWFs/e2UXriCOkrFoh
	 N5zvp48M83E25cIU3BzGp5nQ8gDTxzOZDADIDc7KS/C15oeNUlRpOmdIL4jJqyO8VK
	 gyFMCnBBHAX6MnV/WHrLRBdFPNulgd3xMbk50XZNZxzo9uwRYlPj7A8NglxWz/z1VD
	 ACq0TVNhL/WCS2TgTEk7/76hyVrerjca9lFzwLe51SSQTJaCtopMX0Dd8Kls2yJvx7
	 u56QC7gzzF6VlZuf+oAGZ4rdSLG7PPLs36RPkC5Q+FgBiiTb6V0fxrHMq6VTVEZOGy
	 ARMwvldtUCvnA==
Date: Mon, 4 May 2026 17:51:28 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Chris Morgan <macromorgan@hotmail.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Chris Morgan
 <macroalpha82@gmail.com>, linux-iio@vger.kernel.org, andy@kernel.org,
 nuno.sa@analog.com, dlechner@baylibre.com, jean-baptiste.maneyrol@tdk.com,
 linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
 heiko@sntech.de, conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org,
 andriy.shevchenko@intel.com
Subject: Re: [PATCH V4 01/10] dt-bindings: iio: imu: icm42600: Add icm42607
 binding
Message-ID: <20260504175128.0bfdefe0@jic23-huawei>
In-Reply-To: <PH0PR19MB997338AB2F626D5898BAB27E53A5302@PH0PR19MB997338.namprd19.prod.outlook.com>
References: <20260501221152.194251-1-macroalpha82@gmail.com>
	<20260501221152.194251-2-macroalpha82@gmail.com>
	<20260503-convivial-aquatic-yak-d2dbeb@quoll>
	<PH0PR19MB997338AB2F626D5898BAB27E53A5302@PH0PR19MB997338.namprd19.prod.outlook.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 3 May 2026 15:51:30 -0500
Chris Morgan <macromorgan@hotmail.com> wrote:

> On Sun, May 03, 2026 at 02:18:18PM +0200, Krzysztof Kozlowski wrote:
> > On Fri, May 01, 2026 at 05:11:40PM -0500, Chris Morgan wrote:  
> > > From: Chris Morgan <macromorgan@hotmail.com>
> > > 
> > > Add devicetree binding for the Invensense ICM42607 and Invensense
> > > ICM42607P inertial measurement unit. This unit is a combined
> > > accelerometer, gyroscope, and thermometer available via I2C or SPI.
> > > 
> > > This device is functionally very similar to the icm42600 series with a
> > > very different register layout. Additionally, add mount-matrix
> > > attribute to schema.  
> > 
> > Why adding it? Is it something new? Is it applicable to other variants?
> > If not, why it is allowed for them?  
> 
> It's not new, technically this is a bug/oversight from the very first
> iteration of the invensense icm42600 driver. The driver requests a
> mount matrix using iio_read_mount_matrix and then returns an error from

Unless it's broken (always possible) iio_read_mount_matrix() is supposed
to return an identity matrix if there isn't any info in the binding.

	/* Matrix was not declared at all: fallback to identity. */
	return iio_setup_mount_idmatrix(dev, matrix);

So not required by the linux driver at least.  Probably not something
we should require in general.

Separate patch to introduce it to the binding as optional and say something
about what it is for to justify it's inclusion.  That patch goes before
this one.

> the probe function if it can't read one [1]. So it's very much required
> (and for the next version I'll upgrade it to a required element). I'm
> adding it because a cursory grep suggests that my use case (for the
> Anbernic RG-DS and in the near future the Anbernic RG Vita Pro) are the
> first devices to use this driver in mainline in a device tree based
> system.
> 
> Thank you,
> Chris
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c?h=v7.1-rc1#n746
> 
> > 
> > Do not say WHAT you did, say why you did it.
> > 
> > Best regards,
> > Krzysztof
> >   

