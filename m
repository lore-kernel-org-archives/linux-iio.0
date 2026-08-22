Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53C6EACD;
	Sat, 22 Aug 2026 01:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787363589; cv=none; b=tFA/I1B9L6ftpt+550LogOTXhfdMz3nh0rZqTdhztjCwfal3V317YRNaDW0ytNlT1JuHMzi1j3NqG/3VIeWfrux9fDrVWMep/LokWPIzk00js0vvBAIA0HM0GdsOMOuoCFAU0paVffGYP9qGtIW3WS/X9/lSaTz20N78oGKrkxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787363589; c=relaxed/simple;
	bh=Ld8edAAE290f6pTB61Ojvi2TndIAg4rh2NxNrOD03Gc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qF7RWwzfZcSoQedsFdeWrVpAvxdXkd6eLVuUXoMcyP/n6CgoA7aXlFyDPvqSCq3xfaeawwnbzpAo2SkFB/RYX4zEE+pWiVT9ojDp9lcGnobhw2dN9dBGULlIqEeXrQHlTZsMicKZcHA2Q1s4/qXpCvvqXh3trqahEE2YPp2iFZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ieT7dW6w; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ieT7dW6w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DF841F000E9;
	Sat, 22 Aug 2026 01:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787363584;
	bh=r6MeiXWgK9DpR7Y+4isrivMRsxGTBKFAoVGptDSos5g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ieT7dW6w3OkQuWfBAQKTtPZPTpg90bxDha0KwIkrNyVQbPsdF083ruXXnO9o0DeFn
	 Xca1sGMvkTmzkhsC3GcXjDoiARuEO71yOeV5yTP4sXqQ4n2ZPp44Pa/MW4kgY5LeZM
	 CVXXq1R76bsjyQ+zF64GiZNHBhEF/LJLHyrvw6XNFyMtE27y5HPo/HQIh1BpQEARv2
	 IvWmw2F2OdRHK/noLVcyJb1WXNoQQ5lfZE3+nvaHSztAgyJLFJXv+6OgoYdQ7J7q1q
	 1huT2s4dnTVTI7XqJpBtUc5NErVeuKaK3TufPVm7fzFdOohdYZ9Bunk+FJ2A4EEBTs
	 C3w8ddl1+MyTA==
Date: Sat, 22 Aug 2026 02:52:58 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Marco Chen <marcochen.dev@gmail.com>
Cc: Joshua Crofts <joshua.crofts1@gmail.com>, dan@dlrobertson.com,
 dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 jagathjog1996@gmail.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
 linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH v1] iio: accel: bma400: remove completed tasks from TODO
 list
Message-ID: <20260822025258.428c4db9@jic23-huawei>
In-Reply-To: <aocb9uU4vz4FBo4P@xiaolong>
References: <20260813150103.56350-1-marcochen.dev@gmail.com>
	<20260817161523.00001feb@gmail.com>
	<aocb9uU4vz4FBo4P@xiaolong>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 20 Aug 2026 11:37:49 -0400
Marco Chen <marcochen.dev@gmail.com> wrote:

> On Mon, Aug 17, 2026 at 04:15:23PM +0200, Joshua Crofts wrote:
> 
> > Strange that these weren't removed in the commits that introduce said
> > changes... Anyhow, not sure if this patch on its own is too much churn,
> > Jonathan and the other usually prefer these to go in a series of more
> > changes (i.e. if you do the power management TODO, you send this patch
> > in the series). This is up to Jonathan however.  
In this case it is tidying up now incorrect documentation. I'm fine
with doing that on it's own.  Hence applied.


> 
> That makes sense. I will resend this patch as part of a power management
> series instead of an individual patch like I did here. I have ordered
> a bma400 and I am reading the kernel docs on runtime PM and other IIO
> drivers on how they implement it. 
> 
> To Jonathan, do you have a preference on how the power management
> series should be structured?

Sorry - I'm way behind on review so not going to have time to look at
the datasheet or driver for a few weeks at least.  Perhaps share a proposal
and we can look at it on list.

Jonathan

> 
> 

