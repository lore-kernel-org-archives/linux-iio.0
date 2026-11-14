Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794681686;
	b=rcImd7cB6YBlklE/9Tr4CxZ2jFSa89ABxfZK6NLfHgAYoHgO0TbUFNGVNtiIWZWO7q4U
	 nyDX86Fnb1BOK43qAcwwAKTNRfcxasBqryhIDPmiC6Pt4mPeKGCmFx6lcaxR4Ejgu9Lhe
	 +P3EXYm5uSnj7TccC/BF6lboCpXN3mnrXOnKQrTKdrKt9DgFWJLtHW4umMVI7y3rpVzja
	 j+WfDf0UKzOBzAoNpowNxm4othWOIYDehfUexZ0q1ouJlPOCZlJi/m2ApF/LbMy46d+DG
	 OFHV28+VPZciPxyFIcAU8ROrXY4ucoOjtWrN+KXeVXNYoCVLPlg1aTt00jkV8Xd8qjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794681686;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=hbmmDlDuo/Aafn1uwFBtlXGmOEUSg36qvHcz00UKSls=;
	b=QZZ50/NyxcL9OeNUfXFiWsIaBlum2lPDK+K3mbHSlU4N2uyac09gxs5AVDkK/lNh7q4E
	 a1y2TtrlzBhVTdFdS8yn+J6n7UPRI0+8mjB2oRnBfJ3hQFRSxIcaykUdRPIFVQHhpmBKq
	 URGgSjQObJKi9Ul9a00Yu7gd2sOPcuOiYqL2E0W/UQIpVHSFGU0G4rNXKxfH4woMJwEc4
	 kvh0G07Y7eP6xMues7xih9+Ry6z9D7hirmCPrx0KL3Ex+nPn3TCkiBFgm10Ry1l8f7NOe
	 FO5yKl105CVvDBmKVoZGFAKx/fUYAVR0o5CMB4Nn8TkYpogqGBaWrWRsKxs+bsXlZMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Yp4LV16z;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F477606A323;
	Sat, 14 Nov 2026 18:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Yp4LV16z
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2E651F000C4;
	Sat, 14 Nov 2026 18:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794681685;
	bh=hbmmDlDuo/Aafn1uwFBtlXGmOEUSg36qvHcz00UKSls=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Yp4LV16zuDcpZ3+Y/qLVygQckl2pM5SMQe/KLSlyF5e/QS8BXQvbS3cu/RBNl+TkX
	 SCgfa1fj1U+D99vVto6E4de9vK8/tAxEblZGb4RbFH8WE4EJ4dd2D7TdQP3OotV14/
	 CLeqDPBCzCbWXc9t9+bD9QiK98zHjhExPWGSmwwZKNjrKgp0pj5obm2DNwRbk9tCqe
	 Eo8IEeCv46Og75PXtmxFGtsIy38fXY2n08lz91pZEq9z44B3x8iYiq54V2tUocyM/7
	 /c6iAZ1hIo2bgggcM+WpSR2wy94N6zQSuVpKjFKeisk3GsyMys9ZnKxnqb02/Ik3pz
	 Vt70aZ1irNAOQ==
Date: Sat, 14 Nov 2026 18:41:18 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jesper X Nilsson <jesperni@axis.com>
Cc: Jesper X Nilsson <jesper.x.nilsson@axis.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Stefan
 Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel@axis.com, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 0/4] This series adds support for Texas Instruments
 OPT4041 Ambient light sensor
Message-ID: <20261114184118.6b558a20@jic23-hlaptop>
In-Reply-To: <389d5226-b147-4b8f-b3c3-b6bffc5ca78e@axis.com>
References: <20261023-opt4041-v2-0-ee320812804c@axis.com>
	<20261023215858.623ef46b@jic23-hlaptop>
	<389d5226-b147-4b8f-b3c3-b6bffc5ca78e@axis.com>
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

On Tue, 10 Nov 2026 17:08:38 +0100
Jesper X Nilsson <jesperni@axis.com> wrote:

> On 10/23/26 22:58, Jonathan Cameron wrote:
> > On Fri, 23 Oct 2026 14:30:27 +0200
> > Jesper X Nilsson <jesper.x.nilsson@axis.com> wrote:
> >   
> >> Extend the opt4001 driver to support OPT4041, since it is so similar to
> >> OPT4001. The OPT4041 adds a second channel, a wide band channel ranging
> >> from 380nm to 1000nm. The register map is almost the same for both
> >> devices. OPT4001 has an internal fifo of size four, OPT4041 has two
> >> fifos of size two, one for each channel.
> >>
> >> Since OPT4041 has two channels it has one bit in register 0Bh to select
> >> which channel is compared to the threshold register. The driver does not
> >> support setting the threshold registers, so no new support has been
> >> added for this.
> >>
> >> The OPT4041 is pin compatible and has the same package as
> >> opt4001-sot-5x3. Although the device id is different, I added a new
> >> compatible string since the driver already had different compatible
> >> strings to differentiate between the two OPT4001.
> >>
> >> Datasheet: https://www.ti.com/lit/gpn/opt4041
> >> Signed-off-by: Jesper X Nilsson <jesper.x.nilsson@axis.com>  
> > 
> > 
> > Normally I'd say slow down to give more time for review, but seems
> > you got good reviews anyway and the code looks clean to me.
> > 
> > Ah well, sometimes you win - but generally wait a few days at lesat
> > between versions.
> >   
> I will keep that in mind. Since I got good comments so fast, I was eager 
> to fix them.
> 
> > Applied to the testing branch of iio.git. I'll be rebasing that
> > on rc1 once available.
> >   
> Have the changes been applied? I can not see them on the testing branch 
> of iio.git
> 
I clearly messed something up because indeed they aren't there.

Sorry about that.   Now actually applied and pushed out on the testing branch.


> Best regards,
> Jesper
> 
> > thanks,
> > 
> > Jonathan  
> 

