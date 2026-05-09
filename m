Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D27E38238A
	for <linux-iio@vger.kernel.org>; Sat,  9 May 2026 20:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778360394; cv=none; b=jhfMwQYFqb6fa6NP8lTh5CXoLlzPEw4DvbQkzaM6bGhvvqgmvY5uO+aZkSMV2yyAm6hSMF2D8tlu4ZFmjKKwt0CzabyjPrAAUc7awtwX0Ze84iZ0kV7d6WlXQ3991gjzwCllve3sL/Q70J8vpShtno4WvUW0SSGBTPofd2l/DZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778360394; c=relaxed/simple;
	bh=ZzBP1B2qSk4hq42ZDl+LFeX6Ht/pq4pigntGLC9gO+g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=juR3HPBgRpiv+ic+iLPITpei6fku+b4AhM7VBiY3klhyIzFiX6P7L8Q2N6CKYY/qM7uWsR7FJDj+93NsbwVJOqde7m+niUwozeHcbQL0Nmtb0bdY6OelIeMyVf5vscgETxqL1caPjTT/iPBNLqBpeJgnxWBnzNp44rXVLJxOOCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=CQGAAnAL; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="CQGAAnAL"
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-409de4132b5so1937405fac.1
        for <linux-iio@vger.kernel.org>; Sat, 09 May 2026 13:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1778360390; x=1778965190; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d2B2IWzmjvVV7Fc5wPOLwL5bkbEhy/N0MPl9N12WAp0=;
        b=CQGAAnAL7ywC+Xw8r1P1j2yPEbYhIyBQiqgyjfjyueqjzxIv1s2tfb4Xkx3eukVGwy
         fcxzbJHNE9txfWhuIfK/z12rwuU5asKJX8TTzc48dZxIR7lme9jzrbW9j68qamK1+/VR
         FWoSbHeihbAUe8s3uGEJHYmBG5wxTTLHrYcVAs4W6INavfEJIn5oVhOqRJSiQacgqaQ5
         8q/23MiiO5+FWWMKMbm7mwI2NdL2MojiiZ8296ALK2oUxJoIsu0ehNV8J30V9S1TOcwf
         aGCGY16FlBBdMHHNY+hofTGOo3tYnUeTTvUXwedoVKeaeYParwfMTiTN90I8HSFDwVxl
         gUqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778360390; x=1778965190;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d2B2IWzmjvVV7Fc5wPOLwL5bkbEhy/N0MPl9N12WAp0=;
        b=DNlmQRSswGbWfxr3XEYrA3YvfN6UPxxn4JQnaf8qzEWBaqRrb9up9BF3b7jM+ESpGd
         rU7y1mYTtHBarXxpWFMxBtYI6kcrdAlYx39lSNbCOqf5UW1/DEm7vbT+ytLza/wMuvzZ
         XE/k+ygKn0ZhFxMNZnfHsmTTt5B4+V4Xxf9OL0H1bzeGcJZ1P6pIeaIRgBFO86J6do8b
         /yQWyVxSAUKVhXVM2UnZ6PkCOcJ3vvpwTPPqrGoY3cUut557rDhW1nwDeKMc0hRIjhyu
         J1qfS3/huI6CKzSHBgYPxVHHgSGiEcfX0yXWj8iNyLjtQwz4RcsL/vxsp2+bmVSN3Zai
         9x/Q==
X-Forwarded-Encrypted: i=1; AFNElJ+51kjm0OCiqLnFTRYeqDGjlAP9EgPjocsS71+C4p5i+lUzanwbEgCCDq33yhcd9deWmEOv/J+DM6Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzCKsp+jEoHZt089l0CeJlGdXDaYt205z2tahgX3ONU+gKsj7M
	tzUs9ojAqT3LIfoWefBxN363O4jOdu6BYkqd/HSd/syRDejjUwP/ddBXsEvgQDVjNp0=
X-Gm-Gg: Acq92OFuw02eGWJjm/ioSBpKwVnHfJrasz/zY6omLeHrkZXxSL9tQ8QvliP4CgKfZt/
	CaVkvh3qX+M1PsZR/y9mrpoPLtuPa9QPIiJnqrTezboacouWCp1NLn8qsh3Exp/AO8dP2hEGKjS
	tzYZIrw7ZevFU5FSMPqqS+KX7HdmGroFJ4j9Dh01IlTZ0iasj0mkPhC62SCAFvJmWsfMgxyCqo4
	Pu1UtI1PiX84m7wWGydDKS+J5BVd6t1gWCH/F3xdum9twIUFoNe3QJF8NitdAXcBG5Rs3CNCvQb
	GXHxZF3K1C8qKKBHuTtzIlAbjdRwgUilkvDH/IDnYuGQ1M5tMlbEWv1SyaXwP8LwgataVbMj3pC
	uETTiQVODIYQ+x8PIo9G0QDAuEQCkToRijqXMs9RZ77EFPeR3g3qMjZfGoxk2512TaofdlCHjnW
	WtM9JCQkZwH/EwsvsI0rmUoYx5tDEupGHDPhRBfzjDcuFFURGBF9DVvYgCftt0L+gpGudX62weu
	A==
X-Received: by 2002:a05:6870:c693:b0:42f:c146:da68 with SMTP id 586e51a60fabf-434f58b4a06mr10972755fac.16.1778360390185;
        Sat, 09 May 2026 13:59:50 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:3548:c22e:ea52:dbc7? ([2600:8803:e7e4:500:3548:c22e:ea52:dbc7])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4355736dbc0sm5428751fac.11.2026.05.09.13.59.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 May 2026 13:59:49 -0700 (PDT)
Message-ID: <bb23a9dc-4b95-4e36-9619-0c34d46a39ae@baylibre.com>
Date: Sat, 9 May 2026 15:59:48 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/5] iio: dac: ad5504: fix scale via
 output-range-microvolt
To: Taha Ed-Dafili <0rayn.dev@gmail.com>, lars@metafoo.de,
 Michael.Hennerich@analog.com, jic23@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org
Cc: nuno.sa@analog.com, andy@kernel.org, skhan@linuxfoundation.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260509142047.30302-1-0rayn.dev@gmail.com>
 <20260509142047.30302-6-0rayn.dev@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260509142047.30302-6-0rayn.dev@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/9/26 9:20 AM, Taha Ed-Dafili wrote:
> The AD5504 full-scale range is hardware-determined by the R_SEL pin,
> not the VCC supply voltage.
> 
> Fix the scaling logic by reading the standard 'output-range-microvolt'
> property from the device tree instead of querying the VCC regulator or
> relying on legacy platform data (pdata).
> 
> As a result of this transition:
> - The 'vcc' regulator is now only enabled, not read.
> - Legacy pdata support is removed, as it is no longer required for
>   fallback voltage calculations.
> - Strict array bounds checking is added for the DT property.
> 
> Signed-off-by: Taha Ed-Dafili <0rayn.dev@gmail.com>
> ---
>  drivers/iio/dac/ad5504.c | 25 +++++++++++++++----------
>  1 file changed, 15 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/iio/dac/ad5504.c b/drivers/iio/dac/ad5504.c
> index 9e95da6e49d6..040f580b8282 100644
> --- a/drivers/iio/dac/ad5504.c
> +++ b/drivers/iio/dac/ad5504.c
> @@ -14,10 +14,12 @@
>  #include <linux/kstrtox.h>
>  #include <linux/mod_devicetable.h>
>  #include <linux/module.h>
> +#include <linux/property.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/spi/spi.h>
>  #include <linux/sysfs.h>
>  #include <linux/types.h>
> +#include <linux/units.h>
>  
>  #include <linux/iio/dac/ad5504.h>
>  #include <linux/iio/events.h>
> @@ -274,9 +276,9 @@ static const struct iio_chan_spec ad5504_channels[] = {
>  static int ad5504_probe(struct spi_device *spi)
>  {
>  	struct device *dev = &spi->dev;
> -	const struct ad5504_platform_data *pdata = dev_get_platdata(dev);
>  	struct iio_dev *indio_dev;
>  	struct ad5504_state *st;
> +	u32 range[2];
>  	int ret;
>  
>  	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
> @@ -285,16 +287,19 @@ static int ad5504_probe(struct spi_device *spi)
>  
>  	st = iio_priv(indio_dev);
>  
> -	ret = devm_regulator_get_enable_read_voltage(dev, "vcc");
> -	if (ret < 0 && ret != -ENODEV)

I don't think this would ever return -ENODEV, even on ACPI. It will
just get a dummy regulator now.

> +	ret = devm_regulator_get_enable(dev, "vcc");
> +	if (ret && ret != -ENODEV)
>  		return ret;
> -	if (ret == -ENODEV) {
> -		if (pdata->vref_mv)
> -			st->vref_mv = pdata->vref_mv;
> -		else
> -			dev_warn(dev, "reference voltage unspecified\n");
> -	} else {
> -		st->vref_mv = ret / 1000;
> +
> +	st->vref_mv = 60 * MILLI;
> +	ret = device_property_read_u32_array(dev, "output-range-microvolt",
> +					     range, ARRAY_SIZE(range));
> +	if (!ret) {
> +		if (range[0] != 0 || (range[1] != 30 * MICRO && range[1] != 60 * MICRO))
> +			return -EINVAL;
> +
> +		if (range[1] == 30 * MICRO)
> +			st->vref_mv = 30 * MILLI;
>  	}
>  
>  	st->spi = spi;

