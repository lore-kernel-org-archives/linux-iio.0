Return-Path: <amit.kucheria@verdurent.com>
Date: Tue, 27 Sep 2011 17:59:07 +0300
From: Amit Kucheria <amit.kucheria@verdurent.com>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"Hennerich, Michael" <Michael.Hennerich@analog.com>,
	Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
Subject: Re: IIO: ownership of patches taking drivers out of staging.
Message-ID: <20110927145907.GA2580@matterhorn1>
References: <4E81D071.5050806@cam.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <4E81D071.5050806@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

On 11 Sep 27, Jonathan Cameron wrote:
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

Yes, that'd be fine. I'll try to test out the changes/moves as we go but I
won't be close to HW and a reliable internet connection over the next few
weeks.

/Amit
