Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8CA3A4521
	for <linux-iio@vger.kernel.org>; Mon, 31 Aug 2026 21:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788212347; cv=none; b=Av4VQnwxOZFwx64pzeWu0kU4AqQTt1P5/8DakqMZfd6oHUPaTwkULDa8FlQzFtVd5/1PHUb+tMUhKEKxn2HFTYHPhyLjtnXgSZwdRUexJxo5JxD7wUlxw86QgHwLmOS4eR13T0IMmnVGNfReHp4dRMuxz5eRwDXakkSJChWt//A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788212347; c=relaxed/simple;
	bh=zjlzbS2BJWiY6Eq17AuZUar8L1Yx02AnbD2wTcey/pA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HpyTKLHkczrQD12gTLPsANruTLBYpWCOlitgfm1fjGvdtFbTqJQ67++1n1fXwTkCIX6k44DmYJryjIxTNxF9ajT0sRh6majDg4hGqfqqUuiPjxpCk7LXrYILoGwsE6OiP6gTbAZOUSL6ou9BT5FMAh2JHFIa/WvELJ9wXjJn6Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=BZgXZ+Y4; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="BZgXZ+Y4"
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-6aaf3f54dbeso240378eaf.2
        for <linux-iio@vger.kernel.org>; Mon, 31 Aug 2026 14:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1788212343; x=1788817143; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XTar0GJgDTcaGfB5IlxsiO5nthIFPj6JkXO27Y1m4y8=;
        b=BZgXZ+Y4r3czfHxXhZwDeSHhtlZ0jFTtnGq3Lzuso5AH1uwXI6dngJDegLfJ9pHpUc
         wOoCazQI6sJ9pW19xK1nm5x8WZwfTa+OXlQWrhvgrWYghgcSTIdPN81k+VYwVAwq0jwv
         amIvmnC+4obT3yQkYKti0DUZn7VfKz7R1VRyw14a2FtMg4sQGyNthEq2eJbUaabkg2mZ
         jrBsgVhA7X0oP4zW/V/EAaNB7dQKcEOaqbDBSJ2/SQHj39N5OKsbHQeppXINU9AOSZqa
         bST88d1P+MWZvk1w5NV2mQj9W1on3Ge+iONzH+SdkiqXQZI6ZcwW313UqBig31tSNZjH
         dJXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788212343; x=1788817143;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XTar0GJgDTcaGfB5IlxsiO5nthIFPj6JkXO27Y1m4y8=;
        b=q6zI1ShuWjC3EcS9aoHqUWvbpQHtFLWH9SaTfIm6EaohIogTn0+1yDRQEB0oQbvljq
         yvVeafazfqcML93ThckUXikIOLX1D5Dae3oAmKYeGgUl7QPTKr+ufY0JxxXnNAakXlbm
         KPbrDy+lhqcGd4i8eEH2jmVzhq8t3B2kGTOoKke1TXg86a/0WbS22G9yV0/Udarohhib
         HXgZYq3I2tQDt/l7qJ/s920Fjrrno83z3D14QIlFtiw0IEG6ovmwxu9Cft4ly0hbqEMZ
         Hd5tKwsJ4AKGOySUMFcaCQBaA5cl35nnMQduDs4/P59SXLDbSNbb2qk0WAQklqeHdILC
         0WmA==
X-Forwarded-Encrypted: i=1; AHgh+Rp56dzqW70MFdvCxt2zhLRdt5eeIsvAuMqTGiJOLauDS4zPr+xibMSG9w7Nqy9tnFm/kBCyfTPwmWk=@vger.kernel.org
X-Gm-Message-State: AFuF++kAtYdj310gg3y4ePshozMLbD5CltL8aeTPdP87DNfzb0ycA5W3
	5L1xHkhb5tQ30EN8vfIi9B06CM/m6mbDqZURRlkCDTh7Ix8IjYcV+lUii1w5nsOFFQ8=
X-Gm-Gg: AR+sD13FFjMugpbRL1fkLXWPvPM5N3egnzWZiKeiDe886zBO4Gi9bVB/qap7VAolAaY
	r7WYASYi3o7hECsjXgcor6gHCfBOGBsb3StrMR4qIYEdROLmL+JugCSKj+F0nLBpGIhia+WuQYQ
	xdcuu3vN7iU2DduxE3vi1dzTnjN2MFqAi+i0Ml6nr5ZGUSxSLeecYHmk/7MkV7HOpK53fJpkwWw
	fkx0N93itvY1hRMjvtkMKuI71ilAmrvty+ymoFnOEuMs9Xz4tE3nsEnHrzJLsxjKxkHMhZWkWft
	263Qjbwn11QcNl6W0SRJDOyFOUJdJEXDM2Ie61F/B8M0uh6uAj8wjOKkAdNbKCZkjH0pdw5AGHe
	QidA7n4vA3RSEtpVIX2xs0+Ciz7xEHVpo2vSCuwUCj9yvIuV/MoM0WQ6rURbiLDj7iIkWkHU8sD
	RHHWeYcFakV/54m+fM12m+GchPCYLNT1xea9Ivq857d42AdBWAO6aRppoQMiSfqBtj/ECwJLhyB
	u5Ity1dIinF3lsFilDobrUk7xbR0Xo7pCtt
X-Received: by 2002:a05:6820:200d:b0:6b3:752a:53c9 with SMTP id 006d021491bc7-6b3752a544fmr3291421eaf.2.1788212343577;
        Mon, 31 Aug 2026 14:39:03 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:778b:da9:a8a1:bc78? ([2600:8803:e7e4:500:778b:da9:a8a1:bc78])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-46ad2a8e3adsm6546087fac.13.2026.08.31.14.39.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Aug 2026 14:39:02 -0700 (PDT)
Message-ID: <a54a8a3a-188c-4487-bf90-557f1d027c39@baylibre.com>
Date: Mon, 31 Aug 2026 16:39:01 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] iio: adc: ti-ads112c14: add continuous mode
 support
To: Jonathan Cameron <jic23@kernel.org>
Cc: =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Chris Hall <c-hall@ti.com>,
 Patrick Edwards <pedwards@ti.com>, Kurt Borja <kuurtb@gmail.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260827-iio-adc-ti-ads112c14-continuous-mode-v4-0-1e51a6e20a69@baylibre.com>
 <20260827-iio-adc-ti-ads112c14-continuous-mode-v4-3-1e51a6e20a69@baylibre.com>
 <178812363490.2788519.7648614173312615575.b4-review@b4>
 <20260830232418.10f23462@jic23-huawei>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260830232418.10f23462@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/30/26 5:24 PM, Jonathan Cameron wrote:
> On Sun, 30 Aug 2026 22:00:34 +0100
> Jonathan Cameron <jic23@kernel.org> wrote:
> 

...

>>
>>> +static int ads112c14_buffer_postenable(struct iio_dev *indio_dev)
>>> +{
>>> +	struct ads112c14_data *data = iio_priv(indio_dev);
>>> +	const struct iio_chan_spec *chan;
>>> +	int ret;
>>> +
>>> +	if (!ads112c14_using_drdy_trigger(indio_dev))
>>> +		return 0;
>>> +
>>> +	chan = ads112c14_first_active_channel(indio_dev);
>>> +	if (!chan)
>>> +		return -EINVAL;
>>> +
>>> +	guard(mutex)(&data->lock);
>>> +
>>> +	ret = ads112c14_prepare_channel(data, chan);  
>>
>  | sashiko.dev <sashiko@sashiko.dev>:
>  |
>  | [Severity: High]
>  | Can a user bypass the single-channel limitation and push corrupted data
>  | to the ring buffer here?
>  |
>  | Since ads112c14_validate_scan_mask() allows multiple channels if a non-DRDY
>  | trigger is currently selected, a user could enable multiple channels via
>  | scan_elements, then switch current_trigger to the DRDY trigger before
>  | enabling the IIO buffer.
> 
>>
>> Hmm. Indeed an interesting corner...  From a quick look it is correct.
>> I'm not sure if this is in practice an existing bug - do other
>> drivers change acceptable channels based on another change such as
>> which trigger is in use?   Either way we need to close this.
>>
>> We can't just go clearing the set bits on setting the trigger as
>> that might cause a regression.  So I think all we can do is add
>> a well commented additional check early in the buffer enable path.
>>
>> Given the behaviour that is causing problems is present in this
>> driver we could either add the protection in fix and rely on that
>> going upstream first, or add it as first patch in this series and
>> let it work its way upstream with this patch.
>>
>> Nice catch to sashiko!
>>
> 
>  |
>  | Because this driver does not provide an available_scan_masks array, the
>  | mask isn't re-validated during buffer enablement. Since
>  | ads112c14_buffer_postenable() only configures the first active channel,
>  | will the trigger handler push uninitialized heap memory for the remaining
>  | channels when the full array is sent to userspace?
>  |
>  | via: https://sashiko.dev/#/message/20260827-iio-adc-ti-ads112c14-continuous-mode-v4-3-1e51a6e20a69@baylibre.com
> 
Ah, I had it mixed up in my mind with update_scan_mode(), which would be
called at the appropriate time.

