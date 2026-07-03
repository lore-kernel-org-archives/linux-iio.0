Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F7A303A35;
	Fri,  3 Jul 2026 18:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783103712; cv=none; b=gywY0Q33BWsV0HwzpbQG8XQL+BXxLfXWAjTTUNKzaFzziWudSDNa7ANRz58HExIWt6UqY+MTHYztWD+HpDbtHyCAIv5Po1HdpDf/uyxVzycbNs9AbdJ1WVg0UT1jgX1nEGDzfzjotHmlk7hr7RssDcjVfHGMBORb8bxkGQ8mSFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783103712; c=relaxed/simple;
	bh=uPbqkt2n35bmSZCyZY9n7lCYFnAegu6FTQXj03nio2A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Sv7CfLz5wgsBzRsvdSGEw/zndF6uk16wJMLsu9ZwKGcPPg/SB4vITYWaYmJwa4/ODvVvCiV3vfSYoKJj8f0CjNaffeJJClUh0CRRnCO3SiJZovVbetPLrig6M94sCnSToisG89xVe/RzdL1EEWnkVNYSXHusJNM13S/OoHklsFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=efrREdTj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="efrREdTj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 779A31F000E9;
	Fri,  3 Jul 2026 18:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783103710;
	bh=LE4Gb+upFVtuK3s+4HMCOkGK1myT3l4j4jA8a7fvzoo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=efrREdTjUkdvjH5xUwcx3kQQdaLRkQbmwVNz43bS/ib8DW2zKvp8civHSXnimnjDp
	 FNYarysYh9N4ubXuT7iHig56PHH77ucdnVqYfdTKjVS79imah/G/I0FTxOFMsIoCv9
	 Xt/A+nSm04pNbOnrbkDr3SkFjssdxe74Bx2rSdm2cHkXjiv+laXKttfCTaw9krybVo
	 8nhNRC+JBDEsyiYnGpMbq8VtRC5LUi4wQt2IGrRjoSGVTsTB+8GQwHXheH3rFBh3s/
	 YJlDiYpnZUfntKaRLrohwWPaUEZmWhIYSx83RJ4RsUcAn8Q6SWK3w/rXt3/ATM1SiR
	 ffKBXkNjVmQWA==
Date: Fri, 3 Jul 2026 19:35:05 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andreas Kempe <andreas.kempe@actia.se>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, "linux-iio@vger.kernel.org"
 <linux-iio@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] iio: imu: st_lsm6dsx: deselect shub page before
 reading whoami
Message-ID: <20260703193505.30f3b0b5@jic23-huawei>
In-Reply-To: <akfFnFUk3mKjCoqh@w570anl.actianordic.se>
References: <20260702104059.1744219-1-andreas.kempe@actia.se>
	<akZVDry41WEl5y4Y@lore-desk>
	<20260702180423.2c9e4c8c@jic23-huawei>
	<akfFnFUk3mKjCoqh@w570anl.actianordic.se>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 3 Jul 2026 14:22:20 +0000
Andreas Kempe <andreas.kempe@actia.se> wrote:

> Den Thu, Jul 02, 2026 at 06:04:23PM +0100, skrev Jonathan Cameron:
> > On Thu, 2 Jul 2026 14:09:50 +0200
> > Lorenzo Bianconi <lorenzo@kernel.org> wrote:
> >   
> > > > As part of driver initialization, e.g. st_lsm6dsx_init_shub() selects
> > > > the shub register page using st_lsm6dsx_set_page(). Selecting the shub
> > > > register page shadows the regular register space so whoami, among other
> > > > registers, is no longer accessible.
> > > >
> > > > In applications where the IMU is permanently powered separately from the
> > > > processor, there is a window where a reset of the CPU leaves the IMU in
> > > > the shub register page. Once this occurs, any subsequent probe attempt
> > > > fails because of the register shadowing.
> > > >
> > > > Using the ism330dlc, the error typically looks like
> > > >
> > > >     st_lsm6dsx_i2c 3-006a: unsupported whoami [10]
> > > >
> > > > with the unknown whoami read from a reserved register in the shub page.
> > > >
> > > > The reset register is also shadowed by the page select, preventing a
> > > > reset from recovering the chip.
> > > >
> > > > Unconditionally clear the shub page before the whoami readout to ensure
> > > > normal register access and allow the initialization to proceed.
> > > >
> > > > Place the fix in st_lsm6dsx_check_whoami() before the whoami check
> > > > because hw->settings, which st_lsm6dsx_set_page() relies on, is first
> > > > assigned in that function.
> > > >
> > > > Placing the fix in a more logical place than the whoami check would
> > > > require a bigger restructuring of the code.
> > > >
> > > > Signed-off-by: Andreas Kempe <andreas.kempe@actia.se>
> > > > ---
> > > >
> > > >  Changes in v2:
> > > >    - Drop st_lsm6dsx_get_page() and unconditionally clear the shub page.
> > > >    - Make the code comment clearer.
> > > >    - Document the placement rationale in the commit message.
> > > >    - Link to v1: https://lore.kernel.org/linux-iio/20260604132646.1099072-1-andreas.kempe@actia.se/
> > > >
> > > >  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 21 +++++++++++++++++++-
> > > >  1 file changed, 20 insertions(+), 1 deletion(-)  
> > >
> > > Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > >  
> > Given I assume we want to backport this, please send an appropriate
> > Fixes tag in response to this email.
> >   
> 
> Fixes: c91c1c844ebd ("iio: imu: st_lsm6dsx: add i2c embedded controller support")
> 
Thanks,

Applied to the fixes-togreg branch of iio.git and marked for stable.


> > > >
> > > > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > > > index 630e2cae6f19..f4edcb73ec8c 100644
> > > > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > > > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > > > @@ -1712,6 +1712,26 @@ static int st_lsm6dsx_check_whoami(struct st_lsm6dsx_hw *hw, int id,
> > > >             return -ENODEV;
> > > >     }
> > > >
> > > > +   hw->settings = &st_lsm6dsx_sensor_settings[i];
> > > > +
> > > > +   if (hw->settings->shub_settings.page_mux.addr) {
> > > > +           /*
> > > > +            * If the IMU has the shub page selected on init, for example
> > > > +            * after a CPU watchdog reset while the page is selected, the
> > > > +            * regular register space is shadowed. While the regular
> > > > +            * register space is shadowed, the registers needed for
> > > > +            * initializing the IMU are not available.
> > > > +            *
> > > > +            * Unconditionally clear the shub page selection to ensure
> > > > +            * normal register access.
> > > > +            */
> > > > +           err = st_lsm6dsx_set_page(hw, false);
> > > > +           if (err < 0) {
> > > > +                   dev_err(hw->dev, "failed to clear shub page\n");
> > > > +                   return err;
> > > > +           }
> > > > +   }
> > > > +
> > > >     err = regmap_read(hw->regmap, ST_LSM6DSX_REG_WHOAMI_ADDR, &data);
> > > >     if (err < 0) {
> > > >             dev_err(hw->dev, "failed to read whoami register\n");
> > > > @@ -1724,7 +1744,6 @@ static int st_lsm6dsx_check_whoami(struct st_lsm6dsx_hw *hw, int id,
> > > >     }
> > > >
> > > >     *name = st_lsm6dsx_sensor_settings[i].id[j].name;
> > > > -   hw->settings = &st_lsm6dsx_sensor_settings[i];
> > > >
> > > >     return 0;
> > > >  }
> > > > --
> > > > 2.53.0  
> > 
> > CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you recognize the sender and know the content is safe.
> >  

