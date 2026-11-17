Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794885321;
	b=tfvyW+LzaaCHeAx8FK1NjxsjsEI6drelZqIydAPX7zmrn/iLQ+VRoMuTzEeQZ20HNoEW
	 b82nWt4h7l5ZcVIrb50iYfNp6MBd2rIeSqb2oLto644Wacv0UyIbcTjZop2itg5MfnmaO
	 /YYRYcF9Rmd91cV3cfRKy9Vq7gsqPEttdkv84JtgRt1Qry9ub/xTzxHZJYKe8LC9cwq/l
	 B+LXvR8dnhM/jcf3BoN60mr4WstrEcrOL7bFeRAbMYrI/F1XqTrYJjvfnVgnNwyVIOuly
	 76HwhsQ/XK5AO5b+Ej0Fg4VMy6BUsNErkw73lFrtXEyMm76OU7A5HmsQRIYNdvhpJCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794885321;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=VuiJz2eGPHLfGtyJsLjaVLF/Zzns0rxzByENBKBwsmc=;
	b=QafxzCCd7hbNXgFicFQkEB0ZIQ3qZ3TyXNWFdCifruGRt3zSPpHfFp2q3hW7Iop+hAAr
	 jCFJ1ZlrK89HYBm9g4mhywUupKMk5AystRSs3l55ZC09BeCA8Qa1k+51HRItrQDknoh5Z
	 TnzDka+gjk3lZ6BZh3utYQScDk+4AFLb3xTW5Z5FjHYdKTYSTLLNvFknL4d+c01hiQynk
	 3kLmgsipFg62pWwSyXh6DvcpozoXEnDVYgjHzDf+CS9iy7Fn5fmZ2ZfzM8TNq/U5sYJC+
	 3OTUwvVzatRxIGwJy4gIJH3DgZM7N0q2bYyv3pfVK2Kbc1icWpHnNuwA+lrzP9Uycig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FIv68Yiu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1504C606A31C;
	Tue, 17 Nov 2026 03:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FIv68Yiu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0882F1F000C4;
	Tue, 17 Nov 2026 03:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794885320;
	bh=VuiJz2eGPHLfGtyJsLjaVLF/Zzns0rxzByENBKBwsmc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=FIv68Yiu8XfrJRoOfreho7V9a5y0AZd8TJ3oRMmD56blLULU+yEcRPfkRVkNRvQCz
	 b0rlWimhoQ9fZSHGwTUfbfM8PnZ4Un3D87e4yO7Fdb1Es3FuffU7v6HoRgPfI0odE3
	 cOXxX5dja2Adrj+6Z8fiE6DNliIRbSQCUbrwh89ZBj3j1TxWq2d7925U+Q1SpfKmxQ
	 Colugrk3US8k/94kEG/a7guJJTZ9RY2chsUmdWYDcm+18VbsEIXppxBXArP2L15PVb
	 5VW4IRjqrS6tYNS7fgLLQvOMP6Z/hup74n+weQYVRxMO1PAaGpi8DfE1jXvjWmeYYx
	 bFqU0pvn4G2wg==
Date: Tue, 17 Nov 2026 03:15:09 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: "Sabau, Radu bogdan" <Radu.Sabau@analog.com>
Cc: Radu Sabau via B4 Relay <devnull+radu.sabau.analog.com@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>, "Hennerich, Michael"
 <Michael.Hennerich@analog.com>, "Sa, Nuno" <Nuno.Sa@analog.com>, David
 Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>,
 Alexandru Ardelean <alexandru.ardelean@analog.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>,
 "Budai, Robert" <Robert.Budai@analog.com>, "Gradinariu, Ramona"
 <Ramona.Gradinariu@analog.com>, "linux-iio@vger.kernel.org"
 <linux-iio@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, linux <linux@analog.com>, Conor Dooley
 <conor.dooley@microchip.com>
Subject: Re: [PATCH v6 0/8] iio: imu: Add support for the ADI ADIS16607
Message-ID: <20261117031509.2dfbc85d@jic23-hlaptop>
In-Reply-To: <LV9PR03MB84141F84CA155F8CDD2587FAF77C2@LV9PR03MB8414.namprd03.prod.outlook.com>
References: <20261113-adis16607-v6-0-3f678719942a@analog.com>
	<20261114002522.34f8aeff@jic23-hlaptop>
	<20261114004955.71c7ed7f@jic23-hlaptop>
	<LV9PR03MB8414D877E31EFC41535C9FF0F77C2@LV9PR03MB8414.namprd03.prod.outlook.com>
	<LV9PR03MB84141F84CA155F8CDD2587FAF77C2@LV9PR03MB8414.namprd03.prod.outlook.com>
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

On Mon, 16 Nov 2026 12:18:27 +0000
"Sabau, Radu bogdan" <Radu.Sabau@analog.com> wrote:

> > -----Original Message-----
> > From: Sabau, Radu bogdan
> > Sent: Monday, November 16, 2026 10:55 AM  
> 
> ...
> 
> > > >  
> > > > > This series adds support for the Analog Devices ADIS16607, a precision
> > > > > MEMS IMU with triaxial gyroscope, triaxial accelerometer, and
> > > > > temperature sensor, communicating over a non-standard SPI Half-Duplex
> > > > > protocol.  
> > > >
> > > > Applied 1-5 to the testing branch of iio.git.
> > > >
> > > > I 'think' the proposed changes for the fifo handling shouldn't affect
> > > > those and I don't fancy reviewing a mega series with library changes
> > > > and the new device support.  So build on the base of these first 5 patches.
> > > >
> > > > You will need to provide a base commit for dependency list though
> > > > or sashiko may get confused.
> > > >  
> > > Change of plan. Dropped it over channel type issues in patch 5.  
> > 
> > Thank you guys again for the review, and sorry about patch 5. I'll move the
> > scan_index/scan_type and the timestamp channel into the FIFO patch and
> > resend.
> > 
> > On the FIFO side: adis16475's has_fifo variants register an IIO trigger
> > today and are used through trigger/current_trigger. Converting them to a
> > trigger-less kfifo buffer, as discussed for the library, would remove
> > that attribute on the six ADIS1657x variants, so it is an ABI change on
> > existing devices. Is that acceptable to you?
The ABI change is not.  That's not to say you can't bypass it under
the hood.  So have the whole current_trigger registered but ignore
whatever it is set to.  We have another driver that does that
(for same reason).  IIRC you can do it using one of the less
obvious trigger modes.

> > 
> > If not, the alternative is a smaller fix in adislib: iio_trigger_poll_nested()
> > for the has_fifo path, plus a prep patch taking the sample timestamp in
> > the handlers instead of pf->timestamp (the nested path does not run the
> > pollfunc top half). That keeps the ABI as is, and the adis16607 would
> > then use the adislib trigger path again.  
> 
> Thinking about how to split this: sync and calibration bias do not depend
> on the FIFO, so I could resend the series as the adislib patches, the
> binding, the base driver (raw reads only), external clock sync and
> calibration bias, with no FIFO. Then a follow-up series with the FIFO.
> Would that work for you?
> 
> For that follow-up I would still like to know which way you prefer to
> go for the adislib FIFO handling:
> 
>  - kfifo helper: a trigger-less kfifo buffer with its own threaded IRQ,
>    used by the adis16607 and the adis16475 FIFO variants. It removes the
>    trigger/current_trigger attribute on those variants, so it is an ABI
>    change.
This but without the visible ABI change.  We just make the ABI do
nothing. :)

>  - iio_trigger_poll_nested(): a smaller fix in adislib for the has_fifo
>    path, plus a prep patch taking the sample timestamp in the handlers.
>    It keeps the ABI, and the adis16607 would use the trigger path again.
>    It is only two or three patches, so if you think it is the better
>    alternative it could also be done in this series.
> 

