Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4891F29CE9;
	Sun, 20 Sep 2026 01:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789866332; cv=none; b=EA4KMyHN51HYGigCfbeR6SFMTxXRIKlubOAJZ6um7tz1BdD3T5+cKerTZuu0Womd5e4nIuLKSBylI3yjKVo0Te7aORU2yL8D6jhuMJM6SDu8GztwgOspCXKHk6Urm+SzOUD+hn1MsFp4qm/6LOodg0San8UQg3lbm40ynUV1Zq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789866332; c=relaxed/simple;
	bh=0m72n6E///O5GvMgCET1rmBGRpkAt9hzs/tGnpJiY3w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AGlAY9hfCwKK21Z8hGO+EnoXYvdQlFHg5vc+EnB/SE2Ry2vQS6ijEhzUR4spoGe4ZUD6hqThb/pQIaZytUpPJ4MARZxTqpTuNWP9JjBwLTcPCyrxD85qDd5an+vlJ0uNh7heWflhz4SQ3Q+11oueKQq0ytnlqsd6QKHhrbFi0EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BIh1OFha; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BIh1OFha"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 967621F000FF;
	Sun, 20 Sep 2026 01:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789866330;
	bh=ji1AHJgbuJeJs6uzhIiDnd+GxiaFj52YxrCt7gJ/+zo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=BIh1OFhazskK+ZNZanrMThxqtwqkwrmxQqF8OTqisftZLgVWGxvNhTFH8YVj4bo9I
	 roKSlGUVOtQWn8vT19yGpK+RclKUQRFCHtlSX+gjIP7+xnnCTgLXq5pSCppMDYo700
	 2ezBq/V9NkkEzu6EPGFPxDIMrkpj7Q4CDK9cEZ3ek5we7/EEtEfISE1QU+XEdLPTOz
	 RnvS1T8k2SKk+b//7q0ywnBrR0xSljO5sSTyh/2nSWyPJxrCGc0yk6sTCQMmqWP8EB
	 Jvo9EdfN1/RKi+Rn4SfVZnIU35hhHX/Rjpcn4ZSyzy43lRWK3ArOZDG6yafuHG+y34
	 G3v4gygyuTFHg==
Date: Sun, 20 Sep 2026 02:05:27 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Dan Carpenter <error27@gmail.com>
Cc: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>,
 gregkh@linuxfoundation.org, nuno.sa@analog.com,
 Michael.Hennerich@analog.com, dlechner@baylibre.com, andy@kernel.org,
 linux@analog.com, linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org, joshua.crofts1@gmail.com
Subject: Re: [PATCH] staging: iio: adc: ad7816: Protect sysfs attributes
 with mutex
Message-ID: <20260920020527.2628cb3f@jic23-hlaptop>
In-Reply-To: <aq5nnHPp-tg3C6k0@stanley.mountain>
References: <20260919085513.9173-1-abdelnasserhussein11@gmail.com>
	<aq5nnHPp-tg3C6k0@stanley.mountain>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 19 Sep 2026 13:44:44 +0300
Dan Carpenter <error27@gmail.com> wrote:

> On Sat, Sep 19, 2026 at 11:55:13AM +0300, Abdelnasser Hussein wrote:
> > The sysfs store functions (ad7816_store_mode and ad7816_store_channel)
> > modify the device state and toggle GPIO pins. If accessed concurrently
> > by userspace during an ongoing SPI transfer, this could corrupt the
> > SPI transaction.
> > 
> > Add the existing chip->lock guard to these functions to serialize
> > access and prevent race conditions.
> > 
> > Suggested-by: Joshua Crofts <joshua.crofts1@gmail.com>
> > Signed-off-by: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>  
> 
> Add a Fixes tag.

Hmm - this is a follow up for a few missed cases. The original patch
should probably have had a fixes tag as well even though it's in staging
and the bug goes back probably a decade or more.  Ah well, Abdelnasser,
 add one here anyway and send a v2 with the spacing Joshua asked for.

Thanks,

Jonathan

> 
> regards,
> dan carpenter
> 

