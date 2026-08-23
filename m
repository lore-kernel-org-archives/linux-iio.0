Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB80493633;
	Sun, 23 Aug 2026 01:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787449527; cv=none; b=Yt/TsGDXLHg9GZuDCx7uXa3HIlh4AbEr8RTA8n9jreYqFlgxbLCPxJqKG4T6cChQIRwjdaXqKtVbhsoA7HmHDpWXl9leVCN3s9uk6EyRyGwlztTNUnjz65yoEbSGyalwq1nKWgOga8gs64boECp/3d0tx39v/xmffHwyJoH/Vl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787449527; c=relaxed/simple;
	bh=zYZGc1vkqbwQkIWt+/eSDfR1QodCXeEx48GIk2cQ3OI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xo8xUonRjm7EntpEpNBVg3VtQq9t3aLXzgzCTK7mpH5C9mKM2qLK530R7fhCTtTR9qSjV2AhPnDKGKTzBW7kXETN8k1umpVkAxVRcECydVbuckk3gDLIAoMCvc2lJ+OVQ75niviezcKbyJ1jVsaLQUvKV9doIggc7PhC7LrbNRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dxkAbQlo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dxkAbQlo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D26C31F000E9;
	Sun, 23 Aug 2026 01:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787449525;
	bh=TXMCHlIVfpqQkSeP/b3tc25WGhv/E3FlDQil0NC/ZnY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=dxkAbQlou+MMIDmO2dDrV0XLBr1j/S3mDEh9R5VXoUw9ACRs4dvBZ5fH9+ii7Odzj
	 Jvg0gRjBGWAn70h6mmPQ5OBQllDWtN+fR6BPu+sezOM3S2xM1Aje7kCun8sJZGAwcg
	 SWNYJDhTUxomPl6VBe83FtLRB+E/N6KYX7Z0VMjIwZ+uVe/KTddZ8bwpnqfHkj7VpK
	 Qlx3YkhgiYX4O4mR401XJBHplxtWWvLADYiEDKl6+NqciTuF5HcGbvTk1lQLn80hXM
	 M5zdsnIeNj+eAZmbLzzq5Opam4AZ22IEGYN/wIveZ97eN9CWquik0oypCH+hHxF3j7
	 1rZ5kj+DMUPxg==
Date: Sun, 23 Aug 2026 02:45:18 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Janani Sunil <janani.sunil@analog.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Michael Hennerich <Michael.Hennerich@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Olivier
 Moysan <olivier.moysan@foss.st.com>, Philipp Zabel
 <p.zabel@pengutronix.de>, Linus Walleij <linusw@kernel.org>, Bartosz
 Golaszewski <brgl@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, Michael Walle <mwalle@kernel.org>,
 linux@analog.com, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-doc@vger.kernel.org, jananisunil.dev@gmail.com, Uwe =?UTF-8?B?S2xl?=
 =?UTF-8?B?aW5lLUvDtm5pZw==?= <u.kleine-koenig@baylibre.com>
Subject: Re: [PATCH v4 02/14] dt-bindings: iio: adc: Add AD7768
Message-ID: <20260823024518.2c75733c@jic23-huawei>
In-Reply-To: <718f6ead-d1c0-4dc6-82e4-cac49cc73bd6@baylibre.com>
References: <20260821-ad7768-driver-v4-0-bb8fbd06d4eb@analog.com>
	<20260821-ad7768-driver-v4-2-bb8fbd06d4eb@analog.com>
	<718f6ead-d1c0-4dc6-82e4-cac49cc73bd6@baylibre.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


> > +  ref2p-supply:
> > +    description:
> > +      Positive reference input supply for REF2+. The voltage range is from
> > +      (AVSS + 1 V) to AVDD1. Together, REF2+ and REF2- must provide a
> > +      differential reference voltage from 1 V to |AVDD1 - AVSS|. This
> > +      reference is used by channels 4 to 7 on the AD7768 and channels 2 and 3
> > +      on the AD7768-4.
> > +
> > +  ref2n-supply:
> > +    description:
> > +      Negative reference input supply for REF2-. The voltage range is from
> > +      AVSS to (AVDD1 - 1 V).  
> 
> For all of the supplies, I don't think we need to repeat so much of what the
> datasheet says. It is getting quite noisy and makes it hard to see the parts
> of the description that are actually relevant to how the devicetree is to be
> interpreted. (includes VCM as well)

Agreed.  Keep anything about how being present / not present may matter.
Pretty much anything else isn't really that interesting.
Sometimes
	xxx-supply: true

is enough.

> 
> > +
> > +  reset-gpios:
> > +    maxItems: 1
> > +    description: GPIO connected to the active-low RESET pin
> > +
> > +  start-gpios:
> > +    maxItems: 1
> > +    description:
> > +      GPIO connected to the START pin. An active-low pulse on this pin
> > +      synchronizes the device to other AD7768 devices. When not used, this
> > +      pin must be tied to a logic high level through a pull-up resistor.
> > +      When used, SYNC_OUT must be wired back to SYNC_IN on all devices in
> > +      the synchronization chain.
> > +
> > +  sync-in-gpios:
> > +    maxItems: 1
> > +    description:
> > +      GPIO connected to the SYNC_IN pin. Receives the synchronization pulse
> > +      generated on SYNC_OUT in response to a START pulse. Must be synchronous
> > +      to the MCLK clock domain. In multi-device or daisy-chained systems,
> > +      two successive synchronization pulses must be applied to guarantee all
> > +      ADCs are synchronized.
> > +
> > +  sync-out-gpios:  
> 
> Unusual to have an output pin connected to a GPIO. Usually this would be an
> interrupt or trigger-sources.
> 
> > +    maxItems: 1
> > +    description:
> > +      GPIO connected to the SYNC_OUT pin. Outputs a synchronization pulse
> > +      synchronous to MCLK in response to a START pulse or SPI_SYNC command.
> > +      In single-device configurations this pin must be wired back to SYNC_IN.
> > +      In multi-device configurations it can be routed to the SYNC_IN pins of
> > +      all devices in the chain.  
> 
> Although this description makes it sounds like the SYNC_OUT pin is only ever
> wired to SYNC_IN. So wouldn't be described here at all.

We don't have a particularly good way to say "this hardware controlled pin
is wired from this ADC to this second ADC"  As you note though GPIO doesn't
work for that.

