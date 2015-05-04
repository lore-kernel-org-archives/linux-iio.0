Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:46835 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750899AbbEDQOY (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 4 May 2015 12:14:24 -0400
Message-ID: <55479ADD.7060007@kernel.org>
Date: Mon, 04 May 2015 17:14:21 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Daniel Baluta <daniel.baluta@gmail.com>,
	Antonio Ospite <ao2@ao2.it>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCHv2 2/2] iio: accel: kxcjk-1013: add some blank lines for
 readability
References: <1430730785-17833-1-git-send-email-ao2@ao2.it>	<1430730785-17833-3-git-send-email-ao2@ao2.it> <CAEnQRZCUqdRxizNCddWqzYtTJY43RCs=4Qrv0yDxytqW_aTKww@mail.gmail.com>
In-Reply-To: <CAEnQRZCUqdRxizNCddWqzYtTJY43RCs=4Qrv0yDxytqW_aTKww@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 04/05/15 11:51, Daniel Baluta wrote:
> On Mon, May 4, 2015 at 12:13 PM, Antonio Ospite <ao2@ao2.it> wrote:
>> Some extra blank lines between if checks don't hurt and improve
>> readability.
>>
>> Signed-off-by: Antonio Ospite <ao2@ao2.it>
>> Cc: Jonathan Cameron <jic23@kernel.org>
>> Cc: Bastien Nocera <hadess@hadess.net>
>> Cc: linux-iio@vger.kernel.org
>> ---
> 
> Looks nice :).
> 
> Reviewed-by: Daniel Baluta <daniel.baluta@intel.com>
added to the patch.


> 
>>  drivers/iio/accel/kxcjk-1013.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
>> index 5b7a860..937bfc2 100644
>> --- a/drivers/iio/accel/kxcjk-1013.c
>> +++ b/drivers/iio/accel/kxcjk-1013.c
>> @@ -1147,8 +1147,10 @@ static const char *kxcjk1013_match_acpi_device(struct device *dev,
>>         id = acpi_match_device(dev->driver->acpi_match_table, dev);
>>         if (!id)
>>                 return NULL;
>> +
>>         if (strcmp(id->id, "SMO8500") == 0)
>>                 *is_smo8500_device = true;
>> +
>>         *chipset = (enum kx_chipset)id->driver_data;
>>
>>         return dev_name(dev);
>> @@ -1163,6 +1165,7 @@ static int kxcjk1013_gpio_probe(struct i2c_client *client,
>>
>>         if (!client)
>>                 return -EINVAL;
>> +
>>         if (data->is_smo8500_device)
>>                 return -ENOTSUPP;
>>
>> --
>> 2.1.4
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

