Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B621536C0CA
	for <linux-iio@vger.kernel.org>; Mon, 11 May 2026 11:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778498589; cv=none; b=ZKJSy49ciIR3ATBpGmtpHWskZS8qeHZuf8G0ci88WsbGNuZzzFzq4+9YPRqHSmNO5SmmG+w5r1KYGT7Ue76R/vc2oaCotS2KVgNUOOOuT2A4pQXN1NIPuhPdqZpCc/G6akh77D+ZzpMiWyHJKP+4ZhX/xJG93Jb+dk4QRCw7iUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778498589; c=relaxed/simple;
	bh=QxInPWofE2ZB49PbLt41G2X9x/b2OCfH2703ZmbqkdI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=usM5HvIu9C42fucZoubD0Qz5Dmm2edGuLhHsN9lxF9xANrKjY+tNb4wNkslM969I8gI1hyszG/GdlkTPtOVYj5+J3HIDv5RRrmYxYhY5jIOAL9pPz3GxypWjUagYz+z/TNNJk6UfztHYgVddkHQnctwP6XJYhMfGhPWwlD3gD3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZiFL7VD2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZiFL7VD2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97A51C2BCB0;
	Mon, 11 May 2026 11:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778498589;
	bh=QxInPWofE2ZB49PbLt41G2X9x/b2OCfH2703ZmbqkdI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZiFL7VD2l59jv4Al48Kr2kGH51eu8I311jrbhVpeIU8RFGRl17JPsRMHpylTkW/vN
	 F7bW842FPCuXo6gN0cepkfGDQTdIijV3fO+MDhZzspJ2mZg7HynNqg3zZrcJJI3ym0
	 0HzMwgbW7beeNu+2HgqDA3OeWwiruyJsjcvVlSZgI7y9cuei9VUznuEDyPHnR7cjQD
	 M4VlTXNsaumeiQ7CcGK06vYwNQTuyVB8ol5gn66Tf7fTSj8BnCuZV0RlejEni1goO5
	 TKWi/ri78pDATpIEdLez7zaLiNRHlzFp+khwZzXC0lv0NOompmSyTJF0ebSKhOmVFD
	 Tf2jd+hnDk4TA==
Date: Mon, 11 May 2026 12:23:01 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Machado Lage <marcelomlage@usp.br>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, andy@kernel.org,
 dlechner@baylibre.com, nuno.sa@analog.com, linux-iio@vger.kernel.org
Subject: Re: [PATCH v4 0/2] iio: adc: mcp3422: apply bit manipulation macros
Message-ID: <20260511122301.0f1c14fc@jic23-huawei>
In-Reply-To: <CAO=vGZoizk4wLU7oRET-HxDOe52_82OXyyL1G1r4dzLhJYKv6A@mail.gmail.com>
References: <20260429224401.11818-1-marcelomlage@usp.br>
	<afLyk-kNyZkr_drR@ashevche-desk.local>
	<20260505172214.6f0025d3@jic23-huawei>
	<CAO=vGZoizk4wLU7oRET-HxDOe52_82OXyyL1G1r4dzLhJYKv6A@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 9 May 2026 11:09:06 -0300
Marcelo Machado Lage <marcelomlage@usp.br> wrote:

> On Tue, 5 May 2026 at 13:22, Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > On Thu, 30 Apr 2026 09:11:31 +0300
> > Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> >  
> > > On Wed, Apr 29, 2026 at 07:43:59PM -0300, Marcelo Machado Lage wrote:  
> > > > This patch set rewrites several open-coded bit manipulation parts of
> > > > the MCP3421/2/3/4/5/6/7/8 driver code using bits.h and bitfield.h
> > > > macros.  
> > >
> > > Both LGTM now
> > > Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> > >  
> > Nice.  Applied to the testing branch of iio.git.  
> 
> Thanks for the reviews! We're happy to see our patch applied!
> 
> > FWIW Sashiko had a field day on 'whilst I was here' things in this driver:
> > https://sashiko.dev/#/patchset/20260429224401.11818-1-marcelomlage%40usp.br
> >
> > Note that the DMA one is wrong. Some of the others might or might not be correct.
> > Maybe some stuff to look at if you want to do more work on this driver, though
> > you'll probably need to work out some way of testing fixes for the more complex
> > ones.  
> 
> Thanks for pointing out Sashiko's thoughts on this patch.
> Unfortunately, we do not have access to the device for testing complex fixes,
> but we'll definitely study its suggestions for next contributions.
> 
There are other paths to testing that are mostly sufficient.
Best is full functional emulation in something like QEMU but you can also do a
lot with careful stubbing out of functions and prints of device state / what
goes over the bus.  Key to any of these techniques is to state how you tested
in in the cover letter as these methods don't test everything (nor does real
hardware for that matter - given race conditions and rare failure paths)
and reviewers should be aware of what to look out for which depends a bit
on how things were tested.

No problem if you decide it's too time consuming or tricky though!

Jonathan
 
> Best regards,
> Marcelo

