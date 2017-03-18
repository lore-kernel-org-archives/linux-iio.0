Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:44142 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751715AbdCROT7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 18 Mar 2017 10:19:59 -0400
Subject: Re: [PATCH v2] staging: iio: adis16240: Remove mutex_lock() and
 mutex_unlock() function call.
To: Lars-Peter Clausen <lars@metafoo.de>,
        Varsha Rao <rvarsha016@gmail.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Barry Song <21cnbao@gmail.com>
References: <58c81906.42d5620a.3e22a.7a2b@mx.google.com>
 <39a0f2ff-5771-b287-60ca-b62ba330f31b@kernel.org>
 <08d175a1-af67-40f9-7301-7f7158347e3c@metafoo.de>
Cc: outreachy-kernel@googlegroups.com, linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <284ededc-23fc-fc97-be70-63c4b3ad2d55@kernel.org>
Date: Sat, 18 Mar 2017 14:19:56 +0000
MIME-Version: 1.0
In-Reply-To: <08d175a1-af67-40f9-7301-7f7158347e3c@metafoo.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 17/03/17 09:03, Lars-Peter Clausen wrote:
> On 03/15/2017 11:11 PM, Jonathan Cameron wrote:
>> On 14/03/17 16:23, Varsha Rao wrote:
>>> Remove mutex_lock() and mutex_unlock() function calls, as the
>>> adis16240_spi_read_signed() function can be run parallel and safely
>>> multiple times. Also remove the mutex.h header file and comment, which
>>> are no longer required.
>>>
>>> As indio_dev is declared and initialized in adis16240_spi_read_signed(),
>>> again declaration to same type and initialization to same value is not
>>> required, remove it from adis16240_read_12bit_signed().
>>>
>>> Simplify the return logic, by merging assignment and return into a single
>>> line.
>>>
>>> Signed-off-by: Varsha Rao <rvarsha016@gmail.com>
>> It's a bit obscure, but isn't there the potential to get the check_status
>> call spitting out text for the wrong read, or potentially miss a status
>> value entirely?
>>
>> (kind of more for Lars really, but feel free to comment Varsha!)
>>
>> The various faults look like this wouldn't be an issue, but I'm not
>> totally sure about the SPI failure and whether a following good read
>> at exactly the wrong time might result in the error not being reported...
> 
> I don't think it matters. The error reporting is asynchronous anyway and the
> bits are read-to-clear. So even if two access see the error flag set in the
> data only one of them will be able to read the bits in the diag_stat
> register (unless the error is persistent, in which case the error flag in
> the data would also be persistent).
Fair enough.

Applied to the togreg branch of iio.git - will push out as testing later
for the autobuilders to play with it.


Thanks,

Jonathan
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

