Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C33829ACD1
	for <linux-iio@vger.kernel.org>; Sun, 19 Apr 2026 15:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776614292; cv=none; b=qwSTlWlTkIcZQINWM7xsYrovkg+06x27MNVlx83lFn2IU5VCKJKuTCh/I2pZUca5aADl/vT0tYm1CwjF/qwDpBmPRDz5spwNHUDLDDWZyLkIcw8lKdhsXNIci5asFcIe7NlMMg1/8INIbahjm76EP1DClmVAwPP9c8UIdkLgT3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776614292; c=relaxed/simple;
	bh=Ip0uApDZ6x7hRkZvRDNKOwE5Zeh0oXvzgtrcztSV47U=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=Pfl3g7Qg56tTh8UbqIB1XFUrxLGdHaCCdGRpU+SxtXQLHLNGHENlcdDCQ3Gxs4l1YRWCFRgHB8E+L90847NGVnTZ6v414+rMQPoPe/CIsfmMvdj0s7hUCSTXor84E7IogicTUTbR9B5PlLCJmlBUm8rahUjy0GamQG3i6YHPTNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sEaslfaW; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sEaslfaW"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2a7a9b8ed69so19346125ad.2
        for <linux-iio@vger.kernel.org>; Sun, 19 Apr 2026 08:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776614291; x=1777219091; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0pvLGE9DXtsZnzykj2HCgk/O/2QaHeFt6T/nI5O33gQ=;
        b=sEaslfaWi5fbQqNBKZ3GfoBKzA1vF6Ct/BQ5XNdSbKP9EtaqaAjKLRW+gClXPHxq3U
         ljoYeECg9Sd6XgBC4oft33F2/s9ALjW1zLEifFX4WbX7wguIJVzkrReYjIXfddqUqjCb
         ifKUD+zyl7DuPlY1AStIRleYByrGr32zBA0RDyFf6SjqmQXbhN39uIM9tOfJ7FagQ+RT
         HyqadZkwD2HM/KCs7EtI6Ahuj+96iIUje1inSLbn11xNkN4C+p8FnXh0GrRBj0O8MplS
         ijS9BSzkkEk2b9JliuQe8iDCs0WKb0P7gDXrmIKbTNHXc1VgcrVOIG6PpDh1TbTgZLwl
         rLMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776614291; x=1777219091;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0pvLGE9DXtsZnzykj2HCgk/O/2QaHeFt6T/nI5O33gQ=;
        b=ZgCbCY/AvQ6cn8YQrTJJIDlXHWc5GfGVnpT2rPXVfgv5JUyvKiZozXVvb7xrB3ohIZ
         YkctSCTnXTNfKmBXHeFkg6gDw4m9vL0inh33+5U0Ek6Six7j6C3EkjnECIYzew5U9Oz3
         mkXdEgRmVFEyYp1OoVGlKiCNgwwA6wY7GjZC50Y9blohqDLD6sBd/rUBFoXGMBaid6WF
         qvZbUZ1r/OdGkkQWZrt2uvEI2NF3iN+icEH3ebXd0X0LErvI2tmidUEuMn5hHmBI1nqo
         9oLg0g2cyRjMQOYhCgGNG0khTBG1x0OXzocQVpEhN6QeGoeU5Sh450SUX8qwOJjXOh+y
         TxgA==
X-Forwarded-Encrypted: i=1; AFNElJ9hFlTtvlcnVgz014VP6bIUbtl/wTnOSyefz2cRK7EGcpmFOXGHND+mlrkkINb6qemOrAagBjG2eug=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrXbMoUCpW1F4v0XihxSutVcLNpP338jhN0lOeT6PyOw8sMO5y
	+gCQASp9dJCXgqnuGC2Eb0apUT3Yt1mZu6xqlsD5V45LupW3ufv/l0Mg
X-Gm-Gg: AeBDiesDCc9W8dHdaw3Wh6t+tKMKFvGtqd5fDeqYZwTayPOWkVPMx79kuqo1cgI8qsD
	ZvxVtvw4Al/Ryp2ZpSTjG0SBxULi9of2uvQw8nK6zogj45SrEibzYOYdfMzJc2gXlZsUKqOPw66
	PuBS0XVlE6HmkOTVKYF7du2ISlCWFO8QPYCkh/zYkJiQhiNHclw45WX+/90VNHDE9PbdG8YF9oB
	gTn8p6hmpF0FJ90YlYWqOppZceoK2hVTp22mzKW81+G54HfTuOvwMz0Ipm5pGK+5enw1mECvhAv
	/sO8ukfCcG13cntk0wsw89/pYxFiv9OGoWEnonQqMo4rPNpIg+Y+SqL7tTat1S0hQSiCNOAmzVB
	VM5Pv90fWjTjWcTp5S/BrljBs8uc6hp3/qpKb4gCXTng8BqnvJsCWhiXb0k/5+WYdpuppFSdMtN
	7+4uuAp5OgYU59rkWWHR4SH5AXiEuQ4rWp7znzRxmtTQofPi6N3L3uaV7FuHoiP+r/j73w
X-Received: by 2002:a17:902:b702:b0:2b0:ac1e:9720 with SMTP id d9443c01a7336-2b5f9f7d029mr71309525ad.23.1776614291049;
        Sun, 19 Apr 2026 08:58:11 -0700 (PDT)
Received: from ehlo.thunderbird.net ([2401:4900:ae57:5a37:f1c4:4609:8638:c0c5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fa9ff729sm94905505ad.15.2026.04.19.08.58.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Apr 2026 08:58:10 -0700 (PDT)
Date: Sun, 19 Apr 2026 18:10:11 +0530
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
CC: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 tglx@kernel.org, christophe.jaillet@wanadoo.fr, mingo@kernel.org,
 nabijaczleweli@nabijaczleweli.xyz, kees@kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 6/7] iio: ssp_sensors: Use dev_err_probe
User-Agent: Thunderbird for Android
In-Reply-To: <ad9c7JT-ES7f2Nbi@ashevche-desk.local>
References: <20260415050749.3858046-1-sanjayembedded@gmail.com> <20260415050749.3858046-7-sanjayembedded@gmail.com> <ad9c7JT-ES7f2Nbi@ashevche-desk.local>
Message-ID: <02321180-DF23-4133-8BF4-8BC2D91A5F98@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 15 April 2026 3:09:56=E2=80=AFpm IST, Andy Shevchenko <andriy=2Eshevche=
nko@intel=2Ecom> wrote:
>On Wed, Apr 15, 2026 at 10:37:48AM +0530, Sanjay Chitroda wrote:
>
>> dev_err_probe() makes error code handling simpler and handle
>> deferred probe nicely (avoid spamming logs)=2E
>
>=2E=2E=2E
>
>>  	struct ssp_data *data;
>
>While at it, introduce a temporary variable
>
>	struct device *dev =3D &spi->dev;
>
>and reuse it below=2E Note, you may add a new patch to reuse it in the li=
nes that
>are not related to this patch but may utilise the local variable as well=
=2E
>
>Actually, you can introduce it earlier in the series, exempli gratia when=
 you
>moved probe to use managed resources=2E
>

Thank you for the input=2E
I will add a change to use dev, before devm changes in next series=2E

>>  	data =3D ssp_parse_dt(&spi->dev);
>> -	if (!data) {
>> -		dev_err(&spi->dev, "Failed to find platform data\n");
>> -		return -ENODEV;
>> -	}
>> +	if (!data)
>> +		return dev_err_probe(&spi->dev, -ENODEV,
>> +				     "Failed to find platform data\n");
>
>		return dev_err_probe(dev, -ENODEV, "Failed to find platform data\n");
>
>(And you can leave it one line as trailing string literals are fine to be
> longer 80 even in strict mode=2E You may even double check with checkpat=
ch,
> it won't complain=2E)
>
>=2E=2E=2Eand so on=2E=2E=2E
>

Yes, I'm bit obsessed with 72=2E
I am considering all new changes with possible single line since last week=
, again thank you for drawing my attention=2E
>=2E=2E=2E
>
>>  	if (data->fw_dl_state =3D=3D SSP_FW_DL_STATE_NONE) {
>>  		ret =3D ssp_initialize_mcu(data);
>> -		if (ret < 0) {
>> -			dev_err(&spi->dev, "Initialize_mcu failed\n");
>> -			return ret;
>> -		}
>> -	} else {
>> -		dev_err(&spi->dev, "Firmware version not supported\n");
>> -		return -EPERM;
>> -	}
>> +		if (ret < 0)
>> +			return dev_err_probe(&spi->dev, ret,
>> +					     "Initialize_mcu failed\n");
>> +	} else
>> +		return dev_err_probe(&spi->dev, -EPERM,
>> +				     "Firmware version not supported\n");
>
>I would now negate the conditional and drop redundant 'else'=2E Also note
>the missing {} in the 'else' branch as per Coding Style=2E
>
>	if (data->fw_dl_state !=3D SSP_FW_DL_STATE_NONE)
>		return dev_err_probe(dev, -EPERM, "Firmware version not supported\n");
>
>	ret =3D ssp_initialize_mcu(data);
>	if (ret < 0)
>		return dev_err_probe(dev, ret, "Initialize_mcu failed\n");
>

Noted, {} to match with if block style=2E

I will send changes in next series, drop redundant else and simplify the l=
ogic=2E
