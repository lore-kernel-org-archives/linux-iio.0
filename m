Return-Path: <jic23@jic23.retrosnub.co.uk>
In-Reply-To: <CAHNg1Spjoao_fndWBP7mzE=ORMGK=vSUsVmN+EPvwv912-0KqA@mail.gmail.com>
References: <CAHNg1Spjoao_fndWBP7mzE=ORMGK=vSUsVmN+EPvwv912-0KqA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: How to support multiple chips in single driver
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Date: Sat, 23 Jul 2016 16:07:20 +0100
To: Pratik Prajapati <pratik.prajapati12@gmail.com>,Jonathan Cameron <jic23@kernel.org>,linux-iio@vger.kernel.org,linux-kernel@vger.kernel.org,linux-hwmon@vger.kernel.org,Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Message-ID: <CB140955-28B8-41F1-BEEA-2F20F833267D@jic23.retrosnub.co.uk>
List-ID: <linux-iio@vger.kernel.org>



On 23 July 2016 14:36:39 BST, Pratik Prajapati <pratik.prajapati12@gmail.com> wrote:
>Hi,
>
>I want to add the threshold, event handling and interrupts support in
>vcnl4000 driver but those functionalities are not supported in
>vcnl4000, but supported in vcnl4010 .
>
>Do we have an example (IIO driver) of supporting multiple chips in a
>single driver?
Lots. E.g. adc\max1636.

This is a very common situation 
>
>Note* - vcnl4010 is superset of vcnl4000
>
>Best Regards,
>Pratik Prajapati

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
