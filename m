Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00074238C2A;
	Wed, 19 Aug 2026 01:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787103160; cv=none; b=johlXqqTO4tjYES39L7fYSfZwOZR6CfsaZNxvbaSauMMHBmiHW52+2HY4ZFRLB/WmRMpIHaWHfIkSkfpop/8uAZMigrYVk30Fkr3zh9YUqs0yUHKjqD/TdjzGLIWbSojUmjFyKGU4+i8FNSV4IVM9lq0MTuWn3ykd+TNOg+eZDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787103160; c=relaxed/simple;
	bh=JlWU0h8glHfr2M1ULOxMNu+RSTJMaFPmJ6UrgB/SKJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WvPS4Sh6G6klJ5gDM/hD0smg0a4tMcxx1fO6tC4wxEl1iEDVYz6ItqRWz8eoPwXpUDck9v3ouuNqf2D87BGGreT5vgQP7hImbW1nm0iBOtpzmpLgHfI3/7n7ZRU3LzQBoLi+ud8Bg/BmXvga/+U+mG8HxdgWESp1QJXt2Ahp8WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bvD26f34; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bvD26f34"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 940431F000E9;
	Wed, 19 Aug 2026 01:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787103158;
	bh=P4jXIzM8QxsVnMcjML/SwwOt1zvY/twlUbHoKUFySWI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=bvD26f34/BWVbRxEaesYwfa1vUSJXkTTm6qIhibZqhdhcVOlGcVJbdbMq12yHD6nL
	 V5Bw52UXJnTUA7idPQN3ZOqYrgOwM/hw71RaCQn/OsmG8IYEFGoWkzvlM91D2w+gl3
	 K572CgPilfZgcXmjl/UI+Uz45U9Nn/Q8kKLJ3qWqecqvw3lW+AtFvl54fBG3InVJx2
	 PWBBN1kCkWwVIJWvMDYWWRyg6wZgIc+3BOcSmhv6KrHKSSafpzzqcvY/pZABm9h0au
	 O4cxTWwIHnBy3MjUqfYPoLqM3QvOeuyftNGWQ1S8nQTDQFCQJXjE2nHpdVrUKCXvi7
	 sGQmF5edpbF6g==
Date: Wed, 19 Aug 2026 02:32:33 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Esben Haabendal <esben@geanix.com>
Cc: "Lars-Peter Clausen" <lars@metafoo.de>, "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley"
 <conor+dt@kernel.org>, "Martin Kepplinger" <martink@posteo.de>, "Sean
 Nyekjaer" <sean@geanix.com>, "David Lechner" <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, "Andy Shevchenko" <andy@kernel.org>,
 "Martin Kepplinger" <martin.kepplinger@theobroma-systems.com>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Joshua Crofts" <joshua.crofts1@gmail.com>,
 "Andy Shevchenko" <andriy.shevchenko@intel.com>
Subject: Re: [PATCH v4 2/6] iio: accel: mma8452: Optimize struct mm8452_data
 member orders
Message-ID: <20260819023233.03d79181@jic23-huawei>
In-Reply-To: <87tsosk6zt.fsf@geanix.com>
References: <20260812-mma8452-open-drain-v4-0-bfca15d02b59@geanix.com>
	<20260812-mma8452-open-drain-v4-2-bfca15d02b59@geanix.com>
	<41zbnT5tdPvKMFjNwqTi18KkdWe7Lyw2tPRSixVZ-8cH1LJwnQRi78CowVB5NP6sD_iVSoTEMBevXuRCaDTpXA==@protonmail.internalid>
	<20260815051356.4dac350e@jic23-huawei>
	<87tsosk6zt.fsf@geanix.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 17 Aug 2026 19:10:46 +0200
Esben Haabendal <esben@geanix.com> wrote:

> "Jonathan Cameron" <jic23@kernel.org> writes:
> 
> > On Wed, 12 Aug 2026 16:30:33 +0200
> > Esben Haabendal <esben@geanix.com> wrote:
> >  
> >> Reorder struct mma8452_data members to avoid holes.  
> > Trivial but sashiko pointed out mm[a]_8452 in the title.
> > I'll tidy that up if nothing significant comes up.
> >
> > Interestingly Sashiko also thinks it found a deadlock.
> > Given you are working with this driver if you have time could
> > you take a look at that.
> >
> > https://sashiko.dev/#/patchset/20260812-mma8452-open-drain-v4-0-bfca15d02b59%40geanix.com
> >
> > I'm rather surprised to see the lock taken in the runtime
> > pm suspend callback. It is probably there to close a race
> > where the device is being suspended and the sampling
> > frequency is being written.  I'm not immediately sure what
> > the best way to fix it is. One thing that would work is to
> > do pm_runtime_get* to raise the reference counter and stop
> > there being any chance of an autosuspend.  
> 
> The mma8452_change_config() function is grabbing &data->lock, and is
> forcing chip in stand mode while applying change. This needs to be
> synchronized with mma8452_runtime_suspend() switching to standby mode,
> to avoid a race condition where mma8452_change_config() would end up
> undoing the change made by runtime PM, due to it keeping the old state
> in is_active local variable. So far it makes sense.
> 
> But I don't see the reason for mma8452_read_raw(IIO_CHAN_INFO_RAW)
> grabbing the lock for the call to mma8452_read(). And when
> mma8452_trigger_handler() calls mma8452_read() it does so without
> data->lock held.
> 
> So maybe we we can simply drop the &data->lock from mma8452_read_raw()?
> 
That does look safe to do to me as well. Everything used is
either reference counted (runtime pm in particular) or local variables
so there doesn't seem to be any reason to take the lock for it.

Thanks,

Jonathan

> /Esben

