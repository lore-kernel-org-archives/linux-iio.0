Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD7C3FE663
	for <linux-iio@vger.kernel.org>; Wed, 29 Apr 2026 18:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777485997; cv=none; b=OiFn3xRijoQ8kwAHsfZo/Q5DxUrt0dDJ4rDICtNe56JwS95wLhkZ+lL3TGXkHmYthSSdnwJTTE0VZO9gz1WddSveDuMR8LIig1xHDLygVAZF9DZg4nRjup0InZpwMFjqiAQ6KBlJkhK/yqjD4fipw0ZYB+Xes/3lNGj1MzzsC2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777485997; c=relaxed/simple;
	bh=t3fpHm56+txEmI+CDdCVD42H/rvmEFOPGH89me/h7uE=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=f09gE+/bw1CUZ8HZrtDUNl+iA4SdUouNoEuDydLJVFrKNXuYQZ0Wg9f/mhDT6el/qqH2jkaXpjneR1p33CNOYy1JVobGU6JhRcZb3g+tJtwNr8kPxCQNIyPSqSBZIV6XegbPjA04dJZxgs8Qi5EOH/RSa185IONW4pI+buOX1N0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JC9N8qiR; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JC9N8qiR"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c70ea5e9e9dso6710a12.1
        for <linux-iio@vger.kernel.org>; Wed, 29 Apr 2026 11:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777485992; x=1778090792; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TxRNObWPeYrtCFZB/YSUwtbVipcXYwVFVl7E/XgEpmU=;
        b=JC9N8qiRC0+GqmPd7bekY5RJhmgbzY0HlXEh2pzFAbAplfgNvHK2kgTQYWuQ8VUOAl
         kgCPXxIatJsrPZCeyzE6Bdv4B723bphlyBfs4Ntt0U4wSdra1asVib4Nq2Oo0NyyBZkc
         Ha3uJwvurNgEZAA3ZDC+O/ovW7knaX25y81ieSIndcIQHz8angGxCVQTzjW+1gg4V1QT
         neuJ1ugur2fyGbNFCtXlhAUSMl1GV0jocLzlwtQPvq2EKTnsZy4rIsKvjfvE6bUPmLzT
         d94CJ5KEP25IRnNqGS3jbj7AVyfjX6x/kx4BALo2HzWccXIXMjM0T4P2xkC4biE6ynBA
         nFPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777485992; x=1778090792;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TxRNObWPeYrtCFZB/YSUwtbVipcXYwVFVl7E/XgEpmU=;
        b=bAE5UL7OCHJ4GePvQ2PxnO/+zFX39hcftK8VHyA612h+c7vp0UxAc3QjNtZNGilIa/
         KI8gIr+P2eYgqx3pkT2Z5QC5gMWMgL7VPct3ubwuT2w+EOefQLdObq4SxR2ncebJm8Hw
         NzsJ+DU/K7RlKJgv6/o6p4xW4XOersMYLrY7lMLj0YFWU/5aUu0LHJ2SxGyDojEluDSt
         IyneiFeqKxu8sDThQA+YZb5ZvQFjTG6gf2JTk/imPUCCFb9/xhUQNGqDMUTgVVwhPRwN
         nzKc6fLGEkdzFcII4THq3KV6/wjnhBu6lZv2XMeXAydIEEdPjz4k6vkmonNzfZobiV8D
         BWGA==
X-Forwarded-Encrypted: i=1; AFNElJ/qx4QOioYaY2mcv6eUnt3XF0uwtotgrqmSjtUhLisxpFjf25MKASDbtdpZq94kX1wyDwqKl0/k6Fk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGmoXfYDeMPUndBCPHVbJ5cUVvsD6hWsyESXy1WPpzQReh0TX3
	T65r+4F57+tLr5tOCkgswaQWLpZkqxi89WybiFM4eMsdayPOuwqdZ9O19F45NA==
X-Gm-Gg: AeBDiet+7y4YUsU3QvkTF3nPqndl4+STwlPojTdjqX1tCnWLXxR31zOzvliCRadaBPz
	yQN0LUoMBs+9vAZaErhImTHzmv12cmQSGhoLw6Cxs73ox5zc7ygYt1NJAnitr5/f6aHCOC3+9t7
	Ac+t8K1uRnFWSJJXWC7d72c8JY0i/IeFBGf8ZeWF7m8l7Le8bu2qceO5YXbOH+yVT3r3e5wrEDi
	m8crEcKf+U/GXTq35PzeX9R1jWrR4lmCaFjuwKHI/bYX+KfYZ8e4T+sP3/cVbDC4JlG/5R8cMDn
	0NZK26SLL52wwkref4lfcKV0IiixKaHA0Hqi5noaTNbWkStb+Qknq/yzpgEDYN+HubEZX690fXt
	WLRfO8Mexym90QKd3f2rivRLyKiP9+mRK6j4tQf426h9xao6fW6o0YisoNzA9bCvJxuXKFUwQiO
	2mJmhv8MyAZ51z2KsCGhqzlHHo4sPO3QNxS2AvxR2l0XptTw==
X-Received: by 2002:a17:902:ff0a:b0:2b2:5503:1b8c with SMTP id d9443c01a7336-2b97c40573dmr66372035ad.11.1777485991830;
        Wed, 29 Apr 2026 11:06:31 -0700 (PDT)
Received: from ehlo.thunderbird.net ([2401:4900:aaf3:890d::6543:8983])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b9887acd10sm29396915ad.36.2026.04.29.11.06.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Apr 2026 11:06:31 -0700 (PDT)
Date: Wed, 29 Apr 2026 23:36:24 +0530
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, mingo@kernel.org,
 christophe.jaillet@wanadoo.fr, nabijaczleweli@nabijaczleweli.xyz,
 kees@kernel.org, kyungmin.park@samsung.com, k.wrona@samsung.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v7_3/9=5D_iio=3A_ssp=5Fsensors=3A_?=
 =?US-ASCII?Q?cancel_delayed_work=5Frefresh_on_remove?=
User-Agent: Thunderbird for Android
In-Reply-To: <20260426150912.765d5985@jic23-huawei>
References: <20260426091710.3722035-1-sanjayembedded@gmail.com> <20260426091710.3722035-4-sanjayembedded@gmail.com> <20260426150912.765d5985@jic23-huawei>
Message-ID: <952B333C-55B0-4E76-8685-DA9874BE1447@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 26 April 2026 7:39:12=E2=80=AFpm IST, Jonathan Cameron <jic23@kernel=2E=
org> wrote:
>On Sun, 26 Apr 2026 14:47:04 +0530
>Sanjay Chitroda <sanjayembeddedse@gmail=2Ecom> wrote:
>
>> From: Sanjay Chitroda <sanjayembeddedse@gmail=2Ecom>
>>=20
>> The work_refresh may still be pending or running when the device is
>> removed, cancel the delayed work_refresh in remove path=2E
>>=20
>> Fixes: 50dd64d57eee ("iio: common: ssp_sensors: Add sensorhub driver")
>
>Fixes at start of patch series not after some refactors of unrelated
>code=2E

Hi Jonathan,

Thank you for input, I will make sure to take care of this in future=2E

Additionally, this change is independent to the initial two changes=2E If =
this change is good for the iio subtree then this would help to reduce over=
head in next series=2E

>
>> Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail=2Ecom>
>> ---
>>  drivers/iio/common/ssp_sensors/ssp_dev=2Ec | 1 +
>>  1 file changed, 1 insertion(+)
>>=20
>> diff --git a/drivers/iio/common/ssp_sensors/ssp_dev=2Ec b/drivers/iio/c=
ommon/ssp_sensors/ssp_dev=2Ec
>> index 7d07fae295fd=2E=2E51730dae5871 100644
>> --- a/drivers/iio/common/ssp_sensors/ssp_dev=2Ec
>> +++ b/drivers/iio/common/ssp_sensors/ssp_dev=2Ec
>> @@ -590,6 +590,7 @@ static void ssp_remove(struct spi_device *spi)
>>  	ssp_clean_pending_list(data);
>> =20
>>  	free_irq(data->spi->irq, data);
>> +	cancel_delayed_work_sync(&data->work_refresh);
>> =20
>>  	timer_delete_sync(&data->wdt_timer);
>>  	cancel_work_sync(&data->work_wdt);
>
