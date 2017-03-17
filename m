Return-Path: <lars@metafoo.de>
Subject: Re: [PATCH] Staging: iio: frequency: use octal permissions instead of
 symbolic
To: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>,
 Greg KH <gregkh@linuxfoundation.org>,
 Miguel Robles <miguel.robles@farole.net>
References: <1489672056-7957-1-git-send-email-miguel.robles@farole.net>
 <20170316140555.GB30080@kroah.com>
 <0CA5E762-587E-4E2A-8528-752221D219A5@jic23.retrosnub.co.uk>
Cc: jic23@kernel.org, linux-iio@vger.kernel.org
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <057927c1-bfad-80fd-ee1e-7fd1ffe9fcde@metafoo.de>
Date: Fri, 17 Mar 2017 10:09:38 +0100
MIME-Version: 1.0
In-Reply-To: <0CA5E762-587E-4E2A-8528-752221D219A5@jic23.retrosnub.co.uk>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-iio@vger.kernel.org>

On 03/16/2017 06:19 PM, Jonathan Cameron wrote:
> 
> 
> On 16 March 2017 14:05:55 GMT+00:00, Greg KH <gregkh@linuxfoundation.org> wrote:
>> On Thu, Mar 16, 2017 at 02:47:36PM +0100, Miguel Robles wrote:
>>> Fix checkpatch warnings:
>>> Symbolic permissions are not preferred. Consider using octal
>> permissions.
>>>
>>> Signed-off-by: Miguel Robles <miguel.robles@farole.net>
>>> ---
>>>  drivers/staging/iio/frequency/ad9832.c | 20 ++++++++++----------
>>>  drivers/staging/iio/frequency/ad9834.c | 22 +++++++++++-----------
>>>  drivers/staging/iio/frequency/dds.h    |  2 +-
>>>  3 files changed, 22 insertions(+), 22 deletions(-)
>>>
>>> diff --git a/drivers/staging/iio/frequency/ad9832.c
>> b/drivers/staging/iio/frequency/ad9832.c
>>> index 8d40c8e..163a4ef 100644
>>> --- a/drivers/staging/iio/frequency/ad9832.c
>>> +++ b/drivers/staging/iio/frequency/ad9832.c
>>> @@ -248,22 +248,22 @@ static ssize_t ad9832_write(struct device *dev,
>> struct device_attribute *attr,
>>>   * see dds.h for further information
>>>   */
>>>  
>>> -static IIO_DEV_ATTR_FREQ(0, 0, S_IWUSR, NULL, ad9832_write,
>> AD9832_FREQ0HM);
>>> -static IIO_DEV_ATTR_FREQ(0, 1, S_IWUSR, NULL, ad9832_write,
>> AD9832_FREQ1HM);
>>> -static IIO_DEV_ATTR_FREQSYMBOL(0, S_IWUSR, NULL, ad9832_write,
>> AD9832_FREQ_SYM);
>>> +static IIO_DEV_ATTR_FREQ(0, 0, 0200, NULL, ad9832_write,
>> AD9832_FREQ0HM);
>>> +static IIO_DEV_ATTR_FREQ(0, 1, 0200, NULL, ad9832_write,
>> AD9832_FREQ1HM);
>>> +static IIO_DEV_ATTR_FREQSYMBOL(0, 0200, NULL, ad9832_write,
>> AD9832_FREQ_SYM);
>>
>> Meta-comment, would a IIO_DEV_ATTR_WO_FREQ() and friends help out here?
>> That way it's impossible to get the permission values incorrect.
>>
> Keep it local to driver perhaps as this should be done with properly described channels. Snag is 
> no one has pinned down a final abi for these devices yet!
> 
> Lars is cleaning this up on the to-do list?

Ideally those would be made proper IIO channel properties and then just let
the IIO core and the sysfs file generation. No need to handle permissions in
the driver at all. As far as I know nobody is working on it though, but if
somebody wants to pick it up, go ahead.
