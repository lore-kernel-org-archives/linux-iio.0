Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794018809;
	b=Hc340yla3nLk6M0dU1epbyCW2UJLBEmuiH0MXlTzZifjFt0eeArWkaA4PrwNxSyZKnX/
	 wUI6eJse0uIemEbcI8MdD+JM6e+VCW245OlNoE4fGVyMBTXT6wYekSlBkTcIIUgfKkZ/X
	 x+nzhVgjrIL8v6ttv92jinaVtZOpqPfrZbUOSwLMvoTR0V5kvQuUvTDzo3CQZtEx9b4XE
	 qoixLF2MJUkzJ33aM7JMG6fEAgZWd7AtdGmiZxSUlZwKiBJajHeTEgx8jmJaiBwd0aIP3
	 BRHIsgF/PAKPi2VsEag/9UKiRzqrx6uSGHTcsVm0hN4/CxiwfLUWbcr8ZnearWzoxDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794018809;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=91V3omyskj++g5IXfnumXhkuwJ7mLrazZpEc4xXbXMs=;
	b=btq8T81CtVa/63amuDJIWJpyDsvUBDqLFziEy0Wyacs6vupApGBBOB7Un/TjHjq0KqsU
	 nAbT6pucSIXbosW9/a/ngek4DdbX70AqY4TnQN/xg5cucHQ+aqEpj/VlXcaC+Jno5I1p3
	 Z5QWoJ1Vq7UotmqhjLeCYj9YvZlkfIUrac0XwEmm12I1u0366i6jTFamChrzTcTGOARGh
	 7F92GnzyKTsNdPxeohKE7ibNIIw86AcvheTcoRMF/umxWnlh7Ga8CHxfL1Yx4uJT3T2nq
	 d+ekt+zss4eUPa+1kAbV+0RFiKYhyDGUmvT9GXowTwT1JQv7UKBsuv5GEzYK7D41YVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FWqVaU00;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AAA7606A32C;
	Sat,  7 Nov 2026 02:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FWqVaU00
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A85F91F0089F;
	Sat,  7 Nov 2026 02:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794018809;
	bh=91V3omyskj++g5IXfnumXhkuwJ7mLrazZpEc4xXbXMs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=FWqVaU002fBM9v5T5v6Bz8JR/KADIY6Cp3i0UQRtJ7SlXpidZMMpLSJ04BJ/ROX1Q
	 8HpI3u68Y4sbz+tsgS7HRrqTazNfAfCIfB+6EpmvJ0/okgHfpWHROP3qn6NOII6Dgk
	 DLmCKUrglC8jRwqtLKiHzfw/NJ0bQxel7oKYnEK53DIDpyyVUIPqZJKrwFtA7tPHl7
	 g7emlSWFcusCHKkQPeoiFZVhryQN1NFaXUFB/G7/r5rsZvHA+hdDKmuvA07XbSvPgH
	 BM1haezIVW0xUn/QatJKydcjR17ejZ5nlE1G5WuG7Z3x+49e6TiaAUfj52QpKljQqU
	 QIlVMMQ2X4uIw==
Date: Sat, 7 Nov 2026 02:33:23 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Olivier Louvignes <olivier@mgcrea.io>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Paul Cercueil <paul@crapouillou.net>, "H . Nikolaus
 Schaller" <hns@goldelico.com>, Joshua Crofts <crofts@kernel.org>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/2] iio: adc: Add the Ingenic X1600 ADC
Message-ID: <20261107023323.574fd918@jic23-hlaptop>
In-Reply-To: <20261106105358.59616-1-olivier@mgcrea.io>
References: <20261106105358.59616-1-olivier@mgcrea.io>
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

On Fri,  6 Nov 2026 11:53:56 +0100
Olivier Louvignes <olivier@mgcrea.io> wrote:

> A driver for the SAR ADC of the Ingenic X1600: four auxiliary channels,
> 12 bits, one interrupt per channel. Tested on a HiBy R1, whose keys are on
> channel 0 behind adc-keys.

Applied to the testing branch of iio.git. I'll push that out as togreg
for linux-next to pick up after 0-day has had a chance to give it a first
poke.

Thanks

Jonathan
