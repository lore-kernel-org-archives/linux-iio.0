Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A2C299950;
	Sat, 14 Feb 2026 17:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771089879; cv=none; b=tTeE+DIktezYDStwTzGD1kg225b2Jui9YfA2e2Z981mTJp9o2Fb2AyplddwPNYPou8Awflg0Uo2JMz2HSUemt51sM5UltHlM2qBFWW4XXDAHZvsBufYsE4PuhfF6nliuJKHAQBVKhPc1SWDyAp/cdOYHvtsREpaE8BskblhNLks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771089879; c=relaxed/simple;
	bh=55R8VS4W3Nw5PtJ9oaFQmCCjycBecJUF2P2c8LC/UNU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NKVw+HP86Lk/bN+Di8RPQ93bmBfb+8zMPKwH/TlTrsQEEQQn6yEp5FftX5C9YqlCgoQln4yF/ZIFJb6y7YmRd9gtVMOOjS+KPXIvEE5QcK1THvZ3uvAXbF2HME80bRDtI6gqYTJ9kQaQk1COpi+1Y7meVnTElqdYL6AyvqIDM4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V/PlZ0/d; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V/PlZ0/d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F3DAC16AAE;
	Sat, 14 Feb 2026 17:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771089878;
	bh=55R8VS4W3Nw5PtJ9oaFQmCCjycBecJUF2P2c8LC/UNU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=V/PlZ0/dLy5sUQkaptpbhuo5AUTPiokBB8az0asj79X0PF9FVQWcrv8ngDGyZbl7+
	 gariAz5/iMWXM+8coPUX33pBguphydLV8Lic/qPJQDNP1Rp91mUwvOSrUZzjuHdJeP
	 vPlcEjoFFqYyLKIQPppY7gmTpCMURDZdVoo+B27wcF6uvYVCqB6FAfDvtFmeQl8Lkt
	 KPBDZQzEMA1ojCXmII0IsDbCqDbZckp78sjDYEWzjcXxQB+vy3DU0bNgaexzPMgAs1
	 rRQ0ZuAE/EW9Mrrhtp2du4IKoeRisvn8+xUzdJ2bisE6spmcl+jhDJOYCZHQfTyMG7
	 4YOmLJ0BWUvEQ==
Date: Sat, 14 Feb 2026 17:24:28 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Yasin Lee <yasin.lee.x@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 yasin.lee.x@outlook.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/5] iio: proximity: hx9023s: fix out-of-bounds access
 when copying firmware
Message-ID: <20260214172428.480af8bb@jic23-huawei>
In-Reply-To: <CA+NOmzKZy=8WhsN6w3B195pp10JunZA7ZVjRmwD21Q1CeOBYvw@mail.gmail.com>
References: <20260209-upstream-20260219-v1-0-2b4d74e309d1@gmail.com>
	<20260209-upstream-20260219-v1-1-2b4d74e309d1@gmail.com>
	<aYmeoZIlY2HCueKO@smile.fi.intel.com>
	<CA+NOmzKZy=8WhsN6w3B195pp10JunZA7ZVjRmwD21Q1CeOBYvw@mail.gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 11 Feb 2026 00:35:19 +0800
Yasin Lee <yasin.lee.x@gmail.com> wrote:

> On Mon, Feb 9, 2026 at 4:45=E2=80=AFPM Andy Shevchenko
> <andriy.shevchenko@intel.com> wrote:
> >
> > On Mon, Feb 09, 2026 at 11:37:02AM +0800, Yasin Lee wrote: =20
> > > Initialize fw_size before copying firmware data into the flexible
> > > array member to match the __counted_by() annotation. This fixes a
> > > potential out-of-bounds access that could lead to a kernel crash. =20
> >
> > Fixes tag?
> > =20
>=20
> This is a proactive fix for an original implementation issue I found
> as maintainer.
Hi Yasin,

I think there is a misunderstanding here.

The fixes tag requested reflects which patch originally introduced
the code with the bug. Its separate from Closes tag for which your
reply makes more sense.

The aim of a fixes tag is is to allow stable and individual vendors
who might be carrying your driver to figure out how far back
to backport a fix.

Jonathan

>=20
> > --
> > With Best Regards,
> > Andy Shevchenko
> >
> > =20

