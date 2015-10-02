Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:24724 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750848AbbJBIcb (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 2 Oct 2015 04:32:31 -0400
Date: Fri, 2 Oct 2015 11:32:24 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Crt Mori <cmo@melexis.com>
Cc: linux-iio@vger.kernel.org
Subject: Re: iio: mlx90614: Implement filter configuration
Message-ID: <20151002083224.GJ7289@mwanda>
References: <20151001221609.GA3694@mwanda>
 <CAKv63usH0CoupUtoAsGjUXUojCJ9sCbK9cN85rz3SS8C0QUWLw@mail.gmail.com>
 <20151002070006.GI7289@mwanda>
 <CAKv63uuxuKJ5QY_jpxVe895+AMhyxWWrCWim6BgeB8kLsoNB-A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAKv63uuxuKJ5QY_jpxVe895+AMhyxWWrCWim6BgeB8kLsoNB-A@mail.gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, Oct 02, 2015 at 10:12:01AM +0200, Crt Mori wrote:
> > It looks a little more readable without any casts and it works exactly
> > the same since the casts were just for decoration.
> >
> 
> Like I said they are on most processors, but might not be on others.

And monkeys *might* fly out of my butt.

> I rather have it defined than let compiler decide

Focus on writing simple code and not making it portable for time
travellers to 1980.

> 
> >         ret = mlx90614_write_word(client, MLX90614_CONFIG,
> >                                   (i << MLX90614_CONFIG_IIR_SHIFT) |
> >                                   ((0x7 << MLX90614_CONFIG_FIR_SHIFT) |
> >                                    (ret & ~MLX90614_CONFIG_FIR_MASK) &
> >                                    (~MLX90614_CONFIG_IIR_MASK)));
> >
> > The 0x7 is a magic number.  I would think it would be a named _MASK
> > macro.  Ah, we do have a macro for that.
> 
> That macro is for mask and it is just coincidence that they are the
> same. I would like to keep the
> way it is in case someone wants to change FIR values as well.

Did you read the rest of the email?  This code make no sense.  We know
that it has never been tested since the earlier ret test was inverted so
it was unreachable.  Why are you defending something that is so clearly
wrong?  Anyway get rid of the magic number at least.

regards,
dan carpenter

