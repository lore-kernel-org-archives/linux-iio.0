Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B81D416D1D;
	Wed, 10 Jun 2026 15:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781105879; cv=none; b=ME5aKHrpLcXX/uJ0lOP22E69qHxkJsvQABbik0go+IvKyYjwNJ6/lJVF4koA2gIGLa0Z4l+8rciwvWEZ1EsuXOq8vIkrnzEElee58QVhC5s7arqIsgSC9jpaHeEx5l3Urtj1mMRkBFU9GPgQnYRh45+4FELCGzlW1FbChVLGVWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781105879; c=relaxed/simple;
	bh=AyhaRL9PPEaExWPlGJQzrJdCA0Pp2/08iarGw+HgOzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eGP+8FqJTT1iSj/vqzBnTKO7WFyhhqpa6QMtCjhfmplWi+UzeztD5L4k/sifChzyHjtyfcug9EXjWWDX1Q5H8jjJ3azv2sAjhrF0iCDuT33BhLkQFdwBCuheEqI/Q3pRCMNTMa4CoCD5Tc9dunhQYU980G7QC39GpgjSmOmCpmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nPvhtWSp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nPvhtWSp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CA801F00893;
	Wed, 10 Jun 2026 15:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781105877;
	bh=Xh9ZfaOQ3M7dwc5C/pdJBJ9F4eP9xnAqXGu5SLEHA7Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=nPvhtWSpDpKCnTuCXd/MeyuLWiiO8vHTX5RlbmjnHiWiO3YmPpyftOlKD5fBLTVLY
	 U600gpsUBqPndlXwhxTuVYpCo6CsJlTVYEqills6T3RlCNaUsdM8MN1vAv1LiFBs1g
	 jkMq+URgX501DicH8vhx9iiL5L29bkbiSiIIS7tFfI55Ll2X8dBxbYon3oFXPZLvcU
	 KcQFJZ/BLI/1T7GHufdd/OUNn6ID1iDJ6Dehs41JnMzy9TxfE8p8E+P4uzKyZzkMSS
	 H0fIJIDUmpdEyAsW3/f1SvSM6jAcUPyLP5Snhgn3ivr0YiOGjnpydeGwNf30gj0GdY
	 swdqGHYHA8Ygw==
Date: Wed, 10 Jun 2026 16:37:49 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Hungyu Lin <dennylin0707@gmail.com>, Matti Vaittinen
 <mazziesaccount@gmail.com>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: pressure: bm1390: replace short msleeps with
 fsleep
Message-ID: <20260610163749.5d2cd98f@jic23-huawei>
In-Reply-To: <aievYfVvpJGCfTEz@ashevche-desk.local>
References: <20260609005710.85842-1-dennylin0707@gmail.com>
	<aievYfVvpJGCfTEz@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 9 Jun 2026 09:14:57 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Tue, Jun 09, 2026 at 12:57:10AM +0000, Hungyu Lin wrote:
> > Replace msleep(1) with fsleep(1000) for the driver's short
> > delays.
> > 
> > The BM1390 datasheet specifies a 1 ms reset cancel wait time
> > (tSC1) during the power-on sequence. Use fsleep() for these
> > short delays because it automatically selects the most
> > appropriate sleep mechanism and provides standardized timing
> > slack.  
> 
> Same comment as per v1.
> 
> ...
> 
> > -	msleep(1);
> > +	fsleep(1000);  
> 
> And in case you really still want to do this, use multipliers
> 
> 	fsleep(1 * USEC_PER_MSEC);
> 
> (but this might require time.h to be included).
> 

We seem to have a consensus that this is really just adding noise
in this particular case, so let us drop this one.

Thanks,

Jonathan
