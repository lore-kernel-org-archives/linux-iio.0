Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B9635C69C;
	Thu, 10 Sep 2026 02:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789007804; cv=none; b=tGjzFoVRvo3cMujYOH9kB3m4w/GJfRGqsgvsgfmjxGuV7OA0Xmt6RU0abTKUu0UI0RewLW58YIADfIKl4BZMnhgA70ARZpTFF2zjFwdoDdRIZZmBwJmXtQx9Ih0PQDbDK2f0gY2sf8vzd73v7MGPjRKON/OVwEJ9piqFNacM5Lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789007804; c=relaxed/simple;
	bh=L5dHdGjlvlX2f/AoTLnYtCBU0xmv9u3kpziAmc32dpA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tcbWticNI6T4gcr5camyL+V9R81k4xV4khE0chz0xhbM/75DNq3jZct66jRCVgzjiaUlMvgUj/ac1M49u6jXV91ZY7qvAtmEVxANd2CMIAyWkSOxUaRFrwkYivElmpTiFKcJ8IgIWNB48O8lCfWzRb5fh/OVaqGvkNgkWVHc6NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VQzLNX0h; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VQzLNX0h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24FED1F000FF;
	Thu, 10 Sep 2026 02:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789007802;
	bh=02pFdLLcej4d8nB4rChWendWJX6dzc4stMzQZXHTcGY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=VQzLNX0h2qQjLQ7zMiivtXhCMel2ETnNSmKvNkd1P9GYbIukIjBHc73fymib9a+dt
	 V+Y8SiwmPMuJjrP6yLiC4Gt00P8SvtVsvIrsIsFVzIVbSJUXdQYNwBf2IsAR6IuMlo
	 h9ljJhDodQFfA28ioswll9eY+0nPu86PGsdy49XX+KUFq7XUNzi5Fa4QvmWX2GWx3P
	 lx0ZN9Wo4ucmAN7VDPg5u6iggHRYcQ/yqrC6HKjrFgF0F6n8UpS3EWcYO9pmA0n88F
	 IbrQ7mZQ4rLp0UtdSH8uXfEA+adSt/IYwP2XvXzwHYloXVWL1EioX+aZDt8UuJYzwy
	 R5+4geI6TP3GA==
Date: Thu, 10 Sep 2026 03:36:36 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Rupesh Majhi <zoone.rupert@gmail.com>
Cc: Andy Shevchenko <andy@kernel.org>, Bill Wendling <morbo@google.com>,
 David Lechner <dlechner@baylibre.com>, Eddie James <eajames@linux.ibm.com>,
 Joel Stanley <joel@jms.id.au>, Justin Stitt <justinstitt@google.com>,
 Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers
 <nick.desaulniers+lkml@gmail.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v6 5/6] iio: pressure: dps310: add hardware FIFO support
Message-ID: <20260910033636.3a2ed151@jic23-hlaptop>
In-Reply-To: <20260906094622.433243-1-zoone.rupert@gmail.com>
References: <20260824201203.396651-6-zoone.rupert@gmail.com>
	<178813888151.2788519.16547013180884814648.b4-review@b4>
	<20260906094622.433243-1-zoone.rupert@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun,  6 Sep 2026 12:45:04 +0300
Rupesh Majhi <zoone.rupert@gmail.com> wrote:

> On Mon, 31 Aug 2026 02:14:41 +0100
> Jonathan Cameron <jic23@kernel.org> wrote:
> 
> > Dropping data rather defeats the point of the fifo.  Can we avoid it
> > by holding them locally until we will definitely have seen a useable
> > temperature?  
> 
> The temperature is dropped too. dps310_fifo_drain() sets fifo_temp_valid
> only in its second pass but returns at "if (!scans)" first, and FIFO reads
> are destructive, so a batch that pushes nothing loses the temperature it
> read. With pressure enabled, only a batch holding one ahead of a pressure
> entry gets through.
> 
> DPS310 on a BeagleBone Black, pressure only, 32 Hz and 1 Hz, 3 s per trial:
> 
>   watermark 1  (31 ms drain):   4 of 6 enables produced nothing
>   watermark 32 (484 ms drain):  0 of 6
> 
> Other runs gave 3 of 8 and 3 of 6. Silent, nothing in dmesg.

Maybe we just set the minimum allowed watermark to something that
in practice always has a temperature (or almost does)? It's kind
of true that a watermark below that doesn't work because we end
up dropping data.

> 
> Seeding instead of holding, one temperature read in postenable, fixes it:
> 0 of 16. But TMP_RDY is cleared on read, so after a sysfs read the seed
> waits for the next conversion. Buffer enable took:
> 
>   temp 1 Hz:   661, 781, 802 ms
>   temp 32 Hz:  148, 151, 151 ms   (period is 31 ms, so this is the floor)
> 
> Timeout is 1000000/rate, and on timeout dps310_ready() reinits, putting
> PRS_CFG and TMP_CFG back to defaults. Not something I want in a buffer
> enable.
> 
> Hold across batches as you suggested, since a 31 ms batch usually has no
> temperature in it at all, or a non-blocking dps310_refresh_temp_locked()
> seed plus a validity flag?

Validity flag in the data we push to userspace?  That never works because
we don't have a universal encoding for one.

> 
> > For initial patch just reject starting the buffer if timestamps are
> > set to be captured.  
> 
> No sanctioned way that I can find. buffer->scan_timestamp is private and
> kept out of the scan mask: active_scan_mask reads 2 with in_timestamp_en
> set, and validate_scan_mask() sees the same. indio_dev->scan_timestamp is
> reachable and iio_enable_buffers() sets it before postenable:
> 
> 	if (ACCESS_PRIVATE(iio, scan_timestamp))
> 		return -EINVAL;
> 
> but it is __private, used only there and in
> iio_push_to_buffers_with_timestamp(). That, a helper, or drop the soft
> timestamp channel for now? Triggered-path timestamps are real, so I would
> rather keep those.

Given we have a user I'm fine with having a read only accessor function.
We can't drop anything already supported upstream as it would be an ABI
regression and we only do those when fixing bugs.

So just add a little helper that has the ACCESS_PRIVATE magic hidden away
in it. That stuff is really there to stop writes and ensure we have
an interface that lets us mess around with the internal storage without
changing lots of driver code.

Jonathan
> 
> Rupesh

