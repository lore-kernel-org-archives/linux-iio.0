Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B63D3932C8;
	Tue,  3 Mar 2026 21:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772574072; cv=none; b=J8qp6YNVeGuTeYbVYq/pd8EKrumzZS4gtjoTG2/v2AqSgzCeYSKasbpZ5bFjeRxn/mP+AcmvFeYHSSN6LbcJAtGc/tuLs8XocLf9saPm3tu1MoF77a/DhZahrhQhh2R0w05FN8Rb3tz5d9OkYxoDUcbZBhV90ye/MOkCyXbgAa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772574072; c=relaxed/simple;
	bh=UzJqaXf/gbdaKpZCPjdYsRVTL17WyY6ZX5DmtVnb+Nc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mID43CdsX9wDDfBMTg4W+TQjllXQ1kBBZ5q3J1+hWZB5u7ZMW1n4kytQbZojo2RvN7F6aK3KuGszEWH0Mx4uuoArdXGHwv+GIYMWu/Zu1JFngnFjyom0uQhNqyaVc48THs9Mfa+qvbs46r4T0YrODiLN92UWQwXWYdr22loUFDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ma3+mzg9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ma3+mzg9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE606C19425;
	Tue,  3 Mar 2026 21:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772574072;
	bh=UzJqaXf/gbdaKpZCPjdYsRVTL17WyY6ZX5DmtVnb+Nc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ma3+mzg99yHjWXeDONDu5tAIcff9cAQ3NivvA9mnKcr2pGdFuvJB/n9lWdOY5vGP+
	 RPvQrMvnjX7ZoVo5ZHApzDp8HRlGIeudAMGREHoteFzLPYiAK98UrJcFu8kipMhyi9
	 ACtmcsPEtzfRYlor0a5asMWf38x2ea4RzS4HGGbZqSjS1N6Wv25IV1CcjSbHB4AD/K
	 0Sl2d6gET5NumwFzOFFus81PT+dcCgRyd43xbMoFpsJ/Id5x2ItAUjw6xj1Jn4s/YM
	 hqpGr75S2aT4CeRhZT/8+6HtPkD2FAjrfHO5fINsnVqSz08kAh/j7SA8PwXSYsh465
	 VQinfzNfJXoAQ==
Date: Tue, 3 Mar 2026 21:41:03 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: <Ariana.Lazar@microchip.com>
Cc: <dan.carpenter@linaro.org>, <dlechner@baylibre.com>,
 <andriy.shevchenko@intel.com>, <nuno.sa@analog.com>,
 <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <andy@kernel.org>, <andy.shevchenko@gmail.com>
Subject: Re: [bug report] iio: dac: adding support for Microchip MCP47FEB02
Message-ID: <20260303214103.009d6359@jic23-huawei>
In-Reply-To: <ba4306f4a3cba818008c20b0bb9724a184425488.camel@microchip.com>
References: <caa37f28-a2e8-4e0a-a9ce-a365ce805e4b@stanley.mountain>
	<aYXvP5FLA5BvkoVX@stanley.mountain>
	<aYX016NlTNkJzGdT@smile.fi.intel.com>
	<aYX7tlJ593KBDGW0@stanley.mountain>
	<aYYFba5-ZV8VuZHM@smile.fi.intel.com>
	<aYYJc2d5AwJbc_vV@stanley.mountain>
	<CAHp75VdhTEKu2tKC+UKJLs1DcE7079KEbPV0NTFfUAjADBEg_g@mail.gmail.com>
	<16614d1f875aa1e9923375dd3de0897de17791f5.camel@microchip.com>
	<20260301123140.10f585b4@jic23-huawei>
	<ba4306f4a3cba818008c20b0bb9724a184425488.camel@microchip.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 2 Mar 2026 10:28:04 +0000
<Ariana.Lazar@microchip.com> wrote:

> > Just a reminder that this one still seems to be outstanding.
> > Maybe I missed a patch?
> > 
> > Thanks,
> > 
> > Jonathan
> >   
> > > 
> > > Best regards,
> > > Ariana
> > >   
> >   
> 
> Hi Jonathan,
> 
> Given the latest reviews, I was wondering how do you prefer the next
> patch to be sent. At the moment I am working on the version with three
> modules in order to include both protocol families. If you prefer, I
> will firstly send a patch to fix these bugs for MCP47FEB02 and then I
> will send another one with the combined implementation.

That last option sounds like the right approach. The fix will need to go upstream
first, then once that's available in upstream I can merge into the togreg
branch and apply new stuff on top of it.

Thanks,

Jonathan

> 
> Best regards,
> Ariana

