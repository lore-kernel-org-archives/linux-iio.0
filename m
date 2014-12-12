Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ie0-f181.google.com ([209.85.223.181]:39873 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967589AbaLLNdr (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 12 Dec 2014 08:33:47 -0500
Received: by mail-ie0-f181.google.com with SMTP id tp5so6656392ieb.26
        for <linux-iio@vger.kernel.org>; Fri, 12 Dec 2014 05:33:46 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <548AC0C7.90204@kernel.org>
References: <1417041765-12782-1-git-send-email-dbaryshkov@gmail.com>
	<5488D0DB.2060400@gmx.de>
	<548AC0C7.90204@kernel.org>
Date: Fri, 12 Dec 2014 17:33:46 +0400
Message-ID: <CALT56yNePjPtESQEcUDuHdX0q4z398gR9-szq=CMHWoJPJ5AGA@mail.gmail.com>
Subject: Re: [PATCH] iio: inkern: add iio_write_channel_raw
From: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

2014-12-12 13:17 GMT+03:00 Jonathan Cameron <jic23@kernel.org>:
> On 10/12/14 23:01, Hartmut Knaack wrote:
>> Dmitry Eremin-Solenikov schrieb am 26.11.2014 um 23:42:
>>> Introduce API for easy in-kernel setting of DAC values.
>>>
>> Looking good in general, but indentation of parameters could be
>> improved to align with opening parenthesis. See inline.
>>> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
> I've fixed up both Lars and Hartmut's comments and applied to the
> togreg branch of iio.git - initially pushed out as testing sometime
> later today.  Lots to catch up with first ;)

Thank you. I was under the pile of other patches, so didn't have time
to react to those comments.

-- 
With best wishes
Dmitry
