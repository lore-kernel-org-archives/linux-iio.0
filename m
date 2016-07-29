Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34288 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750806AbcG2Hkd (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 29 Jul 2016 03:40:33 -0400
Received: by mail-wm0-f68.google.com with SMTP id q128so14477263wma.1
        for <linux-iio@vger.kernel.org>; Fri, 29 Jul 2016 00:40:33 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAEnQRZBeTWZVX6+EEuy75we1HoDKoFEXs8oLMcTc0oFXytasxQ@mail.gmail.com>
References: <1469745637-998-1-git-send-email-mranostay@gmail.com> <CAEnQRZBeTWZVX6+EEuy75we1HoDKoFEXs8oLMcTc0oFXytasxQ@mail.gmail.com>
From: Matt Ranostay <mranostay@gmail.com>
Date: Fri, 29 Jul 2016 00:39:52 -0700
Message-ID: <CAKzfze9e3U5MjgbwQYn7_APnvDMJpX8ORrstsASrrbN6bp5UOg@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: ti-ads1015: fix incorrect referencing of
 ads1015_data pointer
To: Daniel Baluta <daniel.baluta@intel.com>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Giorgio <giorgio.nicole@arcor.de>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, Jul 28, 2016 at 11:19 PM, Daniel Baluta <daniel.baluta@intel.com> wrote:
> On Fri, Jul 29, 2016 at 1:40 AM, Matt Ranostay <mranostay@gmail.com> wrote:
>> Reported-by: Giorgio <giorgio.nicole@arcor.de>
>> Cc: Daniel Baluta <daniel.baluta@intel.com>
>> Signed-off-by: Matt Ranostay <mranostay@gmail.com>
>> ---
>>  drivers/iio/adc/ti-ads1015.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
>> index 73cbf0b54e54..fe96af6059d5 100644
>> --- a/drivers/iio/adc/ti-ads1015.c
>> +++ b/drivers/iio/adc/ti-ads1015.c
>> @@ -403,7 +403,8 @@ static const struct iio_info ads1015_info = {
>>  #ifdef CONFIG_OF
>>  static int ads1015_get_channels_config_of(struct i2c_client *client)
>>  {
>> -       struct ads1015_data *data = i2c_get_clientdata(client);
>> +       struct iio_dev *indio_dev = i2c_get_clientdata(client);
>> +       struct ads1015_data *data = iio_priv(indio_dev);
>>         struct device_node *node;
>>
>>         if (!client->dev.of_node ||
>> --
>
> Hi Matt,
>
> Giorgio already sent a patch for this. I think we should go on his way
> since he found the bug.

Ah! see both a bug report and patch earlier now :)

Although do you know if there are anymore drivers we had to make a iio
version of hwmon for the triggered buffer? I suspect this was a simple
copy and paste error from the hwmon driver

>
> Daniel.
