Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189EB35F18D;
	Thu, 26 Mar 2026 08:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774513406; cv=none; b=Bsc0M/eU33sgbPjBBI4d7M9FowqXR+deyfL9qeKTyjDIBVsXZyui6oNx3IgCuXH1Pb9WLBKksoGTIMPjJUuA2fVDnmne0Kl18LYIswtYa+ldrDqawfEFi3D189hETrclixQ001O/U3Tut2AJl+kDXwEJec/wXCA51mfMwpDWp7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774513406; c=relaxed/simple;
	bh=pybC8XmJWk7M79ssKAjW3o5ifUtzDEx+1DzJht+LwPk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nL0Z4EGRtdLaA3OpGWx7hMN1vdHC0PTpNmsLZSAiqaTqo54SXLAlH0JmQYFbEkKEctOzpunpcad3gnBoi/BAuc4naGUDL51/WMl/QcGvrMTp1ABNTWQOuln41//3uA+syjqATUT8S9OLwbomlBoRw3p+ZRMU1cLf4jRRO2p74bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ph6oa4Bn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ph6oa4Bn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A83FBC116C6;
	Thu, 26 Mar 2026 08:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774513405;
	bh=pybC8XmJWk7M79ssKAjW3o5ifUtzDEx+1DzJht+LwPk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ph6oa4BnhQoBUHCpibcRY7EphPeW5cd7cOirg8aD71zMFYjvM1R9SJVGyiIwk5Fic
	 y6/OPOgQta3YKYMaXaT5mG2U407mi4LEKhDdV7u/2wlEcyPNOibl7HTH6k8NeYwPm0
	 wm1uuFKcMNJokuT2KdhEfeBEGg9T5FN1B1qV1JruL+uIcSHFpdb6ylVwC8Iu9beHLk
	 rswrkjceeKYrP8dmG4ERnZDSaEOXHh6XjerbTCx4wAsrvzw3Syh3/RUUEV8CIAgYxL
	 7HKTwtATGIvIjKO+IdGiFJmbFw0vM9A1TRh4C6lHxerCkoZBIzyjl3H48qmWSAH5ZA
	 9fLPh7OdF5dQQ==
Date: Thu, 26 Mar 2026 08:23:17 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: "Javier Carrasco" <javier.carrasco.cruz@gmail.com>
Cc: "Aldo Conte" <aldocontelk@gmail.com>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "David Lechner" <dlechner@baylibre.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, "Andy Shevchenko"
 <andy@kernel.org>
Subject: Re: [PATCH] iio: light: veml6070: fix veml6070_read() return value
Message-ID: <20260326082317.04d78b66@jic23-huawei>
In-Reply-To: <DHC96AXSNFEZ.121C1XIAZNAMZ@gmail.com>
References: <20260325113216.170357-1-aldocontelk@gmail.com>
	<DHC96AXSNFEZ.121C1XIAZNAMZ@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 26 Mar 2026 10:30:46 +1100
"Javier Carrasco" <javier.carrasco.cruz@gmail.com> wrote:

> Hi Aldo,
> 
> On Wed Mar 25, 2026 at 10:32 PM AEDT, Aldo Conte wrote:
> > veml6070_read() computes the sensor value in ret but
> > returns 0 instead of the actual result. This causes
> > veml6070_read_raw() to always report 0.
> >
> > Return the computed value instead of 0.
> >
> > Running make W=1 returns no errors. I was unable
> > to test the patch because I do not have the hardware.
> > Found by code inspection.
> >  
> 
> The fix is correct, but not the commit it addresses.
> This bug was introduced when the guard to handle the mutex was added.
> 
> It should be:
> 
> Fixes: fc38525135dd ("iio: light: veml6070: use guard to handle mutex")
> 
Ah. A bug slipping in during that makes more sense.  Changed.

> > Fixes: bb18885ed823 ("iio: light: veml6070: add support for integration time")
> > Signed-off-by: Aldo Conte <aldocontelk@gmail.com>
> > ---
> >  drivers/iio/light/veml6070.c | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> >
> > diff --git a/drivers/iio/light/veml6070.c b/drivers/iio/light/veml6070.c
> > index 6d4483c85f30..74d7246e5225 100644
> > --- a/drivers/iio/light/veml6070.c
> > +++ b/drivers/iio/light/veml6070.c
> > @@ -134,9 +134,7 @@ static int veml6070_read(struct veml6070_data *data)
> >  	if (ret < 0)
> >  		return ret;
> >
> > -	ret = (msb << 8) | lsb;
> > -
> > -	return 0;
> > +	return (msb << 8) | lsb;
> >  }
> >
> >  static const struct iio_chan_spec veml6070_channels[] = {  
> 
> Best regards,
> Javier

