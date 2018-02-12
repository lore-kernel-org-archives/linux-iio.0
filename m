Return-Path: <SRS0=sxJY=FG=gmail.com=himanshujha199640@kernel.org>
Date: Tue, 13 Feb 2018 01:16:05 +0530
From: Himanshu Jha <himanshujha199640@gmail.com>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: devel@driverdev.osuosl.org, lars@metafoo.de,
	Michael.Hennerich@analog.com, linux-iio@vger.kernel.org,
	gregkh@linuxfoundation.org, 21cnbao@gmail.com,
	linux-kernel@vger.kernel.org, pmeerw@pmeerw.net, knaack.h@gmx.de,
	jic23@kernel.org
Subject: Re: [PATCH 2/4] staging: iio: accel: Remove unnecessary comments and
 add suitable suffix
Message-ID: <20180212194604.GB15335@himanshu-Vostro-3559>
References: <1518436499-8584-1-git-send-email-himanshujha199640@gmail.com>
 <1518436499-8584-3-git-send-email-himanshujha199640@gmail.com>
 <20180212125312.cjo76spuu6agjawc@mwanda>
 <20180212143522.GA12142@himanshu-Vostro-3559>
 <20180212145731.kws25sjinzqq6ax6@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180212145731.kws25sjinzqq6ax6@mwanda>
List-ID: <linux-iio@vger.kernel.org>

On Mon, Feb 12, 2018 at 05:57:31PM +0300, Dan Carpenter wrote:
> On Mon, Feb 12, 2018 at 08:05:22PM +0530, Himanshu Jha wrote:
> > But these should be done when we have *more* instances.
> > 
> > For eg: 
> > I added a tab space in function static int adis16201_read_raw() argument
> > to match open parentheses in this patch. But I also added tabs while
> > removing and adding suitable suffix to the macros. So, should it also be
> > done in a separate patch ?
> 
> If you're changing a line of code and you fix a white space issue on
> that same line, then that's fine.  If it's just in the same function,
> then do it in a separate patch.  In other words, adding tabs when you're
> moving around macros is fine, but adding it to the arguments is
> unrelated.

I will try and divide my patches next time :)

> This patch was honestly pretty tricky to review.

I am sorry for that. Might be easy for IIO reviewers ;)

> Jonathan assumes reviewers have the datasheet in front of them and I
> assume that that they don't.  He's probably right...  But especially
> comments like this:
> 
> 		*val2 = 220000; /* 1.22 mV */

They are pretty obvious as you can see from the return statements
just below that which is :

		return IIO_VAL_INT_PLUS_MICRO;

These comments are obvious because we know 'val1' will be responsible
for Integer part(1.0) and 'val2' for the Micro part(220000 * 10^-6 = 0.22).
Isn't it ?

Although I am new to IIO please correct if I'm wrong.

-- 
Thanks
Himanshu Jha
