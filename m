Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062E333ADB0;
	Thu,  2 Jul 2026 17:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783012032; cv=none; b=IdM65ymXKXTp9gYyyZrGN37fd8mQRyFrX0amRuO/6Yhp67jQeEhm+vQw2RTVcqmthzGeg8jq8BiTNWukn3JzcHE5yJzDRoIbmPB3ZifGRAhhuV1Oqu3leD6j726JuFDSUMdOFhtcFgqPIOXXboVI8d39nrCMwVnuIVxAM4kMMsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783012032; c=relaxed/simple;
	bh=LYNMMdxNpLHrG2zx1/qKSgt8Vs3VGkRczcTxRlH4olw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ap8T+BOxa6J67tC3SU1tpZTTi5lyK99MBA3TffIPQdxPtAz8A/2OkR3n6vo1vAUshIdv/kqQExxKU+5WNhvuyPjiGlEDL1+S2n3lsx1rjjzQWu6MyMO5XPStq25Pql/0nwvFosL+tH4S3ps/gnCTi0wgPfyYvWyYExpJb3jBGcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K838bcIF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K838bcIF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92BE91F00A3A;
	Thu,  2 Jul 2026 17:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783012030;
	bh=PtJMDgQWyzolkqLNVG8mFTHb6u5y49GAD0Wx+KTNH6s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=K838bcIFgEQ+1Dc7nWzfLnL05WrX77qeS/LvNPV5/qcPt2bhcLFW0RRTLwpFh51ou
	 9cK//CCTBxek1+4x8nmBAD0reS+J4NJ96oViBT5JJICcng8oX+9CqxtF3x2fn/2ksN
	 yAjnpPyqTJzAwSG3kY6s8BVIGNPzziHiAfGaccDPofBLT2gvHBNllB7GW2gqLweEJQ
	 SDgVZFCDwllKumDXbomFcF3+Av3FdSZoeVk9/RQkRy0xqR6ZcauE74wdG8oisffJBd
	 53kkbnumtWMin/wYvq2SUvcqwRtwPJngxiDiBI8OD7niawsZqHw0gcnFI25I+ZxWQ7
	 eFOkxXeOOrQwQ==
Date: Thu, 2 Jul 2026 18:07:05 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Anas Khan <anxkhn28@gmail.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Michael Hennerich <Michael.Hennerich@analog.com>,
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, Remi Buisson
 <remi.buisson@tdk.com>, David Lechner <dlechner@baylibre.com>,
 linux@analog.com, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: imu: fix typos in comments
Message-ID: <20260702180705.7fd132ca@jic23-huawei>
In-Reply-To: <akYRrY72qzPX4aH0@ashevche-desk.local>
References: <20260701151811.22130-1-anxkhn28@gmail.com>
	<20260701162659.43310-1-anxkhn28@gmail.com>
	<20260701184935.3f1029e3@jic23-huawei>
	<akYRrY72qzPX4aH0@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 2 Jul 2026 10:22:21 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Wed, Jul 01, 2026 at 06:49:35PM +0100, Jonathan Cameron wrote:
> > On Wed,  1 Jul 2026 21:56:59 +0530
> > Anas Khan <anxkhn28@gmail.com> wrote:
> >   
> > > Fix several comment misspellings across drivers/iio/imu/, found with
> > > codespell and manual review. The corrected words are coefficient,
> > > temperature, sensitivity, access, chosen, and buses.
> > > 
> > > Signed-off-by: Anas Khan <anxkhn28@gmail.com>
> > > Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>  
> > 
> > Andy can confirm, but generally adding more typo fixes that Andy
> > has not reviewed would be a reason to drop his RB tag.  
> 
> Right, please don't add tags when the excessive changes been made.
> 
> > Changes look fine, but I'll wait on a reply from Andy to apply
> > this.  
> 
> ...
> 
> Yeah, everything looks fine.
> 


Applied to the testing branch of iio.git with Andy's tag
there given the looks fine above.

Thanks,

Jonathan
