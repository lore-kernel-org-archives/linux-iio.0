Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE804406273
	for <linux-iio@vger.kernel.org>; Mon, 11 May 2026 15:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778514797; cv=none; b=rd3b6iH8imbBjQkqGZe5nysWT3NR0lQO+fV6/QVc5zq58iEbZ/v2vNy/FeEMpYubKxLvZ2Kxbrcsl0PcGe3e8uJ2QTc6oVGc8VIsbOmbXDWRI3ejvq2jbrIyNZJJr0krm7G/VlBRuWZBIVgBsGm3zfY77jpb9MEyRnOvMYvZZpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778514797; c=relaxed/simple;
	bh=v3dNsMueBYTusGifZdK5zFccz+ZPHAQ+kSDGuwD4FlI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gBU3Nn6a+72JnxYSXUIhv46MwxKFy6mG+hh707TzhTisetjHKNVF8oCOBagLp9ZmBKAINve9Kr2ssHDv9/+k3j+7BK4eOWa3zWf3wRTlEMtqtz+gU7P31UagWqjgbl0shE3qU13R7GfOsWvEBb6SXavo8Q/3tf7B43N2r8pl90k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iVjrM9Gi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iVjrM9Gi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4B8FC2BCB0;
	Mon, 11 May 2026 15:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778514797;
	bh=v3dNsMueBYTusGifZdK5zFccz+ZPHAQ+kSDGuwD4FlI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iVjrM9GikdwA39kEGurrkxgSGzESJQdVMCDO4yD6/X1g1+LEq6DWCA/2BZxQBrvig
	 cK/8lvf/WoRuy1RE15VmLY3uDhhxoejCHNag0XuT+WyyWG7vxVqZVCj7ZSWsGBON+Q
	 vUrgZ9c4gToFwT+eQfLHN9udwHjnA5P8BqzmRC+/JaN/AL14yixutFNuLfao2qt3fG
	 IH5pdc9rplMBr12hc5IegbscX3DR6V8FXX4JBCgvDDBNCtiW+pBeM6VssNtEwrch8h
	 Qai91RyLN7Y2EDt7tWaf08DQu9fLtSenI+QpPrWEqDtva91NnB5Fyi5+crXOUT72Fz
	 fqCxEbAWKHyag==
Date: Mon, 11 May 2026 16:53:10 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
Cc: linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>
Subject: Re: [RFC 0/4] iio: light: add driver for Broadcom APDS9999
Message-ID: <20260511165310.2c439cbc@jic23-huawei>
In-Reply-To: <agHzLu-W7MBNXxmx@gmail.com>
References: <cover.1778491503.git.azpijr@gmail.com>
	<20260511132112.66246dc8@jic23-huawei>
	<agHzLu-W7MBNXxmx@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 11 May 2026 17:19:54 +0200
"Jose A. Perez de Azpillaga" <azpijr@gmail.com> wrote:

> On Mon, May 11, 2026 at 01:21:12PM +0100, Jonathan Cameron wrote:
> > On Mon, 11 May 2026 12:14:42 +0200
> > "Jose A. Perez de Azpillaga" <azpijr@gmail.com> wrote:
> >  
> > > This series adds support for the Broadcom APDS9999 ambient light
> > > sensor. The APDS9999 is a digital proximity and RGB sensor with
> > > ALS capability, featuring I2C interface, programmable gain and
> > > integration time.
> > >
> > > This chip is considered by Broadcom to be the 'successor' to the
> > > APDS-9960 which has technically been discontinued.
> > >
> > > The initial driver implements the ALS/Lux functionality using the
> > > green channel, which approximates the human eye spectral response.  
> >
> > That's not normally a good approximation unless it is also has
> > very bad colour curves for green!  Better than any other channel
> > on it's own but still not good. If we had calibrated sRGB it would be:
> >
> >  Something like: 0.2126R+0.7152G+0.0722B
> > for example.
> >
> > The lux vs white light and lux vs incandecent light are fairly linear
> > so 'maybe' it's good enough but it's a bit of a stretch to describe it
> > as an illuminance measure which is what we'd need for it to be measured
> > in lux.  
> 
> the datasheet states: "Approximates human eye response with green
> channel" and "Uses optical coating technology to emulate human eye
> spectral response."
Hehe. Marketing. They provide the light curves that show it approximates
very well the green part of human eye spectral response and very badly the
rest of it! :)

> 
> that's the reason why I chose to use green channel.
> 
> > So I'm on the fence at the moment.  We might be better off teaching userspace
> > code to do it's own approximation if it has an RGB sensor.  
> 
> I'll also add IIO_INTENSITY channels for R, G, B in v2 so userspace can
> comapute its own weighted lux if it prefers.
> 
> --
> jose a. p-a
> 

