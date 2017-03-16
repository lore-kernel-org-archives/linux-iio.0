Return-Path: <SRS0=2T7J=2Z=jic23.retrosnub.co.uk=jic23@kernel.org>
Date: Thu, 16 Mar 2017 17:19:31 +0000
In-Reply-To: <20170316140555.GB30080@kroah.com>
References: <1489672056-7957-1-git-send-email-miguel.robles@farole.net> <20170316140555.GB30080@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Subject: Re: [PATCH] Staging: iio: frequency: use octal permissions instead of symbolic
To: Greg KH <gregkh@linuxfoundation.org>,Miguel Robles <miguel.robles@farole.net>
CC: jic23@kernel.org,linux-iio@vger.kernel.org,Lars-Peter Clausen <lars@metafoo.de>
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Message-ID: <0CA5E762-587E-4E2A-8528-752221D219A5@jic23.retrosnub.co.uk>
List-ID: <linux-iio@vger.kernel.org>



On 16 March 2017 14:05:55 GMT+00:00, Greg KH <gregkh@linuxfoundation=2Eorg=
> wrote:
>On Thu, Mar 16, 2017 at 02:47:36PM +0100, Miguel Robles wrote:
>> Fix checkpatch warnings:
>> Symbolic permissions are not preferred=2E Consider using octal
>permissions=2E
>>=20
>> Signed-off-by: Miguel Robles <miguel=2Erobles@farole=2Enet>
>> ---
>>  drivers/staging/iio/frequency/ad9832=2Ec | 20 ++++++++++----------
>>  drivers/staging/iio/frequency/ad9834=2Ec | 22 +++++++++++-----------
>>  drivers/staging/iio/frequency/dds=2Eh    |  2 +-
>>  3 files changed, 22 insertions(+), 22 deletions(-)
>>=20
>> diff --git a/drivers/staging/iio/frequency/ad9832=2Ec
>b/drivers/staging/iio/frequency/ad9832=2Ec
>> index 8d40c8e=2E=2E163a4ef 100644
>> --- a/drivers/staging/iio/frequency/ad9832=2Ec
>> +++ b/drivers/staging/iio/frequency/ad9832=2Ec
>> @@ -248,22 +248,22 @@ static ssize_t ad9832_write(struct device *dev,
>struct device_attribute *attr,
>>   * see dds=2Eh for further information
>>   */
>> =20
>> -static IIO_DEV_ATTR_FREQ(0, 0, S_IWUSR, NULL, ad9832_write,
>AD9832_FREQ0HM);
>> -static IIO_DEV_ATTR_FREQ(0, 1, S_IWUSR, NULL, ad9832_write,
>AD9832_FREQ1HM);
>> -static IIO_DEV_ATTR_FREQSYMBOL(0, S_IWUSR, NULL, ad9832_write,
>AD9832_FREQ_SYM);
>> +static IIO_DEV_ATTR_FREQ(0, 0, 0200, NULL, ad9832_write,
>AD9832_FREQ0HM);
>> +static IIO_DEV_ATTR_FREQ(0, 1, 0200, NULL, ad9832_write,
>AD9832_FREQ1HM);
>> +static IIO_DEV_ATTR_FREQSYMBOL(0, 0200, NULL, ad9832_write,
>AD9832_FREQ_SYM);
>
>Meta-comment, would a IIO_DEV_ATTR_WO_FREQ() and friends help out here?
>That way it's impossible to get the permission values incorrect=2E
>
Keep it local to driver perhaps as this should be done with properly descr=
ibed channels=2E Snag is=20
no one has pinned down a final abi for these devices yet!

Lars is cleaning this up on the to-do list?

J
>thanks,
>
>greg k-h

--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
