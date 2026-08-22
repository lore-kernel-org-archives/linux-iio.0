Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684D13093CF;
	Sat, 22 Aug 2026 02:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787365804; cv=none; b=N4zorI3WHzLGdNR7VHMdEpNlgE4Row384SP53gf41+Vv4jtHzA/yo0iAou7vWhbqr4OTMiZfZmDA7jAFkSY7gc/+wRV41mww/xVCvu9CZ8C4fuNGPvkattW4ykaLFPCOmkaPPmOTGt9hhbqVy7mtEBSG+IfsigraatNBf0JJ4rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787365804; c=relaxed/simple;
	bh=+Xf2JttNZz1iQicBNtxFuW0/0ot0Hs7waU+xUCehz4s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n5ttEBtWPDTJg0EbexakjX5DLfXwFNOxM6R7vVh0CjC0ataO42DNbp5r1npVfidYLHaMQj+4oO2RlkOsoILWiKY4ClWbQ0dFPEUiYxkXiaOEJWfE6irIDghYTob26SwCR7eS8q6+CYr8Q/PpRKqrHKmyAiBtoTY1q7OqM+4vkQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PJBZpZuV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PJBZpZuV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1BA81F000E9;
	Sat, 22 Aug 2026 02:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787365803;
	bh=1O9wIJGkabF2WSu9mbg3kmSQ31EGwqG0dpLjdbNl3Ag=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=PJBZpZuVS7shzbeewaZwVh9LR9bn/AQcz1MPgIJG5/A7oqWgKcxtkJDleFgdzumt1
	 aPef1+WKrkEwHjsIUWKtueJufP7S8YC1pL4G8bUcN0PHV0JNnRIbr75RTvFq1dPgCe
	 2bkvM1skgHbDP/X+B6ImH1EM/+mci2yIBzgdQDjUHzZOvaPnbc/ymVMyhoIHTme9Vd
	 YnWpZLe8DlwH1BdzGF0MmuQWOoS0ih7uWfsXCtC2IxD3MAXSezukKkdS6X7BzwJNjh
	 rOvQTkLv1yMQjrv4KQA4M9cREvYNpkI0QgyJWdDmNa5MimFUi+NX0LSShm1avq3LOk
	 zBvpoAeF+7Hmw==
Date: Sat, 22 Aug 2026 03:29:57 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Tsz Shan Chan <tsz.chan.dev@gmail.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Tsz Shan Chan <tchan@jacques.com.au>
Subject: Re: [PATCH v2 0/2] iio: light: vcnl4000: support shared IRQs
Message-ID: <20260822032957.15e3f3cc@jic23-huawei>
In-Reply-To: <aoLorPM301oeipKz@ashevche-desk.local>
References: <20260814-vcnl4000-v2-0-9b771290cc1d@jacques.com.au>
	<aoLorPM301oeipKz@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 17 Aug 2026 13:55:40 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Fri, Aug 14, 2026 at 02:30:41PM +1000, Tsz Shan Chan wrote:
> > This series contains two changes for the vcnl4000 driver.
> > 
> > Patch 1 makes .num_channels match .channels for vcnl4200. vcnl4040 and
> > vcnl4000 channel arrays have the same size, so no functional change.
> > 
> > Patch 2 adds shared IRQ support. It changes the trigger type from
> > falling edge to low level and adds IRQF_SHARED. The IRQ handlers return
> > IRQ_NONE when the device did not generate the interrupt.  
> 
> LGTM,
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> 
See sashiko
https://sashiko.dev/#/patchset/20260814-vcnl4000-v2-0-9b771290cc1d%40jacques.com.au

It might be wrong and there isn't a race condition that ends you
with that condition of stuck level interrupt.  If so just reply here to explain why.

The one about even disabling is a common issue - the IIO core has
not explicit tracking of what events are enabled so it is up to the
driver to quiesce anything necessary on the path down. I didn't look closely
at these reports though so they may or may not be correct!

Thanks,

Jonathan
