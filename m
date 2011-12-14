Return-Path: <lars@metafoo.de>
Message-ID: <4EE8BB28.3060807@metafoo.de>
Date: Wed, 14 Dec 2011 16:05:12 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Dan Carpenter <dan.carpenter@oracle.com>
CC: Greg KH <greg@kroah.com>, devel@driverdev.osuosl.org,
 linux-iio@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>,
 Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH] staging:iio: Add wrapper functions around buffer access
 ops
References: <1323684526-11134-1-git-send-email-lars@metafoo.de> <20111213004506.GA11553@kroah.com> <4EE7145F.9040003@metafoo.de> <20111213235926.GA23916@kroah.com> <4EE87755.3000000@metafoo.de> <20111214143144.GL3503@mwanda>
In-Reply-To: <20111214143144.GL3503@mwanda>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On 12/14/2011 03:31 PM, Dan Carpenter wrote:
> On Wed, Dec 14, 2011 at 11:15:49AM +0100, Lars-Peter Clausen wrote:
>> Marking the function as __must_check doesn't make much sense here. Since it
>> will either return an error or the buffer length. So you'll always use the
>> returned result one way or the other.
> 
> Isn't that the point of a __must_check?

My understanding is that you should use __must_check if it is potentially
dangerous to ignore the return value. Which is not the case here, if you
don't look at the return value it's kind of pointless to call the function
in the first, but it is not dangerous.

- Lars
