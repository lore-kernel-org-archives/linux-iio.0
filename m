Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f180.google.com ([209.85.192.180]:36535 "EHLO
	mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755204AbcCBWE7 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 2 Mar 2016 17:04:59 -0500
Received: by mail-pf0-f180.google.com with SMTP id 63so1536380pfe.3
        for <linux-iio@vger.kernel.org>; Wed, 02 Mar 2016 14:04:58 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (1.0)
Subject: Re: iio: imu: mpu6050: add mpu6500 register settings
From: Matt Ranostay <mranostay@gmail.com>
In-Reply-To: <20160302182144.GU5273@mwanda>
Date: Wed, 2 Mar 2016 14:04:55 -0800
Cc: matt.ranostay@intel.com, linux-iio@vger.kernel.org
Message-Id: <21021227-E4C9-4D25-BD2A-F9A42927B1FD@gmail.com>
References: <20160302181801.GA12744@mwanda> <20160302182144.GU5273@mwanda>
To: Dan Carpenter <dan.carpenter@oracle.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Will fix and submit this afternoon!

Sent from my iPhone

> On Mar 2, 2016, at 10:21, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> 
> I sent that too quickly.  The i2c version of inv_mpu_probe() has the
> same issue as well.
> 
>    drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c:134 inv_mpu_probe()
>    error: we previously assumed 'id' could be null (see line 119)
> 
> regards,
> dan carpenter
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
