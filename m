Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:43245 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751749AbcF3Thk (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 30 Jun 2016 15:37:40 -0400
Subject: Re: [PATCH 5/6 v3] iio: magn: ak8975: make sure to power down at
 remove()
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>
References: <1467202118-10386-1-git-send-email-linus.walleij@linaro.org>
 <1467202118-10386-6-git-send-email-linus.walleij@linaro.org>
 <CAPDyKFpLqdQkNZjzV7nDNF-FTHkDbMDczHnFn=BOWdKx1oVxGw@mail.gmail.com>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
	Gregor Boirie <gregor.boirie@parrot.com>,
	Richard Leitner <dev@g0hl1n.net>,
	Krzysztof Kozlowski <k.kozlowski@samsung.com>,
	Gwendal Grignou <gwendal@chromium.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <243ddd5f-fbb0-32fc-b590-87bc5835d410@kernel.org>
Date: Thu, 30 Jun 2016 20:37:38 +0100
MIME-Version: 1.0
In-Reply-To: <CAPDyKFpLqdQkNZjzV7nDNF-FTHkDbMDczHnFn=BOWdKx1oVxGw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 29/06/16 17:33, Ulf Hansson wrote:
> On 29 June 2016 at 14:08, Linus Walleij <linus.walleij@linaro.org> wrote:
>> The code was not powering the magnetometer down properly at
>> remove(): just cutting the regulators without first setting the
>> device in power off mode. Fix this.
>>
>> Cc: Ulf Hansson <ulf.hansson@linaro.org>
>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> 
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Applied to the togreg branch of iio.git. Initially pushed out
as testing for the autobuilders to play hide and seek.
> 
> Kind regards
> Uffe
> 
>> ---
>> ChangeLog v2->v3:
>> - Rebase
>> ChangeLog v1->v2:
>> - New patch in the series after Ulf's review comment that this
>>   should be separate.
>> ---
>>  drivers/iio/magnetometer/ak8975.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
>> index c67cf3a6128d..43dc1c74be9e 100644
>> --- a/drivers/iio/magnetometer/ak8975.c
>> +++ b/drivers/iio/magnetometer/ak8975.c
>> @@ -990,6 +990,7 @@ static int ak8975_remove(struct i2c_client *client)
>>
>>         iio_device_unregister(indio_dev);
>>         iio_triggered_buffer_cleanup(indio_dev);
>> +       ak8975_set_mode(data, POWER_DOWN);
>>         ak8975_power_off(data);
>>
>>         return 0;
>> --
>> 2.4.11
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

