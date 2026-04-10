Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFEFF386439
	for <linux-iio@vger.kernel.org>; Fri, 10 Apr 2026 10:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775817815; cv=pass; b=KiJh+ZrfyEPT4Dk9NdzXpFvOcXHDM/dbUNPLweledL0/yoo9K6W7AYaEidQ4BzdghdPJQEimmSF8sclPnMS+Qom9vhQrbbBee3XjpsLAQ59h/fcinISkAoZ0eF0pYs4adljGJCY2YNoONHNAYiOF9HZ1OyIhH2k55zjE42KLrZ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775817815; c=relaxed/simple;
	bh=dK6d2FA9a77nfb1jYHoRrb6E5MltM8le7HGTiqOX994=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ehnWqoPxUablOvdYcQmmrR9VQN5CoCi6TyFgYT+VH67lLUwF7vGzXMoS2KoyAFOTgbbjR0J3LXp1YmgZTG/ZGrIa9d3y2WV0e5hExnmdRB76JZH/yCWYJPAvu/HZC1PhcDhCD5U1F3eZ3uWdz4ZynaVeaXFl3p6txmwFqJX7Ieo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T18jQfi4; arc=pass smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T18jQfi4"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-66e6d9610d8so2767223a12.0
        for <linux-iio@vger.kernel.org>; Fri, 10 Apr 2026 03:43:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775817812; cv=none;
        d=google.com; s=arc-20240605;
        b=U5+RRgE8yKPMGTobsw8TJEe9sTlw848ZCDOd0CDNcSq+Z3NkUHVl5BW/WEU3zin04b
         wqcCzMLW6LdevLk4tFQ6Y9WMcgGotA2wjqpFeVBmheYb7DZGal44hrP3R9pmcG1itEuu
         BTO6q9d7DpxM0StnglAh+Wn7N2pHw4TJNO1Eq4PE2IjCWrx/iJtzzWhEwXmgjxswRW9K
         u4g9bTu8jc7C8JY++R88gUegcbgdBoF3jSvARODAZMDbQB1SgwTB4LKh7+bcLJA0Tyyl
         cWnseO0HD2xoPbZHc7485rKUkq8u62M6H6iHEnQMl9PPA/ODx4Oq2bFX7nz850C2C+Tn
         KgwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BdoIj5BlxYESHpYC3v+AXBrtUvLBmx12sFmAxpINGgI=;
        fh=dNKQ/OQb5xb1Q/bbTGpkmkRl8SXaJhzm2/ves0vPjwU=;
        b=a4CrJoAmxbyz6wipxo7v4eTFkm9p6gn4kt7me4pkudZSd0WTAwbwLDs7AKQ6HOViqe
         wNNHS5ld92DBYXDPxIejcTzyLQww9oQWnLVygsgRTnTgLwN4v8Yrl/XfKhRi4BOMJEno
         MHc4Pe9Fb0ZdAZPZNiw25f5XXKsubPUKVB0610HKiQ+ExKb4KSCrtbOoM9lyCfY3R5H9
         OLCVCklSPL7t5lTVgc/tKZtBwd/MQ+2w5vP2tfeakj9LFEgIU6oXwuvjfF/T0BMRgTC9
         CvJh4NJvo2Qzg6pCcUPyF5GSWWxwNZGKB86HRnqwAfru85u5TcQN0Y6XAZo3dVZBUuzV
         hskQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775817812; x=1776422612; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BdoIj5BlxYESHpYC3v+AXBrtUvLBmx12sFmAxpINGgI=;
        b=T18jQfi4QgeFAiCoIwmNHRIueTQND4Wzp6Y+oL1IAwIrxpC/dArKdUXo+FYV65FNV2
         x9By0c55sQSpD68sS/n9QplC3SxhD9lorg1SKoxstfFJYG40zSpp+Z0DzI6L/4Aj/nmX
         jSnj1i/UG5YDV5+zIZVqwtzRzB7k4QAhcuDMqHSGGcwF8hgvOkd/vHl0fPC+MyNg5SU8
         lJx+uDkTV5UHvaSdABjeMD3KNY5ytkBbDyy0FYTMCeYj/OrLppNVIb0COxqlXzK2Prws
         KJVutYczc1td6KKK4a/sMcVtT+TNraMN5YZy2PXuCuGva40Xt5r8V8wt99rZ3m65SKsN
         QAaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775817812; x=1776422612;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BdoIj5BlxYESHpYC3v+AXBrtUvLBmx12sFmAxpINGgI=;
        b=R0eJTGgZXaX/IbNQp0WeqHgX+PBOKz3pGW7Maay94srtfXf1cVmr1Zrl+yoxVw+P+P
         grjbbrGtjUlSkmj5ZhynoQ+TKaSqlJ5xyFW6MNNvzNWO30Rs1v3MTl/gV+AGn/Ph1lNq
         o2lDejpbOG08w/Zad8kGMxV4BhcJGK2MkaGIS5hqUTnoWAOU1/68+q5FNSwwQ+CjVTId
         kbW6ZAX5oMArXXV+nB8maPjLwPPnm4hNef0DxD7zCsboJqK2gu0iXKmB7UTMZ6xZLcXB
         Cp44xqjuVNH1qfeZp1xZN/R2Q3jAi+oQi0XgYeF7Ou1veEcsHOxISGuXL0Ml6gLqd+/3
         DIUw==
X-Forwarded-Encrypted: i=1; AJvYcCV9UfAZnFPRW2AFk2mMtMpYYRyS7LY+NmyUEpCdUbmqwqyjaHDrIxIkbru76K76E4pqmRPWsLseJEw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoVecEzMmv0LQO1shnP9XFHehlxcRv5f5Y9z4aAPZQKoufIlXg
	meUEglFh+hERtEDwK1sHvkmrKF1+niOVn/yFJK7b7+bLZZR/nn/ukYzi9gRphhQcLagjMPlKw/U
	mX/TYnyrYilzd0+Pk1n674KNbrkpxSR0f2EgP
X-Gm-Gg: AeBDieuf5HHZjH90zoa3+iykeH6bHLD5mykXTiTFBargZhGfj3ukJLTRHjlZZsDTIYG
	uBDpArLsDekA8S1nF1yxMNKi6glKh8I3W9g+eSqj9l7JZGNmslwUsi4wpmqz1UH1BuobWqe4hR+
	xm6dh75R/iMQ3Mrz4KDNMVHOrmTGhBRGvenccL0lOoc73eg6suwXsYhfG9RBK4RDz19MDNCE1HO
	AZ+abv9f1WpnxJfyENZb4cgeDgVOJ28T5jWKtAN7CcXEeogFX0kb4H+gWQ4T0iLWOQT7jJfIGsD
	r2EboV4zPTOUS0BZG7K3ZBK68BSs2xppUrT2PrEKSTfn0E+/IAbURavrn0CvLSeVwTzAzy1l2p7
	gH08NbCs=
X-Received: by 2002:a17:907:e107:b0:b8e:796a:fd5d with SMTP id
 a640c23a62f3a-b9d7277c0d1mr84942166b.39.1775817811836; Fri, 10 Apr 2026
 03:43:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260410100832.1388-1-joshua.crofts1@gmail.com> <20260410100832.1388-2-joshua.crofts1@gmail.com>
In-Reply-To: <20260410100832.1388-2-joshua.crofts1@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 10 Apr 2026 13:42:55 +0300
X-Gm-Features: AQROBzA5dWSSOv5xrYv2iUH2sXBet1J7jbnIYb0CT0Ni_O_MSKkvwnOAMkLfXQ8
Message-ID: <CAHp75VdPhg_5gOZtfsZyMkFf5iZ8-wtZ_2Ta2UaWYKbVzgAB4Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] iio: frequency: ad9832: remove kernel.h proxy header.
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org, 
	gregkh@linuxfoundation.org, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, linux-iio@vger.kernel.org, linux-staging@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 10, 2026 at 1:08=E2=80=AFPM Joshua Crofts <joshua.crofts1@gmail=
.com> wrote:
>
> Remove kernel.h proxy header and add bitops.h for
> better dependency control and code clarity.

...

>  #include <asm/div64.h>
>
>  #include <linux/bitfield.h>
> +#include <linux/bitops.h>
>  #include <linux/bits.h>

bitops.h also implies bits.h.

>  #include <linux/clk.h>
>  #include <linux/device.h>
>  #include <linux/err.h>
> -#include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/slab.h>


--=20
With Best Regards,
Andy Shevchenko
