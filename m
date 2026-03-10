Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB36E2356D9
	for <linux-iio@vger.kernel.org>; Tue, 10 Mar 2026 01:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773106371; cv=pass; b=fZ+D7dJFXAulTf387Vpo1z7i0/Teoc6GQqkqOVfIPRfa4DwSX5rJo6Kl84UHEklX+Yx1TIQfQQqJ37MV5iUPZ8DGn/c1H0NrDU7lGsSTUxtlIrziS0TPMfRsYIauEguKh7feosK3bsHp5x+ldechLPuvQAlJeM4pyWa/SVSotZA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773106371; c=relaxed/simple;
	bh=ON5/T8Ii4NJdSEK/vjaegTpOtQ1dmcLfA0pVGwnv5VI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hED5NcE0w3tW3jPsz7C2++IMWVvcEY6O/RZLHkKa64qe4OatSR/Li3WHVKsm/GJjynry5hOPkW4omjSxx8BofxOR8ikNY9oIaEfkloDjKHTderMojeFAdrTDndh0bsxmnlHDdXhqrgA8Ca1fFGiUqQF9JcBESpf6AiDc9BRc90Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WfKnkF1b; arc=pass smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WfKnkF1b"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-661d20c9787so4032649a12.0
        for <linux-iio@vger.kernel.org>; Mon, 09 Mar 2026 18:32:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773106368; cv=none;
        d=google.com; s=arc-20240605;
        b=Ukce+nnfo0MxEdsJPIDt8qjHJu5Yn+YVcNgm7b5Tv773Wrrbtb1qxV7ekVUsevfrcT
         cPixpmDc1irha0WffiPCqJe4K7bsRHQzTvEpM0gyRQr/RTLmKyY+xruvqba2bUT8W9dk
         geQYObzp8wukQoiatUsd75smJGvTjXHTLzcjEfJXtumWUlzGS87Xfso1cg6pTwMjZM3h
         F8YVLjQayATjUPCrls39zhDf1gbq4sz57uwsucXHL1R+6ixLDIB4bIp8W8UiyAGFQhiv
         R6eMjDpH3ubJQNED+95fjTMc7rAsdw1ycIeWIwXlEGR5uEFx5c9DB2tHNYNhhpHE+6BL
         vW0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=86TLssPRzWRl2oB9l4EvY/Oyf71N3N06GZEWrMqMOHk=;
        fh=EGQ0mZXxX7F9wQYbhUN2dzZyI6v2fLKzwa5PwEpRd+c=;
        b=PayP9BBxScIvgy6GN4wgkPhEdqpKYgyODYJ6W0xwo+RgD10Hn+zaf7hLJ3Dgntt5sB
         RxKjeRz+Zpjj8mOVNONPHt/06GBcSxrr2uMSDfe82LCxHrhRZrS+WGRwE04UZFKC6ut7
         Zfa9In2+YAXNJltBmtX48UL1qTmyezLRnvNCGLt0TYbvk3eShebUZyy2Y/VPG499VFoZ
         3gnMuOSj+9mM23fmVwrTJ7EGH6Yft6Q7ezIIGV+4Iu1riC2txKjFDjIvur+kSQUKWXrY
         F2EbRksdNATnAy7LZKoXVj/yVCwcw/wAv6rEjCZ2dawuAfCEd5USCOHq3X6wXj4ddSuJ
         o0GA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773106368; x=1773711168; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=86TLssPRzWRl2oB9l4EvY/Oyf71N3N06GZEWrMqMOHk=;
        b=WfKnkF1bLvRSEjpv0k6xQbOGh5C9zrb06DtUaohi/RqUJG4gDPAonCghgHmGRuqPPj
         JblBdfaztZ2b00udiCKcBTx3PZAxwG7a8UCbsrL28rmSWQv5ik15UJ2rD9kVt4YP784T
         H8A5wfDNRjVi8lNB9/57HUI3IG4ox8dvhyrase2E45/BtCizaQEBa+EBtqnEFT3ac1rR
         WkOLKhom1K45o8YwJzhdSUqiGd/6hcbQLigqL4svPd8m+TI9kRIQj2KrlQitUNNjTCnu
         zA+qjJZSLQzXbvWMC8Yi0lAZz8N64o/PZX6gOunBObPqXhcqktfpoO49l+upH/hoZ6G7
         wCDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773106368; x=1773711168;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=86TLssPRzWRl2oB9l4EvY/Oyf71N3N06GZEWrMqMOHk=;
        b=Kd7FTR9NN48Jpc4HAznpQFM7qM0PrFVm3WmaLr08AuObCqNQ162qj29zfECZnGE4tI
         yp24A3WYw/gPucaMeIqQ1tkZF5z8Wr1nYQMpU+93uzVbX8uZVIb/GOH0oFIr7SbT6LvD
         M/U+cQjd63q3Gy9vV3cAuUn8bEqCV15G7oRBoN34JiKBIQzrowVHnpvUsCAFVJfS2CXa
         AZQbn1enu7WlyRf784glqVl4xhPvlwnjzmv8MIRJui70gyqCCxhz1SaCvgEPS5smjRx+
         Ud0abcLL3xYwAhj4ZCY1vPel6fjtXLekmNv9RRJAp8ZzquzEEqog6hXv1A2OgcWDUJLQ
         AdWw==
X-Forwarded-Encrypted: i=1; AJvYcCV+guA3mQLKTKDBLtUH/y4FfB81KVkRCJFzOJV1aG4AXgnwilei6mcWE8VFdFThUTg3L4ILI7LgsJU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxl2rYv5AfQ9LfCAV3vFb+3F7eJjUXgzgObwJjBeH8Kceb1TMpC
	hXXQ6DvrifsrL3jiwkSS0RXQNtRj+eNcePbNlZSphay57fx++TLH0XzhP65BEWKVlflqY3mOMK2
	biBQT0nF1D3VcW5SsJlEmGWGHFDnKDTk=
X-Gm-Gg: ATEYQzw16zRz23l7e/+QXqarhK15fuEZisZ25fkJKadi7K7bcCBPwvz/Nb4DbG3sbHJ
	zW0IICRFZJfLNitSHUXtj9zXOWJs8d+yJSbQDLUqM61+xOsEy8Fod7IvAsBS2c5QKaeZARzuH8N
	ixnQBgarGCiXWMVYMYdrFpqaNK6eOXxHQoOqPlFZELncd4y+ePbzSlEF1JrQWFIffGhd0O0fdMJ
	7H28nhQz4xPVzWm0T9l307HQ0jBJT1RyvWvxiUspovgDwOOjtdoz0pHnWOqjR5DRXGSPAsms4QA
	9FLZcLGC
X-Received: by 2002:a17:907:847:b0:b93:5520:44e9 with SMTP id
 a640c23a62f3a-b942e0b5b14mr771191766b.35.1773106367844; Mon, 09 Mar 2026
 18:32:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260305-adt7316-correct-macros-v2-0-3702e3841c42@gmail.com>
 <20260305-adt7316-correct-macros-v2-2-3702e3841c42@gmail.com> <aarqg9NBUYpkFKDW@ashevche-desk.local>
In-Reply-To: <aarqg9NBUYpkFKDW@ashevche-desk.local>
From: Michael Harris <michaelharriscode@gmail.com>
Date: Mon, 9 Mar 2026 18:32:36 -0700
X-Gm-Features: AaiRm521MA0nh8p08BWTyZJxvxz62iAI5V-W6U9IjOHdZPkP_2QdtbqObLlDWLM
Message-ID: <CAHXWO3TSiWeVBU-KorRFu8t0SEc-im-xJHwZ1c=Q42OTP+TmOQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] staging: iio: adt7316: remove shift/offset macros
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-staging@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On 3/6/26 6:53 AM, Andy Shevchenko wrote:

Hi Andy, thanks for reviewing my patch series.

>>  #include <linux/i2c.h>
>>  #include <linux/rtc.h>
>>  #include <linux/module.h>
>> +#include <linux/bitfield.h>
>
> Try to squeeze it to make a longest (but sparse AFAICS) ordered list of
> inclusions. With given context
>
>   #include <linux/bitfield.h>
>   #include <linux/i2c.h>
>   #include <linux/rtc.h>
>   #include <linux/module.h>
>
> gives 3 out of 4 in order.

Placing it there would put it right below slab.h, sysfs.h, and list.h.
The includes as a whole are fairly messy and unorganized and I don't
think there's a clean area where I could insert it. Fully reordering it
would be out of scope for this patch series. If you prefer, I can put it
at the top of the includes since it would be the highest alphabetically.

>>      dac_config = chip->dac_config & (~ADT7316_DA_EN_MODE_MASK);
>> -    dac_config |= data << ADT7316_DA_EN_MODE_SHIFT;
>> +    dac_config |= FIELD_PREP(ADT7316_DA_EN_MODE_MASK, data);
>
>FIELD_MODIFY() ?
>

I will apply this.

>
>> -            data = msb << ADT7316_T_VALUE_FLOAT_OFFSET;
>> +            data = FIELD_PREP(ADT7316_AD_MSB_MASK, msb);
>>              data |= lsb & ADT7316_LSB_IN_TEMP_MASK;
>
> Ditto and so on...
>

The main purpose of this patch was to delete the offset/shift macros,
so I only applied the bitfield macros to areas that were using those
offsets or shifts. I left that existing bitwise operation there because
it wasn't affected by the offsets or shifts. If you'd prefer, I can
update it in this case for the sake of symmetry.

Thanks,
Michael Harris
