Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794699463;
	b=yAPxvISg7O1R4h7RAO1nWS1F4GGJ3Xf8PsVT7bVFKxtUYVzfAdLCgEQsf6h2ZcpuSC5x
	 1jeTTIg+hzmsvZ+Pk9uQXTeQkbX83Eyz74PEmgAM0th1aSTEw6HRE0a5KpZXL0cw1lYJo
	 WWnyYQC7ViEok7+KzF0b3ZrPRTD8rWhdbaJj6muFA/WWesP74Ld457Ur5GK7upXueS+Z7
	 kJv51pfgJ2QJsYK5n7hkKVT9WyQmzE593T1Eg+V4uh2oqe+3rOtVdIBbOKcfGJkHsRuFm
	 XaGbEXfljd+stBQVSuniz90NYBaM6BG6fqQBn0ymq9fJekZQjh3v118ZD0nhx6f1zsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794699463;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=y5XyzBRavuP4okaOGXZ90TZzSPFe6fQb6IrQp9skEtQ=;
	b=b9cbJR0lA1CX4TzWIucAyDWE/WtEmwGbTVFmTlUcYAshL8ptGzI4ykWqY1WilMr3vml1
	 TD7JDJLmXMPv64O+CZXA9luMbx4ttovyTlJnTwrIkxJ+QWD6xrRzFkdrcT0OjZenc8/8L
	 51MejjjcxEw5VXVc5XPplDei/hAMCxvkm3lzUUM8y6FSswTYVMqGCN1FtvFj65hA2ZfGS
	 anNyumvFSFhl1zEZBhIfJmppTF2258Syh74ej+wljZSkHTLBmEaKZ4d2H0lQ+NcIr9cBf
	 sIVPmNwwVuDIBiigauLnAnUX/3FU5Vo+ouKpjAvjvLVJxI042syCACYpdWvGzAiLfXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ar702gn6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC225606A33B;
	Sat, 14 Nov 2026 23:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ar702gn6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64FBE1F000CE;
	Sat, 14 Nov 2026 23:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794699463;
	bh=y5XyzBRavuP4okaOGXZ90TZzSPFe6fQb6IrQp9skEtQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ar702gn6RMjcVpitImhXqL/NBu8WsHD/TjxzO6jHikyWtfI0RfUlO9xpncbL4vdjw
	 t2F/pL8gHd/ltW4wJml5iBUKijn14FyPfUnTzw5+CA9N/vv4Z2+lWmZt6MeKxac3Lw
	 xU6zoGu7E/F8HYNXsJsnRY2iBGa/B37Z7Z1R9teV8tXj3alTyonN4+Kan7PaqKfFXO
	 zU4Y+zwtMYK2MuWdSDxkwhBp7j4WfuJGdU3SnT5KkGzQ9dlt7hreUHOkk2hu5lFmnR
	 OzoNtYZw8wXW35hEpx5/m+Rho1mnbi33I36pF2FxFhEo1n1/7Kx0942xFP+YqwTL/B
	 3mlS1pxUy4oYw==
Date: Sat, 14 Nov 2026 23:37:34 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Crofts <crofts@kernel.org>
Cc: linux-iio@vger.kernel.org, Miquel Raynal <miquel.raynal@bootlin.com>,
 Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre Belloni
 <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Song Qiang <songqiang1304521@gmail.com>, Radu Sabau
 <radu.sabau@analog.com>, Maxwell Doose <maxwell@maxwelld.cc>, Tomasz
 Duszynski <tduszyns@gmail.com>, Erikas Bitovtas <xerikasxx@gmail.com>,
 Waqar Hameed <waqar.hameed@axis.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-kernel@vger.kernel.org, Jonathan
 Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: Re: [RESEND PATCH 13/14] iio: light: vcnl4000: poll own trigger
 from interrupt handler
Message-ID: <20261114233734.360afe30@jic23-hlaptop>
In-Reply-To: <20261109094632.00002649@kernel.org>
References: <20261109042851.1326940-1-jic23@kernel.org>
	<20261109042851.1326940-14-jic23@kernel.org>
	<20261109094632.00002649@kernel.org>
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

On Mon, 9 Nov 2026 09:46:32 +0100
Joshua Crofts <crofts@kernel.org> wrote:

> On Mon,  9 Nov 2026 04:28:50 +0000
> Jonathan Cameron <jic23@kernel.org> wrote:
> 
> > From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
> > 
> > Keep a pointer to the driver's trigger in struct vcnl4000_data and poll
> > that from vcnl4010_irq_thread() on a data ready interrupt rather than
> > indio_dev->trig.
> > 
> > With the driver's own trigger in use this is the same trigger. The
> > driver does not restrict which trigger may be used and the data ready
> > interrupt is enabled whenever the buffer is enabled, so with another
> > trigger in use the data ready interrupt previously also polled that
> > trigger, running its consumers in addition to when it fired itself.
> > Now samples are only captured when the selected trigger fires, with the
> > trigger handler clearing the data ready status as before.
> > 
> > This removes a dependency on the trig field of struct iio_dev, which
> > is to become private to the IIO core.
> > 
> > Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
> > ---
> >  drivers/iio/light/vcnl4000.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
> > index 911f8d1c74d4..cab6e0af8c7e 100644
> > --- a/drivers/iio/light/vcnl4000.c
> > +++ b/drivers/iio/light/vcnl4000.c
> > @@ -206,6 +206,7 @@ struct vcnl4000_data {
> >  	struct vcnl4200_channel vcnl4200_al;
> >  	struct vcnl4200_channel vcnl4200_ps;
> >  	uint32_t near_level;
> > +	struct iio_trigger *trig;  
> 
> Just swap near_level and trig and you'll eliminate a 4 byte hole.
> 
tweaked.


