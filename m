Return-Path: <afd@ti.com>
Subject: Re: [PATCH v4 4/4] iio: health: Add driver for the TI AFE4403 heart
 monitor
To: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>, Dan
 Murphy <dmurphy@ti.com>,
        Rob Herring <robh+dt@kernel.org>, Pawel Moll
	<pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell
	<ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>
References: <1453742941-12086-1-git-send-email-afd@ti.com>
 <1453742941-12086-5-git-send-email-afd@ti.com> <56ACD24E.3050308@kernel.org>
CC: <linux-iio@vger.kernel.org>, <linux-api@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From: "Andrew F. Davis" <afd@ti.com>
Message-ID: <56B0E981.5040203@ti.com>
Date: Tue, 2 Feb 2016 11:38:09 -0600
MIME-Version: 1.0
In-Reply-To: <56ACD24E.3050308@kernel.org>
Content-Type: text/plain; charset="windows-1252"; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 01/30/2016 09:10 AM, Jonathan Cameron wrote:
> On 25/01/16 17:29, Andrew F. Davis wrote:
>> +
>> +static int afe4403_read(struct afe4403_data *afe, unsigned int reg, u32 *val)
>> +{
>> +	u8 tx[4] ____cacheline_aligned = {AFE440X_CONTROL0, 0x0, 0x0,
>> +					  AFE440X_CONTROL0_READ};
> hmm. Can you do this on the stack?  Don't think so but maybe I'm wrong..
> The cachline aligned trick relies on the start of the allocation on the
> heap being aligned and then pads to ensure that the element so tagged
> is also aligned appropriately.

I am not sure ether, I think I borrowed this from some example that did
it like this, but I can't find it now. So, I'll change this to be safe.

>> +	u8 rx[3];
>> +	int ret;
> Even if this were possible, ret is in the same cacheline as tx and rx so
> chaos may well occur.
>
> If you really want to avoid having allocations elsewhere, just use
> spi_write_then_read(afe->spi, tx, 4, NULL, 0) and you should be fine
> as spi_write_then_read uses safe bounce buffers.

spi_write_then_read performs a memcpy to the rx buffer, even though
the length is 0 I believe it is still technically undefined behavior,
but it doesn't seem to cause any issues with the current implementation
so I'll do this.

Thanks,
Andrew
