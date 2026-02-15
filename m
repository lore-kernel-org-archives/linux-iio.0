Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00DEE19C54E
	for <linux-iio@vger.kernel.org>; Sun, 15 Feb 2026 17:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771176553; cv=none; b=PvozGJd7P2hP6Y4fPcgMHPn5uzUTH8B/BrnvSZIYUFhWaEUSVNBGKhb0M/eegR+Nc6n4Cl/TwUegcc4WTFO1Ioji8m9USMC7USOdXmyUPl5IXcz9R+sNmehXTKh3b216LrJgybB0J/WyaAzevAd9CbWtG7Ve2Fil1hvyz8ny8yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771176553; c=relaxed/simple;
	bh=kRubzSeb34gMBhG/k1GBQIhV9N/5ZWh5nds6hV6yhWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ge7BimSQA0hLT6nuZ13NGKUaAu3GCSc7y5+huQt+xTEx2uFKav0plejQ6CtL2+ELdSwxSiA4q5eoOcJCp2Fcm0dPTdiIkw2s8SptQM6VRUg+FIR8w72yjGXvWfqWpn76la888fBEMKodJpGATcq7+zbMxbr6O2VcW18IkW62wyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eoOCqX0n; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eoOCqX0n"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-7927b1620ddso30290437b3.0
        for <linux-iio@vger.kernel.org>; Sun, 15 Feb 2026 09:29:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771176551; x=1771781351; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J0U5EsIEfZrt+jHVfvpA1PnJrdcLESznUrVQtE1RRsU=;
        b=eoOCqX0ndzmjxkVSpUoyZB235XkiIBNm/uZNdlBQV5u6l+wMqR3adCxol5W0736aIC
         dvn2eEO/ywRqlgPasRIWfyrBXFCKypHCgrK/NAcKZ2EqpjOILr3yd0V13rCnyj7ct8D0
         2p4sYtNAt32rG8yowCEVTSKDC0cuB3lhCTpqWn5tGskCdpYIi4scyEVZtU8PO9QUouUf
         eYWPw6P4QWUNJNoINhPDhTDZwZWznLqRztOeLIxpCM+bZLdfKNKWEbObxv4z471/IHz0
         3WrZkAqedHZMxwtnUfD5UyDanFufdzNGm4ZVeyjyOpOZ/fp8WUiBtdFCrkIx02/84XSv
         ogQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771176551; x=1771781351;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=J0U5EsIEfZrt+jHVfvpA1PnJrdcLESznUrVQtE1RRsU=;
        b=cclfkVIuqfT/4oSpzT48GZwhV51QW/Z41bkDtfHd85EeYTxjj3QUacdxZfFJOqsybN
         PpQhFQMXftmalhGT+6GTlbaVIPnKZ8+LgoIMawrn1JAUqlF07SieIXXbCu4p11jbN8CR
         rzj0oAmKAjdw2W6Nid+tpKpoigj3vkyZxzrm5OV7Db6xSiaXMIyILQOjmkHy5IqppE8G
         lRGLAwiWYmMYgJJ1wvjhz1NYt2yRVWRir9MWa4u7N8z4Z9Tju6R08Wp4Fp+DiyMU4ahf
         DDrs36P5h//QTkZ1SQi4wFgeJkaf1PR7FtYx9GZyPB4JUcC/YI3eRP2uyGryzlSi6hhn
         G2AQ==
X-Forwarded-Encrypted: i=1; AJvYcCUIIFHInXujiy8qk1PTsdHmsppRtZiw73n30kBD1BtExtDz4ORx6kdjZ0ARBKRh6F9znilZQYH0Xc8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxV2oGI4U2rJy6uAhfhCFmUJVLEGzNdiMivx0zv6wNu4fuBAtIl
	sgcm4DGe901Wf+rr8GSHZB43NKNQlFw7oS9neehQ9So5FeF50JIo0SEn
X-Gm-Gg: AZuq6aKWPWgphg7E+BuOcftSC2QUBCNaFLc90eRjFSoAwBR1DISDI1sYqHgDntdwVAR
	7GiC06MhxbuE+sGA1cIqK98yQhZaK6lowfv1fXA17f/xPF3/dOhM5dPAEtVibjyhpXvLqg3CiT3
	2vAjv6e1Zz/mPcc60xiVlPCa8dcONOFh8fQ1rxrvklBIPX6r+xEjO+23fcPAI+g65BEp880OQX2
	qfYu2CednNP8sF7SjbUcD9QYM1OKIUdgIlz4cFX+rwncGDMoA9Knj4jZKgiWJLOb6WG0lZzCOO+
	/1HvUJ/9wqrz5Nkc3S0wWR+feAA1rJRzVqmW/TpSrfBA7/FLI0z3plOPnYPm6kt2MgVZZm4+eYc
	mhfz5RvfrmgZbRB0c/7otuuiZsEDkg1o7C7sr4bbcRMQbLSqQ9SkqWs7u9EJYGNtpdMJ0gyuHp4
	PCpFkAwaVAkMj9uEfdRavdKXuliTeZLKo=
X-Received: by 2002:a05:690c:e3c3:b0:796:4015:94a with SMTP id 00721157ae682-797aa905a63mr48543847b3.20.1771176550933;
        Sun, 15 Feb 2026 09:29:10 -0800 (PST)
Received: from crusty-box ([79.133.247.80])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7966c16e7b0sm92169247b3.4.2026.02.15.09.29.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Feb 2026 09:29:10 -0800 (PST)
From: Erikas Bitovtas <xerikasxx@gmail.com>
To: jic23@kernel.org
Cc: andy@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	dlechner@baylibre.com,
	krzk+dt@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nuno.sa@analog.com,
	phone-devel@vger.kernel.org,
	pmeerw@pmeerw.net,
	robh@kernel.org,
	xerikasxx@gmail.com,
	~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v4 2/2] iio: light: vcnl4000: add support for Capella CM36686 and CM36672P
Date: Sun, 15 Feb 2026 19:28:56 +0200
Message-ID: <20260215172856.34702-1-xerikasxx@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260214180919.72389701@jic23-huawei>
References: <20260214180919.72389701@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 2/14/26 8:09 PM, Jonathan Cameron wrote:
>> ---
>>  drivers/iio/light/vcnl4000.c | 40 ++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 40 insertions(+)
>>
>> diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
>> index a36c23813679..1f8f4e4586f4 100644
>> --- a/drivers/iio/light/vcnl4000.c
>> +++ b/drivers/iio/light/vcnl4000.c
>> @@ -185,6 +185,7 @@ static const int vcnl4040_ps_oversampling_ratio[] = {1, 2, 4, 8};
>>  #define VCNL4000_SLEEP_DELAY_MS	2000 /* before we enter pm_runtime_suspend */
>>  
>>  enum vcnl4000_device_ids {
>> +	CM36672P,
>>  	VCNL4000,
>>  	VCNL4010,
>>  	VCNL4040,
>> @@ -235,6 +236,8 @@ struct vcnl4000_chip_spec {
>>  };
>>  
>>  static const struct i2c_device_id vcnl4000_id[] = {
>> +	{ "cm36672p", CM36672P },
>> +	{ "cm36686", VCNL4040 },
>>  	{ "vcnl4000", VCNL4000 },
>>  	{ "vcnl4010", VCNL4010 },
>>  	{ "vcnl4020", VCNL4010 },
>> @@ -1842,6 +1845,22 @@ static const struct iio_chan_spec vcnl4040_channels[] = {
>>  	}
>>  };
> 
> ...
> 
>>  	[VCNL4000] = {
>>  		.prod = "VCNL4000",
>>  		.init = vcnl4000_init,
>> @@ -2033,6 +2065,14 @@ static int vcnl4000_probe(struct i2c_client *client)
>>  }
>>  
>>  static const struct of_device_id vcnl_4000_of_match[] = {
>> +	{
>> +		.compatible = "capella,cm36672p",
>> +		.data = (void *)CM36672P,
>> +	},
>> +	{
>> +		.compatible = "capella,cm36686",
>> +		.data = (void *)VCNL4040,
> 
> Is this necessary? I 'think' if you drop it we'll match instead
> on the vcnl4040 fallback and then the access to the data will be
> through the stripped name only bit of the compatible (first entry, not
> the fallback so cm36686 in this case). So you do need the cm36686
> entry in the i2c_device_id table above. Probably better to keep
> this here to avoid having to reason this out - but perhaps a
> comment to that affect would be useful (assuming you verify my
> reasoning).
>
After I removed the entry for "capella,cm36686", I received the "Unable
to handle kernel NULL pointer dereference" error in dmesg. And at least
stk3310 driver includes a compatible entry both for the device (stk3013)
and for the fallback (stk3310). So my assumption is that this entry is
needed.
I could include a comment explaining that cm36686 is fully compatible
with vcnl4040, however, if that is necessary.
> As Andy suggested moving away from enum values an towards
> direct pointers to the chip_info structures + drop the
> i2c_client_get_device_id() in favour of i2c_get_match_data() which
> uses the right firmware entry to get the data in all cases is the
> right long term solution and avoids an association being necessary
> between the two tables.
> 
> Jonathan
> 
> 
> 
> 
>> +	},
>>  	{
>>  		.compatible = "vishay,vcnl4000",
>>  		.data = (void *)VCNL4000,
>>
> 
