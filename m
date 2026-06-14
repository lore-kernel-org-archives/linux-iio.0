Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CAF526C39E;
	Sun, 14 Jun 2026 17:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781458735; cv=none; b=L4fOlOAvZ9Prr/w3wXU8y62peajaaLn1BTgcYqYGW54ptd+LVukhIL/LdRusW/pYwDnRcJAb9zam1+DARsqyye8qeRJmhH0/EFX+GSObR3ZXOL5syzzTHrmcW0gxq+xDlAe45GBqd1DVPXhkRlK9PByWK/CnUh3TYBe5IuhkEh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781458735; c=relaxed/simple;
	bh=bEpZKF9U01VjxwL07alOw1fKe9y66+65FXhcXAfo3vc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BRPYGLk3OkB7juKawj8Gv52jFIa164QYWtNMpX32y2wshRkbLXL+D2rCG59wiWIRZZQusDDWACQ21NdKCJPyXK8up8J+ewp5QJSbjDvwD+wpTI+WU33tfoT6R30xj0kGSA/sBORVd+gk1rzfSqolG8CCaL8uS54vVY6zs906PR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UOTjM7oM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UOTjM7oM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9E761F000E9;
	Sun, 14 Jun 2026 17:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781458734;
	bh=ci2MUdoHHd3m5u/xk70es6YQKxF9EJrDNw3D/omyHVI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=UOTjM7oMomFIoIhOeOiztE50V9c3j/MZ6kCUVtgq89EYXcRc97AOvvtOCDY/jRSip
	 f9IZ4XvJrolAIUWgWF60QL7xQixEzO7lS/Z15j+CN+6JkpoqvavB3ItQlZGbD3TUxE
	 q+ctpLONyxew3+u86dcULzgh12trVWubSjrY614zold+evU7imsaw5/lwBs6ikI07b
	 NnvJCu6drzajKPYZCiLzIj6VkqqlF7muSgLhxXjuMKbzSW6ob4ebIm4Q2R5zYNIIVX
	 SUMhSkBlRm6gGEDuDSeMxxDlNn3drGKratMy1DqeD0m0idLBMBE5uFYobhxNfRT3mr
	 2qrRaYBn6WxsQ==
Date: Sun, 14 Jun 2026 18:38:44 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Maxwell Doose <m32285159@gmail.com>
Cc: Rodrigo Alencar via B4 Relay
 <devnull+rodrigo.alencar.analog.com@kernel.org>,
 rodrigo.alencar@analog.com, Michael Auchter <michael.auchter@ni.com>,
 linux@analog.com, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, Michael
 Hennerich <Michael.Hennerich@analog.com>, David Lechner
 <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, Kees Cook
 <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH v2 11/12] iio: dac: ad5686: write_raw: use
 guard(mutex)()
Message-ID: <20260614183844.0cad63e7@jic23-huawei>
In-Reply-To: <20260609171758.2077ebd5@linuxescape>
References: <20260609-ad5686-new-features-v2-0-70b423f5c76d@analog.com>
	<20260609-ad5686-new-features-v2-11-70b423f5c76d@analog.com>
	<20260609171302.5764edb2@linuxescape>
	<20260609171758.2077ebd5@linuxescape>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 9 Jun 2026 17:17:58 -0500
Maxwell Doose <m32285159@gmail.com> wrote:

> On Tue, 9 Jun 2026 17:13:02 -0500
> Maxwell Doose <m32285159@gmail.com> wrote:
> 
> > On Tue, 09 Jun 2026 11:13:06 +0100
> > Rodrigo Alencar via B4 Relay
> > <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:
> >   
> > > From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> > > 
> > > Use guarded mutex lock to facilitate code review when adding new
> > > attributes. This will allow for early returns, avoiding error-prone
> > > locking and unlocking in error paths. Gain-control support will add
> > > the scale attribute.
> > > 
> > > Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
> > > ---
> > >  drivers/iio/dac/ad5686.c | 14 +++++---------
> > >  1 file changed, 5 insertions(+), 9 deletions(-)
> > >     
> > 
> > I agree with Joshua on this, linux/cleanup.h should definitely be
> > included. However I don't think sending a v3 is worth the trouble
> > (Jonathan may tweak while applying but I wouldn't count on it), so with
> > or without:
> > 
> > Reviewed-by: Maxwell Doose <m32285159@gmail.com>
> >   
> 
> Although I will note that it appears that you haven't converted all of
> the locks to guard(mutex)(). While its only in two spots you should
> probably convert all of them. Either way, patch is obviously correct
> (besides IWYU), so I still stand by my rb.
> 

As far as I'm concerned it is fine to mix and match between guard() and
non guard() if there are places where it is too messy to use guard()

Sometimes it feels nice from a completeness point of view but I'm
definitely not insisting on it!

Jonathan
