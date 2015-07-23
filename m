Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:55758 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753295AbbGWTZS (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 23 Jul 2015 15:25:18 -0400
Subject: Re: [PATCH v3 1/2] iio: fix drivers that consider 0 as a valid IRQ in
 client->irq
To: Octavian Purdila <octavian.purdila@intel.com>,
	Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
References: <1433512783-8183-1-git-send-email-octavian.purdila@intel.com>
 <1433512783-8183-2-git-send-email-octavian.purdila@intel.com>
 <CAE1zotJ_u+ysf+HkD=4=Nv_mJ-4++SZxjKGMRkbKzYzyunLJUg@mail.gmail.com>
 <20150723140516.A3C9E4314B@saturn.retrosnub.co.uk>
 <CAE1zotJiuHsicKuPwyK_rKRY9qDyLV=nFEqJ4ATuroN924nHVg@mail.gmail.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	rtc-linux@googlegroups.com, lkml <linux-kernel@vger.kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <55B13F9B.1030905@kernel.org>
Date: Thu, 23 Jul 2015 20:25:15 +0100
MIME-Version: 1.0
In-Reply-To: <CAE1zotJiuHsicKuPwyK_rKRY9qDyLV=nFEqJ4ATuroN924nHVg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 23/07/15 15:38, Octavian Purdila wrote:
> On Thu, Jul 23, 2015 at 5:05 PM, <jic23@jic23.retrosnub.co.uk> wrote:
>>
>> Octavian Purdila writes:
>>>
>>> On Fri, Jun 5, 2015 at 4:59 PM, Octavian Purdila
>>> <octavian.purdila@intel.com> wrote:
>>>>
>>>> Since patch "i2c / ACPI: Use 0 to indicate that device does not have
>>>> interrupt assigned" [1], 0 is not a valid i2c client irq anymore, so
>>>> change all driver's checks accordingly.
>>>> The same issue occurs when the device is instantiated via device tree
>>>> with no IRQ, or from the i2c sysfs interface, even before the patch
>>>> above.
>>>> [1] http://lkml.kernel.org/g/<1430908148-201129-3-git-send-email-mika.westerberg@linux.intel.com>
>>>> Signed-off-by: Octavian Purdila <octavian.purdila@intel.com>
>>>> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
>>>
>>>
>>> Hi Jonathan,
>>> Does this look OK to you? If so, could you pleas ACK the patch so that
>>> Linus can pick it up in its for-next branch if/when needed?
>>> Thanks,
>>> Tavi
>>
>> Hi Tavi,
>> This is fine, but is there a particular rush to get it in?
>> Otherwise I'll just take it through the IIO tree.
>> Acked-by: Jonathan Cameron <jic23@kernel.org>
> 
> Hi Jonathan,
> 
> Didn't mean to rush things, I haven't seen any activity on this for
> some time and thought it was forgotten. 
A not entirely false assumption.  I'd marked it in my email as to be
applied then it got buried. oops and sorry about that.
> I was also confused with the
> status of Mika's patch, but now that I learned it was merged in 4.2,
> its clear to me that this patch needs to go through the IIO tree.
> 
Applied to the togreg branch of iio.git - initially pushed out as
testing for autobuilders to play with it.

Thanks,

Jonathan
> Thanks,
> Tavi
> 
A
