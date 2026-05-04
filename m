Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A411F03D9;
	Mon,  4 May 2026 16:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777913958; cv=none; b=Miww/BPXWNxX+JRk2o2W3tPk/txQPet/uUcAASs/0rrYx+RKUVwlnLOiqn2nsE/8tsbvKkNRkf+gufI6Jmvsyx3BRCiy4j+X8PfV3WYjHVddahLBWfR7tnkseyTo3kKoke5+u7c/enQd4lwBS2PctbhNj8vEt2bAPa7KkDnTMaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777913958; c=relaxed/simple;
	bh=8r2yruNyWUT+EVOGdJcG9cKN6tevG8t5RAtDjFfeMnM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XK0CSc5NTlGSgAvyR7yiw7CZ1utLLej0HzRM4dYBcR7EF8ODhJxsXH0AiW1Pm0Zvm7x6iKrqvkqzXdfrvc2zuaFRlZGxEK7FSQv11X9hAiXOWSMTr8dqTxaHNgI45x/K3ix3m6mHQaKfddoMhoHBD9pSn2N8P3utdgBu8RCUINE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WdiOH91v; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WdiOH91v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 486A6C2BCB8;
	Mon,  4 May 2026 16:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777913958;
	bh=8r2yruNyWUT+EVOGdJcG9cKN6tevG8t5RAtDjFfeMnM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WdiOH91vOB+1Wmm0xWMvvXcVzVZPViIkBUrrkKQwTf/ns9SZloLj7kwGSMtZRZYtH
	 5CDIW+cuv2L/GzDhvrlejh0nimFk9w/HUUR8iQYtd1UGBmSDH05T+mpT01EeZVdgaC
	 n1oToLHvYya0+6Cm2DJULU6PAAklAPzGz/cPSNjx5R2YdoQbRnD6MqEl8pjgSnXkdC
	 TPI2bJXDXsvo7aAXm4R4xwzCKh5NpOqGWTNBboSMSVenOuLDEvNGoNC074uBanyr9g
	 DcWhB2rq29ucfhbJ4vqlxAr5etl1YiWxpQt4PtzuOc7fIh1dEuUbJKsFRcnbPQ32OI
	 zzhYO1Jnf/U/A==
Date: Mon, 4 May 2026 17:59:07 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Piyush Patle <piyushpatle228@gmail.com>, Andreas Klinger
 <ak@it-klinger.de>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 11/11] iio: adc: hx711: add support for HX710B
Message-ID: <20260504175907.1c70dd9f@jic23-huawei>
In-Reply-To: <afjA2EItdQIWfY9u@ashevche-desk.local>
References: <20260503120949.80292-1-piyushpatle228@gmail.com>
	<20260503120949.80292-12-piyushpatle228@gmail.com>
	<afjA2EItdQIWfY9u@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 4 May 2026 18:52:56 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Sun, May 03, 2026 at 05:39:40PM +0530, Piyush Patle wrote:
> > Add support for the AVIA HX710B ADC, which shares the HX711 GPIO
> > interface but uses trailing PD_SCK pulses to select the active mode.
> > 
> > Model the HX710B with variant-specific channel tables and IIO info,
> > track the active channel across conversions, and use the fixed gain
> > value when computing scale.
> > 
> > Also update the adjacent Kconfig text, file header, and module
> > description so the driver text matches the newly supported variant.  
> 
> ...
> 
> >  	/*
> >  	 * triggered buffer
> > -	 * 2x32-bit channel + 64-bit naturally aligned timestamp
> > +	 * up to 3x32-bit channels + pad + 64-bit naturally aligned timestamp
> >  	 */
> >  	struct {
> > -		u32 channel[2];
> > +		u32 channel[3];
> > +		u32 pad;
> >  		aligned_s64 timestamp;
> >  	} buffer;  
> 
> Maybe it's obvious to everybody, but me, however I find it difficult to see if
> there is no ABI breakage. Can you add a comment explaining why this is not a
> problem?
> 
I replied in v5 (after this was out :)

It's not actually an ABI breakage, but only because the timestamp doesn't
land where this would make you think it does.  If there are less than 3 channels
enabled it lands 8 bytes in, so on top of channel[2] and the pad.

It is misleading which is why we don't use structures when it is possible to enable
a smaller set of channels and have the ones after them move up in the structure.
David add the stuff to declare buffers for this form - so we should use that.
See v5 reply as I've forgotten what the macro is called again ;)

Jonathan

