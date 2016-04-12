Return-Path: <leonard.crestez@intel.com>
To: Peter Meerwald-Stadler <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
 Daniel Baluta <daniel.baluta@intel.com>
From: Crestez Dan Leonard <leonard.crestez@intel.com>
Subject: IIO driver for si114x
Message-ID: <570CDFD0.7060702@intel.com>
Date: Tue, 12 Apr 2016 14:45:20 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-iio@vger.kernel.org>

Hello,

I want to add support for a si1145 light sensor. Some brief googling 
finds a bunch of old (2012) patches for an si114x driver in 
drivers/iio/light. Here's the link to the old thread:

http://comments.gmane.org/gmane.linux.kernel.iio/5478

I did not find any reference to si114x in the main kernel tree so it 
seems to me that it was never actually included. There are a bunch of 
other out-of-tree drivers I found searching the web but they don't seem 
to be IIO drivers so are not interesting.

I'm willing to do the work to get support for this in upstream. I guess 
the best way to do that would be to apply the most recent source I can 
find to my local tree, test it on my device and repost on the list for 
review, right? I can't find anything newer than 2012 though.

As far as I can tell there at are two sets of device models: 
Si1141/42/43 and 45/46/47 with similar datasheets:

https://www.silabs.com/Support%20Documents/TechnicalDocs/Si114x.pdf
https://www.silabs.com/Support%20Documents/TechnicalDocs/Si1145-46-47.pdf

I only have a Si1145 device so I can't test support for si1141/42/43.

--
Regards,
Leonard
