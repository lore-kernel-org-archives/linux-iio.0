Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:32302 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753791AbbELU5G (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 12 May 2015 16:57:06 -0400
Message-ID: <5552690E.3060006@linux.intel.com>
Date: Tue, 12 May 2015 13:56:46 -0700
From: sathyanarayanan kuppuswamy
	<sathyanarayanan.kuppuswamy@linux.intel.com>
Reply-To: sathyanarayanan.kuppuswamy@linux.intel.com
MIME-Version: 1.0
To: Dan Carpenter <dan.carpenter@oracle.com>
CC: linux-iio@vger.kernel.org
Subject: Re: iio: ltr501: Add interrupt support
References: <20150512180941.GD5672@mwanda>
In-Reply-To: <20150512180941.GD5672@mwanda>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi

On 05/12/2015 11:09 AM, Dan Carpenter wrote:
> Hello Kuppuswamy Sathyanarayanan,
>
> The patch 7ac702b3144b: "iio: ltr501: Add interrupt support" from Apr
> 19, 2015, leads to the following static checker warning:
>
> 	drivers/iio/light/ltr501.c:869 ltr501_write_thresh()
> 	info: ignoring unreachable code.
>
> drivers/iio/light/ltr501.c
>     867          case IIO_PROXIMITY:
>     868                  switch (dir) {
>     869                  if (val > LTR501_PS_THRESH_MASK)
>     870                          return -EINVAL;
>
> Probably this code should be outside of this switch (dir) statement?
Agreed. I will send a patch with fix soon.
>
>     871                  case IIO_EV_DIR_RISING:
>     872                          mutex_lock(&data->lock_ps);
>     873                          ret = regmap_bulk_write(data->regmap,
>     874                                                  LTR501_PS_THRESH_UP,
>     875                                                  &val, 2);
>     876                          mutex_unlock(&data->lock_ps);
>     877                          return ret;
>     878                  case IIO_EV_DIR_FALLING:
>     879                          mutex_lock(&data->lock_ps);
>     880                          ret = regmap_bulk_write(data->regmap,
>     881                                                  LTR501_PS_THRESH_LOW,
>     882                                                  &val, 2);
>     883                          mutex_unlock(&data->lock_ps);
>     884                          return ret;
>     885                  default:
>     886                          return -EINVAL;
>     887                  }
>     888          default:
>     889                  return -EINVAL;
>     890          }
>     891
>     892          return -EINVAL;
>     893  }
>
> regards,
> dan carpenter
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

-- 
Sathyanarayanan Kuppuswamy
Android kernel developer

