Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA5C3A6418;
	Sun,  4 Oct 2026 16:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791131249; cv=none; b=EfbAH3L8qhvWJEdNTBpjedw9392kGftE/W/dKUyat10Lh+qi2hhU8mggjT6iHUjfZ8FKqQetqrDUaBgJ73RIwg4LWWBAtZayxwsbxlkAXLqXFTjFE+YAnh0XNuSvrJZV1B+ZDyApwWNzYeSritPYbrLnV3t5VlRxTvtn0LMNcSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791131249; c=relaxed/simple;
	bh=Z4gCoAWckmgDXKou2oJF9djMmcXIf7DvsNo6VGAidRw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jP2cwd2IjM0OIBpsfvd1jYRhl6F9+oYSxR5FCDH46xZQdlW3wJ5ZodD99YtGdRQ6lK/AjZF/lyB8jo8H+Dynu+BAZ2u7M0eL7TMygQV7tbq0LZy4bDAzHFEwjbzb2f8qngoLFsIZul4PJuJwDTZd7sSbR0CCk5t0AesdYi6u+pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DLSOFFNh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DLSOFFNh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ED8A1F000FF;
	Sun,  4 Oct 2026 16:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791131247;
	bh=M/dSWsxmcXiuwTULb1QxS7XuqCbQfn/jziyewxOKFzU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=DLSOFFNhJ0lM/4jB6UuInsPixhP8D/lP7HPyKN0CNisPUXCqePbMFy7/IR79CgsME
	 yo10eANrpuD62ulR9+7YRkwNLsRu+IhmdJ2enM6QHVF/Cf9S4BY39O+0aqor/bFNrx
	 fi/hFpMVd/R80IuMy0kOKDZ95MGJq+ClI7DRwBwqLX/p6K9L0bQGWhzPbwV976vP6w
	 ZJ6TraTCP3VRGyhx5x9hm07EDa7BNI1RYagXBfz0FT9+E4RDRbvkESM1KUWEpMNvxM
	 i3hggNTAfF7bo/KhhA582376EuMpydogjtC/F66Btn35ZnOBZbF+/Y+9205M1YxhBg
	 Qjl5Xa0cmcb9Q==
Date: Sun, 4 Oct 2026 17:27:21 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: Arka Mondal <arka@arkamondal.net>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Michael Hennerich <Michael.Hennerich@analog.com>,
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux@analog.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 arkamondalofficial@gmail.com
Subject: Re: [PATCH 4/5] dt-bindings: iio: dac: adi,ad5758: Fix the 4 mA to
 20 mA current range
Message-ID: <20261004172721.72d6d42e@jic23-hlaptop>
In-Reply-To: <20260928193449.GA408126-robh@kernel.org>
References: <20260918122032.134947-1-arka@arkamondal.net>
	<20260918122032.134947-5-arka@arkamondal.net>
	<20260920193949.45606414@jic23-hlaptop>
	<20260928193449.GA408126-robh@kernel.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 28 Sep 2026 14:34:49 -0500
Rob Herring <robh@kernel.org> wrote:

> On Sun, Sep 20, 2026 at 07:39:49PM +0100, Jonathan Cameron wrote:
> > On Fri, 18 Sep 2026 21:20:31 +0900
> > Arka Mondal <arka@arkamondal.net> wrote:
> >   
> > > adi,range-microamp gives the 4 mA to 20 mA range as <4 24000>. The
> > > values are in microamps, so this reads as 4 uA to 24 mA. The original
> > > text binding described <4 24000> as the "4 mA to 20 mA current range",
> > > and the data sheet (Rev. B, Table 32) confirms range code 1010 is
> > > 4 mA to 20 mA.
> > > 
> > > Add <4000 20000> and mark <4 24000> deprecated, so existing device
> > > trees still validate.
> > > 
> > > Fixes: 777baca07ef1 ("dt-bindings: iio: dac: Add docs for AD5758 DAC")
> > > Signed-off-by: Arka Mondal <arka@arkamondal.net>  
> > 
> > DT reviewers.   Better to paper over a dt that is specifying the wrong
> > range as this does (deprecated) or just make it obvious by failing
> > the binding checks?  I'm thinking failing is better as gets any such
> > dt fixed up faster.  I also suspect no one actually it this because the
> > disconnect they should have seen when reading the datasheet and considering
> > what they wanted should have meant they saw this bug!  
> 
> No in tree .dts (for which I don't want more warnings), so I would just 
> drop it.

Works for me. Arka, please send v2 of patches 4 and 5 rebased on my togreg branch.
Only change being to drop the broken parameter both from binding and from the
driver.  If anyone screams driver side we might paper over this, but they really
should have noticed the value was garbage when they wrote their DT!

Jonathan


> 
> Rob

