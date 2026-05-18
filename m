Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6DBD3793B5;
	Mon, 18 May 2026 15:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779117976; cv=none; b=tT1tQFeO/MvzEMq/MVZGPCPO3xGHwd03359CMWVdRy+yBpv5w35EIke697Gqi4hoq7u+A/HmVKHYnE6A6fiKE/lXCN2w2PSMucX6z/Ik75BfDpRGvxgLnsH/UkB6xSrEm7HByntiB9YKeL6Gw9UPksD3PjWN2nTOCRXQVelVgF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779117976; c=relaxed/simple;
	bh=K/xg1HQ36envx4rozYI3LidpAGiVelKOMj7olctr90s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=px8zZN8LCaiL5Gqx1xAyooEubVKXOAQzSMASCxgMrAbAEf5Lff2jxlY8PcYxXTmXjBKpzIE4yKL2wpHpLUhnJ5w181qWpMG3m66R2EYm7SKZ85tkYJd5R+UxaqhdvkikVWeIkmLD+ymmSA2grQ60tDFgtYNbqHbgPQ85TMfA92o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PlRAG57p; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PlRAG57p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B988BC2BCB7;
	Mon, 18 May 2026 15:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779117976;
	bh=K/xg1HQ36envx4rozYI3LidpAGiVelKOMj7olctr90s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PlRAG57pcnkNEucBpLqFDogW8PkTDi8xvOf3MFtbdy2c6zX1L9zDqImpISYpmRXeV
	 DbKyohYanNe7YOKzNN4+R1QnkEutkTT/oavNdAkceSPTSaLWWTwAru+a187k+vAQtB
	 eEJtrmH6Xrsw+zEHm8j1hYOVc1grNNeWhHseSOZLfUHczaAqNHhOArbXZuz99Rpxad
	 SuKFB0Y9UnmQGtM7KXMbXo/ng3jvsFCQCxDd+7YoN9/8eeuBucQsDgu0rrM0kt8sas
	 y/Lv+MzkCsSyRy5xbWwq3noAB/pHBVkyj16iP4tWkmPLr8uXyPXtScCsj6FmpKYABq
	 7yT2TQNOY4jWA==
Date: Mon, 18 May 2026 16:26:07 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: light: veml3328: add devicetree binding for
 new sensor
Message-ID: <20260518162607.06494368@jic23-huawei>
In-Reply-To: <CALoEA-wrMkqvqDVPDUSbVSQNF56CB3R84Ch5=nX+8aJqmYxDhw@mail.gmail.com>
References: <20260516-veml3328-v1-0-1d4b663e2fe3@gmail.com>
	<20260516-veml3328-v1-1-1d4b663e2fe3@gmail.com>
	<20260517141054.3981672c@jic23-huawei>
	<CALoEA-yk9dJFx=pjjm-=UmTi6Wzx1crLswFfGC2QtPMCP2834Q@mail.gmail.com>
	<CALoEA-wrMkqvqDVPDUSbVSQNF56CB3R84Ch5=nX+8aJqmYxDhw@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 18 May 2026 16:18:37 +0200
Joshua Crofts <joshua.crofts1@gmail.com> wrote:

> On Sun, 17 May 2026 at 16:26, Joshua Crofts <joshua.crofts1@gmail.com> wrote:
> >
> > On Sun, 17 May 2026 at 15:11, Jonathan Cameron <jic23@kernel.org> wrote:  
> > >
> > > On Sat, 16 May 2026 23:50:53 +0200
> > > Joshua Crofts <joshua.crofts1@gmail.com> wrote:
> > >  
> > > > Add devicetree binding for the Vishay VEML3328 RGB/IR light sensor
> > > > connected via I2C (SMBus compatible).
> > > >
> > > > Additionally, add an entry in MAINTAINERS.
> > > >
> > > > Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>  
> > >
> > > This is very standard looking. Have you considered if any similar
> > > bindings can be easily extended to cover this device?
> > >
> > > Note that there is no direct relationship between bindings and
> > > drivers, there are single bindings with multiple associated drivers
> > > and multiple bindings covered by a single driver.
> > > Also dt-bindings get used in multiple projects and some of those
> > > will do different splits in what code covers what parts.  
> >
> > Hmm, now that I think about it, the VEML6030 binding could be easily
> > extended to support this device - oh well, should've checked earlier
> > and it would've saved me a headache.  
> 
> Before I forget, any idea if I should add an F: reference in the MAINTAINERS
> file if I'm just expanding an existing .yaml file? Given I'm not the maintainer
> of it, I'd expect to just have a reference to the actual driver file and not the
> binding.

I wouldn't bother.  This one is simple enough a breaking change is unlikely!

J
> 
> Thanks.
> 

