Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:33289 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751209AbdEEVRg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 5 May 2017 17:17:36 -0400
MIME-Version: 1.0
In-Reply-To: <0DAF21CFE1B20740AE23D6AF6E54843F1E8BCDB2@IRSMSX101.ger.corp.intel.com>
References: <20170504180136.27025-1-martin.blumenstingl@googlemail.com>
 <20170504180136.27025-2-martin.blumenstingl@googlemail.com> <0DAF21CFE1B20740AE23D6AF6E54843F1E8BCDB2@IRSMSX101.ger.corp.intel.com>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Fri, 5 May 2017 23:17:14 +0200
Message-ID: <CAFBinCCQ=rhB9xrv7uPQhNFGHOCgSwEBFuCj1Xu-hVivdxu-Ng@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] iio: adc: meson-saradc: mark all
 meson_sar_adc_data static and const
To: "Langer, Thomas" <thomas.langer@intel.com>
Cc: "jic23@kernel.org" <jic23@kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "carlo@caione.org" <carlo@caione.org>,
        "khilman@baylibre.com" <khilman@baylibre.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-amlogic@lists.infradead.org"
        <linux-amlogic@lists.infradead.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Thomas,

On Thu, May 4, 2017 at 9:07 PM, Langer, Thomas <thomas.langer@intel.com> wrote:
> Hello Martin,
>
>>
>> These are only passed as of_device_id.data and never modified. Thus we
>> can mark them as static const, just like the of_device_id instances
>> where they are used.
>
> Here you talk about static const, but in the code below the const is missing.
indeed - excellent catch, thank you! I'll fix this in v4

>>
>> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>> ---
>>  drivers/iio/adc/meson_saradc.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/iio/adc/meson_saradc.c
>> b/drivers/iio/adc/meson_saradc.c
>> index dd4190b50df6..1cb5df306001 100644
>> --- a/drivers/iio/adc/meson_saradc.c
>> +++ b/drivers/iio/adc/meson_saradc.c
>> @@ -834,17 +834,17 @@ static const struct iio_info meson_sar_adc_iio_info
>> = {
>>       .driver_module = THIS_MODULE,
>>  };
>>
>> -struct meson_sar_adc_data meson_sar_adc_gxbb_data = {
>> +static struct meson_sar_adc_data meson_sar_adc_gxbb_data = {
>>       .resolution = 10,
>>       .name = "meson-gxbb-saradc",
>>  };
>>
>> -struct meson_sar_adc_data meson_sar_adc_gxl_data = {
>> +static struct meson_sar_adc_data meson_sar_adc_gxl_data = {
>>       .resolution = 12,
>>       .name = "meson-gxl-saradc",
>>  };
>>
>> -struct meson_sar_adc_data meson_sar_adc_gxm_data = {
>> +static struct meson_sar_adc_data meson_sar_adc_gxm_data = {
>>       .resolution = 12,
>>       .name = "meson-gxm-saradc",
>>  };
>> --
>> 2.12.2
>>
>
