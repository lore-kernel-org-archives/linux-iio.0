Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2455924C076;
	Mon, 23 Feb 2026 20:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771878911; cv=none; b=K1mFDbdZF0I5EzFkl58IDWrCU8L/mZlbVyHOpynmcNvnyF3qtH+3MPBM5tSYqzzXz7Gy4gh4q1eFVtpTYQ1g3E41UVUnamkRLYI14zxLB4TlhG6ZtGw4JggSFTwdWFVvWWFjfG96o10Aj1hqVqdS8+yf/T1aX5e0i4rVNJRgIl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771878911; c=relaxed/simple;
	bh=CwxESDdtZJgoW3sP5uhrwNZpdjX22fZ573QnSEijARk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lEBlZUrCISzveTBxO7WIrXD8YlGVwc8N+9E86Cjg8PJ9CqL6tnGFZD2wgzxHdnIlbSBAq0iSyI8N/voUq0PyVFKlzXb90dW3U5O6X0Tii8gdBYTz6CAuC2Lem3r6ObFJhhsnxpTwvYpkGJgQocvrlh4fih0tSW0Kd0K2NW6jmTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nwnJee4F; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nwnJee4F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E9DAC116C6;
	Mon, 23 Feb 2026 20:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771878910;
	bh=CwxESDdtZJgoW3sP5uhrwNZpdjX22fZ573QnSEijARk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nwnJee4FZwjPtLsiu0Jh+qAmoXIXWPXPYHB+whFVL1Hj8CczHmczxO5juOPlPaHUg
	 lPxVF/08RxGGYPNGNLuyeEDPVMJTtcapLYTjByBnsQaIk10ag0cWOVKJdql+o13UzY
	 fg4bUZyzlZwFcy5mGQPEMednfv/BID/A0k6XyMJD4GnUXTDBxLfpUHIZ+7UYND+P6e
	 6lbnR9LzPpdD7j4HpNziqUX9pjIjNFyBD+Ursz9A8g8ETJKncIPCJLtoHOmvgGmq0j
	 eNp+tmhKpqQ/Tpdu6OCdIqMZ2I0v8YBwJo1NFO12Nh+orLd9Y3n+B3+CUjYguO0Q36
	 xQGMQWTamOdiQ==
Date: Mon, 23 Feb 2026 20:35:01 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Rogue prince <rougueprince47@gmail.com>, lars@metafoo.de,
 Michael.Hennerich@analog.com, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/3] iio: frequency: ad9523: fix checkpatch warnings
Message-ID: <20260223203501.6c0583fc@jic23-huawei>
In-Reply-To: <aZwRbUyaILTZZvGH@smile.fi.intel.com>
References: <aZd2jAVnTIuz2o7h@smile.fi.intel.com>
	<20260219213549.59645-1-rougueprince47@gmail.com>
	<aZgLutMih65WdesN@smile.fi.intel.com>
	<20260222135054.2e2012aa@jic23-huawei>
	<20260222135836.3f8d7a38@jic23-huawei>
	<CAPC4XCQQcvsyNQKkU9vLdRaJSQRbVxa5DGExoBv5H1Vt4fChKQ@mail.gmail.com>
	<aZwRbUyaILTZZvGH@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 23 Feb 2026 10:35:57 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Mon, Feb 23, 2026 at 02:49:12AM +0530, Rogue prince wrote:
> > On Sun, Feb 22, 2026 at 7:28=E2=80=AFPM Jonathan Cameron <jic23@kernel.=
org> wrote: =20
> > > On Sun, 22 Feb 2026 13:50:54 +0000
> > > Jonathan Cameron <jic23@kernel.org> wrote: =20
>=20
> ...
>=20
> > > Given short nature of your SoB and that this is (I think?) your
> > > first upstream commit I just wanted to check that bhargav is
> > > sufficient to meet this level.
> > >
> > > What counts for this varies a lot by culture or country so if
> > > that is the right level of identification to use that that's
> > > fine, just reply to let me know. =20
>=20
> > Thank you for checking! Yes, this is my first patch.
> > Actually "bhargav" is fine for me , but if you need my full name on
> > signed-off (i.e Bhargav Joshi) then please let me if i need to send a
> > v4 with updated signature or it is possible for you to amend the
> > Signed-off-by line to "Bhargav Joshi " rougueprince47@gmail.com" on
> > your end while applying. =20
>=20
> Please, make sure you send patches with this SoB (using Bhargav Joshi).
> Also make sure there are no double quotes. It's all documented, please
> take your time to study Submitting Patches and Submitting Patches Checkli=
st
> documentation.
>=20
>=20
Just to confirm. Please send a v4.
SoB have legal meaning so best to have a clean record on list.

Jonathan


