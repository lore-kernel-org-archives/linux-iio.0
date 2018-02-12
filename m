Return-Path: <SRS0=CFMa=FG=oracle.com=dan.carpenter@kernel.org>
Date: Mon, 12 Feb 2018 17:57:31 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Himanshu Jha <himanshujha199640@gmail.com>
Cc: devel@driverdev.osuosl.org, lars@metafoo.de, Michael.Hennerich@analog.com,
        linux-iio@vger.kernel.org, gregkh@linuxfoundation.org,
        21cnbao@gmail.com, linux-kernel@vger.kernel.org, pmeerw@pmeerw.net,
        knaack.h@gmx.de, jic23@kernel.org
Subject: Re: [PATCH 2/4] staging: iio: accel: Remove unnecessary comments and
 add suitable suffix
Message-ID: <20180212145731.kws25sjinzqq6ax6@mwanda>
References: <1518436499-8584-1-git-send-email-himanshujha199640@gmail.com>
 <1518436499-8584-3-git-send-email-himanshujha199640@gmail.com>
 <20180212125312.cjo76spuu6agjawc@mwanda>
 <20180212143522.GA12142@himanshu-Vostro-3559>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180212143522.GA12142@himanshu-Vostro-3559>
List-ID: <linux-iio@vger.kernel.org>

On Mon, Feb 12, 2018 at 08:05:22PM +0530, Himanshu Jha wrote:
> But these should be done when we have *more* instances.
> 
> For eg: 
> I added a tab space in function static int adis16201_read_raw() argument
> to match open parentheses in this patch. But I also added tabs while
> removing and adding suitable suffix to the macros. So, should it also be
> done in a separate patch ?

If you're changing a line of code and you fix a white space issue on
that same line, then that's fine.  If it's just in the same function,
then do it in a separate patch.  In other words, adding tabs when you're
moving around macros is fine, but adding it to the arguments is
unrelated.

This patch was honestly pretty tricky to review.

Jonathan assumes reviewers have the datasheet in front of them and I
assume that that they don't.  He's probably right...  But especially
comments like this:

		*val2 = 220000; /* 1.22 mV */

They seem really helpful to me.

regards,
dan carpenter
