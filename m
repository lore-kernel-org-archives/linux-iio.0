Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793579023;
	b=dLGDFMXXcq3RsQzUOoHQU4TQA87/dZYN2pqMeBk9aJNjf408ehXFtixAsgnP//tushrr
	 oN1PBvodZ3shs+baLQ0BjPhJ9GSw9PkHuOMWdLGbG61oyrsyIeno4+4PwQDFuW83BmW/2
	 fxgqz/Pm5nEXaDcQzL6tgdDXJMUDFe17ViatpDehcWaQ4Jv9Es/vX5J5xYYmEwtoBzaI1
	 GqevRhBJ+YYctyocpCkqE/UP2ZIYmB1jukBnudyY5e0uqwqCLtPGDydBAg9WThcLU7J+l
	 5oX5o3uz7yDiqRBP0PHat8WYbMC3JGMge6f18OleV7CH5uBP++8ajSO01i2TmtN4G2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793579023;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=1FgHrbUuzLoQZ5CeGwsD4XDZILIfyANHxWISQSXSsnE=;
	b=oLd6aae1a8+uHabFkXfvee0BsiiVWQMX9fXxHmA4739iRvsJHVFRNXM0oclk/er/imQk
	 97bgs9fhLn+UEdmDgppuYjMLPq+TvvuIMX49IOnFkF0s4YaqWgG+UD4/LEIq75olrjzIw
	 6r4zSajSCkYQPDgt0rk9HztHl2u8P0gJ3/OBN1OdpGuw+m7KMz9xhKsh8PJN1LvtMrO3e
	 YJIOD+u33QENgKEg/KdhgLetpkPkU/gfIyREbWywfAFWOOOoMIt5Hutq1lHYAWuUwM5uK
	 fnpy1sX9Tj/UubzID6NgFb+l3vaH6U9szHoyv7iNV/lj0r78Rq3je4QmNBSbM8RLHSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="V4z/LXgm";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245CB606A324
	for <linux-iio@vger.kernel.org>; Mon,  2 Nov 2026 00:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V4z/LXgm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90EA91F000C1;
	Mon,  2 Nov 2026 00:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793579022;
	bh=1FgHrbUuzLoQZ5CeGwsD4XDZILIfyANHxWISQSXSsnE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=V4z/LXgmN8xl4rw2hwXbfxsbmRJkpCx47/tWm6WWxEtXE14luANlV++iEDxbtYcXp
	 9lMZiyAJ6yem5GijW+avowtN5NZZQ7+Iutiq7TeGose3gmI7fw3FdwZRZf2b5h+gI+
	 hNceuxjyEnzwnxTXvMmrMDpas4cpD5b8l0V75RJpq/n6r/3J4JdWMyTVQmhc22c/bH
	 /WbiAIs5ZZHF/LHIP00VXhfZhMCMH74PDi1OFfV3NoUHvp7SUm2LKXYrwe3Ym4As6f
	 RyWTZhcXPUtmL4IB3hmrkB3EFogTHZgfBX7XtlHTjs01R/MvhsTWPo0Okox6ffL3jj
	 DIeL+Cz4QToRw==
Date: Mon, 2 Nov 2026 00:23:35 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Brian Norris <briannorris@chromium.org>
Cc: linux-iio@vger.kernel.org, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, David Lechner <dlechner@baylibre.com>,
 Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: Re: [PATCH v3 1/2] iio: gyro: fxas21002c: Discard
 pm_runtime_put_autosuspend() return values
Message-ID: <20261102002335.38814506@jic23-hlaptop>
In-Reply-To: <at-Q8f-BKoExUH0e@google.com>
References: <20261026032051.1004536-1-jic23@kernel.org>
	<20261026032051.1004536-2-jic23@kernel.org>
	<at-Q8f-BKoExUH0e@google.com>
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

On Mon, 26 Oct 2026 10:42:09 -0700
Brian Norris <briannorris@chromium.org> wrote:

> On Mon, Oct 26, 2026 at 03:20:50AM +0000, Jonathan Cameron wrote:
> > From: Brian Norris <briannorris@chromium.org>
> > 
> > This driver propagates the return value of pm_runtime_put_autosuspend(),
> > which is not particularly useful.
> > 
> > Returning an error code from pm_runtime_put_autosuspend() merely means
> > that it has not queued up a timer or work item to check whether or not
> > the device can be suspended and there are many perfectly valid
> > situations in which that can happen, like after writing "on" to the
> > device's runtime PM "control" attribute in sysfs for one example.
> > 
> > With the driver modified to discard the pm_runtime_put_autosuspend()
> > return value, it becomes simple to use PM_RUNTIME_ACQUIRE() and
> > guard(mutex)() to simpify two locations. At the remaining location
> > simply dicusard the return value.
> > 
> > This will facilitate a planned change of the
> > pm_runtime_put_autosuspend() return type to void in the future, similar
> > to commit 3afd8df02433 ("PM: runtime: Change pm_runtime_put() return
> > type to void").
> > 
> > Signed-off-by: Brian Norris <briannorris@chromium.org>
> > Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
> > 
> > ---
> > 
> > Brian, given this tweaked your patch a fair bit, please let me know
> > if you are fine with this. Hopefully I didn't mess anything up!  
> 
> Fine with me. Not sure if it's appropriate for "my own" patch, but:
> 
> Reviewed-by: Brian Norris <briannorris@chromium.org>

Might confuse some scripting, so dropped but I certainly appreciate
the meaning behind it!

Jonathan


