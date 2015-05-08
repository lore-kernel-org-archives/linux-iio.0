Return-Path: <jic23@jic23.retrosnub.co.uk>
References: <1430930957-14588-1-git-send-email-mwelling@ieee.org>
            <554B3ABB.7050306@kernel.org>
            <20150507234817.GA24969@deathray>
In-Reply-To: <20150507234817.GA24969@deathray>
From: jic23@jic23.retrosnub.co.uk
To: Michael Welling <mwelling@ieee.org>
Cc: Jonathan Cameron <jic23@kernel.org>, knaack.h@gmx.de,
  lars@metafoo.de, pmeerw@pmeerw.net, san@rosetechnology.dk,
  linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2] iio: mcp320x: Fix occasional incorrect readings
Date: Fri, 08 May 2015 11:54:58 +0100
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Message-Id: <20150508105458.6ABDE4086D@saturn.retrosnub.co.uk>
List-ID: <linux-iio@vger.kernel.org>

Michael Welling writes: 

> On Thu, May 07, 2015 at 11:13:15AM +0100, Jonathan Cameron wrote:
>> On 06/05/15 17:49, Michael Welling wrote:
>> > Without the cacheline alignment, the readings will occasionally incorrectly
>> > return 0.
>> > 
>> > Signed-off-by: Michael Welling <mwelling@ieee.org>
>> Applied to the fixes-togreg branch of iio.git.  Not sure
>> when I'll be able to push this out publicly as travelling
>> / working nights and generally having a silly week. 
>> 
>> J
> 
> Thanks. 
> 
> Appearently code can be silly too:
> https://lkml.org/lkml/2015/5/7/879
*laughs*.  Hmm. 8.56pm. Chances are Mark was a beer or two down ;) 

> 
>> > ---
>> > 
>> > v2: Moved buffers to the end of the mcp320x struct per suggestion to keep
>> > them on their own cacheline.
>> > 
>> >  drivers/iio/adc/mcp320x.c |    6 +++---
>> >  1 file changed, 3 insertions(+), 3 deletions(-)
>> > 
>> > diff --git a/drivers/iio/adc/mcp320x.c b/drivers/iio/adc/mcp320x.c
>> > index efbfd12..8d9c9b9 100644
>> > --- a/drivers/iio/adc/mcp320x.c
>> > +++ b/drivers/iio/adc/mcp320x.c
>> > @@ -60,12 +60,12 @@ struct mcp320x {
>> >  	struct spi_message msg;
>> >  	struct spi_transfer transfer[2];
>> >  
>> > -	u8 tx_buf;
>> > -	u8 rx_buf[2];
>> > -
>> >  	struct regulator *reg;
>> >  	struct mutex lock;
>> >  	const struct mcp320x_chip_info *chip_info;
>> > +
>> > +	u8 tx_buf ____cacheline_aligned;
>> > +	u8 rx_buf[2];
>> >  };
>> >  
>> >  static int mcp320x_channel_to_tx_data(int device_index,
>> >  
>> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
