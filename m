Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8DB3CFF73
	for <linux-iio@vger.kernel.org>; Thu, 21 May 2026 13:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779369616; cv=none; b=J6RZVL0GmRUqiVSE1QvxzHK3hgsw3xV041myXzY4hf/0c2ADOM1+IXw5clLAo2FmvvAyAfeipGX+ZSYar57a/t+nJZ4wEKmyT+1ok06FZN8FFg4/p0YBv2Amzwj3lUjJ8hWENXcQ29jEghh8mNReFstAEahPSfj6Oo9C/XSLxTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779369616; c=relaxed/simple;
	bh=nrsTgdOjEJeWw4i+oxKSJRFt6nK4yWJrSglLcq6KOZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rgH0l/5xqEGQgtyNcIcoG9gsRaIN+Aw+x/pcL8xsEvoq4tj/XsQjx4UcLi4S2xlabAq3vqFWkUOEBVuQz0PZ0TxAqe1s0/dx+GXpscF1/0WZ/QcQbuiJWKkd9aOE/o7Lq4BO9jR31GrCY05pVgvcxqwtXq1d6ivDvkXeOH7ogpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=AX8e0yca; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="AX8e0yca"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-44dd5cb0f81so4897253f8f.0
        for <linux-iio@vger.kernel.org>; Thu, 21 May 2026 06:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1779369612; x=1779974412; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/ui11/N3Y9C06bp42EyC03xisf2LgzZNi0LxtE5/p5o=;
        b=AX8e0ycaeseOb/Oz2Z5mG0RysGw4PW/98a4L6OmQdxxNrGkuCEdJhdgz9v7dzIKyfW
         iHo6WcHCNeEp6FX4PZR4PUpjcFIVPxgGQOfPwihAl+I5Jt76RNFwgzNdFAozIkfQsg/X
         VSGjXKJt0Anc4oJWW2btdeM1cwL/Ou5KtldldNusWFn+W1HK3AYPhQQdlkrVJwcfxY9V
         wFY0M9siR0vz9RwWy/Lk0KvLiXwSJxHqzOLcUjC6F54yRIDT42/W8m3yKSyBvHPsBecE
         zVon+jptpfzXNlW5++ns0nJhHOpURXP+eu+lveQL0KPu14+abHIuj1KJ5JEVmDlUfgR1
         8gng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779369612; x=1779974412;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/ui11/N3Y9C06bp42EyC03xisf2LgzZNi0LxtE5/p5o=;
        b=TrUUinJSozBoIAEkLVwJaorl1n/OVPl120elXKMK5aetjhdBY2CHPYar7Xh0pz4Uqf
         /HuC4kXCm8Ke9T6cFsIaUF6Q8g51goJvA5l467xy/gCf0yeKJjr3l9TILwxAXNNwsgOo
         VJ7Ka7zmoeGvceIaGd1P7BqJkl3TUXvMpWDbL9VTSaDecP4wyYwqAzBFDeIlqTMzvwPG
         SCFSftubvAWH3T8rdNVE3Oh3zZA+0Hsj9c02VCo/sveePE9suJzTN8HkjTzMfhZVIrlC
         vxbXCKomjGfpTKbTnuFe0i+By4doHhGOwDB9wTMjNwc9VpiRVxM9ZocF0aC5NnxYSpCc
         mHlQ==
X-Forwarded-Encrypted: i=1; AFNElJ8/HEVdmXZzNNo5U6bx8HLAk7J23rYEOSmfrpLWUrxymjMvXbqiTrFEOOd/rjBQJjh7MThZyV1dB+c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbcnC2+BLbVaIzSDfW6/TWamloNuLcSAR829NAgrSE3Hfm4Aus
	+fFugBC47zM0h+Z/H1d5XBxD5LQkY6Zy4Ml6Vw7dXCLvkeeUeupGZwwPH771wuquYFM=
X-Gm-Gg: Acq92OE+DjsWNWISei9REXxPJFAiIqh1OZWBDKjUc5KjRBOH53zbyrsblXzeD5njgjs
	7IMPeaBQnHFpnp70qCxjAqWQN1Up5Vqr5XEaKe7LNnkh3PKb2O6dJPgjuI+zD2ant7d7BWnO6Cv
	fUSnrhtuSOptbSFI8WKTJ/4D6ngXW/+zNC1kkfxFC14mMKOaANQRlHkv+u7FWoPbPK75EcYrRKX
	3cqwcuz3J/YR48kXwQcjwMXdKvKiE2DduSKZLZFpW1fRkhStVQLLKYApW0eDvJhQ4rtqxhqRnzr
	SC8Jm+wSeVDMa01MIp8AxdYXlc4dsTTBcxMln9DlfCXWRzpM99yPPWILWkOtkELosONvJHOp5Z0
	UfXwGEGBW1V1m2ReP4+G4guIBaBsTCd+bg3dkz9549rt6QvXPnA7RRWhEVk+WMXlczVbugkS8ZP
	y9x38a6RvO2H9snWyIaWmoc2VlfYC4RqWhNy3n/og57u+ASu9h7JQosFRz26kZVJ/Fhl/7x9fUL
	U5PJDDb26L1EyM=
X-Received: by 2002:a05:600c:6b12:b0:488:7d5b:125d with SMTP id 5b1f17b1804b1-49035f2e4f2mr28581115e9.7.1779369611032;
        Thu, 21 May 2026 06:20:11 -0700 (PDT)
Received: from localhost (p200300f65f47db0477b163ab18b6d155.dip0.t-ipconnect.de. [2003:f6:5f47:db04:77b1:63ab:18b6:d155])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-45eaa756d61sm2935233f8f.0.2026.05.21.06.20.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 06:20:10 -0700 (PDT)
Date: Thu, 21 May 2026 15:20:09 +0200
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
Message-ID: <ag8BYvxUs0Jni5op@monoceros>
References: <cover.1779136001.git.u.kleine-koenig@baylibre.com>
 <4b6ea3483356d758a90bfb8970ed0f1df2f31cfc.1779136001.git.u.kleine-koenig@baylibre.com>
 <20260519193913.6466630b@jic23-huawei>
 <agy7IA69oPEHl7mL@monoceros>
 <20260521130444.197d2867@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="exkb54tmb3ufc4j3"
Content-Disposition: inline
In-Reply-To: <20260521130444.197d2867@jic23-huawei>


--exkb54tmb3ufc4j3
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 7/7] iio: Initialize i2c_device_id arrays using member
 names
MIME-Version: 1.0

Hello Jonathan,

On Thu, May 21, 2026 at 01:04:44PM +0100, Jonathan Cameron wrote:
> On Tue, 19 May 2026 21:51:20 +0200
> Uwe Kleine-K=C3=B6nig (The Capable Hub) <u.kleine-koenig@baylibre.com> wr=
ote:
> > On Tue, May 19, 2026 at 07:39:13PM +0100, Jonathan Cameron wrote:
> > > On Tue, 19 May 2026 10:13:09 +0200
> > > Uwe Kleine-K=C3=B6nig (The Capable Hub) <u.kleine-koenig@baylibre.com=
> wrote:
> > >  =20
> > > > While being less compact, using named initializers allows to more e=
asily
> > > > see which members of the structs are assigned which value without h=
aving
> > > > to lookup the declaration of the struct. And it's also more robust
> > > > against changes to the struct definition.
> > > >=20
> > > > The mentioned robustness is relevant for a planned change to struct
> > > > i2c_device_id that replaces .driver_data by an anonymous union.
> > > >=20
> > > > This patch doesn't modify the compiled arrays, only their represent=
ation
> > > > in source form benefits. The former was confirmed with x86 and arm64
> > > > builds.
> > > >=20
> > > > Signed-off-by: Uwe Kleine-K=C3=B6nig (The Capable Hub) <u.kleine-ko=
enig@baylibre.com> =20
> > >=20
> > > I'd prefer it split into cases you care about (not just name) and the=
 name only ones.
> > > That is unless I'm missing some potential change that breaks initiali=
zing
> > > just the first element and hence not the union you plan to add.
> > >=20
> > > It's a lot of churn and the name one isn't enabling anything new unle=
ss
> > > I'm missing something. =20
> >=20
> > Today all hunks are about using named initializers to improve
> > readability, so the split into only .name vs. .name+.driver_data feels
> > very artificial to me. But if you think that's the compromise to use,
> > I'll adapt.
> >=20
> > > We also get fixes in these annoyingly often so chances are this will =
mess
> > > up backports.  Might even be worth splitting it up into directories
> > > just to reduce that backport mess. =20
> >=20
> > In my opinion this is the reason to do this kind of cleanup with one
> > patch per driver. This doesn't only make backports easier, it also
> > allows to better record who reviewed and acked what, it reduces merge
> > conflicts (because if one driver is updated in your tree already since
> > my base, with one subsystem patch you get a merge conflict which makes
> > the whole patch unapplicable, with one patch per driver only one out of
> > (here) 208 fails).
> >=20
> > But that isn't popular with most subsystem maintainers and so I went
> > with one patch per subsystem. =F0=9F=A4=B7
>=20
> Meh.  This is going to be painful whatever, so to have it as fresh
> as possible I'll pick it up now as one giant patch.

\o/, thanks.

> Note there are already conflicts... Fixed up:
> light/tsl2772.c (a couple more entries)
> light/vcnl4000.c (data is now all pointers, not enum values).
>=20
> Bunch of line changes in other drivers, but otherwise went in fine.

I reproduced the issue, my conflict resolution (on top of next-20260521)
looks as follows:

diff --cc drivers/iio/light/tsl2772.c
index 9ba8140c8bc1,1b1c704f1d6c..000000000000
--- a/drivers/iio/light/tsl2772.c
+++ b/drivers/iio/light/tsl2772.c
@@@ -1900,19 -1888,17 +1900,19 @@@ static int tsl2772_resume(struct devic
  }
 =20
  static const struct i2c_device_id tsl2772_idtable[] =3D {
- 	{ "tsl2571", tsl2571 },
- 	{ "tsl2671", tsl2671 },
- 	{ "tmd2671", tmd2671 },
- 	{ "tsl2771", tsl2771 },
- 	{ "tmd2771", tmd2771 },
- 	{ "tsl2572", tsl2572 },
- 	{ "tsl2672", tsl2672 },
- 	{ "tmd2672", tmd2672 },
- 	{ "tsl2772", tsl2772 },
- 	{ "tmd2772", tmd2772 },
- 	{ "apds9900", apds9900 },
- 	{ "apds9901", apds9900 },
- 	{ "apds9930", apds9930 },
+ 	{ .name =3D "tsl2571", .driver_data =3D tsl2571 },
+ 	{ .name =3D "tsl2671", .driver_data =3D tsl2671 },
+ 	{ .name =3D "tmd2671", .driver_data =3D tmd2671 },
+ 	{ .name =3D "tsl2771", .driver_data =3D tsl2771 },
+ 	{ .name =3D "tmd2771", .driver_data =3D tmd2771 },
+ 	{ .name =3D "tsl2572", .driver_data =3D tsl2572 },
+ 	{ .name =3D "tsl2672", .driver_data =3D tsl2672 },
+ 	{ .name =3D "tmd2672", .driver_data =3D tmd2672 },
+ 	{ .name =3D "tsl2772", .driver_data =3D tsl2772 },
+ 	{ .name =3D "tmd2772", .driver_data =3D tmd2772 },
++	{ .name =3D "apds9900", .driver_data =3D apds9900 },
++	{ .name =3D "apds9901", .driver_data =3D apds9900 },
+ 	{ .name =3D "apds9930", .driver_data =3D apds9930 },
  	{ }
  };
 =20
diff --cc drivers/iio/light/vcnl4000.c
index 88fc7424ae35,fc2161d5f3c7..000000000000
--- a/drivers/iio/light/vcnl4000.c
+++ b/drivers/iio/light/vcnl4000.c
@@@ -2039,18 -2142,6 +2039,18 @@@ static int vcnl4000_runtime_resume(stru
  static DEFINE_RUNTIME_DEV_PM_OPS(vcnl4000_pm_ops, vcnl4000_runtime_suspen=
d,
  				 vcnl4000_runtime_resume, NULL);
 =20
 +static const struct i2c_device_id vcnl4000_id[] =3D {
- 	{ "cm36672p", (kernel_ulong_t)&cm36672p_spec },
- 	{ "cm36686", (kernel_ulong_t)&vcnl4040_spec },
- 	{ "vcnl4000", (kernel_ulong_t)&vcnl4000_spec },
- 	{ "vcnl4010", (kernel_ulong_t)&vcnl4010_spec },
- 	{ "vcnl4020", (kernel_ulong_t)&vcnl4010_spec },
- 	{ "vcnl4040", (kernel_ulong_t)&vcnl4040_spec },
- 	{ "vcnl4200", (kernel_ulong_t)&vcnl4200_spec },
++	{ .name =3D "cm36672p", .driver_data =3D (kernel_ulong_t)&cm36672p_spec =
},
++	{ .name =3D "cm36686", .driver_data =3D (kernel_ulong_t)&vcnl4040_spec },
++	{ .name =3D "vcnl4000", .driver_data =3D (kernel_ulong_t)&vcnl4000_spec =
},
++	{ .name =3D "vcnl4010", .driver_data =3D (kernel_ulong_t)&vcnl4010_spec =
},
++	{ .name =3D "vcnl4020", .driver_data =3D (kernel_ulong_t)&vcnl4010_spec =
},
++	{ .name =3D "vcnl4040", .driver_data =3D (kernel_ulong_t)&vcnl4040_spec =
},
++	{ .name =3D "vcnl4200", .driver_data =3D (kernel_ulong_t)&vcnl4200_spec =
},
 +	{ }
 +};
 +MODULE_DEVICE_TABLE(i2c, vcnl4000_id);
 +
  static struct i2c_driver vcnl4000_driver =3D {
  	.driver =3D {
  		.name   =3D VCNL4000_DRV_NAME,
diff --git a/drivers/iio/adc/rtq6056.c b/drivers/iio/adc/rtq6056.c
index e2b1da13c0d3..ae50fb27bac9 100644
--- a/drivers/iio/adc/rtq6056.c
+++ b/drivers/iio/adc/rtq6056.c
@@ -872,8 +872,8 @@ static const struct richtek_dev_data rtq6059_devdata =
=3D {
 };
=20
 static const struct i2c_device_id rtq6056_id[] =3D {
-	{ "rtq6056", (kernel_ulong_t)&rtq6056_devdata },
-	{ "rtq6059", (kernel_ulong_t)&rtq6059_devdata },
+	{ .name =3D "rtq6056", .driver_data =3D (kernel_ulong_t)&rtq6056_devdata =
},
+	{ .name =3D "rtq6059", .driver_data =3D (kernel_ulong_t)&rtq6059_devdata =
},
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, rtq6056_id);

The last hunk was made necessary by commit
ce80292ead5bb42b50a6b63e44fd95c0edf9d334. And I'm pretty sure that the
following is possible on top:

 static const struct of_device_id rtq6056_device_match[] =3D {
-	{ .compatible =3D "richtek,rtq6056", .data =3D &rtq6056_devdata },
-	{ .compatible =3D "richtek,rtq6059", .data =3D &rtq6059_devdata },
+	{ .compatible =3D "richtek,rtq6056" },
+	{ .compatible =3D "richtek,rtq6059" },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, rtq6056_device_match);

> There are a few new instances in tree, though from a quick glance
> maybe no i2c ones.  Since you sent the first series I've been looking
> out for this in reviews, but some stuff was a already queued.
>=20
> Anyhow, new ones can be dealt with in follow up patches.

There will more some more drivers I missed in other subsystems, so I'll
have to reiterate anyhow. If you catch drivers before going in, that's
great, but it's not a problem if you miss a few.

Thanks for your cooperation,
Uwe

--exkb54tmb3ufc4j3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmoPBnwACgkQj4D7WH0S
/k7DPgf9HjQKvhx202kbjhgSP/d1dU+25Ut5EULsIFMhCQ3zxf0AiGZY0C5GuoCy
RCHet47pR/oglvtrQBoebwQb+ohzep35STOwP9jnhf9ickyPrktyN9AB6Skf7vHo
7sZhGr40khNOOLhXglURLHKjdYBhISDbNq4EVyC8OKeUW5V/SLPFagUkbjNbGMXE
IUz5P6dJ+UFfqLU6GfidVBUciH17vOaKYFPNJQ/H4R7TFyR8tfsTpBiD7HO8V+Xa
ck7YlbmBabHWjApQlWOj1uBy6NIvsBQwQVgVfHP1hRs8V5Ft4ADi+lBfDDrCCC39
ICZwHwFJXUH5y32MFdYBq1MHRUJiow==
=lHNq
-----END PGP SIGNATURE-----

--exkb54tmb3ufc4j3--
