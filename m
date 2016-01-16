Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:53544 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751257AbcAPMzd (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 16 Jan 2016 07:55:33 -0500
Subject: Re: [PATCH v7] iio: add ad5761 DAC driver
To: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
	Lars-Peter Clausen <lars@metafoo.de>
References: <1452540774-26410-1-git-send-email-ricardo.ribalda@gmail.com>
 <56941920.8020406@metafoo.de>
 <CAPybu_00PsgSzp1-TV98ndrh9jym+n=earLU=2w+L9R89=fi1g@mail.gmail.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <569A3DC3.7040307@kernel.org>
Date: Sat, 16 Jan 2016 12:55:31 +0000
MIME-Version: 1.0
In-Reply-To: <CAPybu_00PsgSzp1-TV98ndrh9jym+n=earLU=2w+L9R89=fi1g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 12/01/16 08:23, Ricardo Ribalda Delgado wrote:
> Hello Lars
> 
>> And one wish for the future, please give people a chance a review and don't
>> resend a new version of the patch every couple of hours. This will make the
>> reviewers life a bit easier.
> 
> Sorry for the disturbance
> 
I'm impatient unlike Lars ;)
>>
>>> diff --git a/include/linux/iio/dac/ad5761.h b/include/linux/iio/dac/ad5761.h
>>> new file mode 100644
>>> index 000000000000..2f3702309d61
>>> --- /dev/null
>>> +++ b/include/linux/iio/dac/ad5761.h
>>
>> This should go into include/linux/platform_data. That's where all new
>> platform data include files should go.
>>
> 
> v8 is not on https://github.com/ribalda/linux/tree/ad5761v8
> 
> I will send to the ML if there is no more comments on it by the end of the day.
It's been several days....

(not that it actually matters at this time of the cycle!)
> 
> Regards!
> 
> 

