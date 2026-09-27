Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA2033DEE9;
	Sun, 27 Sep 2026 17:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790529611; cv=none; b=EOJefVC14Zve4vKt8x9vnp7PY0FZrmeIrW8UigNZc+zk8LGSHjVIcWtfBUGhBOJSeLwnmShst0Peb7tgi7O2J2gTCV8YSJHOa4IfKBmYmo+PboLYE7TRsWtWES/Db+y1pgOVXPHap6N72nLRioahzvJKH9vL1w81sZl8Povmy0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790529611; c=relaxed/simple;
	bh=22g2bhWEVOzBB93cClGUub2SG10F+1foaYL9rEaxCvY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PM6iInd30g5t9KgU9E8bLwsnvc2WnCEXExoKH8HVTRVv8NnEVtoZFoRIQDx7g7DAf0dHhdWzJJML6DfjVNfaURNkbDkzoHnwVpSikjN5Xg/CnamionjGrVGijEMzgSjekTgVj7qiSSMgwEVknYaQRMMCJ+lWrNNBDskw6VM/bvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AXy6B9F1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AXy6B9F1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17FB91F000FF;
	Sun, 27 Sep 2026 17:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790529609;
	bh=dnqbkM979B+9s4buxvI+GIWuF41/BLvgBEICg7/Xe1I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=AXy6B9F1w7AWTQOzXSyTTzNE5szGZ4p/FQnPeb2+6RwYkEe3tinzafVy9dFmc1G/x
	 DGeDrl0p/dsEELV5pLsKC5i0HxKi3qaR3KZUwmAHyKQQt4ErXn6PNzpAEM++odY3bS
	 zrC0ge4/sKjW6LYYRsArVzmC8lsxkkgFsBz2zHHVPtPf0Mp8jVIVAW+F4LkMJ91fht
	 e3RsBFiuxBUntYlnr+PceMJtbS+BfJTnrVPKlcwVJYQ22YLobpv/uUYPTlyhCZOx3G
	 dg98E38R49wJZiFSWYs/A8RT/uMeLjxqeqHTn8JAg1PR4XWSvoxwkH1mxZ/mX4hGHW
	 29XJ6fjNjkjLw==
Date: Sun, 27 Sep 2026 18:20:01 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= (The Capable Hub)"
 <u.kleine-koenig@baylibre.com>
Cc: Jiale Yao <yaojiale02@163.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Michael Hennerich <Michael.Hennerich@analog.com>,
 Rodrigo Alencar <rodrigo.alencar@analog.com>, David Lechner
 <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, Anshul Dalal
 <anshulusr@gmail.com>, Antoniu Miclaus <antoniu.miclaus@analog.com>, Herve
 Codina <herve.codina@bootlin.com>, Shi Hao <i.shihao.999@gmail.com>, Linus
 Walleij <linusw@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Angel
 Iglesias <ang.iglesiasg@gmail.com>, linux@analog.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] iio: validate SPI match data before use
Message-ID: <20260927182001.10c331dd@jic23-hlaptop>
In-Reply-To: <ardhvKaSdYh2HiS6@monoceros>
References: <20260925131738.2200612-1-yaojiale02@163.com>
	<20260926021143.478d5361@jic23-hlaptop>
	<ardhvKaSdYh2HiS6@monoceros>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 26 Sep 2026 08:13:13 +0200
Uwe Kleine-K=C3=B6nig (The Capable Hub) <u.kleine-koenig@baylibre.com> wrot=
e:

> Hello Jonathan,
>=20
> On Sat, Sep 26, 2026 at 02:11:43AM +0100, Jonathan Cameron wrote:
> > On Fri, 25 Sep 2026 21:17:29 +0800
> > Jiale Yao <yaojiale02@163.com> wrote:
> >  =20
> > > SPI driver_override can bind a device without a matching entry in the
> > > driver's ID tables.  spi_get_device_match_data() then returns NULL.
> > >=20
> > > These seven IIO drivers use that result without checking it, causing a
> > > NULL pointer dereference during probe.  Add the missing checks before
> > > the match data is used. =20
> >=20
> > I was hoping we'd close this finally by adding a flag to the
> > drivers to say they should fail a match if driver_override is set.
> > Given I thought maybe that would happen when Andy looked into this
> > a while back I've been sitting on this problem for a while.
> >=20
> >=20
> > Unfortunately seems we have to carry on papering over it in the
> > drivers for now :( =20
>=20
> Note there is another effort:
> https://lore.kernel.org/lkml/20260922-driver-override-opt-out-v1-0-58c35d=
ed3b83@nvidia.com/

Nice. I look forward to ripping all these checks out again
if that lands. Obviously we won't backport doing that given the checks
will remain harmless.

Jonathan

>=20
> Best regards
> Uwe

