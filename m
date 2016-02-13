Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-yw0-f193.google.com ([209.85.161.193]:36164 "EHLO
	mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750993AbcBMTFm (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 13 Feb 2016 14:05:42 -0500
Received: by mail-yw0-f193.google.com with SMTP id h80so5872883ywc.3
        for <linux-iio@vger.kernel.org>; Sat, 13 Feb 2016 11:05:42 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <56BF30B8.4040808@kernel.org>
References: <1455277485-19101-1-git-send-email-adriana.reus@intel.com>
 <1455277485-19101-2-git-send-email-adriana.reus@intel.com> <56BF30B8.4040808@kernel.org>
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
Date: Sat, 13 Feb 2016 16:51:06 -0200
Message-ID: <CAKi4VA+BSR+-u9Q3kRQFnFMZTi=0iNgSbc7wuTcyOd5m3etx4Q@mail.gmail.com>
Subject: Re: [PATCH v6 1/4] iio: imu: inv-mpu6050: Fix interrupt pin configuration
To: Jonathan Cameron <jic23@kernel.org>
Cc: Adriana Reus <adriana.reus@intel.com>, linux-iio@vger.kernel.org,
	srinivas.pandruvada@linux.intel.com, ggao@invensense.com,
	lars@metafoo.de, Daniel Baluta <daniel.baluta@intel.com>,
	Adriana Reus <adi.reus@gmail.com>, Crt Mori <cmo@melexis.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Jonathan,

On Sat, Feb 13, 2016 at 11:33 AM, Jonathan Cameron <jic23@kernel.org> wrote:
> On 12/02/16 11:44, Adriana Reus wrote:
>> The select/deselect_bypass duo writes the irq number into the interrupt
>> configuration register.
>> If there is a i2c slave device connected to the mpu (eg. a magnetometer)
>> then this can hinder interrupt delivery for the accelerometer and
>> gyroscope.
>> Set this register to the default configuration.
>>
>> Signed-off-by: Adriana Reus <adriana.reus@intel.com>
> Applied to the togreg branch of iio.git - initially pushed out as testing for
> the autobuilders to play with it.
>
> Given chances have been pretty minor in last few days I'm happy
> enough taking the series as is.  If anyone feels they want to
> add an ack / reviewed by that's fine but I will probably be sending
> a pull request sometime later this weekend so you need to beat that!

I reviewed the entire series and all my comments from previous
versions were fixed. You can add my reviewed-by.

Reviewed-by: Lucas De Marchi <lucas.demarchi@intel.com>



Lucas De Marchi
