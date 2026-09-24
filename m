Received: from fortymile.utu.fi (fortymile.utu.fi [130.232.247.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7628D309EE9;
	Thu, 24 Sep 2026 08:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.232.247.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790238724; cv=none; b=YPvDLMdfNpQ68GzWag9XINpvaC101ObaCHf8xT+ziNKwm6PuR0FJfhAGzWgL+Ynhe12N+No6iEppDTFtrRsWXZu68f+QJmCU/fI+EsjUBH69UHJbLTbCIC75M3Rzx/3hAiFx0exuajPeWpNG86qTNYrDXM3e9yOsno2Sd94GKDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790238724; c=relaxed/simple;
	bh=EybUmtKzWa4h97sMCkxFj4OEctuEEAz0En05Ls9JEZs=;
	h=MIME-Version:Content-Type:Date:Message-ID:CC:Subject:From:To:
	 References:In-Reply-To; b=W6nPUKJenNaSY3AmTKEF91tpAvTR+YTptiUFVwkbhdWC54ivJjbtQH5CdcoemBnyKWvsKjmL0+f8CHIZizsD0CVTNEi/vvEZcnhX4UiUEqcPLcf2XK+GRiHyXnIDh3J/MdNnQXZNSdpEHJkRqZEwigYmbBvzoWfylQ1jq7sCJxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi; spf=pass smtp.mailfrom=utu.fi; dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.b=YV7+dySi; arc=none smtp.client-ip=130.232.247.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=utu.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.b="YV7+dySi"
Received: from smtp-03.utu.fi (smtp-03.utu.fi [130.232.207.30])
	by fortymile.utu.fi  with ESMTPS id 68O8VX9h013219-68O8VX9j013219
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Thu, 24 Sep 2026 11:31:33 +0300
Received: from ex19-16.utu.fi ([130.232.247.56])
	by smtp-03.utu.fi with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <jaakko.ma.koivisto@utu.fi>)
	id 1x9erc-00Emy5-UP;
	Thu, 24 Sep 2026 11:31:32 +0300
Received: from localhost (91.145.105.139) by ex19-16.utu.fi (130.232.247.56)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 24 Sep
 2026 11:31:32 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 24 Sep 2026 11:31:32 +0300
Message-ID: <DLNENHM2KZMM.1IXMNOM1FL17W@utu.fi>
CC: Andreas Klinger <ak@it-klinger.de>, Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?=
	<nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
	<linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] iio: chemical: sgp40: Implement
 get_serial_number-command
From: Jaakko Koivisto <jmatko@utu.fi>
To: Andy Shevchenko <andriy.shevchenko@intel.com>, Jaakko Koivisto
	<jmatko@utu.fi>
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3
References: <20260918134019.1101308-1-jmatko@utu.fi>
 <20260918134019.1101308-2-jmatko@utu.fi>
 <aq6XtHY6Yp-qyg5f@ashevche-desk.local>
In-Reply-To: <aq6XtHY6Yp-qyg5f@ashevche-desk.local>
X-ClientProxiedBy: ex19-14.utu.fi (130.232.247.54) To ex19-16.utu.fi
 (130.232.247.56)
X-FEAS-BEC-Info: WlpIGw0aAQkEARIJHAEHBlJSCRoLAAEeDUhZUEhYSFhIWkhZXkguLT4lWFxYWFhYWFBeUVxfSFhISFpdSAIJCQMDB0YFCUYDBwEeARscBygdHB1GDgFIWUhaX0gJBgwa
 ARFGGwANHgsADQYDBygBBhwNBEYLBwVIWEhaSFlcSFlbWEZaW1pGWlhfRltYSFBIWEhYSF5IWEhYSFhIWV5ICQMoARxFAwQBBg8NGkYMDUhYSFpfSAkGDBoBEUYbAA0e
 CwANBgMHKAEGHA0ERgsHBUhYSFldSAkGDBEoAw0aBg0ERgcaD0hYSFpZSAwEDQsABg0aKAoJEQQBChoNRgsHBUhYSFpdSAQBBh0QRQEBBygeDw0aRgMNGgYNBEYHGg9I
 WEhZUEgGHQYHRhsJKAkGCQQHD0YLBwVIWA==
X-FEAS-Client-IP: 130.232.207.30
X-FE-Last-Public-Client-IP: 130.232.207.30
X-FE-Policy-ID: 3:5:2:SYSTEM
X-FE-Hostname: fortymile.utu.fi
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=utu.fi; s=out-utu-v3; c=relaxed/relaxed;
 h=mime-version:content-type:date:message-id:cc:subject:from:to:references;
 bh=92acAzZFvhVDHt9lngW69ZfUTqXDmj+Y2HXTmSss9Nw=;
 b=YV7+dySiWbEGJLvRy0Z68fCWZe6SCIWMAP+mKPWXl/LXOSmQ1gxwn2/lGxMFW7he1z7jPro9LDUO
	iCKR4Z1/ITWqWhr+qsx/jjIh0uVFtupLlBpkoANKnC6+IKAjuYzVQ2hZNnI6XDoCztsX5312H0Iw
	aDKZ6S1pHLbVxarUbh+rKUhZf5b2U3NgQiNu2YAP551SAWN7GgmG+LDXswdxYaornewEvq5FVF/p
	jDGwYWvOeUTEMysn/0kQSN4m0sV15teVheUlkXwePpt6e/k7su36yzKjhUJU7qEiBJG4vbHuK/E8
	FpQFAkrX2ORKpzkZ0CUF6whftMYdlxi5cwOHoQ==

On Sat Sep 19, 2026 at 5:09 PM EEST, Andy Shevchenko wrote:
> On Fri, Sep 18, 2026 at 04:40:17PM +0300, Jaakko Koivisto wrote:
>> -Retrieve the chip serial number.
>> -Present the serial number to userspace as device attribute.
>> -Rename the tg_measure -struct now that is is used for multiple
>> commands.
>
> ...
>
>> +	ret =3D i2c_master_send(client, (char*)&get_sn, sizeof(get_sn.command)=
);
>> +	if (ret !=3D sizeof(get_sn.command)) {
>> +		dev_err(data->dev, "i2c_master_send ret: %d, expected %zu", ret, size=
of(get_sn.command));
>> +		return -EIO;
>> +	}
>> +	msleep(1);
>
> Explain this sleep.

It is the maximum time it takes for the chip to execute the command.
I'll add a comment describing it.

In testing this command works if the sleep is omitted, but I would leave
it here anyway to be sure we don't try to read the result before the
chip is ready.

>> +	ret =3D i2c_master_recv(client, (char*)&res, sizeof(res));
>> +	if (ret < 0)
>> +		return ret;
>> +	if (ret !=3D sizeof(res)) {
>> +		dev_err(data->dev, "i2c_master_recv ret: %d, expected: %zu", ret, siz=
eof(res));
>> +		return -EIO;
>> +	}
>> +
>> +	if (crc8(sgp40_crc8_table, (u8*)&res.A, 2, SGP40_CRC8_INIT) !=3D res.A=
_crc ||
>> +	    crc8(sgp40_crc8_table, (u8*)&res.B, 2, SGP40_CRC8_INIT) !=3D res.B=
_crc ||
>> +	    crc8(sgp40_crc8_table, (u8*)&res.C, 2, SGP40_CRC8_INIT) !=3D res.C=
_crc)
>> +	{
>> +		dev_warn(data->dev, "CRC error in get_serial_number");
>> +	}
>> +
>> +	data->serial_number =3D 0LL | ((u64)be16_to_cpu(res.A) << 32) | ((u64)=
be16_to_cpu(res.B) << 16) | (u64)be16_to_cpu(res.C);
>
> 0LL ?!
>

I have no excuse for this. Both unnecessary and for u64 should have been
LLU. I will remove it.

>> +	dev_dbg(data->dev, "serial number: %llu", data->serial_number);
>
> Why?!
>

You are right, not really debug information. Will remove.

>
> ...
>
>> -	struct sgp40_tg_measure tg =3D {.command =3D {0x26, 0x0F}};
>> +	struct sgp40_command tg =3D {.command =3D {0x26, 0x0F}};
>
> While at it, add more spaces.
>

Thanks, I'll fix this and other formatting mistakes.

> ...
>
>> +}
>> +
>
> Unneeded blank line.
>
>> +static IIO_DEVICE_ATTR_RO(serial_number, 0);
>> +
>> +static struct attribute *sgp40_attributes[] =3D {
>> +	&iio_dev_attr_serial_number.dev_attr.attr,
>> +	NULL
>> +};
>> +
>> +static struct attribute_group sgp40_attribute_group =3D {
>> +	.attrs =3D sgp40_attributes,
>> +};
>> +
>> +
>
> Single blank line is enough and we have ATTRIBUTE_GROUPS().
>

Is using ATTRIBUTE_GROUPS() valid here? ATTRIBUTE_GROUPS(sgp40) will
create both attribute_group sgp40_group and
attribute_group *sgp40_groups[], and we only need the first one for iio_inf=
o.
The extra *sgp40_groups[] will create unused variable -warning.
