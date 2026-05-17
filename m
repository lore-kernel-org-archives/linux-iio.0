Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB1E35B650
	for <linux-iio@vger.kernel.org>; Sun, 17 May 2026 11:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779017959; cv=pass; b=GIAH2j/X4faEQTMt1UFEQ9bSwfa8oDUErk/mGHg+RJwoOHlu+BmhOpOr6h/KuxDVI7Sl3ZNgbbMTAlBm8lEFEM4njFR3U5+xbVAWrgg17XW8NkUjQN8BvvqjGEYK9Z7OFgR7uA39zXWGpkEELoBzwWmeonGMnVA+kF6rG9+wCi8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779017959; c=relaxed/simple;
	bh=07BG2HCqLs24wN0p8rBiWh3sYfZF1TO/IvFxuWh5zgA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h137hmR9ck4evLAjiU6xSK9XYd+HoYJc+NhnuvGkSQctIUbvXSv3V9GXlagZtsxA3Pi2vssWNaK1WZowa6bkbxoM48+4ecFvzzttYDv0shRoZD4QO5ZL/zqa3sSI47i7u3j3x+DapNSpMcCk0TjWws3yorKEbBADnP1cOnMOhvY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YV475T8u; arc=pass smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YV475T8u"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-44e1860558fso617419f8f.0
        for <linux-iio@vger.kernel.org>; Sun, 17 May 2026 04:39:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779017956; cv=none;
        d=google.com; s=arc-20240605;
        b=MKR8covz3feSGQ6pXKf+Vz89D5135+/CS6LGzRosp3TF5dv/auGnPXXcTu6LiHdRSL
         ZoLCHhXv/oFkwXkaUw5TEGvMHhgqg8lJfH6UARSSro2yzy4fc75XPNnM4tr+XtXpPbak
         MCgABeJCq84qj9mqbHn4jCGWbJZce+wFPSQC5m3b1ZiD6M8ZSE6iVLjZLrZqAw7/ONra
         fRBGUX5vI6wKPZdkJNObodic3B5btr31e3i5W13fZTN+rFM7Hgtxi9KuMtaP/mxBypld
         Qpv8++vY+zSD88BKhwKKkrD7bCvzyYrS9fqoqhfvaciFIUQTlinlNE16xBhmA0eN3Dho
         Vbag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=h13AhDdJlu2pMhIlj69wYMw3L6813Wz3IcR1YzvG8Qw=;
        fh=5Akm+43bClY3HJmAMvQ+JhJxPTiFqL5mkpt5YlSdLLU=;
        b=iFeWaLdAQfZQTEuIpH1W0W1Ozp0A7UX3QQ81Ajfl222PrzI/b0g7/pKw+8C47/Qxau
         w9/6zoL3dBEd4zIFNMHLqTwgSrXlZp7thTA298Czyo3awBOqLPw+82NFbiyE4lv4Tjm6
         52n7wI4Svqfx7i4KJMMViPuTfbzd6AEtFbCgnu+T63jw+j/FdYKYMcyXNmwJxX9dUdzE
         LJtNcNI8Qiy/1PLW/FobaxRh8AKFTOyjV3UlkdL6hWoVuReXQ71pYb8VhbSpqHEfuNXG
         f0SqgBVREmWGQ+yE0Ar3sYQ5374X2oW4uLBZC9SJ9HXMTurx62HufiBl3fW4QBHqDo5C
         jayw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779017956; x=1779622756; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=h13AhDdJlu2pMhIlj69wYMw3L6813Wz3IcR1YzvG8Qw=;
        b=YV475T8u6lYwgbs225o8v/5YU/OjFI+FCT3NxfDN5YZDA5MemHxF6BDt+/1xQyyNoV
         Am4A9TzG/gZG/tnIqrwPfjLGbIFnRVCZHifd7YdQYTcx1Dk/J6RnxSv9EwGpFrE+PfOe
         NYVq6JBDEewCzm6xFn4tOFtJA05c2hhfTb4p2/kpAXT6bkl3xh49RlOaQcvo40pKa4B6
         yAzmvfm/w+ilTefr+doCJF/0v8G7o+Cp81G3I+jpm/vcj/xlEs9QOV8OJGpraR0K87WU
         B9yrZ0aASOQhEwQPuGF/qHUURo/58QMSXrg0KwgFdD0Hum9/4dWeD0rnsyIeufhKz2Dy
         gwoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779017956; x=1779622756;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h13AhDdJlu2pMhIlj69wYMw3L6813Wz3IcR1YzvG8Qw=;
        b=DpZBaQfmt/t0Zkb2x4x65hKNB++H+nfMfWOWlOule19RTZKn23ODJyKvxTFKbylou0
         ykvCyg7gCh9sqKKtfxHhJ+RL2w7y+yIO/DPKq3gMJrZCSG9a0ldhG1bH83Hp/13O1b5N
         yS+68eJDZHLy6R9Sa/AHln0j2CahgBdFDNwC7PiB+HSSNboaBENfz5kOlt1QHiONEKW6
         VEgCvzX9ZeBji5fUo0RzaAOUp6tw1fah4N1Wx25+xTOYWd+dE436Hm1yqmfG6sUoJ+31
         XI+ZRMBBc+NGGwEC1qnLpu1XV3nSfCcVe0iJUV0LVIPaarGl9dkjpe2KgNOSYyPOlBxp
         fjtg==
X-Forwarded-Encrypted: i=1; AFNElJ/wcK8syDryzyWsLYNmPuqOTFvRvSXl9gXHpN/D+trDaHPJ+Gll9ESucWBkdkKLjiq5W/1gvR5Cp7M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMbWiwf6ELos6UzULjRactK8yfgYvXPhR1p1xVfRtUBb+Js3Vr
	jJE2c/kZDbNYohoBDT9o2tBK+GAxA2zWDAivuwCnrYyTGQ6+pH4ky6/XGLQJti/CHs5z+8DxyGi
	2310Wmivhbuj4YWr+lWfsmUc0bJZcWhzj2tNG
X-Gm-Gg: Acq92OF5CjjeOH4qCDCSk2IpWU7nU9Rs5AQwLyeoCVfbvb0ANMndl1qKgWe60IkI4of
	JP/tHhOGq+KwfZ1GI46QR9yRUsBz3UPIqtExHl2Rk30S2/Q4p0UnqPpU3HHX5Od7PYyK5lzNbV6
	TkFO3r3N30wRedFFnELeEVVtMORRKMtM6Rv2HTYSQhQPV5E8tQitOAtWjkEvXiUApDoYlXT/+CD
	0MpH4mwSX+J7y2+M6R9HwpsSeEFXNWdMkLs1+f6j2otyv6oqHDzrRGGFlmAyvak3WjXqcO2pMEq
	jhPoZyh/GkOH2qTNw/xGM/ntTFqYMK8Kk6k7geZPTCkgO9qj6zrrkEksc4C4i9kdFyueOUGIQmh
	TBlU5i4PuEIt5E6gAC5egoeHsOwfYVDb/ebRshEPv0iuPJtwnXoHEgu19YT3gkZYaywZ3gyWdiI
	thJ1sd5ho=
X-Received: by 2002:a5d:644e:0:b0:45e:739c:f187 with SMTP id
 ffacd0b85a97d-45e739cf872mr2376508f8f.22.1779017956020; Sun, 17 May 2026
 04:39:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260516-veml3328-v1-0-1d4b663e2fe3@gmail.com>
 <20260516-veml3328-v1-2-1d4b663e2fe3@gmail.com> <aglz4Z-10mzQBzvL@ashevche-desk.local>
In-Reply-To: <aglz4Z-10mzQBzvL@ashevche-desk.local>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Sun, 17 May 2026 13:39:03 +0200
X-Gm-Features: AVHnY4JJZYzoP3GtCnJcND-dB3yimuGo4vPxyJMnvdKPnn1M7vXd2xhOhoVm3pw
Message-ID: <CALoEA-y_us2D3_=AkLNQ+OEROjRt6+OQKi-xm6AWus_pjtHLMw@mail.gmail.com>
Subject: Re: [PATCH 2/2] iio: light: veml3328: add support for new device
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 17 May 2026 at 09:53, Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Sat, May 16, 2026 at 11:50:54PM +0200, Joshua Crofts wrote:
> > Add support for the Vishay VEML3328 RGB/IR light sensor communicating
> > via I2C (SMBus compatible).
> >
> > Also add a new entry for said driver into Kconfig and Makefile.
>
> ...
>
> IWYU.
>
> + array_size.h

Ah, missed that one.

> > +#include <linux/bitfield.h>
> > +#include <linux/bits.h>
> > +#include <linux/cleanup.h>
> > +#include <linux/delay.h>
> > +#include <linux/err.h>
> > +#include <linux/i2c.h>
> > +#include <linux/module.h>
> > +#include <linux/mutex.h>
> > +#include <linux/pm_runtime.h>
> > +#include <linux/regmap.h>
> > +#include <linux/regulator/consumer.h>
>
> Most likely + types.h.
>
> ...
>
> > +struct veml3328_data {
> > +     struct regmap *regmap;
> > +     struct device *dev;
>
> Dup? We may derive one from the other (in case if regmap is registered with
> the same dev, otherwise needs a good comment explaining why not).
>
> > +     struct mutex lock;
> > +};

Okay, regmap is registered with the same device.

> ...
>
> > +/* integration times in microseconds */
> > +static const int veml3328_it_times[][2] = {
> > +     { 0, 50000 },
> > +     { 0, 100000 },
> > +     { 0, 200000 },
> > +     { 0, 400000 },
>
> USEC_PER_MSEC in all of them.

Good catch.

> > +};
>
> ...
>
> > +     return regmap_update_bits(data->regmap, VEML3328_REG_CONF,
> > +                               VEML3328_SHUTDOWN, VEML3328_SHUTDOWN);
>
> Here and everywhere else, use regmap_set_bits()/regmap_clear_bits() when
> appropriate.

No problem.

> ...
>
> > +static int veml3328_power_up(struct veml3328_data *data)
> > +{
> > +     int ret;
> > +
> > +     ret = regmap_update_bits(data->regmap, VEML3328_REG_CONF,
> > +                              VEML3328_SHUTDOWN, 0);
> > +     if (ret < 0)
> > +             return ret;
>
> > +     fsleep(veml3328_it_times[3][1]);
>
> This is not good. Why do we have a table from which we are using only one
> value? Define it properly and use here.

My bad, will use a macro instead.

> > +     return 0;
> > +}
>
> ...
>
> > +             ret = regmap_read(regmap, chan->address, &reg_val);
> > +             if (ret < 0)
>
> Do all these ' < 0' for regmap API make any sense?

I guess not, will change these to use (ret)
>
> > +                     goto exit;
>
> ...
>
> > +     ret = pm_runtime_resume_and_get(data->dev);
> > +     if (ret < 0)
> > +             return ret;
>
> There are respective PM_RUNTIME_*() macros.
>
> ...
>
> > +     if ((reg_val & 0xff) != VEML3328_ID_VAL)
>
> Do you need the & 0xff? Do you have register width > 8 bits?

The datasheet says that the high byte is reserved (silicon revision imo),
so it does contain data, therefore it has to be masked.

>
> > +             return dev_err_probe(dev, -ENODEV, "Invalid device ID\n");
>
> We don't fail on that, now we just warn.

Alright.

> ...
>
> > +static DEFINE_RUNTIME_DEV_PM_OPS(veml3328_pm_ops, veml3328_runtime_suspend,
> > +                              veml3328_runtime_resume, NULL);
>
> Split logically.

Easy enough.

>
> ...
>
> > +static const struct i2c_device_id veml3328_id[] = {
> > +     { "veml3328" },
>
> Use .name.
> This is a new development due to some Uwe's ongoing (re)work on ID tables.

Sure.

> > +     { }
> > +};
>
> ...
>
> Was this AI-assisted? If so, don't forget to add tags.

My bad, forgot to add it. Thanks for the detailed review!


--
Kind regards

CJD
