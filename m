Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793577021;
	b=kBIj+TCAD6Rf3UbIpqa7tOwTNxpWc1A9dmvYGPRhSb7jM8y33/QDkVQPKasBG47IDPd6
	 8QHF4uvX3imuegc3fNgxp+eAimu1MYkrD22Szlt4P7ZR56wrbSIq0+aEB6qXSHr5fWwbP
	 nITeeNfma6I0s8hPRTX7tK9GW45L8EA63CnsO49OCqbTj0AU+gq4yoJ3Y1KVdHhx9cf1n
	 Wlacqk7v3OjqYAIa41z3bBrdW9xgBaVz2M0wpha6QR0Ht6zB+VHb7zvL28pEf8u6N92du
	 t7IrFLPe4n8h/eVkNUH2PFo6U6yW5Kn3p3hnAmEZZDuGIMV6f2haCIOEznCIxmCkzZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793577021;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=GtkyqXjaNZUhp+wtMvVWU33nxLUpc8+32fesBBYhb8w=;
	b=Jui8+Q+0DVF9eCiHWOAOlQrmCrF6uwHuZtLPKUrigv8gQ1ZO/EjK3Nk7Qj0heEjIsaUf
	 uJTLwBGLKym4+eG+2dFuG0E+v2Dz467TKChWwkLbV7zwDW1ZLj2Z//6NlCWfPtaVGldUZ
	 M0lSwE7kAP/dlP9g1XjnBWmP2tT4PdaSIxmZPQnKWkxaVeTjAM7nTP6nfdzYr8BQ9Rfij
	 8aWIu7OcrefuIjxiiCKT+cERbpsQ0R/hle3dSE3tP2ZUX5ZmNE1ThHmksUSTuU4Rg0OCR
	 oHzBncwo2bf8R+GIrbItkmxB2i8YGMtDhVrsFg6scPEbkapE4j/OMOCAXTYsrv1L/uA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i1mOGOEa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A9A4606A324;
	Sun,  1 Nov 2026 23:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i1mOGOEa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A5131F000C1;
	Sun,  1 Nov 2026 23:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793577020;
	bh=GtkyqXjaNZUhp+wtMvVWU33nxLUpc8+32fesBBYhb8w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=i1mOGOEaTLeFmzOBlUQPAipM3JBBEAnnb8FPetvslzNbDTb6qpgLHSXbJ5/6K+XYp
	 Vxzcv05w+wIcpMMbJHxghkLCTN4kiZWPTrxnY01jkZNmM6FNk2nXJxXmzHNkXujkI3
	 YM1Z6EKcixm75tmxi3B/Kqt0KAQMDWPFHWL4AMmsAwXd00DveNDZa4hKDlakL65nrB
	 a/SomYiUTTQrTbFdeC8ivQPr+v/I+sXilm2dP3ZtpH0sQCfnlDyVvI8gUdtTg6JPoV
	 T2kpvDdgJqRJjPQBCBmrIoC+doiFRsStkDDoA4dHB73vBWBXSD6eRYTVdvvnKuLUVb
	 NXfjgbWYCOO8Q==
Date: Sun, 1 Nov 2026 23:50:10 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: "Sabau, Radu bogdan" <radu.sabau@analog.com>
Cc: Radu Sabau via B4 Relay <devnull+radu.sabau.analog.com@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>, "Hennerich, Michael"
 <Michael.Hennerich@analog.com>, "Sa, Nuno" <Nuno.Sa@analog.com>, David
 Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>,
 Alexandru Ardelean <alexandru.ardelean@analog.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, "linux-iio@vger.kernel.org"
 <linux-iio@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, linux <linux@analog.com>
Subject: Re: [PATCH v4 6/8] iio: imu: adis16607: Add FIFO-based
 buffered/triggered capture
Message-ID: <20261101235010.79416e15@jic23-hlaptop>
In-Reply-To: <LV9PR03MB8414024B4B8A88109DE96B29F7602@LV9PR03MB8414.namprd03.prod.outlook.com>
References: <20261023-adis16607-v4-0-a4d541ebfd13@analog.com>
	<20261023-adis16607-v4-6-a4d541ebfd13@analog.com>
	<20261026000910.328f6cd8@jic23-hlaptop>
	<LV9PR03MB8414024B4B8A88109DE96B29F7602@LV9PR03MB8414.namprd03.prod.outlook.com>
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

On Tue, 27 Oct 2026 09:36:47 +0000
"Sabau, Radu bogdan" <radu.sabau@analog.com> wrote:

> > -----Original Message-----
> > From: Jonathan Cameron <jic23@kernel.org>
> > Sent: Monday, October 26, 2026 2:09 AM  
> 
> ...
> 
> > > +static void adis16607_fifo_push_sample(struct iio_dev *indio_dev,
> > > +				       u8 *fifo_data, s64 timestamp)
> > > +{
> > > +	struct adis16607 *st = iio_priv(indio_dev);
> > > +	u16 msw, lsw;
> > > +	s32 val24;
> > > +	int bit, offset = 0;
> > > +
> > > +	memset(st->data, 0, sizeof(st->data));
> > > +
> > > +	for_each_set_bit(bit, indio_dev->active_scan_mask, indio_dev-
> > >masklength) {  
> > iio_for_each_active_channel()
> > 
> > As sashiko notes, masklength is private.
> > 
> > There are a load of places we need to update to stop accessing these
> > directly but please don't add another one.
> > 
> > It's on my list to throw some LLM tokens ago once I get out from
> > under review backlog.
> > 
> > https://urldefense.com/v3/__https://sashiko.dev/*/patchset/20261023-
> > adis16607-v4-0-
> > a4d541ebfd13*40analog.com__;IyU!!A3Ni8CS0y2Y!9cguUuIwYMdnmBcoNR
> > ye0_U99KUnJt04T6XlSnvS-9rxh5-8Y2fQXC39Mxsw3erc_JwvyFp3ssecZg$
> > Check everything else reported.
> > 
> > FWIW there are also some nasty race conditions around active_scan_mask
> > being available when the buffer is being torn down. You might
> > want to close those off by claiming buffered mode to prevent
> > such a transition.
> >   
> 
> Agreed, I'll switch to iio_for_each_active_channel() and I'll go through the
> rest of the Sashiko findings for v5.
> 
> On the active_scan_mask races, I'd like to check which path you mean.
> In this driver the only reader of the mask is the trigger handler
> (fifo_push_sample()), which runs as the pollfunc.
> As far as I can tell, iio_trigger_detach_poll_func()'s free_irq() waits for it
> to finish before iio_disable_buffers() frees the mask, so I couldn't find a
> window where the handler sees a stale or NULL mask today.

Ah. I may have failed to distinguish between cases with a trigger involved
and those without.  The bug reports are probably on the ones without.
Unfortunately I haven't found time to look at the overall issue
in enough detail yet.

> Even so, I'd like to close this off for good, so that a later change to the
> driver or to adislib can't introduce the race.
> 
> Claiming buffer mode inside the handler looks like it would deadlock
> against iio_disable_buffers(), which holds mlock while waiting for the
> handler in free_irq().

We'd use a conditional claim in here - only the core code driving the state
transitions should take a claim unconditionally (they can just grab the lock).
If mlock is held it should fail and we just drop out of the handler having
done nothing.  So either disable buffer wins and we drop through the handler
quickly or it looses and the attempt to take mlock blocks in
iio_disable_buffers()

Or am I missing something worse?

> 
> Would snapshotting the active-channel layout in update_scan_mode()
> (called before the pollfunc is attached) and having the handler read
> only that copy be an acceptable way to close it?
It would but that feels like we are just papering over a lifetime issue
by creating another object rather than fixing it if necessary.

Anyhow, from your first comment this may all be irrelevant anyway.

Jonathan

> 

