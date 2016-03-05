Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:56828 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750709AbcCERun (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 5 Mar 2016 12:50:43 -0500
Subject: Re: iio: imu: mpu6050: add mpu6500 register settings
To: Matt Ranostay <mranostay@gmail.com>,
	Dan Carpenter <dan.carpenter@oracle.com>
References: <20160302181801.GA12744@mwanda> <20160302182144.GU5273@mwanda>
 <21021227-E4C9-4D25-BD2A-F9A42927B1FD@gmail.com>
Cc: matt.ranostay@intel.com, linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56DB1C72.5060407@kernel.org>
Date: Sat, 5 Mar 2016 17:50:42 +0000
MIME-Version: 1.0
In-Reply-To: <21021227-E4C9-4D25-BD2A-F9A42927B1FD@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 02/03/16 22:04, Matt Ranostay wrote:
> Will fix and submit this afternoon!
> 
> Sent from my iPhone
> 
>> On Mar 2, 2016, at 10:21, Dan Carpenter <dan.carpenter@oracle.com> wrote:
>>
>> I sent that too quickly.  The i2c version of inv_mpu_probe() has the
>> same issue as well.
>>
>>    drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c:134 inv_mpu_probe()
>>    error: we previously assumed 'id' could be null (see line 119)
>>
>> regards,
>> dan carpenter
Whilst true, I'm now wondering why we assumed it might be.  Paranoia perhaps?
Hmm, guess we should keep it consistent (he says having just bounced this
back to Matt)- I'll take it as is but as a cleanup rather than a fix.

J
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

