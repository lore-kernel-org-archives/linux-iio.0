Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CBC02BE048;
	Sat, 14 Feb 2026 19:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771095777; cv=none; b=icwNReCFqx93u8jyyeNExaQVeObzHBTL5VlkEtc3iVLDV1OwGXYapx5dZ31a3ycDsUqT4Znml2E+MhOhKe8KY4wH0j2m0sbn19gznuEcjrhX+vc1yqKpmtKi3yKcjXWI8pRWAgYqH4ZN6MThdGNxFeJ9vy46hh8KZLvksEOG4gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771095777; c=relaxed/simple;
	bh=TR0kk19nnoF9r65yFryXUINaqHmHctTxQ9YbpT7jsY0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aztv8NHFUWJBSoNHZyon4m3j1tL1XRthYxx25KMaaUUdw63atO2Uzq5UTiM+I1YxYVRRCDoVjFfqD9aiMiSgrjide/6Y8y3zKoiI6b1pBT3hNIT1ExRkPFS6lPPDwNzLRdC/91Wvdmjaa+NyP4Mt4If2qXRNHVQ8q6Klo/hMnbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UgTmHKPn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UgTmHKPn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCED0C16AAE;
	Sat, 14 Feb 2026 19:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771095777;
	bh=TR0kk19nnoF9r65yFryXUINaqHmHctTxQ9YbpT7jsY0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UgTmHKPnNaOdVQh+5K/HjQ+JRVd7lWMTBURaD2+2GLZJnkyJDzwiyYqZ1thHhRdZM
	 AIfjCaZ8rP+vwIA+DyhErMO6fyKmdx9t58jvHk7uSSmCdDW4gAVX+EV+a4su6KbwpT
	 vGI02nAkP3eG6+KsZp/Pdt0QwMjb7HvyVlN2Nr6ZMKsuhotKSv+yaT1mIf+Tmdie/U
	 iFcDB/KU1/YP3xM6W1TMdkhnoTj70Nb12i1xGY5hXfQfNTdxxOACvUu0QLTIDC0qv0
	 StqRNWxfr7DPWnV2J5VZreVmr5Ym934jQEqB4Z+HpC6ujgMl+0mRxAh8Nskq8/LOF1
	 1B59lCMJdNhOw==
Date: Sat, 14 Feb 2026 19:02:46 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Alencar via B4 Relay
 <devnull+rodrigo.alencar.analog.com@kernel.org>
Cc: rodrigo.alencar@analog.com, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, Michael Hennerich
 <Michael.Hennerich@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, David
 Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Alexandru Ardelean
 <alexandru.ardelean@analog.com>, Andy Shevchenko
 <andriy.shevchenko@intel.com>
Subject: Re: [PATCH v4 11/11] iio: amplifiers: ad8366: update device support
Message-ID: <20260214190246.228c148a@jic23-huawei>
In-Reply-To: <20260210-iio-ad8366-update-v4-11-15505f7b15b4@analog.com>
References: <20260210-iio-ad8366-update-v4-0-15505f7b15b4@analog.com>
	<20260210-iio-ad8366-update-v4-11-15505f7b15b4@analog.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Feb 2026 19:42:11 +0000
Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:

> From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> 
> Add support for the following digital step attenuators:
> - HMC271A: 1dB LSB 5-Bit Digital Attenuator SMT, 0.7 - 3.7 GHz
> - ADRF5720: 0.5 dB LSB, 6-Bit, Digital Attenuator, 9 kHz to 40 GHz
> - ADRF5730: 0.5 dB LSB, 6-Bit, Digital Attenuator, 100 MHz to 40 GHz
> - ADRF5731: 2 dB LSB, 4-Bit, Digital Attenuator, 100 MHz to 40 GHz
> - HMC1018A: 1.0 dB LSB GaAs MMIC 5-BIT DIGITAL ATTENUATOR, 0.1 - 30 GHz
> - HMC1019A: 0.5 dB LSB GaAs MMIC 5-BIT DIGITAL ATTENUATOR, 0.1 - 30 GHz
> 
> Additionally, copyright notice was updated with current year.
> 
> Co-developed-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> Co-developed-by: Michael Hennerich <michael.hennerich@analog.com>
> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
Hi Rodrigo.

A few early comments propagate to here but nothing else to add to this
or previous patch.

Thanks,

Jonathan


