Return-Path: <lars@metafoo.de>
Subject: Re: [PATCH 1/6] staging: iio: set proper supply name to
 devm_regulator_get()
To: Matt Ranostay <matt@ranostay.consulting>,
 Eva Rachel Retuya <eraretuya@gmail.com>
References: <1477933475-21914-1-git-send-email-eraretuya@gmail.com>
 <1477933475-21914-2-git-send-email-eraretuya@gmail.com>
 <CAJ_EiSTU_z_fNSLSUSTpzU+v5F5f-JEe7p2fUms3LKEd+wftDw@mail.gmail.com>
Cc: linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
 Linux Kernel <linux-kernel@vger.kernel.org>, Michael.Hennerich@analog.com,
 Jonathan Cameron <jic23@kernel.org>, knaack.h@gmx.de, pmeerw@pmeerw.net,
 gregkh@linuxfoundation.org
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <73bc1e52-d728-a61b-69f3-a567c0b05e28@metafoo.de>
Date: Tue, 1 Nov 2016 20:58:23 +0100
MIME-Version: 1.0
In-Reply-To: <CAJ_EiSTU_z_fNSLSUSTpzU+v5F5f-JEe7p2fUms3LKEd+wftDw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-iio@vger.kernel.org>

On 11/01/2016 05:03 AM, Matt Ranostay wrote:
> On Mon, Oct 31, 2016 at 10:04 AM, Eva Rachel Retuya <eraretuya@gmail.com> wrote:
>> The name passed to devm_regulator_get() should match the name of the
>> supply as specified in the device datasheet. This makes it clear what
>> power supply is being referred to in case of presence of other
>> regulators.
>>
>> Currently, the supply name specified on the affected devices is 'vcc'.
>> Use lowercase version of the datasheet name to specify the supply
>> voltage.
>>
> 
> Aren't we possibly breaking current device tree definitions that
> people may have? We should still check the old name after the new
> datasheet name in my opinion.

None of those drivers have DT bindings, so I think we are OK. And they are
in staging anyway.
