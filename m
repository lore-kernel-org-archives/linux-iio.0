Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46AF627057D
	for <linux-iio@vger.kernel.org>; Thu,  7 May 2026 02:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778122123; cv=none; b=Ace2XD63JutyGhOx8PYwKNCYHnVnChz0aBrz9g4j8aV9W267kcO3ifyCuvPvTnm5hPvVUakHFjZmUXdgBPH9w/v6CLFai7ouz7fygFP+hgyJINjUfE/2Z0xP7RlrNLFDoYhTkFZptwkyWy/KeAYHFccY9TQFJmkmHFbDrg+uGEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778122123; c=relaxed/simple;
	bh=tMvM2QBI4N4/MiKMdfR4y0Ye/kiDFDB2JQHZVD0/8q4=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=j+nKSqyG379Xq71xluH/rKtymnWIl/lzIaP7yVpEVrg5Ku4wpv8X8aYQMDD1tHHO6jgStNcz05/eQOF6ixp9eQxrpY43z2A4HKRKcSG9rCpq+WDIfbHE2f+ei+f2sxF+1IpDNgLH39VsSbWRCg46oBcDvnfPuB67Y4JVCPgeh5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PpSs+4m1; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PpSs+4m1"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2ba3e3c4f87so3078175ad.3
        for <linux-iio@vger.kernel.org>; Wed, 06 May 2026 19:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778122121; x=1778726921; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SsHq2tMTa92LyWH+93ll7/KRvRPnoBRg1Q/lbX4SdXE=;
        b=PpSs+4m13N/oiqJmVg3Cv0TSEJ5xmHHL/In1Y3rNoqSJFfQTbfBLY7viWHQqcerkRs
         /fOTKt4uzW8Vj+U7w8PSE9qI3f7B78Qt7fB+D3Q06A1PIZy88IgYZQlvZLo158UfI8pK
         Lb2Gxa2nGrOvruLkYyjC4VZg626OR0bnllHBKfbLfE+UnwCsBjYVpeung+EEiVMFjxzh
         zThrSlwEliAL7KaorXZSLmAQNlmz8zaFmltQP+o8bWuzxqn0n2rW83OgGFgn7dmYAUMV
         v6lvdnpbgQHu0bvpQ2yyrD6mpu19Bk1kmra4QgQudmubqYjINNvb94TJ2w0bEVekLtz5
         ShaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778122121; x=1778726921;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SsHq2tMTa92LyWH+93ll7/KRvRPnoBRg1Q/lbX4SdXE=;
        b=rW+LnNYQIlHDYPctzM35jWrFxO8GdaBH5EyXRUhp2QYVAvtP6RTU5yoBXjwDpWsBbm
         oFfij3TMhN3eyszxteGHf1Mg8E4MBsT8QqwfTSeLCZNhCs24Ugeyx8gpU5nKu+pZMrNQ
         2DYhxCeA8K2/O/89kYow+fQSCACy7Da32NZMJifzKUfUJ/Oaf4eJZGpBhwhxOgbuNUuU
         XD3ya5IdeiAcHrSNgPEeprwD4FlfvvnQuRdnLRauuImG/zTVwB5cTh/jPv/EmgsaEe13
         W7v//3j04PN8YlKBPcetwqUqFnhy5YFaAjN0SCGfOhxDHPqdjnzQlHsN0gNwi/mSG6tC
         /pZQ==
X-Forwarded-Encrypted: i=1; AFNElJ8d7bYQIgwee1FDmfRLretG2dW6TgYGDWsneoKw+uwIF62MaRzn05yt64tn/3J/oY2BhRR5cKhqqug=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQKzGpSF0prwQJJpPnWuHbGQGM1V+8Ygx2+ILnBFAperYN+MxZ
	4YLEZ+mpr634MQum9jfU17Exgbz8HpND/WUccwbcfyE7KVyq3pHez8e5d9RN8A==
X-Gm-Gg: AeBDieuFUjFgC2WKO4ZQzQ3K5SEQLi5SascxdxmlDeS/iOmlEvENF+tIEaFsEbc8fXP
	iCBeOu61/hWzGj42EVRr0oKLs4UiTcLcbT07esFY1ARrr4DywGt2Mjr15lzGYWQBURNwab4MdA8
	bS1kqAdhImcj5Llb6RUF10o3cl0TceTfjYX62XW8SKcsJFDG/GkSa+W34HtpSS6YeUfOSfB6+Ln
	iyN9A5Ngg+KAqL4PXWDzED81/k1+Bc0WW8+1OdhBBLbLzWABW9ZoeqMqtio7QvTb/Ih06enbh/M
	Ckt7xEhePQyadjTDl3kUmbN70LeNfcG4bRZI1u9nDqI7z1hKycFzTYxfwWfHW2b8U6cW/absA+V
	K83z2dFJ3NBw7pwadgV1mdFC6OZp2U/jyzRAs4eLDivATVlvHviEIUFTgsrQ+yXoNrx8AZ+WKme
	loUWrRdcLcf5tBAHI+ESo7scX9/TC6p39XNAxyBuWFtKtbXt2Jb1v/anWcmg==
X-Received: by 2002:a17:902:f650:b0:2b2:5503:1b8d with SMTP id d9443c01a7336-2ba78f63e64mr59462595ad.6.1778122120543;
        Wed, 06 May 2026 19:48:40 -0700 (PDT)
Received: from ehlo.thunderbird.net ([2401:4900:ac23:b594:789f:a6c4:c581:db80])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2babb0e4a37sm6502555ad.74.2026.05.06.19.48.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 May 2026 19:48:39 -0700 (PDT)
Date: Thu, 07 May 2026 08:16:40 +0530
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 sakari.ailus@linux.intel.com, christoph.muellner@theobroma-systems.com,
 martink@posteo.de, mfuzzey@parkeon.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v3_08/10=5D_iio=3A_accel=3A_mma8452=3A?=
 =?US-ASCII?Q?_use_pm=5Fptr=28=29_and_direct_runtime_PM_calls?=
User-Agent: Thunderbird for Android
In-Reply-To: <20260506190654.598dca87@jic23-huawei>
References: <20260505174640.3998281-1-sanjayembedded@gmail.com> <20260505174640.3998281-9-sanjayembedded@gmail.com> <20260506190654.598dca87@jic23-huawei>
Message-ID: <4719ED48-6731-4319-8724-35F174C199B8@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 6 May 2026 11:36:54=E2=80=AFpm IST, Jonathan Cameron <jic23@kernel=2Eor=
g> wrote:
>On Tue,  5 May 2026 23:16:38 +0530
>Sanjay Chitroda <sanjayembeddedse@gmail=2Ecom> wrote:
>
>> From: Sanjay Chitroda <sanjayembeddedse@gmail=2Ecom>
>>=20
>> Use pm_ptr() together with DEFINE_RUNTIME_DEV_PM_OPS() so the PM ops
>> pointer is automatically handled when CONFIG_PM is enabled or disabled=
=2E
>>=20
>> Switch to direct PM runtime calls and drop
>> mma8452_set_runtime_pm_state() wrapper, which is no longer needed=2E
>> This follows modern kernel power-management conventions=2E
>>=20
>> Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail=2Ecom>
>
>Hi Sanjay,
>
>The cleanup you have in here has made what i think are two nasty race
>conditions much  more obvious=2E I think we need to fix those
>(and that fix needs to go at the start of this series)
>
>Thanks for you work on this driver - this problem has been
>there a long time!
>
>Jonathan
>
Hi Jonathan,

Thank you for your review and kind words=2E

Your guidance and feedback are very motivating and help contributors stay =
consistent and improve their work=2E

It is an honor to collaborate and learn from experienced maintainers like =
you=2E

Also, I would like to know if there are any opportunities in other IIO dri=
vers or within the kernel framework where contributions would be helpful, e=
specially around fixes, resource management, power management, or general c=
ode cleanup and coding style improvements=2E I would be glad to work on suc=
h areas and continue contributing=2E

Thanks,
Sanjay Chitroda

>> ---
>> Changes in v3:
>> - Use direct PM runtime calls and drop redundant wrapper along with CON=
FIG_PM
>> - Link to v2: https://lore=2Ekernel=2Eorg/all/20260422165643=2E2148195-=
6-sanjayembedded@gmail=2Ecom/
>> Changes in v2:
>> - Use DEFINE_RUNTIME_DEV_PM_OPS to address review comment and resolve 0=
-day bot warning
>> - Link to v1: https://lore=2Ekernel=2Eorg/all/20260414192045=2E3598010-=
1-sanjayembedded@gmail=2Ecom/
>> ---
>>  drivers/iio/accel/mma8452=2Ec | 55 +++++++++++++----------------------=
--
>>  1 file changed, 19 insertions(+), 36 deletions(-)
>>=20
>> diff --git a/drivers/iio/accel/mma8452=2Ec b/drivers/iio/accel/mma8452=
=2Ec
>> index 2cd24b1543af=2E=2E5ab981481599 100644
>
>
>>  static ssize_t mma8452_show_int_plus_micros(char *buf, const int (*val=
s)[2],
>> @@ -974,6 +953,7 @@ static int mma8452_write_event_config(struct iio_de=
v *indio_dev,
>>  				      bool state)
>>  {
>>  	struct mma8452_data *data =3D iio_priv(indio_dev);
>> +	struct device *dev =3D &data->client->dev;
>>  	int val, ret;
>>  	const struct mma8452_event_regs *ev_regs;
>> =20
>> @@ -981,8 +961,11 @@ static int mma8452_write_event_config(struct iio_d=
ev *indio_dev,
>>  	if (ret)
>>  		return ret;
>> =20
>> -	ret =3D mma8452_set_runtime_pm_state(data->client, state);
>This smells like the same bug as below=2E=20
>> -	if (ret)
>> +	if (state)
>> +		ret =3D pm_runtime_resume_and_get(dev);
>> +	else
>> +		ret =3D pm_runtime_put_autosuspend(dev);
>> +	if (ret < 0)
>>  		return ret;
>> =20
>>  	switch (dir) {
>> @@ -1452,10 +1435,15 @@ static int mma8452_data_rdy_trigger_set_state(s=
truct iio_trigger *trig,
>>  {
>>  	struct iio_dev *indio_dev =3D iio_trigger_get_drvdata(trig);
>>  	struct mma8452_data *data =3D iio_priv(indio_dev);
>> +	struct device *dev =3D &data->client->dev;
>> +
>>  	int reg, ret;
>> =20
>> -	ret =3D mma8452_set_runtime_pm_state(data->client, state);
>
>This functions makes me very suspicious and I think has a nasty existing
>race condition=2E  If the auto suspend were to suspend immediately
>vddio would be powered down=2E  Unless they supplies have odd naming on t=
his
>device that means the bus would be down before the write that follows=2E
>
>As such I think this needs s rewrite to makes sure we only call
>pm_runtime_put_autosuspend() after the bus writes in this function are do=
ne=2E
>
>I think that is safe to do without testing as all it will do is delay
>when the power gets turned off a tiny bit=2E
>
While in-corporating direct PM runtime call; I also observed that this is =
against the expectation and design as per my knowledge=2E

However, I assume that thisust be well tested and something which I may no=
t aware specific to driver=2E So I done changes as per requirement and wait=
ed for input from reviewer and potentially guidance on the same=2E

Now, this is clear issue and will handle same in next series=2E

>> -	if (ret)
>> +	if (state)
>> +		ret =3D pm_runtime_resume_and_get(dev);
>> +	else
>> +		ret =3D pm_runtime_put_autosuspend(dev);
>> +	if (ret < 0)
>>  		return ret;
>> =20
>>  	reg =3D i2c_smbus_read_byte_data(data->client, MMA8452_CTRL_REG4);
>> @@ -1738,7 +1726,6 @@ static void mma8452_remove(struct i2c_client *cli=
ent)
>>  	regulator_bulk_disable(ARRAY_SIZE(data->regs), data->regs);
>>  }
>
