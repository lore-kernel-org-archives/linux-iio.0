Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1B1371860
	for <linux-iio@vger.kernel.org>; Mon, 20 Apr 2026 14:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776694319; cv=none; b=SnahnKvgGrTSzh+oN+vIJs6f7VZM6H7vKMd7Bn9hPERL6uwtC1nwnOfCvh3pzI1WSymdxtvLbyNtF7Hk493KkcPOhPmr+wfW6RuqZcxLhIbm8ccz9jz9z2f/Ar/tsUNujbFZhsEzqFAkasfsSUErdrUHAfbPG0uoceXI4TKwmWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776694319; c=relaxed/simple;
	bh=aX8LYP3ECC/cWxVoFMwNHrNdBz5rPMU56Qk1vIvnDCQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mUOLWrgXa0EwFQ1Gupc7pO9jdvdoOvu+S0zkpE45qy5dmOmXPkThmVaOvg7rKDg+qXtH+V0bh7T9qNv/APfPfGjKhFf//r2jG654BR4gi5Z3em6SFOOKjf9wI3IKl03GTW0HEINw1Ebp5yR/2ULmu1xh8+oyLtqrQPTL9ZKTlE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br; spf=pass smtp.mailfrom=usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=XtBU/WxE; arc=none smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="XtBU/WxE"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-12c565476d7so6138413c88.1
        for <linux-iio@vger.kernel.org>; Mon, 20 Apr 2026 07:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1776694315; x=1777299115; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Cg54qARICyRaEKtg9liLPgcxff0yOr3kYH5tQ5LnKb0=;
        b=XtBU/WxE+mUNlyMx1KR0rwC6Xk31Xuh7gxjM9S9OUZ21Be2xw511r3mDwUt4dTE81e
         iOzj4GEqtJqoJ/J+Vs7Fu2qfCalEMkFpILYFFblsmr1EE984EkAvktYuRtkqTv5PLD0O
         FRpfrat3lAbjCcR/1flqUm60M+DdBzTEd+Vf+l0/H6bYEG/Aa9klYa+5CPFr08qlkiXY
         cFeMszApB1c8PLEIohkJ+M7RyBNcK0AkvZuBt02l0z8gmFfRjuVEw4QgI9ZSM8eBoLTN
         zdYwF3/erbP1ONZqYZQXL4nBu0RyEUZgVw9CAgKvfz8q8ZILOPk/HmLhj7pqnhiJA28O
         bMkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776694315; x=1777299115;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Cg54qARICyRaEKtg9liLPgcxff0yOr3kYH5tQ5LnKb0=;
        b=rX2zIdaqZ42wRrlieoX4AcsQ/K3kck1t7w3mMNpYwiefi0F/pcNo5C7e2tp1tASwNi
         cAlYQZZaRBYBzxFThuBrNMa8oc5fyW2B2/VfIl45a59gtoFYqDO1tj0LP0y3JRMGH/it
         m1TK97JvNm0LFqELKebsGLulFfmOTlUo89CKIBfDaSkQkQZBUJX2unZsEY1gp0XNN9lF
         ivBBvv74BgpytNc49J3SmXce89C1WLcddzrJOkyMQBuo5rLNi4t+5bKKvTL6S5AzwD7j
         nK/h5e0aRkdy1a+bkS5Wk7Bp0Wm2UICgsvkyQiJPdnaIfBQ0VvzL7c8fde6pXWxcwZYn
         2hTg==
X-Forwarded-Encrypted: i=1; AFNElJ/D1Za9Ms3h6pX1P3piNROknb4RLKrudUKF4D918NYUXbfaZY2WEnOSPyNsswb6nxT9/TvDyeSTB/8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxN5GM3jptx8No9jsh2llKf/w/2rCBem9CT4Pf99eW2S1k0kZJq
	oQ8nyoO+KdwYyC2RW930Dyiofl3wa+crwCstdu6SiDAkRInC8/N3esqHYaCWgVwozRPeLTu0Rev
	MCk92nICVTg==
X-Gm-Gg: AeBDiet267v+eYNfuXmpG59d1bRob4l9UpRp4pwpB8d7YScBLdMvEBywlne7FA2AtYy
	6nQZtTI9x454nl5aJeH8UbjtoePVkWFvUExD7MQ1K1UhLncsxQrMXl1Y5qKT9oJH7pYqPv0EKJk
	EMp/tnwLwXUgSB34J+zdxRQ0rJb9fUtbbRwis1iommIHTVpEdPb7OYkq8DvSStPoAMlEQmvNdvx
	lfsyzFMmxZVhOOPUvOK0kOzCRYfpF6Q/+4F6k29Rg9+hlEetrqiVwa1b74Qp94Rb7CfsUg9xCVg
	VVWjgiX+KNKTIeLLCF4uElFKGu0eXa7nQh0l/o6mJseKub2u3s6Rd+AuZmA5nFl/Wm1XBfE24K8
	yKz+CaWJHSR32yHi9/4sQ4GWgH6IIWhsmkcpD2zy/l91DP3mluB1GLlUok5ZQ91gQLlqXrFGGRg
	VW36+D0Hg8272OXG+UpM93aXpCzK6djEq/6M1fFJOv34zMIxwb7Uda5dPzYw/s3x+615NKTYV0B
	Qz1c43A2evBZB8PQl0WLitBnqhpbdacTRft
X-Received: by 2002:a05:7301:fd16:b0:2e7:af57:3b72 with SMTP id 5a478bee46e88-2e7af57404cmr2279507eec.29.1776694314993;
        Mon, 20 Apr 2026 07:11:54 -0700 (PDT)
Received: from ?IPV6:2804:14c:4c:af50:c408:26e5:33b0:662b? ([2804:14c:4c:af50:c408:26e5:33b0:662b])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e539fa3cecsm14443548eec.6.2026.04.20.07.11.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Apr 2026 07:11:54 -0700 (PDT)
Message-ID: <b4a1f829-f953-4d2a-a8ac-2e828ef56d4b@usp.br>
Date: Mon, 20 Apr 2026 11:11:50 -0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: temperature: mlx90614: use guard(mutex) for EEPROM
 access locking
Content-Language: en-US
To: Jonathan Cameron <jic23@kernel.org>
Cc: cmo@melexis.com, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, linux-iio@vger.kernel.org
References: <20260418205151.172046-1-luizmugnaini@usp.br>
 <20260419124341.465353af@jic23-huawei>
From: Luiz Mugnaini <luizmugnaini@usp.br>
In-Reply-To: <20260419124341.465353af@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Jonathan,

Thanks for the feedback. I'll be sending a v2 shortly. About your points:

 > I'd also consider if having a locked reader helper might be
 > worth doing here as well

I would prefer just using scoped_guard() in this specific case as there are
only two affected call sites and no real code duplication. But I agree that
if this proliferates, a helper procedure might be the way to go.

 > It may make sense to take a closer look at whether we can use cleanup
 > magic to handle the power management as well though that would need more
 > substantial refactors so wouldn't belong in this patch.

Agreed. That would indeed entail a new patch.

 > > @@ -476,12 +473,11 @@ static int mlx90614_sleep(struct 
mlx90614_data *data)
 > >
 > >      dev_dbg(&data->client->dev, "Requesting sleep");
 > >
 > > -    mutex_lock(&data->lock);
 > > +    guard(mutex)(&data->lock);
 > >      ret = i2c_smbus_xfer(data->client->adapter, data->client->addr,
 > >                   data->client->flags | I2C_CLIENT_PEC,
 > >                   I2C_SMBUS_WRITE, chip_info->op_sleep,
 > >                   I2C_SMBUS_BYTE, NULL);
 > > -    mutex_unlock(&data->lock);
 > >
 > >      return ret;
 >
 > return i2c_smbus_xfer();

I'll remove that intermediate ret variable, thanks for the tip.

Best regards,
Luiz


On 19/04/2026 08:43, Jonathan Cameron wrote:
> On Sat, 18 Apr 2026 17:51:36 -0300
> Luiz Mugnaini <luizmugnaini@usp.br> wrote:
>
>> From: Luiz Mugnaini <luizmugnaini@usp.br>
>>
>> Replace mutex_lock()/mutex_unlock() pairs with guard(mutex) from
>> cleanup.h for cleaner and safer mutex handling. The lock protects
>> EEPROM access across five call sites in mlx90614_read_raw(),
>> mlx90614_write_raw(), and mlx90614_sleep().
>>
>> In all cases, the code between mutex_unlock() and the end of scope
>> is either trivial computation, a return statement, or a call to
>> mlx90614_power_put() (which only schedules a deferred autosuspend
>> via pm_runtime_put_autosuspend()). The slightly extended lock scope
>> is negligible compared to the existing hold times, which include
>> EEPROM write cycles with 40ms sleeps.
>>
>> Signed-off-by: Luiz Mugnaini <luizmugnaini@usp.br>
> Hi Luiz,
>
> When making this sort of modernization change I'd suggest taking
> a look at the feedback and final form of other similar patches.
> Pretty much everyone gets the same feedback on these and you'd have
> saved everyone time if you'd realized it applies here as well.
>
> I'd also consider if having a locked reader helper might be
> worth doing here as well
>
> Something like
>
> static xxx mlx90614_read_word_data_locked(xxxx)
> {
> 	guard(mutex)(&data->lock);
> 	return i2c_smbus_read_word_data();
> }
>> ---
>>   drivers/iio/temperature/mlx90614.c | 16 ++++++----------
>>   1 file changed, 6 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/iio/temperature/mlx90614.c b/drivers/iio/temperature/mlx90614.c
>> index 1ad21b73e..adf100756 100644
>> --- a/drivers/iio/temperature/mlx90614.c
>> +++ b/drivers/iio/temperature/mlx90614.c
>> @@ -23,6 +23,7 @@
>>    */
>>   
>>   #include <linux/bitfield.h>
>> +#include <linux/cleanup.h>
>>   #include <linux/delay.h>
>>   #include <linux/err.h>
>>   #include <linux/gpio/consumer.h>
>> @@ -296,10 +297,9 @@ static int mlx90614_read_raw(struct iio_dev *indio_dev,
>>   		if (ret < 0)
>>   			return ret;
>>   
>> -		mutex_lock(&data->lock);
>> +		guard(mutex)(&data->lock);
> What is the scope of this guard?  Hint, that gets 'interesting' when in a switch
> case statement and there is a standard solution for that...
>
>>   		ret = i2c_smbus_read_word_data(data->client,
>>   					       chip_info->op_eeprom_emissivity);
>> -		mutex_unlock(&data->lock);
>>   		mlx90614_power_put(data);
>>   
>>   		if (ret < 0)
>> @@ -319,10 +319,9 @@ static int mlx90614_read_raw(struct iio_dev *indio_dev,
>>   		if (ret < 0)
>>   			return ret;
>>   
>> -		mutex_lock(&data->lock);
>> +		guard(mutex)(&data->lock);
> Same applies here and probably a load more cases below.
>
>>   		ret = i2c_smbus_read_word_data(data->client,
>>   					       chip_info->op_eeprom_config1);
>> -		mutex_unlock(&data->lock);
>>   		mlx90614_power_put(data);
> It may make sense to take a closer look at whether we can use cleanup magic
> to handle the power management as well though that would need more substantial
> refactors so wouldn't belong in this patch.
>
>
>>   
>>   		if (ret < 0)
>> @@ -358,10 +357,9 @@ static int mlx90614_write_raw(struct iio_dev *indio_dev,
>>   		if (ret < 0)
>>   			return ret;
>>   
>> -		mutex_lock(&data->lock);
>> +		guard(mutex)(&data->lock);
>>   		ret = mlx90614_write_word(data->client,
>>   					  chip_info->op_eeprom_emissivity, val);
>> -		mutex_unlock(&data->lock);
>>   		mlx90614_power_put(data);
>>   
>>   		return ret;
>> @@ -373,10 +371,9 @@ static int mlx90614_write_raw(struct iio_dev *indio_dev,
>>   		if (ret < 0)
>>   			return ret;
>>   
>> -		mutex_lock(&data->lock);
>> +		guard(mutex)(&data->lock);
>>   		ret = mlx90614_iir_search(data->client,
>>   					  val * 100 + val2 / 10000);
>> -		mutex_unlock(&data->lock);
>>   		mlx90614_power_put(data);
>>   
>>   		return ret;
>> @@ -476,12 +473,11 @@ static int mlx90614_sleep(struct mlx90614_data *data)
>>   
>>   	dev_dbg(&data->client->dev, "Requesting sleep");
>>   
>> -	mutex_lock(&data->lock);
>> +	guard(mutex)(&data->lock);
>>   	ret = i2c_smbus_xfer(data->client->adapter, data->client->addr,
>>   			     data->client->flags | I2C_CLIENT_PEC,
>>   			     I2C_SMBUS_WRITE, chip_info->op_sleep,
>>   			     I2C_SMBUS_BYTE, NULL);
>> -	mutex_unlock(&data->lock);
>>   
>>   	return ret;
> 	reutrn i2c_smbus_xfer();
>
>>   }
