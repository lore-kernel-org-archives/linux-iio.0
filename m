Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9065C613;
	Mon, 17 Aug 2026 01:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786931373; cv=none; b=Ng1hjp+jwXqo2bBtB+Wy6lBP4PpJBHM2blxnWe0OUaCnia98I1ajk1AciZKzsgxUr7WCg5CqEPRpScgKHJq9jDXVwVFLMojEzx5eBRrWFsCEELklpHluhdMYMjRBfvKNJ46qPJeK0WMxdiira+aLh/QCXnxGNi5IQez2TeXV424=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786931373; c=relaxed/simple;
	bh=tq9SE4wBjnpaVY/4EOV3O6eqjShJlGxnA75kAb3oXuk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S/qX/JKnWOZxTjKMjdj6/yDZKoC6b/toe70FXYfMj5TmuKW+By/FNWCE4erqRT6UCyDdvHW1mEf4hIY7IUGxGBLvJliNsW5X5kbWcH3gVU/b2dMHd5ldX1ekMYqzcb1GR4P8aB1ZKDacux/6U9k7f5sjc8S1UM3mHCzgRZ77GGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RR0cDim6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RR0cDim6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4DFF1F000E9;
	Mon, 17 Aug 2026 01:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786931371;
	bh=IGGu//KeQelgohpE8O0YD1dijvbI3Brz60Yey2biXDo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=RR0cDim6wfcVdypRRpRkJx3NRJ/jGuQd/WLmtXjZLgWElBxs1trzLoX5e+Qa/xfDX
	 pfTL2qTmDazU4zNqTH76ettCMwMz2s8/jMiBrdgBkfriWhn99OaMi1Rc6pygGLXUdi
	 mI0ubBQpT4mRvqzhRJoM4YKdKmI7Zp2cdnjcb3L39RL58lxpEqYcKXnTXUZstLKKt4
	 mSHTd5UnKQz6eUVme0TIg7iEKaYAf7rISJCYdkoCaiACy+ybSAYJ1L5CTUtoKnDS+y
	 LR7fXuVwONvkSLqZ/liu7HLZaHYD1ngnzfLSHaeWyJ36Vrr/0MSgRgLn4qqzrVd3sV
	 oErhg+u4x6Arw==
Date: Mon, 17 Aug 2026 02:49:27 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Mehdi Djait <mehdi.djait@linux.intel.com>, Matti Vaittinen
 <matti.vaittinen@fi.rohmeurope.com>, Matti Vaittinen
 <matti.vaittinen@linux.dev>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>, Mehdi Djait
 <mehdi.djait.k@gmail.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Kalle Niemi <kaleposti@gmail.com>, Topi
 =?UTF-8?B?U29ua2Fqw6Rydmk=?= <sonkajarvi@hotmail.com>
Subject: Re: [PATCH 11/12] iio: accel: kionix-kx022a: Prevent memory leak
 and fix statey
Message-ID: <20260817024927.598f5c83@jic23-huawei>
In-Reply-To: <5424d7ba-861b-44ea-ae92-f4b334958a71@gmail.com>
References: <cover.1786347811.git.mazziesaccount@gmail.com>
	<85e6bd3998863e0247c52dcf0c1486b2cddff567.1786347811.git.mazziesaccount@gmail.com>
	<anxcithfWakkARl8@mdjait-mobl>
	<5424d7ba-861b-44ea-ae92-f4b334958a71@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 14 Aug 2026 10:39:48 +0300
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> On 12/08/2026 14:47, Mehdi Djait wrote:
> > Hi Matti,
> > 
> > Thank you for the patch!
> > 
> > On Mon, Aug 10, 2026 at 10:55:03AM +0300, Matti Vaittinen wrote:  
> >> From: Matti Vaittinen <mazziesaccount@gmail.com>
> >>
> >> The driver allocates memory for samples at buffer enable path. If regmap
> >> operation fails in the kx022a_fifo_enable() at the buffer enable path, the
> >> allocated memory is never freed. Furthermore, the state information and
> >> previous hardware configuration(s) aren't undone, potentially leaving
> >> WMI interrupts and buffers enabled, or driver state flags wrong.
> >>
> >> Free the memory and revert the hardware configuration and state flags on
> >> error path.  
> > 
> > Reviewed-by: Mehdi Djait <mehdi.djait@linux.intel.com>
> >   
> >> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> >> Fixes: e7123a4dfcd7 ("iio: accel: kionix-kx022a: Refactor driver and add chip_info structure")
> >> ---
> >>   drivers/iio/accel/kionix-kx022a.c | 27 ++++++++++++++++++++++-----
> >>   1 file changed, 22 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/drivers/iio/accel/kionix-kx022a.c b/drivers/iio/accel/kionix-kx022a.c
> >> index 8a13f78aeab0..49e8b4b943da 100644
> >> --- a/drivers/iio/accel/kionix-kx022a.c
> >> +++ b/drivers/iio/accel/kionix-kx022a.c
> >> @@ -980,26 +980,43 @@ static int kx022a_fifo_enable(struct kx022a_data *data)  
> > 
> > Do you think this error handling should also be done for kx022a_fifo_disable():
> > in case __kx022a_turn_on_off() or one of the regmap_clear_bits() fails before
> > we free the fifo_buffer ?  
> Good question. I am not really sure what IIO thinks if disable returns 
> an error. Should the driver be in a state where it can handle re-try of 
> a disable (Eg, a new call)?

It carries on when it gets a disable on the buffer tear down path.
It isn't obvious what the right choice is and we can't really just
back off and let things try again as some of the reasons this occurs
are things like driver unbind which doesn't fail.

So best effort for error handling only on the tear down + ideally
some prints so we know what has gone wrong if it does happen.

Writing a driver that survives random bus transmission failures in
every uncommon path is really hard and the complexity is often
not worthwhile.

Jonathan


> 
> If so, then returning an error from "turning on" the IC
> return __kx022a_turn_on_off(data, true);
> is problematic as fifo_buffer is already freed. New call to the disable 
> would then cause a double free. If this is the case, it should be fixed, 
> perhaps by just "NULLing" the fifo_buffer after the free.
> 
> If IIO does not allow "re-disable", then failures before the free() will 
> cause a memory leak. Furthermore, the hardware state may be left 
> inconsistent. Considering that such errors should be quite unexpected, 
> and probably a symptom of shomething being off - I am not really 
> terribly worried about the leak or inconsistent state - and I don't 
> really know what else the driver could be except re-try - which might be 
> a never ending story if problem persists.
> 
> Yours,
> 	-- Matti
> 

