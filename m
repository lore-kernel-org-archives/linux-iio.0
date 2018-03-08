Return-Path: <SRS0=wpQW=F6=gmail.com=himanshujha199640@kernel.org>
Date: Thu, 8 Mar 2018 12:58:19 +0530
From: Himanshu Jha <himanshujha199640@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
	pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
	linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org, daniel.baluta@gmail.com
Subject: Re: [PATCH 10/11] Staging: iio: accel: Add comments about units in
 data read function
Message-ID: <20180308072819.GA24090@himanshu-Vostro-3559>
References: <1520236170-14668-1-git-send-email-himanshujha199640@gmail.com>
 <1520236170-14668-11-git-send-email-himanshujha199640@gmail.com>
 <20180307205030.11fff428@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180307205030.11fff428@archlinux>
List-ID: <linux-iio@vger.kernel.org>

On Wed, Mar 07, 2018 at 08:50:30PM +0000, Jonathan Cameron wrote:
> On Mon,  5 Mar 2018 13:19:29 +0530
> Himanshu Jha <himanshujha199640@gmail.com> wrote:
> 
> > Clarify the conversion and formation of resultant data in the
> > adis16201_read_raw() with sufficient comments.
> > 
> > Signed-off-by: Himanshu Jha <himanshujha199640@gmail.com>
> This is fine but it needs to be in the original comment changing patch
> rather than removing the comments first then a few patches later putting
> back a different version.
> 
> So good change but in the wrong place in the series.  Learning to reorder
> a series and merge down multiple patches into one is very useful when
> working with git.

I will send v2 with all the updates!

What about sign_extend32 & reverse christmas ordering patch ? Will you
pick that up or shall I send them again ?

-- 
Thanks
Himanshu Jha
