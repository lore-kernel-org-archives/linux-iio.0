Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www381.your-server.de ([78.46.137.84]:55943 "EHLO
	www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751209AbcFVICH (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 22 Jun 2016 04:02:07 -0400
Subject: Re: [PATCH v3] iio: temperature: add support for Maxim thermocouple
 chips
To: Jonathan Cameron <jic23@kernel.org>,
	Matt Ranostay <mranostay@gmail.com>
References: <1464572270-29154-1-git-send-email-mranostay@gmail.com>
 <6e79df7d-4ac1-3a44-e303-af858f30e161@kernel.org>
 <77a1a974-2636-878b-742c-d624cc5fdc58@kernel.org>
Cc: linux-iio@vger.kernel.org, Marek Vasut <marex@denx.de>,
	Matt Porter <mporter@konsulko.com>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Peter Meerwald <pmeerw@pmeerw.net>
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <576A45FA.4020708@metafoo.de>
Date: Wed, 22 Jun 2016 10:02:02 +0200
MIME-Version: 1.0
In-Reply-To: <77a1a974-2636-878b-742c-d624cc5fdc58@kernel.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 06/11/2016 06:48 PM, Jonathan Cameron wrote:
> On 03/06/16 13:33, Jonathan Cameron wrote:
>> On 30/05/16 02:37, Matt Ranostay wrote:
>>> Add initial driver support for MAX6675, and MAX31885 thermocouple chips.
>>>
>>> Cc: Marek Vasut <marex@denx.de>
>>> Cc: Matt Porter <mporter@konsulko.com>
>>> Signed-off-by: Matt Ranostay <mranostay@gmail.com>
>> I'm going to let this sit for a sort while as I'd like some discussion
>> of the invalidate buffer bit.
>>
>> Cc'd a few more people for views.
> Hmm. Deadly silence.
> 
> Daniel, Lars, Peter - this is a fairly fundamental abi question.
> 
> What do we do to signify an 'invalid reading' in the buffer.
> 
> Here the part is driven by a software trigger - and if we skip
> a reading we are obviously out of sync.
> 
> Old and nasty trick we used in some (possibly only one)
> early driver was to set an invalid state for these cases.
> 
> Anyone have a better idea?

Ideally the driver would leave the data including the status bit intact and
not replace it with a magic constant that way an application that is aware
of the way the chip behaves could handle that.

