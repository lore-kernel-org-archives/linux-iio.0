Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94BD33AEF4E;
	Mon, 21 Sep 2026 23:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790034836; cv=none; b=g34ORxYAfNrJ8d4rNgjd575+BXRBLbbQPJJU2vjxpbGTEmZpVyisWiFKbRSRjseT8OUBC4n0QeRnfDHnYYyA5ZZYp7LrT0KplQ8P8X5DoW8sulhkv9rpCaTLaf3MDZxhllMjlNk1Jm/k2O5QM0X/pm3H+EopmzfWMAZzBagTgYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790034836; c=relaxed/simple;
	bh=ZGRK0sDG/XpSMHc4Lhho3n007+8QFLF2F76F2fxTV04=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R6ItKC1Pa0c9XzVEYTi0xLnNUPl3rHrchRilErA3IAEYA/fSJPyAJoRazocZ16GeTV1Snb+n7O8QSTz8ZWHJm1Fbqlmmy1F6vuwXHVaYkA7Vb7iwtjnk0sM7iPdArXKQX+oiDqzhBSRSzIE/RPWPgLl/AjFAynfK2Km6P+SB9cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JeuEKLq4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JeuEKLq4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 529F81F000FF;
	Mon, 21 Sep 2026 23:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790034832;
	bh=diy5dTMuGN9SnimJ6pKCOC3PsKM87clvjh/CmMiUvFs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=JeuEKLq4RJROUUy6nZnZJNjbsQbdfs6em8G330IU3kWgjngY4t1B6ZkqnnnATDs6Q
	 TqUb3KPumdGRc8jL7lJO+SFXK1XfHRJc1o9qolQbHksLuSQTeIjgXVIIvBbzPN9/17
	 WCIGg7ziNdzLRhjuQkgyG2/g1CpD+2FcfMFkrXfI3T99Wpu61orM77H3rPwNsSxINS
	 tqCpttMf+hoiEGJYsA06v9ZrNJqpqjfrxckTWn2R8Na5Wq4ZZUw3EUkcGT8+BJY7a4
	 GuM91FTSCr9ZjSAY2WPYafJWXkaNUSxtXWQzVnr4/hrY9ybgqFleHR0Vh/5Y37Q2Nt
	 k9Z2W+G1XaAGg==
Date: Tue, 22 Sep 2026 00:53:47 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Rupesh Majhi <zoone.rupert@gmail.com>
Cc: Andy Shevchenko <andy@kernel.org>, Bill Wendling <morbo@google.com>,
 David Lechner <dlechner@baylibre.com>, Eddie James <eajames@linux.ibm.com>,
 Joel Stanley <joel@jms.id.au>, Justin Stitt <justinstitt@google.com>,
 Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers
 <ndesaulniers@google.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev
Subject: Re: [PATCH v7 09/10] iio: pressure: dps310: implement
 .hwfifo_flush_to_buffer()
Message-ID: <20260922005347.069c490e@jic23-hlaptop>
In-Reply-To: <20260921183106.231972-1-zoone.rupert@gmail.com>
References: <20260918122517.377565-1-zoone.rupert@gmail.com>
	<20260918122517.377565-10-zoone.rupert@gmail.com>
	<178992913316.706584.1446996024286841775.b4-review@b4>
	<20260921183106.231972-1-zoone.rupert@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 21 Sep 2026 21:31:06 +0300
Rupesh Majhi <zoone.rupert@gmail.com> wrote:

> On Sun, 20 Sep 2026 19:32:13 +0100
> Jonathan Cameron <jic23@kernel.org> wrote:
> 
> > As talked abotu above, I think iio_device_claim_buffer_mode()
> > will do the job here as it stops the IIO core transitioning between
> > modes until afte this is done with the active_scan_mask.  
> 
> It does, but patch 10 then warns on it:
> 
>   dps310.c:1233:2: warning: releasing mutex 'iio' that was not held
>                    [-Wthread-safety-analysis]
> 
> clang 23.1.2, CONFIG_WARN_CONTEXT_ANALYSIS=y. There is a
> DEFINE_GUARD_COND for direct mode but none for buffer mode, so clang
> cannot follow the conditional claim. v8 holds the same lock over the
> same span with IIO_DEV_GUARD_CURRENT_MODE() and the mode check that was
> already there. If you would rather have the named API, say so and I
> will add the buffer mode guard and ACQUIRE macro to the core first.

Adding the guard is fine - we kicked that back a while ago simply
due to lack of users. Is there a path to annotating the non
ACQUIRE.. functions to expose the right information to clang?

I did similar for sparse and at least the direct_mode claims
a while back. This might be a case of it just gets too complex
though and the compiler fails to figure out what is wrong.

Jonathan

> 
> Rupesh

