Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD091B6D1A;
	Sun, 22 Mar 2026 11:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774180323; cv=none; b=gTkugkdsanogf8zO6tTRyopEu3b1BewSWVD/lvfF1xv0glhIhGegNYZHggXbWn8CC35/e70E5CAG8VmBP+eVVPjXw9z39FcObMnHWBQC0uLQHTRD3bqbH1+7zy+ynY0yYLrpn6v8oxluz2GuT5JMHuLkVX4QGGdGkkJBe3k7CFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774180323; c=relaxed/simple;
	bh=SXBDfBvRx04l2CCVp87HENbJiCXeMjKNmo1BP3/dTSk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fq9N8+815lMyxz1nD/GpuH0qW+8/9hTyCP4Qnaj8xuek3WIqG0AxNBjb9z1vuWRt1yI1ZE2MruesEbGQaZKsyPxIpMi9DxxXrM/Ybp7/gcLG8bNkTDpkO+1GGem/4leBnQxCGC5dnxBpmIXzVZZ55ieZRsNH7GaJaBj+XA9BUhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JV4+VwWW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JV4+VwWW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAEBEC19424;
	Sun, 22 Mar 2026 11:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774180323;
	bh=SXBDfBvRx04l2CCVp87HENbJiCXeMjKNmo1BP3/dTSk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JV4+VwWWjR4xBPkGDV/pD9N6lLZGzdMPiCg1xDEe5ffftOJYvq03OGWBvTRbOjMlf
	 SYrAyeys7WtUf2S1kX4A7S8Qh2xo+vziet6w4VO32UdcmssHk4Ul1StlN6cmd5LS0J
	 2jCFSmRmTiOmwO/fBR7K+PIt7hOHv48eUYP0YO7WalyG4Xa+h35Z8WEXVZ3fuUstZ/
	 EKLBfU69+SRkmUfO6Vufeaz7qHXzQlkeVPaNd0eDrybKZJLsnc1BnIqibfS+y1Ik/K
	 Hi9Y/duaGq+Nb8waKITUmRsLR6JRAErPzDkoLtrXP419OuI09hZMnI5KbtfYJCGrzt
	 pGYCNQFN2oaxw==
Date: Sun, 22 Mar 2026 11:51:54 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Neel Bullywon <neelb2403@gmail.com>, lars@metafoo.de,
 Michael.Hennerich@analog.com, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: frequency: adf4350: replace loop with
 fls_long()
Message-ID: <20260322115154.40de9b1c@jic23-huawei>
In-Reply-To: <abf6RwTHSapCUw52@ashevche-desk.local>
References: <20260311020115.56321-1-neelb2403@gmail.com>
	<20260314172006.69744-1-neelb2403@gmail.com>
	<abf6RwTHSapCUw52@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 16 Mar 2026 14:40:39 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Sat, Mar 14, 2026 at 01:20:06PM -0400, Neel Bullywon wrote:
> > Address the TODO in adf4350_set_freq() by replacing the iterative
> > power-of-2 shift loop with a constant-time bitwise calculation.
> > 
> > By comparing the highest set bits of the target constant and freq
> > using fls_long(), we can calculate the required RF divider selection
> > in a single step without relying on expensive 64-bit division.
> > 
> > This ensures freq is properly shifted to meet or exceed the minimum
> > VCO frequency.  
> 
> ...
> 
> >  	st->r4_rf_div_sel = 0;  
> 
> > -	while (freq < ADF4350_MIN_VCO_FREQ) {
> > -		freq <<= 1;
> > -		st->r4_rf_div_sel++;
> > +	if (freq < ADF4350_MIN_VCO_FREQ) {
> > +		st->r4_rf_div_sel = fls_long(ADF4350_MIN_VCO_FREQ - 1) - fls_long(freq);
> > +		if ((freq << st->r4_rf_div_sel) < ADF4350_MIN_VCO_FREQ)
> > +			st->r4_rf_div_sel++;
> >  	}
> >  
> > +	freq <<= st->r4_rf_div_sel;  
> 
> Yeah, unfortunately it looks like too complicated in comparison with the
> original code. Have you checked binary output? My gut feelings that this
> gives also a lot of code in addition to.
> 
> Little optimisation can be like:
> 
> 	if (freq < ADF4350_MIN_VCO_FREQ) {
> 		st->r4_rf_div_sel = fls_long(ADF4350_MIN_VCO_FREQ - 1) - fls_long(freq);
> 		freq <<= st->r4_rf_div_sel;
> 		if (freq < ADF4350_MIN_VCO_FREQ) {
> 			st->r4_rf_div_sel++;
> 			freq <<= 1;
> 		}
> 	}
> 
> but it is still too much.
> 
> ...
> 
> Maybe we simply need to replace TODO with a NOTE explaining that if better algo
> is found we can replace.
> 
This comment update makes sense to me as will make people look for previous
attempts before sending a new one!

Neel, you ran into tricky challenge - thanks for giving it a go!

Jonathan


