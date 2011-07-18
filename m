Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:54265 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750991Ab1GRNlv (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 18 Jul 2011 09:41:51 -0400
Message-ID: <4E243822.6020204@cam.ac.uk>
Date: Mon, 18 Jul 2011 14:41:54 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: michael.hennerich@analog.com
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"device-drivers-devel@blackfin.uclinux.org"
	<device-drivers-devel@blackfin.uclinux.org>,
	Drivers <Drivers@analog.com>
Subject: Re: [PATCH 2/2] iio: adc: New driver for AD7280A Lithium Ion Battery
 Monitoring System
References: <1310734743-2623-1-git-send-email-michael.hennerich@analog.com> <1310734743-2623-2-git-send-email-michael.hennerich@analog.com> <4E241C45.5090902@cam.ac.uk> <4E242BA8.8020006@analog.com> <4E242D8C.8080300@cam.ac.uk> <4E2436E0.9060501@analog.com>
In-Reply-To: <4E2436E0.9060501@analog.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


>>>>> +
>>>>> +static int ad7280_read_raw(struct iio_dev *dev_info,
>>>>> +                        struct iio_chan_spec const *chan,
>>>>> +                        int *val,
>>>>> +                        int *val2,
>>>>> +                        long m)
>>>>> +{
>>>>> +     struct ad7280_state *st = iio_priv(dev_info);
>>>>> +     unsigned int scale_uv;
>>>>> +     int ret;
>>>>> +
>>>>> +     switch (m) {
>>>>> +     case 0:
>>>>> +             mutex_lock(&dev_info->mlock);
>>>>> +             switch (chan->type) {
>>>>> +             case IIO_IN:
>>>>> +                     ret = ad7280_read_channel(st, chan->address>>   8,
>>>>> +                                               chan->address&   0xFF);
>>>>> +                     break;
>>>>> +             case IIO_IN_DIFF:
>>>>> +                     ret = ad7280_read_all_channels(st, st->scan_cnt, NULL);
>>>> Err... Really need some explanation for what this channel is!
>>> Voltage across all cells.
>> Fair enough. So are the other voltages not differential as well? (across a given
>> cell rather than referred to a base voltage)
>> ...
> Yes technically seen they are all differential.
> 
Any cost in setting them up as such then?

in1-in0
in2-in1 etc
+
inX-in0 for your summed one?

