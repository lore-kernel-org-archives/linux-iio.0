Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C88B640
	for <linux-iio@vger.kernel.org>; Wed,  1 Jul 2026 00:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782864601; cv=none; b=MsYeb/mNa7IRvQFqj6vpUsH79x4t0zDoeKMx6iUXYPUzh9REoXUDL3PF9ekzxP+cH3UgmRt/XcNUwKl2NYFDn6VLOloCPvKEnilQ/ubY8hRPkUBwZfTk6SjNS7NMqgaxOE//GGUBx8TIm+iJ8D9nmtetj0mawemx/twUEUyVXuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782864601; c=relaxed/simple;
	bh=SEQLmtxMe8RdxfHiK7GNeVAWs6Awb7VnGTOmu6ad7jc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WPTFz+QPJz7kkyeVrnEvxc9u5PrSeg07fEGeLjl2Dwd/S/qRMcMRPCFaL5iYdWKVbdZ+I8i9vht41Jtzf9CquXCDONwuQ4CECJf2zqdWYv0zPPytafeFiT1LspqJR6pYoJANl7gkEZd14YNTO5N9T9SiU3Z3bTx7gQXj7I/as50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DF7aHuvb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DF7aHuvb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C55C1F000E9;
	Wed,  1 Jul 2026 00:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782864599;
	bh=vBWaQL5935fcZhzh4xsoVZjX2A+kFqey2J9kqFgMaE0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=DF7aHuvba4r4ERXwQlApWB62cFM0K7jmwhnVJZRuxzYfKr8C12yk+45fkJSFpo7Ua
	 FC08BYPzrouXfWaqWpkna7HF9A5yQSZ4Vm4IDPhSulj2vrniqJXwyKOHlNeWAA6joC
	 Ptlb63CbSoQS2R8sZp49fMRfJHOcN/fL7Zcg5Fo7Jy6XFrk4gQUurSO0e+6iPEHxM9
	 2+YkV3TKBLqDP/Ht8gEztJf/3vhRScJJqoDGheN0zYjkY0PEFON9RhHVkFrNMlO0JO
	 frk6B0H9bza2/j2j6VXTHgT5jjrrsFGuoZUNFcQwLsUFyNU0qoeROJX1an0HHN6Po0
	 /MKFGpEu/JjOQ==
Date: Wed, 1 Jul 2026 01:09:54 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Erick Henrique <erick.henrique.rodrigues@usp.br>
Cc: andriy.shevchenko@intel.com, andy@kernel.org, dlechner@baylibre.com,
 nuno.sa@analog.com, joshua.crofts1@gmail.com, linux-iio@vger.kernel.org
Subject: Re: [PATCH v1 0/1] iio: dac: m62332: Fix regulator reference count
 imbalance
Message-ID: <20260701010954.68746703@jic23-huawei>
In-Reply-To: <20260630021309.36636-1-erick.henrique.rodrigues@usp.br>
References: <20260630021309.36636-1-erick.henrique.rodrigues@usp.br>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 29 Jun 2026 23:13:08 -0300
Erick Henrique <erick.henrique.rodrigues@usp.br> wrote:

> m62332_set_value() enables the Vcc regulator on every write of a non-zero
> value and disables it on every write of zero, without tracking the
> channel's current state, so a non-zero-to-non-zero change leaks an enable
> and leaves the reference-counted regulator on. This gates enable/disable
> on the stored per-channel value so the regulator is enabled exactly while
> a channel is active.
Normally I'd push back on cover letters for single patch series, but
the next bit here is perhaps enough to justify one.  It could have
gone under the --- in the patch though.
> 
> This is an independent bug fix, based on mainline rather than on the
> in-flight header-cleanup series for this driver
> (https://lore.kernel.org/r/20260628034811.152946-1-erick.henrique.rodrigues@usp.br).
> The two touch the same function and so will conflict; the fix is
> deliberately based on mainline so it backports cleanly to stable. Happy to
> reorder behind the cleanup, or rebase either on the other, whichever you
> prefer.
> 
Fixes almost always go first. So the other series will need rebasing
on top of the v2 of this.

Thanks

Jonathan

> Erick Henrique (1):
>   iio: dac: m62332: Fix regulator reference count imbalance
> 
>  drivers/iio/dac/m62332.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> 
> base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494

