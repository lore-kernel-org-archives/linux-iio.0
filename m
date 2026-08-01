Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D0948989F
	for <linux-iio@vger.kernel.org>; Sat,  1 Aug 2026 08:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785574114; cv=none; b=COJGo02b8AqrdxJkqe6yqdYa19tF09DFg4lj4Nkhl++ZGsxMXZUxFedCEhRrZqdb0tMi40Rf0C8RrDcB890V4/55NwC+AoUXS2eyfXkQBTfk7suzKaDMJ+TEMk6C3JEyRzpTbaP5JFoI+pXevkQaoJSlw+fUMYGsasv9NJx/jJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785574114; c=relaxed/simple;
	bh=CBTuGAaSO+Mj6Xd9zM2Dy/TQHDvuh1uTIenUQEv3ye8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tgCkHs0gI5S5BnqVIa/XQOG2+mf0Q76f/5g7Baq62i79jFXbG3kbW8I+MbU3zG/M2sYB1O/r/8QRHW5VzByChUENUBcbdIfZ1MsyWxq3RLMlaz5CDnd6RfOdq/2V5anbBMAENPnc9ugNctiBn0zNdeyY4EgBG6YBWZ7cv6ZjQco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tweaklogic.com; spf=pass smtp.mailfrom=tweaklogic.com; dkim=pass (2048-bit key) header.d=tweaklogic.com header.i=@tweaklogic.com header.b=hntZ1oT8; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tweaklogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tweaklogic.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tweaklogic.com header.i=@tweaklogic.com header.b="hntZ1oT8"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2cad8076b01so20101645ad.2
        for <linux-iio@vger.kernel.org>; Sat, 01 Aug 2026 01:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tweaklogic.com; s=google; t=1785574111; x=1786178911; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/pZ8m7pRzCz8D91oW/VyFl59Ql2se0V6HINSg9JYJs8=;
        b=hntZ1oT876WG+B50DD6Rfv1ytRErqAhdgAnwdGLjMZ1sq93p0V+YL9yfjIcFeiEW3D
         nUy2TiFOhB0yr+nDi+Aoyyu2Egnbql+BegP4n51OfWJl0juTPtg6v0R2EDPrY5oN3ENQ
         Jno2zrBps7HIAuJfA+aTEg6pUwDHyK4JDp840Dv0BkDj+6ul4e9eB30ydxLdsD373jgu
         xqlX4ET3UmUrfF/6DpPh8HSgJzVw/Rd99TOfyptCeTyq9DYMXxVEXcwqDfLdcTKsJKPl
         siEZWlrCbJ6UZo6mdRzqoOtc/8t97l5q8IrJZhtbQTpf2ESXnG6enPCuYNmjB3Yt0imA
         mOqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785574111; x=1786178911;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/pZ8m7pRzCz8D91oW/VyFl59Ql2se0V6HINSg9JYJs8=;
        b=pLnnJLuxABI7eaSor+reUv/DM8FudLNNz8yw94ot7/zQTWFHBZb4nD9jZWVkyhz8+O
         kZWtW7DrvSYC7Im2jbuwUj/wLTFz5FHlFQhVApLlVVkcvRLwOuomPQn5fiNeafJ796e9
         xy/nZZ+hSM0arGOXqKOAIninGuy1rjytxPaNYnAoWrMU4TDpUrr+zC/emjPkyPBNKBHW
         yqGMlPj2puixdQvenxWWrgoJXPLZ74rpllU85v6IvF9EwMjj6kbNQpBAX7QA5y1Zgzpj
         sHYJNLHkMOFykKmU3+NprTmWcu5uiCXSP7pjlC8fnf9eJuQYu6M5wHMUlYUYZE8D7bto
         XY/Q==
X-Forwarded-Encrypted: i=1; AHgh+RrQ8Jd+HiGfr/DDNGLejDJD5IECV0XSQm/QDA/rpHoTYLK3Q9kv5kLgjELh43i9TQRCZH2dBRTQwpg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYFFbi14MOJLp3PHyAlxQCPfFLlubSC1R9sLuZaWanK6CFnx5P
	wA5ZISnnfXNvS0D1paM7zphtHL09BnMAzYT2qYa9jSbBensQ1Nx1BcqRtZ3gR4BHgEM=
X-Gm-Gg: AR+sD11aPwWymbt0qyt6N7HOKN7rmxxJ/Q5l2ShabHluKEPJjhuYQ2vo039mCS9jLqD
	kvN+l1r6TOVaenEHPwQ/73u8He5Orbs7KiIhbRR7FIu4cIAnYlXMU4azWV8p7NfBhKueAy/Z/vT
	iV7qgQh/0CSvLTs2yGAwloP+ei7dw8k4cn6se7miCSFxIhK6Uon+C5+x2jQnCL3U1d41uRIUWu/
	GHJMO4oEeS53QmDpFTx1lAA8OkPXcdOIjVhbXfYenNhSOqnOLO1OZU5Zd4mbaAhH56yemT8BhtL
	6/7u1cAJphSFfvabhR/A8TORpfsj11W4PMK9aMUmdCQGmyh9/c+YYfH40oU3HOuFJdy3vgzLygn
	YtygWdOKHqV9eS+tQqtLUV32tQ5NsLbJIaP970C/+I672+HRRxNtVVAXQsNSEF8aB1rxc/vIeWf
	d8X+Du26DnsXfolFEBTdV6um0BvyWNyPLkrRi05gPOzK415525w5wt7+6Fw2hAAeiGcPxPEMkcA
	zPj+w==
X-Received: by 2002:a17:902:f541:b0:2ca:5970:732d with SMTP id d9443c01a7336-2d0524810e8mr29279355ad.41.1785574110963;
        Sat, 01 Aug 2026 01:48:30 -0700 (PDT)
Received: from [10.104.119.12] ([129.127.204.12])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d04b0eb598sm15724405ad.51.2026.08.01.01.48.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Aug 2026 01:48:30 -0700 (PDT)
Message-ID: <166588b4-7bd6-400e-9be3-300dd1a1f9f6@tweaklogic.com>
Date: Sat, 1 Aug 2026 18:23:19 +0930
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: light: apds9306: fix PM reference leak in
 apds9306_read_data()
To: Jonathan Cameron <jic23@kernel.org>,
 Moksh Panicker <mokshpanicker.7@gmail.com>
Cc: dlechner@baylibre.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 skhan@linuxfoundation.org
References: <20260725051048.5616-1-mokshpanicker.7@gmail.com>
 <20260727033151.0ea0cb9d@jic23-huawei>
Content-Language: en-US
From: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
In-Reply-To: <20260727033151.0ea0cb9d@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27/7/26 12:01 pm, Jonathan Cameron wrote:
> On Sat, 25 Jul 2026 05:10:48 +0000
> Moksh Panicker <mokshpanicker.7@gmail.com> wrote:
> 
>> apds9306_read_data() calls pm_runtime_resume_and_get() but several
>> error paths return directly without calling pm_runtime_put_autosuspend(),
>> leaking the runtime PM reference and preventing the device from
>> autosuspending.
>>
>> Add a goto label before pm_runtime_put_autosuspend() and use it on
>> all error paths after a successful pm_runtime_resume_and_get().
>>
>> Fixes: 620d1e6c7a3f ("iio: light: Add support for APDS9306 Light Sensor")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Moksh Panicker <mokshpanicker.7@gmail.com>
> Good find.
> Please look at PM_RUNTIME_ACQUIRE_AUTOSUSPEND() and matching ERR macro.
> 
> Using that should simplify this fix quite a bit and generally give us nicer code.

Nice. Ditto. I have to read about it too. Thanks Jonathan.

