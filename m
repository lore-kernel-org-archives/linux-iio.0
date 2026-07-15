Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A93040EB9C
	for <linux-iio@vger.kernel.org>; Wed, 15 Jul 2026 13:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784120499; cv=none; b=nWMEhO/0qJdKJ/SrOgx9rigrbykTU+VfpaktLXjXkRwBDEx3bIf8qsIgPkLnDCffdop7JIK+k+ZPgazPlSGymxnDN0wvi6mZwqHNq0ihomYY4Go5pMPW3MGZgzYCRwE93h8db6iLvC7fMyc3DNwhCdrnwh2V/WF8tt9asEU68zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784120499; c=relaxed/simple;
	bh=A9IxaC2jYjvoAPuB3MFJhOdcY+PYA3Vpj/llsUFAVM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TLW+OLiPsayX6mVvE2dIzuivsUN57ciN8uco55+ygXnd4530oTGD+8ivkFwx+XIMuhUDel+CHm74fdDASwpgQQuXZ+UhQcfoQZZDI/OzJIDV353/LxOmCMlF9TENFHuMCb4nrUeXVk8Zn9YHkt17/q7VmCPDJs/sTsy4s22UFD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ScxZ9Xyu; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ScxZ9Xyu"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c12614b81c9so1003572666b.3
        for <linux-iio@vger.kernel.org>; Wed, 15 Jul 2026 06:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784120496; x=1784725296; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=JGJiBe2GnXkVQ7WvIgk+rUjAfNgMujlbFP2wwqEbWZQ=;
        b=ScxZ9XyueW6CfHq1BUATqrpPa65NehqpX208mL1vEWCvHbXSF2M4QD5vCCifRqXYir
         4KXrBTG53T0GUt65qCj5uJTE9Mc+oYSbNmDbj67xTpxQqOH4rJ5BD0SUNPyJVsf+i2SW
         YiGWjNcB8PJRm/YZ4395XeiDA+r7yhPOmQdfxZnoHBZbv91tJhizxwObFDJqz1DFL41k
         J4I1/3n1Fkhu9qBoKBlRy+/3tar2to6xTvxD05GV8kI85fs3fSnbcFDVoKY2p22rCS6D
         c+arBZiw668F1tlYgUX7vCrDLUWZFBBfrN/7eqtvHWECq+QJFLgT1AlLt04Pdsx+foBf
         2zHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784120496; x=1784725296;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=JGJiBe2GnXkVQ7WvIgk+rUjAfNgMujlbFP2wwqEbWZQ=;
        b=YBzC6iom+MYKMHvAUmrtJUiOPtjZsIy2NrtU1Y7MD4m+gmyKV/Cm0xXJMORPTOsW7R
         YTk0sou6kiX4GAu8s2rOm08wnPKTgraqUPpLTYNdoJzHqHxSRG8GAyUfmslEcHGw8xhp
         j7Ili5HfEK+5ZvZKAL81Wn7q12PhzloR2PEhfJoTBPIxndZS35QhfrOr5TOJuClyzhUK
         BenkYv9xPFYjB2NIhzrPWssm+o5b3pNTBir4Ox7TO1LzT2/sQeWBU9gYx1WjffOOvVrW
         q/13zkLC9oyFmTbFGC1bOhF2sBbpJ/hpN08S9ZpiWc2ZqPmBA91TyB4+Ze9Aya4jBGNr
         uFWA==
X-Forwarded-Encrypted: i=1; AHgh+RoKqNv+mNIKqcavkb2QxBuOEbfCx9X9+5eJonWfJnFA00F9tmmlBjRnLtgtqMZtWc+In+caCpLZ/s4=@vger.kernel.org
X-Gm-Message-State: AOJu0YynskyKtnE5ypiZsSluPMen/7t9sz3+2y7d/V2E3Js1ZgjcqLqr
	Sr8bqL6ZS5NjzhDMLI1Cqek9G7tXxQwTRK+Rp3OCC7B4dvAx76w4ikTO
X-Gm-Gg: AfdE7cnw6xfxO4uAA+5dUT5fhJTCLvEEWj8BSO///tWyOvGAJikfmGuRQu/5noC4XkH
	dKHh8KlmDbLQob7ou7JqS7MFs7CWiiPXkDSv3DF6ZE3YbFtmjjJdVmZYoQH0BZnk6Wm9+c5HtNv
	5qODxestG5hKl5rztXy29xfz5NFD84wXlCh/yM3mEzJtYgAGiGk7laH8zxHuEiwwUNX5iI9Q/ZS
	TY5C2z27aw7RJvCz6joEmtZau9Tccin8J068+PhLnF1XDkHMtvDOsKBmiIKueEp6SVSJshnEmnx
	GFaZb0dqizp4Ze9QMNU0izy96nkTxG8EbXF+DOmwvEyj7e4y7K5bnAHCJ9ET+8N7HAw5/CYlIVo
	yRZaarrUadeF1R37ynouDqsTLcS8VwcICb+/Mi66HbkRI8r8hW3N8Ch7exEg/n0Kzr8yiKhvu/i
	gDnz6ip36PqgVa95RdcZhn6zBP3Ag=
X-Received: by 2002:a17:906:2856:b0:c15:e04e:aed4 with SMTP id a640c23a62f3a-c16792bf2a1mr141096566b.42.1784120496310;
        Wed, 15 Jul 2026 06:01:36 -0700 (PDT)
Received: from NSA-L02.ad.analog.com ([137.71.226.102])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c16871962cesm22072566b.25.2026.07.15.06.01.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 06:01:35 -0700 (PDT)
Date: Wed, 15 Jul 2026 15:01:32 +0200
From: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
To: Esben Haabendal <esben@geanix.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Nikita Travkin <nikita@trvn.ru>, Maslov Dmitry <maslovdmitry@seeed.cc>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] iio: light: ltr501: Power down chip if request
 irq fails
Message-ID: <7yhbsguvuodmgpmhb6dgnuxfede4x6x3ducrifymcmqlb5vl4u@rgrjqovq2ife>
References: <20260715-liteon-ltr329-v2-0-d18af55edab5@geanix.com>
 <20260715-liteon-ltr329-v2-4-d18af55edab5@geanix.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260715-liteon-ltr329-v2-4-d18af55edab5@geanix.com>

On Wed, Jul 15, 2026 at 02:27:26PM +0200, Esben Haabendal wrote:
> In case request irq failed, we were leaving the chip powered instead of
> powering it down again.
> 
> Signed-off-by: Esben Haabendal <esben@geanix.com>
> ---
>  drivers/iio/light/ltr501.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/light/ltr501.c b/drivers/iio/light/ltr501.c
> index 379e57ac5f5b..9d4de798e5ab 100644
> --- a/drivers/iio/light/ltr501.c
> +++ b/drivers/iio/light/ltr501.c
> @@ -1571,7 +1571,7 @@ static int ltr501_probe(struct i2c_client *client)
>  		if (ret) {
>  			dev_err(&client->dev, "request irq (%d) failed\n",
>  				client->irq);
> -			return ret;
> +			goto powerdown_on_error;

This looks like a fix so we should have a Fixes: tag. And being it a fix
it should be the first patch in the series (can come after bindings
though). Reason is for backports.

- Nuno Sá
>  		}
>  	} else {
>  		indio_dev->info = data->chip_info->info_no_irq;
> 
> -- 
> 2.55.0
> 
