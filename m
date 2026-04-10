Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8E9330B32
	for <linux-iio@vger.kernel.org>; Fri, 10 Apr 2026 08:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775808684; cv=none; b=r3JLTIyKZC5SSX8PfT9wSy8jLL4F+D87/7NQIDb31ND+0D7q+tBpkQ+QU9hVKXsXwDKhiaDHLTlL86AzYT7nnf8dBiuGR+veHsflJttEmQFii8a9EIPpSuxrKwG7AO/wYtuJmT6MqQ5XWXV43qO/N+t6mKrpZYuKOF2CL9hHxfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775808684; c=relaxed/simple;
	bh=eFNKlU6BN3Qg8lcYQRoLu1p6oaJmRcs2oqeUQphcWgw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZdMv/fNUR8ci9HZfdrZYZ6mjGIcSoM+76mWPp0NNVHYxGWs+M6Mld3Lp1tDDi+u6qzrwWxrYSRVHuSPDG6tLw5Y4PbLBm9d+PSikgFco4OQbQsS56OzvVluOb+PeuyNqcCOuGstM26CMkTsCp3mStz54kaoVNB/YXExPIeK3iII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JU0rGwlE; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JU0rGwlE"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4852b81c73aso15930635e9.3
        for <linux-iio@vger.kernel.org>; Fri, 10 Apr 2026 01:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775808681; x=1776413481; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YOV62oQg08u1Yx/zt3MV8JzMI4cWJ9x82u8lWWrOUr4=;
        b=JU0rGwlEgKQ5wIY+3lSayhZf+vXhHfzAh9ebMSmPk/X5wWBUo+djVx9jdiTPoPUOeK
         wYVlpwQNZl0fuZeVIuWOydsC2rZtPaIbfuATve9jSQDVM26hebmjPEaZ+7LVEmTVLYP7
         fmmqA+87eefdZhN4IfadOPYLLcx+D6g74iyAVRZsL5340zRPP0MPVx0yTejB5OUAf/tq
         KjMMq3iuuShwcYrU3Li6Tov7y7An7NHv82Ymx/Y/E4QrziY7HtBGFvWUe52Fc+dm83K/
         XwcVYLN4tiUYyNtcn9uHflxiLlGALArGb+SINr4NM8hlry3xCzuXE6chnE8laFh0IpyH
         JRSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775808681; x=1776413481;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YOV62oQg08u1Yx/zt3MV8JzMI4cWJ9x82u8lWWrOUr4=;
        b=qGhXOz73OCFt2dkIjQyn/nrI45Cc5esrHNvnQXr19LOZf5L5+E7ELS8P7R3by32/Ue
         /rhFrX1HXtEumt00NZm05cdajbU98rvJXADBOjxrph7oHltVOLouqJndruwoaMBNbmfd
         pU8A/Sl2LTO5Gno3jKj0VjO2fjTlpgF5R3t1DT+8jhtIT+mrbeg14kNzoyGnRKCobA2O
         5sN4X9akmZTmsoYsb3Q5tAaurvAFKmzVXDfpwYACRWpAe1s1GuevgZD6ZI5G7wQ/V6K/
         2EzNxcFWKBx0F67WQ41kAEqaHlcY1cltGdu4eQC8XF2IQb7It90jCDBmDTLWB6kx/Fsj
         3FOg==
X-Forwarded-Encrypted: i=1; AJvYcCUcRST6vOdVlAQ8hotW+m651xSfdWmmsshreJvRJrDzq5RmI9m1iSe92Ua/m94kvEjz+kXgmOLCipg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZGYjhTU8Zx4CtOxQY6kFSZdPqDyng6cE18J6Fl6uLFr2N+7Z5
	5JiiHGg5D02tSUUT08GTlI44nBURuqsEAibvd/KeHpbEaKGuxELfy6fW
X-Gm-Gg: AeBDiev3yJCmAK85KsUCxYc4pzmw7RpvxcQjNbnIkykfub7o8dgqE3cMQV1OFHBbYza
	j82IUegP5VA6BIekoCRTbo7bPZZC/bz9NIuFhqgo9m7jx+7+wDZodCB4o8acmYosr2KptnJdSSD
	akDHWazvWSKoeQ9jwNgWbrxlg9Uo3oNZs0kyNRr6kGieJE5WJuoZaTkEfuXAKo00g9CRfz77BS2
	3wVosvCU4L4DrzI2HIDY7gAU5+xIQsNH6bVSH/nBbgUb9AtHFHsLdvYGl5aYanWhXOvCEZ8irxE
	DBowKFoEwyMzrZLsxiLk+cwxJkjFwOSVXZXSWRmlVYNGpk/eZmQlbXaf1BJ2U4PZ+XkA+WyaAy1
	dRZfUPArGivP9NBO2jwZjYJtkC8KOrm8GRtVht0PQLcO87qz+cqqDhrnc+dqSXTgT9Y9aZOSqWJ
	r9kBeRkfUFWYLeS12tC9XQT7Vu0aTryPo5/YQ4NxodpJjiW8E37cVhvwo1ACgS8Q4lN9uWpI9iT
	tc=
X-Received: by 2002:a05:600c:628b:b0:488:904b:f31 with SMTP id 5b1f17b1804b1-488d68603ffmr23646065e9.22.1775808681064;
        Fri, 10 Apr 2026 01:11:21 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d5b3cbb2sm57593325e9.13.2026.04.10.01.11.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 01:11:20 -0700 (PDT)
Date: Fri, 10 Apr 2026 09:11:19 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, lars@metafoo.de,
 Michael.Hennerich@analog.com, jic23@kernel.org, dlechner@baylibre.com,
 andy@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-staging@lists.linux.dev, Greg KH <gregkh@linuxfoundation.org>,
 nuno.sa@analog.com
Subject: Re: [PATCH] iio: frequency: ad983x: replace do_div() with
 div64_ul().
Message-ID: <20260410091119.117d0feb@pumpkin>
In-Reply-To: <CALoEA-xo04NZoZLboZ_RNg+m8QfCaDMrfNRb0cZwnE1DMp=8ng@mail.gmail.com>
References: <20260409131823.1289-1-joshua.crofts1@gmail.com>
	<20260409182755.499a419c@pumpkin>
	<CALoEA-yVCyyiA1gUCj4Z0JcLscpSSssPCPXnUPOciWJOHj3VUg@mail.gmail.com>
	<adh8zOCQDhGwgf0Y@ashevche-desk.local>
	<CALoEA-xo04NZoZLboZ_RNg+m8QfCaDMrfNRb0cZwnE1DMp=8ng@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 10 Apr 2026 08:58:10 +0200
Joshua Crofts <joshua.crofts1@gmail.com> wrote:

> On Fri, 10 Apr 2026 at 06:30, Andy Shevchenko
> <andriy.shevchenko@intel.com> wrote:
> > > The clk struct in linux/clk.h explicitly uses an unsigned long to represent
> > > the clock value, which is used in this driver. Using an unsigned long
> > > ensures platform independent usage without type mismatching.  
> >
> > ...which effectively means the frequency most likely fits 32-bit. Otherwise
> > would it ever work on 32-bit platform? This is a mistake in CLK design.  
> 
> So we keep the do_div() macro and cast mclk to u32.
> 

There is no need for a cast, just ignore coccineal.

	David
