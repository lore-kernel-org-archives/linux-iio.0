Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B57342532;
	Tue,  2 Jun 2026 14:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780410336; cv=none; b=j/ZRk1tafiH51vubBlBQZ4W0Wo7lw+H+dFltkwIIuhDhAvMZEi44hIWibXXYBQ4AaqDFNDrLUB6XHWWw8aB2IjCEQxh7rsENB/Q/5e87748fMl/qTl4YtU7NFZx7vm1L2xQC8llpBSahUex8dq8VPrANjOA+SCc2bg0kQFskO40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780410336; c=relaxed/simple;
	bh=gDGXiLT3JqOX8wQ9n6ii703OTT8fmAPo27/oT17JntU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WuX8c2odDqs2phoJpg0DKiSxGOx46pOtkASABrojRcYxmTXPYH7csdb1zvQ3ui/kDI2I7+4VOvvh24benaeh7YAJKMjyqQ2jrP2YRPDc55jRLrV7XL+GVqeLtyhzkyZfm3/ZDMF03SjzUDQIrn0wUMyWqLKyo1xJrwdDaVnZRVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KFxpfJnN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KFxpfJnN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FF701F00893;
	Tue,  2 Jun 2026 14:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780410335;
	bh=rms3S0PZB6SZwtbdTVXGh0F52SojebAQvTX0RudusYo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=KFxpfJnNYyAJJeNh9/dFdRZhEdbvESeQTpBB+GYXLnzwRMUF/GJ+t+eGg0ldx7Ef8
	 xMQfyrV6Y3SEaoTkGLV2nruV2QxwgCRlzW3FN6Wx7NJZxWFhwINz/4d4o8ODOr2P9R
	 AvPhr2/goj2idswGNh3wmNqTkCvcQLnQKXanX3FcZl/bbee4DRIOimCE3msoMadifZ
	 sRNzN9tn9tBFkMGXCsTAXYcX2BdctYMIypFnbSfAArk7bIPMIROJ7qcy1FW1ukKwOj
	 O7pLaL2OmDBIwplMFt1V6s9fI8jnEdfA7xlQrwqEFt88JNzr7cal9PRcJUYBUP7xJe
	 FiUY5B0SCLUnA==
Date: Tue, 2 Jun 2026 15:25:27 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Antoniu Miclaus <antoniu.miclaus@analog.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Michael Hennerich <Michael.Hennerich@analog.com>,
 David Lechner <dlechner@baylibre.com>, linux-iio@vger.kernel.org,
 linux@analog.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ad4080: fix AD4880 chip ID
Message-ID: <20260602152527.1ae1303e@jic23-huawei>
In-Reply-To: <CALoEA-wZhXnLrAcW+k81p8ifFp=WpF7DVA+35H9oLDhGKR6cdA@mail.gmail.com>
References: <20260602084019.2564-1-antoniu.miclaus@analog.com>
	<CALoEA-yz-kJGHXDC=Fwmi1C9P_EpEcimxt=9a94vv6eAHQ-TXg@mail.gmail.com>
	<20260602134417.5fd78512@jic23-huawei>
	<CALoEA-wZhXnLrAcW+k81p8ifFp=WpF7DVA+35H9oLDhGKR6cdA@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 2 Jun 2026 16:02:48 +0200
Joshua Crofts <joshua.crofts1@gmail.com> wrote:

> On Tue, 2 Jun 2026 at 14:44, Jonathan Cameron <jic23@kernel.org> wrote:
> > Applied but I dropped the fixes tag because it causes pain for me to have
> > references within my tree near merge windows and it will all be in the same
> > pull request anyway.  Note it had changed because I had to do some surgery
> > on the tree a few days ago.  
> 
> Hey Jonathan,
> 
> Just letting you know that your Signed-off-by tag is missing in the commit
> in the togreg branch.
> 

Thanks. Fat fingered it.

Fixed up.
