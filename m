Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 278A12F8EB7;
	Mon, 11 May 2026 13:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778507026; cv=none; b=eb+7JeX6OeUvNAlys4t0y13KgVvUZ3V9PbVvCoqZAu60CafckevhFH7tJWgyve2DtuPrKWgTH0wOL926l7af1QzXJTg3n/xJssvYwo3S5d/hOvvKWoOnOv8wKCl6gyfcFvh6ECyMnDKUcyEtVyngX26BjSJJMGsdRSCwGn3iwTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778507026; c=relaxed/simple;
	bh=/3pzqEMxogsnI9LeMDIUXAeHoMObYEHvJ/92er2SczU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JIf9LV/CwIuZFLKQSAWPaNG6NbZZuBSQD1x2Nk+SrW5+wxXMkUWx1za9T4y7G9QgQLeIh9IOI1f2M+Kbw3UmC0Pi82d6x8tP8XPpA98qJmtSRbespsK8uEks8awR+lduLP+8HC4EAHNb+aiUVL2C+z9fB08rl49NlFSyZQhI/W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g7qEZJBa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g7qEZJBa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F6DEC2BCB0;
	Mon, 11 May 2026 13:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778507025;
	bh=/3pzqEMxogsnI9LeMDIUXAeHoMObYEHvJ/92er2SczU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=g7qEZJBaLEKZB6dfsjzqIn05MuFvwzH+jFEVifEZVAZsyoKIywOFKR4qq5OZmedl6
	 3tUSUDcU6Tm3oE6j4PLJmmwBUQVSa1cq321XV1L+tbuxAIH1cuxtWpiUFfx8r/pDg1
	 Hof+euH9qhhW6SKGtiMjaefcLGW7uJMTp8zEvvAftmIXVLJWq7Ig1GzZsSg8FfuN9h
	 bKoaCs6/0PVCxNTfCA9T8J4nWkxwrOmJAd78++0S63eW11+lqzHIaz+cmTePyAtSrx
	 3TTwcN7bh6A7hPwwxVnYXwo71GYYOt+fLHgjI8smPqQ/Xlq+lyCIwXN3kd3EkZv8zQ
	 6XcBo/5rEjPmg==
Date: Mon, 11 May 2026 14:43:36 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Ethan Tidmore <ethantidmore06@gmail.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, David
 Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ad7766: Update to use
 iio_push_to_buffers_with_ts()
Message-ID: <20260511144336.765f72a5@jic23-huawei>
In-Reply-To: <agGyGgI6vlINm-V8@ashevche-desk.local>
References: <20260510221404.22834-1-ethantidmore06@gmail.com>
	<agGyGgI6vlINm-V8@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 11 May 2026 13:40:26 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Sun, May 10, 2026 at 05:14:04PM -0500, Ethan Tidmore wrote:
> > The old ABI function iio_push_to_buffers_with_timestamp() is no longer
> > preferred due to it being inherently unsafe.
> > 
> > Update to the current standard iio_push_to_buffers_with_ts().  
> 
> Nice, but there is nothing about correctness of the change. This is quite
> sensitive area which is ABI. Any breakage is a big deal. Have you studied
> the case deeper? What are the contents of the buffers with the old one and
> new one versus channels enabled? Is timestamp located in the same offset
> in both cases?
> 
Lazy hint on this - check the implementations. One's implemented using the
other making these questions straight forward.

More interesting to me would be a statement of why that size is correct one
to pass. That is the most common source of bugs around these changes rather
than data placement issues (good to understand though!)  Note that we have
broken data placement by 'cleaning' up the functions themselves in the past
but not just switching from one to the other.

So patch is right but a brief statement that struct ad7766.data is an
embedded array and so we can just take it's size would be nice to have in
the patch description.

Thanks!

Jonathan


