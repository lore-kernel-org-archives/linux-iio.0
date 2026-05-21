Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3CD93C5859;
	Thu, 21 May 2026 12:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779365115; cv=none; b=UtsB3qylefnSK+GOmd9Rp/y7FdiFhKu9rm+FjkYlga0rD2CGkCUdxrJHJhH8a6IO6hl1DEc9iucdxEApS7K68b4XuoL/aDIpjzT4FLbsqV7ywf/9NxHwQdia3SZmMZ5O/vWpi/6nCy4V+Qs/bYZP4ZNO3n6Nh7m6QjpTx13Hii4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779365115; c=relaxed/simple;
	bh=0hbBrBZ4K2i7LXdJuMrG7uMKnUJFXsTXdDnSwQfSIOA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Orszek3mGB1iOmLOb8LLRUEZMyJzbPUcR+pc6ddSpR11x72tSFKv66xmlxTcTS4M9nh767CdkfO919VhDOU4lkCIH6nnAF3wIJuPnGimC7Cov9MMcGx/9kQNPGSR+mTLSkibSQv/V/ARgQebn9JeX3MEGkOzuJXcdIpMuAnFTLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eHKdqK/x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eHKdqK/x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC7781F000E9;
	Thu, 21 May 2026 12:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779365113;
	bh=Tlfhgq/Rxl8VRL+EbYLK8ggXlYDx3hjq2Rg2OvSKpDE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=eHKdqK/xovxSSfOCiKaPYu/T+m91OVDb4w6/4DUtT7V/PRJ65u0tKbQ/OBWM6bbib
	 bL1lmIecEO2L4r4K8dY0q2FgBuifK/FpOpFroeyffJY0c9+M1NQ96g5wQ6qV3SagF+
	 vtVQbFufQFz6uQgFBY0j+gHYos8vnOKzU1VKanliPKbgeh3JJT+PkNXpAla1BiVOlf
	 p+/U9yOnfCT9feK7PBkcUVKSkMwiN6kRLop1NsO5bfJJwIPRBqGndmWbEn1ibah5fi
	 dRI1XgIEvr7vfD2k5CwekoyVEDmOm/WjFsvKsVmh535T6KDiZ+7XzqdHwVL4eLS/Cw
	 NLc730Jb0vRZQ==
Date: Thu, 21 May 2026 13:04:44 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= (The Capable Hub)"
 <u.kleine-koenig@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Puranjay Mohan <puranjay@kernel.org>, Marcelo Schmitt
 <marcelo.schmitt@analog.com>, Antoniu Miclaus <antoniu.miclaus@analog.com>,
 Ramona Gradinariu <ramona.gradinariu@analog.com>, Petre Rodan
 <petre.rodan@subdimension.ro>, Dan Robertson <dan@dlrobertson.com>, Herve
 Codina <herve.codina@bootlin.com>, Matti Vaittinen
 <mazziesaccount@gmail.com>, Francesco Dolcini <francesco@dolcini.it>,
 =?UTF-8?B?Sm/Do28=?= Paulo =?UTF-8?B?R29uw6dhbHZlcw==?=
 <jpaulo.silvagoncalves@gmail.com>, Hugo Villeneuve
 <hvilleneuve@dimonoff.com>, Anshul Dalal <anshulusr@gmail.com>, Gustavo
 Silva <gustavograzs@gmail.com>, Andreas Klinger <ak@it-klinger.de>, Tomasz
 Duszynski <tduszyns@gmail.com>, Ariana Lazar <ariana.lazar@microchip.com>,
 Rui Miguel Silva <rmfrfs@gmail.com>, Linus Walleij <linusw@kernel.org>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>, Li peiyu
 <579lpy@gmail.com>, Lorenzo Bianconi <lorenzo@kernel.org>, Alex Lanzano
 <lanzano.alex@gmail.com>, Jagath Jog J <jagathjog1996@gmail.com>,
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, Remi Buisson
 <remi.buisson@tdk.com>, Christian Eggers <ceggers@arri.de>, Mudit Sharma
 <muditsharma.info@gmail.com>, Kevin Tsai <ktsai@capellamicro.com>,
 =?UTF-8?B?T25kxZllag==?= Jirman <megi@xff.cz>, Dixit Parmar
 <dixitparmar19@gmail.com>, Gerald Loacker <gerald.loacker@wolfvision.net>,
 Akhilesh Patil <akhilesh@ee.iitb.ac.in>, Eddie James
 <eajames@linux.ibm.com>, Petar Stoykov
 <petar.stoykov@prodrive-technologies.com>, Song Qiang
 <songqiang1304521@gmail.com>, Siratul Islam <email@sirat.me>, Crt Mori
 <cmo@melexis.com>, Waqar Hameed <waqar.hameed@axis.com>, Sebastian Andrzej
 Siewior <bigeasy@linutronix.de>, Gustavo Vaz <gustavo.vaz@usp.br>, Sakari
 Ailus <sakari.ailus@linux.intel.com>, Marcus Folkesson
 <marcus.folkesson@gmail.com>, Guenter Roeck <linux@roeck-us.net>, Bartosz
 Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, Chuang Zhu
 <git@chuang.cz>, Kyle Hsieh <kylehsieh1995@gmail.com>, Giorgi Tchankvetadze
 <giorgitchankvetadze1997@gmail.com>, Chen-Yu Tsai <wens@kernel.org>,
 Oleksij Rempel <o.rempel@pengutronix.de>, Romain Gantois
 <romain.gantois@bootlin.com>, Sander Vanheule <sander@svanheule.net>, David
 Jander <david@protonic.nl>, Andrew Davis <afd@ti.com>, chuguangqing
 <chuguangqing@inspur.com>, Shrikant Raskar <raskar.shree97@gmail.com>, Kurt
 Borja <kuurtb@gmail.com>, Denis Benato <benato.denis96@gmail.com>, Ethan
 Tidmore <ethantidmore06@gmail.com>, Tomas Borquez
 <tomasborquez13@gmail.com>, Srinivas Pandruvada
 <srinivas.pandruvada@linux.intel.com>, Shi Hao <i.shihao.999@gmail.com>,
 Xichao Zhao <zhao.xichao@vivo.com>, Erikas Bitovtas <xerikasxx@gmail.com>,
 Aldo Conte <aldocontelk@gmail.com>, Colin Ian King
 <colin.i.king@gmail.com>, Gabriel Almeida <gabrielsousa230@gmail.com>,
 Gabriela Victor <gabevictor333@gmail.com>, Beatriz Viana Costa
 <beatrizvianacosta16@gmail.com>, Frank Li <Frank.Li@nxp.com>, Adrian
 Fluturel <fluturel.adrian@gmail.com>, Antoni Pokusinski
 <apokusinski01@gmail.com>, Yasin Lee <yasin.lee.x@gmail.com>, Felix Gu
 <ustc.gu@gmail.com>, Ben Collins <bcollins@watter.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 7/7] iio: Initialize i2c_device_id arrays using
 member names
Message-ID: <20260521130444.197d2867@jic23-huawei>
In-Reply-To: <agy7IA69oPEHl7mL@monoceros>
References: <cover.1779136001.git.u.kleine-koenig@baylibre.com>
	<4b6ea3483356d758a90bfb8970ed0f1df2f31cfc.1779136001.git.u.kleine-koenig@baylibre.com>
	<20260519193913.6466630b@jic23-huawei>
	<agy7IA69oPEHl7mL@monoceros>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 19 May 2026 21:51:20 +0200
Uwe Kleine-K=C3=B6nig (The Capable Hub) <u.kleine-koenig@baylibre.com> wrot=
e:

> [Dropped one recipient who's email address isn't valid any more]
>=20
> Hello Jonathan,
>=20
> On Tue, May 19, 2026 at 07:39:13PM +0100, Jonathan Cameron wrote:
> > On Tue, 19 May 2026 10:13:09 +0200
> > Uwe Kleine-K=C3=B6nig (The Capable Hub) <u.kleine-koenig@baylibre.com> =
wrote:
> >  =20
> > > While being less compact, using named initializers allows to more eas=
ily
> > > see which members of the structs are assigned which value without hav=
ing
> > > to lookup the declaration of the struct. And it's also more robust
> > > against changes to the struct definition.
> > >=20
> > > The mentioned robustness is relevant for a planned change to struct
> > > i2c_device_id that replaces .driver_data by an anonymous union.
> > >=20
> > > This patch doesn't modify the compiled arrays, only their representat=
ion
> > > in source form benefits. The former was confirmed with x86 and arm64
> > > builds.
> > >=20
> > > Signed-off-by: Uwe Kleine-K=C3=B6nig (The Capable Hub) <u.kleine-koen=
ig@baylibre.com> =20
> >=20
> > I'd prefer it split into cases you care about (not just name) and the n=
ame only ones.
> > That is unless I'm missing some potential change that breaks initializi=
ng
> > just the first element and hence not the union you plan to add.
> >=20
> > It's a lot of churn and the name one isn't enabling anything new unless
> > I'm missing something. =20
>=20
> Today all hunks are about using named initializers to improve
> readability, so the split into only .name vs. .name+.driver_data feels
> very artificial to me. But if you think that's the compromise to use,
> I'll adapt.
>=20
> > We also get fixes in these annoyingly often so chances are this will me=
ss
> > up backports.  Might even be worth splitting it up into directories
> > just to reduce that backport mess. =20
>=20
> In my opinion this is the reason to do this kind of cleanup with one
> patch per driver. This doesn't only make backports easier, it also
> allows to better record who reviewed and acked what, it reduces merge
> conflicts (because if one driver is updated in your tree already since
> my base, with one subsystem patch you get a merge conflict which makes
> the whole patch unapplicable, with one patch per driver only one out of
> (here) 208 fails).
>=20
> But that isn't popular with most subsystem maintainers and so I went
> with one patch per subsystem. =F0=9F=A4=B7

Meh.  This is going to be painful whatever, so to have it as fresh
as possible I'll pick it up now as one giant patch.

Note there are already conflicts... Fixed up:
light/tsl2772.c (a couple more entries)
light/vcnl4000.c (data is now all pointers, not enum values).

Bunch of line changes in other drivers, but otherwise went in fine.

There are a few new instances in tree, though from a quick glance
maybe no i2c ones.  Since you sent the first series I've been looking
out for this in reviews, but some stuff was a already queued.

Anyhow, new ones can be dealt with in follow up patches.

Thanks,

Jonathan


>=20
> > Also, have you done a checkpatch check for this?  Nice to not being fig=
hting
> > it for ever. =20
>=20
> No, but that's on my agenda.
>=20
> Best regards
> Uwe

