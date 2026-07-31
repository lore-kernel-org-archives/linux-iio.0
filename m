Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C050400E1A;
	Fri, 31 Jul 2026 14:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785508783; cv=none; b=GH7CpVWXDigQY8UdUMWPUbhxtsNqqpXj0/gZmmmetfiPNJQGeVrrAG4B/rn+SPPULBUErsLKTtmFTZu51HeTtr+Gan9UVtq6daFFXOL41fHAfp9NGHGPeg1Q1gfVkWc+NFBzUD7Wg4KMjAvZKbOkq+Xv98DboDf3N3LirFvysWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785508783; c=relaxed/simple;
	bh=U/5XQK/L7yYZk9xQ82GY4qt7EW00pexUQsC+XdH1Wq0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uaBvKKb1xCobmY2PchndtdvBZCcKsCauS+aQqnX+nwh3OQ9FVpH/gK5sS99hbSQB3gOvO0HMVF1eit4tTTxKGnGJIT3HTEUAwwzqQ9INFyLSQTu+KsAAKITTGX/l2Yh22au2nZXVbEUBfuPw2WbIMRw36mDMe3nCQ7qZaAKuBmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GnPU6xko; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GnPU6xko"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A1F71F000E9;
	Fri, 31 Jul 2026 14:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785508782;
	bh=ryPqQ3wPmCBEPuGEr6/KTKvRORIV9Tt/Y/mcOa0Awic=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GnPU6xkoCSSVpSd9iPfsPBPZCeAS+4H/65Muv9K6QtU0IZw0TWPIWncaa0SGtheuS
	 fTBmVUq65ERZCUU4zP2C0rFB3Nrm4U/8NWZ3Liia20PL5BdBl2RJwaWYmvoFwp8aGu
	 JWOY7oAtUj3zCBbS11A6El3u3UQxIIK+rn5KBbyvSLNNDIUNRC/8zB0k1UItgMT/as
	 D+R4qB1UJKMOT9Y4NyLbdySxnHTNXEwt6ygWDnRdImiQYlqY5YIehRr0Dk6OXUyJbo
	 aTbaMg/eBW56zuXqd0PyyGTgxmLyPtfgwbLFDD3YLxoSwnK0FMz3rc6G2JsEpvwNGJ
	 4dHJWkcIgNUtQ==
Received: from johan by xi.lan with local (Exim 4.99.4)
	(envelope-from <johan@kernel.org>)
	id 1wpoOh-00000000XLr-3kZN;
	Fri, 31 Jul 2026 16:39:39 +0200
Date: Fri, 31 Jul 2026 16:39:39 +0200
From: Johan Hovold <johan@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Helge Deller <deller@gmx.de>,
	dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v5 01/14] dt-bindings: leds: Document TI LM3533 LED
 controller
Message-ID: <amyzq2XEhiOH28DD@hovoldconsulting.com>
References: <20260617080031.99156-1-clamor95@gmail.com>
 <20260617080031.99156-2-clamor95@gmail.com>
 <akeFmMQ_S1Y18hlu@hovoldconsulting.com>
 <CAPVz0n23=F2Q2fSJJx1E_mST2zhomKcvhKtOy-Af3aoq-pZ-Zw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPVz0n23=F2Q2fSJJx1E_mST2zhomKcvhKtOy-Af3aoq-pZ-Zw@mail.gmail.com>

On Tue, Jul 14, 2026 at 04:27:08PM +0300, Svyatoslav Ryhel wrote:
> пт, 3 лип. 2026 р. о 12:49 Johan Hovold <johan@kernel.org> пише:

> > > +            light-sensor {
> >
> > Doesn't the binding (or dts) checker complain about this node not having
> > an address?
> >
> 
> No it does not

Thanks for confirming.

Johan
