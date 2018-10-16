Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtprelay0087.hostedemail.com ([216.40.44.87]:49631 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726703AbeJQHAl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 17 Oct 2018 03:00:41 -0400
Message-ID: <d00fec12b481f17ce6e844d86be56b5f12bdb0b1.camel@perches.com>
Subject: Re: [PATCH] staging: iio: ad7280a: Lines should not end with a '('
 - style
From: Joe Perches <joe@perches.com>
To: Giuliano Belinassi <giuliano.belinassi@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Date: Tue, 16 Oct 2018 16:07:58 -0700
In-Reply-To: <CAG4RSAFMGSFyUqutRD2SRMsBt5RHVo5RUQsBq7fis6OVWxSZbg@mail.gmail.com>
References: <20181016210950.cmx4r4pb2yg5ofpp@smtp.gmail.com>
         <5717d448daad72d7eb142732ca88e9ed30854088.camel@perches.com>
         <CAG4RSAFMGSFyUqutRD2SRMsBt5RHVo5RUQsBq7fis6OVWxSZbg@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

(There is a linux-usp@googlegroups.com mailing list
that bounces when I reply, so I removed it from the
cc list)

On Tue, 2018-10-16 at 19:48 -0300, Giuliano Belinassi wrote:
> Hello,
>     Thank you for your review :-).
>     Sorry, but I am a newbie on this, and now I am confused about my next
> step. Should I make a v2 based on your changes, or do you want to submit
> your changes?

I wrote that to encourage you to do more than
what checkpatch says.

I just moved code around and reduced duplication.

There are many similar opportunities for code
refactoring in staging.

You could test what I wrote, add a good commit
message with a subject like:

[PATCH V2] staging: iio: ad7280a: Refactor <functionname>

with a commit message that describes the changes and
perhaps shows the object size difference using

$ size <old> <new>

Maybe add a Suggested-by: tag if it pleases you, but
what I did is trivial and I think it's unnecessary.

Are you doing this for a class assignment?
