Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qg0-f41.google.com ([209.85.192.41]:57401 "EHLO
	mail-qg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753211AbaG3NYR (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 30 Jul 2014 09:24:17 -0400
Received: by mail-qg0-f41.google.com with SMTP id q107so1423112qgd.14
        for <linux-iio@vger.kernel.org>; Wed, 30 Jul 2014 06:24:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <53D8ECB9.1010503@metafoo.de>
References: <CA+TH9VkYTQOEaV4OX2HAZcpvXhgcP8e+Mp1m1otnX5v=OPbBCw@mail.gmail.com>
 <53D8ECB9.1010503@metafoo.de>
From: Angelo Compagnucci <angelo.compagnucci@gmail.com>
Date: Wed, 30 Jul 2014 15:23:36 +0200
Message-ID: <CA+TH9VkMzi1U1C1GagBTEcQ_3E4vGiKoa+2mz-MNiA8x4O5udQ@mail.gmail.com>
Subject: Re: Why drivers don't depend on CONFIG_REGULATOR?
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Lars,

I have this fixed regulator in my device tree:

adc_supply: fixedregulator {
  compatible = "regulator-fixed";
  regulator-name = "fixed-supply";
  regulator-min-microvolt = <3300000>;
  regulator-max-microvolt = <3300000>;
  regulator-boot-on;
};

With CONFIG_REGULATOR=y CONFIG_REGULATOR_FIXED_VOLTAGE=y:

# cat in_voltage0_raw in_voltage_scale
4095
0.805664062

4095 * 0.805664062 = 3299.19433389, OK wonderful!

With CONFIG_REGULATOR not set:

# cat in_voltage0_raw in_voltage_scale
4095
cat: read error: Invalid argument

How do you cope with something like this? Is this expected?

Thank you for your time!

2014-07-30 15:01 GMT+02:00 Lars-Peter Clausen <lars@metafoo.de>:
> On 07/30/2014 11:51 AM, Angelo Compagnucci wrote:
>>
>> Hello List,
>>
>> I wasted a little bit of my time this morning understanding why the
>> regulator I used in my device tree wasn't working, only to discover
>> later that the regulator support was not enabled in my config.
>>
>> I think that all the drivers that use a regulator should depend on the
>> CONFIG_REGULATOR.
>>
>> Is there a reason why any driver has "depends on REGULATOR" in their
>> Kconfig entry?
>>
>> Thank you for your time!
>
>
> Hi,
>
> A lot of drivers work just fine without regulator support enabled. When
> disabled the regulator API stubs itself out with dummy function that always
> succeed.
>
> - Lars
>



-- 
Profile: http://it.linkedin.com/in/compagnucciangelo
