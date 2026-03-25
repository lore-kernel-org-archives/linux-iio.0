Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0232638C2C4;
	Wed, 25 Mar 2026 19:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774467756; cv=none; b=YOfjts3p/S+VT8yapMRaibOS+eGMMWhE2RTqTEmf7Po/mrv/T/Np324YJuGqJP+L114UnR4bVVpoLVefDKzoncTsfSpBKdmiDW//PnQShAOHC67lEZ6vjw+X+swq/eVpzljszaeIkdjc70rndnyuACU8OHKU+aWCbktN5LdTz90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774467756; c=relaxed/simple;
	bh=casEECSCZFqzaWXZa5uVv2GLE6pia8LBWKJV9Nkem4o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jfZKwJzHfmjQ4oORnItwALS2ioXYSn98LPw9gcuWhVwm84qz/aWh9iLp5nMn5sZ93NR/o+qN/CoOoC0aL1awTgadfYveXNEXimntLha3tfqYUKshE7lttBNnyydvNWBAuSYjeBCgfN8HGUNHqp5mZIYZCYO6TszWT5CafsciQ5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JmXiUHPJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JmXiUHPJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4D43C4CEF7;
	Wed, 25 Mar 2026 19:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774467755;
	bh=casEECSCZFqzaWXZa5uVv2GLE6pia8LBWKJV9Nkem4o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JmXiUHPJA+L12PjxMiAw6qmVr5LWtN2igfZykPyMev3rzaxbYX+G5ZK66Lmunf7NW
	 R1WBTo3h0Y0wAIo6YFWdLpjImdSG2wNwfgdv4nHK5Cl7Ipm3vM0z0sAZ2nM5C3CIDP
	 LFO71a2KJT1Z9MvK7gnS4CCwbkTN3MExmBA2k+DDNj1XlLA7GbEAgQbuDjkekOpEgY
	 Agwm2hJ2er3NkewmDRehXu7zmpwWl+JqtAPTelNDnAhL+/tyUXM3cHyxbZxTjIo0KA
	 NIgnQsXdi6WSnkSog9qJPjx/1XlDfndR5S8ZqXf6RWELuZzRcTUN5kVcvbaDEAEjSi
	 CcUFFdBFEv0Ng==
Date: Wed, 25 Mar 2026 19:42:27 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Gabriel Rondon <grondon@gmail.com>, David Lechner
 <dlechner@baylibre.com>, Nuno Sa <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ti-ads8688: use read_avail for available
 attributes
Message-ID: <20260325194227.5d112a85@jic23-huawei>
In-Reply-To: <acJ4sPoX_UqorDXS@ashevche-desk.local>
References: <20260323215633.8140-1-grondon@gmail.com>
	<acJ4sPoX_UqorDXS@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 24 Mar 2026 13:42:40 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Mon, Mar 23, 2026 at 09:56:33PM +0000, Gabriel Rondon wrote:
> > Convert the in_voltage_scale_available and in_voltage_offset_available
> > attributes from legacy IIO_DEVICE_ATTR with custom show functions to the
> > IIO framework's read_avail callback. This uses the framework's built-in
> > support for _available attributes, removing the need for manual sysfs
> > formatting.
> > 
> > Precompute the available scale values at probe time since they depend on
> > the reference voltage which does not change after initialization.  
> 
> ...
> 
> > +static const int ads8688_offset_avail[] = {
> > +	-(1 << (ADS8688_REALBITS - 1)),  
> 
> This is fragile code (however it probably won't be exposed IRL)
> if ADS8688_REALBITS == 32 this is UB in accordance with C standard.
> 
> Also the trick with -BIT(x) is harder to read than simple GENMASK().
> If ADS8688_REALBITS == 1, this becomes -1 (all ones), is it correct?
> 
> > +	0,  

Replying here because the follow up lost too much context.
This is a classic offset for bipolar ADC, which is - half the full
range binary value.  So we won't hit the edge cases, but maybe
expressing it different will be clearer.

-(GENMASK(ADS8688_REALBITS - 1, 0) >> 1) does feel a bit overkill
but -GENMASK(ADS8688_REALBITS - 2, 0) feels under explained (much
like the current).

We 'could' use -(U16MAX >> 1) but that feels very specific to
it being 16 bits.

Maybe just leave this as it already is in the table the value
is copied from. 
