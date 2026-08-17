Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE8628373;
	Mon, 17 Aug 2026 01:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786929573; cv=none; b=l0qvuqVYmor4Kjvq13EkYUfwbXPBUE4B8lylavKTvKiIhEIuKTSsQyI+qyUjer45RBQuT4P/J3z8RZDfBQ649+qbLg+WNb2PcjiR0uQsqk+l9ol+B1Y5XBB6UxQXk5iWJS5K0S5Tqks6AtqpQUrHGcUePs+WZVEn3t1JU4pYRMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786929573; c=relaxed/simple;
	bh=m7BLXtsrLu9AN0ji4uqJKPpMXcn6matvmJNDvYtT9/0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UNU53RNGSjZVc2BZ5mk4ZKSaCF04+aSnHW1YvT1JsWXlpmiiu7DQh5oQeB63f6V1DPn/F4GNIZ66UjosSRHBa4urxczw9pidv86/3CRhKvVEQciz4mJ1YBvlAFN0WYa3jSlAjBc+nJu4UiMk5iogdKhddR2ETF4ec2/ZFgqCpMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sk2J72B0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sk2J72B0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9753A1F000E9;
	Mon, 17 Aug 2026 01:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786929572;
	bh=04mzDkCy7rHnGkxOTeg0AeioOdnKmN8P5YELmT91YIo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Sk2J72B0yA5jmrR9dPr91jf3ducx/CmPCq1Mu+bc/Zomh+uYFA+UDFHXpbqIq0sQ7
	 L/0XonWfSBRZ/o7Wz5lp2WU2w+AML8N6pUt5xiuAVMJFXMqHnoh8p2SR2ctroEOTaZ
	 KVx37fteiiHgTo9MTJtJeztPdJYqqob7laYskluGcQE/mqLpca28aSHIvgUkKUOkrv
	 +PpElCyIhqcGt4JcfJ1XXQNxYkrwt7igydjPzWFIB3JRN5rrBfCkEeMtwe+Depguwp
	 AFQ4MsQGfGvrgHGopMDFfTA+gcWnXV4+9yFY8JqmeaZga3dwykjuXbEQTh5T4l3fDq
	 T3wqX81xlFx2Q==
Date: Mon, 17 Aug 2026 02:19:27 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>, Matti Vaittinen
 <matti.vaittinen@fi.rohmeurope.com>, Matti Vaittinen
 <matti.vaittinen@linux.dev>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>, Mehdi Djait
 <mehdi.djait.k@gmail.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Kalle Niemi <kaleposti@gmail.com>, Topi
 =?UTF-8?B?U29ua2Fqw6Rydmk=?= <sonkajarvi@hotmail.com>
Subject: Re: [PATCH 07/12] iio: pressure: rohm-bm1390: Fix AVE_NUM
 initialization
Message-ID: <20260817021927.142ebca9@jic23-huawei>
In-Reply-To: <anr0jtvYorFKaEXY@ashevche-desk.local>
References: <cover.1786347811.git.mazziesaccount@gmail.com>
	<7784e12793187a75dc10b0e84471f0cefe4d28b9.1786347811.git.mazziesaccount@gmail.com>
	<anovRGxtsyJZ8cO9@ashevche-desk.local>
	<247b0e35-f49e-4bec-abd4-4a2c3dd49a2d@gmail.com>
	<anr0jtvYorFKaEXY@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Aug 2026 13:08:14 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Tue, Aug 11, 2026 at 12:05:47PM +0300, Matti Vaittinen wrote:
> > On 10/08/2026 23:06, Andy Shevchenko wrote:  
> > > On Mon, Aug 10, 2026 at 10:53:07AM +0300, Matti Vaittinen wrote:  
> 
> ...
> 
> > > > Use FIELD_PREP() to shift the intended AVE_NUM value to correct field.  
> > > 
> > > Can it be FIELD_PREP_CONST()?  
> > 
> > Can you please elaborate why it should in this case?  
> 
> I'm not sure why it's not obvious, but the parameters are constants, why would
> we need an additional check or even checks?
> 
I'm not sure it is as obvious as the name would suggest.
FIELD_PREP() has a whole bunch of stuff that runs if it happens
to have a build time constant value +  FIELD_PREP_CONST() is
documented as primarily being there when the code requires a constant
to be correct.  Whether FIELD_PREP() collapses to a constant in
a recent compiler is something I'm not sure of.

Jonathan


