Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33117 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753536AbcCILo2 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 9 Mar 2016 06:44:28 -0500
Received: by mail-wm0-f67.google.com with SMTP id n186so9510008wmn.0
        for <linux-iio@vger.kernel.org>; Wed, 09 Mar 2016 03:44:27 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <56E006FA.3040201@parrot.com>
References: <cover.1457459537.git.gregor.boirie@parrot.com>
	<26a4b9ab8ae9b40f9c96c51f12c977fdad36532f.1457459537.git.gregor.boirie@parrot.com>
	<CAEnQRZBsQ4_XPBXfuWu4WL_qLG7fo3ynsWfQ51v=Ya2O6-jXyQ@mail.gmail.com>
	<56DFF4D2.4000708@parrot.com>
	<56DFF594.8030603@posteo.de>
	<56E006FA.3040201@parrot.com>
Date: Wed, 9 Mar 2016 13:44:26 +0200
Message-ID: <CAEnQRZCrXSPaJEzVSBEf6Tvv9htrFHKhWZW4zkJZxdvZ8=awuA@mail.gmail.com>
Subject: Re: [PATCH v5 1/1] Fixes: 3145229f9191 ("iio:pressure:ms5611: power
 regulator support")
From: Daniel Baluta <daniel.baluta@intel.com>
To: Gregor Boirie <gregor.boirie@parrot.com>
Cc: Martin Kepplinger <martink@posteo.de>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Daniel Baluta <daniel.baluta@intel.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, Mar 9, 2016 at 1:20 PM, Gregor Boirie <gregor.boirie@parrot.com> wrote:
>
>
> On 03/09/2016 11:06 AM, Martin Kepplinger wrote:
>>
>> Am 2016-03-09 um 11:02 schrieb Gregor Boirie:
>>>
>>> Hi Daniel,
>>>
>>> On 03/08/2016 10:16 PM, Daniel Baluta wrote:
>>>>
>>>> On Tue, Mar 8, 2016 at 8:00 PM, Gregor Boirie
>>>> <gregor.boirie@parrot.com> wrote:
>>>>>
>>>>> When not compiled-in, regulator layer will return a NULL pointer when
>>>>> trying to get a reference to any regulator using
>>>>> devm_regulator_get().  As
>>>>> IS_ERR() does not consider this an error, the ms5611 probing
>>>>> operation will
>>>>> try to enable a NULL regulator, which will invariably cause a kernel
>>>>> crash.
>>>>> This patch fixes this situation by using devm_regulator_get_optional()
>>>>> instead of devm_regulator_get().
>>>>>
>>>>> Signed-off-by: Gregor Boirie <gregor.boirie@parrot.com>
>>>>
>>>> $Subject should be here. And the commit subject should be something
>>>> more appropriate like:
>>>>
>>>> iio: pressure: ms5611: Fix crash when ...
>>>
>>> I'm a bit lost here since when Jonathan asked for "a fixes tag" inclusion
>>> (http://permalink.gmane.org/gmane.linux.kernel.iio/22425), I supposed he
>>> meant a tag such as one described in the Documentation/SubmittingPatches
>>> file.
>>> My initial attempt was sent with the subject:
>>> "iio:pressure:ms5611: fix oops when probing regulator".

The initial subject was OK.

>>>
>>> Would you please be kind enough to give me some sort of rules as to when
>>> and how
>>> to write subject lines related to fixes patch ?
>>>
>> I guess you can just put in a "Fixes:" line, along with your
>> "Signed-off-by:" lines.
>
> Oh... <light bulb enlightenment/> ! I definitely need some decent manners
> lessons :)
> Thanks.

What Martin said :). For example, you can look at this patch:

https://lkml.org/lkml/2016/2/16/505

Daniel.
