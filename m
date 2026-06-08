Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0BDC3955C6
	for <linux-iio@vger.kernel.org>; Mon,  8 Jun 2026 20:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780950717; cv=none; b=jQiW6YJ1XQcJrQIz8hsLOTTMc1QawQUs0BdY55VpYjLhlAbsDwOmsmWyOLWDeJbi7RSZx11swIptI15bVYbfvXtCmzs5HgBxBYEEugX8q2F5156wcZ98zzk+PLnfOYyeq1x19dGyPHqivWzdog2+XVHfXKZbJTBqZrqZe8BbSTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780950717; c=relaxed/simple;
	bh=/R+qFNq2MRWIRpASjDvEa9edwehTODKYWPwF4Ig6JSA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NoJPH+zd+LjneZYHKApSs2d7+BBky9Fyo1khEp8EawkZeOn9fvBjJtPANbJlH34e/8M82TA/BLUjgGd2ndSsxAhHg0nLjyO040ibtUhffgIWB3zPk8n1Euu7CWp7LOYPB1Gj8OP5xwaF/TJ6tW9yTzYg0J/dg30IfwDmBnh69OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IdXurBZu; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IdXurBZu"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-490b1bbcf3aso39430445e9.1
        for <linux-iio@vger.kernel.org>; Mon, 08 Jun 2026 13:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780950713; x=1781555513; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=J7aA46O1Kidp9EIBCKXaMzxYNS525jaJND8WlxgPNm4=;
        b=IdXurBZuK2RfTtY1M8I6fmwT6fbiUpxs1/8okyjjucPbI4CSf82ha4Nu0GyWGGCOEy
         VGb1y+YVqoqCp5b4CnT10gtQ/3DcZTgvibP+URzjmpzvfL7x1ZNLSVZErzPQlGtaqZCb
         pKPemInwLjxz/8Wf6ukhj198sAvdZjwnGeNrpsl0Rsj7R39hflukI5QPqqsy+nle5u+F
         JF1Ksy1dAOFsoQPCHI9Y0YOnAHFniMYq+nb8x+NlPH5qIOfpdPwnLy6h0M/g0uzcXpz2
         tJh50CG5kS8/xI5jPf9X5hW496v+GvFklo4XB9bN+7BrmoOlirmRoxUNse+knCuJB//n
         ECbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780950713; x=1781555513;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J7aA46O1Kidp9EIBCKXaMzxYNS525jaJND8WlxgPNm4=;
        b=CWbL1R5RTwxb8ct4QjzeZyv8fooI2juZz/bs4dvAEaj9aGeDBJdfcVD4EG9l6r006h
         HrBL/ii7QeMDzCFCN6BS0yVbM4bkaQKWwOZGmlnFqpA2d0sEL+EukZLGU5ReQbz3dj07
         eg0E/sg0rUyC5DntfFjd9Bj31HbyCXQM4B/69nUlu28SqjDGhlcRjD+9GoWw5dF1EyvG
         lA9aY087JRMEJFPlDsjtB7wO0SEcI1KAnfuZLsZ1fLrTbLMc4v6Sayj+X1ssf7cFwDmg
         4FBS/mgoxxySgsodnMqc9CWaivy7yJa+qoNr/tjzNdtV3dS2XfiTrtzDtTeLdON+B4r6
         lzAA==
X-Forwarded-Encrypted: i=1; AFNElJ8W8TAM6fW78Idju7DPFNi2swo0tTBACCNcS5lyd4yzAZO96ga8JGE6rvo4BTUW0XFGQR4d0auuW0g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9YoIBTLElK+kx8+GgmbwgcOWzIECK2U1eDm2Jz8kvX5T310p6
	I/tsvoGYN/3iuNxE+kOts1FMK8R/fMcrOi5GDw0tm2nV30TtCmmnlYmU
X-Gm-Gg: Acq92OHSFWUSqngQlNLcGa5Luo3UNCwklwFrwDb7ukRnExQuKVq29oHYHEdizZkbEs3
	CmififRrbf73uRnuXaqHLvfNP2j4QwAHeCF2Z/DbaJF3DS5fgPufeXQTFnb5L8oACPvlI22XpTz
	Ou6DomUTcrndh2ax5Kkwp+Y69NGI8r9yJibok/bkCEPHoif6aDiHtLT1SQTllVE5PwBBNZkvlB/
	SJ9pIa7ykZ8F+va6zJt2FdXuJoqDvxWHozQVYE6+jdeMU+oHmdq/bp3wwHO6V9ilBb6EZXtk5vz
	xiv61FP6Jip/ZOjJEBZ342a5earFXBA1U9BsXWVSjfrOfQWRQ9+UyirNew3pB69Zz/TyfaS5iLj
	jTyOyK2DrLo1I66hMGjhmu3LG7GqcSsHg11y/vKuiVTP2/EPBT4iJDz/2qoZmjyG8dhHLIdaUJP
	4Zip3E15XnfaXNnqkCVtjbctiWdfNCoCr7MtAjJ01mOTcbFcEPwOLROOynicASoGNTiyQ5f2F8c
	zxBRq0ooLQQtxKvKLRFtSU=
X-Received: by 2002:a05:600c:4e43:b0:490:b9c3:6c69 with SMTP id 5b1f17b1804b1-490c2622cf7mr276459415e9.30.1780950713229;
        Mon, 08 Jun 2026 13:31:53 -0700 (PDT)
Received: from ?IPv6:2001:818:ea56:d000:56e0:ceba:7da4:6673? ([2001:818:ea56:d000:56e0:ceba:7da4:6673])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc413541sm452900015e9.14.2026.06.08.13.31.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 13:31:52 -0700 (PDT)
Message-ID: <93063cd749aa8bc5f650bfa4188abb8c4cb8aec9.camel@gmail.com>
Subject: Re: [PATCH v16 08/14] iio: core: add decimal value formatting into
 64-bit value
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: rodrigo.alencar@analog.com, linux-kernel@vger.kernel.org, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-doc@vger.kernel.org, 	linux@analog.com
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>,  Andy Shevchenko	 <andy@kernel.org>, Lars-Peter
 Clausen <lars@metafoo.de>, Michael Hennerich	
 <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>,  Andrew Morton
 <akpm@linux-foundation.org>, Petr Mladek <pmladek@suse.com>, Steven Rostedt
 <rostedt@goodmis.org>,  Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Rasmus Villemoes
 <linux@rasmusvillemoes.dk>, Sergey Senozhatsky <senozhatsky@chromium.org>,
 Shuah Khan <skhan@linuxfoundation.org>
Date: Mon, 08 Jun 2026 21:32:58 +0100
In-Reply-To: <20260604-adf41513-iio-driver-v16-8-1a7d09143bc2@analog.com>
References: <20260604-adf41513-iio-driver-v16-0-1a7d09143bc2@analog.com>
	 <20260604-adf41513-iio-driver-v16-8-1a7d09143bc2@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-06-04 at 10:59 +0100, Rodrigo Alencar via B4 Relay wrote:
> From: Rodrigo Alencar <rodrigo.alencar@analog.com>
>=20
> Create new format types for iio values (IIO_VAL_DECIMAL64_*), which
> defines the representation of fixed decimal point values into a single
> 64-bit number. This new format increases the range of represented values,
> allowing for integer parts greater than 2^32, as bits are not "wasted"
> in the fractional part, which can be seen in IIO_VAL_INT_PLUS_MICRO and
> IIO_VAL_INT_PLUS_NANO. Helpers are created to compose and decompose 64-bi=
t
> decimals into integer values used in IIO formatting interfaces, which
> creates consistency and avoid error-prone manual assignments when using
> wordpart macros. When doing the parsing, kstrtodec64() is used with the
> scale defined by the specific decimal format type.
>=20
> Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
> ---

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

> =C2=A0drivers/iio/industrialio-core.c | 49 ++++++++++++++++++++++++++++++=
++---------
> =C2=A0include/linux/iio/types.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 20 =
+++++++++++++++++
> =C2=A02 files changed, 59 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-c=
ore.c
> index ffe0dc49c4b9..93c2540d4cd2 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -19,6 +19,7 @@
> =C2=A0#include <linux/idr.h>
> =C2=A0#include <linux/kdev_t.h>
> =C2=A0#include <linux/kernel.h>
> +#include <linux/math64.h>
> =C2=A0#include <linux/module.h>
> =C2=A0#include <linux/mutex.h>
> =C2=A0#include <linux/poll.h>
> @@ -26,7 +27,6 @@
> =C2=A0#include <linux/sched.h>
> =C2=A0#include <linux/slab.h>
> =C2=A0#include <linux/wait.h>
> -#include <linux/wordpart.h>
> =C2=A0
> =C2=A0#include <linux/iio/buffer.h>
> =C2=A0#include <linux/iio/buffer_impl.h>
> @@ -656,6 +656,7 @@ static ssize_t __iio_format_value(char *buf, size_t o=
ffset,
> unsigned int type,
> =C2=A0				=C2=A0 int size, const int *vals)
> =C2=A0{
> =C2=A0	int tmp0, tmp1;
> +	int l =3D 0;
> =C2=A0	s64 tmp2;
> =C2=A0	bool scale_db =3D false;
> =C2=A0
> @@ -699,7 +700,6 @@ static ssize_t __iio_format_value(char *buf, size_t o=
ffset,
> unsigned int type,
> =C2=A0	case IIO_VAL_INT_MULTIPLE:
> =C2=A0	{
> =C2=A0		int i;
> -		int l =3D 0;
> =C2=A0
> =C2=A0		for (i =3D 0; i < size; ++i)
> =C2=A0			l +=3D sysfs_emit_at(buf, offset + l, "%d ", vals[i]);
> @@ -708,8 +708,25 @@ static ssize_t __iio_format_value(char *buf, size_t =
offset,
> unsigned int type,
> =C2=A0	case IIO_VAL_CHAR:
> =C2=A0		return sysfs_emit_at(buf, offset, "%c", (char)vals[0]);
> =C2=A0	case IIO_VAL_INT_64:
> -		tmp2 =3D (s64)((((u64)vals[1]) << 32) | (u32)vals[0]);
> -		return sysfs_emit_at(buf, offset, "%lld", tmp2);
> +		return sysfs_emit_at(buf, offset, "%lld",
> +				=C2=A0=C2=A0=C2=A0=C2=A0 iio_val_s64_compose(vals[0], vals[1]));
> +	case IIO_VAL_DECIMAL64_MILLI:
> +	case IIO_VAL_DECIMAL64_MICRO:
> +	case IIO_VAL_DECIMAL64_NANO:
> +	case IIO_VAL_DECIMAL64_PICO:
> +	{
> +		int scale =3D type - IIO_VAL_DECIMAL64_BASE;
> +		s64 frac;
> +
> +		tmp2 =3D div64_s64_rem(iio_val_s64_compose(vals[0], vals[1]),
> +				=C2=A0=C2=A0=C2=A0=C2=A0 int_pow(10, scale), &frac);
> +		if (tmp2 =3D=3D 0 && frac < 0)
> +			l +=3D sysfs_emit_at(buf, offset, "-");
> +
> +		l +=3D sysfs_emit_at(buf, offset + l, "%lld.%0*lld", tmp2, scale,
> +				=C2=A0=C2=A0 abs(frac));
> +		return l;
> +	}
> =C2=A0	default:
> =C2=A0		return 0;
> =C2=A0	}
> @@ -979,6 +996,7 @@ static ssize_t iio_write_channel_info(struct device *=
dev,
> =C2=A0	struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);
> =C2=A0	struct iio_dev_attr *this_attr =3D to_iio_dev_attr(attr);
> =C2=A0	int ret, fract_mult =3D 100000;
> +	int type, dec_scale =3D 0;
> =C2=A0	int integer, fract =3D 0;
> =C2=A0	long long integer64;
> =C2=A0	bool is_char =3D false;
> @@ -989,9 +1007,11 @@ static ssize_t iio_write_channel_info(struct device=
 *dev,
> =C2=A0	if (!indio_dev->info->write_raw)
> =C2=A0		return -EINVAL;
> =C2=A0
> -	if (indio_dev->info->write_raw_get_fmt)
> -		switch (indio_dev->info->write_raw_get_fmt(indio_dev,
> -			this_attr->c, this_attr->address)) {
> +	if (indio_dev->info->write_raw_get_fmt) {
> +		type =3D indio_dev->info->write_raw_get_fmt(indio_dev,
> +							=C2=A0 this_attr->c,
> +							=C2=A0 this_attr->address);
> +		switch (type) {
> =C2=A0		case IIO_VAL_INT:
> =C2=A0			fract_mult =3D 0;
> =C2=A0			break;
> @@ -1007,12 +1027,19 @@ static ssize_t iio_write_channel_info(struct devi=
ce *dev,
> =C2=A0		case IIO_VAL_CHAR:
> =C2=A0			is_char =3D true;
> =C2=A0			break;
> +		case IIO_VAL_DECIMAL64_MILLI:
> +		case IIO_VAL_DECIMAL64_MICRO:
> +		case IIO_VAL_DECIMAL64_NANO:
> +		case IIO_VAL_DECIMAL64_PICO:
> +			dec_scale =3D type - IIO_VAL_DECIMAL64_BASE;
> +			fallthrough;
> =C2=A0		case IIO_VAL_INT_64:
> =C2=A0			is_64bit =3D true;
> =C2=A0			break;
> =C2=A0		default:
> =C2=A0			return -EINVAL;
> =C2=A0		}
> +	}
> =C2=A0
> =C2=A0	if (is_char) {
> =C2=A0		char ch;
> @@ -1021,12 +1048,14 @@ static ssize_t iio_write_channel_info(struct devi=
ce *dev,
> =C2=A0			return -EINVAL;
> =C2=A0		integer =3D ch;
> =C2=A0	} else if (is_64bit) {
> -		ret =3D kstrtoll(buf, 0, &integer64);
> +		if (dec_scale)
> +			ret =3D kstrtodec64(buf, dec_scale, &integer64);
> +		else
> +			ret =3D kstrtoll(buf, 0, &integer64);
> =C2=A0		if (ret)
> =C2=A0			return ret;
> =C2=A0
> -		fract =3D upper_32_bits(integer64);
> -		integer =3D lower_32_bits(integer64);
> +		iio_val_s64_decompose(integer64, &integer, &fract);
> =C2=A0	} else {
> =C2=A0		ret =3D __iio_str_to_fixpoint(buf, fract_mult, &integer, &fract,
> =C2=A0					=C2=A0=C2=A0=C2=A0 scale_db);
> diff --git a/include/linux/iio/types.h b/include/linux/iio/types.h
> index 4e3099defc1d..924ac9dc6893 100644
> --- a/include/linux/iio/types.h
> +++ b/include/linux/iio/types.h
> @@ -7,6 +7,9 @@
> =C2=A0#ifndef _IIO_TYPES_H_
> =C2=A0#define _IIO_TYPES_H_
> =C2=A0
> +#include <linux/types.h>
> +#include <linux/wordpart.h>
> +
> =C2=A0#include <uapi/linux/iio/types.h>
> =C2=A0
> =C2=A0enum iio_event_info {
> @@ -34,6 +37,23 @@ enum iio_event_info {
> =C2=A0#define IIO_VAL_FRACTIONAL_LOG2 11
> =C2=A0#define IIO_VAL_CHAR 12
> =C2=A0
> +#define IIO_VAL_DECIMAL64_BASE		32
> +#define IIO_VAL_DECIMAL64_MILLI		(IIO_VAL_DECIMAL64_BASE + 3)
> +#define IIO_VAL_DECIMAL64_MICRO		(IIO_VAL_DECIMAL64_BASE + 6)
> +#define IIO_VAL_DECIMAL64_NANO		(IIO_VAL_DECIMAL64_BASE + 9)
> +#define IIO_VAL_DECIMAL64_PICO		(IIO_VAL_DECIMAL64_BASE + 12)
> +
> +static inline s64 iio_val_s64_compose(s32 val0, s32 val1)
> +{
> +	return (s64)(((u64)val1 << 32) | (u32)val0);
> +}
> +
> +static inline void iio_val_s64_decompose(s64 dec64, s32 *val0, s32 *val1=
)
> +{
> +	*val0 =3D lower_32_bits(dec64);
> +	*val1 =3D upper_32_bits(dec64);
> +}
> +
> =C2=A0enum iio_available_type {
> =C2=A0	IIO_AVAIL_LIST,
> =C2=A0	IIO_AVAIL_RANGE,
