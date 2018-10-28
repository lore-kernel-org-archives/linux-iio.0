Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qk1-f196.google.com ([209.85.222.196]:44041 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726492AbeJ2Bhs (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 28 Oct 2018 21:37:48 -0400
From: Renato Lui Geh <renatogeh@gmail.com>
Date: Sun, 28 Oct 2018 13:52:32 -0300
To: Jonathan Cameron <jic23@kernel.org>
Cc: Renato Lui Geh <renatogeh@gmail.com>, lars@metafoo.de,
        Michael.Hennerich@analog.com, knaack.h@gmx.de, pmeerw@pmeerw.net,
        gregkh@linuxfoundation.org, alexandru.Ardelean@analog.com,
        stefan.popa@analog.com, giuliano.belinassi@usp.br,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: Re: [PATCH v2 1/2] staging: iio: ad7780: update voltage on read
Message-ID: <20181028165231.2det3cq3u7r6qoxj@renatolg>
References: <cover.1540506298.git.renatogeh@gmail.com>
 <1f7b2c6ee0e18b1c43a8b27f482b08313c52d4e9.1540506298.git.renatogeh@gmail.com>
 <20181028155611.67abeafb@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
In-Reply-To: <20181028155611.67abeafb@archlinux>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Jonathan,

Thank you for the review.

>> +		voltage_uv = regulator_get_voltage(st->reg);
>> +		if (voltage_uv)
>> +			st->int_vref_mv = voltage_uv/1000;
>>  		*val = st->int_vref_mv * st->gain;
>Is there actually a reason (now) to have the stashed value
>of int_vref_mv in the state structure?

>From probe:

if (voltage_uv)
	st->int_vref_mv = voltage_uv / 1000;
else
	dev_warn(&spi->dev, "Reference voltage unspecified\n");

So the idea was to, when voltage_uv = 0, return the previous voltage.
Should I instead handle this as an error the same way as in probe?

Thanks,
Renato
