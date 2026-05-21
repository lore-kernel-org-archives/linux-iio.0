Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E86383C6B;
	Thu, 21 May 2026 11:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779363459; cv=none; b=TZTM4bAHnK9tpBx9iDpKWKSMd8kbBMpeEb5IDRMZPwnQz2kDqB5RBP3v7i2x9VrYnsXE0X/24wuyvnZOrzc3zNyolPk0REHyNDVFyhe9dMEkx16pJt8kzKfhKEBIh7vZs+HpPdzyPa3PUySbILbzTVvq4/89YpzSKyCLlGjLP2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779363459; c=relaxed/simple;
	bh=47aF6857AcyWArAoF2cHPoLav220X0UrpsRiT2yk2mM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I3trc3O1I0jYTfdRZIoihEUc6cqOtahwpsAL3B4JG8WEA2Im0U6WlPBHsf+7ScPTBn/VAERVSrzOchtz9kKi4IWpot7ne3JZuBHuMCvpI4lDkuzprgngRbcYBXhBWCz9x6IHLVdGoq8xfemez4siFY6i96sgeTfsbz/k9uytqiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TZUONwHi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TZUONwHi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 815A61F000E9;
	Thu, 21 May 2026 11:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779363457;
	bh=jpfc+cFWtoph/ZB9R7Tu6Jily2VPOWNDOQ0yEftO6YE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=TZUONwHi+/1I4Jg62IrskIREapIbUEXuNXhqXjelIowWXMZd1NwkNSROPQBFjCVW1
	 3f71wteG3zP4G3PnrpJhKPSdZk4PNb24EVP93/9bid5k4c5ynmT07xT5JLd9DYbB4/
	 KaZhwyscHDqNoyFaGlUUfLOpJ7d/JuT0taAH9yEckw/+vN8sfhH6kMt6aNbq2vQ1zg
	 SaLaN8kzcHGqfPrpPPxDYaEPNB4dANkuViDQR4plPtO5V5rYXVj5RzLw8UXfkxWQkV
	 1DbLFD/Z0Z6bdORR3ubG1KTFoo4N4VSXtjQuzMsCkA/jfLXE48JKNAlJzM5DFVL38z
	 I4uEFS1Se3bDA==
Date: Thu, 21 May 2026 12:37:27 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Xingyu Wu <xingyu.wu@starfivetech.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-iio@vger.kernel.org"
 <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v1 2/2] iio: adc: Add StarFive SAR-ADC driver
Message-ID: <20260521123727.6a7d97ff@jic23-huawei>
In-Reply-To: <NTZPR01MB09564579135FBB637DA5F0F59F0E2@NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn>
References: <20260518081852.116909-1-xingyu.wu@starfivetech.com>
	<20260518081852.116909-3-xingyu.wu@starfivetech.com>
	<20260520130532.15e65a18@jic23-huawei>
	<NTZPR01MB09564579135FBB637DA5F0F59F0E2@NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

> 
> >   
> > > +
> > > +	starfive_saradc_ch_monitor_stop(priv, ch);  
> > 
> > Why stop it?  Add a comment.  We aren't interested in future events?  
> 
> If we do not stop it and the input voltage remains constant, the ADC could continuously monitor the voltage and continuously trigger interrupts for the bound.
> As a result, the CPU utilization rate will be high.

Can you use an edge interrupt instead of a level one?

If not, then a common solution is to disable for a period (maybe a second
or so) then reenable. There are various more refined ways of doing this.

Basically we don't want to be in a situation where a momentary blip
disables the event and we miss a later condition that must be handled.

Thanks,

Jonathan

