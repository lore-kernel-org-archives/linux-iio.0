Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:36482 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756901AbbEVScC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 22 May 2015 14:32:02 -0400
Received: by paza2 with SMTP id a2so16605422paz.3
        for <linux-iio@vger.kernel.org>; Fri, 22 May 2015 11:32:02 -0700 (PDT)
From: Oliver King-Smith <oliverks@elementalsemi.com>
Content-Type: text/plain; charset=utf-8
Subject: Back porting bmg160 driver to 3.10.9 kernel
Message-Id: <435F7C92-8E78-4BF9-8477-2032CE54AD04@elementalsemi.com>
Date: Fri, 22 May 2015 11:31:58 -0700
To: linux-iio@vger.kernel.org, Rich.Surprenant@nuvation.com
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

I am trying to back port the bmg160 driver to the 3.10.9 kernel to work on an Android 4.4.x device.

The API for in ii_info has changed quite a bit between the 3.18 and the 3.10 kernel.  So this function won’t compile

static int bmg160_read_event(struct iio_dev *indio_dev,
                             const struct iio_chan_spec *chan,
                             enum iio_event_type type,
                             enum iio_event_direction dir,
                             enum iio_event_info info,
                             int *val, int *val2)
{
        struct bmg160_data *data = iio_priv(indio_dev);

        *val2 = 0;
        switch (info) {
        case IIO_EV_INFO_VALUE:
                *val = data->slope_thres & BMG160_SLOPE_THRES_MASK;
                break;
        default:
                return -EINVAL;
        }

        return IIO_VAL_INT;
}

The 3.10 prototype for this function is
        int (*read_event_value)(struct iio_dev *indio_dev,
                                u64 event_code,
                                int *val);

My question is what does IIO_EV_INFO_VALUE map to in the old event_code in the 3.10.9 kernel

Oliver

