Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48AC229BD8C;
	Wed, 12 Aug 2026 04:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786510338; cv=none; b=fC4X9+V18DWHMecqnFy19+cVSBTXqkCUxke7B3OB8nvCfABbXrrieU/rzoGPgrWJLa9IhsMUOHfTbjYNV86Iu8MRxydwZ5V8/vqeOz65w5s5V0aVt+BaX++ddVrJ2C3QLIdUy/fhhTe9paV2wBt4NKTICAeH3/CsVTH8Cn9Jjvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786510338; c=relaxed/simple;
	bh=E18uZqsou2hQskz0XH8/gmSZs0TtKtUB7KnfUL81L/c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nYaEidSqpXMQwxiM++cKsZv7wJ1h4Fie3amhiEGLg2ytKL85LCaeXfA2NCm79A4WWPxUS7sMvtF2qtujuEWN/wmIVkq/m8+JMIslRsjWmkaZJjTPNDfthRJynDFAiGZn7Gq9zBdD+JfX3Cijn1iSQP6tFwIx8sTsppS1GSMyx2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SYO2fMu4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SYO2fMu4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 138811F000E9;
	Wed, 12 Aug 2026 04:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786510337;
	bh=6+/13sxdSI5l7PVKZVYBy/IC5KzPDNSBnwCNr9212TI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=SYO2fMu4Q2YfFdcXx+2bDe/QASxDBfk7vaV6ou5Rn/0bLj8HwJs9X4kmR2DwEHCQR
	 w8e3cN+2OzbovjFvkgcPHDcRaVS/bjByWrzfEJl1exyiyTc8mi+rWJwF5cCNPAvp2V
	 Cg//2KHKZ4I2iBSloMnl8tDCuqAGhIMbYczmvnN8Gtse0njpCZH6xucfyrk04iO/yU
	 xiP20MvZCeJuxDOjuykpylyU0fyBIAcAU82c2fGd9XBRjFBoskJqPHkciXJXTc0AlD
	 nPhsup+5nWWgj2hiqeNbCHG6YNMpx0SLwk/R2+BIJofHH2SYrSBXfBITtWRr+ZDMMr
	 0Xa/ZIELU4dvw==
Date: Wed, 12 Aug 2026 05:52:02 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Yash Suthar <yashsuthar983@gmail.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: accel: bmc150: use IIO_DECLARE_BUFFER_WITH_TS
Message-ID: <20260812055202.1fcc271e@jic23-huawei>
In-Reply-To: <anmTFZkbbSqZ-5CY@ashevche-desk.local>
References: <20260808220236.421832-1-yashsuthar983@gmail.com>
	<20260809055442.434972-1-yashsuthar983@gmail.com>
	<20260809235934.6045eab8@jic23-huawei>
	<20260810001852.6afc2c2e@jic23-huawei>
	<anmTFZkbbSqZ-5CY@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Aug 2026 12:00:05 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Mon, Aug 10, 2026 at 12:18:52AM +0100, Jonathan Cameron wrote:
> > On Sun, 9 Aug 2026 23:59:34 +0100
> > Jonathan Cameron <jic23@kernel.org> wrote:  
> > > On Sun,  9 Aug 2026 11:24:42 +0530
> > > Yash Suthar <yashsuthar983@gmail.com> wrote:  
> 
> ...
> 
> > Actually no. I've backed that out. 
> > 
> > Given the data alignment is fixed, if we were going to do this it would
> > be clearer as 
> > struct {
> > 	s16 chans[3]; //see later, I believe this should be __le16
> > 	aligned_s64 timestamp;
> > };
> > 
> > But that is very similar to the structure that follows immediately after
> > this, but that has __le16 chans[] 
> > 
> > So what is going on here?  
> 
> AI slop?

It's the original code I'm complaining about. Been around a while!
So for once, nope (I think!)


Jonathan

> 

