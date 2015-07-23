Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ob0-f175.google.com ([209.85.214.175]:36339 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752629AbbGWNbm (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 23 Jul 2015 09:31:42 -0400
Received: by obnw1 with SMTP id w1so153507785obn.3
        for <linux-iio@vger.kernel.org>; Thu, 23 Jul 2015 06:31:41 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAE1zotJCkdoStrh0CAFh8aoQr0+AZD-OCJX9B2BNPAAs9cgbxg@mail.gmail.com>
References: <1433512783-8183-1-git-send-email-octavian.purdila@intel.com>
	<1433512783-8183-2-git-send-email-octavian.purdila@intel.com>
	<CAE1zotJ_u+ysf+HkD=4=Nv_mJ-4++SZxjKGMRkbKzYzyunLJUg@mail.gmail.com>
	<CACRpkdYE2HG3Cm74Hg9jXy2FwvwveqpbJbwTPKvmOm6aR7BNmQ@mail.gmail.com>
	<CAE1zotJCkdoStrh0CAFh8aoQr0+AZD-OCJX9B2BNPAAs9cgbxg@mail.gmail.com>
Date: Thu, 23 Jul 2015 15:31:41 +0200
Message-ID: <CACRpkdasoyFVrRzgL+M7LSMCY+oE5+1kBWnwZr17vgrzdA4jQg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] iio: fix drivers that consider 0 as a valid IRQ in client->irq
From: Linus Walleij <linus.walleij@linaro.org>
To: Octavian Purdila <octavian.purdila@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"rtc-linux@googlegroups.com" <rtc-linux@googlegroups.com>,
	lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, Jul 23, 2015 at 3:23 PM, Octavian Purdila
<octavian.purdila@intel.com> wrote:
> On Thu, Jul 23, 2015 at 4:11 PM, Linus Walleij <linus.walleij@linaro.org> wrote:

>> Me or Torvalds?
>>
>> This looks more like a Wolfram patch to me if it should not
>> go through IIO.
>>
>
> Hi Linus,
>
> This patch fixes one issue introduced by  "i2c / ACPI: Use 0 to
> indicate that device does not have interrupt assigned" which I see it
> is merged in the GPIO for-next branch. That is why I thought you will
> pick it up, did I assume wrong?

Aha yeah O already forgot that I merged that.

That patch is not in -next, it is already in Torvalds'
tree.

So fixes can be merged directly through the IIO tree
without any GPIO dependencies.

Yours,
Linus Walleij
