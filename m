Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:38804 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751688AbcFNHon (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 14 Jun 2016 03:44:43 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Tue, 14 Jun 2016 08:44:38 +0100
From: jic23@jic23.retrosnub.co.uk
To: Matt Ranostay <mranostay@gmail.com>
Cc: Alison Schofield <amsfield22@gmail.com>, linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH 0/2] iio: humidity: sht31: add Sensirion SHT31 support
In-Reply-To: <CAKzfze_=URjXxePW4+P_Y8OUrgoMiC90Nzr=3ey+G=ZHKsRxCA@mail.gmail.com>
References: <1465708397-19649-1-git-send-email-mranostay@gmail.com>
 <20160613222502.GA4376@d830.WORKGROUP>
 <CAKzfze_=URjXxePW4+P_Y8OUrgoMiC90Nzr=3ey+G=ZHKsRxCA@mail.gmail.com>
Message-ID: <f26e218318cd07bdb857f67b1357f36e@jic23.retrosnub.co.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 14.06.2016 00:23, Matt Ranostay wrote:
> Didn't notice that will till now, and looking at the timestamp I see 
> why :).
> However this is more for the sw triggered buffer support which hwmon
> lacks... there is a few examples of this already in the tree.
> 
> Maybe Jonathan and Peter will have some input on this.
> 
Thanks for highlighting this Alison.  Not the first time we have had
simultaneous driver postings under review for both IIO and
HWMON unfortunately.

The hwmon guys are fairly flexible iff there is a good reason to want 
stuff
that is in IIO.  The original hwmon humidity driver was actually my 
fault
as it slipped in when hwmon was effectively not maintained (Andrew 
Morton was
babysitting).  People on their side have always been a bit split on 
humidity
drivers and whether they are within their scope.

Anyhow, best bet is to email their list (perhaps reply to the driver 
thread)
to make sure everyone knows this is going on (cc linux-iio as well).
Then we can work out how to move forward.

Two drivers, one in each place is a non starter for new parts.  We have
ended up with a few instances, but it's mostly been a case of a driver
with much wider scope ending up covering parts that were already in 
hwmon.
Also a very small number of devices have moved across from hwmon to IIO.

In this particular case the sensor is reasonably fast so there is at
least some argument for IIO support. Note I tend to stay out of these
and let the driver author work on convincing Guenter / Jean
(they are very reasonable and responsive!) Only thing I'll say is that
I'm more than happy to have this in IIO if the hwmon guys don't mind.

Jonathan
> On Mon, Jun 13, 2016 at 3:25 PM, Alison Schofield 
> <amsfield22@gmail.com> wrote:
>> On Sat, Jun 11, 2016 at 10:13:15PM -0700, Matt Ranostay wrote:
>>> Add support for the humidity and temperature functionally for the 
>>> SHT31
>>> chipset. In addition add support for using using software triggers.
>> 
>> Now that I'm hwmon-aware ;)  I see this same driver under review in 
>> hwmon.
>> Can support exist in 2 places?
>> 
>> alisons
>> 
>>> 
>>> Matt Ranostay (2):
>>>   devicetree: add Sensirion AG vendor id
>>>   iio: humidity: sht31: add Sensirion SHT31 support
>>> 
>>>  .../devicetree/bindings/i2c/trivial-devices.txt    |   1 +
>>>  .../devicetree/bindings/vendor-prefixes.txt        |   1 +
>>>  drivers/iio/humidity/Kconfig                       |  11 +
>>>  drivers/iio/humidity/Makefile                      |   1 +
>>>  drivers/iio/humidity/sht31.c                       | 416 
>>> +++++++++++++++++++++
>>>  5 files changed, 430 insertions(+)
>>>  create mode 100644 drivers/iio/humidity/sht31.c
>>> 
>>> --
>>> 2.7.4
>>> 
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-iio" 
>>> in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
