Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-193.synserver.de ([212.40.185.193]:1031 "EHLO
	smtp-out-193.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1945920AbbEWIuQ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 23 May 2015 04:50:16 -0400
Message-ID: <55603F40.2030709@metafoo.de>
Date: Sat, 23 May 2015 10:50:08 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Oliver King-Smith <oliverks@elementalsemi.com>,
	linux-iio@vger.kernel.org, Rich.Surprenant@nuvation.com
Subject: Re: Back porting bmg160 driver to 3.10.9 kernel
References: <435F7C92-8E78-4BF9-8477-2032CE54AD04@elementalsemi.com>
In-Reply-To: <435F7C92-8E78-4BF9-8477-2032CE54AD04@elementalsemi.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/22/2015 08:31 PM, Oliver King-Smith wrote:
> I am trying to back port the bmg160 driver to the 3.10.9 kernel to work on an Android 4.4.x device.
>
> The API for in ii_info has changed quite a bit between the 3.18 and the 3.10 kernel.  So this function won’t compile
>
> static int bmg160_read_event(struct iio_dev *indio_dev,
>                               const struct iio_chan_spec *chan,
>                               enum iio_event_type type,
>                               enum iio_event_direction dir,
>                               enum iio_event_info info,
>                               int *val, int *val2)
> {
>          struct bmg160_data *data = iio_priv(indio_dev);
>
>          *val2 = 0;
>          switch (info) {
>          case IIO_EV_INFO_VALUE:
>                  *val = data->slope_thres & BMG160_SLOPE_THRES_MASK;
>                  break;
>          default:
>                  return -EINVAL;
>          }
>
>          return IIO_VAL_INT;
> }
>
> The 3.10 prototype for this function is
>          int (*read_event_value)(struct iio_dev *indio_dev,
>                                  u64 event_code,
>                                  int *val);
>
> My question is what does IIO_EV_INFO_VALUE map to in the old event_code in the 3.10.9 kernel

Nothing. With the old API events could only have values and no other attributes.

- Lars

