Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794886667;
	b=DCCnDzC/yX97Cxig1fL/MuFyfsiXfU66258s92SSGCSBjRYvDWGEJVJcD0iVQDWIcLgY
	 9oG62aasTXEuTywelyri8NEYNtgLaWy5X1Mb/HDuRqc1crxZ4VPmhnV1ChIB4R2bPF9eT
	 uuO7Hw66V4ITr56bunxi4YDRFUVW8GcEstiiGQBTfFp3V88lTEcU2K6GYeFMyeTNtogLQ
	 pB9jw0mbWpPOTUchj3PRhITdHO27jf5N4OS8JMpDsFlhOrBbLkgFT3mDkww0DeXpSLPhR
	 3hAoWOYCmvbQMwjXLp0yN4mDdVn+R8d2yuhTu9pXez8WFc39cFvPOw/I+o+4gM74RfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794886667;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=4AV/MAasXEtTYyfh7qcjnTdrgUPx3E4ctzJU8c4gChI=;
	b=ZDfcOcoSFW3uO1BgkLyTQiUtSArL1EnUMGWYmes/Ycuy9Pe2WAcMR10aNoR2uuYeVFYf
	 WF4rTXXxuh0nyg08EP2f5rpghTy3o9YNxa79XnfA3/4Y0+PE12fnk9YQ3Ab2+u4egBYuI
	 ZpB8VPiW90vzNmx5Q6aAzbOi/4FrVlSmgcWKglhzJZisnlLwIuymdnKiSHR/0aXrECwea
	 2BpdotfpIO9YXZ1imfy+mdlwpAwEG7+CkXux8ODTztKWmXP3QAjdBZrMVGGCf04q3PRum
	 hRU8PzldyuTGLVy2tYyIVNlTPZn0xTj3jPsYmShlkNKZe/57ixUI7tCiADBPJZEk/tg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="WQIFN5/R";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8EBF606A31C;
	Tue, 17 Nov 2026 03:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WQIFN5/R
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 143A71F000C4;
	Tue, 17 Nov 2026 03:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794886666;
	bh=4AV/MAasXEtTYyfh7qcjnTdrgUPx3E4ctzJU8c4gChI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=WQIFN5/RbBheEj54u5u4RKiKL8ak9UOT18MXWk8rNkbO1UI5Bkavbdx2X8UyArRuq
	 6puZjBq3WVDulhJh9z7Fq52K5Jgkv4K0bNq/cwlib7hoD9eNSbaCys56B2R4C6hqK5
	 AUgWJAaoY1rtuB6XTiIN4d1u4I8uvL5WC59Ov9DGEPDItJPXkgx/2xObzUSujyzVkz
	 MF0JhDkZMj4CzP0AUDUNYP2wpSlFKlFd2Y0W3HrBXkX5roEKh8IBzfLQYY/6JKws6m
	 2GZy8mkIoB5Wt6/Cuce2hcZFyDkJV8OpTXxDGqI37DMuqVGsRxjvVoZbHD94waFJUk
	 HHK0RmEgMfyCw==
Date: Tue, 17 Nov 2026 03:37:41 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Rupesh Majhi <zoone.rupert@gmail.com>
Cc: Andy Shevchenko <andy@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Eddie James <eajames@linux.ibm.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>, Arnav
 Kapoor <kapoorarnav43@gmail.com>
Subject: Re: [PATCH v2] iio: pressure: dps310: don't wait for new
 temperature in trigger handler
Message-ID: <20261117033741.39724519@jic23-hlaptop>
In-Reply-To: <20261117033153.608b124e@jic23-hlaptop>
References: <20261113230241.82046-1-zoone.rupert@gmail.com>
	<20261114013817.476f8fb9@jic23-hlaptop>
	<20261114083525.11972-1-zoone.rupert@gmail.com>
	<20261115010203.2a939bd6@jic23-hlaptop>
	<20261115183949.11591-1-zoone.rupert@gmail.com>
	<20261115203150.7faed0b1@jic23-hlaptop>
	<20261115223817.10568-1-zoone.rupert@gmail.com>
	<20261117033153.608b124e@jic23-hlaptop>
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

On Tue, 17 Nov 2026 03:31:53 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> On Mon, 16 Nov 2026 00:38:17 +0200
> Rupesh Majhi <zoone.rupert@gmail.com> wrote:
> 
> > On Sun, 15 Nov 2026 20:34:11 +0000
> > Jonathan Cameron <jic23@kernel.org> wrote:
> >   
> > > That all sounds good.  I tried to apply it to the testing branch of iio.git
> > > but I'm getting some build errors (+ a load of fuzz). I guess this
> > > has dependencies that I'm missing?  If they are fixes, then I may just have
> > > to wait until I can merge back into my tree (after they are upstream).    
> > 
> > No dependencies. It is based on fixes-togreg. On testing probe
> > hunk no longer matches and with fuzz it lands in
> > dps310_fifo_interval(). git am -3 gets it right there and it builds.
> > 
> > I can send a version on testing if that is easier.  
> I actually looked at what was messing up this time.  It was just that
> int rc; had been dropped.  It's just used locally in this patch so I
> put a declaration in.
> 
> Have just merged rc3 into the testing branch anyway as a bunch of
> other stuff is queued up on it. So hopefully what I push out in a minute
> should be good.
> 
Scratch that - I just backed out the merge as completely failed to notice
the char-misc merge was after rc3, thus little point :(  Will have to wait
for rc4 for a suitable tag to merge.

Anyhow, I cherry-picked my fixed up version and it applies fine without
that anyway.

Thanks

Jonathan

> Jonathan
> 
> > 
> > Thanks,
> > Rupesh  
> 
> 

