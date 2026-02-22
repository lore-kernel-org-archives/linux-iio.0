Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59BF5146D5A;
	Sun, 22 Feb 2026 16:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771778906; cv=none; b=cgkjRafvDDOuIWmo2YhI/ly00V+ApI3Z3YGR9ZLxqQRci4UeFJdTKDzfY84elo3FKkuCgs5Sv84uJ9YLS/CjWw60df1SgaDaMhitY31sRdEU3HBbObvsqnJ5rIFSd94MQq+PXJJWF+o5EpSDeHVAy1U7p6qh9A5uHIIpi7tTFSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771778906; c=relaxed/simple;
	bh=J7Eib0yHbf9rdjI16OzpBpwqtJ812/tBUq9qdgi0scU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a/I3g44FZ18s3/Lnfw9vgfBE0TMXdsGXzm6TPM/2lTkzC9LmvCQXCRKb7y5/bc2hu66Y4usv4GdH9xagz3CcltNTWlxz2RWzMzJ6mLOBKnqeiaN9eC1QOynTgG80P+t9yqbLXGvNDJp2QiR0J7epxq68gk55VsIe+k+DoEaW+1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kpVzLgZj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kpVzLgZj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3A72C116D0;
	Sun, 22 Feb 2026 16:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771778906;
	bh=J7Eib0yHbf9rdjI16OzpBpwqtJ812/tBUq9qdgi0scU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kpVzLgZjQFcFKh21SgRosj7du+JJgZ/CJp1hpdl21eF2iGN9Nz+6ea5Qq/TqqkY0F
	 RmBOe9EZnLu24oZysjOMBzHkS2tOI45j7Bkf8dJdsoYt8QMjfsoC86BmsPGdaiurub
	 UI7TRTejYPyzFYRROhdWL3KCvVzQ7nkn72lleJMuMmasttnB/RNDPSJwqHVhqFbftI
	 wBMGWzBzbtBobSrWrJXzeVQT8kttpfzt7TcvsarEOlCsJciNEDa6jynwfbs28ksk8G
	 BIyr2vKsqAFfcOPT9nneQ5QuyPOuA0zioLcF3ZcGinlxfAW3mNIJ4XP3cnk862tNMl
	 8mPeKI93DhuAg==
Date: Sun, 22 Feb 2026 16:48:15 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: radu.sabau@analog.com, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Nuno Sa <nuno.sa@analog.com>,
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>,
 Robert Budai <robert.budai@analog.com>, Antoniu Miclaus
 <antoniu.miclaus@analog.com>, Ramona Gradinariu
 <ramona.gradinariu@analog.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: imu: adis: Fix NULL pointer dereference in
 adis_init
Message-ID: <20260222164815.0513cfca@jic23-huawei>
In-Reply-To: <aZhuqJuPuBHSyGLk@smile.fi.intel.com>
References: <20260220-adis-fix-v2-1-4cc24a261306@analog.com>
	<aZhuqJuPuBHSyGLk@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 20 Feb 2026 16:24:40 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Fri, Feb 20, 2026 at 04:16:41PM +0200, Radu Sabau via B4 Relay wrote:
> 
> > The adis_init() function dereferences adis->ops to check if the
> > individual function pointers (write, read, reset) are NULL, but does
> > not first check if adis->ops itself is NULL.
> > 
> > Drivers like adis16480, adis16490, adis16545 and others do not set
> > custom ops and rely on adis_init() assigning the defaults. Since struct
> > adis is zero-initialized by devm_iio_device_alloc(), adis->ops is NULL
> > when adis_init() is called, causing a NULL pointer dereference:
> > 
> >     Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
> >     pc : adis_init+0xc0/0x118
> >     Call trace:
> >      adis_init+0xc0/0x118
> >      adis16480_probe+0xe0/0x670
> > 
> > Fix this by checking if adis->ops is NULL before dereferencing it,
> > falling through to assign the default ops in that case.  
> 
> Don't throw versions too quickly. You missed a tag from colleague of yours.
> 
> > Fixes: 3b29bcee8f6f ("iio: imu: adis: Add custom ops struct")  
> 
> ...
> 
> > -	if (!adis->ops->write && !adis->ops->read && !adis->ops->reset)
> > +	if (!adis->ops)  
> 
> I hope you have checked that this is indeed the case and we don't need this
> check anymore. (I would be glad to see it being replaced as in this patch!)
> 
> Assuming this is confirmed,
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> 
> Collect the tags and issue a new version only on demand, and not earlier
> than 24h from previous one.
> 
I picked up the tag from Antonio and applied this as well as adding a stable
marking so it'll get backported.

Note I'll be rebasing on rc1 once available, so the fixes-togreg branch
currently has a random mid merge window base.

Thanks,

Jonathan

> >  		adis->ops = &adis_default_ops;
> >  	else if (!adis->ops->write || !adis->ops->read || !adis->ops->reset)
> >  		return -EINVAL;  
> 

