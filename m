Return-Path: <dan.carpenter@oracle.com>
Date: Wed, 19 Oct 2016 15:54:23 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Brian Masney <masneyb@onstation.org>
Cc: devel@driverdev.osuosl.org, lars@metafoo.de, linux-iio@vger.kernel.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        pmeerw@pmeerw.net, knaack.h@gmx.de, jic23@kernel.org
Subject: Re: [PATCH 5/7] iio: light: tsl2583: check return values from
 taos_chip_{on, off}
Message-ID: <20161019125423.GL4469@mwanda>
References: <1476873130-24926-1-git-send-email-masneyb@onstation.org>
 <1476873130-24926-5-git-send-email-masneyb@onstation.org>
 <20161019112249.GH4469@mwanda>
 <20161019124832.GB6741@basecamp.onstation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161019124832.GB6741@basecamp.onstation.org>
List-ID: <linux-iio@vger.kernel.org>

On Wed, Oct 19, 2016 at 08:48:32AM -0400, Brian Masney wrote:
> Ok, I'll rework my patch series to stick with the direct returns. I
> personally prefer that approach. I was using the gotos since I thought
> that was standard convention in the kernel.
> 

It *should* but "goto unlock;"  When you can tell what the goto does,
that's great.  But these gotos don't do anything so by definition the
names are going to be meaningless.

regards,
dan carpenter
