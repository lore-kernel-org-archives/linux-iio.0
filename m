Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86119340A51;
	Thu,  9 Apr 2026 14:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775746361; cv=none; b=QWVwXYbyB/0xGccKzHbIlipHw9RDTF4anhDYtb3PisaUoYnGx7jvPC2NSzv1qZPILb3v27U1c8Q60+nz+NGBmZM3jRDeVZ2cL+W5PaZJENdQ1Z6fBonfHyx/2PLzjN0fbiI2mHjg/xsc1jWLMf2J2rcOU7PJrvdwsnkR+q8PntI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775746361; c=relaxed/simple;
	bh=7FcLS/IZTMFfLMwY41ylRskXZnPtAOpfvYkNdvQHY9M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dvE/4CBEcjNIWPhKxc+2BwNGNW9TL2pAfxaDTLqNrA0mfwAqt2Xiue5usy+lcAbMIxdmFQGH0xrynO+X+yTYdEYFkpQwonNlbjgJS5yoFgNnpOkjDSuSRlg3ynrnhLxCVepdtxso1WcGsqfc2MjHU+joB+Yf3hRdO7Sjy6v8pRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fMuFx5Iu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fMuFx5Iu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4EFBC4CEF7;
	Thu,  9 Apr 2026 14:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775746361;
	bh=7FcLS/IZTMFfLMwY41ylRskXZnPtAOpfvYkNdvQHY9M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fMuFx5Iu/Rx0g/Y59c312Dkb5BmcFdMtLB3ysd8+5BTmSMjDcGpDTHBastmou/hx/
	 73h9rgggWQW0SBihWlgMW8/YCdhGdXsBk4SoKoL8UeSaSI3Uye2ocr8DFEuCIerLxG
	 yHRP5ymqXGwvUI652+6txMFrCkoNzFC4u3qxJzmY=
Date: Thu, 9 Apr 2026 16:52:38 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
	nuno.sa@analog.com, dlechner@baylibre.com, andy@kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev
Subject: Re: [PATCH] iio: frequency: ad983x: replace do_div() with div64_ul().
Message-ID: <2026040913-spherical-slacks-bc5b@gregkh>
References: <20260409131823.1289-1-joshua.crofts1@gmail.com>
 <CALoEA-zR-4xv4UkHqZmwHodVzNu02xRTJ+RDcfaU_EbnDdQahg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALoEA-zR-4xv4UkHqZmwHodVzNu02xRTJ+RDcfaU_EbnDdQahg@mail.gmail.com>

On Thu, Apr 09, 2026 at 03:34:02PM +0200, Joshua Crofts wrote:
> On Thu, 9 Apr 2026 at 15:18, Joshua Crofts <joshua.crofts1@gmail.com> wrote:
> >
> > Coccinelle reported the following in both ad983x drivers:
> > do_div() does a 64-by-32 division, please consider using
> > div64_ul instead.
> 
> Apologies, I typoed Greg's and Nuno's emails in the original CC list.

Please send a v2 with that, as we didn't get this message at all :(

thanks,

greg k-h
