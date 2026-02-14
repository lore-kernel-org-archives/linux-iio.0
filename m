Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C56E22756A;
	Sat, 14 Feb 2026 18:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771093261; cv=none; b=ZfD0c/wpQNZJ9kX6Xmjdlu0x30JsClV+uVnRT1cT2yza58RJjnui/eUS15LnrexNxuMFrpbMPsYtx1rFbX1pYT4I2FKOA3qP2MJAm6qwTozC1MCXSrg7UuuPnaGD24fd/eUB7NDnQ9aETA2RgUQebj/eJLcai/JlCiQFEpUijUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771093261; c=relaxed/simple;
	bh=SpH5LBYM8L/BZTguwn65xNBxpAfj6pU8FJs+ikDFnEg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y0pgfFTpSbp//6prVqqwU3/6gnoJp9ulgO/Wex7VBRDGvCk9WVoWvZ8F9kLLJbUwdutD30dU5fAsQjx9+34Qh+s+Pv1p0ox6RQjmLt1nHCzNgJp8iCpR2EjtePwmp91ZSnxH7skUn7u+906HgL6nmHHT3AXq6RHPdAqFWJmZOZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pQMAMeig; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pQMAMeig"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ED75C16AAE;
	Sat, 14 Feb 2026 18:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771093260;
	bh=SpH5LBYM8L/BZTguwn65xNBxpAfj6pU8FJs+ikDFnEg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pQMAMeig+9P1rxOnwbjDP5O20MbCx5RfvnRQOpFB199B6VaMi83Mx6ydiP6EjAd+l
	 QbEaBfABugltJAwMf8jCbAwhvEeZ6Cx8Y2xbX2J1UWtDWWJEskASwH8cPo7rBkKyW7
	 dQO7nBmZ0tCRQ+oWPZAEnMO9f0A3b/IiN0br9DTwbWZDwsW6+To1rB+f62Nj3P0nlf
	 cg323P2z7yttu66bydS3JSZaoZ6SpYED6w99Acdty8hYfvh2H/GHIfS8FaCCSrsxQ6
	 wSBXa19fDEEiZyhzKiTP74ZPY8aQA2/GeQzizrXgqRy6eoNjfDH1u16kMPvn6UI2ql
	 YWxaEVxZu8qVg==
Date: Sat, 14 Feb 2026 18:20:52 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Antoniu Miclaus <antoniu.miclaus@analog.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: dac: max5522: use
 devm_regulator_get_enable_read_voltage()
Message-ID: <20260214182052.14c6f8ee@jic23-huawei>
In-Reply-To: <aYuIftCDo5O0IF9F@smile.fi.intel.com>
References: <20260210175137.44178-1-antoniu.miclaus@analog.com>
	<aYuIftCDo5O0IF9F@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Feb 2026 21:35:26 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Tue, Feb 10, 2026 at 07:51:27PM +0200, Antoniu Miclaus wrote:
> > Simplify probe by using devm_regulator_get_enable_read_voltage() to
> > get, enable and read the regulator voltage in a single call, caching
> > the value at probe time.  
> 
> ...
> 
> > -	struct regulator *vrefin_reg;
> > +	unsigned short vref_mv;  
> 
> vref_mV ?
> 
> ...
> 
> > +	state->vref_mv = ret / 1000;  
> 
> "1000" --> "(MICRO / MILLI)" ?
> (yes, this way with the parentheses).

I know I've argued against proliferation of the X_PER_Y macros
but this one does seem to be very common. Maybe it's time to bring in

MICROVOLTS_PER_MILLIVOLT even if it's longer than the open coded version?

Andy, what do you think?  I do worry that people will see it as fine
to add many many others if we start with this one though. So maybe not.

Anyhow, doesn't need to be in this series.

Jonathan

> 

