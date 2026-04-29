Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228182580CF
	for <linux-iio@vger.kernel.org>; Wed, 29 Apr 2026 18:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777486328; cv=none; b=do3f/845xgW2woSvbUzytmfbRbRtDuvs90Xu8BRrvH6H13WzUnjuselA4F2x8m6W5pfDf/TVnwqY4QBWPkUao0E9L54WqgZM3SknCzRNuGukZGzb/uYAQMFGs8dPLTYaKatLjJX+6qMsbVQZ0FGozrjsl1xeDPTTt+P1h5DNDmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777486328; c=relaxed/simple;
	bh=bqTPTdiYxNn/aQjb401FLvwAB0bhPCLTO5ZpDMNFyOc=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=cYMHUbt5vfEtjAH7ncmXR+bg9ZZnWa9yYlzDQ1p5f+JJTKsltYXP70SHSEP+9UQ3hZyQ8RNVXUV2xh1YoEViFzU4ntlipd29Qg+QJngh80fAgTVoQ0+SBZYhW+lr2kJnunsUATk5SMtVW8L+jilV+TmE/lrFYk6e1naH97BX428=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bKK36wzP; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bKK36wzP"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-35da1af3e10so21946a91.3
        for <linux-iio@vger.kernel.org>; Wed, 29 Apr 2026 11:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777486326; x=1778091126; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uf5ovASwF3vjtPCq95wA8sxW4qrT2BU9CLJbWLHRZSE=;
        b=bKK36wzP40VaG6iZGTvke2C/Rsx8k5Ckj8e6IXJ278EBKa/Eu5sZQGAfrnudJ3iT02
         Bz3L16Dt3UYyMJo4TLCwwzxm1HrgAq3mEQIWxMy9lvS8aza1oc2xmTF0Qoxm5JuLamfZ
         p3Gx01yFhVpbSbJWRu1v8+6b+7uJFM7gb07yrbAYoAsaSj5m2bJHI2Yw2O2ssP29HulJ
         AgFGducKvbZTzszmeGHjGD7ncd3TuUnReRbgMaib/eq1qxNf7wf9l2ZcwRz4e3imkQTY
         76c95i1Uativ2JWc5BLXDiM1XKd8icuw0MlixROE5nIFYsodFhandtj7r/Z9mIFG5WKv
         CTVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777486326; x=1778091126;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uf5ovASwF3vjtPCq95wA8sxW4qrT2BU9CLJbWLHRZSE=;
        b=fgOZGYGyUain7sAGTR8iZJAzzQPg1a1dL7drWcqCvAcl+P6ajzLC93SYY63PrcLls1
         xcCyvuoXvRuxSKB3lK0k5kkKJeejlunrJsKh4+/lqToYuSSdUrl92JkAyPv3Z79ilDuL
         /17/JpUIcgbnXs9A0B/KJfBo/nK8IFaCb2bC0ZNRzfjiBw6SuG4YTHRIRMgecCxgFY6+
         NmvOvHYD1Ixxsw3TgnoWv0IGLQG+VOBeMY1ULoh0Kebo+b3p4MKUAh4K5Eo/xsDP06+0
         W8n+8hxgJpwDEIGUwjZI2/T+GX5M4ntl4y7lMUGOdKXIoj3rTtUR255DpA0Zm4JBQYlI
         kQcA==
X-Forwarded-Encrypted: i=1; AFNElJ8sOSBvSqQlTLBuqryIqEBvHTfOR7U6EUQzF4qJbd1v5XDI9OyCu5iURgJcO7pd7LjuaZ2E65tQLgQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx61/9dLsAv1apOUMPvayFqcDNkginWqW3/YgyxqHOiwl6yETAn
	r3nGulZDPT20Q6aWo4X+2o5c4nZXxbChJc5jdyM3wP1CzPuJsZOTP3j7
X-Gm-Gg: AeBDies5RNchOz0g0VFq4lwKE8IcLvifV+mdbUyR/b68iofjQOTWEez+jO6SqTUIFBQ
	XTe37aZHp6/HghfIvNyRY5/T0JXyLhdrYN63X0auad7/v8sJWXr46N/ZvZlodwvZiSBGAeOtPeZ
	z/8S9u147C9ELwjtaV4azMBJHatNdcQlbvcQfMRJnhuwFmJWlImEuXguL03rzMB58gvl+w1ahxE
	gTlmeupIkTB3bgBHuJG2X6D/QgfucY1Yk9aM8rcMDR8zDx0zb20+3BW+YAoBcch8NxRKjMS53Gf
	BoWZgfRL0yUm1Uu68AZEITd4tYXygljoYOWU8eIZLD0bKw8hczxiq13xsVUl8uR3390MOgwNswU
	QqAJxhFg9ADHanvprFwoHbAVDYDq5LE7C1YB0eXf45cp1ePUzyBozlnnNfnXR/GUFpNEaQAFB4D
	yGQklo2SaD/IH/PihaMXzMCrP/Ffmbxy1nafrYOcuzSgrrPQ==
X-Received: by 2002:a17:90b:35c3:b0:361:423d:203d with SMTP id 98e67ed59e1d1-36491fc0af7mr9353939a91.8.1777486326467;
        Wed, 29 Apr 2026 11:12:06 -0700 (PDT)
Received: from ehlo.thunderbird.net ([2401:4900:aaf3:890d::6543:8983])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-364bdf69bc2sm285399a91.10.2026.04.29.11.12.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Apr 2026 11:12:06 -0700 (PDT)
Date: Wed, 29 Apr 2026 23:42:00 +0530
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, mingo@kernel.org,
 christophe.jaillet@wanadoo.fr, nabijaczleweli@nabijaczleweli.xyz,
 kees@kernel.org, kyungmin.park@samsung.com, k.wrona@samsung.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 1/9] iio: ssp_sensors: cleanup codestyle warning
User-Agent: Thunderbird for Android
In-Reply-To: <20260426145312.06bcd30e@jic23-huawei>
References: <20260426091710.3722035-1-sanjayembedded@gmail.com> <20260426091710.3722035-2-sanjayembedded@gmail.com> <20260426145312.06bcd30e@jic23-huawei>
Message-ID: <07A0C2D3-A621-4553-9C0B-C8713F049ACF@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 26 April 2026 7:23:12=E2=80=AFpm IST, Jonathan Cameron <jic23@kernel=2E=
org> wrote:
>On Sun, 26 Apr 2026 14:47:02 +0530
>Sanjay Chitroda <sanjayembeddedse@gmail=2Ecom> wrote:
>
>> From: Sanjay Chitroda <sanjayembeddedse@gmail=2Ecom>
>>=20
>> Reported by checkpatch:
>> FILE: drivers/iio/common/ssp_sensors/ssp_dev=2Ec
>>=20
>> WARNING: Prefer __packed over __attribute__((__packed__))
>> +} __attribute__((__packed__));
>>=20
>> Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail=2Ecom>
>Applied to the testing branch of iio=2Egit=2E
>
>I'm trying to pick up some of the patches on list just
>to reduce how many are getting sent in new revisions and
>the time it takes people to look at them each time=2E
>
>Not sure how far I'll get in your series so look out for
>when I stop saying I've applied them=2E
>
>thanks,
>
>Jonathan
>

This was started with single change and later based on valuable input and =
guidance from you and Andy and during the internal review and development o=
f driver some new change is getting appended and series is getting long eve=
n after taking few changes to iio=2E

Hoping to close this soon, so I can divert my focus in other open parts=2E

Thanks,
Sanjay Chitroda

>> ---
>>  drivers/iio/common/ssp_sensors/ssp_dev=2Ec | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>=20
>> diff --git a/drivers/iio/common/ssp_sensors/ssp_dev=2Ec b/drivers/iio/c=
ommon/ssp_sensors/ssp_dev=2Ec
>> index da09c9f3ceb6=2E=2E7d07fae295fd 100644
>> --- a/drivers/iio/common/ssp_sensors/ssp_dev=2Ec
>> +++ b/drivers/iio/common/ssp_sensors/ssp_dev=2Ec
>> @@ -28,7 +28,7 @@ struct ssp_instruction {
>>  	__le32 a;
>>  	__le32 b;
>>  	u8 c;
>> -} __attribute__((__packed__));
>> +} __packed__;
>> =20
>>  static const u8 ssp_magnitude_table[] =3D {110, 85, 171, 71, 203, 195,=
 0, 67,
>>  	208, 56, 175, 244, 206, 213, 0, 92, 250, 0, 55, 48, 189, 252, 171,
>
