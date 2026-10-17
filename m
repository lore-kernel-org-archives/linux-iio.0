Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444484CF49E;
	Sat, 17 Oct 2026 00:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792195880; cv=none; b=tkYV3nvvz6i/c+KoeoSTm/wPKby2xEYXOPQdK4VfhH0w0liB6n/XToF0t1/qM1adnb07HUk2qZkpP30+jn3OR8tBJJ0FDTZgKExcMlpR0uZHqC17Y4rTyK1SDucFNefiE/XWi87kxrzrHrUDpBOyb4Dh8sYith0l31zQ6p2I9xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792195880; c=relaxed/simple;
	bh=S3BpuTcncoPRKYSf6BgBXL672v4BfbKAtvOGLJAoJ7U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nPwfhUtaiNZOO6fplK/3LAhX/W5i756bZeAtx2aV89Lazp+cqWTqCmcp/Cg9n4n+9ym0nod0h4B1uC3710MelBCfQWGhiLyKVdrP17cxNH2oBogPNQN0wwjWmuz8RPg8ERVM++Jw/2amFiShclOtSsHEUhQnUVNLs8j0klgg3hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DKmM3ZJb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DKmM3ZJb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0E3E1F000C4;
	Sat, 17 Oct 2026 00:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792195878;
	bh=4RCS+7D5EoxWLvekx7aj1PEI8tkTociXq4Yd/Tif9ds=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=DKmM3ZJbmn0xTq8P/v65KiDBsU7TgZ+RXl6EgUk/ILV+7RgXU06nWo3iPBA770HPU
	 ehUq/SFdZ+G1ngrLveGg8sOw7o062KDnZH5JQXqxBMDno8bUv+sajpxOb+nniqxIPD
	 k1FJkaZ/TS8zpGH8OJt5pVkilnfm0Zyxp1X6PSCGMbFqwQsYZ24bol1Y9ivBpktfFn
	 YcD4KlgBFBiiVwvbuAqvEKuc1g5K6mLIBcl/kbTM5DFyhT/X0mmze7anESNoSwz0J4
	 f4x27kAA9/trc/am3VTLmE4yIbxGZYQRgTPWRS9B4AKv5eGmsCIrkE0QNijW7j4XDL
	 BYcG9snPzQoZg==
Date: Sat, 17 Oct 2026 01:11:14 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Shehryar Ahmad <shehryar.amd@gmail.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Michael Hennerich <Michael.Hennerich@analog.com>,
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>,
 linux@analog.com, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] iio: accel: adis16209: add missing SPI and OF
 matching table
Message-ID: <20261017011114.0597062f@jic23-hlaptop>
In-Reply-To: <atIn5M6l__WKsjyv@ashevche-desk.local>
References: <20261016114527.128364-1-shehryar.amd@gmail.com>
	<atIn5M6l__WKsjyv@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 16 Oct 2026 16:34:28 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Fri, Oct 16, 2026 at 04:45:25PM +0500, Shehryar Ahmad wrote:
> > Replaced old manual matching via MODULE_ALIAS to modern SPI matching
> > table.  Also added missing OF match table for DT based probe. Compatible
> > adi,adis16209 is already enumerated in
> > Documentation/devicetree/bindings/iio/accel/adi,adis16201.yaml  
> 
> Both LGTM,
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> 
Applied to the testing branch of iio.git which will be rebased on rc1
once available and then pushed out for linux-next to pick up.

Thanks,

Jonathan


