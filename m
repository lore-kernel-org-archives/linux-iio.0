Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:23558 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756262AbcCBSVx (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 2 Mar 2016 13:21:53 -0500
Date: Wed, 2 Mar 2016 21:21:44 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: matt.ranostay@intel.com
Cc: linux-iio@vger.kernel.org
Subject: Re: iio: imu: mpu6050: add mpu6500 register settings
Message-ID: <20160302182144.GU5273@mwanda>
References: <20160302181801.GA12744@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160302181801.GA12744@mwanda>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

I sent that too quickly.  The i2c version of inv_mpu_probe() has the
same issue as well.

	drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c:134 inv_mpu_probe()
	error: we previously assumed 'id' could be null (see line 119)

regards,
dan carpenter

