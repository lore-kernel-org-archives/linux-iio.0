Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www381.your-server.de ([78.46.137.84]:50652 "EHLO
	www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751505AbcEaNUa (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 31 May 2016 09:20:30 -0400
Subject: Re: [PATCH 2/7] iio: adc: ad7791: claim direct mode when writing
 frequency
To: Jonathan Cameron <jic23@kernel.org>,
	Daniel Baluta <daniel.baluta@gmail.com>,
	Alison Schofield <amsfield22@gmail.com>
References: <cover.1464115008.git.amsfield22@gmail.com>
 <b115a245427767bd4c2fd4242b7ee04a243008b3.1464115008.git.amsfield22@gmail.com>
 <CAEnQRZAdj1fn8ibNx1pCA44=DwDGP8yfMPwGfNCeiW24g97kJg@mail.gmail.com>
 <ba579602-3808-f193-f8c0-1edb40f911a7@kernel.org>
Cc: "Hennerich, Michael" <Michael.Hennerich@analog.com>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <574D8F92.4040405@metafoo.de>
Date: Tue, 31 May 2016 15:20:18 +0200
MIME-Version: 1.0
In-Reply-To: <ba579602-3808-f193-f8c0-1edb40f911a7@kernel.org>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/29/2016 07:06 PM, Jonathan Cameron wrote:
> On 25/05/16 11:34, Daniel Baluta wrote:
>> On Tue, May 24, 2016 at 10:16 PM, Alison Schofield <amsfield22@gmail.com> wrote:
>>> Driver was checking for direct mode and trying to lock it, but
>>> left a gap where mode could change before the desired operation.
>>> Use iio_device_claim_direct_mode() to guarantee device stays in
>>> direct mode.
>>>
>>> Signed-off-by: Alison Schofield <amsfield22@gmail.com>
>>> Cc: Daniel Baluta <daniel.baluta@gmail.com>
>>
>> Looks good to me. We could use an Acked-by from Lars here.
>>
>> Acked-by: Daniel Baluta <daniel.baluta@gmail.com>
> This one is a little more interesting.  I wonder if we wouldn't be better
> off taking the lock for the whole function rather than dropping it for
> short periods.

It will only be locked once. sysfs_streq() will only match for a single
item. But you are right the code could be refactored to make that more
clearer. First run the lookup look and then apply afterwards.

