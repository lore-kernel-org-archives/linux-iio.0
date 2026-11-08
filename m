Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794169539;
	b=gwPKG4e6g960O79N1svlAucQNbllHCtKmeqJqu1lK0xgJ7eib4r3jsD+GXOiS8EkToNq
	 e+zhc98OZ3lOzDECmLaNvTp6hK6gRQxWhdhNV71xd+DmqvvxNXcjKeCUaY9os0fQiF1nv
	 QzKJB6f5nT8b0C2jwENhKUewE8oMhqcMM4f2z7HSeJCKO9tRQjbaxCERkxC8TB68yR0Rf
	 RwcLWDD1xp2u/iL0u62tcj8XvXP5MEHLSZN0JUE8bgNmE0z/f+X4QH+CpjG8TW7H0UiOT
	 8BVHCKqBFYcpTqIcukHHqiPxLIdU4IzHVB+9QPh2nQ1m8UYCsTsR/3vE295tcfk9W+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794169539;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=62AVhf0POHWHUUtjB2014242u5WisVDmsGTBMibsHeo=;
	b=3R1WlHsa85hFRCmPLw0duw5uRN6Xwy+MWJ6ZNO0WLJ9wlMzdKuwRwlaFqJ7y2eCV1hYQ
	 bwjiC90zkciprjv02i3Wo35OOlkuuRmVe1A5qLvXgr0IznoXfrPF3cGu+Kaa7NPjbranv
	 O5Nh6FYEM164fyzkVNHRDOgSfUupeqzCy/rz3lkSC+UOFqX64tnJezRoK0upysKnowQWr
	 2CLeEt3TmuipkAUk2ajGjQO1K/53OjEnq39O8zUJe6wTHEhkaPAMoDnK4WKVRPGqgpSXN
	 8F8nkTCcSohm+QLG5Ec/95Dxsbs/V9u8MzlPxfGPfRAnH1hG72bO6zupa4UcbJA0qXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DYCa7iDl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6521608655C
	for <linux-iio@vger.kernel.org>; Sun,  8 Nov 2026 20:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DYCa7iDl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0221F1F0089F;
	Sun,  8 Nov 2026 20:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794169538;
	bh=62AVhf0POHWHUUtjB2014242u5WisVDmsGTBMibsHeo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=DYCa7iDlOp1yuSsM86yXYG+mPMzfSQjqbv56qmenSbfBVzm9QhteVG++rwkjjUhSx
	 8bThWekJNNtbBi3TlP4lPLbzlk8QgoS0if0PceE6JOSAI0dyLkTchV2cZP3MQ1jB87
	 Pl9OTYcZgymlFjRqxSkO7QxRY1YRihi038CpDgjOXNYcFMx9tB+QPcXBtPZIp/50Ib
	 npysqEgLSrdoO3qA/z0JLSu/n/8Ebev7eyLRib/JheGT33k3T3jpWEzuc5Pn94mmpP
	 OZ+KxXU+FYQzwY+MfNzlNFxDXHdHWmdgsK5ncaiw3KS1eLiMTFyMvwWURbM77kSKDi
	 zfYh55+zsQZcg==
Date: Sun, 8 Nov 2026 20:25:32 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Yash Suthar <yashsuthar983@gmail.com>
Subject: Re: [PATCH 35/39] iio: accel: bmc150-accel-core: use
 iio_push_to_buffers_with_ts()
Message-ID: <20261108202532.43de9a1d@jic23-hlaptop>
In-Reply-To: <auB8rKIaXGRfai6b@ashevche-desk.local>
References: <20261026-iio-v1-0-8b136778eedf@oss.qualcomm.com>
	<20261026-iio-v1-35-8b136778eedf@oss.qualcomm.com>
	<auB8rKIaXGRfai6b@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 27 Oct 2026 12:27:56 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Mon, Oct 26, 2026 at 04:05:53PM -0700, Jonathan Cameron wrote:
> > Replace the deprecated iio_push_to_buffers_with_timestamp() with
> > iio_push_to_buffers_with_ts(), passing the size of the pushed buffer,
> > at both call sites.
> > 
> > The triggered buffer handler read into a separate fixed buffer rather
> > than the scan buffer used for the FIFO path. Use the scan buffer
> > directly and drop the now unused buffer field. This also corrects the
> > type of the read destination to __le16 to match the scan buffer's
> > channels array. Widen the mutex-held region to cover the use of scan.  
> 
> ...
> 
> >  	u8 fifo_mode, watermark;
> > -	s16 buffer[8];  
> 
> I have a weak memory that I have seen a patch that reuses scan buffer instead
> of dedicated one, but I'm not sure if it was against this driver (and if so,
> why it got not applied).
> 
> It might be this one 8c5f649119f4 ("iio: accel: kionix-kx022a: use scan struct
> for one-shot and trigger reads").
> 
There was indeed a discussion for this driver that touched on this for this
driver.  That also included a dma safety fix that I don't have here! 

https://lore.kernel.org/all/20260825085156.212042-1-yashsuthar983@gmail.com/

+CC Yash in case they intend to come back to this topic.

If not I'll come back to this one when I get to the nasty
conversions and come up with a combination of Yash's series and
the interface change this one is focused on.

Thanks and impressive memory given how many similar patches
we've had come past recently!

Jonathan


