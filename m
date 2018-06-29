Return-Path: <SRS0=51PO=JP=gmail.com=daniel.baluta@kernel.org>
MIME-Version: 1.0
In-Reply-To: <AF0F37DE-70F9-4B88-BEE1-48516E1795BB@jic23.retrosnub.co.uk>
References: <1529562877-9357-1-git-send-email-himanshujha199640@gmail.com>
 <1529562877-9357-4-git-send-email-himanshujha199640@gmail.com>
 <20180622144435.0000613b@huawei.com> <CAEnQRZCOVrYk=oifne81Fo_ky_3vLq85AwA2v6qJ68s7HRMTDQ@mail.gmail.com>
 <AF0F37DE-70F9-4B88-BEE1-48516E1795BB@jic23.retrosnub.co.uk>
From: Daniel Baluta <daniel.baluta@gmail.com>
Date: Fri, 29 Jun 2018 16:02:36 +0300
Message-ID: <CAEnQRZAayGy9n-h=zirvF6VbVgwDiTM5dr-dJx_b+ys+OitBAg@mail.gmail.com>
Subject: Re: [RFC 3/3] iio: imu: bme680: Add ACPI support
To: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>, Himanshu Jha <himanshujha199640@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald <pmeerw@pmeerw.net>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-iio@vger.kernel.org>

On Mon, Jun 25, 2018 at 1:06 PM, Jonathan Cameron
<jic23@jic23.retrosnub.co.uk> wrote:
>
>
> On 25 June 2018 08:40:08 BST, Daniel Baluta <daniel.baluta@gmail.com> wrote:
>>On Fri, Jun 22, 2018 at 4:44 PM, Jonathan Cameron
>><jonathan.cameron@huawei.com> wrote:
>>> On Thu, 21 Jun 2018 12:04:37 +0530
>>> Himanshu Jha <himanshujha199640@gmail.com> wrote:
>>>
>>>> Add support to probe the bme680 sensor on the i2c bus using
>>>> ACPI.
>>>>
>>>> Cc: Daniel Baluta <daniel.baluta@gmail.com>
>>>> Signed-off-by: Himanshu Jha <himanshujha199640@gmail.com>
>>>
>>> This looks fine.  Do we know for sure that they use that ACPI
>>> ID?  For these sorts of devices, it's fairly common to have entirely
>>> random ids presented.   Also, I'm a little curious to know, what
>>> ACPI based device has one of these?
>>
>>Hi Jonathan,
>>
>>I am not aware of any ACPI device using our chosen ID. We just
>>picked BME0680 based on previous drivers from Bosch.
>>
>>It is useful to enumerate the sensor via ACPI because our
>>qemu testing setup uses ACPI.
>
> Cool. Any docs on that setup?  Would be useful blog post if easy to do.

We have multiple iterations of our setup, depending on the project.

Generic description that we use at University can be found here:

https://linux-kernel-labs.github.io/master/labs/vm.html

Scripts are here:

https://github.com/linux-kernel-labs/linux/tree/master/tools/labs/qemu

For IIO we use DLN2 (USB-I2C/SPI) adapter and we pass
-acpitable file=description.aml to qemu.


thanks,
Daniel.
