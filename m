Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E963815E9;
	Fri,  8 May 2026 13:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778247289; cv=none; b=d4N2RbAkyFPdtQOhv4fBkhFxBadQSlOKCiOzbuz6GGO1Mly7zTSmkgt73c1IX94EXDazoIudsEP/SFtBEAB5EwejOsNnmPKr5crUGby6t9b0JC/zSiSgZl0dSJhb1sYFv7a0OtnCOqXyZk7hebuyinW7N0kC/0fliOE/EUxI8X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778247289; c=relaxed/simple;
	bh=7sBQKLd1gvQdvYl55UGPqLj0Ibge4dU6+iVep48ECtE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OPTFBNRfnZA4ceJLhIyRW4TsxjCks39Yf/FankIGmb6GhQ0mzuzyOBW76/+VBrDibh9fnN9lZwBaW4gXXtsQYbe6fdiPGZAyt4jKsRdVRQ3JsoQuB2o1g1bSi8dWjJ7kmfoPIWF/zDaqvvvr9mE3jSHpiiEcQBoB2NcvBTXyDTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f8Amt/Zz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f8Amt/Zz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B273CC2BCB0;
	Fri,  8 May 2026 13:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778247288;
	bh=7sBQKLd1gvQdvYl55UGPqLj0Ibge4dU6+iVep48ECtE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=f8Amt/ZzG6gC44t3DIYcc88Pb9cprQ6kwN+QGGzhKfGva3HQfw3/uRCMhXjkdW2oe
	 EPc37EaGhtgZysL+Jl8AYyKfg4vP7AWmiv6n3c9Pa6SjwsWKl7dxR4sgTAyWLhpDS5
	 MSmACIm8Dcb0QYtnOkxpOjBG0UkN33pe3e+bYFbQtszvBWnHgHxFBZkMCTDAJsSkif
	 ovGVLaPXdV1XkvSICx0h0PIzkYyXNs7GwBnigDmiLvepqhtP66aqW2fwf4ryx/8Q8i
	 dvB8yWVb6Y+ntpVWD1iSE78X+YxwyPBttcTxpiWHwP52u99l+QfUc0JLKIbdjzyfLP
	 GLp9Bexz61U7w==
Date: Fri, 8 May 2026 14:34:39 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Joshua Crofts <joshua.crofts1@gmail.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/8] iio: magnetometer: ak8975: driver cleanup
Message-ID: <20260508143439.01e64e8c@jic23-huawei>
In-Reply-To: <af2qiO0BZLoGy1P4@ashevche-desk.local>
References: <20260507-magnetometer-fixes-post-pickup-v1-0-37827ca68fb3@gmail.com>
	<af2TFa3qd_7tcxeR@ashevche-desk.local>
	<CALoEA-wUdMm5gu=OhhgYV1C3o3MHEzfC0i9gjjUz6CE4B+xw1Q@mail.gmail.com>
	<af2qiO0BZLoGy1P4@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 8 May 2026 12:19:04 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Fri, May 08, 2026 at 10:59:12AM +0200, Joshua Crofts wrote:
> > On Fri, 8 May 2026 at 09:39, Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:  
> > >
> > > On Thu, May 07, 2026 at 04:35:49PM +0200, Joshua Crofts via B4 Relay wrote:  
> > > > This series is a continuation of the previous ak8975 driver cleanup
> > > > effort, as most of the patches were picked.  
> > >
> > > It should be v6.  
> > 
> > Jonathan said to either do a v6 or a new series, up to me.  
> 
> Fair enough.
> 
Oops. Wasn't my intent.  v6 would be normal for 'some patches' of a series
that are outstanding. Ah well never mind.. 

J

