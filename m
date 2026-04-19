Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81903285C84;
	Sun, 19 Apr 2026 16:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776615563; cv=none; b=roKJ4O/kQJC4uFf/nSdNiNHUx7KnrmSJlDtmU4GvwjkD1os+o1xQuAjcIqI2eudac/fjq/NppAOAt+8kyE5S02whZCtMDe4f1DpuXLMohOY/KCaqqkRvuoyszA6Mt0I3zDW3AOyJ8ZOczu+/pxpOrubEQvsg8p/msW2jGtMbO9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776615563; c=relaxed/simple;
	bh=wAeOocvw65itA8vbiEkkBA3seZslYZ/GxIC1Jlosu/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jkc2SYlU6trj5qnT7D8c1I5pYUOyZvbAw5fbcvR2IBPGsALP++pAj9dUHtqf5CVqaLpsDP1ZqtpMwKjKKbtjUUFF4EBagYNp3IdGQ4jiVfR6MahsgIVSCMh5Zai9tS2lOczR0KCDUaXKNoTgBqPI04RpokfVXcwL3i8Z5a4cx/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MJ/gZsgE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MJ/gZsgE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B37FC2BCAF;
	Sun, 19 Apr 2026 16:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776615563;
	bh=wAeOocvw65itA8vbiEkkBA3seZslYZ/GxIC1Jlosu/Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MJ/gZsgEVUTDDGkONnJh5u072LDI1pTGAAyJtu8bIEAZcKHAQv/AqWJVGY+1/yAHN
	 QM/q+YjMaTeu3yNf028HbxCrqktjsBT6bHD3Bji4g8wkA56dUJD6UJ8LBVWvuLFCT7
	 fY8oaRRSAhvvNSxl5s9zw0KxGNdaXIeqthHlfPZzzUdE6WuewJ9W6qoAZUC8f2o0my
	 wuUopdwCw7i/rJ6SNDcEFHWaL4zojbcHXZKBTw+qU59Ipp9u09O35VM5HGAku1C38i
	 TxA09hdbGLITAhBkHQF8/NNauGP9sSCPY/zF2ZjVPc993TGktZ2ik5bsbYKOVxW+GA
	 vYABtXwtpd5YA==
Date: Sun, 19 Apr 2026 17:19:15 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Joshua Crofts <joshua.crofts1@gmail.com>, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: magnetometer: ak8975: remove unnecessary braces
Message-ID: <20260419171915.09ad7e90@jic23-huawei>
In-Reply-To: <aeJ8Nlg1DTuvknGA@ashevche-desk.local>
References: <20260417130224.1308-1-joshua.crofts1@gmail.com>
	<aeJ8Nlg1DTuvknGA@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 17 Apr 2026 21:30:14 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Fri, Apr 17, 2026 at 01:02:24PM +0000, Joshua Crofts wrote:
> > Remove unnecessary braces at single if statement block.
> > 
> > No functional change.  
> 
> Code wise is good, but I think it's an unneeded churn as a standalone change.
> Up to Jonathan.
Whilst it's churn it's very localized and unlikely to cause us much trouble
so I've taken it.

Other comments below make sense for follow up patches.

thanks,

Jonathan

> 
> ...
> 
> >  	ret = i2c_smbus_write_byte_data(data->client,
> >  					data->def->ctrl_regs[CNTL], regval);
> > -	if (ret < 0) {
> > +	if (ret < 0)
> >  		return ret;
> > -	}
> > +
> >  	data->cntl_cache = regval;
> >  	/* After mode change wait atleast 100us */  
> 
> Side note: you can also fix a typo (missing space) and
> 
> >  	usleep_range(100, 500);  
> 
> move the driver to use fsleep().
> 
> (In a separate change.)
> 

