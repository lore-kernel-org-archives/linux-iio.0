Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from argos.tuxed.org ([176.9.87.227]:45428 "EHLO argos.tuxed.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753553AbcAWSzT (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sat, 23 Jan 2016 13:55:19 -0500
Subject: Re: [PATCH v2 3/3] iio: light: opt3001: enable operation w/o IRQ
To: Martin Kepplinger <martink@posteo.de>
References: <1452960878-1727-1-git-send-email-mail@alexanderkoch.net>
 <1452960878-1727-4-git-send-email-mail@alexanderkoch.net>
 <569D1BDD.1050804@posteo.de>
From: Alexander Koch <mail@alexanderkoch.net>
Cc: Jonathan Cameron <jic23@kernel.org>, knaack.h@gmx.de,
	lars@metafoo.de, Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Michael Hornung <mhornung.linux@gmail.com>, dannenberg@ti.com,
	balbi@ti.com, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Message-ID: <56A3CC8B.1020205@alexanderkoch.net>
Date: Sat, 23 Jan 2016 19:55:07 +0100
MIME-Version: 1.0
In-Reply-To: <569D1BDD.1050804@posteo.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Am 18.01.2016 um 18:07 schrieb Martin Kepplinger:
> Am 2016-01-16 um 17:14 schrieb Alexander Koch:
>> Enable operation of the TI OPT3001 light sensor without having an
>> interrupt line available to connect the INT pin to.
>>
>> In this operation mode, we issue a conversion request and simply wait
>> for the conversion time available as timeout value, determined from
>> integration time configuration and the worst-case time given in the data
>> sheet (sect. 6.5, table on p. 5):
>>
>>   short integration time (100ms): 110ms + 3ms = 113ms
>>    long integration time (800ms): 880ms + 3ms = 883ms
>>
>> This change is transparent as behaviour defaults to using the interrupt
>> method if an interrupt no. is configured via device tree. Interrupt-less
>> operation mode is performed when no valid interrupt no. is given.
>>
>> Signed-off-by: Alexander Koch <mail@alexanderkoch.net>
>> Signed-off-by: Michael Hornung <mhornung.linux@gmail.com>
>> ---
>>  drivers/iio/light/opt3001.c | 137 ++++++++++++++++++++++++++++++--------------
>>  1 file changed, 95 insertions(+), 42 deletions(-)
>>
> 
> Looks ok to me, although I didn't verify anything. Not very important
> suggestions for changes inline

Thanks! Suggestions noted but if nobody objects I'd stick with v2 as I'm
hoping to have it accepted in the merge window for 4.5.


Regards

Alex
