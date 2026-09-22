Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472B36FC3;
	Tue, 22 Sep 2026 00:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790036622; cv=none; b=VqemyyW8R6xPgzt6SHCHWw1oDH6/PSuP/4/JQywlBLL71cQpgnjX7fPpjfqZLy9DoywLsbCcNtheWsEK0no2e5XBy2PQkBxum8ZD/Gpt7+2//pHT/iwaQWEJhmB1jjwLf/E/IKs2korbqo0wk8PAingFg9imdF3uSfsxDTrXnJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790036622; c=relaxed/simple;
	bh=p63jFiCl7gko0jJ8Lv6dEIlYqkJSIxxv08Cttfe3yqo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=docyMAQzWW6XHFZn3QSqb+ECAbP6+TeqPRPEiWil4hrj1T1MtFo/NgWYtAeo/ar9saUbmonCrhkzOuP3sAb1Q8rg9KDY683eDqJ/S63C0TJbEvghx8V6A9fhaMiTJubnYlxvPTRkGNLSgdIntqQx7ufgYj/IjaJox167RFA8zwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H145PbDW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H145PbDW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E38611F000FF;
	Tue, 22 Sep 2026 00:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790036621;
	bh=p63jFiCl7gko0jJ8Lv6dEIlYqkJSIxxv08Cttfe3yqo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=H145PbDWwspoUI5vQRxdx/xjPWAG5e4ph065fkPR0aUmj6lgToYtEHG4rcZgLvvuE
	 QYBsW6EJgBGYJ+52rkkggbaZcgANDKGClCic5eyIa/T8ITCUP24Stc6Bo6tK/jnRTQ
	 wbWqmpEEsWD+Bu/6jdS6sU3cEC+T/QP4qdNxbse/PebprghErN8q2F0pTjyOnfK1jz
	 QFSro5fYY/P+kWoLew6Jf8BmX/6vlqqIi49l5UDswqgTpnZN13De9JFe2dw/TK2820
	 jGLfbZtHjS0Iudxz2Ei9xIIjiIMQjXsSsFdDD7LdS3eNUDTE4yWwCAj+eRaSFRTaWz
	 7tKm2TyxehgqA==
Date: Tue, 22 Sep 2026 01:23:38 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Chen-Yu Tsai <wens@kernel.org>
Cc: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>,
 linux-iio@vger.kernel.org, =?UTF-8?B?Vm9qdMSbY2ggS3LDoXRrw70=?=
 <vo.kratky@seznam.cz>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Samuel Holland <samuel@sholland.org>, Sakari Ailus
 <sakari.ailus@linux.intel.com>, Linus Walleij <linusw@kernel.org>, Wolfram
 Sang <wsa+renesas@sang-engineering.com>,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 02/11] iio: adc: change from %ld to %pe for PTR_ERR()
 printing
Message-ID: <20260922012338.66698120@jic23-hlaptop>
In-Reply-To: <CAGb2v66iTrHY-MHTKsFM=Wqf3vVLy-g8eg6M8eP573YX92MDig@mail.gmail.com>
References: <20260604120201.116925-1-vo.kratky@seznam.cz>
	<20260604120201.116925-3-vo.kratky@seznam.cz>
	<rfot56KMT1aR8vVOIe5xxg@gmail.com>
	<CAGb2v66iTrHY-MHTKsFM=Wqf3vVLy-g8eg6M8eP573YX92MDig@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 22 Sep 2026 00:08:55 +0800
Chen-Yu Tsai <wens@kernel.org> wrote:

> Jonathan,
>=20
> On Sat, Jun 13, 2026 at 4:06=E2=80=AFPM Jernej =C5=A0krabec <jernej.skrab=
ec@gmail.com> wrote:
> >
> > Dne =C4=8Detrtek, 4. junij 2026 ob 13:59:22 Srednjeevropski poletni =C4=
=8Das je Vojt=C4=9Bch Kr=C3=A1tk=C3=BD napisal(a): =20
> > > Replace numeric PTR_ERR() logging with the %pe format specifier
> > > so that error values are printed in a more readable form.
> > >
> > > This change was identified using a Coccinelle semantic patch.
> > >
> > > No functional change intended.
> > >
> > > Signed-off-by: Vojt=C4=9Bch Kr=C3=A1tk=C3=BD <vo.kratky@seznam.cz> =20
> >
> > Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com> =20
>=20
> Any chance you can still pick this up?
Not without Andy's feedback being taken into account as
it seems to apply to this patch as well as the one he commented on

https://lore.kernel.org/all/CAHp75VcKGfzQePh0TzsNBKPjHxr=3Dey8uO=3D4_+_oaio=
SNKkS8_A@mail.gmail.com/
>=20
>=20
> Thanks
> ChenYu

