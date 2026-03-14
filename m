Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC7941C68F;
	Sat, 14 Mar 2026 11:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773486874; cv=none; b=J0v9+3vu2JmsEwljOmNcPA5B2jZ8GpYTlkVkW92H7bmXawbNJB2hn3iKEddzQU+NaRctRX74Ydp6xJBKw3jb/Mp1dwtI6ekyc1YHBL0At/30/wLtJngqen3DdPmsWkxFOf2RboFTq6aSudsiFpcrDJ/ZxkqPJMelvmdWstUhWyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773486874; c=relaxed/simple;
	bh=dXXrf3DAU5M06AAFRkcekLafEvGQp6usv+Quay1rNu8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RujhVIA3sznkB8JAHT0Tl99xEN1H5TTiBw8BIBIcoEjfOwd7mR1mAQvDBw2rKRirAEZf1gsTXDJreIK48ZekD0UCgvnH7FMYmze7t9Uu8P6ftJqIKng03155+oo6KrXqZgs+l3O+l91B/TeaVa49WcP4dFJikKsRFhzNbl8wvQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BxBhuVys; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BxBhuVys"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87537C116C6;
	Sat, 14 Mar 2026 11:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773486874;
	bh=dXXrf3DAU5M06AAFRkcekLafEvGQp6usv+Quay1rNu8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BxBhuVysnnKFOJLmUu4aVy25THxdVCLyIqiscCVoKM8ju13zdR4LmY2vuwPZSneaC
	 QzQI00w1zg6T2ecIyk64PB6wc2mxoiC/mGtcUhp3Lu/6qAgyxkN9H5NRgzRTHKGzWk
	 8p6HRkj9f9Rt2FXROU7UwdBmkCS0Bbs+mYM+zMnzJiDXNW9H9pT0RCgGOnZMCqyUZM
	 +IS3m7tuce4NK+X3uSbtrvEc3m+qeXbZAm5j3cF7cLEl+36xhh1BZDx2Egf4iNgZoS
	 7T526iNQy5jjQy25lkeI5jnPPFe30X9tYUXDTE/5gpkFHF49ZmSelhaB2rdt+QJz1P
	 CDt1hE51h24Gg==
Date: Sat, 14 Mar 2026 11:14:17 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: David Lechner <dlechner@baylibre.com>, Francesco Lavra
 <flavra@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 5/6] iio: ABI: Add partial quaternion modifier
Message-ID: <20260314111417.598be3b9@jic23-huawei>
In-Reply-To: <aa3brnQzYT2fKeZo@ashevche-desk.local>
References: <20260304080519.2844101-1-flavra@baylibre.com>
	<20260304080706.2844472-1-flavra@baylibre.com>
	<77e10517-2b6e-417b-95d3-185d3a067ba5@baylibre.com>
	<20260307130312.2efd100e@jic23-huawei>
	<aa3brnQzYT2fKeZo@ashevche-desk.local>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 8 Mar 2026 22:27:26 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Sat, Mar 07, 2026 at 01:03:12PM +0000, Jonathan Cameron wrote:
> > On Wed, 4 Mar 2026 16:35:39 -0600
> > David Lechner <dlechner@baylibre.com> wrote:  
> > > On 3/4/26 2:07 AM, Francesco Lavra wrote:  
> 
> ...
> 
> > Whilst I can see the argument, I'm not keen on more punctuation in the filenames.
> > May well trip up someone's parser.  For now squashing the spaces is probably
> > the best option.
> > 
> > This made me spot a major issue though. We can only add to end of these
> > enums, not the middle!  
> 
> So, if not yet, we need to have a patch that adds a big fat note/warning about
> this on top of the enum(s).

To me that would basically say 'oh look this is a uapi header, you can't
change anything'. I guess we have a few proof points that people don't
actually realise that so maybe you are right.

