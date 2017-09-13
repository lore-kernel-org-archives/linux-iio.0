Return-Path: <SRS0=QQTE=AO=oracle.com=dan.carpenter@kernel.org>
Date: Wed, 13 Sep 2017 11:12:21 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Himanshi Jain <himshijain.hj@gmail.com>
Cc: outreachy-kernel@googlegroups.com, lars@metafoo.de,
        Michael.Hennerich@analog.com, jic23@kernel.org, knaack.h@gmx.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, nick.desaulniers@gmail.com,
        daniel.baluta@gmail.com
Subject: Re: [PATCH 2/2] iio: Use __ATTR_NAMED to allow passing name as
 string to IIO_DEVICE_ATTR_NAMED and change usage to pass string
Message-ID: <20170913081221.udzpojijvm44ht45@mwanda>
References: <cover.1505288677.git.himshijain.hj@gmail.com>
 <2bc7a124ab925dd2c50aa8c778745d179777d50d.1505288677.git.himshijain.hj@gmail.com>
 <490606d70335e84a09ef418cb3cc0dbee6f79c84.1505288677.git.himshijain.hj@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <490606d70335e84a09ef418cb3cc0dbee6f79c84.1505288677.git.himshijain.hj@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

On Wed, Sep 13, 2017 at 01:26:27PM +0530, Himanshi Jain wrote:
> Add IIO_ATTR_NAMED macro to use __ATTR_NAMED to allow passing name as
> string to IIO_DEVICE_ATTR_NAMED. Change current usage of
> IIO_DEVICE_ATTR_NAMED to pass name as string.
> 
> Signed-off-by: Himanshi Jain <himshijain.hj@gmail.com>

This version looks nice.  The subject is just *way* too long, though.
Also you have put a v2 in the subject and a little changelog after the
--- cut off.  Just call it something like:
[PATCH 2/2 v2] iio: Change to __ATTR_NAMED()

regards,
dan carpenter
