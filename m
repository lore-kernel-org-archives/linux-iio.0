Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795657496;
	b=4oavtOQv8waEFOpsmnFhlrlmgbCIWBgdl+8oAaalz/TLqp+bYXdRMdTDv0wq7sZxztmG
	 C0yQl5PKuMGMOI4lWKH2WP3PnGzAGil5JP+7BlvRzM2ARoI3MJTKuc9q2zTsemX5vlyrL
	 vGBiNl9SXztUDlk79r6OFJvBQo/AlLSwz3KjiP7TfhNR6pOrd8ttY2c4GL9WKybNxXpdj
	 2lxF+BhZQqouHu6cIX+m31HnB+sFxQ+V4Ck/mWFZx84qpeYKRTDbsdgvdYYvp9Ksvh7st
	 GcyltWhYy2vgCc1G9ORHSAt5H8tyJgZFRd5q4ITO1J2xUkDjHUVjtw68kVT5tAaa6qw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795657496;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=mHw3fF9VwxtqgAqIm1+76NLfsCQVvS+qok5BB7sKrHo=;
	b=BjLBbkZpBjyuTyrdH2sONT2fAkx/m5tFfdKLC+LhF3nuMcKC+9rUoaImYW8fRPye4wwo
	 i0fZip4VBMUJPaPrBDS2w+Am24d8RG5Pv0T+FeEBLNXB2hFTkVTXFEfx15JuxjQry+G1L
	 4qHyJY/H7RjHgq3E7F4/V6WRUV3qvFJf8ooI7GOIe2+bYD4knCyrm7I55hA3r/V1ZY8Xx
	 yUyLCqU7W9HmBGxy4K2utCXZa8U4WkLlhcHpR2UZqX7GEnlr1sdlV1r8I4BKvSHHJ6rjf
	 kll/bWiL5sydSORMuujB1q0uLYdBmCz7Iz20kSw9H1LOp+5MTfzy45YIYRu9/86gTUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RBhVMI+r;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40D1606A31E;
	Thu, 26 Nov 2026 01:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RBhVMI+r
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB4EC1F000C4;
	Thu, 26 Nov 2026 01:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795657496;
	bh=mHw3fF9VwxtqgAqIm1+76NLfsCQVvS+qok5BB7sKrHo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=RBhVMI+rKIFrOS1JTVAAqt5cNeiv/1UmGQKoOL8RegRUvo7NJYKzO5wvw2LGsMeYY
	 0BOfgcjeSnXfTGI1bI5T7kK/WwAzCDC74OT+ENoEJD099+l5sDvERZ+E8Pq3Z1Af06
	 Ir3NJy0eJlLj1xRPD/OsIREGqOKKcvNQK9/Ph20lTO1CR18ICnXMxVmZV643FaJfyO
	 KRJzP1l3oGqTXzOcqcEkJBPro8CcfmNDDeXR0LJ/zph4qS8febH5SgdlnnNYs2vS7/
	 Xknf5I71zJdtT2eWvY39WB264PkkLS5vbo14pTfmii4AneM/R92F6Bil6wEyle7w3O
	 oZHEh1T5QRtxA==
Date: Thu, 26 Nov 2026 01:44:49 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Joshua Crofts <crofts@kernel.org>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, David
 Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, Rupesh
 Majhi <zoone.rupert@gmail.com>
Subject: Re: [PATCH v2 1/1] iio: core: Split debugfs routines
Message-ID: <20261126014418.6eb2a97a@jic23-hlaptop>
In-Reply-To: <awcaWIBZbS4Iq4uj@ashevche-desk.local>
References: <20261125140251.384361-1-andriy.shevchenko@linux.intel.com>
	<6d517c95-82e1-4713-bc1f-9922a975e26d@kernel.org>
	<awcaWIBZbS4Iq4uj@ashevche-desk.local>
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

On Wed, 25 Nov 2026 19:26:48 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Wed, Nov 25, 2026 at 03:22:59PM +0100, Joshua Crofts wrote:
> > On 25-Nov-26 14:59, Andy Shevchenko wrote:  
> 
> ...
> 
> > > +static void iio_device_register_debugfs(struct iio_dev *indio_dev) {}
> > > +static void iio_device_unregister_debugfs(struct iio_dev *indio_dev) {}  
> > I checked Sashiko and it points out that building with debugfs disabled
> > causes compiler warnings:  
> 
> Right, you were a bit late after my reply to myself :-),
> but thanks for double check!
> 
> I think this warrants a v3.
Sensible change. I'll wait for v3. 

Thanks,

Jonathan

> 
> > After adding inline,
> > 
> > Reviewed-by: Joshua Crofts <crofts@kernel.org>  
> 
> Sure, thanks!
> 

