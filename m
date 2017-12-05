Return-Path: <lars@metafoo.de>
Subject: Re: [PATCH] iio: buffer-dma: Expose data available
To: Matthew Fornero <matthew.fornero@gmail.com>
Cc: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>,
 linux-iio@vger.kernel.org, Matt Fornero <matt.fornero@mathworks.com>
References: <1512161180-30116-1-git-send-email-mfornero@gmail.com>
 <20171202115257.5e561988@archlinux>
 <d260e712-ec2f-33d5-e368-86c2e7ffa19e@metafoo.de>
 <CABdUomw1Z=CTq5m5jBic-=PNtn3DGU1L3b3O6bhzX-MOo2iCrw@mail.gmail.com>
 <a4dd5967-e905-70c0-e84b-ea64f45dc134@metafoo.de>
 <CABdUomwzhiEkOECPGG5T08eqydGuHmsCSfkH0wCbPm6wOzeXig@mail.gmail.com>
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <ef13f5a5-6e4e-e9a5-057e-204d73fc42c1@metafoo.de>
Date: Tue, 5 Dec 2017 19:38:43 +0100
MIME-Version: 1.0
In-Reply-To: <CABdUomwzhiEkOECPGG5T08eqydGuHmsCSfkH0wCbPm6wOzeXig@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-iio@vger.kernel.org>

On 12/05/2017 07:11 PM, Matthew Fornero wrote:
> On Tue, Dec 5, 2017 at 10:08 AM Lars-Peter Clausen <lars@metafoo.de> wrote:
>>> What about the case when the data_available element in
>>> iio_buffer_access_funcs is undefined (e.g. industrialio-buffer-cb)?
>>> Do we modify iio_buffer_data_available() to return 0, do we make the
>>> sysfs function return -ENOENT or -EINVAL, or simply not expose the sysfs
>>> interface for this case?
>>
>> The callback buffer does not support any of the interfaces required for the
>> userspace facing side. E.g. there is no read() callback.
>>
>> For proper support of the userspace interfaces data_available() is required,
>> otherwise read() would never return. So I think this is fine, we'd never
>> register the userspacing interface if it didn't have the data_available
>> callback.
> 
> So there should already be provisions in place for *not* registering the
> cb buffer with user-space, meaning no additional logic would be required
> for exposing / not exposing a "data_available" sysfs attribute, correct?

Yes.
