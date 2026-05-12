Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C435543D50D;
	Tue, 12 May 2026 11:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778584532; cv=none; b=o1SWbv3uawYCfOu66NTsgzIBJNGBzLXFfP8uSvRggZMmMcKKOkXGQgd5+F4/f9062hMzPj0Gg/+KNgx0Df+f85YKuVnRLFpYO5fO9+jB0I5P0nOflwODGxR8GdIDn7OOq6IxCgghFhffWsuIlq7EXmqgqvFOszgNUSWtYOrDe8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778584532; c=relaxed/simple;
	bh=nKcsGwq9fYD1dPRa8Aue0iDlpcE2T0iWXihzrNarpFo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XirAP6pnzsFOgrP+zsq/lWgM8hMo463OtPbD3nMjfFzJn+lnvKbl+BSNTekMg+U21X84oo5wZsYHAJldTQWKYnwqvBg037T1THvZ3B0UG0vBLIeHTMRvjKrBg1P1vE6cMkGHNzU4N65Epc/5bbgILvk6kh8DtHxHriIlAndPS4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=odHIjXlS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="odHIjXlS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F3D9C2BCF7;
	Tue, 12 May 2026 11:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778584532;
	bh=nKcsGwq9fYD1dPRa8Aue0iDlpcE2T0iWXihzrNarpFo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=odHIjXlSd4Gz27vuWCJy4F+8TWHDbGub2qRt6MW9zcr/LeoeyZVSeU/Glh2amttzn
	 jtqcKhBVpAWgEKX/hYWyKL73ktxYlBZOw8glwyZA3nbdtPkc9dI7e4HdR5vVA4hoPp
	 tDAa9Sn8RpvWBK23gkrQ6uEKofrsGRf6sGVTKL/7eB1vLLK2wP/7SupcbIghyqmue5
	 p1EM4s88YV6vKlRDOJloYh0nh6iMApmmPCS29eEFERY0v5z3TM/PXqDrZC054qEhlu
	 EUzGKIl6IeZZ83r8ZSZDjL5mwJs2gSVLXaKy32yVd2L/1FH0L9S6KXFhABWDUBQfDF
	 b9PxVrBA8f77w==
Date: Tue, 12 May 2026 12:15:23 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Joshua Crofts <joshua.crofts1@gmail.com>, Nuno =?UTF-8?B?U8Oh?=
 <noname.nuno@gmail.com>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/8] iio: magnetometer: ak8975: switch to using managed
 resources
Message-ID: <20260512121523.0e3f4911@jic23-huawei>
In-Reply-To: <agLjiS9xv9HyzX8K@ashevche-desk.local>
References: <20260507-magnetometer-fixes-post-pickup-v1-0-37827ca68fb3@gmail.com>
	<20260507-magnetometer-fixes-post-pickup-v1-3-37827ca68fb3@gmail.com>
	<0a3e455c86cef14fe3481019031ebf04f98470f7.camel@gmail.com>
	<CALoEA-x9TtnWbGCtTo-jhrJ7Zic1S7J=xRYSL0VZgOvTb1GGCA@mail.gmail.com>
	<agLd7t10HBjbEzYq@nsa>
	<CALoEA-zJTJ1nA7-7nyeMnF7m87utM8SZvTBcMOY6kibZPA4-hg@mail.gmail.com>
	<agLjiS9xv9HyzX8K@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 12 May 2026 11:23:37 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Tue, May 12, 2026 at 10:12:35AM +0200, Joshua Crofts wrote:
> > On Tue, 12 May 2026 at 10:06, Nuno S=C3=A1 <noname.nuno@gmail.com> wrot=
e: =20
> > > > This is to prevent a resource leak. If we register the power_off
> > > > function at the end,
> > > > any potential probe() failures will leave the regulators on. =20
> > >
> > > Okay it does make sense! I now see the action is registered after
> > > ak8975_power_on() which what makes sense. Still would like to avoid t=
hat
> > > weird pm_runtime_set_active() call. It would be nice if we could
> > > guarantee through PM that the device get's suspended on unbind. Oh we=
ll,
> > > I guess this is ok. =20
> >=20
> > FYI, there is a new version where I addressed some of your comments. =20
>=20
> Btw, can we rearrange the patches that the most controversial one(s?) wil=
l go
> at the end (as much as possible) of the new series? Then we can work on i=
t with
> a less burden and unneeded dragging of the 'good' patches. Jonathan, what=
 do
> you think?
>=20

Definitely. I'm swamped (or as it's otherwise known neglecting the other
stuff I supposedly maintain). So anything that allows me to pick up partial
sets would be most welcome.

Jonathan
