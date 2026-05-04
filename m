Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF7F202C46;
	Mon,  4 May 2026 16:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777910450; cv=none; b=I81do1RqFQhcVJ6opDzIT4zKiz/vodQhFj0GG6GcOgy3hM+RKEaErkTPpjkojG3aaOOCqkwDCYEZDJE4Cpg8FLNmEwl/TFD35Cpuo6lMSLLXpbcg9gEhmyfCFJBWSnj2e/DBqFwLO4x6EdTFn3dJZfeaXGzqz9AJiXareqWTPHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777910450; c=relaxed/simple;
	bh=LDG23F47+EKP7kFitVkUbjmVNpx5L979aHM4xc6I+Ag=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nOLeFHSqAmSGRxQ5Hig6SJXFbQJ8mGFwpyPuUAohyICGyZaMzY5Vv/0A3K5vNsqR5kp12PsJ8SkS9nkQPxi0qedGn8plajqTGbUGcwoKe+m2IQaHEz60CB31tQfS18/zFFlrzVkwagGcxFSkqjFzeAzTEf0Cf/vwXlqvAJ7Jo80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=poo1sFFj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="poo1sFFj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1498C2BCB8;
	Mon,  4 May 2026 16:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777910450;
	bh=LDG23F47+EKP7kFitVkUbjmVNpx5L979aHM4xc6I+Ag=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=poo1sFFj0fMoevgYNexXg4Xu63L18kLTv72pi7TNYFzmR49uiN9/VUw7bdxG0Lk3d
	 /UxR4/ktadpmhUVPuB/7RewvbAL+EdFYotMkJkyoV+FEkRJDJiHiceFJzcr1S4y7TZ
	 vaJUByfdJ9G+LV4YrvvorS2Os100CaTr0G05x0BHQnoH3JKVx5zdXH1aYmWNzns/zp
	 183vwlsBPfquAi2lOKkT9kEEQyvxWSLT6Kn854LtIglFW3CzM3DrHIJp+y+mUQp74g
	 RQRQNA2fT3bunLQgEQhyVCGzvflD3B3EF2vM7TelSU7dsUdaHdbov8/XSQfjI5BiC0
	 2DShfcDJj4diw==
Date: Mon, 4 May 2026 17:00:39 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Piyush Patle <piyushpatle228@gmail.com>, Andreas Klinger
 <ak@it-klinger.de>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 05/11] iio: adc: hx711: move scale computation to
 per-device storage
Message-ID: <20260504170039.778e155b@jic23-huawei>
In-Reply-To: <afisRtohis1eJBBZ@ashevche-desk.local>
References: <20260503120949.80292-1-piyushpatle228@gmail.com>
	<20260503120949.80292-6-piyushpatle228@gmail.com>
	<afisRtohis1eJBBZ@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 4 May 2026 17:25:10 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Sun, May 03, 2026 at 05:39:34PM +0530, Piyush Patle wrote:
> > The gain-to-scale table is global today, so probe-time scale updates for
> > one device overwrite the values used by any earlier device instance.
> > 
> > Fix this by making the gain table const and storing the computed scale
> > values per device in hx711_data.
> > 
> > No functional change for single-sensor configurations.  
> 
> ...
> 
> > +static const struct hx711_gain_to_scale hx711_gain_to_scale[HX711_GAIN_MAX] = {
> > +	{ 128, 1, 0, },
> > +	{  32, 2, 1, },
> > +	{  64, 3, 0, },  
> 
> In such case the inner trailing commas are not needed. They are needed when the
> supplied lists are arrays and may be extended. Here it's a proper data type
> with fixed number of arguments. If you want to be even stricter and robust, move
> to C99 initialisers (but note, I'm fine with just trailing commas being removed).
> 
> 	{ 128, 1, 0 },
> 	{  32, 2, 1 },
> 	{  64, 3, 0 },
> 
> >  };  
> 
> ...
> 
> > @@ -574,4 +575,3 @@ MODULE_AUTHOR("Andreas Klinger <ak@it-klinger.de>");
> >  MODULE_DESCRIPTION("HX711 bitbanging driver - ADC for weight cells");
> >  MODULE_LICENSE("GPL");
> >  MODULE_ALIAS("platform:hx711-gpio");
> > -  
> 
> Stray change.
> 
Given Andy commented on this a couple of times and it is still here,
let me just add that this change is fine, but not in a patch doing
anything other that white space cleanup.  So spin a new patch for it
or don't make the change at all.  This stuff is distracting noise.

Thanks,

Jonathan


