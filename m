Return-Path: <jic23@cam.ac.uk>
Message-ID: <4E456051.9070906@cam.ac.uk>
Date: Fri, 12 Aug 2011 18:18:09 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: iio-blue.git reorganization.
References: <4E45563D.4090204@cam.ac.uk>
In-Reply-To: <4E45563D.4090204@cam.ac.uk>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 08/12/11 17:35, Jonathan Cameron wrote:
> This dev tree as I warned is not stable.  It's more or less
> a dump of my local working tree.
> 
> As such I hope no one minds the wholesale reorganization I've just
> pushed out to kernel.org.  Basically I've sorted patches
> into fixes / cleanups1 / chan spec conversions / cleanups2 / controversial bits / other stuff.
> 
> fixes and cleanups1 have gone to Greg for now.
I got bored and sent on chan spec conversions (as they have all been
around for ages) and cleanups2 (also been around for ages).  Also
included the adis16344 support patch whilst at it.

So just the controversial stuff left in my tree if Greg merges the lot
without issue.

> 
> The controversial bits are:
> 
> * trigger rework to make removal safe.
> 
> * chrdevs merging into one.
> 
> * in_ out_ prefix on channnels.
> 
> * endian description addition.
> 
> * extend scan_mask and event codes to allow for more channels.
> 
> Comments on anything and everything welcome!
> 
> 
> Jonathan
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
