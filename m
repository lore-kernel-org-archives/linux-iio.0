Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:46827 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751451AbbEDQNV (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 4 May 2015 12:13:21 -0400
Message-ID: <55479A9C.1080806@kernel.org>
Date: Mon, 04 May 2015 17:13:16 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Daniel Baluta <daniel.baluta@gmail.com>,
	Antonio Ospite <ao2@ao2.it>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCHv2 1/2] iio: accel: kxcjk-1013: add the "KXCJ9000" ACPI
 id
References: <1430730785-17833-1-git-send-email-ao2@ao2.it>	<1430730785-17833-2-git-send-email-ao2@ao2.it> <CAEnQRZC6J267=Q8Dbu1X4U5pgH4pP5XKbHkk-uW=rk9yrK-xOA@mail.gmail.com>
In-Reply-To: <CAEnQRZC6J267=Q8Dbu1X4U5pgH4pP5XKbHkk-uW=rk9yrK-xOA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 04/05/15 11:50, Daniel Baluta wrote:
> On Mon, May 4, 2015 at 12:13 PM, Antonio Ospite <ao2@ao2.it> wrote:
>> This id has been seen in the DSDT of the Teclast X98 Air 3G tablet based
>> on Intel Bay Trail.
>>
>> Signed-off-by: Antonio Ospite <ao2@ao2.it>
>> Cc: Jonathan Cameron <jic23@kernel.org>
>> Cc: Bastien Nocera <hadess@hadess.net>
>> Cc: linux-iio@vger.kernel.org
> 
> Looks good to me.
> 
> Reviewed-by: Daniel Baluta <daniel.baluta@intel.com>
Added to the patch.
> 
>> ---
>>  drivers/iio/accel/kxcjk-1013.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
>> index 51da369..5b7a860 100644
>> --- a/drivers/iio/accel/kxcjk-1013.c
>> +++ b/drivers/iio/accel/kxcjk-1013.c
>> @@ -1418,6 +1418,7 @@ static const struct dev_pm_ops kxcjk1013_pm_ops = {
>>  static const struct acpi_device_id kx_acpi_match[] = {
>>         {"KXCJ1013", KXCJK1013},
>>         {"KXCJ1008", KXCJ91008},
>> +       {"KXCJ9000", KXCJ91008},
>>         {"KXTJ1009", KXTJ21009},
>>         {"SMO8500",  KXCJ91008},
>>         { },
>> --
>> 2.1.4
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

