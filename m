Return-Path: <jic23@cam.ac.uk>
Message-ID: <4C99D7C3.7050202@cam.ac.uk>
Date: Wed, 22 Sep 2010 11:17:39 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: Manuel Stahl <manuel.stahl@iis.fraunhofer.de>,
 linux-iio@vger.kernel.org, Michael.Hennerich@analog.com,
 Robin.Getz@analog.com
Subject: Re: [RFC PATCH 0/6] staging:iio:imu driver merges, fixes and new
 features.
References: <1284217100-2469-1-git-send-email-jic23@cam.ac.uk> <4C99C2BF.5030107@iis.fraunhofer.de> <4C99D67E.7010307@cam.ac.uk>
In-Reply-To: <4C99D67E.7010307@cam.ac.uk>
Content-Type: text/plain; charset=ISO-8859-15
List-ID: <linux-iio@vger.kernel.org>

On 09/22/10 11:12, Jonathan Cameron wrote:
> On 09/22/10 09:47, Manuel Stahl wrote:
>> Hi Jonathan,
>>
>> the merge still has severe problems for adis16400. Ring buffer doesn't read elements (bytes_per_datum is always 8) but the buffer contains zeros for the elements and a valid timestamp.
>>
>> The temp attribute has a different address for adis300 and adis400, so we need a separate entry here.
> gah. I missed that one.  It should actually be temp_x_attr  as the datasheet clearly labels it as
> the X-axis gyroscope temperature measurement. It matches the address for that on the adis16350 so that
> should be fine. Otherwise the only fix would have been to add this a chip_info field and change
> the attribute look up appropriately.
>>
>> The attached patch fixes a few problems, but the ring buffer still does not work.
> Strange. I must have messed something up. It's likely to be in the area around burst read.
> The original code may have worked with all channels on, but I had to rewrite a chunk to make
> it support various channel combinations.  This is in the earlier patches in the series
> (before the merge ones).  I don't have any devices that will do burst mode so I couldn't
> test that code.
> 
> Will look into it.
> 
> Thanks for the patch.
> 
> Those alarm attributes can wait until someone implements support for the alarms on the
> adis16400. Right now they aren't used.
> 
> diff --git a/drivers/staging/iio/imu/adis16350_core.c b/drivers/staging/iio/imu/adis16350_core.c
> index d8f76c6..b921f1d 100644
> --- a/drivers/staging/iio/imu/adis16350_core.c
> +++ b/drivers/staging/iio/imu/adis16350_core.c
> @@ -484,7 +484,7 @@ static int adis16350_initial_setup(struct adis16350_state *st)
>  	/* use high spi speed if possible */
>  	ret = adis16350_spi_read_reg_16(dev, ADIS16350_SMPL_PRD, &smp_prd);
>  	if (!ret && (smp_prd & ADIS16350_SMPL_PRD_DIV_MASK) < 0x0A) {
> -		st->us->max_speed_hz = ADIS16350_SPI_SLOW;
> +		st->us->max_speed_hz = ADIS16350_SPI_FAST;
>  		spi_setup(st->us);
>  	}
> 
> Is quite clearly a bug in the original code. I'll push that out as a separate fix patch
> prior to the series. As it's obvious I'll send that directly to Greg (author as you
> of course!).
> 
> The reorder doesn't matter, but does make the code order more logical.
It did however make me take a closer look at the other two sets, and I'd missed one of the calibbias
attrs in the adis16300 so definitely a worthwhile exercise!
