Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0344373BE4
	for <linux-iio@vger.kernel.org>; Thu,  2 Jul 2026 11:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782993298; cv=none; b=nyT3lnIURj6lnmzcKe6jlBqejZ6zxHp6v/b1ZfBWNJwvoHHfdblbpzvq49+eF4xqV8iLn8l1MFw1sxZAwlY9PhJQb5PkXsNaW/l/Eh89WFxJXEJxsuT+aMbHZBWfweP8HVYBwLmBbbpBk/LqUFRmrN3QgvaDUguTsHnxclExl3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782993298; c=relaxed/simple;
	bh=h3UBt8s2kqs9lJt8/ZSLLrQll3JnwuCfy2ew3MSP7A0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RvTErWK5HmuLZyHrncCoMnGFHei1TS2aTz8pZtL4FF6cPKqJzMyx2JBBWb6PMqe4azLp3IE0bGiSg9DB9dATn3neqvz8yTh93eCQ2ZWEjF7RnM6dkKNZt7fR9p3bOMPNSh1pCff67kAiBTW8eQ0AKm9rSYuIDhBt7EQL8I43MwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Eeye+dIy; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eeye+dIy"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-493bc8fda98so15272205e9.0
        for <linux-iio@vger.kernel.org>; Thu, 02 Jul 2026 04:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782993296; x=1783598096; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x6bZnNnnckR7GCIa0ybaa3K35hyuFwKq5PKxUjyua1w=;
        b=Eeye+dIyZFK1ryBgzz2M+L+UhQBdH2z24bGwH9gIkFyOHO43osXL0EQdscv+Iq+6TU
         lQLOJHgoAxLAd3q1J46J6oUUZZBHykyzAfrNC2CPORFpTspKgqJ/8YBTDm5XO7l41mQc
         RiI+ob7mkE+6z9ViRxiRQLdVDe/rvWTa0AV0WZU/0Eb0X1rrf//0nPRd+aOTRORbHImD
         PqENpn/beC8PrQ912HecvLgMcRVb01PB63KOTA8wzCDiLdGtZ+xQv0DJ5yKCMPMolJvL
         q1OCBIhAYHgwOvCbUlWAx6DWWUfdlZ/bGp8hqmkqScuibEHkC9JGUHuPW5z9BEXzAQwY
         juwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782993296; x=1783598096;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=x6bZnNnnckR7GCIa0ybaa3K35hyuFwKq5PKxUjyua1w=;
        b=ddIU7Q9epqHd6Tt+eNDEGKSiZXAHFt7dO8+SocOK2ruIGxul74Lq3Otk6BVileSJID
         aPsuWw/4BmDKiHWPkCRIMjaEhEqRPHhBt3O0RqB2LbskX+I30L+wQmJOb7EBsmjep/WH
         0LG9isHLXUNWStzoxGq8hEfgUlZJivMCRpBuVaySNW4wyjIy8TQnAUmXZYG6B45VpjIE
         x18ZUIJnV+8JgkFAoZ0I/ilkrabrdlgpPzhYTYyKZUsTKjpj/mjUYBtz+C5fOcsC6OGL
         18GjCblM3hZFWhSbXFqHBatnX+ER1xCiRDRm77fiur8h4PCKwTE2mBq+0oRYps3+LTZO
         3jpw==
X-Forwarded-Encrypted: i=1; AFNElJ/C7qMN7YvEnsioDa3GxXZ5Ui4HnvVnAGHDYmQfb6mrh2g1Lx+X7WBHkYKf4dfRZg2KDxsY3cK4bHM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzoo9XDaMquuegzRTejTGwbfX+qcIRr2YEeXSqOh1dXNrSrsb/Q
	Eht9Ipnnoqvas3VdlqqtUvocgS9Enq4KcdejdsHnfjF+oR8HmLR8HoAW+eIgbQ==
X-Gm-Gg: AfdE7cln4g4uoGr2O9P84ZhIo3i5H80+CJOcxMGhV/zZ1iqC4Xi7k5KNsOky6y9hNy5
	//vnNOTpyhAhsculzrgzcPWDvoPO3BZ75rjWljoWwnfEMfCXAFnRdp85gpMnEjuRY8O4/g6DR1R
	8UradAN/V05vv9HUE0b1227cOIJprI3AvySO6L6a/cCU4jvAsx30j/G+QP5LGGg/pVFjfEOM63L
	80qSF8jRpA8SOG1Uaiftz0sLTeSbqrfRNQkedWW/5QZMctxOONLbuteYEjo/w4WLJUZ469WDBQX
	XhLFb/gds2U46iqilVbmcY+ZW6zyRFZWmKr7hXk3h0T0P7CDD5eloQr6rIcGtUQ0GkVEwDwIXWp
	HmLWES9dGEvYogGXnGg7VWzbdFPZ3jwlH7aBZ/iHdeb/ezDQsJEh640/d8sYg2wscRMhHa1gnti
	AvYQaEEw7HAhxq2Pp1NYWXytPX4qyaoTRh/Ve/zP2zFXwbmULISQsqDrBLrcZLsIZD3+5DigBA1
	NunYSRpcTBv4dex6Zgg6Yw+zp8emsyE+PmQ7j0AeS3RxOZH7kroV5SP6YQorm9vwFnTYOc9mkrm
	4ytNnAkM4gsRUwPJ1CApHQNDwEi5tqgzChs6Qr4WgZfBIg+koy1u/3M=
X-Received: by 2002:a05:600c:8b70:b0:48f:d5b8:5b07 with SMTP id 5b1f17b1804b1-493c3cf3c2fmr61031475e9.20.1782993295873;
        Thu, 02 Jul 2026 04:54:55 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493c63bfba1sm48043365e9.15.2026.07.02.04.54.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 04:54:55 -0700 (PDT)
Date: Thu, 2 Jul 2026 13:54:54 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Moksh Panicker <mokshpanicker.7@gmail.com>
Cc: jic23@kernel.org, nuno.sa@analog.com, Michael.Hennerich@analog.com,
 dlechner@baylibre.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, skhan@linuxfoundation.org
Subject: Re: [PATCH v3 2/2] iio: adc: ad7779: Remove redundant
 dev_err_probe() after devm_request_irq()
Message-ID: <20260702135454.0000064b@gmail.com>
In-Reply-To: <20260702114649.9758-3-mokshpanicker.7@gmail.com>
References: <20260702114649.9758-1-mokshpanicker.7@gmail.com>
	<20260702114649.9758-3-mokshpanicker.7@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  2 Jul 2026 11:46:49 +0000
Moksh Panicker <mokshpanicker.7@gmail.com> wrote:

> devm_request_irq() already prints an error message on failure via the
> IRQ core, so wrapping its return value in dev_err_probe() results in a
> duplicate error message. Return the error directly instead.
> 
> Suggested-by: Joshua Crofts <joshua.crofts1@gmail.com>
> Signed-off-by: Moksh Panicker <mokshpanicker.7@gmail.com>
> ---
>  drivers/iio/adc/ad7779.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7779.c b/drivers/iio/adc/ad7779.c
> index c1a99b4c1256..a5b8bfa99a74 100644
> --- a/drivers/iio/adc/ad7779.c
> +++ b/drivers/iio/adc/ad7779.c
> @@ -842,8 +842,7 @@ static int ad7779_setup_without_backend(struct ad7779_state *st, struct iio_dev
>  			       IRQF_NO_THREAD | IRQF_NO_AUTOEN, indio_dev->name,
>  			       st->trig);
>  	if (ret)
> -		return dev_err_probe(dev, ret, "request IRQ %d failed\n",
> -				     st->spi->irq);
> +		return ret;
>  
>  	ret = devm_iio_trigger_register(dev, st->trig);
>  	if (ret)

Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>

-- 
Kind regards

CJD
