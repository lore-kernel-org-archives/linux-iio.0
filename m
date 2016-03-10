Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.aswsp.com ([193.34.35.150]:30861 "EHLO mail.aswsp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932691AbcCJJwN (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Thu, 10 Mar 2016 04:52:13 -0500
Message-ID: <56E143F5.6040606@parrot.com>
Date: Thu, 10 Mar 2016 10:52:53 +0100
From: Gregor Boirie <gregor.boirie@parrot.com>
MIME-Version: 1.0
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>,
	<linux-iio@vger.kernel.org>
Subject: Re: [PATCH v6 0/1] iio:pressure:ms5611: fix and enhancements
References: <cover.1457522751.git.gregor.boirie@parrot.com> <56E0BAC8.2080607@samsung.com>
In-Reply-To: <56E0BAC8.2080607@samsung.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

You appeared since get_maintainer.pl printed your address for v3
of this patch modifying drivers/iio/pressure/ms5611_i2c.c
because of 215597 ("iio: Drop owner assignment from i2c_driver").

I did not take time to update addresses list for later versions.
Sorry about that. I took you out of CC list.
Regards

On 03/10/2016 01:07 AM, Krzysztof Kozlowski wrote:
> On 09.03.2016 20:34, Gregor Boirie wrote:
>> Changes since v1:
>> * temperature compensation fix:
>>      * reword commit message
>>      * remove useless parenthesis
>> * power regulator: reword commit message
>> * add oversampling rate support
>>
>> Changes since v2:
>> * remove non printable characters from commit messages
>>
>> Changes since v3:
>> * drop first 3 patches since applied onto testing
>> * fix oops at regulator probing time if regulator support not compiled-in
>> * complete device-tree support and documentation
>> * remove continuous sampling support (see Jonathan's "kthread tight loop
>>    trigger" proposal)
>> * checkpatch'ed
>>
>> Changes since v4:
>> * drop first 2 patches since applied
>> * amend commit to include "Fixes" tag
>>
>> Changes since v5:
>> * reword patch subject line and include "Fixes" tag in commit message
>>
>> Gregor Boirie (1):
>>    iio:pressure:ms5611: fix crash when probing regulator
>>
>>   drivers/iio/pressure/ms5611_core.c | 8 ++++++--
> Really, how the heck you connected my humble person with this file?
> get_maintainer.pl does not print me. Even when run with --git argument.
>
> BR,
> Krzysztof
>
>

