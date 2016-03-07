Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ig0-f174.google.com ([209.85.213.174]:37486 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752151AbcCGITL (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 7 Mar 2016 03:19:11 -0500
Received: by mail-ig0-f174.google.com with SMTP id z8so34368343ige.0
        for <linux-iio@vger.kernel.org>; Mon, 07 Mar 2016 00:19:11 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <56DB1C72.5060407@kernel.org>
References: <20160302181801.GA12744@mwanda>
	<20160302182144.GU5273@mwanda>
	<21021227-E4C9-4D25-BD2A-F9A42927B1FD@gmail.com>
	<56DB1C72.5060407@kernel.org>
Date: Mon, 7 Mar 2016 10:19:10 +0200
Message-ID: <CABjU8GuKAD3v48uEAXE_UmTr0q8zO=w5jLBdEa3fdkN-enTCPQ@mail.gmail.com>
Subject: Re: iio: imu: mpu6050: add mpu6500 register settings
From: Adriana Reus <adi.reus@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Matt Ranostay <mranostay@gmail.com>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	matt.ranostay@intel.com, linux-iio@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

My understanding from the previous commits is that it might be NULL
when enumerating via ACPI (I didn't dig into core to check this so I'm
not able to confirm if that is still the case).
(commit: 4f33fbae555000bf73aaacbc4f5b24668afc8c7a)

On Sat, Mar 5, 2016 at 7:50 PM, Jonathan Cameron <jic23@kernel.org> wrote:
> On 02/03/16 22:04, Matt Ranostay wrote:
>> Will fix and submit this afternoon!
>>
>> Sent from my iPhone
>>
>>> On Mar 2, 2016, at 10:21, Dan Carpenter <dan.carpenter@oracle.com> wrote:
>>>
>>> I sent that too quickly.  The i2c version of inv_mpu_probe() has the
>>> same issue as well.
>>>
>>>    drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c:134 inv_mpu_probe()
>>>    error: we previously assumed 'id' could be null (see line 119)
>>>
>>> regards,
>>> dan carpenter
> Whilst true, I'm now wondering why we assumed it might be.  Paranoia perhaps?
> Hmm, guess we should keep it consistent (he says having just bounced this
> back to Matt)- I'll take it as is but as a cleanup rather than a fix.
>
> J
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
