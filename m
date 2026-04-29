Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF223D3D13;
	Wed, 29 Apr 2026 10:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777458491; cv=none; b=ptsSekl65cVZEf3fo6IGn5AUfRA3EVtUW60mREIJbtYyxJxC7t5L1uqggTXBAjQ9CM2s7Alhx3PFPglISWqwHFs/6zvt6W0kXVkoyeZBzpTcksqF9nsxjwQI1oDIzBpvss4UE65ixkTglq91btkL2+vh1HytueJ6SUbKMjftFrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777458491; c=relaxed/simple;
	bh=fA/6zhudExSUKY97NXtJOo4zw81B/9NwD0j59Ug491Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DS4VrWsdCgUUfv15p9j8H0hja2moQ8ezq9hznNHRaqf64QCcfuJCYmc806b53DcrBcofr9NmEc6sydkIvluM/CRPNWY/DPRQcsNfTVwsK4z7p2HzIPJ3txaLccZY6EXyTYxJ6RUxE8xCmT8QifDCSBXRDZlq/NSVv3C54W3O19g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kFfG+xO7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kFfG+xO7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC127C2BCC7;
	Wed, 29 Apr 2026 10:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777458489;
	bh=fA/6zhudExSUKY97NXtJOo4zw81B/9NwD0j59Ug491Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kFfG+xO76eJmQa8+Na19ueSFE4owRzoj8UJA2tieH1lGW79GmWyurzmvMd5IiiRqq
	 tuh6J1pdGZTj+Gq8WskieRy/JhzM7icMu2rSKY5xZTh/1PPGQXlLgZn/kkscJa0si5
	 M1/fBqydR4KUYEs2bmA8KwnhNaVrtJxwWRgZRSTzdVysW1iO7G29xRAtVVjZR0Gw9a
	 oxUcTGDuTbK92yzCmZMWsfMuwro81H99fdVH4AmzjvZnv9MVdfmIFsJtcq7G9HJUcD
	 51iRRb3C0OnoGuarCqaMfo9If+hWi2QDDK/eSaMrFtXS52fIapmIJNX+CfCGABsXab
	 ocBOnyNn8LWmw==
Date: Wed, 29 Apr 2026 11:27:59 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Joshua Crofts <joshua.crofts1@gmail.com>, Piyush Patle
 <piyushpatle228@gmail.com>, ak@it-klinger.de, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/7] iio: adc: hx711: update Kconfig, module
 description and file header
Message-ID: <20260429112759.0e14c0e8@jic23-huawei>
In-Reply-To: <afHWH8Wq4XNxzQdy@ashevche-desk.local>
References: <20260427100950.33936-1-piyushpatle228@gmail.com>
	<20260427100950.33936-4-piyushpatle228@gmail.com>
	<CALoEA-wAUpZ7_2_3kB33mNB_Y_DAc_p7QwPR9a5pxL1iET_cdw@mail.gmail.com>
	<ae9otn7HuPKVtzsk@ashevche-desk.local>
	<CALoEA-w=giUoevbAh+i66ATKfXCr9WUE0R6G6DOMq2xE8cibEA@mail.gmail.com>
	<20260428185404.26f3da04@jic23-huawei>
	<afHWH8Wq4XNxzQdy@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 29 Apr 2026 12:57:51 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Tue, Apr 28, 2026 at 06:54:04PM +0100, Jonathan Cameron wrote:
> > On Mon, 27 Apr 2026 15:49:06 +0200
> > Joshua Crofts <joshua.crofts1@gmail.com> wrote:  
> > > On Mon, 27 Apr 2026 at 15:46, Andy Shevchenko
> > > <andriy.shevchenko@intel.com> wrote:  
> > > > On Mon, Apr 27, 2026 at 12:26:53PM +0200, Joshua Crofts wrote:    
> > > > > On Mon, 27 Apr 2026 at 12:23, Piyush Patle <piyushpatle228@gmail.com> wrote:    
> 
> ...
> 
> > > > > > +         which are used for bridge sensors such as weigh cells.    
> > > > >
> > > > > Typo here.    
> > > >
> > > > It's better if you point exactly what the typo is.
> > > > I think you meant "weigh" that should be "weight"?    
> > > 
> > > Yep, that's it, my mistake.  
> > 
> > Nope. They are called weigh cells not weight cells.  
> 
> MODULE_DESCRIPTION() is not aligned. Somewhere a mistake is lurking :-)
True enough but that happens to get cleaned up in a rewording in this
patch as it no longer mentions weight or weigh cells.


> 

