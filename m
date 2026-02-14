Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B6EF42A9D;
	Sat, 14 Feb 2026 18:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771094665; cv=none; b=rruNR/Mimb4fGYNp71lTXFr6JtFKrDrg7HhHMP0iwjlUinvPUsWwXzZb3guYZaZn2bMA+urMbBBy0uEGS1fjixfEKQUWjFLIqj1+2ze9O5jOTYScY9V2m45OoO3LudStNe87SVU1MQXFRwal4Y9h+8k3WCPcieyWOblJ0XPBJLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771094665; c=relaxed/simple;
	bh=m5o9ISYaUDLyKaRhNebHWlq3NpJX8mmzwpGiaC16LgU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S0ePZQAnhuekeVakzP/qx7s8vMwW/I+uVJ0m28Ouxnn6rkRc17oOXEti3P2Fik3X7wx0EcLp/xjlPzhSyGCYnYA7t2PxnJrgqc+7YIC9/Sy6lqm5pZgPE60LoxXIDLUCK3CkR/JLdugnUNKJuiAcy+pA/NvGeeNJm6tC+fOfsBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XzVepseA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XzVepseA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B44EEC16AAE;
	Sat, 14 Feb 2026 18:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771094664;
	bh=m5o9ISYaUDLyKaRhNebHWlq3NpJX8mmzwpGiaC16LgU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XzVepseAxTHhSKXCVj3VkVmJQ10zuKTgdGoj5pu2iaFB/cF5dcufgnzwt6XbGxYUY
	 8ydhUXRybpXSjuEao5xrri9DflSiRCpIyx79Am3M/Vzmff7J3z8s2gnWcJmxQxidsZ
	 f5qbnSrZQF8oaul4+0L8PRt2kF5XXcgLKI5Y7XOzzj0/xtNXv4B4fNLfE1A+G/oOVt
	 n0MXB83Asl7qWwXkSb/8QbK4lPrk7WkLhMZ8r7NR8evqHKie12wH0zO8/iq533Q3Ys
	 E7RsPms/sh6YeGGM4yRpUVM85DXPG83coG0qOk1smcK6L40Xlgv+J+mn9M3mDXM+yn
	 TroyvFAU60ryQ==
Date: Sat, 14 Feb 2026 18:44:14 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>,
 rodrigo.alencar@analog.com, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, Michael Hennerich
 <Michael.Hennerich@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, David
 Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v4 07/11] iio: amplifiers: ad8366: refactor device
 resource management
Message-ID: <20260214184414.61c1e88c@jic23-huawei>
In-Reply-To: <aYyEhGWhql7C78PY@smile.fi.intel.com>
References: <20260210-iio-ad8366-update-v4-0-15505f7b15b4@analog.com>
	<20260210-iio-ad8366-update-v4-7-15505f7b15b4@analog.com>
	<aYuPhB_e14orrZ64@smile.fi.intel.com>
	<whgxbva3eeushqmj57xsk2q5kv3pmrffu2fzgmxyynvvzb4fyr@25arbt3bqulm>
	<aYyEhGWhql7C78PY@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 11 Feb 2026 15:30:44 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Wed, Feb 11, 2026 at 12:10:11PM +0000, Rodrigo Alencar wrote:
> > On 26/02/10 10:05PM, Andy Shevchenko wrote:  
> > > On Tue, Feb 10, 2026 at 07:42:07PM +0000, Rodrigo Alencar via B4 Relay wrote:
> > >   
> > > > Adhere modern device resource management with the following:
> > > > - Voltage regulator managed and enabled internally;
> > > > - IIO device registration handled with devm_iio_device_register();
> > > > - removal of goto's from the probe function;
> > > > - ad8366_remove() removed as it is not needed anymore;
> > > > 
> > > > With the drop of goto's dev_err_probe() is used to report probe errors.  
> > > 
> > > I think the regulator change should be split and go before the previous patch,
> > > because that one affects the ordering in the error path and remove stage.  
> > 
> > OK, that can be done, but the same way,
> > the error check would change as well as the dev_err_probe() args, not seeing
> > much benefit there as the same lines will have to be touched anyways.  
> 
> The point is to range the problems and target the more serious one first.
> I consider the wrong ordering, (mis)use of devm_*() are in a priority to
> just a simple cleanup.
> 
Took me a minute to see what was meant here, but having realized original
code unwound as power off then reset when it had setup as power on then reset,
I agree entirely with Andy that should be fixed in the earlier patch.

Thanks,

Jonathan


