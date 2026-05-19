Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3EA73AE18C
	for <linux-iio@vger.kernel.org>; Tue, 19 May 2026 19:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779220287; cv=none; b=jmRnEdLrvHiOSMT31R55Knq9HZ3+o1qxpuI+YnbliwzUYOPqcuxhlrsIc75xtraGb6Rem4K1GCKrf2cmyZGF7x09VVX1qGJnP7vSVZfQSoU+4JydTPcgbgQGaT2Ur/r3Gjb55CQzRdwpyEDEfbEzH3hLF+VqdrhnTCUXnZE/ijc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779220287; c=relaxed/simple;
	bh=0TaKRAnKnNwqy74i/sb/1XJBkSa4AsHKFyv20tLHTtk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kP10t4od9gGGWBzAdoKDoRXu5ABJX72CQvKT0Gm/Jr6BEWAZurnFOi5axPTFCKPr22Cwu2I9dkn3PbYfU/6mluz6EZ+HdJkhVl6VeMfIsD5Sz06/4a3Lqaj/sigK8TNrvF/CdoxS2YmefM6Ncu/RmP1MyWHn8iTEzQE8p9n3aqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=WTfsASQr; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="WTfsASQr"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-48a7fe4f40bso48814595e9.0
        for <linux-iio@vger.kernel.org>; Tue, 19 May 2026 12:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1779220283; x=1779825083; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=v9NBzb9aKlIq7Sd0DoDjattmaS8U7WMC1EqfiH19BzM=;
        b=WTfsASQr0Jq//3xmbSc3jbIgkQemnsI6NupcoBHfIP16hIulj5bLUr+6z3Oc560XJq
         Jk+AdpZk6FTbhHZQaZyrEEign8WAMm6o6koWu80b5QwffSufZ8wKzFJH5bg2SE8fouv/
         XytLDv6dbCDzdIn3l1SqghCAHG7F6xF3ghpqUqzCBakdVfs4DpnUhkJJIJviGldp8Iql
         RB+lKGZtd/VnwGIuZNq05OMlaOB3rj8iKbiBau69ba2lbaFoTFDHB+5Lg6++LZg3pglG
         opJRLNhpvN730jNVR2QnuUeB9uV2Dr2SVxWnX6TzJev2z11u5mtkkyPSvn1j3Pt/6EyP
         eZxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779220283; x=1779825083;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v9NBzb9aKlIq7Sd0DoDjattmaS8U7WMC1EqfiH19BzM=;
        b=aoKUWKCeDCW6HKJsbaZtcTxkhoZvReLS8O7dtLpcNi3uhvINPSBGQ2PcA0ZPyYJDO1
         Xzi4xZSHUo3X8HIXQt0ipRb/jrMfD7rVdFS4sD7m67NRfMF7j9oDFxFLhmOOLfnFMPc8
         0lozE4yOzs3g4gvoJ7UI0KePxocVWrU+8wYOR/2OKiRuSDeJpavIaEq0l+Oc1W8XXNQ2
         0Kdf3RvUzuTwEDjqswbQvUwif7QgTB4di2H1/1E0lX/UFUpqnEnNJLcnravbu8qsmN7j
         WMV3SCPbIh4lvwqXbgiTIBO988JQjAqqI/3x+p2DMf4mQGmV2DvG7pjPFOZAO+8Ijnbw
         2CxQ==
X-Forwarded-Encrypted: i=1; AFNElJ8u+yVBB2ID2TBlfDekM5JOFwj+hKDpQYa6hZFUMJI2O3rnHGEnoE26mVxyZXb2X5Ba0hmRRYLRbGM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkFewgyySfNNgqz3YQLkydByYZF3WvvW4khdN75IXJeiLavSMB
	xEz93eh+2+Wi3tzHP1qdMIZxVaxXpZg+i2NFAgvuv+8iHXyqMC56cq2+jM2BgAWPScI=
X-Gm-Gg: Acq92OG+f+f0/8fFFckaqC2vK9T1QuO2PDyU6E0Kg6fE6nIrEEhimWsHHFOvP4zYwyW
	E3aXb7tbmUbzP96MAl5bbQrEKx/SY20UKG5BA3KNA5gs0Vd52pbJhYNSw7viIsgFaJlB7qJNpc6
	LqJI+TCI4RzsBPb05toNASiPG91EaREfDYZaQ9n/WDL3021EFQW6z960d/Lk19Gn3K0qudiSGvE
	0pOnJjjU6Y/wuu85/bmag217DWZHw7I6QndWmLZQ6BVIgoss4COyCax0Q/m1R04r5xdLJt3cAEj
	qCAXnF4sgRgrtUpBaV4KWIs+1xNjUOTLNLMisU0AbO2OoDmg77o5D3zwBB5/e0lGcI+/kkg7dnk
	mn+SG/0OL5OnQv44StK8sjo9zg7J7VR2qeXeFc0QYVF6KWBlOZYu5EVVt2wEZ7+TMyMcfpf7UPg
	qj0E8N+RiTMTKRX2/CNEUXr9AYqFae
X-Received: by 2002:a05:600d:c:b0:48a:56de:d62a with SMTP id 5b1f17b1804b1-48fe60eca75mr296779745e9.11.1779220282884;
        Tue, 19 May 2026 12:51:22 -0700 (PDT)
Received: from localhost ([2a02:8071:56d1:2de0:1d24:d58d:2b65:c291])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-48fe53ab6aasm372620935e9.2.2026.05.19.12.51.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 12:51:22 -0700 (PDT)
Date: Tue, 19 May 2026 21:51:20 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, 
	Puranjay Mohan <puranjay@kernel.org>, Marcelo Schmitt <marcelo.schmitt@analog.com>, 
	Antoniu Miclaus <antoniu.miclaus@analog.com>, Ramona Gradinariu <ramona.gradinariu@analog.com>, 
	Petre Rodan <petre.rodan@subdimension.ro>, Dan Robertson <dan@dlrobertson.com>, 
	Herve Codina <herve.codina@bootlin.com>, Matti Vaittinen <mazziesaccount@gmail.com>, 
	Francesco Dolcini <francesco@dolcini.it>, 
	=?utf-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <jpaulo.silvagoncalves@gmail.com>, Hugo Villeneuve <hvilleneuve@dimonoff.com>, 
	Anshul Dalal <anshulusr@gmail.com>, Gustavo Silva <gustavograzs@gmail.com>, 
	Andreas Klinger <ak@it-klinger.de>, Tomasz Duszynski <tduszyns@gmail.com>, 
	Ariana Lazar <ariana.lazar@microchip.com>, Rui Miguel Silva <rmfrfs@gmail.com>, 
	Linus Walleij <linusw@kernel.org>, Javier Carrasco <javier.carrasco.cruz@gmail.com>, 
	Li peiyu <579lpy@gmail.com>, Lorenzo Bianconi <lorenzo@kernel.org>, 
	Alex Lanzano <lanzano.alex@gmail.com>, Jagath Jog J <jagathjog1996@gmail.com>, 
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, Remi Buisson <remi.buisson@tdk.com>, 
	Christian Eggers <ceggers@arri.de>, Mudit Sharma <muditsharma.info@gmail.com>, 
	Kevin Tsai <ktsai@capellamicro.com>, =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>, 
	Dixit Parmar <dixitparmar19@gmail.com>, Gerald Loacker <gerald.loacker@wolfvision.net>, 
	Akhilesh Patil <akhilesh@ee.iitb.ac.in>, Eddie James <eajames@linux.ibm.com>, 
	Petar Stoykov <petar.stoykov@prodrive-technologies.com>, Song Qiang <songqiang1304521@gmail.com>, 
	Siratul Islam <email@sirat.me>, Crt Mori <cmo@melexis.com>, Waqar Hameed <waqar.hameed@axis.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Gustavo Vaz <gustavo.vaz@usp.br>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Marcus Folkesson <marcus.folkesson@gmail.com>, 
	Guenter Roeck <linux@roeck-us.net>, Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
	Chuang Zhu <git@chuang.cz>, Kyle Hsieh <kylehsieh1995@gmail.com>, 
	Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>, Chen-Yu Tsai <wens@kernel.org>, 
	Oleksij Rempel <o.rempel@pengutronix.de>, Romain Gantois <romain.gantois@bootlin.com>, 
	Sander Vanheule <sander@svanheule.net>, David Jander <david@protonic.nl>, Andrew Davis <afd@ti.com>, 
	chuguangqing <chuguangqing@inspur.com>, Shrikant Raskar <raskar.shree97@gmail.com>, 
	Kurt Borja <kuurtb@gmail.com>, Denis Benato <benato.denis96@gmail.com>, 
	Ethan Tidmore <ethantidmore06@gmail.com>, Tomas Borquez <tomasborquez13@gmail.com>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Shi Hao <i.shihao.999@gmail.com>, 
	Xichao Zhao <zhao.xichao@vivo.com>, Erikas Bitovtas <xerikasxx@gmail.com>, 
	Aldo Conte <aldocontelk@gmail.com>, Colin Ian King <colin.i.king@gmail.com>, 
	Gabriel Almeida <gabrielsousa230@gmail.com>, Gabriela Victor <gabevictor333@gmail.com>, 
	Beatriz Viana Costa <beatrizvianacosta16@gmail.com>, Frank Li <Frank.Li@nxp.com>, 
	Adrian Fluturel <fluturel.adrian@gmail.com>, Antoni Pokusinski <apokusinski01@gmail.com>, 
	Yasin Lee <yasin.lee.x@gmail.com>, Felix Gu <ustc.gu@gmail.com>, Ben Collins <bcollins@watter.com>, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 7/7] iio: Initialize i2c_device_id arrays using member
 names
Message-ID: <agy7IA69oPEHl7mL@monoceros>
References: <cover.1779136001.git.u.kleine-koenig@baylibre.com>
 <4b6ea3483356d758a90bfb8970ed0f1df2f31cfc.1779136001.git.u.kleine-koenig@baylibre.com>
 <20260519193913.6466630b@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lct2h5a7d7neno6s"
Content-Disposition: inline
In-Reply-To: <20260519193913.6466630b@jic23-huawei>


--lct2h5a7d7neno6s
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 7/7] iio: Initialize i2c_device_id arrays using member
 names
MIME-Version: 1.0

[Dropped one recipient who's email address isn't valid any more]

Hello Jonathan,

On Tue, May 19, 2026 at 07:39:13PM +0100, Jonathan Cameron wrote:
> On Tue, 19 May 2026 10:13:09 +0200
> Uwe Kleine-K=C3=B6nig (The Capable Hub) <u.kleine-koenig@baylibre.com> wr=
ote:
>=20
> > While being less compact, using named initializers allows to more easily
> > see which members of the structs are assigned which value without having
> > to lookup the declaration of the struct. And it's also more robust
> > against changes to the struct definition.
> >=20
> > The mentioned robustness is relevant for a planned change to struct
> > i2c_device_id that replaces .driver_data by an anonymous union.
> >=20
> > This patch doesn't modify the compiled arrays, only their representation
> > in source form benefits. The former was confirmed with x86 and arm64
> > builds.
> >=20
> > Signed-off-by: Uwe Kleine-K=C3=B6nig (The Capable Hub) <u.kleine-koenig=
@baylibre.com>
>=20
> I'd prefer it split into cases you care about (not just name) and the nam=
e only ones.
> That is unless I'm missing some potential change that breaks initializing
> just the first element and hence not the union you plan to add.
>=20
> It's a lot of churn and the name one isn't enabling anything new unless
> I'm missing something.

Today all hunks are about using named initializers to improve
readability, so the split into only .name vs. .name+.driver_data feels
very artificial to me. But if you think that's the compromise to use,
I'll adapt.

> We also get fixes in these annoyingly often so chances are this will mess
> up backports.  Might even be worth splitting it up into directories
> just to reduce that backport mess.

In my opinion this is the reason to do this kind of cleanup with one
patch per driver. This doesn't only make backports easier, it also
allows to better record who reviewed and acked what, it reduces merge
conflicts (because if one driver is updated in your tree already since
my base, with one subsystem patch you get a merge conflict which makes
the whole patch unapplicable, with one patch per driver only one out of
(here) 208 fails).

But that isn't popular with most subsystem maintainers and so I went
with one patch per subsystem. =F0=9F=A4=B7

> Also, have you done a checkpatch check for this?  Nice to not being fight=
ing
> it for ever.

No, but that's on my agenda.

Best regards
Uwe

--lct2h5a7d7neno6s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmoMvzUACgkQj4D7WH0S
/k5vLwgAiL6CW2R+kMxHjrhDUR7VIhFCG2wMBKLz5WbkBWU5squkTN/1qVtoWWar
vci9CmfyXf4DAHwPE5VxqFdI/2hnHkZGY+9HdlZ5rCA0eE9uRtLRXpmagLU8vP7G
qwGeXmdRXcSleK+2+J6mG2vC4TJ0UzR8V/2gwYk1Blpah9QGIHAWS3MlOHQpkatg
qVvkxhTS+BBYcEf5Anqk+X2GoX5yM1BAJxN3ruPTt0kSKHs4IS5hDeorUgfadCD2
Sh1f5bn07i2pkm8es6dISs5b5wruLTNr8sUXdDy3nFpOcTFl2esGEFYyc2F+QwWJ
s9hr9xBFuzUzOyfUryv2POEO1qXSEg==
=P7dV
-----END PGP SIGNATURE-----

--lct2h5a7d7neno6s--
