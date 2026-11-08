Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794167329;
	b=qsNTi+hJLBtOifc5B6SGzSJTSOc4kD73GEfLgqY70OHLq9LGDYzjrqkIJ+7Q6vAk24nJ
	 9RX6rWihQQLjAQAO3rvYfdUnwCtw22elCE2xkOBFeZD7B34aTQCjrAInxrnMOYgP8J+5s
	 yUXInCeOIpwV7/5Gcl2hOJZupRHIVLHvVoiR0M7oVNUW603WxurxjbtXC2KPRLRbYEm1s
	 ndhxiy7m01N/0LTILshYQeogiG5eCvqxsnZIWboKAlNfZMVQfJYxgUmTUrDeldU3F0cMB
	 VItj7XaPgsbKUEjI0Q92bu+oRPFAyGF+tBE8Lq8pJddNZ5VN/+eWcSRZ3APCDRwBUSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794167329;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=DsMQNwNDiCWW1aTFXx3EfXXKFYgiH/gneXFX9OLWif4=;
	b=NWhN2DF/FWdfAQVoHC4mtjJhtS/tAY7I1PnDHfNPD6zkO7ufHXHGoZ3qsaeCgYPqfDZf
	 2KGcE47+JL2WHsylkjm33lmo5xuUuq3VMYijEdfBsujp1+0hgR8HPFxf4YbM8pLZf4TWI
	 mgzfwTAY3DVDHit5GETiFmfcMS/H61sKfsqlNpd9Jua6TR9WmvVfrTDI7LLDPu19C9QsR
	 6JTPTaKKbC28QAzjH/lytjMlMgaNBU2Y4B8QKdrsoTfROSMI1Q+Yy6H2DT7irYILMr0lk
	 joL3DmK6UpcFrgD4f4Q6QFudUlybuN1XUdH1puiF5glmiKw6EMXbuobuUH8On+OfAYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P4GS2e9g;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33A8606A31C
	for <linux-iio@vger.kernel.org>; Sun,  8 Nov 2026 19:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P4GS2e9g
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B9BF1F0089F;
	Sun,  8 Nov 2026 19:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794167329;
	bh=DsMQNwNDiCWW1aTFXx3EfXXKFYgiH/gneXFX9OLWif4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=P4GS2e9gZKCu/wgRoOfrwySeBKNu9kJKE01IN/4jQHFOmRQZNKMVZiVR2OKvPqdYi
	 n1KwmrA2Nci+jDsd9mOOLojd1pbZ2aroIsm6SH0yD+XyUH+FgOrEC3sL8coqvLYXBp
	 uYtHq9yjBEUBY8J08oIs+mgkzsN90bhoAcOB0VMTy4f7oXyxpWidI9tyZOifD7jKfr
	 jIPpEXZmGc/xwmwPR/gg+J9vHbgnDhJmTdPSqqmGt1NbuQLM/JSW4QYNCeOZ2iMZmV
	 V3bmW69AO/h9t+DUEHl202umidNO8jMarM0V8ow3I3rbGi5AtP6y7z50dW76NRwVym
	 hlTO+doZIXFGA==
Date: Sun, 8 Nov 2026 19:48:43 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 "Andrew F. Davis" <afd@ti.com>
Subject: Re: [PATCH 17/39] iio: health: afe4403: use
 iio_push_to_buffers_with_ts()
Message-ID: <20261108194843.467aa829@jic23-hlaptop>
In-Reply-To: <auBf5WQlpOrJF6x0@ashevche-desk.local>
References: <20261026-iio-v1-0-8b136778eedf@oss.qualcomm.com>
	<20261026-iio-v1-17-8b136778eedf@oss.qualcomm.com>
	<auBf5WQlpOrJF6x0@ashevche-desk.local>
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

On Tue, 27 Oct 2026 10:25:09 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Mon, Oct 26, 2026 at 04:05:35PM -0700, Jonathan Cameron wrote:
> > Replace the deprecated iio_push_to_buffers_with_timestamp() with
> > iio_push_to_buffers_with_ts(), passing the size of the pushed buffer.
> > 
> > The pushed buffer is never a direct SPI/DMA transfer target, so move
> > it from the per-device state to the stack. Use
> > IIO_DECLARE_BUFFER_WITH_TS() since the timestamp offset depends on the
> > number of enabled channels, and zero initialize it.  
> 
> ...
> 
> > static irqreturn_t afe4403_trigger_handler(int irq, void *private)  
> 
> >  	int ret, bit, i = 0;
> >  	u8 tx[4] = {AFE440X_CONTROL0, 0x0, 0x0, AFE440X_CONTROL0_READ};
> >  	u8 rx[3];
> > +	IIO_DECLARE_BUFFER_WITH_TS(s32, scan, 8) = { };  
> 
> I would move it a bit up, giving the visible context to be even before
> 'int ret...' line.
> 
> ...
> 
> > -	iio_push_to_buffers_with_timestamp(indio_dev, afe->buffer,
> > -					   pf->timestamp);
> > +	iio_push_to_buffers_with_ts(indio_dev, scan, sizeof(scan),
> > +				    pf->timestamp);  
> 
> One line of 82 characters is okay I believe.
> 
Both done and applied.

Thanks,

J

