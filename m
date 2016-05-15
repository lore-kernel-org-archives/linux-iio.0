Return-Path: <mranostay@gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAKi4VAKCLe_UvuPVEQUB+qXZMvd4N4ai2z6LjG28oDf5xOe9pQ@mail.gmail.com>
References: <1462929938-15910-1-git-send-email-matt.ranostay@intel.com> <CAKi4VAKCLe_UvuPVEQUB+qXZMvd4N4ai2z6LjG28oDf5xOe9pQ@mail.gmail.com>
From: Matt Ranostay <mranostay@gmail.com>
Date: Sat, 14 May 2016 21:06:18 -0700
Message-ID: <CAKzfze8-a10r3vqigeEhx9HdZcLPcGfUy7PsP+hzd9fiMkOwYQ@mail.gmail.com>
Subject: Re: [PATCH v2] iio: adc: ti-ads1015: add support for ADS1115 part
To: Lucas De Marchi <lucas.de.marchi@gmail.com>
Cc: Matt Ranostay <matt.ranostay@intel.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, Jonathan Cameron <jic23@kernel.org>,
	Daniel Baluta <daniel.baluta@intel.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Sat, May 14, 2016 at 7:14 PM, Lucas De Marchi
<lucas.de.marchi@gmail.com> wrote:
> Hi,
>
> On Tue, May 10, 2016 at 10:25 PM, Matt Ranostay <matt.ranostay@intel.com> wrote:
>> TI ADS1115 is a 16-bit resolution ADC that is register map
>> compatible with the ADS1015 device.
>>
>> Cc: daniel.baluta@intel.com
>> Signed-off-by: Matt Ranostay <matt.ranostay@intel.com>
>> ---
>
>
> I see no changes to the available data rates in ads1115 which are very
> different from the ones in ads1015. Am I missing something?

Yikes! I totally missed that.. good catch..

>
> Lucas De Marchi
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
