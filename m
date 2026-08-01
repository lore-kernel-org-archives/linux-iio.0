Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A236272E53;
	Sat,  1 Aug 2026 23:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785626041; cv=none; b=vC0US/MY+f2C9ABuIeb+zEgG1OKYSbvDBnXZBGekGnpxX7zzqh1Vj+0Dldx8/MuffqynoqLOjjMjtKq4agCFAy+Z6qZGmG7yztHUbE2gzApQTjqEMwtCdAMjR7GbdnzyzX4xgvb8eCNfcst0NqE9d6TXoBbe7NqoI7vXYxVq8tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785626041; c=relaxed/simple;
	bh=9WyUCPBKQ0TEPsDZ7NPjlZ/tU02qqyNh3hr3Ljmxe2A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=trWis7M/l786sSbWGHF5gOxtybMOSPgjn4eFDpq0AwtYR7t9NBB/VQ6eRWLeHfzBvyERhk7AS9W/kfkP8D5+DKsoEemcUC1gCqrbzs/DvhjM29vahmYlmyCEItmPljN31IKf7qVGeN2Hi68Yh9s6U8SbmyLF9k0OeI6yF0Mp6a4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j56WV+vJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j56WV+vJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 692DC1F00AC4;
	Sat,  1 Aug 2026 23:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785626039;
	bh=vvxUb/7jYQXdoFiaSvOQOYKS2Oel/6PitxAZHc1hgcU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=j56WV+vJkp/zjTjUOy5RpIUmAscMrZb0WPDpeI8H/IT9GIzndRqjkW2OVpeWsf8mb
	 8GeeFvh/agMYtDFXK0Lz/kNd4SC+9ALttkB2xWoPX5Wskx6Dm1w4+3OJEfHHgELCJi
	 a2SqaSJZW9FXBb5oWGqGanLYKekGaO2b+5PW71h1nk4ymmj5sBHgu7gfDZKUlRT5gv
	 RnzFsLca434elCl/4/nP/bZf4IzBoiwGuKtxSrO+84zE+SyD69yOYhV2VWJRTd8lIe
	 magc4NIsShV4/sIjPZJXvMZFPEGSx8UDP+LOXz2EkJZpgg0hrcffp2F14wAlOEYGrJ
	 SLqBsDzGqb7Uw==
Date: Sun, 2 Aug 2026 00:13:54 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Ariana Lazar <ariana.lazar@microchip.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: adc: add support for PAC1711
Message-ID: <20260802001354.6aab1136@jic23-huawei>
In-Reply-To: <a869acd6-9c77-4495-a581-232ca88ac9e2@baylibre.com>
References: <20260728-pac1711-v2-0-609bc026093c@microchip.com>
	<20260728-pac1711-v2-1-609bc026093c@microchip.com>
	<a869acd6-9c77-4495-a581-232ca88ac9e2@baylibre.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit




> > +  microchip,gpio1-mode:
> > +    $ref: /schemas/types.yaml#/definitions/string
> > +    description:
> > +      Defines the function of the pin. This is a multifunction gpio digital I/O
> > +      pin which can be configured as alert1 interrupt, GPIO digital input, GPIO
> > +      digital output or slow. When functioning as SLOW pin pulling the pin high
> > +      overrides the programmed sample rate and results in a sample rate of 8 sps
> > +      (Slow mode).
> > +    enum: [alert1, gpio1_input, gpio1_output, slow]
> > +    default: gpio1_input  
> 
> Maybe I missed something in the previous discussions, but this
> seems a bit too restrictive and also a bit redundant.
> 
> interrupt-names already tells us if A0 or A1 is used for /ALERT.

Agreed - so for that make the properties mutually exclusive.

> 
> And why should we restrict GPIO usage to only input or output?
> (Binding should have gpio-controller and #gpio-cells properties
> for that too.)

Yeah. Seems that would just be gpio or allow the presence of a gpio
consumer indicate that.

> 
> It also isn't clear to me how the slow pin would be useful when
> we can also program the sample mode to the same rate over I2C.
> So maybe we should defer adding a binding for that until we have
> an application that actually requires it.
> 
> And this is missing the possibility that the pins can be used
> as a conversion trigger as well. Likely that would use a
> trigger-sources binding, but as that isn't common, I would defer
> adding that until we have a use case.
> 
> So I would just leave these properties out.

Makes sense to me. This definitely falls into the corner case
for bindings where we don't yet know what the right thing to do 
is so we don't provide full bindings from the start.

Mention this is intentionally not here as part of the patch description.
