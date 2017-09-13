Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www381.your-server.de ([78.46.137.84]:48087 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751112AbdIMTXl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 13 Sep 2017 15:23:41 -0400
Subject: Re: [PATCH v2 1/2] include: linux: sysfs: Add __ATTR_NAMED macro
To: Greg KH <gregkh@linuxfoundation.org>,
        Jonathan Cameron <jic23@kernel.org>
Cc: Himanshi Jain <himshijain.hj@gmail.com>,
        devel@driverdev.osuosl.org, daniel.baluta@gmail.com,
        Michael.Hennerich@analog.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, nick.desaulniers@gmail.com,
        outreachy-kernel@googlegroups.com, pmeerw@pmeerw.net,
        knaack.h@gmx.de
References: <cover.1505291907.git.himshijain.hj@gmail.com>
 <2bc7a124ab925dd2c50aa8c778745d179777d50d.1505291907.git.himshijain.hj@gmail.com>
 <20170913180310.27cbf1b1@archlinux> <20170913185805.GB26390@kroah.com>
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <5e43ea4d-eab8-c4be-c5dc-2f862578d011@metafoo.de>
Date: Wed, 13 Sep 2017 21:23:31 +0200
MIME-Version: 1.0
In-Reply-To: <20170913185805.GB26390@kroah.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/13/2017 08:58 PM, Greg KH wrote:
> On Wed, Sep 13, 2017 at 06:03:10PM +0100, Jonathan Cameron wrote:
>> On Wed, 13 Sep 2017 14:14:07 +0530
>> Himanshi Jain <himshijain.hj@gmail.com> wrote:
>>
>>> Add __ATTR_NAMED macro similar to __ATTR but taking name as a
>>> string instead of implicit conversion of argument to string using
>>> the macro _stringify(_name).
>>>
>>> Signed-off-by: Himanshi Jain <himshijain.hj@gmail.com>
>>> ---
>>>  include/linux/sysfs.h | 7 +++++++
>>>  1 file changed, 7 insertions(+)
>>>
>>> diff --git a/include/linux/sysfs.h b/include/linux/sysfs.h
>>> index aa02c32..20321cf 100644
>>> --- a/include/linux/sysfs.h
>>> +++ b/include/linux/sysfs.h
>>> @@ -104,6 +104,13 @@ struct attribute_group {
>>>  	.store	= _store,						\
>>>  }
>>>  
>>> +#define __ATTR_NAMED(_name, _mode, _show, _store) {			\
>>
>> I'm not sure about the naming here.  The normal __ATTR macro is also
>> 'named'.  Maybe something as awful as
>>
>> __ATTR_STRING_NAME ? 
>>
>> Greg what do you think?
> 
> ick ick ick.
> 
>> This is all to allow us to have names with operators in them without
>> checkpatch complaining about them... A worthwhile aim just to stop
>> more people wasting time trying to 'fix' those cases by adding spaces.
> 
> Yeah, but this really seems "heavy" for just a crazy sysfs name in a
> macro.  Adding a whole new "core" define for that is a hard sell...
> 
> I also want to get rid of the "generic" __ATTR type macros, and force
> people to use the proper _RW and friends instead.  I don't want to add
> another new one that people will start to use that I later have to
> change...
> 
> So no, I don't like this, how about just changing your macros instead?
> No one else has this problem :)

Nobody else realized they have this problem yet. E.g. there are a few users
of __ATTR in block/genhd.c that have the same issue and are likely to
generate the same false positives from static checkers.

