Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CEE5285CBC;
	Sun, 26 Jul 2026 20:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785096968; cv=none; b=f309Cy9chGxkgSSlOoe+VOSEpXZ5tvwRrC4vY+7qMVd7vKuHozbRcrc3csKx73/75fdm43JWS+v8haXFuRSRH1JNnz+M34c1vN+j2CKLLb81lq7YjsL532wW4sHEOHLr9dO4wlyNQbU+Le7xnO9fJY9JoNqyCkvmE1/7W/9MAW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785096968; c=relaxed/simple;
	bh=fcCdAr8xxH2dyKosq8WGnZhWmfEmcynozj3yOuJ11pA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NjNYlX4qp4m298iA39G0lAjyiwpkT+dfE5Y4F2v2BsOcsxpBKemZsIw6n16FhWpYkSs+E0Wup8J8dLCLfuu4d7X32svIQO6VVyc+cnPAWzs9XMaXOxlZ7b6TyFj5kIz3lCg+LXrm5HbnAPHZyXJrseN32ogFe9thmMSDiA6HeoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kMSV34bT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kMSV34bT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C56651F000E9;
	Sun, 26 Jul 2026 20:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785096965;
	bh=AFxGd3miAptodylZ/HuqfE+79F68cubA4xUFsoymyHQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=kMSV34bTOpp629cxCGpvkpWyLGBSPWftqcDCX4nEToSihMvqnx09RfkBWj2TBjiH7
	 I9DQaQQm/XAIhxgItVTE4Z02L+iLUPsNO030UaKX7NmqV4QG0hoayIIr9ihqcp778w
	 hOHjRxkuyd0KdZA54v438VSJHoJDmqrPlEee8IZsuiZuV35ndvokTMoBoacVW+xj/L
	 FAwhAs2Y4hYjrQjP2hQSQ78S1v4ckHqjF4Kma3Z2E2CckzMeko+gKxMRKo3yA+8lHr
	 n2yivhjgLS+p1VVuUSCAQrcL4KPgkrBlgCBZpP/Hip0tVecjRhgKhB1tMGyUP4SqBV
	 ypePcr3ES2RoA==
Date: Sun, 26 Jul 2026 21:16:01 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Gustavo Silva <gustavograzs@gmail.com>
Cc: Pan Chuang <panchuang@vivo.com>, David Lechner <dlechner@baylibre.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Maxwell Doose <m32285159@gmail.com>, Tomasz Duszynski
 <tduszyns@gmail.com>, Siratul Islam <email@sirat.me>, Matti Vaittinen
 <mazziesaccount@gmail.com>, "Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= (The
 Capable Hub)" <u.kleine-koenig@baylibre.com>, "open list:IIO SUBSYSTEM AND
 DRIVERS" <linux-iio@vger.kernel.org>, open list
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 03/13] iio: chemical: Remove redundant
 dev_err()/dev_err_probe()
Message-ID: <20260726211601.2b7aef65@jic23-huawei>
In-Reply-To: <20260726210830.2eca3e9a@jic23-huawei>
References: <20260724030524.607185-1-panchuang@vivo.com>
	<20260724030524.607185-4-panchuang@vivo.com>
	<amVAkbdREpNVZahV@archlinux>
	<20260726210830.2eca3e9a@jic23-huawei>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 26 Jul 2026 21:08:30 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Sat, 25 Jul 2026 20:16:15 -0300
> Gustavo Silva <gustavograzs@gmail.com> wrote:
> 
> > On Fri, Jul 24, 2026 at 11:03:38AM +0800, Pan Chuang wrote:  
> > > Since commit
> > > 55b48e23f5c4 ("genirq/devres: Add error handling in devm_request_*_irq()"),
> > > devm_request_irq() and devm_request_threaded_irq() automatically log
> > > detailed error messages on failure. Remove the now-redundant
> > > driver-specific dev_err() and dev_err_probe() calls.
> > > 
> > > Signed-off-by: Pan Chuang <panchuang@vivo.com>
> > > ---
> > >  drivers/iio/chemical/ccs811.c      | 4 +---
> > >  drivers/iio/chemical/ens160_core.c | 2 +-
> > >  drivers/iio/chemical/scd30_core.c  | 2 +-
> > >  3 files changed, 3 insertions(+), 5 deletions(-)
> > >     
> > 
> > Reviewed-by: Gustavo Silva <gustavograzs@gmail.com> # for ens160
> >   
> 
> For some reason b4 is adding a review from Andy to this one
> that I can't find either locally or on the list (not for v1
> or this).  I've edited it out by hand.
> 
> Maxwell did give a tag though on v1 so I've kept that.
Ah. Andy did give it, and the author should have picked it up
after following the condition attached in reply to v1.

> 
> Thanks,
> 
> Jonathan
> 

