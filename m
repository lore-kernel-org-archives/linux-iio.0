Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37EBC3A4508;
	Wed,  3 Jun 2026 14:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780495741; cv=none; b=XdPfsOiWU5NWjLPU/kWJ77Pl1y6CVop7Vw42wwulL8XuKZQJ8LiE779lIRG+/CRsmg8Xzq7lOibl88n7ejES+jJybpfHhHj7bsh7f/olCxoRm6iaP75WukOxlILfv8becJ5Iit3VKk6fy8poOEGp9uzlz+MbCTraos6Qs/Su+80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780495741; c=relaxed/simple;
	bh=DuYA+zryREOTpzvWbVuU5xKiHGO1c5cwqZ5Pa/942cE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W06XNbmRW3bK8wSpgw1HX8d0vC+uAEksDE1UVXzdxMRyeXEBrBdfKyTos2WsVZAiEdl85MI8yJD28kkLn+CAA2KA7jMN9JW7i0DyXWJDE7QpPJ8PMx1tnWdZrxSBzq7Z9MnsZmTO4+DDep2lNWiAZpScbzWoiRZEpupLrL1G01I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YGcPpNOS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YGcPpNOS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 064531F0089B;
	Wed,  3 Jun 2026 14:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780495740;
	bh=nedUuBVMO/4KT0zZSmnalelQp4OIIOUUzQFp8dGHid8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=YGcPpNOSslUBVE4uF4h8ILATB+vnMIEBxOBIJBjBuXPl/B/DWrnmdzFUX6dG1sr7D
	 kAwhqSqoPpOy7Rb9cn1JqCDepETQCmxhW6tYYews0XYXztDdausBi2p9dp4OSuLGdF
	 sCgNxTm+STRkzshXL35NnzfSpYrzrTW9irWoRtAwKOdgtvcpdh3eevOJt9tYRTNNEv
	 q3cF6of+NlkT+bG+1XiEbgMOeIwNDUiSNeOcEvrFglNGlOkxuSUKXSZ3f5uJOCi1wi
	 +Fo9zbDMgpZ9m5H8CiDjZfik0RW85eNHxsK2Ka+Yj9qtpb5U4QXeUOboT4SOQveF77
	 br6nhtKvmmPgQ==
Date: Wed, 3 Jun 2026 15:08:48 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Liviu Stan <liviu.stan@analog.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Antoniu
 Miclaus <antoniu.miclaus@analog.com>, Francesco Lavra
 <flavra@baylibre.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux@analog.com, devicetree@vger.kernel.org,
 Joshua Crofts <joshua.crofts1@gmail.com>
Subject: Re: [PATCH v4 4/9] iio: temperature: ltc2983: Use local device
 pointer consistently
Message-ID: <20260603150848.6060dc5e@jic23-huawei>
In-Reply-To: <ah9mbI8j2WhaneOe@ashevche-desk.local>
References: <20260525164013.118614-1-liviu.stan@analog.com>
	<20260525164013.118614-5-liviu.stan@analog.com>
	<20260527171820.4cbf10d4@jic23-huawei>
	<ah9mbI8j2WhaneOe@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 3 Jun 2026 02:25:32 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Wed, May 27, 2026 at 05:18:20PM +0100, Jonathan Cameron wrote:
> > On Mon, 25 May 2026 19:39:31 +0300
> > Liviu Stan <liviu.stan@analog.com> wrote:
> >   
> > > Some functions define a local 'dev' pointer but still use bare
> > > '&st->spi->dev' in some code paths, and some don't have it at all.
> > > Replace bare references with the local pointer for consistency and
> > > collapse some wrapped lines that now fit within 80 characters.
> > > 
> > > Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
> > > Signed-off-by: Liviu Stan <liviu.stan@analog.com>  
> > Applied to the testing branch of iio.git.  
> 
> As I said, this has to be split to three patches.
> Can we drop it? Or is it late already?
> 
This only seems to be doing one of the 3 sets of things you suggest.
"
So, this has to be split to three:
- dropping dup message
- moving to devm_kcalloc() and at the same time define local dev in the probe
(and only in the probe without changing anything else)
- this patch
"

The argument for the ordering is small. The duplicate message line gets
modified then dropped - not ideal but not a big thing.

The devm_kcalloc() isn't in here.

Given where we are in the cycle I'm not keen to back this out to get
the ideal ordering of changes.

Jonathan


