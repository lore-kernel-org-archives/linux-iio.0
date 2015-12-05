Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:33516 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753288AbbLEQds (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 5 Dec 2015 11:33:48 -0500
Subject: Re: [RFC] pH sensors
To: Matt Ranostay <mranostay@gmail.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
References: <CAKzfze_t+D1sxP58EJeR284XbLHnrvaLOEpBgq_wdGGg2gW9XA@mail.gmail.com>
 <CAKzfze_Ff8mWJR0kqo1v1mD_=mGCNBWPaZZ1Q+2aOzU9mzPp1A@mail.gmail.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <566311EA.9070504@kernel.org>
Date: Sat, 5 Dec 2015 16:33:46 +0000
MIME-Version: 1.0
In-Reply-To: <CAKzfze_Ff8mWJR0kqo1v1mD_=mGCNBWPaZZ1Q+2aOzU9mzPp1A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/12/15 06:44, Matt Ranostay wrote:
> On Thu, Dec 3, 2015 at 8:29 PM, Matt Ranostay <mranostay@gmail.com> wrote:
>> Hello et all,
>>
>> So currently planning on working a I2C based pH sensor and want to get
>> some input on the iio_chan_type to use.
>>
>> There are two solutions  that can be thought of:
>>
>> 1) Use the current IIO_CONCENTRATION type and use the percentage of
>> Hydronium (H3O+) in the solution to report to actual pH levels
> 
> I just remembered that pH is for example  -log(10**-7) = 7. so using
> IIO_CONCENTRATION would require processing within the driver. So I
> think option 2 is the only thing that makes sense since it would just
> have a simple scaling value.
I'd have gone for the second option anyway!

Whilst it's nice to keep the range of units used to a minimum some units
are so ingrained in peoples minds for particular things we are best
going with them even when they could be blugeoned into an existing option!

> 
>> 2) New IIO_PH type that is an typically an integer from 0 (acid) - 14 (base)
>>
>> Thanks,
>>
>> Matt
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

