Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6AF218EB1;
	Mon, 23 Feb 2026 21:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771880443; cv=none; b=UAoSccznQCaISCGWxJJPk2BPpKxr4b/xtyjsyJ/jXZGGryuvCqIeTc9xpyNcWzVYpe4GpA0/eOrvzS5gZt+JmdKRPyPQTIzA0gG02jTvI6unBArzYJnUJfb0ITpIr/Mct5VhUFzE5A2plzLJti0W40ynI9R/1hT86o8xogNWtDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771880443; c=relaxed/simple;
	bh=F6gyhU2046GZPJuoOfw1gZiNCnRMZqUz+IOimqJ1DpQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eDtHqERvvqjr6oiVqjezZvQl4QcbWHGzSkDg3txXb1D4rC0izTRazbIZ7lj4uQTSR0FOC9Boa0X7LZwDT2lB1zm81XmwFgw8VkYR/N3zyjz2xLzL/LWcQxQ1HdTHFdu9EipQkVSONI8hDlCOvNDNabGn5pk1+/5S4DyWWT0ehJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ttvyR8c2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ttvyR8c2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A71A3C116C6;
	Mon, 23 Feb 2026 21:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771880443;
	bh=F6gyhU2046GZPJuoOfw1gZiNCnRMZqUz+IOimqJ1DpQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ttvyR8c2AgukDWapGzNoPI63jQD79ysXw2+l+dnqeGXDZSo001zmzsnUCvEsiSj6S
	 kjvyx/7vOyPzNjTKHB2CAldxwb375x+6GXHp+LSe0A91ikhwyUN0+h+aA1348ympjp
	 +/3Ik75XzTP4Jx69sB/5yQfkRGoI4fKaZUyFaIBdOa2AiFiryn+gB38rXOuZiK4ZKs
	 2c71hgNhvA33U0p6yBgf8WPwFZ1DUCXCqo3f98U6f0gTlGbvMRQg2VIsTOitOS6skU
	 ESwphqy/TJCrQl50D6W5IEDdkYd9xkUz1Y6SEKgi9GfwrOZ20Wt7uJFL/U6eAUMfss
	 xAMZ0ptVp3oXw==
Date: Mon, 23 Feb 2026 21:00:35 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v2 1/1] iio: core: Simplify IIO core managed APIs
Message-ID: <20260223210035.47341770@jic23-huawei>
In-Reply-To: <aZtT3pDS9X6pGVnT@smile.fi.intel.com>
References: <20260220132912.2392102-1-andriy.shevchenko@linux.intel.com>
	<20260222165411.427e6a9c@jic23-huawei>
	<aZtT3pDS9X6pGVnT@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 22 Feb 2026 21:07:10 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Sun, Feb 22, 2026 at 04:54:11PM +0000, Jonathan Cameron wrote:
> > On Fri, 20 Feb 2026 14:25:19 +0100
> > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> >  =20
> > > Use devm_add_action_or_reset() instead of devres_alloc() and
> > > devres_add(), which works the same. This will simplify the
> > > code. There is no functional changes.
> > >=20
> > > While at it, inline devm_iio_kfifo_allocate() into its only user.
> > >=20
> > > Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com> =20
> > Nice.  Applied =20
>=20
> Thanks!
>=20
> One minor thing though. The iio_kfifo_alloc()/free() uses variable name '=
r'
> while devm_iio_kfifo_alloc() uses 'buffer'. I was thinking again and now
> I probably would go with 'buffer' in devm_iio_kfifo_release() as well
> to have a symmetry with the devm_*_alloc(). If you think it worth changin=
g,
> may you fold it? (AFAIU the applied patch is still in the pending/testing
> queue that is okay for rebase, squash, et cetera.)
>=20
Ok.  Whilst looking at this I noticed there was a stray docs
reference to devm_iio_kfifo_alloc() Which doesn't exist any more so
I updated that to refer to iio_kfifo_alloc() which is what is called.



