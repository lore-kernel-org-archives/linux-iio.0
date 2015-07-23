Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:55908 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753389AbbGWTxO (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 23 Jul 2015 15:53:14 -0400
Subject: Re: [PATCH v3 2/2] iio: light: add APDS9960 ALS + promixity driver
To: Matt Ranostay <mranostay@gmail.com>
References: <1436754043-6232-1-git-send-email-mranostay@gmail.com>
 <1436754043-6232-3-git-send-email-mranostay@gmail.com>
 <55AB7FBE.1060707@kernel.org>
 <CAKzfze_2wchApiDHRaCWTgRWL_eep42hOdyXHnrE4Ox6UVxK5A@mail.gmail.com>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	=?UTF-8?Q?Marek_Va=c5=a1ut?= <marex@denx.de>,
	linux-pm@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <55B14627.5040903@kernel.org>
Date: Thu, 23 Jul 2015 20:53:11 +0100
MIME-Version: 1.0
In-Reply-To: <CAKzfze_2wchApiDHRaCWTgRWL_eep42hOdyXHnrE4Ox6UVxK5A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

<snip>
>>> +static int apds9960_read_raw(struct iio_dev *indio_dev,
>>> +                          struct iio_chan_spec const *chan,
>>> +                          int *val, int *val2, long mask)
>>> +{
>>> +     struct apds9960_data *data = iio_priv(indio_dev);
>>> +     u16 buf;
>>> +     int ret = -EINVAL;
>>> +
>>> +     if (data->gesture_mode_running)
>>> +             return -EBUSY;
>>> +
>>> +     switch (mask) {
>>> +     case IIO_CHAN_INFO_RAW:
>>> +             apds9960_set_power_state(data, true);
>>> +             switch (chan->type) {
>>> +             case IIO_PROXIMITY:
>>> +                     if (chan->scan_index == -1) {
>>> +                             ret = regmap_read(data->regmap,
>>> +                                               chan->address, val);
>>> +                             if (!ret)
>>> +                                     ret = IIO_VAL_INT;
>>> +                     } else {
>> If the channels don't have explicity channel mask entries for a polled
>> read then there will be no way of reading them anyway except through the
>> buffered interface.
> 
> What context do you mean by channel mask entries?
.info_mask_separate = BIT(IIO_CHAN_INFO_RAW)  - or the processed variant.
> 
>>> +                             /*
>>> +                              * Cannot poll the GESTURE channels which are
>>> +                              * just usable with triggered buffers.
>>> +                              */
>>> +                             ret = -EBUSY;
>>> +                     }
>>> +                     break;
<snip>

