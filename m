Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77CFB2F1FDC;
	Thu, 29 Jan 2026 18:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769711212; cv=none; b=XLu4mRVAxzVxsGnQt2hTn26KvC1kIPHTPaz2g8RCvqnAQOvX6i4Svdf4oXc2zGXcQEYo9XTXwdlcy71lBFpRF1xArQDfBXXCza+roogvp3opkYQBfWvi6AskY1QZ/rtojwY0baatskShG9BWWIQGiqXW/bDKcrs9t8rw+5seGOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769711212; c=relaxed/simple;
	bh=XhKtAtHJJDG09lCfCp6L05UZJdDjyNCDesFmj4m8D9E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nS+gOnjF/ZhEQeIsRyMyhD8QqizoPcAsFyjuLjusmny5LHFsL3W2oUayhKdw6tBWFK+Bv1d9jwcdlub00vi9mIp99oue3rtA5QDotM/zj5cHCYM/vEoKQVy33KR0JVXUPIF3lDHnD6qAUTBg42vM1tTjurTZsXbQYCLKjBjAA/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R3qiTp62; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R3qiTp62"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73DABC4CEF7;
	Thu, 29 Jan 2026 18:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769711212;
	bh=XhKtAtHJJDG09lCfCp6L05UZJdDjyNCDesFmj4m8D9E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=R3qiTp626clZbuQb/t5qmOM2UfbqhDsQa2qxjuY6Uv9CqwPyoWsp91UfaU1/n2lIZ
	 ujt/+Rc+Gk7GmsKjuyoJwwvlJN1H1NW12tShpWIMydSWvnyniqX3mFwCaWRA+mcBca
	 dFQjNP1EpWTuOW5xDHwno8FDYN01TeKuv39YNi1My3SCfD1agn+zpqfwL41JpAVTB/
	 r4u3f4TpoUG5tKp8lnbEa/aumaYCCYnVHILi6IgtMUs3ufHNU7hsWHi6hNGGQTpsJ3
	 U/C+HzX1SelWiR0UGs75F3gj5pAUhZJV5f5BK9IU2zv/GZMRFHoICapzZ3M5+rPywG
	 cJvI37b9w/ZWg==
Date: Thu, 29 Jan 2026 18:26:44 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jose Javier Rodriguez Barbarin <dev-josejavier.rodriguez@duagon.com>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 dev-jorge.sanjuangarcia@duagon.com
Subject: Re: [RESEND PATCH v2 0/1] iio: Remove MODULE_ALIAS from
 men_z188_adc
Message-ID: <20260129182624.18e7ea5e@jic23-huawei>
In-Reply-To: <aXuPdgiszetBRSsx@MNI-190>
References: <20260123104805.15975-1-dev-josejavier.rodriguez@duagon.com>
	<20260129160502.33cb6a0a@jic23-huawei>
	<aXuPdgiszetBRSsx@MNI-190>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 29 Jan 2026 17:48:54 +0100
Jose Javier Rodriguez Barbarin <dev-josejavier.rodriguez@duagon.com> wrote:

> On Thu, Jan 29, 2026 at 04:05:02PM +0000, Jonathan Cameron wrote:
> > On Fri, 23 Jan 2026 11:48:04 +0100
> > Jose Javier Rodriguez Barbarin <dev-josejavier.rodriguez@duagon.com> wrote:
> > 
> > Hi Jose,
> > 
> > When resending the first thing we should see is a clear statement here
> > at the top of the cover letter for why?  I applied the previous posted
> > version and not seeing any indication here on why I would consider this one.
> > 
> > Jonathan
> >   
> 
> Hi Jonathan,
> 
> Thanks for your answer. First of all I would like to apologize myself.
> I just resent the patch because I was not aware the v2 patch was already
> applied, I came across yesterday while updating my linux-next local copy.
> 
> For a reason I cannot understand, I didn't receive your previous answer.
No problem. But a resend is rarely the way to address that unless
a rebase is needed (in which case it's a new version anyway!)
If it's been quite a long time, just reply to the original thread
to ask if it got missed. 

Jonathan

> 
> My bad.
> 
> Regards,
> 
> Javier R.
> 
> >   
> > > The first patches I sent for fixing the autoload problem encountered
> > > on mcb device drivers were 2. The first [1] was focused on updating the
> > > modpost process for letting kbuild to access to the data within
> > > MODULE_DEVICE_TABLE and the second one [2] for removing the MODULE_ALIAS
> > > on all mcb client drivers.
> > > 
> > > They were rejected and Andy suggested me to split the second patch
> > > in a per-driver basis instead of sending all drivers' changes in a
> > > single patch once the first patch was merged.
> > > 
> > > The first patch is already merged on Linus's Git repository for 6.19-rc4
> > > 
> > > commit 1f4ea4838b13 ("mcb: Add missing modpost build support")
> > > 
> > > So now I am sending this patch for removing MODULE_ALIAS on the mcb driver
> > > in this subsystem as it is no longer required. This cleanup is being sent
> > > to each affected subsystem separately, as per the review suggestion to ease
> > > the handling for maintainers.
> > > 
> > > [1] https://lore.kernel.org/all/20251127155452.42660-2-dev-josejavier.rodriguez@duagon.com/
> > > [2] https://lore.kernel.org/all/20251127155452.42660-3-dev-josejavier.rodriguez@duagon.com/
> > > 
> > > changes in v2:
> > > - Renane commit message
> > > 
> > > Jose Javier Rodriguez Barbarin (1):
> > >   iio: adc: men_z188_adc: drop unneeded MODULE_ALIAS
> > > 
> > >  drivers/iio/adc/men_z188_adc.c | 1 -
> > >  1 file changed, 1 deletion(-)
> > >   

