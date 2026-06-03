Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC1136A36E;
	Wed,  3 Jun 2026 10:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780484172; cv=none; b=Sqb/3ACQd1BfA9yKpBPMSS49p4dqzAfk+IfXOeGnug104ZBrC/TQqbSXqfyBIM+ShEwdcgg6Ya7Hi7YhBMhwHXb0EHtrATSxw9ThOnuZkW5vJaBfG45qBvZToAa9yjZJJ351AwYoD6kPUgSMGqXBr2iFIbIhWlgK9SBOpfenNSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780484172; c=relaxed/simple;
	bh=xmDJwof4XDDjilUfkwJHGPZ3onWnBpjRWYP2hRxqkTA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dWjn4leO1nUkagQdGKSfgrr7yslstjjr6lePe675unFpy7fQHQISmsvuuMH0z53oTUi47VsSGu4RMwBb+SA2iMLyfKi0rmclCU7o5O9okWQCdhOm28kyGqPPcfmxFYD6UWoDN6m8l2fxsJLG8lBsVJY9tHXF0LDpg5jEZXFKjuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J666huQR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J666huQR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9827B1F00893;
	Wed,  3 Jun 2026 10:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780484171;
	bh=FDwF1eE0EdMzImIdVDDPp5Vo+daPsDYxV2qxbfRAH04=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=J666huQRrA7a9IiLF4dn227fjrc1o4pusaWXUTNU0bAJr/vGG9rIyEd5+eC8tT26a
	 bAX88fIs4F1b6Ub8dq068DrcTdFHzsUMrVfVSGxkK877a1M2qXLjNG6aCeTk4MLt1j
	 6ljo2SRjJnr1AI/SuRO/K/aXZJtcd4jeLF32W8k7KyGmc2YxzXnInssTODJ4gfeyWg
	 emg++Aw5qvWfG63DmymH+IEiaX/Ki15BmUFyW6M3myzvtivUYbHmUcM7ukQyO4X2eR
	 px3tz924qRlXO4QdvZhsW1xAH4J91/dCzAjdPPMi/o8nAa+QFq7rVTDqxCbb2/2W2B
	 M3c51hYEe14uw==
Date: Wed, 3 Jun 2026 11:56:04 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Miao Li <limiao870622@163.com>, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, dixitparmar19@gmail.com,
 waqar.hameed@axis.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, limiao@kylinos.cn
Subject: Re: [PATCH] iio: accel: stk8312: Update includes to match IWYU
Message-ID: <20260603115604.0bb2592a@jic23-huawei>
In-Reply-To: <ah_BVAIR40VIquaY@ashevche-desk.local>
References: <20260603014754.187465-1-limiao870622@163.com>
	<ah_BVAIR40VIquaY@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 3 Jun 2026 08:53:24 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Wed, Jun 03, 2026 at 09:47:54AM +0800, Miao Li wrote:
> 
> > Update the list of included headers in stk8312.c using
> > Include-What-You-Use (IWYU) tool, mainly to remove kernel.h
> > and add missing headers such as array_size.h, bits.h,
> > dev_printk.h, etc.  
> 
> Same comments as per your other patch.
> 

Main take away here is if you are sending a new type of change,
test the waters (and get initial feedback) on that change applied
to a single driver.  That way you don't waste your time or that
of reviewers on common problems.

Thanks,

Jonathan
