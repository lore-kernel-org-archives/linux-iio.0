Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74F5A3AEF2A;
	Mon, 27 Apr 2026 09:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777280692; cv=none; b=d/Opunk9iFl8XchZwWmGPyi2f6FSzqD/eEen9o6SF0mfcL9YgthENPAE3UfEZynCrjpDxLF5dmIt0CYjBxsocIkvdBqWKgWD23hyQaMcjiI7AAoQ02baScG7UMK9XsgN/zIR/fjJykofmEL+2xx6of9GRNu94d5oZm1cstzHi/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777280692; c=relaxed/simple;
	bh=AkPDyGOpRwp4dXpfrAHBGS6DICfleK1swWoyvTjzzUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eUYeI4dtAAg1Lkk4OysDzAg1smhUXUtOYE73bHW5M9KQAYFdbBWTroeLgKC7SInfUU+ZlgDJbjwMu2XRcjlkRsfF4KbQ1X52Y7wzt2mXIRgoO7suKUbNhgjVgFOuCU4g8yhKqzhIJms68aU7a6aQ4/hpHVoIe/sdPSOVUT3oQDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XmJFSw7n; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XmJFSw7n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BC09C19425;
	Mon, 27 Apr 2026 09:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777280692;
	bh=AkPDyGOpRwp4dXpfrAHBGS6DICfleK1swWoyvTjzzUQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XmJFSw7n7d+ljtdFu3Yji/SI0+V3WoMyqXBTvQF7WrXe8EBfLaFXj7FFGyleX7CH1
	 khDST3IP3nCbnbWOE4NriXkBgLSXEUI32U9Rl8l/f1dlIRYl/7Ql2T19ioHoFK57TX
	 mEr0DrZxrjs9UAC6wweMwN8y6S8G+SUUrpVIq2fq7I1AKA1X3s7ZI9B+1o8NEwgp30
	 iaUXasUpCxH36PR+LHSPK3RtH9lRzq9D7VUEI8St7nqPx18rpqMwnOLz2iRsrnqHU8
	 wI5OLPyLLIy6GxP1CamrIGhrM71+OqBBNSmYLCebabI+Jsra1r0rnoXK5nC12/QH1L
	 iCVkjGWT7FwoQ==
Date: Mon, 27 Apr 2026 10:04:41 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andrey Skvortsov <andrej.skvortzov@gmail.com>
Cc: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jonathan Marek <jonathan@marek.ca>, Brian
 Masney <masneyb@onstation.org>, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 1/3] iio: imu: inv_mpu6050: fix unbalanced
 regulator_disable calls, when probe fails
Message-ID: <20260427100441.68b6a986@jic23-huawei>
In-Reply-To: <ae50xlJfXiVax6c_@skv.local>
References: <20260426112334.3938774-1-andrej.skvortzov@gmail.com>
	<20260426112334.3938774-2-andrej.skvortzov@gmail.com>
	<20260426154330.0a29236e@jic23-huawei>
	<ae50xlJfXiVax6c_@skv.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 26 Apr 2026 23:25:42 +0300
Andrey Skvortsov <andrej.skvortzov@gmail.com> wrote:

> On 26-04-26 15:43, Jonathan Cameron wrote:
> > On Sun, 26 Apr 2026 14:23:32 +0300
> > Andrey Skvortsov <andrej.skvortzov@gmail.com> wrote:
> >   
> > > During a probe functions after all regulators are enabled, runtime pm
> > > is enabled. Before probe function finishes, runtime pm triggers and
> > > disables vddio regulator. When probe function fails after that,
> > > inv_mpu_core_disable_regulator_action tries to disable already
> > > disabled by runtime pm vddio regulator causing following backtrace:
> > > 
> > >   inv-mpu6050-i2c 1-0068: trigger probe fail -19
> > >   WARNING: drivers/regulator/core.c:3244 at _regulator_disable+0x2ac/0x600
> > >   Call trace:
> > >    _regulator_disable+0x2ac/0x600 (P)
> > >    regulator_disable+0xac/0x148
> > >    inv_mpu_core_disable_regulator_vddio_action+0x3c/0xb0 [inv_mpu6050]
> > >    devm_action_release+0x4c/0x88
> > >    release_nodes+0xd8/0x178
> > >    devres_release_group+0x214/0x3c8
> > >    i2c_device_probe+0x6fc/0x9b0
> > >   ...
> > >   inv-mpu6050-i2c 1-0068: Failed to disable vddio regulator: -5
> > > 
> > > vddio state is handled in two places: pm_runtime and
> > > inv_mpu_core_disable_regulator_vddio_action devm action.
> > > inv_mpu_core_disable_regulator_vddio_action has to check, whether
> > > regulator is disabled by pm_runtime already. But this information is
> > > available only after pm_runtime state is initialized by
> > > pm_runtime_set_active during a probe. So
> > > inv_mpu_core_disable_regulator_vddio_action has to be called only
> > > after pm_runtime is properly initialized. To handle cases, when probe
> > > fails before pm_runtime is enabled, explicitly disable regulators
> > > in error paths.  
> > Why not drag pm_runtime_set_active() earlier?  
> 
> Do you mean something like proposed in v2? [1]
> 
> 1. https://lore.kernel.org/linux-iio/20260401082737.781018-4-andrej.skvortzov@gmail.com/#t
Ah yes. Sorry, I missed that discussion.

To me moving this earlier is less hacky.  We are brining the runtime
state inline with what we have set the power to at the point of doing
so.

Nuno, having seen the complexity that moving that state change late
causes, I don't suppose you are convinced that v2 solution is the way
to go?

Thanks,

Jonathan

> 
> > Whilst we currently
> > check for an error on that call I'm not sure there is any reason
> > to do so.  It's a narrow set of conditions than can cause such an
> > error. 
> > 
> > If you have that between the regulator enable and registering the
> > devm action I think that would mean you don't need to manually clean
> > up the regulators.
> > 
> > Maybe I'm missing something.
> > 
> > J
> >   
> > > 
> > > Signed-off-by: Andrey Skvortsov <andrej.skvortzov@gmail.com>
> > > Fixes: 07c12b1c007c ("iio: imu: mpu6050: add support for regulator framework")
> > > ---
> > > 
> > > Changes in v3:
> > >  - make patch to be the first patch of the patchset for easier backporting
> > >  - update commit message to fix Andy's comment
> > >  - don't move pm_runtime_set_active from pm_runtime initialization,
> > >    move activation of inv_mpu_core_disable_regulator_action instead
> > > 
> > > Changes in v2:
> > >  - minimize call trace in commit message
> > >  - include specific driver name in patch subject
> > >   
> 

