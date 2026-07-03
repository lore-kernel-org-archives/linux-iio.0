Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF263128D5;
	Fri,  3 Jul 2026 22:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783119364; cv=none; b=SSKcw+pkJBmo5M3ycCCGOxxeIwfpTUgmxpECxWrpd/rxjpnGJqdXHnjwHRK7mGinVaLCZ/MqKJmQIbqTiFfpKzKY59knYaYDYbGYPP9K2MZrJT/Qa4y+WwlospkBz6PCpzHgK8qo1nRhEHZW6hTQPKb8sIFfOA3gfbao2kv3koE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783119364; c=relaxed/simple;
	bh=mXChaQYdiriKq1f5sUhaq1ihuClF0MOP+AtaJQ3GB+4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q7ptffPastcd7qqCfavMfyjAX3hqw7pRpqa0JyLT9f2a19k2i4NZCovHjgufxiaouiRCyGfmdj+0eIjBhllnGohMBGgyhYjwGCIsFZ1pWcqqeZfztrO5EmUz27yFrH+DAftZpE5av4qrGH/BKHm0XXRIxclQnPPNaK2E/rquNIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oS3/UJIk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oS3/UJIk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF1B81F000E9;
	Fri,  3 Jul 2026 22:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783119363;
	bh=STRR19kykPEzT8KZO6gjSz66WGAS36QgQelnTr6j7DI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=oS3/UJIkIRnF64s8iWqB+ZmYjooFPXxn2fIZtG3HCdpFF7nMl6/Oa3IHoF2mHuoR7
	 ew3IdpPhOm1g6qtyGDadqrBZZOVzgOBkW9N0scoMWjGg2sMYEVtK0qnJOuHcJ8ntaF
	 ik15KHe+KRAJe2h7Kotol9dJ/dclLWb8NSTsSji+U2d1Pww1i2oJBM7VheoEQzDP79
	 o1/6B8hH2u7SDo9cLGIFc8XlJWMEDQWsubWiIlZxWNTWZNF6zKplXWrbUeaHcMPcjj
	 npR/38J/OG2p4yKknewHANt4E76QP0wgjVO9EAQNnjPAAOuHsgoQVOkhWvSOrBuIcX
	 RN4Iego+Q8cWw==
Date: Fri, 3 Jul 2026 23:55:56 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Ghennadi Procopciuc
 <ghennadi.procopciuc@oss.nxp.com>, Daniel Lezcano
 <daniel.lezcano@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH v1 1/1] iio: adc: nxp-sar-adc: Fix the delay calculation
 in nxp_sar_adc_wait_for()
Message-ID: <20260703235556.52b5864a@jic23-huawei>
In-Reply-To: <d04e0999-3598-45aa-bcee-d391ef6024cc@oss.qualcomm.com>
References: <20260519215607.78241-1-andriy.shevchenko@linux.intel.com>
	<20260522183533.358a1f30@jic23-huawei>
	<a05742a9-9129-4844-87d5-14473648c4ac@oss.qualcomm.com>
	<20260703200626.40511970@jic23-huawei>
	<d04e0999-3598-45aa-bcee-d391ef6024cc@oss.qualcomm.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 3 Jul 2026 22:42:21 +0200
Daniel Lezcano <daniel.lezcano@oss.qualcomm.com> wrote:

> On 7/3/26 21:06, Jonathan Cameron wrote:
> > On Tue, 26 May 2026 14:48:44 +0200
> > Daniel Lezcano <daniel.lezcano@oss.qualcomm.com> wrote:
> >   
> >> On 5/22/26 19:35, Jonathan Cameron wrote:  
> >>> On Tue, 19 May 2026 23:56:06 +0200
> >>> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> >>>      
> >>>> The original code was using ndelay() twice. In one case the delay
> >>>> is calculated as 1/3 of ADC clock and in the other as 80 ADC clocks.
> >>>> But according to the comments in all cases it should be a multiplier
> >>>> of the ADC clock, and not a fraction of it. Inadvertently
> >>>> nxp_sar_adc_wait_for() takes the wrong case and spread it over
> >>>> the code make it wrong in all places. Fix this by modifying a helper
> >>>> to correctly use the multiplier.
> >>>>
> >>>> Fixes: 7e5c0f97c66a ("iio: adc: nxp-sar-adc: Avoid division by zero")
> >>>> Fixes: 4434072a893e ("iio: adc: Add the NXP SAR ADC support for the s32g2/3 platforms")
> >>>> Reported-by: Sashiko <sashiko-bot@kernel.org>
> >>>> Closes: https://sashiko.dev/#/patchset/20260416090122.758990-1-andriy.shevchenko%40linux.intel.com
> >>>> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>  
> >>>
> >>> Daniel, could you take a look at this one.
> >>>
> >>> Explanation seems fine but original patch was yours so I'd like
> >>> some 'aware' eyes on it!  
> >>
> >> Sounds like correct but let me loop in Ghenadi as I don't have the
> >> platform anymore to check the change
> >>  
> > Hi
> > 
> > This one is still outstanding if anyone has a chance to look at it.
> > If not I'll gamble and apply it :)  
> 
> Yes sure, go ahead
> 
> Acked-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
Applied and marked for stable

Thanks,

Jonathan

> 

