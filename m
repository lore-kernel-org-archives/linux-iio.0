Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qk0-f176.google.com ([209.85.220.176]:35473 "EHLO
	mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751148AbcGWQiJ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 23 Jul 2016 12:38:09 -0400
MIME-Version: 1.0
In-Reply-To: <CB140955-28B8-41F1-BEEA-2F20F833267D@jic23.retrosnub.co.uk>
References: <CAHNg1Spjoao_fndWBP7mzE=ORMGK=vSUsVmN+EPvwv912-0KqA@mail.gmail.com>
 <CB140955-28B8-41F1-BEEA-2F20F833267D@jic23.retrosnub.co.uk>
From: Pratik Prajapati <pratik.prajapati12@gmail.com>
Date: Sat, 23 Jul 2016 22:08:07 +0530
Message-ID: <CAHNg1SorRwoDQowDa=+wdrEfmNg+9esw-Jbfxm1nO+0DZWBtBA@mail.gmail.com>
Subject: Re: How to support multiple chips in single driver
To: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, Jul 23, 2016 at 8:37 PM, Jonathan Cameron
<jic23@jic23.retrosnub.co.uk> wrote:
>
>
> On 23 July 2016 14:36:39 BST, Pratik Prajapati <pratik.prajapati12@gmail.com> wrote:
>>Hi,
>>
>>I want to add the threshold, event handling and interrupts support in
>>vcnl4000 driver but those functionalities are not supported in
>>vcnl4000, but supported in vcnl4010 .
>>
>>Do we have an example (IIO driver) of supporting multiple chips in a
>>single driver?
> Lots. E.g. adc\max1636.
I couldn't found max1636
https://git.kernel.org/cgit/linux/kernel/git/jic23/iio.git/tree/drivers/iio/adc?h=testing
and https://github.com/torvalds/linux/tree/master/drivers/iio/adc
Or is that adc/max1363?
