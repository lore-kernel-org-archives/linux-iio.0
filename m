Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509933A7F73
	for <linux-iio@vger.kernel.org>; Fri, 15 May 2026 10:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778840396; cv=none; b=DT7lP4NPoD9epczOHtqlMMsCzzNYQ5yJi2ZhavfAJZ4b/S4CYjyYMpOf6Y7+5vrhulopE/Sky6ak3qGKTvWYRnfqetpA38y2mtfx/sHJXmmBqsE5cbg0Zy5LMMZ9GqI8/SFPtZZS/Irso7arG9VswHoVHM06X0QUia84b5Bx4Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778840396; c=relaxed/simple;
	bh=ov75P4p4oWTlDH2aWqiU6AXZOoA1BURDRcg2XELC2R4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JPG8cZVI1cyeNngzul2KlkUPhlj4oS/L1mvy1SxPTooGRBMB8NltTe26wpofoARY28gcLFZZx/Yu6pR/1Gff1vgHKOF4H/NQrsPF6bsOFOWzlOPIJb/tKjahQJxNlTH2IrgwZktKTTZvu2HIRmJV7s7A9RwA8zmpt1XSnAsJxpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1wNpe0-0004YZ-MH; Fri, 15 May 2026 12:19:48 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1wNpe0-000uQu-0G;
	Fri, 15 May 2026 12:19:48 +0200
Received: from pengutronix.de (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 53FF65373B5;
	Fri, 15 May 2026 09:35:13 +0000 (UTC)
Date: Fri, 15 May 2026 11:35:12 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel@pengutronix.de, lgo@pengutronix.de
Subject: Re: [PATCH] iio: iio_triggered_buffer_setup_ext(): request
 IRQF_ONESHOT only if threaded handler is present
Message-ID: <20260515-fierce-barracuda-of-enrichment-9e28d8-mkl@pengutronix.de>
X-AI: stop_reason: "refusal"
References: <20260514-iio-irq-fixes-v1-1-3bc28b094ad6@pengutronix.de>
 <20260514164132.6545e492@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7aqqtvsnvkxhw6os"
Content-Disposition: inline
In-Reply-To: <20260514164132.6545e492@jic23-huawei>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org


--7aqqtvsnvkxhw6os
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] iio: iio_triggered_buffer_setup_ext(): request
 IRQF_ONESHOT only if threaded handler is present
MIME-Version: 1.0

On 14.05.2026 16:41:32, Jonathan Cameron wrote:
> Thanks for the report + patch.
> >
> > I'm not sure if this is the correct fix, or if the
> > stm32-adc.c/stm32-dfsdm-adc.c driver needs fixing.
>
> Sounds like another case of what we had to fix for hid-sensors (and a few=
 others
> IIRC).
>
> They should never have been using triggers in the first place for this pa=
th -
> but now we have ABI we can't touch.  Note there are even comments saying =
that
> the infrastructure registered is not used!
>
> So we have to have do a small dance to ensure the sysfs files are still c=
reated
> but without the need for the pollfunc setup etc.
>
> https://lore.kernel.org/all/20260220224514.471348-1-srinivas.pandruvada@l=
inux.intel.com/
>
> It is in theory possible to have a case that needs the fix you have below
> but that would not be using iio_pollfunc_store_time().
> That being used without a thread is pretty much pointless as no one reads
> the timestamp.
>
> I took a look just at stm32_adc and things are more complex because in so=
me
> cases we should be registering a triggered buffer (with both top and bott=
om
> half set) and in some cases we should not - but should be doing what we
> did in the hid sensors.
>
> Given I believe this is a harmless warning I'm not in a huge rush to fix =
it.

It's a warning including a stack trace:

| ------------[ cut here ]------------
| WARNING: kernel/irq/manage.c:1502 at __setup_irq+0x104/0x81c, CPU#1: adc-=
stm32/370
| Modules linked in:
| CPU: 1 UID: 0 PID: 370 Comm: adc-stm32 Not tainted 7.1.0-rc3+ #2 PREEMPT =
 dba7a20aa885d5558721d75378dc67d9c58ca68c
| Hardware name: STM32 (Device Tree Support)
| Call trace:
|  unwind_backtrace from show_stack+0x18/0x1c
|  show_stack from dump_stack_lvl+0x50/0x64
|  dump_stack_lvl from __warn+0x98/0x178
|  __warn from warn_slowpath_fmt+0x1a4/0x1ac
|  warn_slowpath_fmt from __setup_irq+0x104/0x81c
|  __setup_irq from request_threaded_irq+0xb8/0x14c
|  request_threaded_irq from iio_trigger_attach_poll_func+0xa8/0x1a4
|  iio_trigger_attach_poll_func from __iio_update_buffers+0xab8/0xb6c
|  __iio_update_buffers from enable_store+0x84/0xd4
|  enable_store from kernfs_fop_write_iter+0x154/0x220
|  kernfs_fop_write_iter from vfs_write+0x27c/0x4fc
|  vfs_write from ksys_write+0x68/0xf0
|  ksys_write from ret_fast_syscall+0x0/0x54
| Exception stack(0xe12f9fa8 to 0xe12f9ff0)
| 9fa0:                   00000000 00000000 00000009 01ad2358 00000002 0000=
0000
| 9fc0: 00000000 00000000 0f387d24 00000004 01accc68 01ad13b8 01accc68 b5ff=
e44c
| 9fe0: b5ffdf08 b5ffdef4 b6d34659 b6d3d038
| ---[ end trace 0000000000000000 ]---

which looks quite scary :)

> We need someone who has the time + hardware to test solutions as they
> can be a bit fiddly.

We have the hardware, we're happy to test patches.

> Whilst the code you have here papers over the problem it's changing from
> having an entirely correct warning to hiding that the code is wrong so
> I'd rather not merge that.  I've rejected it as a proposed solution a cou=
ple
> of times so far - and thought we were getting to the end of drivers that =
abused
> this stuff :(  Seems not quite yet.

regards,
Marc

--
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--7aqqtvsnvkxhw6os
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCagbozwAKCRDMOmT6rpmt
0gPhAQCcEES6yqYEf65pULzR7/4NHvkxWLU0uMhqNLQ9gH1s2QEA8VptmsoEFaox
AYSbWejfEaTMTeHtxrVC/7Upglbq8w4=
=8bpo
-----END PGP SIGNATURE-----

--7aqqtvsnvkxhw6os--
