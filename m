Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:48128 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752653AbbGSPTH (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 19 Jul 2015 11:19:07 -0400
Message-ID: <55ABBFE8.4090108@kernel.org>
Date: Sun, 19 Jul 2015 16:19:04 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Hartmut Knaack <knaack.h@gmx.de>
Subject: IIO : Clarifying review tags.
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi All,

The primary aim of this email is that I'd like to
improve the quality of credit that we are giving people
for the vital job or reviewing patches.

This is a quick(ish) email to try and clear up my interpretation
of when various review tags are appropriate.  This follows
on from a discussion as part of the kernel summit pre
discussion.  In particular, one issue that was raised there
was how to give credit where credit is due for reviews.

There are some proposals to add the option for patch
authors to explicitly credit anyone who pointed out bugs
in their earlier versions, but those may or may not come
to anything.  There may well be a formal statement from
the kernel summit (probably a clarification to
submittingpatches) but then there may be no clear opinion
and as with many kernel aspects it will be left to
individual maintainers.

Anyhow, another aspect was the uses various maintainers
are making of Acked-by vs Reviewed-by.  As such I thought
I would clarify my understanding (which has changed somewhat
as a result of those discussions).  Comments of course most
welcome!

Our standard tags;

Signed-off-by:
	This is part of the developer certificate of origin
stuff.  If you sign-off you are making an explicit statement
that either you wrote the code or it passed through your
hands and to the best of your knowledge you are not breaking
license terms etc (this includes me for example certifying
that I have made no changes that would invalidate earlier
sign offs) This is the one with some legal meaning
and I think we are all using it correctly (just here for
completeness).

Note that this also either implies that you have 'reviewed'
the code in detail, or that you are happy that the deep
review has already been done by someone you trust.
(and it's this last bit that lets the Linux development
process scale).  There is a pretty universal view that
you don't bother with both signed-off-by and any other tag
(though tested-by can be appropriate in my view).

Acked-by: 
	This is kind of a looks fine to me / I am happy with this
tag.  Has a couple of common uses:

1) Driver author / maintainer is saying they are happy with
someone else's change.  Note this includes me as IIO maintainer
saying I am happy for another maintainer to apply stuff to the
IIO tree (where cross subsystem series make this sensible).

2) For small changes where 'review' is not really relevant.
   e.g. Typo fixes.

Must be provided by the person who wishes to express this
opinion (note the difference from reviewed by below).

Tested-by:
	Does what is says on the tin.  If you have the hardware
and run a new patch to check it works then send a tested-by.
Note that it is absolutely encouraged to send a tested-by
and an ack/reviewed by.  I always want more tested-by:s as
they give me a warm fuzzy feeling about a patch. If someone
informally mentions they tested something I'll normally poke
them to give the tag as well.

Reviewed-by:
	Now this is the one that caused most discussion in the
previously mentioned thread.  When is it appropriate?

1) When substantial work has been applied as part of a review.
   This might be indicated by a series of suggested changes
   or by detailed comments on what they think is good / bad
   might be done differently.   In these cases the reviewer
   may 'suggest' the tag themselves.

2) Where earlier versions of a patch have received substantial
   review but the reviewer has not commented on the latest
   version.  In this case some maintainers have been giving
   'Reviewed-by' tags to people who haven't supplied them
   on their own.  This is the change I would like to make to
   how I have done things previously (where when I had time
   I pestered people to give a reviewed-by).

   A few of you delight in early stage reviews and I feel often
   get little or no permanent credit for your hard work.
   In particular there are some here who spend a lot of time
   helping new submitters get large patches in order.  A job
   that can take a huge amount of work on occasion!

   So does anyone object if I sometimes add Reviewed-by tags
   for them?  Obviously this is all going to be a little
   arbitrary so do keep sending them directly (and authors
   keep adding them to later versions of your patches!)
 
Anyhow, the thread that lead to this has yet again reminded
me of how lucky I am and we all are in IIO wrt to the quality
and quantity of reviewers who put huge amounts of time into
improving all our code!

I certainly know I would have burnt out long ago if it was
just me against the mountain.

I'm going to be on holiday week after next. Should get back
to normal in early August.

Thanks,

Jonathan

