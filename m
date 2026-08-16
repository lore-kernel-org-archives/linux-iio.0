Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A19271456;
	Sun, 16 Aug 2026 00:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786841644; cv=none; b=D1hN8uhp3bcMr2x3zD0AkwVWYVckKazPSdLR1mrHSostvBXWes9I3Eqdo/Z0cTnr44PP/U2xvQrzGpbq9t/AMjueKPn5yje/7h63akOp7IcLKCflSHusZkWYkSDRxPTCXts5cZPuneJd368nZ5CF3xb6A5oI5RyhVpSK8dHAfv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786841644; c=relaxed/simple;
	bh=15xdwW/32FQjnvIrD0UIak5lHnG6ls24PG1QQyc3PE4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TDQJadbClIkSIjfHEeVOCZ/NER9sEuj2xpnlm3fGsZxLaNG9PTGHcbde2iB+e0IPim1A64dAu9V8Sv4mbkkUorVnhrzFHoKt709pS2M1pJLzLp41gOV04B5smB+sfBe7tmH7n4QSxzbHctZ7ELC8NIqJlf46vCDg6XXchdRUADs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AnBdtDX2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AnBdtDX2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DAC21F00A3A;
	Sun, 16 Aug 2026 00:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786841642;
	bh=T3Q4a/aen9Sh6WiJ81WoHVuIvXPYrJMoJpPvEm6xiJI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=AnBdtDX2nXGaCYPeXD4O9djhBRlFkJu1E6HWw87iKHW9TXz9CpNbDYOP6sL8ZhcRb
	 kNEiNxnve2B/QLDmOuIx3KI3g4iBFLCrvSB5ApN8jgo6qhjtCEdRQ9i/hJyE8/inry
	 lHCuVAJGuB83Sdcu3FcFW446zOHDJu38bfO8seVsH02LFRqMeaqgmqFeq5bzZzoRH2
	 Zwn7KSqBXWDU7d236taRIe9pKf12uOZnqdAH6q2dqkS+0zexrcC/AnDQB4V4MKqPWs
	 kzWvv0iFw/93/aHfM/prYWNcBM8icutPzbnQrKl/4nSnWzZvos1qAdQZg8N6uhxCMF
	 cdzjbvwr5T1Xg==
Date: Sun, 16 Aug 2026 01:53:58 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Shengzhuo Wei <me@cherr.cc>, Ramona Gradinariu
 <ramona.gradinariu@analog.com>, Antoniu Miclaus
 <antoniu.miclaus@analog.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Michael Hennerich <Michael.Hennerich@analog.com>, David Lechner
 <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, Marcelo Schmitt
 <marcelo.schmitt@analog.com>, linux@analog.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: accel: adxl367: reject out-of-range FIFO
 entry count
Message-ID: <20260816015358.76f644f5@jic23-huawei>
In-Reply-To: <anwqC4tczcdnmF1u@ashevche-desk.local>
References: <20260812-adxl-fifo-v2-0-86bea20faf1c@cherr.cc>
	<20260812-adxl-fifo-v2-2-86bea20faf1c@cherr.cc>
	<anwqC4tczcdnmF1u@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 12 Aug 2026 11:08:43 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Wed, Aug 12, 2026 at 03:58:50PM +0800, Shengzhuo Wei wrote:
> > The FIFO entry count reported by the device can be as large as 1023
> > (the low byte plus the low two bits of the high byte), but fifo_buf[]
> > only has room for ADXL367_FIFO_SIZE (512) entries.
> > adxl367_push_fifo_data() passes the reported count straight to the FIFO
> > read, so a count above ADXL367_FIFO_SIZE overflows fifo_buf, a heap
> > out-of-bounds write of up to 1022 bytes into adjacent memory.
> > 
> > Rather than clamp the count and silently drop the excess, abort the
> > read: a count beyond the FIFO size means the device is returning
> > garbage, so the data cannot be trusted. The message is ratelimited
> > because a stuck device can raise the IRQ repeatedly.  
> 
> Aren't they already were discussed in linux-iio@ mailing list earlier?

I'm lost.  Yes it was discussed a few times, one of them in the v1 thread
for this.  Andy, can you be a bit more specific on what you mean here.
I for one am half asleep today so could do with the pointer!

> 
> ...
> 
> > +		dev_err_ratelimited(st->dev,
> > +				    "FIFO entry count %u exceeds FIFO size %lu\n",
> > +				    fifo_entries,
> > +				    (unsigned long)ADXL367_FIFO_SIZE);  
> 
> In majority of the explicit castings when printing a message they are wrong or
> unneeded. Use correct format specifiers to begin with.
> 
This one I agree with - why would we print it as a long unsigned given it is the
constant 512?

