Return-Path: <SRS0=8d+p=JL=gmail.com=daniel.baluta@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20180622144435.0000613b@huawei.com>
References: <1529562877-9357-1-git-send-email-himanshujha199640@gmail.com>
 <1529562877-9357-4-git-send-email-himanshujha199640@gmail.com> <20180622144435.0000613b@huawei.com>
From: Daniel Baluta <daniel.baluta@gmail.com>
Date: Mon, 25 Jun 2018 10:40:08 +0300
Message-ID: <CAEnQRZCOVrYk=oifne81Fo_ky_3vLq85AwA2v6qJ68s7HRMTDQ@mail.gmail.com>
Subject: Re: [RFC 3/3] iio: imu: bme680: Add ACPI support
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Himanshu Jha <himanshujha199640@gmail.com>, Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-iio@vger.kernel.org>

On Fri, Jun 22, 2018 at 4:44 PM, Jonathan Cameron
<jonathan.cameron@huawei.com> wrote:
> On Thu, 21 Jun 2018 12:04:37 +0530
> Himanshu Jha <himanshujha199640@gmail.com> wrote:
>
>> Add support to probe the bme680 sensor on the i2c bus using
>> ACPI.
>>
>> Cc: Daniel Baluta <daniel.baluta@gmail.com>
>> Signed-off-by: Himanshu Jha <himanshujha199640@gmail.com>
>
> This looks fine.  Do we know for sure that they use that ACPI
> ID?  For these sorts of devices, it's fairly common to have entirely
> random ids presented.   Also, I'm a little curious to know, what
> ACPI based device has one of these?

Hi Jonathan,

I am not aware of any ACPI device using our chosen ID. We just
picked BME0680 based on previous drivers from Bosch.

It is useful to enumerate the sensor via ACPI because our
qemu testing setup uses ACPI.

thanks,
Daniel.
