Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042012C08AD;
	Sat, 11 Apr 2026 08:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775897664; cv=none; b=Ek4Pls0SWLrfIa58KYAhIRPWFh/3iV+r5WhIHQqK1X24StnZv9cmQq92iYIFb/mCWPr+WvrqeeDKX54rrtuv/ofnyHMX8JDN4/0U12EuNZlvympTCdIo+5fFJUDh9p6ZJkGqAeKulfwNt2YGCxyaU6o/1yMsL4jiCmXRhluHDwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775897664; c=relaxed/simple;
	bh=XsMo2QtH1SkpBZ8g25CaHdFzxGbZ3eevhUARfG+yUOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FDXp9pGJ5WGNGqR8wQNKEyN/5HI1Kz5suzxOlTp/hxU1ewvNuzMI+7O7L0WiBysLVitslxWUwhJjySKXeRekBMyc2Mk1YT7V/xkeCPk3UUSnpXgd+kviqVToqRPI/Lcr60FU9mgpHIaUKi12jl1LFLRPqJRgiFiTL/UfNaPfuNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cxaA2eR+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cxaA2eR+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25C93C4CEF7;
	Sat, 11 Apr 2026 08:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775897663;
	bh=XsMo2QtH1SkpBZ8g25CaHdFzxGbZ3eevhUARfG+yUOQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cxaA2eR+OUCh/8cwROaZBJWIGPpJtOF8MXa2cpjEzfCMJiWrHG+3/XzRB1MPvEVYk
	 9WHhgqrSib7yofomELBZZz5N6Xo//YKEbwaGoWLW+NGAvIchWcwhk9UppBtbJVaA7m
	 vD1IfuZWN8/eEoRiBTRrerG3XPMdq6NNDppfQILY=
Date: Sat, 11 Apr 2026 10:53:54 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Advaith Neelacantan <advaith.neelacantan@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: iio: frequency: ad9832:  use guard(mutex) for
 locking
Message-ID: <2026041132-grid-booth-1b0a@gregkh>
References: <20260411072503.106621-2-advaith.neelacantan@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260411072503.106621-2-advaith.neelacantan@gmail.com>

On Sat, Apr 11, 2026 at 12:55:04PM +0530, Advaith Neelacantan wrote:
> Replace mutex lock/unlock pairs with
> 
> guard(mutex) for automatic scope-based locking.
> 
> Simplifies code by removing need to manually unlock.

Only use guard() for new code, no need to change existing code for that
at all.

thanks,

greg k-h
