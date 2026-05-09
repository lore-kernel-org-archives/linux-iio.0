Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC482EFDA6
	for <linux-iio@vger.kernel.org>; Sat,  9 May 2026 08:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778316432; cv=none; b=hNQlJnhMr0wHZDcEx3tJSoD7lcJ8ab79Phk59seF6at6VYUD1YPH1Wrg1iveG+39Iss7nw2+LOielTAtakEo7zU9aeABpJFsGsv+OPrB3NRmOPy42+VhvUO6Au78IsAxtif3t3OY0ta2jhR4jDowKnPOFDQ4De53UBLLQ/NRZas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778316432; c=relaxed/simple;
	bh=Bb6nEvpfuChNfFhHZiQFC5VNcBl847Ox5pEzjL0qzi4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cWtTyA4ncmudzzuYNRdXddthtZprUHdaasJwuZ2LNZPr+uGAYmDojLnb5mrcMJefzkQ4TfLKacEkQvkmXzsImEM0JAkeJuWwzEErgZ9mNaFIlLGzX1nLWJ4bUehrHuJUtZsV4iTY6O0lkVYupCIj4H4/I9sPQpjcXfno659i1Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=URQ2OT7f; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="URQ2OT7f"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-43d73352cf2so2198727f8f.1
        for <linux-iio@vger.kernel.org>; Sat, 09 May 2026 01:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778316430; x=1778921230; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=byj5vDNEuv7r2Run+bsy79RaofCz2aLJtEV5ew8aPPs=;
        b=URQ2OT7fGWbZYCHr0cn2A5fOJqVws4FjZ8hKV0wq0A1lG2ytFrDrqUt6jVhQxuPEbr
         3JnqSo22AcDxiQqc7za8PltDMnWJg2eZq2TlIQdQIj0OoukUHelab6a7kdogP+oK6xE9
         k+mAKlZbaHtijX0+lNaVxLblsLGE6BFbIkN0qmJMDqW82+MHayQgQEE1s9gLCeAuFIbC
         ZOFHi0HPkPjMTLADxj4I+Lv1YXGAcrucHmY3dRfPeePwL9D6G21kUdLFXqxvLXTH3QsK
         kPKlMm7devAT60bvoT5VJoR6yKKJNSiHGjcD7xKyoeUefNDnpJD15y4ftP/Td1gAiFOs
         RQ8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778316430; x=1778921230;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=byj5vDNEuv7r2Run+bsy79RaofCz2aLJtEV5ew8aPPs=;
        b=cl1ZeX5/mwuCAxualPtU8cl8EkH0gwG0QkmfbVrPd3uZudUgUKuTKg58BNFaOP3jkr
         M0gPAlZFLkPSzmHqe84Xc16K+tSQajK4mW9v+68oRJXb6wucW9sW74jc3w3FkW5fP8bS
         STWCArfome81LLqFvRcgwz1th0fC62wYsnN5G8DJksYy0mkR4APwFQ9SvhtL9BCHqVlV
         G/hRguK6LRtoZ1Vy+XUuBQJAjghCCRP7ntYHqEVfuF3igWlXzLPKgUNYaGwmtyVm034R
         fNYgLdBFAPU7hYOvIbpraCE/TfG5Y5Yhtd5BzA1oFGOcCasNmxEMnUgG64AzLERoiP+n
         ImkA==
X-Gm-Message-State: AOJu0Yy6aMHmLqOPyLPbChyViemoTXYDIspT7UlLfAUH0zyFlbGIB6ae
	eCQOtpHCcyq/Qc1yi67doBaTPcVBQHWyy/xwTQ1zg7F1r6skQ6QjACqN
X-Gm-Gg: Acq92OEoD6AOjmNItsiRRIS2zzfzNxvPjJocEdT3zAByKODaUJdbp2jOMheceedsbLl
	u8HeB9OPj6FvCEBZYvgXWZqwaQUGFsguDwo/Qs7/FgBQxE17WgEOwKhp0I23ZUbvZNMOEz7c425
	M+Q4wMLw+aYOu1Q60/OiwLZR9KZSHBFY3BqO05XksJUwsVhEwD64AAfMWbvQ2MdrLBHnEVYHJG9
	wMOcpLvI+josUUETd3x8EK4yQhiL2zTPaoYHGT/HLDyHTMABoxRDkH5ubbZycxa7jwM68bP6dUP
	XrcFQxollGV8G5YHDVvCJnr8wl+L5OGIzfFdBueOPLVsNHSh/JnWH9BuG9vdIgKigzm1uQa2/1C
	Gd0IpQY1Q3rbDlD9z1mvg5SUO1OKVady5QF/nvZcJMOLZf/gN079pgPCtZ3PuYhgF9d3NXgHSWQ
	Pd8ZrTD3PqrGCgpFwtXGRECBRSk3kJVyZHT4q5wHaxaAJwsss/mt36Zm2+9oEsIRc1p3bxmQd5D
	w==
X-Received: by 2002:a05:6000:2c10:b0:441:247a:e98e with SMTP id ffacd0b85a97d-456a3e31fabmr2567765f8f.24.1778316429573;
        Sat, 09 May 2026 01:47:09 -0700 (PDT)
Received: from ?IPv6:2001:818:ea56:d000:56e0:ceba:7da4:6673? ([2001:818:ea56:d000:56e0:ceba:7da4:6673])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4549120f1f9sm9950091f8f.24.2026.05.09.01.47.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 01:47:09 -0700 (PDT)
Message-ID: <4c51fab97ee7885fc9e26f7fe31c3db307580a6c.camel@gmail.com>
Subject: Re: [PATCH 1/8] iio: magnetometer: ak8975: modernize polling loops
 with iopoll() macros
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: joshua.crofts1@gmail.com, Jonathan Cameron <jic23@kernel.org>, David
 Lechner <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?=
 <nuno.sa@analog.com>, Andy Shevchenko	 <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Andy Shevchenko
	 <andriy.shevchenko@linux.intel.com>
Date: Sat, 09 May 2026 09:48:10 +0100
In-Reply-To: <20260507-magnetometer-fixes-post-pickup-v1-1-37827ca68fb3@gmail.com>
References: 
	<20260507-magnetometer-fixes-post-pickup-v1-0-37827ca68fb3@gmail.com>
	 <20260507-magnetometer-fixes-post-pickup-v1-1-37827ca68fb3@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-05-07 at 16:35 +0200, Joshua Crofts via B4 Relay wrote:
> From: Joshua Crofts <joshua.crofts1@gmail.com>
>=20
> The driver currently uses while loops and msleep() for polling during
> conversion waits.
>=20
> Replace the custom polling loops with readx_poll_timeout() and
> read_poll_timeout() macros from <linux/iopoll.h>. This reduces
> boilerplate, standardizes timeout handling and improves overall code
> readability, keeping the original timing and error behaviour. Add
> <linux/time.h> for USEC_PER_MSEC macro instead of using magic numbers.
>=20
> Assisted-by: Gemini:3.1-Pro
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
> ---

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

> =C2=A0drivers/iio/magnetometer/ak8975.c | 43 ++++++++++++++++------------=
-----------
> =C2=A01 file changed, 18 insertions(+), 25 deletions(-)
>=20
> diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer=
/ak8975.c
> index
> 6be72e1cc0a8321e767da5e65d54c0fe88712304..b990c123e2808c2078abcfaf6b2ef86=
c09393e6b
> 100644
> --- a/drivers/iio/magnetometer/ak8975.c
> +++ b/drivers/iio/magnetometer/ak8975.c
> @@ -24,6 +24,7 @@
> =C2=A0#include <linux/pm_runtime.h>
> =C2=A0#include <linux/property.h>
> =C2=A0#include <linux/regulator/consumer.h>
> +#include <linux/time.h>
> =C2=A0#include <linux/types.h>
> =C2=A0#include <linux/wait.h>
> =C2=A0
> @@ -649,16 +650,14 @@ static int wait_conversion_complete_gpio(struct ak8=
975_data
> *data,
> =C2=A0{
> =C2=A0	struct i2c_client *client =3D data->client;
> =C2=A0	int ret;
> +	int val;
> =C2=A0
> =C2=A0	/* Wait for the conversion to complete. */
> -	while (timeout_ms) {
> -		msleep(poll_ms);
> -		if (gpiod_get_value(data->eoc_gpiod))
> -			break;
> -		timeout_ms -=3D poll_ms;
> -	}
> -	if (!timeout_ms)
> -		return -ETIMEDOUT;
> +	ret =3D readx_poll_timeout(gpiod_get_value, data->eoc_gpiod, val, val !=
=3D 0,
> +				 poll_ms * USEC_PER_MSEC,
> +				 timeout_ms * USEC_PER_MSEC);
> +	if (ret)
> +		return ret;
> =C2=A0
> =C2=A0	ret =3D i2c_smbus_read_byte_data(client, data->def->ctrl_regs[ST1]=
);
> =C2=A0	if (ret < 0)
> @@ -672,27 +671,21 @@ static int wait_conversion_complete_polled(struct a=
k8975_data
> *data,
> =C2=A0					=C2=A0=C2=A0 unsigned int timeout_ms)
> =C2=A0{
> =C2=A0	struct i2c_client *client =3D data->client;
> -	u8 read_status;
> =C2=A0	int ret;
> +	int val;
> =C2=A0
> =C2=A0	/* Wait for the conversion to complete. */
> -	while (timeout_ms) {
> -		msleep(poll_ms);
> -		ret =3D i2c_smbus_read_byte_data(client,
> -					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 data->def->ctrl_regs[ST1]);
> -		if (ret < 0) {
> -			dev_err(&client->dev, "Error in reading ST1\n");
> -			return ret;
> -		}
> -		read_status =3D ret;
> -		if (read_status)
> -			break;
> -		timeout_ms -=3D poll_ms;
> -	}
> -	if (!timeout_ms)
> -		return -ETIMEDOUT;
> +	ret =3D read_poll_timeout(i2c_smbus_read_byte_data, val, val !=3D 0,
> +				poll_ms * USEC_PER_MSEC,
> +				timeout_ms * USEC_PER_MSEC,
> +				true,
> +				client, data->def->ctrl_regs[ST1]);
> +	if (ret)
> +		return ret;
> +	if (val < 0)
> +		dev_err(&client->dev, "Error in reading ST1\n");
> =C2=A0
> -	return read_status;
> +	return val;
> =C2=A0}
> =C2=A0
> =C2=A0/* Returns 0 if the end of conversion interrupt occurred or -ETIMED=
OUT otherwise
> */
