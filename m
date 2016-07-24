Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58827 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752223AbcGXLhk (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 24 Jul 2016 07:37:40 -0400
Subject: Re: resource managed pollfunc
To: Gregor Boirie <gregor.boirie@parrot.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
References: <578E4517.7040808@parrot.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <b472ad18-4a42-66c1-f55d-5574f526bc4c@kernel.org>
Date: Sun, 24 Jul 2016 12:37:37 +0100
MIME-Version: 1.0
In-Reply-To: <578E4517.7040808@parrot.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 19/07/16 16:19, Gregor Boirie wrote:
> Dear all,
> 
> I'm wondering why there are no resource managed versions of
> iio_triggered_buffer_setup and iio_alloc_pollfunc.
> 
> Any particular reason ??
No one got around to it?

The triggered buffer one is a little bit non trivial a it
does a good deal of it's own allocating.

It's not immediately obvious whether such a devm call should
just make devm calls itself, or should use it's own unwind.

I think I'd prefer the making devm calls itself, though that
would obviously lead to perhaps more code duplication as
you'd also need an explicit unwind version.

Any other similar situations than anyone can think of
to give us a precedent on how to handle this?

Jonathan
> 
> Regards,
> Greg
> -- 
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

