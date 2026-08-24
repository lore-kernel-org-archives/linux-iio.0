Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 733AA4582FE;
	Mon, 24 Aug 2026 14:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787582710; cv=none; b=cirqKQvY2nNBOoJOjqo98ksxIQnAGONFPH9nbEVkDGFnET+wo53osezRlniCFFLuEdGL7lIAvsc3gNenzxSiKrPqbUb4m2eZoH6C5rbf3AySpDNu+DTWpUgPZ5owuPF6CUp7D9nTMOuL5BlEml7heKozNsZyghnPQ672d47bnFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787582710; c=relaxed/simple;
	bh=hLAGFYEYc8NaVpMg4EPPTMwlzlST3ntxnVnzT57vTb8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uO2uPlPdkw/98DRPDWoSau97/r2lNbtZAJ1EdYrx6BHOzWLxJu6KpIrC8BmmHV1OJ0VwJuxF+o1M6WuH+w35GS2TFREIDRyQ3DHTMl5tiVsGg+bRUXjBRa8lbwvT2+ITbLgQbaCs8926ERGmmGU8bWWAUe2SddhtCzdUNjob+Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from [IPv6:2a0a:edc0:0:900:1d::4e] (lupine.office.stw.pengutronix.de [IPv6:2a0a:edc0:0:900:1d::4e])
	(Authenticated sender: pza@pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 5872E201917;
	Mon, 24 Aug 2026 16:45:01 +0200 (CEST)
Message-ID: <31aa140058fde422c12e34fe926e7df01ba448df.camel@pengutronix.de>
Subject: Re: [PATCH v3 05/14] iio: adc: Add AD7768 and AD7768-4 core support
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Jonathan Cameron <jic23@kernel.org>, Janani Sunil
 <janani.sunil@analog.com>
Cc: Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, Michael Hennerich	
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>,  Conor Dooley <conor+dt@kernel.org>,
 Olivier Moysan <olivier.moysan@foss.st.com>, Linus Walleij	
 <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, Jonathan Corbet
	 <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, Michael Walle	
 <mwalle@kernel.org>, linux@analog.com, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-doc@vger.kernel.org,
 jananisunil.dev@gmail.com,  Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?=	
 <u.kleine-koenig@baylibre.com>
Date: Mon, 24 Aug 2026 16:45:01 +0200
In-Reply-To: <20260816201049.480143e1@jic23-huawei>
References: <20260813-ad7768-driver-v3-0-cb554399ad26@analog.com>
		<20260813-ad7768-driver-v3-5-cb554399ad26@analog.com>
	 <20260816201049.480143e1@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On So, 2026-08-16 at 20:10 +0100, Jonathan Cameron wrote:
> On Thu, 13 Aug 2026 15:56:58 +0200
> Janani Sunil <janani.sunil@analog.com> wrote:
[...]
> > +static int ad7768_reset(struct ad7768_state *st)
> > +{
> > +	struct reset_control *reset_ctrl;
> > +	unsigned long reset_low_us;
> > +	unsigned long mclk;
> > +	int ret;
> > +
> > +	reset_ctrl =3D devm_reset_control_get_optional_exclusive(regmap_get_d=
evice(st->regmap),
>=20
> Probably use a local variable for struct device *dev =3D regmap_get_devic=
e(st->regmap);
> to reduce line length.

Or just pass dev into ad7768_reset() as an additional parameter.

regards
Philipp
