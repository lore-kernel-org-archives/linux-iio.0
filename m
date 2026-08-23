Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F09833F368;
	Sun, 23 Aug 2026 21:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787520686; cv=none; b=dhGQ9wArzkRC8kUP3zN+Szor4geUydBnGGoRT94+Z98uL2Wtz93ohizrk+so0ixSTgV8HMOLrRdb4sAFqbuUWzpuxw3Fc/rgQeJiKNue304bMxmdjHwo3Aal6coZw9+GTY/xVOY52eTB0ARRXJeaYOA6M3wWb15TVW71oImYN7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787520686; c=relaxed/simple;
	bh=nf9KZ884A8BRovsHozVKYUVdhdLkv5FG1P41rUi1gn0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iQIXJAbjNStOBQhjHyjGBkh8n+ahJLUk5b7jKeM1tRGSOg9VkrCcPyL0rO8EmMxdgnDe8v/cTnLK8vLaWRHI07Du4EgkpCMCZ61H6qS435JPOAybb9aMjc6qwafRrp5OesTEUPV2Cp9D3zQqJ2Quu9fppW6fTfX5mY+fdS1rVKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A9k54qYn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A9k54qYn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEDD61F000E9;
	Sun, 23 Aug 2026 21:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787520684;
	bh=E12ZWy9PoGB7xsegjfp0KowrWwm3I5F/1lVYyYIBQjE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=A9k54qYnDE4tAt+RHl256JZdQS3BpwPZV6c60J4iiqXzo7qCknLM360dzqrbio+w4
	 TQ2z2DdrWnXMIP3kFbL5N4jWq6g+IbqzHK3+WMTCB4eGbeQ2wfTu++LMLgdJ4GbHdr
	 DW+5HpmeS8AMjfrF8sfn1pcwpUID9ffniEiOW43nTyosd1Ok2l9gCLoe9Smajkr4Hf
	 L4QakeZqLUPtepcrcvv5cZ/p/A3ZljrwnCv/g4YmJWL263+xS4PIpEt1ZBYFpMxQ/t
	 CCsjpH1JDz+jlcIZtixAGSunym2M3DRhFSGRYA52WFnSBZbWhj/e6NndRramt9szf5
	 I9Aptiz08WTuA==
Date: Sun, 23 Aug 2026 22:31:20 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Salah Triki <salah.triki@gmail.com>, Michael Hennerich
 <michael.hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux@analog.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: adc: ad4030: fix invalid oversampling_ratio
 validation
Message-ID: <20260823223120.293ae60e@jic23-huawei>
In-Reply-To: <0b03fc0f-8032-47b2-ac97-f2d93c1c5bdf@baylibre.com>
References: <20260823045205.25554-1-salah.triki@gmail.com>
	<0b03fc0f-8032-47b2-ac97-f2d93c1c5bdf@baylibre.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 23 Aug 2026 13:29:32 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 8/22/26 11:52 PM, Salah Triki wrote:
> > ad4030_set_avg_frame_len() computes avg_log2 = ilog2(avg_val) before
> > validating avg_val, and the subsequent range check only rejects
> > negative values or values above the maximum supported OSR. It does
> > not reject avg_val == 0, nor values that are not exact powers of 2.
> > 
> > - avg_val == 0 passes the check (0 is not < 0 and not > max), so
> >   ilog2(0) is called with an undefined/garbage result.
> > 
> > - Non-power-of-2 values (e.g. avg_val == 3) also pass the check and
> >   silently get rounded down by ilog2() to the nearest lower power of
> >   2, so userspace can write a value to the oversampling_ratio sysfs
> >   attribute that does not match what actually gets programmed into
> >   hardware, without any error being reported.
> > 
> > Only powers of 2 in [1, 65536] are valid OSR values, as listed in
> > ad4030_average_modes[]. Validate avg_val fully before computing its
> > log2, using is_power_of_2() and requiring avg_val > 0.  
> 
> There is no rule in IIO that says we can't round values when writing
> attributes. Users are expected to read the attribute after writing to
> see what actually took effect. So this patch doesn't seem justified.
> 
> > 
> > This issue was identified with assistance from Claude AI and manually
> > verified against the code.
> > 
> > Fixes: 949abd1ca5a4 ("iio: adc: ad4030: add averaging support")  
> 
> Actually, this could break existing users that depend on the current
> behavior. It certainly doesn't fix anything.
The zero check may make sense even if the rest do not.

Jonathan

> 
> > Signed-off-by: Salah Triki <salah.triki@gmail.com>
> > ---
> > Changes since v1:
> >    - Added note stating the issue was identified with assistance from
> >    Claude AI and verified manually.
> >    - Removed initialization of avg_log2 at declaration.
> > 
> >  drivers/iio/adc/ad4030.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >   

