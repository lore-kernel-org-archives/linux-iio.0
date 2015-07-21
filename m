Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qg0-f46.google.com ([209.85.192.46]:32861 "EHLO
	mail-qg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751236AbbGUJPr (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 21 Jul 2015 05:15:47 -0400
MIME-Version: 1.0
In-Reply-To: <55AB73C3.5020206@metafoo.de>
References: <7d56ec6a8a6fdd76d8cc9abf4330c34061873920.1437229669.git.cristina.opriceana@gmail.com>
	<55AB72A3.7080105@kernel.org>
	<55AB73C3.5020206@metafoo.de>
Date: Tue, 21 Jul 2015 12:15:46 +0300
Message-ID: <CAFA9rWOZJX=v1FU3QzCJrhamOvS_XaVqQ5MENyFiT6SjiBsoOg@mail.gmail.com>
Subject: Re: [PATCH] iio: Fix iio_validate_scan_mask_oneshot function name typo
From: Cristina Georgiana Opriceana <cristina.opriceana@gmail.com>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	linux-kernel@vger.kernel.org,
	Daniel Baluta <daniel.baluta@intel.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, Jul 19, 2015 at 12:54 PM, Lars-Peter Clausen <lars@metafoo.de> wrote:
> On 07/19/2015 11:49 AM, Jonathan Cameron wrote:
>>
>> On 18/07/15 15:31, Cristina Opriceana wrote:
>>>
>>> Rename function to iio_validate_scan_mask_oneshot() since it's used to
>>> validate that only one channel is selected.
>>>
>>> Signed-off-by: Cristina Opriceana <cristina.opriceana@gmail.com>
>>
>> I'm sure Lars (who I think named it?) will come back with a fuller
>> response, but
>> I believe the naming (if not necessarily clear!) was deliberate.
>>
>> one hot - as in only one channel is enabled at a time.
>> oneshot - only a single reading of all channels is taken
>> (like a one shot interrupt).
>
>
> Yes. See https://en.wikipedia.org/wiki/One-hot
>
> Thanks.

Ah, I see. Thanks for the info!

Cristina
