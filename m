Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:45131 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752135AbcAXOzg (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 24 Jan 2016 09:55:36 -0500
Subject: Re: [PATCH v2 3/3] iio: light: opt3001: enable operation w/o IRQ
To: Alexander Koch <mail@alexanderkoch.net>,
	Martin Kepplinger <martink@posteo.de>
References: <1452960878-1727-1-git-send-email-mail@alexanderkoch.net>
 <1452960878-1727-4-git-send-email-mail@alexanderkoch.net>
 <569D1BDD.1050804@posteo.de> <56A3CC8B.1020205@alexanderkoch.net>
Cc: knaack.h@gmx.de, lars@metafoo.de,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Michael Hornung <mhornung.linux@gmail.com>, dannenberg@ti.com,
	balbi@ti.com, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56A4E5E4.2070608@kernel.org>
Date: Sun, 24 Jan 2016 14:55:32 +0000
MIME-Version: 1.0
In-Reply-To: <56A3CC8B.1020205@alexanderkoch.net>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 23/01/16 18:55, Alexander Koch wrote:
> Am 18.01.2016 um 18:07 schrieb Martin Kepplinger:
>> Am 2016-01-16 um 17:14 schrieb Alexander Koch:
>>> Enable operation of the TI OPT3001 light sensor without having an
>>> interrupt line available to connect the INT pin to.
>>>
>>> In this operation mode, we issue a conversion request and simply wait
>>> for the conversion time available as timeout value, determined from
>>> integration time configuration and the worst-case time given in the data
>>> sheet (sect. 6.5, table on p. 5):
>>>
>>>   short integration time (100ms): 110ms + 3ms = 113ms
>>>    long integration time (800ms): 880ms + 3ms = 883ms
>>>
>>> This change is transparent as behaviour defaults to using the interrupt
>>> method if an interrupt no. is configured via device tree. Interrupt-less
>>> operation mode is performed when no valid interrupt no. is given.
>>>
>>> Signed-off-by: Alexander Koch <mail@alexanderkoch.net>
>>> Signed-off-by: Michael Hornung <mhornung.linux@gmail.com>
>>> ---
>>>  drivers/iio/light/opt3001.c | 137 ++++++++++++++++++++++++++++++--------------
>>>  1 file changed, 95 insertions(+), 42 deletions(-)
>>>
>>
>> Looks ok to me, although I didn't verify anything. Not very important
>> suggestions for changes inline
> 
> Thanks! Suggestions noted but if nobody objects I'd stick with v2 as I'm
> hoping to have it accepted in the merge window for 4.5.
Sorry Alex,

The IIO merge window for a given cycle closes at least a week before Linus
announces the opening of the main merge window.  This is partly due to the
path that IIO patches take to Linus (via Greg KH who operates a policy of
not taking anything after Linus starts hinting that the final RC for the
previous version is out) and partly as it's good general best practice
as it leaves some time for patches to sit in linux-next and get hammered
by the autobuilders, identifying any merge conflicts etc.

So this is firmly 4.6 material now anyway so we have lots of time to
dot the 'i's and cross the 't's!

(If it had been marginal I 'might' have enacted Martin's suggestions
as I applied the patch) but no point in taking the risk I might mess
it up so early in a cycle!

Jonathan
> 
> 
> Regards
> 
> Alex
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

