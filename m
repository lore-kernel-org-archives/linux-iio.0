Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D3CF9C0;
	Sat, 15 Aug 2026 19:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786822409; cv=none; b=BtPcCHe8tlg0VtnZUNjXePooBzd+IYtXTsrjcZU/ZJI0cK1THUOXCGxgfIm8RKmvCBvFxQIM1ItjvuTyfxiowYM4yEgeCyrC2OH+34Uc78f79Xl/Gmw32O63lRCIsEhJDZDKnto9EBsdHDWIL5O//cjXcU0xsabexuQDR19gvyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786822409; c=relaxed/simple;
	bh=740ZsBSRNdQ7eVvwayJQa0Hzeh/lzlQt+x328SlZpmQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hGXWHJ10zZEv95CGFPVQKe0WI+18FwSzdIQJhBx+L91gAK5ZKfQ+KlQRw/KF8hLyJDT0HdH0uFv3KXSNvy/y2VOqTzruKfeok88CvCOD8EmXGj3y5eJW/2cEt5DbzZvmMFoJ4JuhW4zmGoTyi68yVLH06/bbS4jfrtUA1k4K1Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DMK+1BJb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DMK+1BJb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC2221F000E9;
	Sat, 15 Aug 2026 19:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786822408;
	bh=I5Yh7x8Pt5usGYhUmGQHISP6sbrREFiI1VOt6YxsRrc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=DMK+1BJbf6QJ7c1JVjZ+KHzsxjPbmES5wd4rWYBoQvgr0vL+kp4gyjSulX4Ho+fj4
	 g4BVNLyJLOT4bgXEm4VHb1W+jO1ncbJhbxCXPm0ZzbiFnDD2X7kZezAht7ZFT1esYR
	 RVuY2A1K/474+/EPpZTSDnayGxJ/HD4HBzt2Kpt7U/UqZlZ5To2tnxufAuXuYCfD5O
	 fTMLrmobhHAQj++sbsfZDLg184jW2G3gRvNnvw5cA44K4FsRoc7A8VP7J0YUzIQ7Q8
	 CtuTw8VcamF26u2RDtW8JJMjmBzkuDfH7QVQdT9qwhIpxG/uPkSpQ0ZXFlD9OLmdzm
	 POtycuOAKyQVw==
Date: Sat, 15 Aug 2026 20:33:25 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Esben Haabendal <esben@geanix.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Martin Kepplinger
 <martink@posteo.de>, Sean Nyekjaer <sean@geanix.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Martin Kepplinger
 <martin.kepplinger@theobroma-systems.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/6] iio: accel: mma8452: Support interrupt sharing
Message-ID: <20260815203130.7699cb60@jic23-huawei>
In-Reply-To: <an7NOEOw8Jn0id0N@ashevche-desk.local>
References: <20260812-mma8452-open-drain-v4-0-bfca15d02b59@geanix.com>
	<20260812-mma8452-open-drain-v4-4-bfca15d02b59@geanix.com>
	<an7NOEOw8Jn0id0N@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 14 Aug 2026 11:09:28 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Wed, Aug 12, 2026 at 04:30:35PM +0200, Esben Haabendal wrote:
> > Adding handling of rutnime PM suspension in the interrupt handler allows
> > sharing interrupt with other devices.
> > 
> > Keep in mind that the device by default is using push-pull for the irq pin,
> > which might require additional hardware design to allow interrupt sharing.  
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> 

There are a few sashiko comments on this one. I haven't looked
at them in detail - so if you think they are wrong feel free to say that!
