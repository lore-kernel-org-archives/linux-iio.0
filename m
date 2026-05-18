Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10090481649;
	Mon, 18 May 2026 13:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779111447; cv=none; b=KERX+bhVuqUXE99Lv3WEuVY8Q2h7YZWBs5z++PJHFoe2ygiqMSIHJ+Sbrxz1GvXLJwVdMBUhqJLnRr8ued3ccbetJz7i3/kztTE7MDK2UkVfB/Rz9t+wQnTNNeTE6fo8r1si88YORDL5vE+R4VriFHJIYTt2gl7PjJP9ym7eAP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779111447; c=relaxed/simple;
	bh=3lhGsZhYa2nOYCn1/cqmAQVFLropapGtbzu4gXAxsYs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N/EmUkERxeRBAGlmaqSrH65WWCp3v6rw2BFzvk4ApPvQkmMSIM/82jMF4ExUyfiNQg5J5mHZV6MhA6EHzOBWN/RUAIsDPGatoRpkdRSHuluvRnu6JeAx2tu0UwtGc8OP+Siq7a9JWr9klazkmW6uEBwi/RMj3xdFjAHlSjcpaqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fAPF5GN7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fAPF5GN7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BFFFC2BCB7;
	Mon, 18 May 2026 13:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779111446;
	bh=3lhGsZhYa2nOYCn1/cqmAQVFLropapGtbzu4gXAxsYs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fAPF5GN757+tXotU0AMuPF//EAKUkPIyI1cvS7YyuyhQ9HKUjo6sA31feCEnvATaY
	 HPI+hlmEkEilRdcyoA2y/m98iYGhE4V5KsNDJvkJvI6J1N1uYR5TlF42UCmRTjGPzU
	 xu6dBGiYv3Crv+8Sz6Si/LWHaipFw+VVVNscyRSh6vVIfa8+YzJsku9B6C93JA3Ze8
	 u7RDMYoTmB2pVZz7mSfOiWvxgAEgSflwbtTWRSqkTvsedHvsi7PsCgPXnR3NUHRpXy
	 ZTOAuNbcshRFl765lsStEi+Qn/QBQqgixp1vnN86HTkxFCEv9Bi2euFqamMHgpueh8
	 02ho6mcJX/fkQ==
Date: Mon, 18 May 2026 14:37:18 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Sanjay Chitroda <sanjayembeddedse@gmail.com>, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, sakari.ailus@linux.intel.com,
 christoph.muellner@theobroma-systems.com, martink@posteo.de,
 mfuzzey@parkeon.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 06/10] iio: accel: mma8452: convert to bulk regulator
 usage
Message-ID: <20260518143718.646210bf@jic23-huawei>
In-Reply-To: <CALoEA-xvobdVgDcUdB7PwYA=k8sUutNikG3Pw9fb9VOXyraSaQ@mail.gmail.com>
References: <20260505174640.3998281-1-sanjayembedded@gmail.com>
	<20260505174640.3998281-7-sanjayembedded@gmail.com>
	<CALoEA-xvobdVgDcUdB7PwYA=k8sUutNikG3Pw9fb9VOXyraSaQ@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 6 May 2026 00:34:22 +0200
Joshua Crofts <joshua.crofts1@gmail.com> wrote:

> On Tue, 5 May 2026 at 19:49, Sanjay Chitroda <sanjayembeddedse@gmail.com> wrote:
> >
> > From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
> >
> > The "vdd" and "vddio" regulators are always controlled together. Switch
> > to the regulator bulk API to handle setup, enable, and disable paths in
> > a single call.
> >
> > No functional change intended.
> >
> > Suggested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
> > ---
> >  drivers/iio/accel/mma8452.c | 59 ++++++++++---------------------------
> >  1 file changed, 15 insertions(+), 44 deletions(-)
> >
> > diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
> > index b49949792190..1c984c708ec3 100644
> > --- a/drivers/iio/accel/mma8452.c
> > +++ b/drivers/iio/accel/mma8452.c
> > @@ -111,8 +111,7 @@ struct mma8452_data {
> >         u8 data_cfg;
> >         const struct mma_chip_info *chip_info;
> >         int sleep_val;
> > -       struct regulator *vdd_reg;
> > -       struct regulator *vddio_reg;
> > +       struct regulator_bulk_data regs[2];
> >
> >         /* Ensure correct alignment of time stamp when present */
> >         struct {
> > @@ -1570,25 +1569,15 @@ static int mma8452_probe(struct i2c_client *client)
> >         if (ret)
> >                 return ret;
> >
> > -       data->vdd_reg = devm_regulator_get(&client->dev, "vdd");
> > -       if (IS_ERR(data->vdd_reg))
> > -               return dev_err_probe(&client->dev, PTR_ERR(data->vdd_reg),
> > -                                    "failed to get VDD regulator!\n");
> > -
> > -       data->vddio_reg = devm_regulator_get(&client->dev, "vddio");
> > -       if (IS_ERR(data->vddio_reg))
> > -               return dev_err_probe(&client->dev, PTR_ERR(data->vddio_reg),
> > -                                    "failed to get VDDIO regulator!\n");
> > -
> > -       ret = regulator_enable(data->vdd_reg);
> > +       data->regs[0].supply = "vdd";
> > +       data->regs[1].supply = "vddio";
> > +       ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(data->regs), data->regs);  
> 
> Since you're using ARRAY_SIZE(), it would be good to add a <linux/array_size.h>
> include, as it's currently pulling the macro from elsewhere. Perhaps
> run the IWYU
> tool to check (any header additions/removals stemming from IWYU would go in a
> separate patch however).
Fully agree that there are missing includes in the file.
ARRAY_SIZE() is already in use so ideally an IWYU header additions patch
should precede this one that adds another user.

Given Andy's comments as well need addressing I'll stop here in picking up the series.
Jonathan

> 

