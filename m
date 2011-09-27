Return-Path: <manuel.stahl9cd33xy531iis.fraunhofer.de@bounce.antispameurope.com>
From: Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Subject: Re: IIO: ownership of patches taking drivers out of staging.
Date: Tue, 27 Sep 2011 15:34:09 +0200
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "Hennerich, Michael" <Michael.Hennerich@analog.com>,
 Amit Kucheria <amit.kucheria@verdurent.com>
References: <4E81D071.5050806@cam.ac.uk>
In-Reply-To: <4E81D071.5050806@cam.ac.uk>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201109271534.09628.manuel.stahl@iis.fraunhofer.de>
List-ID: <linux-iio@vger.kernel.org>

Hi Jonathon,

I'm fine with that. Of course we could also change ownership for adis16400 to 
Michael, as I don't have the time to actively support this one.
I have a few others in the pipeline (lis331dlh, itg3200) that I will publish 
as soon as we have a stable API in mainline.

Regards,
Manuel

Am Dienstag, 27. September 2011, 15:32:33 schrieb Jonathan Cameron:
> Hi All,
> 
> I'm putting together a patch set to propose the first step in moving
> IIO out of the staging tree.
> 
> I want to take a small set (initially) of representative drivers
> along for the ride.
> 
> Now unlike later elements which will consist of git moves (and hence
> preserve history) those that come with us now will be done by
> stripping down the drivers and then building their feature set
> back up as we go.
> 
> My question here is whether people are happy if I assign authorship
> of patches for their drivers to them (with appropriate note and
> sign off from me to explain where they came from).
> 
> Right now my example set consists of
> 
> ad799x - Michael's
> max1363 - mine :)
> tsl2583 - Amit's
> adis16400 - Manuel's but with large bits from drivers of mine
> 	    and Barry Song. I'm fine with it being Manuel's.
> 	    Copyright notice covers that some of it is Analog's
> 	    so, Michael, is that fine with you guys?
> 
> So I need responses from Amit, Michael and Manuel as to whether
> they mind me setting author of relevant drivers to them?  I'd
> obviously also like sign offs once you have had time to look
> at them. I'll post an updated tree shortly to github.
> 
> Thanks,
> 
> Jonathan
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
