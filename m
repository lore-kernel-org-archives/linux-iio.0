Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lf0-f65.google.com ([209.85.215.65]:36434 "EHLO
	mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933565AbcALIX1 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 12 Jan 2016 03:23:27 -0500
MIME-Version: 1.0
In-Reply-To: <56941920.8020406@metafoo.de>
References: <1452540774-26410-1-git-send-email-ricardo.ribalda@gmail.com> <56941920.8020406@metafoo.de>
From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Date: Tue, 12 Jan 2016 09:23:06 +0100
Message-ID: <CAPybu_00PsgSzp1-TV98ndrh9jym+n=earLU=2w+L9R89=fi1g@mail.gmail.com>
Subject: Re: [PATCH v7] iio: add ad5761 DAC driver
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hello Lars

> And one wish for the future, please give people a chance a review and don't
> resend a new version of the patch every couple of hours. This will make the
> reviewers life a bit easier.

Sorry for the disturbance

>
>> diff --git a/include/linux/iio/dac/ad5761.h b/include/linux/iio/dac/ad5761.h
>> new file mode 100644
>> index 000000000000..2f3702309d61
>> --- /dev/null
>> +++ b/include/linux/iio/dac/ad5761.h
>
> This should go into include/linux/platform_data. That's where all new
> platform data include files should go.
>

v8 is not on https://github.com/ribalda/linux/tree/ad5761v8

I will send to the ML if there is no more comments on it by the end of the day.

Regards!


-- 
Ricardo Ribalda
