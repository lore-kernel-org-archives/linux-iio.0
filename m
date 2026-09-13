Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6937913D53C;
	Sun, 13 Sep 2026 22:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789336847; cv=none; b=upBeI/YNLNBD0A8eFG5NQPwxhFpVzaIg4N4Z6wBBP45QJdVbuPFxbJwkGfeCnVc8IcD7e5JYoKDx0A8AjYDydSfA8UOJL3sZ3OirJm2+8Eeo2J2pe5JPJIXQxy9cCgyk92Pg0qLGVYczxyhcdkRr4G6nZB8V0eq6AdmdCzFh3eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789336847; c=relaxed/simple;
	bh=RLcYYaG8lMwBbmXtuh9OJJf5wNIV53Uqr9eb4tGCN6I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=md5dpJvEtVgUhnMh022GA1FVhnmAr5wAcIBGyphpgPyNhIdlROHYwoMKGjLuo2YWndaYRvIHwyaL1qzpK/oJqqRp0oeyW4XIDRl2PDETDa6wv+wTvrCaNtsVOjZLAdHWbsa/mG1QRxjmbl1oahQ/X+5X4MeaoSV60QWCGCEajcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L6HwNCXF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L6HwNCXF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BEBC1F000FF;
	Sun, 13 Sep 2026 22:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789336846;
	bh=Wq0j4WMyKl+SAo7hwBKRXWgrN10qKUEShOmoMttyE/U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=L6HwNCXF5EzrK/pmGJYOUUnefXlkfLJ2cDWwFJCj+2T4HXmfDfd0UTIt+bBTZM+5P
	 z7ltou4W7A2+JbgzFPfoIyjUcN7vvdSlKU06Vu6SHZ7+hLWQ42t5cI4NCcJTRgrj6C
	 r+8nHx3yCuE/HuYuDCvZ2IffZyW7LLB15lvVLMDIQV5+12+/0Hv5TjRlp90UFxnKzd
	 VvIMOzKV1JtvdgE2/+F2FQVlIXAv2sQhLuYTYNdNKB4WXkuQMeyKL8AQCDwoJp50fR
	 AxPBBUOmIHi6go0Cd62lyMTaS4NfvAbHk7EgetdM0jXkvypJpwFP9oMOjKFcZMaPRM
	 tWrEX8GDvufEw==
Date: Sun, 13 Sep 2026 23:00:41 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: mdshahid03@gmail.com, Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
 David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Ray Jui
 <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
 bcm-kernel-feedback-list@broadcom.com, linux-iio@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/6] iio: adc: bcm_iproc_adc: convert to devm-managed
 APIs
Message-ID: <20260913230041.4027958c@jic23-hlaptop>
In-Reply-To: <aqFdEiBzwIAuqVhp@ashevche-desk.local>
References: <20260908172359.30003-1-mdshahid03@gmail.com>
	<aqFdEiBzwIAuqVhp@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 9 Sep 2026 16:20:18 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Tue, Sep 08, 2026 at 10:53:53PM +0530, mdshahid03@gmail.com wrote:
> 
> > Changes in v4:
> > - Move the ADC enable error-path cleanup simplification into the
> >   clock conversion patch.
> > - Simplify the ADC devm cleanup action.
> > - Restore the blank line after the copyright header.  
> 
> Cover letter is not only changelog, it also a summary of the series.
> Patch wise LGTM,
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> 

Applied to the testing branch of iio.git for 0-day to take its
normal look before I push out as something I'd rather not rebase.

Thanks

Jonathan
