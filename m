Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B142C11E4;
	Wed,  1 Jul 2026 21:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782939738; cv=none; b=azS3BPb9TUND3oOqOWC4idl9QRetCmgqgo+y3naTZtXskwCQdoQpZNDh3J1ToR1CPzHTrsk4f/nOkpDmCCpJzMAfJZqsgLOxD10PT+Ig2RSYITQexVUB1JT3ULfOvZwmmBq7zX/OqMKSBfFPWHYgJMpsZ2hPRU4Rly/NwFIdnHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782939738; c=relaxed/simple;
	bh=bBxKTCuVG/kqzi9PHZORxAaQ6e5TWwycVpaSLpxaraA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F9EQLd9/bqOv9KwsKlpCvNEDdjz3EuKw/d+ZaPGWqavYLwf5SFNzMmgS05wCUkaSmlnQ88rsqok55Y3HQlt2WFndubOUFVuQq8Xj4PdCu1+bVUuYfy2cQwFEHXRRRs9woh6jDZeUQB99S/oesz+ufUPIEsK7Ri3TR3Z+iZIYxYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VofUYjdW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VofUYjdW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48C011F000E9;
	Wed,  1 Jul 2026 21:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782939737;
	bh=fDYzkfD03QCemnZAongM476f9RM73y8sVoEYcrmB+04=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=VofUYjdWJWrF+6tGCKvfwHMXju9c+U2sGOf5WjZk4Y1Ff8an6PDSNiEOdr4pYJZEq
	 eV6gIfhT25BWm5G8icoxXZR4tFt/Ub7nfZIUJD//tEm265KGI4a/9bu1DsOAqDw6GA
	 zhhmnUjl4Wx9gKs0nXuSo4+MK8cRkAat3rfTS84wVXLsBKa+zp8a08CIt/4JXFp0Hw
	 SAxEVNYiuxJAzk5ZGfbK55kzN0e7PZpFOtvWvMacYCXXONvEeA+SiB2/YsheCFDZF9
	 EajUUmNHO8b1FCMr2lWFeocN2hNHvHrUS/aE0Gm+15upioDbcK9AXXRzs1AYMGxeI9
	 YZDK4yFXdxhiw==
Date: Wed, 1 Jul 2026 22:02:13 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Chi-Wen Weng <cwweng.linux@gmail.com>, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, nuno.sa@analog.com,
 andy@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, cwweng@nuvoton.com
Subject: Re: [PATCH 2/2] iio: adc: Add Nuvoton MA35D1 EADC driver
Message-ID: <20260701220213.499ed6da@jic23-huawei>
In-Reply-To: <66ad5723-6589-473a-91da-b13e2ba90aeb@baylibre.com>
References: <20260625110638.38438-1-cwweng.linux@gmail.com>
	<20260625110638.38438-3-cwweng.linux@gmail.com>
	<66ad5723-6589-473a-91da-b13e2ba90aeb@baylibre.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit




> This field has a new name:
> 
> 	chan->scan_type.format = IIO_SCAN_FORMAT_UNSIGNED_INT;
> 
> > +	chan->scan_type.realbits = 12;
> > +	chan->scan_type.storagebits = 16;
> > +	chan->scan_type.endianness = IIO_CPU;
> > +
> > +	if (differential) {
> > +		chan->differential = 1;
> > +		chan->channel2 = vinn;
> > +		snprintf(name, MA35D1_EADC_CHAN_NAME_LEN, "in%d-in%d", vinp,
> > +			 vinn);
> > +	} else {
> > +		snprintf(name, MA35D1_EADC_CHAN_NAME_LEN, "in%d", vinp);
> > +	}
> > +
> > +	chan->datasheet_name = name;  
> 
> We usually don't use datasheet_name. It would make more sense to implement
> labels and get the label from devicetree.

It is used by the consumer interface to find the right channel if we
are using hardcoded iio_map rather than dt based association.

Given this is a SoC ADC it is possible this will be needed. All depends
on how tightly coupled other components are.

It can come in as part of a later series adding such a consumer rather
than now. 

Thanks,

Jonathan
