Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793757860;
	b=J4PSI523p3mF3QHQitt/2+KDspC8eoIZYhzSgcATEbav/nFVjL0cIlqjKZB3sBO2qjot
	 6aRTEjqy3O1sVPsNy/aINT2KUBZqEPqIvHmGu7T0wE10FJyym43NJ9khNbSKlX9QXc6t3
	 2WH2I2rwBmwztRMEdHQCH46TvbMGrB7Wg3RFzX9FByjAkVOOQ+YF5eBBIydtx+t+5Fa8S
	 gIbNjCCsabyZ0rNKX4NgRFAK0INppDCBDrsnfu0UIxALok9TGVwJMagGBQnf+VQedN8Iq
	 vaEjCMhnirxkJ2QB+Fian+C2zDwnCyeI7K3x98FQSFqXaLhKlNpKbPRWHCOJyPd/9vw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793757860;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=E3dxUxhVcbrBYug1uib0e6cBnVXo5pgOi0YOtDVoFUo=;
	b=ydaM+nYHVEKKKhQmlOaP4nlF/YZmUwXEuWFrOgcTe3MJj4t6H5Dqe8UjJ7Yh0Yihywcl
	 2hNwYv14k9pdo21f2XNGp3y/bjFQQijXwio4vRR+nQPj+dgYfDNzwieA5XBeIYsThTkXK
	 PbUXJ9IUyd9mPE21K/CpgND301NNVX4BYCEkvkMw7CvisttmCkv4luJvhaSbBArVpsb/2
	 jUwBmzx+tYC70uog7gLzNyc7QbusGNjexOgaAAGD9gYRNTdXufqlYNCQ075XzzGvisu25
	 0cqT/fNS5McRFf1BHHTkZjjK2zAjS7bnhQk19TQvuONPdheyTR2Fr4Z40JSyhrNEhBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iktoxgKP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0555C606A31B;
	Wed,  4 Nov 2026 02:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iktoxgKP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E2711F000C1;
	Wed,  4 Nov 2026 02:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793757859;
	bh=E3dxUxhVcbrBYug1uib0e6cBnVXo5pgOi0YOtDVoFUo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=iktoxgKPUoPoBIf9gyHxjSub5uOdQ2apo7LTavHKPjZH23wVnL3IMKpkGCdN1VzZ3
	 jXTOkp1CvOvY+3Chi5uzl4zjqEZ5ylzI4WZLXFnmytWNNtXHV17zousGCezrdSYh3w
	 AucSlQoqjISkX9x22qiotc5WfYbKAO0tTb1Lhu8c37FhF0xKqdIm5pyKymMf/hGWnl
	 1IA5x4IBCdajb+rzQvh7QRKMwo+2bd3UjjaJYLua+bLokKbz+/b1fv26lulSKgSzF9
	 fSdhM1BGWN6/gYRWKiPg0OGXjVxOFnhAjnFrtZPJGJxTiXFYpvWTZzavqxr0d22ird
	 mCEyfPedc+TcQ==
Date: Wed, 4 Nov 2026 02:04:11 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Olivier Louvignes <olivier@mgcrea.io>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Paul
 Cercueil <paul@crapouillou.net>, "H . Nikolaus Schaller"
 <hns@goldelico.com>, Joshua Crofts <joshua.crofts1@gmail.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] iio: adc: Add a driver for the Ingenic X1600 ADC
Message-ID: <20261104020411.5adb2e2f@jic23-hlaptop>
In-Reply-To: <aum7smuAHnSSb69e@ashevche-desk.local>
References: <20261102201155.10948-1-olivier@mgcrea.io>
	<20261102201155.10948-3-olivier@mgcrea.io>
	<aum7smuAHnSSb69e@ashevche-desk.local>
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

On Tue, 3 Nov 2026 12:47:14 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Mon, Nov 02, 2026 at 09:11:55PM +0100, Olivier Louvignes wrote:
> > The X1600's SAR ADC has four auxiliary channels, each with its own start
> > bit, interrupt flag and 12-bit result, and none of the touchscreen or
> > battery engines of the JZ47xx ADCs that ingenic-adc drives. Add a small
> > driver that exposes the four channels as voltages against the 3.3 V
> > reference.
> > 
> > The registers are in chapter 19 of the X1600 programming manual. The
> > ADC clock divider is even, as the manual has it (an odd value divides
> > by one less); the vendor kernel writes the divider minus one, which
> > gives a slightly faster clock than it asks for.
> > 
> > Tested on a HiBy R1, whose play/pause and volume keys sit on channel 0
> > behind adc-keys: all three read and report correctly.  
> 
> A few nit-picks below, otherwise feel free to add
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

FWIW I took another quick look and don't have anything to add.
So given this is clearly approaching being applied, feel free
to send a new version once you've addresses the questions from
Conor.  No need to wait the normal period under these circumstances.

Jonathan
