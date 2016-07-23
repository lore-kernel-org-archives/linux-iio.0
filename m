Return-Path: <jic23@jic23.retrosnub.co.uk>
In-Reply-To: <CAHNg1SorRwoDQowDa=+wdrEfmNg+9esw-Jbfxm1nO+0DZWBtBA@mail.gmail.com>
References: <CAHNg1Spjoao_fndWBP7mzE=ORMGK=vSUsVmN+EPvwv912-0KqA@mail.gmail.com> <CB140955-28B8-41F1-BEEA-2F20F833267D@jic23.retrosnub.co.uk> <CAHNg1SorRwoDQowDa=+wdrEfmNg+9esw-Jbfxm1nO+0DZWBtBA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: How to support multiple chips in single driver
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Date: Sat, 23 Jul 2016 18:25:16 +0100
To: Pratik Prajapati <pratik.prajapati12@gmail.com>
CC: Jonathan Cameron <jic23@kernel.org>,linux-iio@vger.kernel.org,linux-kernel@vger.kernel.org,linux-hwmon@vger.kernel.org,Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Message-ID: <CFCD1FEA-7D06-474F-ACA8-77F3A04CCEF6@jic23.retrosnub.co.uk>
List-ID: <linux-iio@vger.kernel.org>



On 23 July 2016 17:38:07 BST, Pratik Prajapati <pratik.prajapati12@gmail.com> wrote:
>On Sat, Jul 23, 2016 at 8:37 PM, Jonathan Cameron
><jic23@jic23.retrosnub.co.uk> wrote:
>>
>>
>> On 23 July 2016 14:36:39 BST, Pratik Prajapati
><pratik.prajapati12@gmail.com> wrote:
>>>Hi,
>>>
>>>I want to add the threshold, event handling and interrupts support in
>>>vcnl4000 driver but those functionalities are not supported in
>>>vcnl4000, but supported in vcnl4010 .
>>>
>>>Do we have an example (IIO driver) of supporting multiple chips in a
>>>single driver?
>> Lots. E.g. adc\max1636.
>I couldn't found max1636
>https://git.kernel.org/cgit/linux/kernel/git/jic23/iio.git/tree/drivers/iio/adc?h=testing
>and https://github.com/torvalds/linux/tree/master/drivers/iio/adc
>Or is that adc/max1363?
Sorry yes max1363!
>--
>To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
