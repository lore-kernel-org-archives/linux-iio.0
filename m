Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3FC1311957;
	Mon,  2 Mar 2026 20:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772481615; cv=none; b=Prey1Ty4KhR+Qh6WXnYtC4xaHArFALsjxxMlavINEEBpLYWeumD3zRr2WQ/5ayyGq/xWQiNx7fqPzrY3jT4EkAJiKJUek1zOPiVIRZh/t0kBcNqDHwwMWRtFUx9qauZcNMd5eBEjl1xB6A0E/lVBJf5QEaPnlI09jFe3E323GSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772481615; c=relaxed/simple;
	bh=UlHTbLgLSFeoEJvabbReCtaADnfzq3lvpXXuUaAqX5E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Sv+DAOmo0X71Qsuq68YqdcMT51niY3YC8BEyORxSBVUqbyjHWlCBgXPZ247+MQvxZXxEelWuFjm2L3jaodJw4fMt0rfnWrlnPqXGaULufccgP4dAF2UH4tTVngddIPaAsQe5B2ZMeZp7hiKHqN4ELhlzkBcoLNx2F1U1IZQ1cxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=peFCLIJE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="peFCLIJE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11072C19423;
	Mon,  2 Mar 2026 20:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772481615;
	bh=UlHTbLgLSFeoEJvabbReCtaADnfzq3lvpXXuUaAqX5E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=peFCLIJEt4L7m0ciD4Hk6A1slnsB7QZNBU7BlC3EO9jw3XZSSfpsefvqgGGHZvgcb
	 ij8wmSA6cRs4CY2fapyhmRIAWnzY+RDepON6kmMAa39OAsrORSkxFhYFv+f2hLHOmB
	 HnNBXAsY5EXUYR1UD1M4kCrqWkZy9ZYVBgDWS4Pfqns0MYl1mkrdHTgekXcN7IijIj
	 KJXZ/FjtznDMsgzsROaEyeaiMOOD8cvBFWrFebAKHc7z7rpMdFU6CKa8MkK4jWuHRs
	 jfWtL0ayJ/DU7mY0IbQwCIWU11Aeh0r0cuxC8HXmuksAQH28vO/i28swUy5B8GMApf
	 pEfgvcbr5k8zg==
Date: Mon, 2 Mar 2026 20:00:05 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Felix Gu <ustc.gu@gmail.com>, Francesco Dolcini <francesco@dolcini.it>,
 =?UTF-8?B?Sm/Do28=?= Paulo =?UTF-8?B?R29uw6dhbHZlcw==?=
 <jpaulo.silvagoncalves@gmail.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, =?UTF-8?B?Sm8=?=
 =?UTF-8?B?w6Nv?= Paulo =?UTF-8?B?R29uw6dhbHZlcw==?=
 <joao.goncalves@toradex.com>, Francesco Dolcini
 <francesco.dolcini@toradex.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ti-ads1119: Replace IRQF_ONESHOT with
 IRQF_NO_THREAD
Message-ID: <20260302200005.75ad5cb1@jic23-huawei>
In-Reply-To: <d918c909-e5c9-4a9b-99e2-d458392d72c5@baylibre.com>
References: <20260303-ti-ads1119-v1-1-71b54880edf3@gmail.com>
	<d918c909-e5c9-4a9b-99e2-d458392d72c5@baylibre.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 2 Mar 2026 10:15:04 -0600
David Lechner <dlechner@baylibre.com> wrote:

> On 3/2/26 10:00 AM, Felix Gu wrote:
> > Since commit aef30c8d569c ("genirq: Warn about using IRQF_ONESHOT
> > without a threaded handler"), the IRQ core checks IRQF_ONESHOT flag
> > in IRQ request and gives a warning if there is no threaded handler.
> > 
> > Since there is no threaded handler, replace devm_request_threaded_irq
> > with devm_request_irq, and replace IRQF_ONESHOT with IRQF_NO_THREAD.
> > 
> > Fixes: a9306887eba4 ("iio: adc: ti-ads1119: Add driver")
> > Signed-off-by: Felix Gu <ustc.gu@gmail.com>
> > ---  
> Reviewed-by: David Lechner <dlechner@baylibre.com>
> 
> Although I would swap the order of paragraphs in the commit
> message. The second one is the real problem (so should go first)
> and the first one is just how the problem was found.

I rewrote the commit message along those lines and called
out why it needs IRQF_NO_THREAD.

Applied to the fixes-togreg branch of iio.git and marked for stable.

Given proximity to the patch removing the message, it may be this
will cause some slight mess in linux-next.

Thanks,

Jonathan
