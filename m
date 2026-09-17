Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B70D3563D4;
	Thu, 17 Sep 2026 02:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789612506; cv=none; b=WiRnMKlZJ8MDEu1/dMf+rAlM3kRwkSKRYU2XgmM5FAQl77iqcRSu5javFJGiyDuUlW4JB/8Csu/qnsNmzJ8mQEtGBPRqPMaVXVO6LKVJP9aRBj8JBFObtWY9T2brF10SZs/x6LD4wS3XgyZNCkwaZSxVNLR6jnl1sghcNlOjzHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789612506; c=relaxed/simple;
	bh=PeUQ683RJlPFxP6+ceMxW3G2onzFxs4LNlFP+k5VM1o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=an5sN7b8HNhPTHtP1gw3Ud+oSShA1lPdSZ+bgxfKhD5CTkEub4Bum75yADLG6WtI3E9+y7FOn/vMxd3dmeZx9ZU1tc51fIPhxC17t6xgkiYm9NnvJ7SsxmffUNm7vhqgg6trY7THuSRefXbVh8GmR7WrBqcVM/UvhetJoFdCUAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZySDM2DC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZySDM2DC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EB7B1F000FF;
	Thu, 17 Sep 2026 02:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789612494;
	bh=K/RNf0vR2eOQ/dq8Mg/3O5B5a2js4GnbWuI/ED+6udk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ZySDM2DChW6Qq8GCYSPmYZt/Fri0cJcyI30q1ZPdGYms0FAGVnXVC9Fl4hkckA1Wu
	 /FzETTgY86IMVWm/XHoLq2ZFZ1r0f1jCL0B+kASM3n4wFwqfvWv7AlrRfOPWjjZL6O
	 ei52upwraOv+hEwRZ4AH3mhXOOrUbj9P1uWLv+i7uv77cb/q7/diFK5HaNa+ggq6Lw
	 OoJBV8ArNeYjN/fRXkSAxXQ2RJ4scasCi65CGjRFJU7qnK0WElPIiKHl2/TkyPKt6y
	 JO+oJuKSi87onhj8zoFBkz9p16NwkCeksQQIUAFtvLR+MezltiUr1SMlMLlDwxAoPn
	 nBmgwjYGt66EQ==
Date: Thu, 17 Sep 2026 03:34:48 +0100
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
Message-ID: <20260917033448.1b830f32@jic23-hlaptop>
In-Reply-To: <20260916210223.15456-1-zoone.rupert@gmail.com>
References: <20260824201203.396651-6-zoone.rupert@gmail.com>
	<178813888151.2788519.16547013180884814648.b4-review@b4>
	<20260906094622.433243-1-zoone.rupert@gmail.com>
	<20260910033636.3a2ed151@jic23-hlaptop>
	<20260916210223.15456-1-zoone.rupert@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 17 Sep 2026 00:02:23 +0300
Rupesh Majhi <zoone.rupert@gmail.com> wrote:

> On Thu, 10 Sep 2026 03:36:36 +0100
> Jonathan Cameron <jic23@kernel.org> wrote:
> 
> > Maybe we just set the minimum allowed watermark to something that
> > in practice always has a temperature (or almost does)? It's kind
> > of true that a watermark below that doesn't work because we end
> > up dropping data.  
> 
> Two temperature entries are prs_rate / tmp_rate pressure entries apart, so
> a batch needs one more than that before it is sure of catching one. The
> FIFO holds 32, so there is no such watermark once the ratio reaches 32.
> That is six of the 64 rate pairs, and one of them is pressure 32 Hz with
> temperature 1 Hz, the case that found this, which would want 33.

Ah.  So if we did go this way we'd need to cap the ratio to be sure of getting
them fast enough to always be available. Doing so doesn't sound too bad...

> 
> So I will hold them locally instead, which is what you asked for first. The
> drain timer runs at half the fill time, so nothing overflows while the
> driver waits, and the hold lasts only until the first temperature of the
> session, bounded by the rate ratio at 128 entries. The first push still
> waits for that temperature, but only once per enable, and no pressure entry
> is dropped. I will re-run the zero output regression against it.

Ok. So we get some lag if that ratio is big. Not ideal but not too bad.
> 
> > Validity flag in the data we push to userspace?  That never works because
> > we don't have a universal encoding for one.  
> 
> I meant driver state, not a channel. Moot now.
> 
> Rupesh

Jonathan


