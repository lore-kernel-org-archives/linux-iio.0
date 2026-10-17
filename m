Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D3A3C343A
	for <linux-iio@vger.kernel.org>; Sat, 17 Oct 2026 22:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792275922; cv=none; b=hmh/Lk/FgqqY79U5iwrxP4loVlEouRTIwPjb48ZBZBSz2GKV+CZWw4hGRDV60PhB88Owi/Jnib8PdjY2p2C0oizDAOJXP+HRwJVHN5kEKAYXGNkwhGza+HI2yOVobiIV0Ybawa4jMbEs8a+atFTS6hboLCRcoKPfMdMJPfL7TAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792275922; c=relaxed/simple;
	bh=9i4/LEg3il1U736MRtWpJtJrx5CdNO+7b4ELPAMYySY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lnnIIH9IS80T3sUSXVIvDjg5ufd+bPArfQJif4Thv3HNTGW/Ykf3LIFZLNSBGMuCK2YZqNBC2chYsqNFDAucOeIK57UBB2xTjXjCXzJBFIw1QlwmBT5lxTNJoGfXLb9hj+5JY0/o5NUOyMSe4bye3kqs/MvSHeKzPOBUg5x3EaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IpSweOxD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IpSweOxD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92DD51F000C4;
	Sat, 17 Oct 2026 22:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792275920;
	bh=1XB1ZTvbGNzSc1bf+3ffS1zxU+EhgFd12sI9Scph2XI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=IpSweOxDGYsOQUAtLYhdr3EqMYAHLBy5SXdUZfYKIi0gH+LZQdXXc5xQ/tIxeBg1j
	 RDR4EzKMNCJXV2Ph3v+iWaoanXeJGDbm18fqqGP5zGFUlO195eNAW0Yq0SdZErWyBy
	 7cdEQE65UfmyvGbwl3u5xT/PrBNNyZx+/UWx8Vp/3tywfnYYvAjQ3lKdp4ZyICRhk8
	 GxSUxYDzTn9ga4MFDR+ErPFkdsNT9nxUjwhA1JQUk2dOKmHR7R+y9NnvGg2l7HWmGW
	 TCtDb6fduLHTKYPDaHVWAeAF34T8Neft1G+ogC3/kfsRf4GjC6ZjG419F8igTT62Jp
	 3+qiCvr/Kj3GA==
Date: Sat, 17 Oct 2026 23:25:15 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, Zixin Wang
 <ywp1023456@foxmail.com>, Kevin Tsai <ktsai@capellamicro.com>,
 linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v3] iio: light: cm32181: add support for the CM32183
Message-ID: <20261017232515.064af783@jic23-hlaptop>
In-Reply-To: <20261015222449.5fb400c1@systembl0wer>
References: <tencent_850445458D21608E9C8821E6728457F31C0A@qq.com>
	<as6gvHhkgiudzDz4@ashevche-desk.local>
	<20261015222449.5fb400c1@systembl0wer>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 15 Oct 2026 22:24:49 +0200
Joshua Crofts <joshua.crofts1@gmail.com> wrote:

> On Wed, 14 Oct 2026 00:21:00 +0300
> Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> 
> > On Tue, Oct 13, 2026 at 11:07:30PM +0800, Zixin Wang wrote:  
> > > From: Zixin Wang <ywp1023456@foxmail.com>
> > > Date: Sun, 11 Oct 2026 08:29:13 +0000
> > > Subject: [PATCH v3] iio: light: cm32181: add support for the CM32183
> > > 
> > > Add the device ID for the CM32183. The device has the same register
> > > layout as the CM32181. Found on the H3C MegaBook 14.    
> > 
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> > 
> > However I dunno if the above email tags will be handled correctly by the tools
> > (usually we don't have double Date and Subject email headers).
> >   
> 
> I checked just in case and b4 ignores these and applies the patch
> successfully (while retaining your Rb tag).

Applied to the testing branch of iio.git.

Thanks,

Jonathan


> 

