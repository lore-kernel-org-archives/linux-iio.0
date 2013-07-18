Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-oa0-f46.google.com ([209.85.219.46]:45404 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751394Ab3GROGT (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 18 Jul 2013 10:06:19 -0400
Received: by mail-oa0-f46.google.com with SMTP id h1so4154870oag.5
        for <linux-iio@vger.kernel.org>; Thu, 18 Jul 2013 07:06:19 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <51E7F423.4000909@metafoo.de>
References: <CAP9ODKq7TkBnpQSvwMRT0Cdy5wwfDGZ3E0ddP5vHkEgmskbcyg@mail.gmail.com>
	<814feb73-b2b3-4f23-8066-4221b75ac0b9@email.android.com>
	<CAP9ODKr4qC3EuRwbx9=dcTMvYjT2sAMTdBBsYs_-Z82rQ0e2DQ@mail.gmail.com>
	<201307180531.02207.marex@denx.de>
	<877ggoxck1.fsf@parenteses.org>
	<51E7F423.4000909@metafoo.de>
Date: Thu, 18 Jul 2013 11:06:18 -0300
Message-ID: <CAP9ODKpgEYGgSg-+Uk=1BcrrOJJenGXL0jZTBZUFyUYTwahppg@mail.gmail.com>
Subject: Re: ADC setting for differential and single-ended channels
From: Otavio Salvador <otavio@ossystems.com.br>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Mario Domenech Goulart <mario@ossystems.com.br>,
	Marek Vasut <marex@denx.de>,
	Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, Jul 18, 2013 at 10:56 AM, Lars-Peter Clausen <lars@metafoo.de> wrote:
> On 07/18/2013 02:44 PM, Mario Domenech Goulart wrote:
>> On Thu, 18 Jul 2013 05:31:01 +0200 Marek Vasut <marex@denx.de> wrote:
>>> Therefore, the userland would have to export sysfs file for each of the channels
>>> where one would write if the channel is possitive(+) / negative(-) /
>>> not_connected(NC) and then trigger the start of sampling.
>>>
>>> What do you think?
>>
>> That sounds like an interesting option.  It's still not very clear to me
>> how to specify which input is reference to which input, but I suppose
>> that must be possible.
>
> I don't think Marek's idea is an option. The purpose of a generic framework
> is to hide device specific implementation details like this. Not to expose
> them, you don't need a framework for that.

Agreed.

>> As far as I understand, we have three options so far:
>>
>> a. Specify the channels configuration in the dt.  sysfs would expose the
>>    exact channels configuration as specified in the dt.
>>
>> b. Expose all the possible input combinations via sysfs and leave to
>>    userland to properly read channels.
>>
>> c. Expose the mux interface via sysfs, so that userland can configure
>>    channels.
>>
>> Does that sound right?
>
> I think a mixture of a) and b) will be the best solution. How exactly this
> is going to be implemented is something we still need to figure out though.

Ok, so let's go back to the start:

One alternative we discussed is to use two attributes in the dts as:

 ...
 #channels = <2>;
 channels = <0 3
                    1 2>;

So it'd take two channels. One composed by input 0 and input 3 and
another composed by input 1 and input 2.

On the another case, we'd use:

  ...
  #channels = <3>
  channels = <0 3
                     1 3
                     2 3>;

So it'd take three channels and all them comparing to input 3.

This allow for us to export only the working channel and in properly
configured way. Does it seems sensible? What are the problems with
this idea?

--
Otavio Salvador                             O.S. Systems
http://www.ossystems.com.br        http://projetos.ossystems.com.br
Mobile: +55 (53) 9981-7854            Mobile: +1 (347) 903-9750
