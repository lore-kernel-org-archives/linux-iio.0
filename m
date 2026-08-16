Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B9552AF00;
	Sun, 16 Aug 2026 19:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786909573; cv=none; b=o3vSt04Ii+1+DTEzKR0UllXzZIH1E9fIhpO7jwExERhCxhxOCqqy8R4+TNi/cpuSvYDvz4gFVGsufDmDwxz/Ji2/j6fWCZaXlYItymEDq8Xzs6rVsJ6zywcfks1jYUAOuzHmJxqPH10yYGTS6DNoCheLk4ISRSDzDf9OLS4zHOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786909573; c=relaxed/simple;
	bh=ydTeLTMSrDd3wLWRAr4wXA7xV96UBCvUG47ynPScBEs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jM9XkaykZrJ4y58+jZNdYxxhsMGseNAc2YOwGOukwOmpmmI/dZ7VSKmiVMMoS3xJ+HceAnk/LVeO020p22eIk/ldQjNvk8LLKggsT+ORSofHWTaPGM34nMobr7C0uLQpauGDQScnGsyUDLldpiDkcSY8+4HTdzx0lAxvIIXB0CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TOs8h5Za; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TOs8h5Za"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE3AE1F000E9;
	Sun, 16 Aug 2026 19:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786909571;
	bh=m8KwuO3YIIWStRr4n29LMhNSQg5I21ZkYZ9y73+9K+w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=TOs8h5ZarTzZy8TNVJ0dCDT+TmLdv9XYoMTYc+U9edK6k8C6OOSqQJz4YNz37iq0r
	 S2xcYmS1OT+x6rH485w6qU1Y7TwgD6+q+etpP0CY3T/rU2Dmxa6mNYkyWVZFFf0KH/
	 QDbIBwMmdRYNBAqnXC0eqs9DBtPr1NgjNi9an5yOC4ECwb/xvdyePbhM+OH6TJC6KJ
	 I+xZrPbYMPc9ktrgrmWy6pgru6grROWrfdc8h0k3zxu52EL8dXELOM56siWY7l+33T
	 w0EvrH005R5aLMI2Xow0RPHgzt+M1WdBMEcwxbAXmhYndJ9UAuzw9PTp9jlsVzTM6I
	 hftawInS4pOBw==
Date: Sun, 16 Aug 2026 20:46:05 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Janani Sunil <janani.sunil@analog.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Olivier
 Moysan <olivier.moysan@foss.st.com>, Philipp Zabel
 <p.zabel@pengutronix.de>, Linus Walleij <linusw@kernel.org>, Bartosz
 Golaszewski <brgl@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, Michael Walle <mwalle@kernel.org>,
 <linux@analog.com>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-gpio@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <jananisunil.dev@gmail.com>, Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?=
 <u.kleine-koenig@baylibre.com>
Subject: Re: [PATCH v3 09/14] iio: adc: ad7768: Add VCM regulator support
Message-ID: <20260816204605.28a0a81f@jic23-huawei>
In-Reply-To: <20260813-ad7768-driver-v3-9-cb554399ad26@analog.com>
References: <20260813-ad7768-driver-v3-0-cb554399ad26@analog.com>
	<20260813-ad7768-driver-v3-9-cb554399ad26@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Aug 2026 15:57:02 +0200
Janani Sunil <janani.sunil@analog.com> wrote:

> Expose the on-chip common mode voltage output through the regulator
> framework. Support the three fixed output levels and the
> supply-dependent AVDD1/2 setting.
> 
> Keep the ADC runtime active while VCM is enabled and release the runtime
> PM reference when the output is disabled.

Why?  Expectation I think is that VCM is used for powering analog
front ends or simple circuity directly tied up to what we are measuring
with the ADC.  Feels like it may well want to only be powered up when
about to sample stuff.

Perhaps that is a problem for a front end device we aren't currently
describing.  We don't really have a way to do those for backend 
/ dma grabbed data today as there isn't a consumer interface in the
same way there is for the software managed buffers path.

> 
> Signed-off-by: Janani Sunil <janani.sunil@analog.com>



