Return-Path: <jic23@kernel.org>
Message-ID: <4F0F356A.9000109@kernel.org>
Date: Thu, 12 Jan 2012 19:32:58 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
CC: linux-iio@vger.kernel.org, jic23@cam.ac.uk
Subject: Re: [PATCH 1/3] staging: iio: core: fix argument of iio_buffer_register
 (must be const)
References: <1326124974-7288-1-git-send-email-manuel.stahl@iis.fraunhofer.de> <4F0F34F4.9070108@kernel.org>
In-Reply-To: <4F0F34F4.9070108@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 01/12/2012 07:31 PM, Jonathan Cameron wrote:
> Oops. One trivial point here.  Perhaps the commit message could make it
> clear that this is for the stub?  Had me briefly confused.  Either way
> fine with me.
> 
> On 01/09/2012 04:02 PM, Manuel Stahl wrote:
>> Signed-off-by: Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
> Acked-by: Jonathan Cameron <jic23@cam.ac.uk>
Sorry, finger memory.
Acked-by: Jonathan Cameron <jic23@kernel.org>
>> ---
>>  drivers/staging/iio/buffer.h |    4 ++--
>>  1 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/staging/iio/buffer.h b/drivers/staging/iio/buffer.h
>> index 44593b2..1a35006 100644
>> --- a/drivers/staging/iio/buffer.h
>> +++ b/drivers/staging/iio/buffer.h
>> @@ -197,8 +197,8 @@ int iio_sw_buffer_preenable(struct iio_dev *indio_dev);
>>  #else /* CONFIG_IIO_BUFFER */
>>  
>>  static inline int iio_buffer_register(struct iio_dev *indio_dev,
>> -					   struct iio_chan_spec *channels,
>> -					   int num_channels)
>> +				      const struct iio_chan_spec *channels,
>> +				      int num_channels)
>>  {
>>  	return 0;
>>  }
> 
