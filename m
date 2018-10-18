Return-Path: <SRS0=KjQi=M6=poczta.fm=sst@kernel.org>
Date: Thu, 18 Oct 2018 20:06:01 +0200
From: Slawomir Stepien <sst@poczta.fm>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Michael.Hennerich@analog.com, jic23@kernel.org, knaack.h@gmx.de,
	pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
	gregkh@linuxfoundation.org
Subject: Re: [PATCH v2 1/1] staging: iio: adc: ad7280a: use crc8.h API to
 build crc table
Message-ID: <20181018180601.GA32323@x220.localdomain>
References: <20181018114915.GA30276@x220.localdomain>
 <ef781380-2306-fb2a-8a9c-f95b23e59b0e@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <ef781380-2306-fb2a-8a9c-f95b23e59b0e@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>

On paź 18, 2018 19:31, Lars-Peter Clausen wrote:
> On 10/18/2018 01:49 PM, Slawomir Stepien wrote:
> > The custom build function ad7280_crc8_build_table is not needed. The
> > crc8_populate_msb function from linux/crc8.h will build the same crc
> > table.
> > 
> > Signed-off-by: Slawomir Stepien <sst@poczta.fm>
> 
> This looks good, thanks.
> 
> Acked-by: Lars-Peter Clausen <lars@metafoo.de>

Thank you.

> I supposed the code could be improved a bit further in a follow up patch by
> only having one global table since it will be the same for all instances.

Yes that's a good idea.
How should I proceed? v3 or a separate commit based on the changes in this
commit? I think separate commit will be better, so I can make a good commit
message...or maybe put it all in a patch series with your ack added to this
change? Sorry I don't know the rules in such cases.

-- 
Slawomir Stepien
