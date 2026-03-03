Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 639F83D75CC;
	Tue,  3 Mar 2026 21:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772573305; cv=none; b=euM+0dxdZlj3KunfJjWIoZsBa95IqfFrafgdPGFmEzmPZs1LjegXYrsu0n4pHZe5EGASfamErM8tlrCclLkmTacNtCUM9JltqF1S07QeTEt/XW2rAezbUb+ONVvKSE/RXGhxHBwUNvIc6eRGRbcL/iYpd9f91TbgLwCOYiuLeCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772573305; c=relaxed/simple;
	bh=UZYM2GM4QUIhzVjQTV+H7ZwO24LyxBOqpdPkLx4oFfM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bkvTho4337OlLeCbmSV/W4UVW75eGNfdF/hg3bMPwhoT2iGzdMKA8ejvKVWFMQgAQQbMgVAG/BkeZOenmg5rZylaY4+P+4/xmZu6HZYucLo0Rw+Ivsn4gXEk9g4FYuLtOkiT0eHPB+a33E0K6lcgkMumK2wlEwt5KzJz8Iw7AUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pNwf+kzW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pNwf+kzW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29143C116C6;
	Tue,  3 Mar 2026 21:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772573305;
	bh=UZYM2GM4QUIhzVjQTV+H7ZwO24LyxBOqpdPkLx4oFfM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pNwf+kzW6S/I6OVHpzfjq4l7pt81HUuNRgk4ib7jJApbkyHXikOSHELUUbUZNYiW6
	 TP/BpTH9qmyuplCUIDSOCmEyIcd+m3Ny+eAfRx4ct9z8ctkv/fMdpwTUs+8VNXmkhm
	 I0yhxqOF/s1TPY4h8Hx+6rttmCxC0uoxFqoxE//AgJfmuDecmAxKXxRFc9KdRpRzEo
	 pc2VPYZnOvwUvpwBoUvcAMKMJybiBYl3BhnirxHnPXxMUrg6Vs0aC6JwGyJzKW3OjY
	 n59QWWT3H4TKXHC6pKsoXMtWfozfh8p9/8PQGob4/eISI4i2iGhiaKaPF0+Sh2by8u
	 iD+drY8LJ8Bmg==
Date: Tue, 3 Mar 2026 21:28:13 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Antoniu Miclaus <antoniu.miclaus@analog.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, David
 Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Jagath Jog J
 <jagathjog1996@gmail.com>, Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>,
 Matti Vaittinen <mazziesaccount@gmail.com>, Fabio Estevam
 <festevam@denx.de>, Linus Walleij <linus.walleij@linaro.org>, Sakari Ailus
 <sakari.ailus@linux.intel.com>, Marcelo Schmitt
 <marcelo.schmitt1@gmail.com>, Eugene Zaikonnikov <ez@norphonic.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/13] iio: remove unused struct fields across
 drivers
Message-ID: <20260303212813.563c8ae5@jic23-huawei>
In-Reply-To: <20260205204532.1a49cb73@jic23-huawei>
References: <cover.1770030812.git.antoniu.miclaus@analog.com>
	<aYHDjUVQTSa4Oyrl@smile.fi.intel.com>
	<20260205204532.1a49cb73@jic23-huawei>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 5 Feb 2026 20:45:32 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> On Tue, 3 Feb 2026 11:44:45 +0200
> Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> 
> > On Mon, Feb 02, 2026 at 01:25:50PM +0200, Antoniu Miclaus wrote:  
> > > This series removes unused struct fields found across various IIO
> > > drivers. These fields were either left over from previous refactoring,
> > > or were added during development but never actually used.
> > > 
> > > Removing them reduces memory footprint slightly and improves code
> > > clarity by eliminating dead struct members that could confuse future
> > > readers.
> > > 
> > > Each patch is independent and can be merged separately as they touch
> > > different drivers with no dependencies between them.    
> > 
> > Assuming it applies cleanly and compiles,
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> > and I see in some cases it gains space.
> >   
> 
> Applied.  Thanks!
> 
Unfortunately I was a Muppet and applied this to a temporary tree
then lost it.  Now it's actually on the testing branch of iio.git.

Thanks,

Jonathan

> J
> 

