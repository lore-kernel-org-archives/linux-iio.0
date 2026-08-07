Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76CE93BBFAD
	for <linux-iio@vger.kernel.org>; Fri,  7 Aug 2026 15:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786117809; cv=none; b=l0Wx3Fzw+LG9+g3GhXASaHAIcCDKOmIX75Hwawfx/xO/JT8F+cwvUYuIq4z+tWBGGHrLKE2oo0sBUNK+caYdSnXzBdHO/tomaAhUrJYVhLoyc86cip69KcJ404uWC5aSIrWFCWQ4Ngb8U+m0cQYNOgRgZIl+nUsG9juReSkp2Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786117809; c=relaxed/simple;
	bh=+IF0rnPoPzQtbJ4gFb9Q9ZlrvWQfINl/eAZ1VgJahZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U3aXEqg7u1Wdrx94FtS3JBbgyu703X02MgdPMPSoc7WRY0sZkxCyTgH14kgmhQvNeKmWnxKo/PEzEDr88ZbeFdLuVgT1idESd4n0quRpgs9QthsngGAd2DSP5N5FuWpYBoHF+iqKbvyKImx+w4CHeF0rFsWzlojUjF3rpfrLohs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Srufy5aj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Srufy5aj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4DFF1F00A3A;
	Fri,  7 Aug 2026 15:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1786117808;
	bh=2Q+xSBb+88Jxe9LxgU/IawHOOSgkRd2sd6+Eka271Mk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Srufy5ajOdY6heu55w9sgEMBnc0zunatAml6OHUVzLpEmOrw418kAklQM2KaXUyIm
	 qK+bzmbOLvIeir1AiiS+J6H1CqWTR5MoIv4X71XjK4tdhVFmGlEC3hxdYcOCT6qFZU
	 RyeXnfBGGhzvTwBNFtzrAFMgMZn7xsMHhjGHHMTo=
Date: Fri, 7 Aug 2026 16:42:28 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org
Subject: Re: [PULL] IIO: Fixes for 7.2 set 2 (probably now for merge window)
Message-ID: <2026080711-estate-backshift-5289@gregkh>
References: <20260807011131.7ea4a639@jic23-huawei>
 <2026080756-emphatic-staple-8c6d@gregkh>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026080756-emphatic-staple-8c6d@gregkh>

On Fri, Aug 07, 2026 at 04:15:04PM +0200, Greg KH wrote:
> On Fri, Aug 07, 2026 at 01:11:31AM +0100, Jonathan Cameron wrote:
> > The following changes since commit 3585cfd4563731a8ae406b32807613c667c2b887:
> > 
> >   Merge tag 'iio-fixes-for-7.2a' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/jic23/iio into char-misc-linus (2026-07-09 07:44:06 +0200)
> > 
> > are available in the Git repository at:
> > 
> >   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-7.2b
> 
> Yeah, let's wait for -rc1 for these, thanks!

Oops, pull failed:

Fixes tag: Fixes: 93a39542d3c3 ("iio: adc: Add driver for ADS7128 / ADS7138")
	Has these problem(s):
		- Target SHA1 does not exist

:(

