Return-Path: <SRS0=uV9Z=GD=gmail.com=himanshujha199640@kernel.org>
Date: Tue, 13 Mar 2018 21:54:54 +0530
From: Himanshu Jha <himanshujha199640@gmail.com>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: potentiometer: ds1803: remove VLA usage
Message-ID: <20180313162454.GA8769@himanshu-Vostro-3559>
References: <20180313152343.GA31789@embeddedgus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180313152343.GA31789@embeddedgus>
List-ID: <linux-iio@vger.kernel.org>

Hi Gustavo,

On Tue, Mar 13, 2018 at 10:23:43AM -0500, Gustavo A. R. Silva wrote:
> In preparation to enabling -Wvla, remove VLA. In this particular
> case use macro ARRAY_SIZE so the length of array _result_ can be
> computed at preprocessing time.
> 
> The use of stack Variable Length Arrays needs to be avoided, as they
> can be a vector for stack exhaustion, which can be both a runtime bug
> or a security flaw. Also, in general, as code evolves it is easy to
> lose track of how big a VLA can get. Thus, we can end up having runtime
> failures that are hard to debug.
> 
> Also, fixed as part of the directive to remove all VLAs from
> the kernel: https://lkml.org/lkml/2018/3/7/621
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---

It is already applied as I had sent the patch few days ago.
https://lkml.org/lkml/2018/3/10/164

I specifically CC'ed you and Kees to avoid the patch collisions.

-- 
Thanks
Himanshu Jha
