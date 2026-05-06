Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ECEC175A99;
	Wed,  6 May 2026 18:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778091444; cv=none; b=CmrZchu09a6gtmZi1AfNBLxpt5LRpcNiW6pND5V8PYfgDoMctQ/Hs+H+iVXhovbo3smr+nawkNGNEsFDBIQm5/MN30B9ppQ424OKI6YHKPiPeVAqSTvc37UmIVdEBx3tWIW1OWdRDSmloHH/MIV7bj02XyDu7q8lCElthfFc9Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778091444; c=relaxed/simple;
	bh=wZcS3zPDTogbCCquvTJ9KNSoNvqqTQ3UtT6v+t8RYWE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mfeAv5cCjT+V40SU9A1iIK6hySWQ5iRSUeR4T62ZAzdKuohJQqf46B58YvLRrLwISeduORhwyBjbUMbHzqgwe6LNU34RFInTMStqrPfarWoXPq85K/xd79xjQVvefQ2e08IGzlFktjgRVFuqLEfozXSayBzVauEXK9zjOMi9iLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NWffUwtG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NWffUwtG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A53FC2BCB0;
	Wed,  6 May 2026 18:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778091444;
	bh=wZcS3zPDTogbCCquvTJ9KNSoNvqqTQ3UtT6v+t8RYWE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NWffUwtGBDqVB30Rh/y78YDGyywGqCY00++tlXRVJYuLLUvfU79K6k4ODPVbDVGaf
	 tlb+klh6ixf+8kG0vin2lV+HZlTNtrfVFaydkKv9oyuH1rGekGGgKNwEx+36JLl2BN
	 PvYMh6c8TRt/diEXl9ThfOxTvgtjh747b9cMTJnMBMH6wGTk/VXqEDvet6VZ0pE5OP
	 OJbCqe6k7VoSmhjihZKfHAP/0Mq2Vwbvx2ce1o8tXEvDO+tgU8CgSvQExZ5t3BaTOM
	 0af7wlLtLyQd7sPnU5MptKJLOARy+Ujtkno0JhXs0ykDR0kpkttugMgK5MTYCTIyJv
	 5MVwhKR7jbb6g==
Date: Wed, 6 May 2026 19:17:15 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Aldo Conte <aldocontelk@gmail.com>, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, shuah@kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH 2/3] iio: light: tcs3472: implement wait time and
 sampling frequency
Message-ID: <20260506191715.4a943d60@jic23-huawei>
In-Reply-To: <afsVzTytyLsNcAi0@ashevche-desk.local>
References: <20260506094311.222500-1-aldocontelk@gmail.com>
	<20260506094311.222500-3-aldocontelk@gmail.com>
	<afsVzTytyLsNcAi0@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

> 
> > +static unsigned int tcs3472_cycle_time_us(struct tcs3472_data *data)
> > +{
> > +	unsigned int atime_us = (256 - data->atime) * 2400;
> > +	unsigned int init_us = 2400;
> > +	unsigned int wtime_us;
> > +
> > +	if (!(data->enable & TCS3472_ENABLE_WEN))
> > +		wtime_us = 0;
> > +	else if (data->wlong)
> > +		wtime_us = (256 - data->wtime) * 28800;
> > +	else
> > +		wtime_us = (256 - data->wtime) * 2400;  
> 
> This is the same as atime_us.
Similar form but not the same unless data->wtime == data->atime
Probably not worth defining anything common for that.

> 
> > +	return wtime_us + init_us + atime_us;
