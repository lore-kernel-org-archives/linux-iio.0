Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0A3336882;
	Thu, 26 Mar 2026 20:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774556590; cv=none; b=DtIJA43Zh8YOJj709PazUcPB7HG9n/p5maFG/KAWpQYhNMLKJkoVw2jMfXosSCw2Qtlu/mm/1L37auh35BbkAclTHQnt2aCepOJHYIwv8Iwk+s23bbFfMjmawBjwG2zL2OGZrIz523LDiVRHVUScB76FH9mXNOOd2csLTYc6szo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774556590; c=relaxed/simple;
	bh=6m/H3j8IsrBdv9gezuJcmcavp1CyYx+IhU/TicXb0/4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=abSd9GSBsO4jZB1S9tBHVKd9UGVisbquYAWf1vsbdi8RpapOVyJuSvkxKu2SmF9V8YntzqHzHJjMurOeNWjsBQ7iAQbEBwy7MCnQx7inguSYG7Q2sj/Ph1KythcRdgugrvmnTbYGi2LS3Ok09AjnO/o4m6pK7jQnTDgq/Rh8NBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k2h9WROu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k2h9WROu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C4F6C116C6;
	Thu, 26 Mar 2026 20:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774556590;
	bh=6m/H3j8IsrBdv9gezuJcmcavp1CyYx+IhU/TicXb0/4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=k2h9WROu7wbO6ds6MrotxbzTGd6t89oZtBQTkKx3dQTALcAtHOO93NMfA6sIOYOAQ
	 QCw6CdLstJOlHjGDTOdWllRMrNrYa9QvnS6dNCKnO9RbrmdeBz2RvkjQgDAeQU6/oE
	 YS7MmhmJ1LUHu2rLh5JL+uElupIsFmbofv5BzKWQuhfXQZFL5uS/aE8uZ8PZeJe3A5
	 BWWF1GbNU+ztE69ABlmhAk1vWlNCVp1mrqjythE6HnFA3gY7ygG/fQ1uSRAq5HkPNi
	 u1KBR9Ed1xOLCRF/mZHe1Y+dPNkgNRh+scXcqc0ZbVp0k4K71+ijYswb4Dh2sMoYnV
	 g9CnI+Jeh1VoA==
Date: Thu, 26 Mar 2026 20:23:02 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Aldo Conte <aldocontelk@gmail.com>
Cc: Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>
Subject: Re: [PATCH] iio: light: veml6070: fix veml6070_read() return value
Message-ID: <20260326202302.17791c6a@jic23-huawei>
In-Reply-To: <9f81cdd6-7f20-45fe-a431-78d75016f7a0@gmail.com>
References: <20260325113216.170357-1-aldocontelk@gmail.com>
	<DHC96AXSNFEZ.121C1XIAZNAMZ@gmail.com>
	<9f81cdd6-7f20-45fe-a431-78d75016f7a0@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 26 Mar 2026 14:14:16 +0100
Aldo Conte <aldocontelk@gmail.com> wrote:

> On 3/26/26 00:30, Javier Carrasco wrote:
> > Hi Aldo,
> > 
> > On Wed Mar 25, 2026 at 10:32 PM AEDT, Aldo Conte wrote:  
> >> veml6070_read() computes the sensor value in ret but
> >> returns 0 instead of the actual result. This causes
> >> veml6070_read_raw() to always report 0.
> >>
> >> Return the computed value instead of 0.
> >>
> >> Running make W=1 returns no errors. I was unable
> >> to test the patch because I do not have the hardware.
> >> Found by code inspection.
> >>  
> > 
> > The fix is correct, but not the commit it addresses.
> > This bug was introduced when the guard to handle the mutex was added.
> > 
> > It should be:
> > 
> > Fixes: fc38525135dd ("iio: light: veml6070: use guard to handle mutex")
> >   
> >> Fixes: bb18885ed823 ("iio: light: veml6070: add support for integration time")
> >> Signed-off-by: Aldo Conte <aldocontelk@gmail.com>
> >> ---
> >>   drivers/iio/light/veml6070.c | 4 +---
> >>   1 file changed, 1 insertion(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/iio/light/veml6070.c b/drivers/iio/light/veml6070.c
> >> index 6d4483c85f30..74d7246e5225 100644
> >> --- a/drivers/iio/light/veml6070.c
> >> +++ b/drivers/iio/light/veml6070.c
> >> @@ -134,9 +134,7 @@ static int veml6070_read(struct veml6070_data *data)
> >>   	if (ret < 0)
> >>   		return ret;
> >>
> >> -	ret = (msb << 8) | lsb;
> >> -
> >> -	return 0;
> >> +	return (msb << 8) | lsb;
> >>   }
> >>
> >>   static const struct iio_chan_spec veml6070_channels[] = {  
> > 
> > Best regards,
> > Javier  
> Hi Javier,Thank you for your correction.
> I got the wrong result from the grep command.
> Do I need to do a review, or is Jonathan's correction enough?
It's applied on my tree so all good - no need to do anything.

Thanks,

Jonathan

> 
> Thanks,
> Aldo

