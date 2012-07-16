Return-Path: <ggao@invensense.com>
From: Ge Gao <ggao@invensense.com>
References: <5003D02D.10601@kernel.org>
In-Reply-To: <5003D02D.10601@kernel.org>
MIME-Version: 1.0
Date: Mon, 16 Jul 2012 10:04:01 -0700
Message-ID: <ebb72e8221e1731a0fe33cb7ad510e05@mail.gmail.com>
Subject: RE: IIO 3.6 merge window now closed.
To: Jonathan Cameron <jic23@kernel.org>, linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

Dear Jonathan,
	There is some bugs I have fixed for Kfifo. I am not sure whether
it is already fixed by anyone else. Where can I see the latest code for
Kfifo? The rc5 does not even include your fix about poll. I guess it is
not "latest" enough. There are also  two directories for IIO. One is under
staging and one is not. Clearly none of them works well since it lacks a
lot of files/defines.

	Thanks.
Best Regards,

Ge GAO


-----Original Message-----
From: linux-iio-owner@vger.kernel.org
[mailto:linux-iio-owner@vger.kernel.org] On Behalf Of Jonathan Cameron
Sent: Monday, July 16, 2012 1:26 AM
To: linux-iio
Subject: IIO 3.6 merge window now closed.

Hi All,

As Linus has pretty much said he won't do another release candidate, the
3.6 merge window will open in approximately
1 week. For IIO I'm copying Greg's policy with staging (for obvious
reasons ;) and closing our merge window now.
Rather tediously this means cutting a few of my own patches off. Oh well
got to be fair about things and I'll have those queued up for 3.7 nice and
early!

Obviously fixes can still get queued up for 3.6, but will probably not go
upstream until after 3.6-rc1.  As ever, please make sure that fixes are
entirely separate from improvements / feature enhancements / new drivers.

Jonathan
--
To unsubscribe from this list: send the line "unsubscribe linux-iio" in
the body of a message to majordomo@vger.kernel.org More majordomo info at
http://vger.kernel.org/majordomo-info.html
