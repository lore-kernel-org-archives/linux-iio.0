Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793501618;
	b=R4JM8KtqrV0Ce1VQsWrYX7G1vvDtdeZGtkYc8j5SGa0QjWfisMLAvZTc38RfACostS4O
	 TRw1sjksn2vvXeG0dIOr/3rGgdiuX16VzAMdPL5IeCvGaBdiA3MSHNMNCYCRhPR/e8xJ/
	 /3mHmkhdJZCKx6CjNIqocEXJV7UmFfsZ/XIDmFUyVKWKBzYAEGs4SojBp4x3nAAw4lcvG
	 phWUyyJfkwwXJlQBjO4wM56RCcnccFGJ38nPjB0MLLdOusr2si/Dfmn9N5YEFp1YQcJOF
	 LzlAmKcYwwYW2avWrG9ckOgUcnevyClB9DUDoCdF/DcrpVpfLyjAgLrGPyCnUPg7Xmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793501618;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=oi2Om/0yRV8ohoDUorxLi3TAR/FjA7v3NVIbPVXfGMk=;
	b=fJhW1Knk1Y7v9sKOslHhqyVQRVp8DcyhM8K7eR2UDq5S4w+vTHFXdZbrFOob5gETBnLT
	 DWD7nr9IsBrm2tJXkdtX7fRS+MR5HqizxmEgTt55YXZNc6Ho2uQwh+upNQipi6YKpvURn
	 8jeQgjCXjghz6PA/jVdaa0ffcFNLwePD7IMe8H3OssTDg0raIJjv0TKLKiQfmOQFpUW/E
	 TIx2+qssZjXanzSruMOUFsieNqMYaIbCt1ehI9JtDlM0y1zjbnPYBzcb4kRZ8xBiSMQgW
	 A5bTPbVSCj0X4MWdAlai9em1qfjNSimCHuAS155FbK3JRbGkvfkWi14Ta+LS+ev2qQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ikc572T1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE810606A324;
	Sun,  1 Nov 2026 02:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ikc572T1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18C4A1F000C1;
	Sun,  1 Nov 2026 02:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793501617;
	bh=oi2Om/0yRV8ohoDUorxLi3TAR/FjA7v3NVIbPVXfGMk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ikc572T14IdO7+Q5gL7kWsZMhWNNzS6xlTnow7ZOClBWwio3XgC1oE60a52Fq8HBl
	 cqzUXSLUVmN77cJSy0KtAuGSf3E4pChr3AoBfi5XWKdMt02cIu9mK/tQLZSoTS+Yyq
	 vPyCsG8h3zg2a0/yoBq6174FGnUQtTIL37nD3g5Ah58ZfVj/KT9AcjmWCFDaUld/wT
	 TL94QU2ZV6d8qc5V3fSAtbus1eptVtuw4aanNB8S/GA/H8g/HxTpP24SGAYQv7jQrz
	 F+QZqHopq5jSK+BKOeGnLdZwnA+kGFGP+M/JDcINnACaVFrufiPYTEKAs6E0/+Vunp
	 proxPaIyBFDWw==
Date: Sun, 1 Nov 2026 02:53:28 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Josef Bacik
 <josef@toxicpanda.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable <stable@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, Leonard Crestez
 <cdleonard@gmail.com>
Subject: Re: [PATCH 02/15] iio: trigger: fail the attach if no sub-IRQ is
 left
Message-ID: <20261101025328.51918bd8@jic23-hlaptop>
In-Reply-To: <auHCnFusqaw-CT7x@nsa>
References: <20261027-llm-char-misc-iio-v1-0-0d818334f6c7@linuxfoundation.org>
	<20261027-llm-char-misc-iio-v1-2-0d818334f6c7@linuxfoundation.org>
	<auHCnFusqaw-CT7x@nsa>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 28 Oct 2026 09:38:57 +0000
Nuno S=C3=A1 <nuno.sa@analog.com> wrote:

> On Tue, Oct 27, 2026 at 05:19:06PM +0100, Greg Kroah-Hartman wrote:
> > From: Josef Bacik <josef@toxicpanda.com>
> >=20
> > A trigger can serve CONFIG_IIO_CONSUMERS_PER_TRIGGER devices, two by
> > default.  When one more device is attached, iio_trigger_get_irq() retur=
ns
> > -ENOMEM.  iio_trigger_attach_poll_func() prints an error, drops the mod=
ule
> > reference and jumps to its exit, but ret is still 0 there, so it reports
> > success.
> >=20
> > iio_enable_buffers() goes on as if the poll function were attached.  The
> > write to buffer/enable succeeds, but no sample ever arrives.  When the
> > buffer is disabled again, iio_trigger_detach_poll_func() undoes an atta=
ch
> > which has not taken place, with -ENOMEM in pf->irq:
> >=20
> >  - iio_trigger_put_irq() calls clear_bit() with the bit number
> >    -ENOMEM - trig->subirq_base, which clears a bit in whatever lies in
> >    front of trig->pool;
> >  - if only one of the real consumers is left, the trigger is switched o=
ff
> >    under it;
> >  - module_put() drops a reference to the driver module which has been
> >    dropped already.
> >=20
> > All it takes is to set the same trigger as current_trigger of three
> > devices and to enable their buffers.
> >=20
> > Return the error.
> >=20
> > Fixes: 995438233579 ("iio: Fix error handling in iio_trigger_attach_pol=
l_func")
> > Cc: stable <stable@kernel.org>
> > Cc: David Lechner <dlechner@baylibre.com>
> > Cc: "Nuno S=C3=A1" <nuno.sa@analog.com>
> > Cc: Andy Shevchenko <andy@kernel.org>
> > Cc: Leonard Crestez <cdleonard@gmail.com>
> > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > --- =20
>=20
> Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>
>=20
Another one where it seems the LLMs are feeding the same to multiple
people.=20
Currently on my fixes-togreg tree is:
ef017c440534 ("iio: trigger: Return an error when the trigger has no free i=
rq")
=46rom Karl Mehltretter

> >  drivers/iio/industrialio-trigger.c | 1 +
> >  1 file changed, 1 insertion(+)
> >=20
> > diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industria=
lio-trigger.c
> > index 76926fee0f84..fc4651490d42 100644
> > --- a/drivers/iio/industrialio-trigger.c
> > +++ b/drivers/iio/industrialio-trigger.c
> > @@ -293,6 +293,7 @@ int iio_trigger_attach_poll_func(struct iio_trigger=
 *trig,
> >  	if (pf->irq < 0) {
> >  		pr_err("Could not find an available irq for trigger %s, CONFIG_IIO_C=
ONSUMERS_PER_TRIGGER=3D%d limit might be exceeded\n",
> >  			trig->name, CONFIG_IIO_CONSUMERS_PER_TRIGGER);
> > +		ret =3D pf->irq;
> >  		goto out_put_module;
> >  	}
> > =20
> >=20
> > --=20
> > 2.56.0
> >  =20

