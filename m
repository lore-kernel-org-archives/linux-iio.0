Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC0C3002A9;
	Fri, 15 May 2026 15:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778857612; cv=none; b=A/US1dT3vWLK5CC0qs8M5ckJ3xnF/dEeUjknyI+dOhrF38sjMs5x64y3c6/pz80DU1kmNIZLKbQ2R2mYEWsVw0BYYfoEAwkUv+KbkKOrs571vmDDpm0gIZvzaFcuPAH4FxZTxojpnrhYIbiC9WKMUKYGUE7TufDet/upyL4acuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778857612; c=relaxed/simple;
	bh=FILSLCcVXMhoQYUaMxaWQ5TYq2kwy4zGVK6Pqcj5O30=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E/njqS49vDsre4CDgnjGHXI3vnc4VdLngu2Y8dssQqPO+lur+t+wT+t/gQnDCdVMWACArVbhU6Wn7IBgbFGQKnDqqeHYGGwGDJQYdKXTTivIEY7yMKKzUMuO6TXvgjHRc0FEIuAdXS2zAMJqzirJUBEmMqc0FNFXWvFC4oFssnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=W+Q1xLsu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="W+Q1xLsu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8CEEC2BCB0;
	Fri, 15 May 2026 15:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778857612;
	bh=FILSLCcVXMhoQYUaMxaWQ5TYq2kwy4zGVK6Pqcj5O30=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W+Q1xLsuoPZoDvfHKQVlzqtbBW0nCvCzqrXul0uYtmU7iiNHmB7015+zTrn1H5bPz
	 Kx6gBygBBieiRYgsbnnj0AAt85E/I+/tLFTVOPsLDx16T03SZz82C6e7yj72NxFwXF
	 rX+hYkzDYbU4TAfJLK5nwyayBo1KRJOA+zPkqG0s=
Date: Fri, 15 May 2026 17:06:56 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Sam Daly <sam@samdaly.ie>, stable <stable@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH 1/3] iio: adc: ti-ads1298: add bounds check to
 pga_settings index
Message-ID: <2026051515-economist-bloomers-eb9d@gregkh>
References: <2026051420-strudel-graves-f6cd@gregkh>
 <20260515153913.00150136@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260515153913.00150136@jic23-huawei>

On Fri, May 15, 2026 at 03:39:13PM +0100, Jonathan Cameron wrote:
> On Thu, 14 May 2026 18:23:20 +0200
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> 
> > From: Sam Daly <sam@samdaly.ie>
> > 
> > ads1298_pga_settings has 7 elements but ADS1298_MASK_CH_PGA can yield
> > values 0-7. If it yields a value >= 7, this causes an out-of-bounds
> > array access. Add a bounds check and return -EINVAL if the index
> > is out of range.
> > 
> I'll add something about the other value be reserved whilst applying.
> 
> Note that Sashiko has found a more involved similar case (I haven't
> checked it)
> 
> https://sashiko.dev/#/patchset/2026051420-strudel-graves-f6cd%40gregkh
> 
> Whilst ideally we should harden drivers against faulty values from
> hardware, sometimes (like that one) it gets rather involved to actually
> do!  Hence I'm not suggesting we actually fix that one but if anyone
> does want to take a look - go ahead.

Right now, once a driver binds to a device, we "trust" the hardware
works properly.  But "obvious issues" like this patch and the series are
good to have for some devices where the same pattern of fix has been
applied elsewhere in the tree.

thanks,

greg k-h
