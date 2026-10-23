Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792788683;
	b=jhL//GdUwDavhWrp4e2lMTqcmm3LIhLy3RWWnXFO2lFEsh/tiy28GP3J+4ssui76kM6H
	 5YwiDc9BpXBBBMFKaUPdbRknFPqPTm7oG6K87/1iXeIeFtiVnT1XRa+NYTBxq77Jmu+gY
	 bkkbXZW/5MZlzB5uUGdTaiL/trU8mVAttxhlw2S9hHhmOJWrs2+rwLoCtka0hC+9MOVUb
	 DuOeSnyhpkiW+Qg+fAh9hi53ghd5y2WbmGzW6KAcXTzAv46BYAwdHeQzY0dAhtzTaRIDp
	 BaywyzJTjTpDFSvPI7npuFFfYZmodauBe6PizEk1gkLa9XI8Z35ANXodbAc2cYqDbEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792788683;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=yOEjoMRQK6/014MnUv4vEHrQJtts2RHl1RaHTYPhBHs=;
	b=VuKLAo7bouyQ2m1ARc4wrwdRL4hnZey4JcCXpgPFMOeEumSAXFTlzhWlD3qBSLXih46J
	 NZ9JTEeWC1BLZTy/ReWvnoE7C5dIB8PMTBAz3RXKxz1j5uq8/pmFFPB2hy9B6qT9Nfn1T
	 T0CXCDjhKcsajtmrcfgd0011RJbS+X7lh481IYs5lthwI2WqhU22mS+xjfW5mDrZM4di1
	 VL77ZSJ8eCm5nc0m99gYzZCOOBAFEFOfUhzJTAQlOrBAljqvDnOwL0XTM1HlZcoPkUjUg
	 kGeyTsBwtSbrdFJUOFTl9ETkGt9B7rl28ApJvNkNSZcosHqtLGD6EG5MvZUdM8RPtOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kRINWm9E;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A54EC606A336;
	Fri, 23 Oct 2026 20:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kRINWm9E
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AFE01F01829;
	Fri, 23 Oct 2026 20:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792788683;
	bh=yOEjoMRQK6/014MnUv4vEHrQJtts2RHl1RaHTYPhBHs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=kRINWm9E+2moWQ5jgsHz4TXgmBZOfEfpODcUb/AtYvTfjGV7h4z5cz91pqLZ/6T1H
	 DvtWFy+DW+nMqIsiFblBAAV9yx8rLX0Z8UQ+iwgoC/msas4zOeH9dGP+MzXpryUjNm
	 R79X6CN3Is05nUYuCONI11Ciuwmo/zRXh2W5CIGd1BuDnVdAs2OtiTuXEMFCI2Yl3L
	 i/uEfPuHRiyOJ7ANbWdoYKROfo3BQqsstAA2vXx+O3uGWAaCk22p1L20LekQaWx4gW
	 7uIygwMaXYsC69/pBgylLRaULjOFXne1M3XlRRtJe/PMcYYZUP/On4gpc8i16Xu2WA
	 dwGqAtQGXyZTQ==
Date: Fri, 23 Oct 2026 21:51:15 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jesper X Nilsson <jesperni@axis.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, Jesper X Nilsson
 <jesper.x.nilsson@axis.com>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Stefan Windfeldt-Prytz
 <stefan.windfeldt-prytz@axis.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@axis.com
Subject: Re: [PATCH 2/3] iio: light: opt4001: refactor driver to prepare to
 support more devices
Message-ID: <20261023215115.1d3b8460@jic23-hlaptop>
In-Reply-To: <f51f9c6d-1272-46b2-a8fe-f0f100b77a9d@axis.com>
References: <20261023-opt4041-v1-0-45227f82d05c@axis.com>
	<20261023-opt4041-v1-2-45227f82d05c@axis.com>
	<atsj2tE357ZvUuCm@ashevche-desk.local>
	<f51f9c6d-1272-46b2-a8fe-f0f100b77a9d@axis.com>
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

On Fri, 23 Oct 2026 12:07:41 +0200
Jesper X Nilsson <jesperni@axis.com> wrote:

> On 10/23/26 11:07, Andy Shevchenko wrote:
> > [Some people who received this message don't often get email from andriy.shevchenko@intel.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> > 
> > On Fri, Oct 23, 2026 at 09:48:14AM +0200, Jesper X Nilsson wrote:  
> >> Prepare opt4001 driver to be able to support OPT4041. Extend struct
> >> opt4001_chip_info with fields channels and device_id because OPT4041 has
> >> two channels and another device id.  
> > 
> > ...
> >   
> >> Assisted-by: LLM  
> > 
> > Drop this tag.
> >   
> I will drop the tag in v2.> ...
Hi Jesper,

Small process thing.

If you agree with all the suggestions in a patch, don't reply as
a separate email.  The place for the info in here and the thanks
is the change log of v2.

Note I send this email at least once a week to ask people to basically
be less polite in the interests of efficiency :)

Jonathan
