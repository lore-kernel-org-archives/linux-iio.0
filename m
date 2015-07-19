Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.15]:49921 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753621AbbGSTyr (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sun, 19 Jul 2015 15:54:47 -0400
Message-ID: <55AC0079.9060507@gmx.de>
Date: Sun, 19 Jul 2015 21:54:33 +0200
From: Hartmut Knaack <knaack.h@gmx.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Daniel Baluta <daniel.baluta@intel.com>
Subject: Re: IIO : Clarifying review tags.
References: <55ABBFE8.4090108@kernel.org>
In-Reply-To: <55ABBFE8.4090108@kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Jonathan Cameron schrieb am 19.07.2015 um 17:19:
> Hi All,
> 
<...> 
> Our standard tags;
> 
> Signed-off-by:
> 	This is part of the developer certificate of origin
> stuff.  If you sign-off you are making an explicit statement
> that either you wrote the code or it passed through your
> hands and to the best of your knowledge you are not breaking
> license terms etc (this includes me for example certifying
> that I have made no changes that would invalidate earlier
> sign offs) This is the one with some legal meaning
> and I think we are all using it correctly (just here for
> completeness).
> 
> Note that this also either implies that you have 'reviewed'
> the code in detail, or that you are happy that the deep
> review has already been done by someone you trust.

Hi,
call me paranoid, but I would feel better if you would still
review in all cases. To load off some weight from your
shoulders I would recommend to change the workflow a bit in the
sense that you hold back on reviews until a patch has either
received an acked/reviewed-by tag or an appropriate amount of
time has passed (maybe a week). Then you should still do a very
suspicious review before taking in that change.
Thus, you could focus more on the details and would not have to
deal with early respins.

> (and it's this last bit that lets the Linux development
> process scale).  There is a pretty universal view that
> you don't bother with both signed-off-by and any other tag
> (though tested-by can be appropriate in my view).
> 
<...>

I'm fine with the Acked-by and Tested-by stuff.

> Reviewed-by:
> 	Now this is the one that caused most discussion in the
> previously mentioned thread.  When is it appropriate?
> 
> 1) When substantial work has been applied as part of a review.
>    This might be indicated by a series of suggested changes
>    or by detailed comments on what they think is good / bad
>    might be done differently.   In these cases the reviewer
>    may 'suggest' the tag themselves.
> 
> 2) Where earlier versions of a patch have received substantial
>    review but the reviewer has not commented on the latest
>    version.  In this case some maintainers have been giving
>    'Reviewed-by' tags to people who haven't supplied them
>    on their own.  This is the change I would like to make to
>    how I have done things previously (where when I had time
>    I pestered people to give a reviewed-by).
> 
>    A few of you delight in early stage reviews and I feel often
>    get little or no permanent credit for your hard work.
>    In particular there are some here who spend a lot of time
>    helping new submitters get large patches in order.  A job
>    that can take a huge amount of work on occasion!
> 
>    So does anyone object if I sometimes add Reviewed-by tags
>    for them?  Obviously this is all going to be a little
>    arbitrary so do keep sending them directly (and authors
>    keep adding them to later versions of your patches!)
>  

I'm in favor of using the Reviewed-by tag rather restrictive.
IMHO it expresses that the reviewer was able to understand the
change in its full extend. This may include to check all
device specific parameters used against a data sheet (if the
data sheet is not available due to NDA, then I would not want
to give this tag), check each line of code, check fixes against
the source code block it applies to (or even parent level
blocks if required). As a result, it should indicate that the
patch has successfully passed certain quality checks of the
reviewer. This in turn gives appreciaction to the patch author.
The reviewers reputation however can suffer, if significant
bugs slipped through the review. That's why I don't feel too
comfortable if anyone else gives reviewed-by tags in my name.
Clearly, there is a gap in between the acked-by and reviewed-by
tags, something that would express your contribution in the
development process.

> Anyhow, the thread that lead to this has yet again reminded
> me of how lucky I am and we all are in IIO wrt to the quality
> and quantity of reviewers who put huge amounts of time into
> improving all our code!
> 
> I certainly know I would have burnt out long ago if it was
> just me against the mountain.
> 
> I'm going to be on holiday week after next. Should get back
> to normal in early August.

Enjoy!

Hartmut

> 
> Thanks,
> 
> Jonathan
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

