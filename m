Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C3B3E3145
	for <linux-iio@vger.kernel.org>; Mon, 20 Jul 2026 16:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784566235; cv=none; b=QatQultZvTOg5rjpRAOXMN+FILQ4s64umMgD2gOelfwynq4s1s6o2UYw2E5QaHOWCnyIXfMyL6Uqc8LAXLC4PXAf3R77l7N5xcbe1ItsNATzwJ8Z6JcTipl9+q3v4SS0m5EpZ2py3xEJkq+WOdkHRwrtN2Q7xoUyowzvSrvQ2Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784566235; c=relaxed/simple;
	bh=xLj8gVdARFZvL7dMaAwyCyeARyxXEU4B3zwUZPi/zlk=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=P/JcIdC8AhL5I6mcrAbT5Uh9I+233C0TPrX32cGKYCmK3yAk04Kkj1mofbl3Ppt6DEmldz06LoXqimdfdmVHCJDG0mSpQ8tbX1s/v5+hTNI8PUZtWFj3tWk2BaSGqEYx2MtutmOIQbyQdTJcxVRgMiF1apZ/vIRdR2laDvvegGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CxgjVmxL; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CxgjVmxL"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-38df94d4dd8so5043692a91.2
        for <linux-iio@vger.kernel.org>; Mon, 20 Jul 2026 09:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784566234; x=1785171034; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :references:in-reply-to:user-agent:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=E9JE/eR+ETc25R/xPipwqaolcgylczRQleB6t8SczIQ=;
        b=CxgjVmxLrj4zWpRiA52rv2BC1lJOLzgDZBogublJPBkKVnWy4wyTYesnTvFQVa0xb0
         uuYiDISHcr8BSjVNF/1g73AFBWwL5Lyq16l7ks+X2bDJXlgzVI+HhtZv3sUq7KGQ/fq/
         jLweqAUIfY5UElnkmBZgYItFD1+sANchyZfopO3Fc/eLqD7ODxvAU/R2rnvscbk4S8RS
         VmjVPBVbTc5dytPkuSGtPt4kgOy68Xiy8wWTIVNgaemaYVId+rmU+JbK28P5zeEncNnm
         42Uy2CiE0mcO7uzhp5ZT74pihjL2N7Fyxs0NllDvtkMd6Hky9bUbPVSS8ws7BM/EPlwJ
         xeyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784566234; x=1785171034;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :references:in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=E9JE/eR+ETc25R/xPipwqaolcgylczRQleB6t8SczIQ=;
        b=ElYRW/CPiSxUhsTm2cV8Xx+DHKxCXtRCUG6a1NmieGu1Qq9ZuRRNUUka82b/L+B4za
         0x1JiqbHUU8ngXzXzesWYakOvIZ8G8cItEcsqsFwUgGEpEbwe0al+YD/ar64T6orz/T+
         Mf8lhJerlc6N7BNcq8XdCh0shfFVtMKigIUR86hVfgdWoJBbaSjs0gH9O10MhK1ZPhH7
         q3kVQj5yZHQY+QcNt6pbtGmj9NxMjpBnCtNqpzkZm977BnTG8pEU/768ATBkhGdKo7gi
         CkmCT9GrMDg7mMkuc+NnZNGShkyGLX2/gK6wKuRhsd7u4dJK9Lv7lUpUw/dfJHiHTrOQ
         J38w==
X-Forwarded-Encrypted: i=1; AHgh+RqRrfPLmKsFtB1IFrPLr1LcqeQHnGyEMY653jGKGnGwkaGS/T6E1dWQ31HLH6HyoqgUGVgi/4Fi8wI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEa0BY4UEW52crgjj15ZdiVvJ3X5AGoK2xAbyhedDo+QGWDR80
	NLdDSPYhiAdpzBhZmeYg6BTJB1rLJbPqvxpohnS7AGxJ51FybAzzqYH1DctDTQ==
X-Gm-Gg: AR+sD12SBzJg/JYDBkm/4HIkTNapr7/Pkw3EsaGe4qK1LdfpShSSRcYIkR0sxfZCBx9
	3ampgd6rvTblFeSGZm9oaAQRLfCcTMpaBhCmPYxBc/h+n7YVLvC8+RE6ZWJT6vqRVXkbIokjj0U
	4JO3fsQUSHqA5/wEE9FWTGfoJruPHXMCfFaPLPKJUBcF9hHsPDFp0u26o2Kni3JmVSs7eTYDPqE
	/XiO5dlLWf+3lE5jGhfgnzP+qcIc/LUlgGZKN2VdmiUbmeOSyh9i75BZ8WpAqK3atcj33TeHlDL
	9k1QhS4+aDL8b6xAxwv4TlxVg2LqLKXGDgscVlePPWo43jkrkbkkKJvhqzbQLcG/LNMhDKW/QY4
	5YXOb+Utpk3FTI5Cwy9TapWyom6EYGnYjd5yZ3t1/V7cv1wLvESJkRdplyHDOuNKrmdS+42zgLo
	GDKsu1tZtsCZzD6FoOMSRR0tWb5A==
X-Received: by 2002:a17:90a:d44e:b0:38d:ddc2:7ccb with SMTP id 98e67ed59e1d1-38e4b3d0fdamr14849441a91.1.1784566233232;
        Mon, 20 Jul 2026 09:50:33 -0700 (PDT)
Received: from ehlo.thunderbird.net ([2401:4900:1f3f:a2a5:2929:50ea:668d:9415])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13ce2a129f3sm30207025c88.7.2026.07.20.09.50.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jul 2026 09:50:32 -0700 (PDT)
Date: Mon, 20 Jul 2026 22:20:28 +0530
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
CC: Jiri Kosina <jikos@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 David Lechner <dlechner@baylibre.com>,
 =?ISO-8859-1?Q?Nuno_S=E1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, linux-input@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_02/10=5D_iio=3A_gyro=3A_hid-sen?=
 =?US-ASCII?Q?sor-gyro-3d=3A_use_local_struct_device?=
User-Agent: Thunderbird for Android
In-Reply-To: <al4MeTgAWWkJsb1T@ashevche-desk.local>
References: <20260720-hid-iio-local-struct-device-v1-0-74496fee6327@gmail.com> <20260720-hid-iio-local-struct-device-v1-2-74496fee6327@gmail.com> <al4MeTgAWWkJsb1T@ashevche-desk.local>
Message-ID: <1E009860-0A0F-4F8D-8017-CE5739F22144@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 20 July 2026 5:24:33=E2=80=AFpm IST, Andy Shevchenko <andriy=2Eshevchen=
ko@intel=2Ecom> wrote:
>On Mon, Jul 20, 2026 at 03:10:14PM +0530, Sanjay Chitroda via B4 Relay wr=
ote:
>
>> Introduce a local struct device pointer derived from &pdev->dev=2E
>> This avoids repeated &pdev->dev usage and improves readability=2E
>
>=2E=2E=2E
>
>>  	if (ret) {
>> -		dev_err(&pdev->dev, "failed to setup common attributes\n");
>> +		dev_err(dev, "failed to setup common attributes\n");
>>  		return ret;
>
>Nope, First one (to eliminate a lot of churn) should be to convert this a=
nd
>similar to use
>
>		return dev_err_probe(=2E=2E=2E);
>

Hi Andy,

Thank you for your input=2E

I'm planning to have a incremental series: first introduce a local "dev" p=
ointer, then convert the resource management to "devm_*", and finally repla=
ce the remaining error reporting with "dev_err_probe()"=2E

This keeps each series focused and avoids introducing intermediate pattern=
s such as:

   ret =3D dev_err_probe(dev, ret, =2E=2E=2E);
   goto error;

Once the cleanup paths are removed, those sites naturally become:

   return dev_err_probe(dev, ret, =2E=2E=2E);

Does this approach sound reasonable?

>>  	}
>> =20
>> -	indio_dev->channels =3D devm_kmemdup(&pdev->dev, gyro_3d_channels,
>> +	indio_dev->channels =3D devm_kmemdup(dev, gyro_3d_channels,
>>  					   sizeof(gyro_3d_channels), GFP_KERNEL);
>>  	if (!indio_dev->channels) {
>> -		dev_err(&pdev->dev, "failed to duplicate channels\n");
>> +		dev_err(dev, "failed to duplicate channels\n");
>
>And this kind of messages are dead code and must be just removed complete=
ly=2E
>
>>  		return -ENOMEM;
>>  	}
>
>=2E=2E=2E
>
>Please, revisit the whole series=2E

Yep, understood=2E

I'll revisit series, drop dead code and send v2=2E

Thanks, Sanjay
>
