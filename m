Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-072.synserver.de ([212.40.185.72]:1108 "EHLO
	smtp-out-069.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753840AbcC1Ix7 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 28 Mar 2016 04:53:59 -0400
Subject: Re: [PATCH 28/31] iio: gyro: use parity32 in adxrs450.c
To: Jonathan Cameron <jic23@kernel.org>,
	"zhaoxiu.zeng" <zhaoxiu.zeng@gmail.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>
References: <1458788612-4367-1-git-send-email-zhaoxiu.zeng@gmail.com>
 <56F78ED3.8080603@gmail.com> <56F8ECDE.3010701@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <56F8F045.7060409@metafoo.de>
Date: Mon, 28 Mar 2016 10:50:13 +0200
MIME-Version: 1.0
In-Reply-To: <56F8ECDE.3010701@kernel.org>
Content-Type: text/plain; charset=gbk
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/28/2016 10:35 AM, Jonathan Cameron wrote:
> On 27/03/16 08:42, zhaoxiu.zeng wrote:
>> From: Zeng Zhaoxiu <zhaoxiu.zeng@gmail.com>
>>
>> Signed-off-by: Zeng Zhaoxiu <zhaoxiu.zeng@gmail.com>
> Interesting.  Whilst obviously correct I wonder if this obscures the
> intent of the code a little. Lars, what do you think?

The parity function is newly introduced in this series and can be more
efficient that  just hw_weight() & 1 on certain architectures. Since the
result is the same using it is certainly an improvement. But ...

[...]
>> -	if (!(hweight32(tx) & 1))
>> -		tx |= ADXRS450_P;
>> +	tx |= !parity32(tx) * ADXRS450_P;

... this should still be

if (!parity32(tx))
	tx |= ADXRS450_P;

Otherwise it's a bit too much obfuscated for my taste. Just leave it to the
compiler to optimize it as it sees it fit.
