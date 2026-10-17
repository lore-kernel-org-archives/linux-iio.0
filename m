Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5CAE3C1085;
	Sat, 17 Oct 2026 23:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792278258; cv=none; b=KPceJMU83S4DKUgzb2gf1LTK9uvJ4nNbAP5dhilyjthehphxNBKUnaWfps5e8DyjtnFRykhWhTwCW0pm2uyNKtdpOT/sulBqaUpkYGLDBVfiButofYRmMA9FcasORc6N4X4eC0vigQLXRTuix77eK5XPjLdsxexdNjIsGIigK14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792278258; c=relaxed/simple;
	bh=CYaMDvmi2KiHdu4OXdWIuDUIRkzMWnrsGYmND09VDBY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hCBerAUPV/QT0oUo/pIRwaDQsKe9ftW2bd7g8D9AcMhfd2a4LfKrtvPTAVSF1D1hGZ+TfnEEfCILbcshdbwm4qFxggd2Sc1aDStMKrCkiu8piIXB5+45mDVfgn9jvBx7iLZ5db6O2R/MHFVhy7XK1jZpmFbA9Frj91iDH/g7jAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k+VgA7eT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k+VgA7eT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 984821F000C4;
	Sat, 17 Oct 2026 23:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792278257;
	bh=TmCuJFBc23774vm02fvvgkDm65I3y7HgwtkXFUD4HfA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=k+VgA7eTAZPXLR2+e3qWjr1H1Sbui4xHJTvBeAln7d9WmMfFYV/w3FD5ZEixbWHCw
	 phOUj2Nbg0mfeVChqGSysTe7tpzeqvyaG9ABn1z0hsrJ4Uo44lsxY/g578fIl0IvsG
	 Sbw7HibyxwVhsIST+LEnNAZbFZclDgCQ+21KwbAAGT6SkE/uMyu3hYFQM5sxEJtIl2
	 pO4UbJQURfDpmpjiSVYY8tLvb2tewV/Rhkr5Qq1K8J8anyLFlqEggik8TGQ70br9FQ
	 c/H93gosQemDdIvQcrQPti0zkE/XAn5/z1/e+PRHacIUMvNuZpMVT0A2A7qoVxE8hX
	 NEHmHpMDK8C9g==
Date: Sun, 18 Oct 2026 00:04:13 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Arnav Kapoor <kapoorarnav43@gmail.com>, Jean-Baptiste Maneyrol
 <jean-baptiste.maneyrol@tdk.com>, David Lechner <dlechner@baylibre.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: imu: inv_mpu6050: fix kernel-doc warnings
Message-ID: <20261018000413.0d849fae@jic23-hlaptop>
In-Reply-To: <20261011193357.51c393e4@systembl0wer>
References: <20261011045754.358335-1-kapoorarnav43@gmail.com>
	<20261011193357.51c393e4@systembl0wer>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 11 Oct 2026 19:33:57 +0200
Joshua Crofts <joshua.crofts1@gmail.com> wrote:

> On Sun, 11 Oct 2026 10:27:49 +0530
> Arnav Kapoor <kapoorarnav43@gmail.com> wrote:
> 
> > scripts/kernel-doc -Wall reports several warnings for the inv_mpu6050
> > driver:
> > 
> > - inv_mpu_magn_get_scale() only describes @st, not @chan, @val and @val2.
> > - Eight functions use "Returns ..." in the body instead of a "Return:"
> >   section, and inv_mpu6050_set_enable() and
> >   inv_mpu_data_rdy_trigger_set_state() do not describe their return
> >   value at all, e.g.:
> > 
> >     Warning: .../inv_mpu_aux.c:87 No description found for return value
> >     of 'inv_mpu_aux_init'
> > 
> > - int_pin_cfg in struct inv_mpu6050_reg_map is documented with a ';'
> >   instead of a ':' after the name, so kernel-doc does not see it, and
> >   user_ctrl in struct inv_mpu6050_chip_config and startup_time in
> >   struct inv_mpu6050_hw are not documented.
> > 
> > Describe the missing parameters, members and return values, and convert
> > the return value descriptions to "Return:" sections. Where the return
> > value was described before the long description, move it after it, so
> > the description is not parsed as part of the return value section.
> > 
> > With this change, scripts/kernel-doc -Wall reports no warnings for
> > drivers/iio/imu/inv_mpu6050/. Comment-only change.
> > 
> > Assisted-by: LLM
> > Signed-off-by: Arnav Kapoor <kapoorarnav43@gmail.com>
> > ---  
> 
> Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
> 
Applied. Thanks,
J

