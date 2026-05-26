Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8703A7F5F;
	Tue, 26 May 2026 12:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779798787; cv=none; b=pMJuQrKEhir1odEVEXhoNJxRxHYsPsXMEDa7By56y6AIV4YiY7pF+Eg+tvkKcbgSrmLWkUktnXu5sshcz/n0ZME06nhk1XUFNIWw9K8/k79L/6EDU6FCPsIcXK3W5TEgvD7oFjOXInLeZ3qdqKd0xznEcnUOMhzt7o+u+npke2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779798787; c=relaxed/simple;
	bh=YRUex1hghA+tO41he3dHRIZQx/gJ1U/095M/6qHa47E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l0vEhy1X7p1GYFKRGEk5m4Ss0AURWgteqrfI2cEwwvjyZWX/3EJ60zRrWpYuxs4wNdBCJDxp8JJYOSpUVzqOnz/pgK0NEmTCvolvB0pqQAOL+n2pZhLs6squFs8xr6hw5WODEVpVy7C5mr5o+GrhLNvB8m5y+mqzTdGTBM++IG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LPyFj7Fi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LPyFj7Fi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE7C11F000E9;
	Tue, 26 May 2026 12:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779798785;
	bh=UXy+Aq3ip8ggzdAob3fH1MwYAHbx0+lsclrzD0G6o8Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=LPyFj7Fi/8dsVw+6KLIF3BQeHFNvnYUAHDLUn+9cvtKgFfeoJPLCv0wXAUzwY5Rk2
	 AebALP6aVBQr1C3Qpmswmy+KrWdhLFV0RMdoGZLYVQ4dXipG0If4ZDGpAvtoEb4Rhv
	 4B2xW/UDP1eYZgKwZUbbVUforJgUFyBidA+Z2cGHT3INUyMchg+239WbgMwt8qbkh9
	 ShRLuNTbJdzTx73JwXczuKZUYUo/6eq6vBjA+ovnx6/cw3FpkUWghIFjiMvObZQ0Zr
	 kD1vgyWsH7IfBASq6FvSlO/cZFgIDJHrEJi8k80o8jhAxvthcWSLn9oagATDvk/4Jj
	 nUDtkvro3rKlA==
Date: Tue, 26 May 2026 13:32:56 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Piyush Patle <piyushpatle228@gmail.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Andreas Klinger <ak@it-klinger.de>, Andy
 Shevchenko <andy@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v9 04/11] dt-bindings: iio: adc: hx711: add HX710B
 support
Message-ID: <20260526133256.4b781fa6@jic23-huawei>
In-Reply-To: <CAMB+xkYUC-OqncD+SxOo9K36ZR9iC-5CFUs6wKojz2j+M24K4g@mail.gmail.com>
References: <20260518220228.63322-1-piyushpatle228@gmail.com>
	<20260518220228.63322-5-piyushpatle228@gmail.com>
	<20260520111919.5e99fe72@jic23-huawei>
	<CAMB+xkYUC-OqncD+SxOo9K36ZR9iC-5CFUs6wKojz2j+M24K4g@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 24 May 2026 08:15:27 +0530
Piyush Patle <piyushpatle228@gmail.com> wrote:

> On Wed, May 20, 2026 at 3:49=E2=80=AFPM Jonathan Cameron <jic23@kernel.or=
g> wrote:
> >
> > On Tue, 19 May 2026 03:32:20 +0530
> > Piyush Patle <piyushpatle228@gmail.com> wrote:
> > =20
> > > Add the avia,hx710b compatible and document the HX710B-specific
> > > DVDD and VREF supplies.
> > >
> > > Add constraints that forbid HX711-only properties on HX710B nodes and
> > > require vref-supply for HX710B, then add a separate HX710B example.
> > >
> > > Signed-off-by: Piyush Patle <piyushpatle228@gmail.com>
> > > Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> > > Acked-by: Conor Dooley <conor.dooley@microchip.com> =20
> > FWIW the only thing Sashiko doesn't like is dvdd is enabled for the old
> > parts. Move it to the earlier supply adding patch for hx711 and we shou=
ld
> > be good to go!
> >
> > Jonathan =20
>=20
> Because dvdd-supply now lands in 02/11 as a shared property, I will
> remove it from 04/11's properties block.  The allOf constraint in
> 04/11 does NOT gain a dvdd-supply: false in the else (HX711) branch
> DVDD is valid and meaningful for HX711 nodes too.  The only things
> forbidden for HX711 remain vref-supply (else branch); the only things
> forbidden for HX710B remain vsup-supply and rate-gpios (then branch).
> I think this will be a suitable approach, right ??

Yes. Sounds right to me.

Jonathan


