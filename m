Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC1C29D26C;
	Wed, 12 Aug 2026 04:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786507397; cv=none; b=RuxLlcqF99T4JjFWU6NP4jLUey+os2AwqlMqnezi2sL5IWEKK0+7dT03vkUSz//h/lFvd8uCZsc4gQP/sYv21v5rXy6TBsBYZg7KK26q8JdVP2H2iqMVJK1RtNYwihFl8m9ynrPyy9yexyuJ2DGiI2lHyPwaPJ8x8AWgwH+IiZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786507397; c=relaxed/simple;
	bh=j7z37lnbaGmQfdjr3XUmQ1PIJAlOuHiskn3Fc9fvqoc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rfVbnwPf6vunTO6m06hRhHTUaNQICF35f9+pNem4855dPLjJKYZVkTnh8b/XMWg5r0sEXaxEYLMp7fkge5XKE9wTpEjMavxGvLm468FWJ2wLhWvT5y4uYdze9qT27LOrCG6TNb/qOQrZzhgtfmhOfJffexGMjhACoTD0LusQ6nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DySS4LHL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DySS4LHL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EA751F000E9;
	Wed, 12 Aug 2026 04:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786507395;
	bh=IpxM674/qZiY79F1Phn6HpwxYzDeLLCDl3ThxeIJ0KE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=DySS4LHLqRqebSWFIYXYomuSnnqoNBqoOnTrDL3fIfg5q0axKCo6w9JCV+i93x7XU
	 KHrxzzlKV7mETjWJJtjTqN4uwfDyoJTC+fMt9uz5uRdrcPOmaU+Fum9QoqV5js3dsD
	 rdaEL7fXxB7HcXcuwwLW9FLLJnId+ApHHMKq6myg0s46ud1rVFA0Fg0qNef8mwQtb8
	 df/s1vsuAAgMlPjjezEEGudMah/w1uBcP0Ekuy65+59E5XooTQN9fj7caz3A60NJdz
	 L8XXVXMy454ES93oykOZb+MTEjeGm0+M868HupK3GBricbsSdBa8gPOiKA2qSXuymL
	 X+pWhVPUE3jBQ==
Date: Wed, 12 Aug 2026 05:03:00 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Marcelo Schmitt <marcelo.schmitt1@gmail.com>, Marcelo Schmitt
 <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 nuno.sa@analog.com, Michael.Hennerich@analog.com, dlechner@baylibre.com,
 andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 julianbraha@gmail.com
Subject: Re: [PATCH v9 5/6] iio: adc: ltc2378: Add support for LTC2338-18
Message-ID: <20260812050300.02ba78a6@jic23-huawei>
In-Reply-To: <anrju2FHVOfS-e6z@ashevche-desk.local>
References: <cover.1785186980.git.marcelo.schmitt@analog.com>
	<39f2ff86cf736ff97286d6451fcc45fdba6732f9.1785186980.git.marcelo.schmitt@analog.com>
	<anl_v428aTL6waBK@ashevche-desk.local>
	<anqM43NvcVhhkkWI@debian-BULLSEYE-live-builder-AMD64>
	<anrju2FHVOfS-e6z@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Aug 2026 11:56:27 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Mon, Aug 10, 2026 at 11:45:55PM -0300, Marcelo Schmitt wrote:
> 
> ...
> 
> > > > +	/*
> > > > +	 * The internal reference buffer amplifies both the internal reference
> > > > +	 * and REFIN by a factor of 2.
> > > > +	 */
> > > > +	ret = devm_regulator_get_enable_read_voltage(dev, "refin");
> > > > +	if (ret == -ENODEV) { /* refin is optional */
> > > > +		st->ref_uV = st->info->internal_ref_uV * 2;
> > > > +		return 0;
> > > > +	}
> > > > +
> > > > +	if (ret < 0)
> > > > +		return dev_err_probe(dev, ret, "failed to read refin regulator\n");
> > > > +
> > > > +	st->ref_uV = ret * 2;
> > > > +
> > > > +	return 0;  
> > > 
> > > I'm not sure about others' preferences, but I would do it as if-else-if and
> > > remove dup return 0.
> > > 
> > > 	if (ret == -ENODEV) /* refin is optional */
> > > 		st->ref_uV = st->info->internal_ref_uV * 2;
> > > 	else if (ret < 0)
> > > 		return dev_err_probe(dev, ret, "failed to read refin regulator\n");
> > > 	else
> > > 		st->ref_uV = ret * 2;
> > > 
> > > 	return 0;
> > > 
> > > It also makes code shorter (in amount of LoC).  
> > 
> > This has already been applied to IIO testing. I do send another version of this
> > specific patch if that's okay.  
> 
> Jonathan can replace it there, as rebase is inevitable anyway. Let's ask his
> opinion: Jonathan, do you want a followup that can be folded or a new version
> of this patch?

Patch on top.  Pull request went out. I was busy with some other stuff
so didn't get a chance to catch up with outstanding discussion before
sending that.

Jonathan

> 

