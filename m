Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85113221DAE;
	Fri,  3 Jul 2026 19:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783105593; cv=none; b=n7HcrGtKPbe8tzE5afiaQF/OGTK159evgF3ltwUMpCrc1NP6uTEogUC+ntJTUcIvRN2qdSMFr//QTfhahngp/270+gjUzXypkoAwQrA3VGqirzwv74cFGLG3zLspXkRvDAVEOIJBLYxYBHZD4FTSjJ6UqUTuxL2JPLU/SQKkKNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783105593; c=relaxed/simple;
	bh=mv2BsUy3intTqhltCpzBtNEly8AWVzp1JtjsI5biLJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LtfR24CwjNhlD1+JOTtlpWpSenssPOl5B6RhC/HB61+Q/ub2B4IMGPmqrficBLJjQSNBGznSzYuJURE3QJrh9AZCd7LQFKe+xoVxCz/Ay0Zp+sBwhq5eN15a1yDpN0clgNsuxc6SyFg8abm9oJEnYxM1jh7rBLy8dFF/wtIAaXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QKFZw05D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QKFZw05D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B9F51F000E9;
	Fri,  3 Jul 2026 19:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783105592;
	bh=rZpu58nMxaKiF4oCCytzshVIwNqZ0nNVd2Hczy2vmVA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=QKFZw05DPpvOxMA5KYGCj8UskZLBifFwYSq0JPXFufWsUyzV2O5obEGNvgmXwnI1S
	 dPJG14rOorb6aGyhh/UKnplh0V4pFU8+TbpqudnX+cdtVNqXbrNohAXL6dO5CO4uTG
	 5G06jt4IPWlraH/VXtLAJUii08BTNrUqziN/CIKzDKyV/FHPkL2BohcnfH6j2y+FIS
	 4RGeCxBPywRndSDmxHzNJQKXTOlQe0P6RnEVuPPnvCHCXiXYjTMDp5dmK4ptjtEZjc
	 QMlE2zACVQcM0ls1T1ORjD2QI3SY2x9prX4hgjVI/BAusnPbCRY5qTslyMJDpEtpcY
	 G8Toa9XDSwYew==
Date: Fri, 3 Jul 2026 20:06:26 +0100
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
Message-ID: <20260703200626.40511970@jic23-huawei>
In-Reply-To: <a05742a9-9129-4844-87d5-14473648c4ac@oss.qualcomm.com>
References: <20260519215607.78241-1-andriy.shevchenko@linux.intel.com>
	<20260522183533.358a1f30@jic23-huawei>
	<a05742a9-9129-4844-87d5-14473648c4ac@oss.qualcomm.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 26 May 2026 14:48:44 +0200
Daniel Lezcano <daniel.lezcano@oss.qualcomm.com> wrote:

> On 5/22/26 19:35, Jonathan Cameron wrote:
> > On Tue, 19 May 2026 23:56:06 +0200
> > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> >   
> >> The original code was using ndelay() twice. In one case the delay
> >> is calculated as 1/3 of ADC clock and in the other as 80 ADC clocks.
> >> But according to the comments in all cases it should be a multiplier
> >> of the ADC clock, and not a fraction of it. Inadvertently
> >> nxp_sar_adc_wait_for() takes the wrong case and spread it over
> >> the code make it wrong in all places. Fix this by modifying a helper
> >> to correctly use the multiplier.
> >>
> >> Fixes: 7e5c0f97c66a ("iio: adc: nxp-sar-adc: Avoid division by zero")
> >> Fixes: 4434072a893e ("iio: adc: Add the NXP SAR ADC support for the s32g2/3 platforms")
> >> Reported-by: Sashiko <sashiko-bot@kernel.org>
> >> Closes: https://sashiko.dev/#/patchset/20260416090122.758990-1-andriy.shevchenko%40linux.intel.com
> >> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>  
> > 
> > Daniel, could you take a look at this one.
> > 
> > Explanation seems fine but original patch was yours so I'd like
> > some 'aware' eyes on it!  
> 
> Sounds like correct but let me loop in Ghenadi as I don't have the 
> platform anymore to check the change
> 
Hi

This one is still outstanding if anyone has a chance to look at it.
If not I'll gamble and apply it :)

Thanks,

Jonathan

> 

