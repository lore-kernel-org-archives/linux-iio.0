Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:44193 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751766AbaFULmd (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sat, 21 Jun 2014 07:42:33 -0400
Message-ID: <53A57021.5010402@kernel.org>
Date: Sat, 21 Jun 2014 12:44:33 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Sachin Kamat <spk.linux@gmail.com>,
	Beomho Seo <beomho.seo@samsung.com>
CC: linux-iio@vger.kernel.org, j.anaszewski@samsung.com,
	Sachin Kamat <sachin.kamat@linaro.org>,
	naveen krishna <ch.naveen@samsung.com>, ktsai@capellamicro.com,
	srinivas.pandruvada@linux.intel.com, t.figa@samsung.com,
	myungjoo.ham@samsung.com, jh80.chung@samsung.com,
	cw00.choi@samsung.com
Subject: Re: [PATCH 2/5] iio: light: cm32181: Use devm_* APIs
References: <1403072503-29246-1-git-send-email-beomho.seo@samsung.com>	<1403072503-29246-3-git-send-email-beomho.seo@samsung.com> <CAK5sBcFv_oQt=stra-7T821xYwQiDCURNnhUpEwwDabu1YcsSw@mail.gmail.com>
In-Reply-To: <CAK5sBcFv_oQt=stra-7T821xYwQiDCURNnhUpEwwDabu1YcsSw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 18/06/14 09:20, Sachin Kamat wrote:
> Hi Beomho,
>
> On Wed, Jun 18, 2014 at 11:51 AM, Beomho Seo <beomho.seo@samsung.com> wrote:
>> This patch changes API from iio_device_register() to devm_* API.
>> Using API make code simpler.
>>
>> Signed-off-by: Beomho Seo <beomho.seo@samsung.com>
Hmm. Fair enough I suppose.

Applied to the togreg branch of iio.git

Jonathan
>> ---
>>   drivers/iio/light/cm32181.c |   11 +----------
>>   1 file changed, 1 insertion(+), 10 deletions(-)
>>
>> diff --git a/drivers/iio/light/cm32181.c b/drivers/iio/light/cm32181.c
>> index d976e6c..ad36b29 100644
>> --- a/drivers/iio/light/cm32181.c
>> +++ b/drivers/iio/light/cm32181.c
>> @@ -331,7 +331,7 @@ static int cm32181_probe(struct i2c_client *client,
>>                  return ret;
>>          }
>>
>> -       ret = iio_device_register(indio_dev);
>> +       ret = devm_iio_device_register(&client->dev, indio_dev);
>>          if (ret) {
>>                  dev_err(&client->dev,
>>                          "%s: regist device failed\n",
>> @@ -342,14 +342,6 @@ static int cm32181_probe(struct i2c_client *client,
>>          return 0;
>>   }
>>
>> -static int cm32181_remove(struct i2c_client *client)
>> -{
>> -       struct iio_dev *indio_dev = i2c_get_clientdata(client);
>> -
>> -       iio_device_unregister(indio_dev);
>> -       return 0;
>> -}
>> -
>>   static const struct i2c_device_id cm32181_id[] = {
>>          { "cm32181", 0 },
>>          { }
>> @@ -370,7 +362,6 @@ static struct i2c_driver cm32181_driver = {
>>          },
>>          .id_table       = cm32181_id,
>>          .probe          = cm32181_probe,
>> -       .remove         = cm32181_remove,
>>   };
>>
>>   module_i2c_driver(cm32181_driver);
>> --
>> 1.7.9.5
>>
>
> Looks good.
> Reviewed-by: Sachin Kamat <sachin.kamat@samsung.com>
>

