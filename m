Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF2136B061;
	Sun, 22 Mar 2026 12:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774181605; cv=none; b=WYQG+gTTbzssQ7RmNCv+asaPkE8bfeEz4yn3L1wEZ7IVJnnnNHckmMKsotXovxxdOyQqWpc1uVOBC/35ZE8LA2SyFucGWNByXssZcoqg1vw25vvwvMA/Nyh+UUKBCoCll8W7RU8AONM0vxjNpqUvBvMyH882+yiDKOVDl/tp5xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774181605; c=relaxed/simple;
	bh=QyRN17cuwQMcm6t/hXJbAttKHgfyFGCtvWvlWFFC3wA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=exMtOF25ryKPODBlFaz104uhsya5peQylxyn1M0+Hekdu/Rzk8T/Sy4+g3kXxtCSVFsDxPch+v1E1R9wVYz7jEQXP0Z+0j3B41pg2/M95V7OiMAQcVY6KKXNA80nHVT/jV20GE6HvaaK0KwhhJ75sJ4BP1LbJJDn58eThY7zhq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CCXhPJ/u; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CCXhPJ/u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5712C19424;
	Sun, 22 Mar 2026 12:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774181605;
	bh=QyRN17cuwQMcm6t/hXJbAttKHgfyFGCtvWvlWFFC3wA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CCXhPJ/uPTtBHH5rjPN+eJN0nAQloYX5nzpm67/74uzwr5RiZHIcpXCtw9WVpvQh7
	 Lo3Xs2zfJdTZqaDaimd+g79wxIv1gNpscTS+R7hEFZm6jNFgbCJRiMozMXXrHz1kjK
	 CI71qS+ZwgtuKKBhfqjtYa9P+p2od18L2rBU3axPAbsnbKtDhmYYgCS5YLyP1LFMwe
	 bJKNRQRMEQuaG+TI8UXlAxJSgnpBeV4UyaFiNocC1TpfgKghW2YvC2U1sI3vYzzKLd
	 qhY/EF6tQpCQd2rhg1m8/8FvO+N+6aISL6Czgj2yLEGCTmqI2+pv0M7r2nx9m4gEbz
	 O5wbljcwKYIlg==
Date: Sun, 22 Mar 2026 12:13:14 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Ammar Mustafa <ammarmustafa34@gmail.com>, Alisa-Dariana Roman
 <alisa.roman@analog.com>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 linux-iio@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Docs: iio: ad7191 Correct clock configuration
Message-ID: <20260322121314.0143bda3@jic23-huawei>
In-Reply-To: <aaLIhgJjrNlp3oTy@ashevche-desk.local>
References: <aaHrsTS9iG-PEfue@ammar-VM2>
	<aaLIhgJjrNlp3oTy@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 28 Feb 2026 12:50:46 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Fri, Feb 27, 2026 at 02:08:33PM -0500, Ammar Mustafa wrote:
> > Correct the ad7191 documentation to match the datasheet:
> > - Fix inverted CLKSEL pin logic: device uses external clock when pin is
> >   inactive, and internal CMOS/crystal when high.  
> 
> high --> active
> 
> Thanks, this part looks good in the below documentation update.
> 
> > - Correct CMOS-compatible clock pin from MCLK2 to MCLK1.  
> 
> I haven't checked driver yet, but is it only for a single component?
> Can you double check that _all_ supported by the driver have the same
> in their datasheet(s)?
> 
> ...

Hi Ammar,

Just a quick note to say I'm going to mark this one in patchwork
as needing a new version given Andy's questions have been here a while.

Thanks,

Jonathan

> 
> > +- When CLKSEL pin is ACTIVE: Uses internal 4.92MHz clock (no clock property
> >    needed)
> > -- When CLKSEL pin is tied HIGH: Requires external clock source
> > +- When CLKSEL pin is INACTIVE: Requires external clock source
> >    - Can be a crystal between MCLK1 and MCLK2 pins
> > -  - Or a CMOS-compatible clock driving MCLK2 pin
> > +  - Or a CMOS-compatible clock driving MCLK1 pin and MCLK2 left unconnected
> >    - Must specify the "clocks" property in device tree when using external clock  
> 

