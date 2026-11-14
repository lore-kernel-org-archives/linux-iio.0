Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794699352;
	b=wQHjy1FJxojIIPfG2F0Bl8SAu6d0u/f2h64mCtIA4Ulgq2N+vSDV3/RyAassq5EufnzF
	 7lxDJsCUscZkwtPXu9woEhS3EDYx1bhBZ463XzYxj4bxmqYwjbv8NCYLHOqKXdhPiNRs8
	 ot7eH0OJMwD7K62Y9MUOC7aW2mSfFV1JxW/JMcFepVi0OKrSg5FIU479Tpgl5rXXNh5As
	 nqbGpS2rLTNVBzEbncFsXL+33K7RY6tv1Za1MPlb6ar7300apJElbqyIdnB4J5OHJ4HUO
	 +Azm0tbUbR+c7j7uGokM27mOakqg7jiX9t3ifUewJkRJP3SWAlUVviCwlEx0Yz4X+5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794699352;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=0hLijEQmrtO8f9MefoCcZ2hV97tr8JlMlp8crB1A2uo=;
	b=4YAYWGu1EhPn2mAOVPr7I5K53eejxljy5hZ8dcWyY5MCgBuSH5qcVVe3CxBOa1uXYjJH
	 QeY2D6lWlAmtdRQDOmgecVWFqWkH7SEw6E/8+8FJDr3FEQy96Dpw6VzOmk00I6W24z/td
	 /ZgKy4byf3usoPfv7hb+odAQNT5OgqtepSGNDp5U2ldMA8xGHOsPSnjEX5uM+JRMCLKz4
	 1UxWuPLpXnHuWh6bbVSS/6A3IWwilAPpPn3LPVN5GX9TFIm3FYzOF59Jcj85jHTRz0VdE
	 Pw6Cf2mikWMcT7KTdMkOeBUtvKTqelL2/R1KaEYyLCBWwRAEGIyxAOPmqMDxI9EVXig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nPgquv5P;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB24606A329;
	Sat, 14 Nov 2026 23:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nPgquv5P
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E9361F000C5;
	Sat, 14 Nov 2026 23:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794699352;
	bh=0hLijEQmrtO8f9MefoCcZ2hV97tr8JlMlp8crB1A2uo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=nPgquv5P6XwYkI2+baujnMYvwXejM9eYxtLRD5WmDc2AKewb1ObR2EBWVId3VSye+
	 TkDJ4ZQc4aJWQkjWBfMXqeWonIFrxQUrghK6yie7Kx3HxT/WRWGvo0a/r/kpSvYWBy
	 GUbsPCuyNE5UD5XUY1wWzcPu1xShU7TNwCmU/FJWut4a1us6IqSHLvAAbFftu2RDfH
	 X//JssVyWr0MC0IkFjDLMI0sBrZIdnQ9/8EPF39gEaKr9VopNxRBatpic9EkXxeJBP
	 hQqvOuWoBkgCIBZNAJAhtlLcA41kFJnIOsMmP/B+CGoNK8RX/jXvGiExHL215TrT29
	 //frY5Q/S1GKw==
Date: Sat, 14 Nov 2026 23:35:43 +0000
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
Subject: Re: [RESEND PATCH 11/14] iio: proximity: vl53l1x-i2c: poll own
 trigger from interrupt handler
Message-ID: <20261114233543.66b66ae7@jic23-hlaptop>
In-Reply-To: <20261109094202.0000284f@kernel.org>
References: <20261109042851.1326940-1-jic23@kernel.org>
	<20261109042851.1326940-12-jic23@kernel.org>
	<20261109094202.0000284f@kernel.org>
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

On Mon, 9 Nov 2026 09:42:02 +0100
Joshua Crofts <crofts@kernel.org> wrote:

> On Mon,  9 Nov 2026 04:28:48 +0000
> Jonathan Cameron <jic23@kernel.org> wrote:
> 
> > From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
> > 
> > Keep a pointer to the driver's trigger in struct vl53l1x_data and poll
> > that from vl53l1x_irq_handler() rather than indio_dev->trig. Only the
> > driver's own trigger is accepted, via iio_validate_own_trigger(), so
> > with the buffer enabled that is the trigger in use.
> > 
> > This removes a dependency on the trig field of struct iio_dev, which
> > is to become private to the IIO core.
> > 
> > Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
> > ---
> >  drivers/iio/proximity/vl53l1x-i2c.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iio/proximity/vl53l1x-i2c.c b/drivers/iio/proximity/vl53l1x-i2c.c
> > index bce238d1b6de..ffc6fe45b165 100644
> > --- a/drivers/iio/proximity/vl53l1x-i2c.c
> > +++ b/drivers/iio/proximity/vl53l1x-i2c.c
> > @@ -102,6 +102,7 @@ struct vl53l1x_data {
> >  	enum vl53l1x_distance_mode distance_mode;
> >  	u8 gpio_polarity;
> >  	int irq;
> > +	struct iio_trigger *trig;  
> 
> Pahole reports a 4 byte hole between irq and trig. Reordering
> like this yields a better result:
> 
> struct regmap *            regmap;               /*     0     8 */
> struct completion          completion __attribute__((__aligned__(8))); /*     8    32 */
> 
> /* XXX last struct has 1 hole */
> 
> struct reset_control *     xshut_reset;          /*    40     8 */
> struct iio_trigger *       trig;                 /*    48     8 */
> enum vl53l1x_distance_mode distance_mode;        /*    56     4 */
> int                        irq;                  /*    60     4 */
> /* --- cacheline 1 boundary (64 bytes) --- */
> u8                         gpio_polarity;        /*    64     1 */
> 
Good point. I guess I need to poke my llm to take this into account.

tweaked whilst applying.

Thanks,

Jonathan


