Return-Path: <lars@metafoo.de>
Message-ID: <4FA02576.2060607@metafoo.de>
Date: Tue, 01 May 2012 20:03:34 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: Ge Gao <ggao@invensense.com>, linux-iio@vger.kernel.org
Subject: Re: different data rate in IIO ?
References: <abd67b68b54fc6c88b83c91a200ace5e@mail.gmail.com> <4F9FAAB9.7060003@metafoo.de> <4F9FE357.6050004@cam.ac.uk> <4F9FE632.3040308@metafoo.de> <4F9FEA37.5040107@cam.ac.uk> <4F9FEDC6.8070400@metafoo.de> <4F9FF002.2060900@metafoo.de> <4F9FF82E.80906@cam.ac.uk>
In-Reply-To: <4F9FF82E.80906@cam.ac.uk>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 05/01/2012 04:50 PM, Jonathan Cameron wrote:
> On 5/1/2012 3:15 PM, Lars-Peter Clausen wrote:
>> On 05/01/2012 04:05 PM, Lars-Peter Clausen wrote:
>> [...]
>> Ah, seems as if the refcounting infrastructure is already ready for
>> use after
>> we have called device_initialize, so the above plan should work quite
>> well.
>> Call device_del in iio_device_unregister and device_put in
>> iio_device_free and
>> free the struct in the release callback.
> That makes sense given it just splits the two parts of device_unregister
> apart.
> Don't suppose you want to do the patch?

I could write the patch, but I don't have a setup at hand right now where I
could test it, so this would have to wait until next week. I wouldn't mind if
you took care of it though :)

- Lars
