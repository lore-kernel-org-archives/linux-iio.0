Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476FC3A16A8;
	Thu, 17 Sep 2026 02:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789613261; cv=none; b=h11JoNZF1e8TqS9UFRaEZRBJmyMzxr+fD2kw2LVIYr6ndGhkgGmx99l0KaEu4V8OaF/1RJUbW1Zm4DIDH8SMcbAZT/MnKleQU+/ALkfVWyrRDp9QrLwHEmqMd/3IUzWtKgpYCd3WO2MQLu9SSylYgTzFb+S+qFqrckibPOcPqJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789613261; c=relaxed/simple;
	bh=cW9a+Zha04E7NdiDvF2rIhx90nn1CbbVnVtobvjwMEM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EP7+ycKd5gAU8OeJJdxl3s40iETaxSN3CVmc5mU4jLNq6Tn3qSClTqjBqTgOao73yzU8qjK8TvjG6bG1dzM4+5OG2GMkaKbf+iJG0aT7SviozkLY4lPOuWAA1u6mR8U3pdthRVZ5zlGNLSi5WkqO9zklbkKAMjnC/X4Eg67AC4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zfb0JbS6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zfb0JbS6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F297C1F000FF;
	Thu, 17 Sep 2026 02:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789613247;
	bh=kVK2Vn7JyZo+wndIvq70KStvvJyJbbwuCVCogF5MB6U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Zfb0JbS6L3eUX7KPYx9b/x9RrEfG2GFcTtoroZEJDdIpY2+q/iyCbz9+SbjM24qHu
	 DlLVYQTvh8RGTQ/zP7KOh+CmZapL5mULM0L6hjsJKuqSil0BHC4joaXMrtjUXRTjTc
	 D46bF4sno+Z5DkKI969onKWitnEsCfycARAxXalubFRTBqrT/+pase9RapfeAoEO17
	 zOnt+VcuoCV9xyYeJgpoV4saww99ntCBK+mzDyX7tAOf0FA9uLgr6ij7VFTpH6lvMV
	 NzSrY3iJlJATsxdjzP5PpMwgKDEvo4OEiGDXfMR4EK3cnuwOf6DrMvLk3rQb/IUGGW
	 au1hiYmSOmRMA==
Date: Thu, 17 Sep 2026 03:47:21 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Esben Haabendal <esben@geanix.com>
Cc: "Lars-Peter Clausen" <lars@metafoo.de>, "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley"
 <conor+dt@kernel.org>, "Martin Kepplinger" <martink@posteo.de>, "Sean
 Nyekjaer" <sean@geanix.com>, "David Lechner" <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, "Andy Shevchenko" <andy@kernel.org>,
 "Martin Kepplinger" <martin.kepplinger@theobroma-systems.com>, "Christoph
 Muellner" <christoph.muellner@theobroma-systems.com>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 9/9] iio: accel: mma8452: Support interrupt sharing
Message-ID: <20260917034721.0f4a8701@jic23-hlaptop>
In-Reply-To: <87pkyfox0i.fsf@geanix.com>
References: <20260907-mma8452-open-drain-v8-0-c17407e22118@geanix.com>
	<20260907-mma8452-open-drain-v8-9-c17407e22118@geanix.com>
	<_9NG2PCqwv-AxkrhQVOkPVIgvYD4-t2CFH5W5HVBmr35w9xmX9v9FIraB1OPE8Ssbd_pjQqM-bq3DEAtRl78Sg==@protonmail.internalid>
	<20260914002203.5ca07dd0@jic23-hlaptop>
	<lU80OLl5Xk_Bte8Klo69TR6a5JIitMP_N_IXZFIWkRKUmrV6NFHrMHxp1PUFoo8hb3OpKPo_4R2QWBYpfOLFJw==@protonmail.internalid>
	<87y0d4pal0.fsf@geanix.com>
	<87pkyfox0i.fsf@geanix.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 15 Sep 2026 08:21:17 +0200
Esben Haabendal <esben@geanix.com> wrote:

> "Esben Haabendal" <esben@geanix.com> writes:
> 
> > "Jonathan Cameron" <jic23@kernel.org> writes:
> >  
> >> On Mon, 07 Sep 2026 16:51:04 +0200
> >> Esben Haabendal <esben@geanix.com> wrote:
> >>  
> >>> Adding support for sharing interrupt line with other device requires the
> >>> interrupt handler to handle runtime PM suspension properly, ignoring the
> >>> irq if the device is suspended (maybe even off). And while at it, we use
> >>> the PM reference to ensure we do not get suspended while processing an irq.
> >>>
> >>> In order to prevent the chip from raising irq while suspended (that is when
> >>> using fixed regulator, where suspend just means setting the device in
> >>> STANDBY mode), we disable all interrupt sources by clearing CTRL_REG4, and
> >>> then restores the value again when resuming.
> >>>
> >>> With that in place, it is safe to add the IRQF_SHARED flag.
> >>>
> >>> Keep in mind that the device by default is using push-pull for the irq pin,
> >>> which might require additional hardware design to allow interrupt sharing.
> >>>
> >>> Signed-off-by: Esben Haabendal <esben@geanix.com>
> >>> ---
> >>>  drivers/iio/accel/mma8452.c | 67 +++++++++++++++++++++++++++++++++++++++------
> >>>  1 file changed, 58 insertions(+), 9 deletions(-)
> >>>
> >>> diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
> >>> index fda29df5d109..e521dca37f76 100644
> >>> --- a/drivers/iio/accel/mma8452.c
> >>> +++ b/drivers/iio/accel/mma8452.c
> >>> @@ -120,6 +120,7 @@
> >>>   * @sleep_val:			time in ms to sleep while waiting for drdy
> >>>   * @ctrl_reg1:			CTRL_REG1 register shadow value
> >>>   * @data_cfg:			DATA_CFG register shadow value
> >>> + * @ctrl_reg4:			CTRL_REG4 register value to restore on resume
> >>>   * @open_drain:			true for irq pin in open-drain mode
> >>>   */
> >>>  struct mma8452_data {
> >>> @@ -138,6 +139,7 @@ struct mma8452_data {
> >>>  	int sleep_val;
> >>>  	u8 ctrl_reg1;
> >>>  	u8 data_cfg;
> >>> +	u8 ctrl_reg4;
> >>>  	bool open_drain;
> >>>  };
> >>>
> >>> @@ -1083,15 +1085,21 @@ static irqreturn_t mma8452_interrupt(int irq, void *p)
> >>>  {
> >>>  	struct iio_dev *indio_dev = p;
> >>>  	struct mma8452_data *data = iio_priv(indio_dev);
> >>> +	struct device *dev = &data->client->dev;
> >>>  	irqreturn_t ret = IRQ_NONE;
> >>> +	int pm_status;
> >>>  	int src;
> >>>
> >>> +	pm_status = pm_runtime_get_if_active(dev);  
> >>
> >> Sashiko raises the question of what happens if you actually get an error
> >> return from this. You may be deliberately ignoring those, but if
> >> so add a comment.  
> >
> > Yes, sounds like a good idea.
> >  
> >> The fun race around tear down is worth considering in particular (see
> >> sashiko comment).  
> >
> > I will look into that. Although very unlikely, it does sound like a real
> > issue that *could* occur.
> >
> > Adding a boolean flag (remove_in_progress = true) to the mma8452_data
> > struct, and set that in mma8452_remove() before disabling runtime pm
> > seems like a KISS solution. Should we be returning IRQ_HANDLED or
> > IRQ_NONE in that case?  There is no IRQ_MAYBE return value :D  
> 
> Or maybe instead:
> 
> In mma8452_remove(), we switch the order of
> pm_runtime_disable()/pm_runtime_set_suspended() with free_irq(), and
> race condition will magically disappear without any further changes.
> 
> I will push a new version with this change.

I'm not keen if that means we are disabling in a different order to setup.
Now if you can flip setup as well it is probably fine.

Jonathan


