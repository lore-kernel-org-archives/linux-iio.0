Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:48148 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932582Ab3BIVHR (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 9 Feb 2013 16:07:17 -0500
Message-ID: <5116BA7C.8020201@kernel.org>
Date: Sat, 09 Feb 2013 21:07:08 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Denis Ciocca <denis.ciocca@gmail.com>
CC: lars@metafoo.de, linux-iio@vger.kernel.org
Subject: Re: Proposal to add full scale attribute
References: <1360431297-18251-1-git-send-email-denis.ciocca@st.com>
In-Reply-To: <1360431297-18251-1-git-send-email-denis.ciocca@st.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 02/09/2013 05:34 PM, Denis Ciocca wrote:
> I everyone,
> 
> my patch (not working) is a proposal to add full scale attribute to change
> the current full scale for devices. The patch doesn't work because the function
> for_each_set_bit in the industrialio-core.c use the type unsigned long and
> the new entry is too big. However, what do you think about?
> 
> Thanks,
> 
> Denis

Hi Denis,

What you propose has come up a number of times before (and
is present I think as 'range' in a number of drivers still in staging)

We did have a brief discussion a while ago about how to handle describing
the possible range of channels and off controls on channels.
One thing I suggested at the time (but have done nothing about since)
was that we should actually have descriptions of the possible values
of all elements of iio_info (including raw channel readings).
The discussion was deep in a thread on something else so I won't
try and dig it out now.

Up shot was something like

1) have an additional callback in struct iio_info along the lines of:
	int (*read_avail)(struct iio_dev *indio_dev,
		          struct iio_chan_spec const *chan,
			  int **vals,
			  long mask);
(return type indicates what vals is filled with).  Typically it'll be
returning a pointer to a static array to avoid leaking memory.  Otherwise
some care will be needed in drivers.

2) For all iio_info elements there will be additional attributes to effectively
access pretty printed versions of the output of this callback.

in_accel_raw_availble
in_accel_scale_available
...
(or similar).

These would be read only and describe the possible values the associated
output (e.g. in_accel_raw) can take.

To make up some syntax how about
[0...255] or {0, 13, 33} to indicate a range, or a small set of possible
values?

The in_accel_raw_available in conjunction with in_accel_scale would then
effectively give your full range but also a lot of other useful information.

As I stated earlier, we have had a range attribute proposed in the past
(and is in some staging drivers) which is I think similar to your proposed
full scale attribute.
The issue I always had with it is that we then end up with the question of
which should be controllable, scale or range?  Scale is important for
processing the data, but people like to see full scale as well.

You touch on efficiency of writing full scale in the patch. I am afraid
I don't follow what you mean by that. Could you explain?  Setting these
values is never in the fast path and in the vast majority of cases the
conversion from one to the other is trivial.

What do you think?

Thanks for pointing out that we were out of space in the mask. I've been
meaning to do something about that for a while.  One obvious option is
to split the shared and separate masks up into a pair with the fields just
defined in the appropriate one. Any other simple options occur to anyone?

Jonathan
