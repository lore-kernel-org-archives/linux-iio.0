Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793575728;
	b=tJhZSkFtEw6CL7sK3MzB9f+iobA/31COI13tli7nysC/p/7bBzBDumcGW+oG9VnzHmsX
	 8W1l6uxsU5WDLD0V9lEjGSS9WaaJBydFvF06pTbSAsFwFEQT6prfyjEv1G4Lqlvb283NN
	 pJiA6z8AO4O+VFowQ+D22Oya8D7Y2H4PA0anXga/Picfb3Uc9zBjSoGTVD3bxSa8psdpq
	 Fe0UpJJstJNyypAttUyMJm42f/vb3jltVSiTH3eOwQI2rMIX6rRA8HDtwr9v2eQS7Nvm8
	 FlNDZYaToS5y9bbkxiZgcAEgnt37PdxerEPXD3jG/i2Gt8GsCA3rAU/CYxVcni5ErAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793575728;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=MN5KK8jKhXjnMlMrzDOYdQ79mkQ5D28TMuJpUxh2iNI=;
	b=h6obTaMXx2/zx21mvx2UYUi/+urfLVf6O84rIgS+3RPDdI++PEJ3DATWw3uC1JxK43+I
	 N633wn4fiQhiw8oBUszR79HsJHfIqXjbOkVdrJrxw1qaGHAmhZYzOjeYxgsYDlvR1hIGV
	 KuJdTqTCL+LGycngmoywIRT0McASP5rFKHv5gCCI8tNtqCOWVmO3M1KhpMzBCKYSPUh6n
	 1Fj9a2aq7UcA05VvJQwyH/Cw3X0O6exjmUcCO5BcS5IWPNdpiGFHObnErellrW+pNA38Z
	 M1Lr7gaqQ2UyRw1xCNDsrjha01hnKIDrRWBBMnia0KkHL/PxG289EQHC6TM+oBz0h/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T2Du5A77;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D6260A2608;
	Sun,  1 Nov 2026 23:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T2Du5A77
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01D8A1F00919;
	Sun,  1 Nov 2026 23:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793575727;
	bh=MN5KK8jKhXjnMlMrzDOYdQ79mkQ5D28TMuJpUxh2iNI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=T2Du5A77vmFi2vkzBAegqF0X+Anh40oBzhQ+W3kXA5Djg7Z2Bj8Uph5upHMudHGJ5
	 ZM/O9Lik6L1xDr5Po5oHMzjuuxsAnnjJVgQnFAyz0bQz01/O1kM6EtNeb9o0yuglwr
	 PPB1lIBall+uvvtESGKyTH05QpGlrq4G+R45PTWgkVoD0AEbSv0tlEeXHitXUkybOy
	 7alHKphaAfW5xTdAmntNydPIssxqppT4czF5dq5bVLlsy7f2gsVfCNfrft3F+t4Pxj
	 gjtxDtaBm6olsJHdsObTP/1T1V7lr2Yb26o1ky1y/a/AueBszvL0P/2jDkuj28QFgl
	 JQY7UFbW3vseA==
Date: Sun, 1 Nov 2026 23:28:38 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jonathan Santos <jonath4nns@gmail.com>
Cc: Jonathan Santos <Jonathan.Santos@analog.com>, linux-spi@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, linux@analog.com, broonie@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 Michael.Hennerich@analog.com, nuno.sa@analog.com, dlechner@baylibre.com,
 andriy.shevchenko@intel.com
Subject: Re: [PATCH v4 2/9] dt-bindings: iio: adc: ad7768-1: Document
 multidevice support
Message-ID: <20261101232838.591e2dd9@jic23-hlaptop>
In-Reply-To: <auWKdiIzL1Gykxkk@JSANTO12-L01.ad.analog.com>
References: <cover.1792435248.git.Jonathan.Santos@analog.com>
	<6e2176d5547c59c39bb692e9768d7ac079b40f71.1792435248.git.Jonathan.Santos@analog.com>
	<20261026020500.6c13c0e6@jic23-hlaptop>
	<auWKdiIzL1Gykxkk@JSANTO12-L01.ad.analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 31 Oct 2026 03:28:06 -0300
Jonathan Santos <jonath4nns@gmail.com> wrote:

> On 10/26, Jonathan Cameron wrote:
> > On Tue, 20 Oct 2026 22:56:56 -0300
> > Jonathan Santos <Jonathan.Santos@analog.com> wrote:
> >   
> > > The AD7768-1 family supports aggregating up to four devices on a single
> > > SPI controller, with each device occupying a dedicated CS line and a
> > > single data lane.
> > > 
> > > Extend the `reg` property to accept up to 4 entries (one per device).
> > > 
> > > Add `spi-rx-bus-width` property to declare the per-device lane count.
> > > Since each lane is bound to one CS, the number of entries must match
> > > `reg`. Make it required when `reg` has more than one entry, along with
> > > `spi-cs-composite` property.
> > > 
> > > Add an example for a four ADAQ7768-1 aggregation, with shared DRDY and
> > > SYNC_IN pin.
> > > 
> > > Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
> > > ---  
> > 
> > I'd suggest some asci art might make it more obvious what you mean here.
> >   
> 
> Ok! in the commit message, right?

Probably. If it feels too much under the cut, --- with a lighter description
in the actual message may work too.
