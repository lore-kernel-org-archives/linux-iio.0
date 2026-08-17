Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F2C28373;
	Mon, 17 Aug 2026 01:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786930051; cv=none; b=Bj9QRXrOvv6RYKt2DvlCbxXm/D6rtivm/ds+C7ruCtX0mIiRurWrGJirc60K+NR6WaUmiyO5S8QhnohUQ70bTqYGDMFwzhHa8HCMjNNH9IsHSLKN98as75ykDg9QnkRugT8dJHhAvVQtGcufPaiR53vKQgimaUXxuZ3FPVrU4lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786930051; c=relaxed/simple;
	bh=y1tFHSGaxwpgmBsRtZKyJs+UrADfjA1wVoBSkofuCjM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oZEg4npZ4LSXRKEAdyHN2Kw+9rUizU+eSMLt1NMowylGt5Qa629I6lOGEHAU082vUixDoMMb8eTuEQsS6vfn6JW9btvQe1krwEgbUcIX7mWZJqqIoL15i/4BMSKpWtU1ZGHnvv9OMdZfaAR/rqdsFqbF7SmJygbEC0jWnV35fFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dE1hcTED; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dE1hcTED"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 151A11F000E9;
	Mon, 17 Aug 2026 01:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786930049;
	bh=egfJKO3ILPAVOHvsdJNO0LvclCi8VHy8o2+rVferFAI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=dE1hcTEDqB6fzcSrQGBKtAinr2U2A981dz3BELTuCKguJFP6Z3keLjCxsvKvWZmJu
	 NOE0GDKb0RHi9M0uun5iz85JO0X+KrTt13LWiXnhzMLx2DKxPd2/oFCv/EBRMnlyXa
	 k+HSpb+xnULA66WZ9uOVA7rxKBXn5H6W7p7i2KjxoiHKGUuzPHpWLnKfEyhSPJODT0
	 06ZAoSWnJyEA5gGy5q1B4DVjBlRPgHR4uaCNCYPGNFkPDARRtMczEAyKXWP3K+S4VS
	 Ksqt05G3vm78Du6NNB1lH0dPXN5jMsKzpWS2NNLJ9nYIldMqgSKNLX2P9jzZbImOyP
	 A9RF1DprnCkmQ==
Date: Mon, 17 Aug 2026 02:27:25 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Matti Vaittinen <matti.vaittinen@linux.dev>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>, Matti Vaittinen
 <matti.vaittinen@fi.rohmeurope.com>, David Lechner <dlechner@baylibre.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Javier Carrasco <javier.carrasco.cruz@gmail.com>, Mehdi
 Djait <mehdi.djait.k@gmail.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Kalle Niemi <kaleposti@gmail.com>, Topi
 =?UTF-8?B?U29ua2Fqw6Rydmk=?= <sonkajarvi@hotmail.com>
Subject: Re: [PATCH 04/12] iio: adc: rohm-bd79124: Catch regmap errors at
 measurement start/stop
Message-ID: <20260817022725.18f4e36f@jic23-huawei>
In-Reply-To: <fc198eaf83319548317611ee128e78a542567156.1786347811.git.mazziesaccount@gmail.com>
References: <cover.1786347811.git.mazziesaccount@gmail.com>
	<fc198eaf83319548317611ee128e78a542567156.1786347811.git.mazziesaccount@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Aug 2026 10:51:20 +0300
Matti Vaittinen <matti.vaittinen@linux.dev> wrote:

> From: Matti Vaittinen <mazziesaccount@gmail.com>
> 
> The bd79124_start_measurement() and bd79124_stop_measurement() ignore
> errors from the regmap reads, causing potential use of uninitialized
> stack variable when deciding whether the measurement is already
> started/stopped. The bd79124_stop_measurement() may also ignore failure
> to clear the sequencer state bits, which may make the hardware to ignore
> the setting and leave hardware and driver states out of sync.
> 
> Check the return value and bail-out if error is detected.
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> Fixes: 3f57a3b9ab74 ("iio: adc: Support ROHM BD79124 ADC")
Applied and marked for stable

Thanks,

J
