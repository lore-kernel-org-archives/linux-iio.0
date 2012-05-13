Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailhost.informatik.uni-hamburg.de ([134.100.9.70]:51382 "EHLO
	mailhost.informatik.uni-hamburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751761Ab2EMHY3 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 13 May 2012 03:24:29 -0400
Message-ID: <4FAF61CF.6070509@metafoo.de>
Date: Sun, 13 May 2012 09:25:03 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Roland Stigge <stigge@antcom.de>
CC: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/3] staging:iio:dac:max517: Convert to channel spec
References: <1336755862-24184-1-git-send-email-lars@metafoo.de> <1336755862-24184-2-git-send-email-lars@metafoo.de> <4FAEB14A.8020408@kernel.org> <4FAED9AD.4020803@antcom.de>
In-Reply-To: <4FAED9AD.4020803@antcom.de>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/12/2012 11:44 PM, Roland Stigge wrote:
> Hi,
> 
> On 12/05/12 20:51, Jonathan Cameron wrote:
>> On 05/11/2012 06:04 PM, Lars-Peter Clausen wrote:
>>> Convert the max517 driver to channel spec. As part of the conversion the
>>> "out_voltage_1&2_raw" property, which updates both channel 1 and 2
>>> simultaneously with the same value, is lost, since this is not really covered by
>>> the IIO spec.
>> We'll have to introduce a buffered option for output at somepoint to
>> cover the equivalent of that out_voltage_1&2_raw attribute.
>>
>> Roland, how vital was that to you?
> 
> I'm generally fine with the proposed changes and can ack it. However, we
> should provide a replacement for the old "1&2" attribute. It supports a
> certain hardware feature of this chip. No need to sacrifice it.

I don't think it makes sense to keep it in it's current form. First of all this
isn't really covered by the IIO spec to have one attribute which changes two
(or more) output at once and secondly it is artificially limited to setting the
same value on both outputs, while the chip doesn't have this limitations and
you can set different values on both outputs at once. So I'm not so sure how
useful it even is in it's current form.

The proper solution for this is to implement buffered support for output
devices and I do have some experimental code for that. But I'd like to move the
DACs out of staging. And this driver is sort of the main blocker right now. If
you insist on keeping the "1&2" attribute, I guess it's best to just leave the
max517 in staging for now, while we move the other DAC drivers out.

- Lars
