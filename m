Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-la0-f54.google.com ([209.85.215.54]:34352 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750749AbbFMScu (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 13 Jun 2015 14:32:50 -0400
MIME-Version: 1.0
In-Reply-To: <557C749E.2090005@kernel.org>
References: <1434037774-22081-1-git-send-email-daniel.baluta@intel.com>
	<1434037774-22081-3-git-send-email-daniel.baluta@intel.com>
	<20150612074046.GB14044@vdogaru>
	<557C749E.2090005@kernel.org>
Date: Sat, 13 Jun 2015 21:32:48 +0300
Message-ID: <CAEnQRZA1VZF47MHLm0sPkmgFtNVjtNMMPzB7gNDWhD4qmcqXDg@mail.gmail.com>
Subject: Re: [PATCH 2/2] iio: proximity: sx9500: Fix proximity value
From: Daniel Baluta <daniel.baluta@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Vlad Dogaru <vlad.dogaru@intel.com>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Tiberiu Breana <tiberiu.a.breana@intel.com>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, Jun 13, 2015 at 9:21 PM, Jonathan Cameron <jic23@kernel.org> wrote:
> On 12/06/15 08:40, Vlad Dogaru wrote:
>> On Thu, Jun 11, 2015 at 06:49:34PM +0300, Daniel Baluta wrote:
>>> Because of the ABI confusion proximity value exposed by SX9500
>>> was inverted.
>>>
>>> Signed-off-by: Daniel Baluta <daniel.baluta@intel.com>
>>
>> Reviewed-by: Vlad Dogaru <vlad.dogaru@intel.com>
>>
>> Sorry for causing the confusion, it was the only proximity sensor I had
>> encountered to date.
> Greg,
>
> I've cc'd you to let you know that this fix causes an ABI change for
> one driver.  Technically that driver actually matched with the current documentation,
> just the documentation was misleading and lots of drivers have ended up with
> the reverse interpretation (question was whether proximity values get larger
> or smaller as you get nearer).
>
> Anyhow, given timing I doubt the pull request will reach you until after the
> merge window.  I am also going to mark this for stable to cover the 4.0 and 4.1
> kernels that have this driver in them.
>
> Hope that's fine!
>
> Applied to the fixes-togreg branch of iio.git
>
> Daniel, thanks for clearing this mess up and checking through all the drivers
> and datasheets to figure out it was only this one!

You are welcome. Also, lets not forget that as mentioned in the cover letter
there is still one driver that needs to be fixed. That is stk3310,
where the fix is not
trivial, but I have already talked with Tiberiu and he will take care of it.

thanks,
Daniel.
