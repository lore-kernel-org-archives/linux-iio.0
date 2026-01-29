Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8472D63E8;
	Thu, 29 Jan 2026 17:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769709071; cv=none; b=lAGcpjxObuzvE6ljizKSNXmrheM5Gh0lyblqXGpRfjqmbyUhgoqtAgOoeb9gAbik7Oun263/psaPASoG+HF5Myz7H9KeeBz78VKG9j0WWm7cQGYPtHOBzN2kj+U59v7bOwQc/c4zjkEeJytNHF1H3v2ordCZRJbx1S72VCKOPfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769709071; c=relaxed/simple;
	bh=gGrhDzMmHhjqEV1x2q6DXoxnR3xiD6ABY6Lg/ZUUzg4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MALe8SgUXa56lahoTjHBIE75iiEF/P9SCLTTsL1Nnt5SYLCug/PNUdncrhPirWUdaWwswF0/S2sdhX9mPAyBTl4ONY48vHp2wfMiafAmkewqWdQTaRDDb4PpnWq9pB1OAIW2vfw6pPY+hh6fgrp7gV/0aefjf4uZPFhdwdNzDOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f0NbzHAy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f0NbzHAy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D51EC4CEF7;
	Thu, 29 Jan 2026 17:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769709071;
	bh=gGrhDzMmHhjqEV1x2q6DXoxnR3xiD6ABY6Lg/ZUUzg4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=f0NbzHAywz92dImIOm4zMuWeK+ui+Qqy8ij4PSJyNex7Klmdd7LdiuyUPfUwKYn31
	 XEqBB4IABQouypExqe5dOo0ko1EsyMsB94YYI0VZSzzbJiWc3MVAuYiHdn7jdGPhYY
	 FkQhYHGdD14GaKwOawZBFblv+GTNVzSr4/f5g9TrQznXPzWcQgcMi4ylInnmEP1sWM
	 j6mvAtyR2vTbDL2c+PD2acT8zTpH6kAnEyoguVIr1/uiFuQ3AIqjGmzriKL19QpDIf
	 fxlAIBuIEolYKcKn3I05cJMS1DeFYLwt5VIMBeewwiIEizAcUBDg5RO/70iZAmsGjZ
	 veCCW3Wg4+riw==
Date: Thu, 29 Jan 2026 17:51:02 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: raskar.shree97@gmail.com, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 skhan@linuxfoundation.org, david.hunter.linux@gmail.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 0/6] iio: proximity: Add interrupt support for
 RFD77402
Message-ID: <20260129175102.3613bd09@jic23-huawei>
In-Reply-To: <aXqMz3TYNA3hegcX@smile.fi.intel.com>
References: <20260128-b4-rfd77402_v5-v8-0-36388fe7b95e@gmail.com>
	<aXqMz3TYNA3hegcX@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 29 Jan 2026 00:25:19 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Wed, Jan 28, 2026 at 11:21:47PM +0530, Shrikant Raskar via B4 Relay wrote:
> > This series improves the RFD77402 ToF driver by cleaning up include
> > ordering, improving resource lifetime handling, switching to kernel
> > polling helpers, and adding optional interrupt-driven operation.
> > 
> > Changes in v8:
> > - Add comment for polling timeout value.  
> 
> And mistakenly removed it...
> 
Fixed up and applied.  Given cycle cut off is effectively tonight
I didn't want to have to revisit this next cycle.

Applied to the togreg branch of iio.git
(not I'm skipping normally testing branch to get this some time
in next before I make it Greg's problem ;)

Jonathan

> > - Fix indentation for macro's.  
> 

