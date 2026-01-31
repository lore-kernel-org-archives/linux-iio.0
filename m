Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2685B3033CA;
	Sat, 31 Jan 2026 16:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769878655; cv=none; b=ncq9Reng1VWWCUcmEPgdlCYnd4KshnIuKwzwRZB6sORZh6jDfvVs4+KLEIkdC/PfviwAco962KKcOAQCqWxzxxAxpSlzxXftYhFCe4puRRn6dJ2JuaLHxp8YXoAAw0gsGi+A1ZW4ISrEPRzlcasC/b44rrFYVkFZeIuyNbD10mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769878655; c=relaxed/simple;
	bh=0HnjZNXfMnu9rOPdh1ZoJ8mpxdEsse0tBsJhDwnMipQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YiIAf9ui+ZgqTExC/D1NsudTtgTkQY7BQpIH4SmlI6w6mXJE7AQvsGIAJhnWt1TWfqj3bBA4gZpfoBrLh/hbkxiXglBaRtnGvKZWcHpZsN/2EYBPj/koagIh1Apj457nBjCRPdO08JAqYniuaCD/DORURdfRoxbJrBgrb77xa0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R0QiGzzG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R0QiGzzG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F742C4CEF1;
	Sat, 31 Jan 2026 16:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769878654;
	bh=0HnjZNXfMnu9rOPdh1ZoJ8mpxdEsse0tBsJhDwnMipQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=R0QiGzzGv6noMgUQyQTuWvgZ8V8HuvKMVCsCZLgoFV1mrvCos61r24vs+5ssEbGj7
	 ZQSU9BNhZMTHTUmbTqx/H0FffAkapvWfPx/NBTCEr59Xu+5zJbd3CiXvjfSUqCm8uj
	 tN1qCMdfeST0h79d5Dby8pCTts03bflh8QSoMQ5jRfArB9+NFoT+LNTFlA6xXoNy9A
	 n0xrYCr0Ab1gJVZA6PHzD2PIuGZ871rudGCkM1vaA79sKzynA/QWAY/UuH4JUV2lQ5
	 qNLTpXAgOeXJSMQN1B2UHWxhOom/bFcKm0talgpO9FYptPlh3j3CQo5RTXQ+KHaUcP
	 sTmzNC9+QlfmA==
Date: Sat, 31 Jan 2026 16:57:24 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, Antoniu Miclaus
 <antoniu.miclaus@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Matti Vaittinen <mazziesaccount@gmail.com>,
 "Fabio Estevam" <festevam@denx.de>, Sakari Ailus
 <sakari.ailus@linux.intel.com>, Chen-Yu Tsai <wens@kernel.org>,
 <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: adc: ad4080: remove unused dec_rate field
Message-ID: <20260131165724.590bb48f@jic23-huawei>
In-Reply-To: <20260130173849.00004447@huawei.com>
References: <20260129172340.34216-1-antoniu.miclaus@analog.com>
	<aXxAVIM3iTXdQJE8@smile.fi.intel.com>
	<20260130173849.00004447@huawei.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 30 Jan 2026 17:38:49 +0000
Jonathan Cameron <jonathan.cameron@huawei.com> wrote:

> On Fri, 30 Jan 2026 07:23:32 +0200
> Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> 
> > On Thu, Jan 29, 2026 at 07:21:58PM +0200, Antoniu Miclaus wrote:  
> > > Remove unused dec_rate field from ad4080_state struct.
> > > The driver reads/writes decimation rate directly from
> > > hardware registers via ad4080_get_dec_rate() and
> > > ad4080_set_dec_rate() functions.    
> > 
> > Jonathan, the changes look good to me, but the process wise it made badly.
> > Up to you, if you want to apply this, but it might be confusing as this is
> > definitely *not* a series.  
> 
> I'm not planning to queue anything else non urgent for the coming 
> merge window, so we have plenty of time to do a v2 nicely.
> 
> I'd not be against having this lot of cleanup as a series if it
> had a clear cover letter stating tooling used to find them etc.
> Whilst not one driver, and can merge independently that sort of grouping
> is fine if it provides some value (such as background info).
> 
I looked through the patches and they all seem fine, but lets
take the fact I'm not going to be merging anything for a while as
an opportunity to clean up presentation of this series.

So I'll wait for v2, as a proper series with a cover letter, patch
numbering etc.

Thanks

Jonathan

> 
> Jonathan
> 
> 
> > 
> > Also some patches should probably have a v2, I haven't checked that.
> >   
> 
> 

