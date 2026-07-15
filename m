Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B45F3F4112
	for <linux-iio@vger.kernel.org>; Wed, 15 Jul 2026 12:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784120391; cv=none; b=K2G5EbHrcNsV4mCDPU/ZKTFftXy6qnnTxNYpDW28NZaiK8S4jfGdnzEA2Gl6nof8e6FQTwgWyrcpjWXlaA4/JyFf4Uti5xaL3a0l4mDx6SJp4DkLnzP3z5hNxHpuOY5qiZ33wRAqS/XpbJLicjUZUFzhoW8p3bY7H5aIv20oVn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784120391; c=relaxed/simple;
	bh=nVcKHyPKz/W/FvJITsfshyPhXDm4WJXd509Pb5vj2ug=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=My5OWipRxX3ojf+YiBglq+Pd+6I7rxRMTtGjrlZiyS0aOuVbq9XFPX+OMNeYTGJQyPMCFDCJHVH8+6fXsVjsFLEP6JqRtyWKRP7/+V6vPckf2MTqAHZ4PxVRRnxHhQQWBswl5He/k+WvenLBUQqNqh2K7n4MleIoMITZnLwstBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UHzw17oB; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UHzw17oB"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-493b7612475so41111855e9.3
        for <linux-iio@vger.kernel.org>; Wed, 15 Jul 2026 05:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784120387; x=1784725187; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wXmSB/fZgpo1wJ9NHr1MARO2u1xBe0vIjZpMWVhRSx8=;
        b=UHzw17oBf+ApTp76TDefHfJ7TITrucW7MPXpUKVWDiXxtDURbhx0nj+umZKd+fZJE+
         AdKHr8ZaVkvwkfmr8IuKHtFDaNYP0gS5G9U/pEFwOKspMWavpnhvP9BDhL+lz0fw2KMP
         z9qxY89xyZAh4QY56A1Um/brXtBM6K7LA8R+BdAINXQzlrR3y3XORRou6BapS0F1HRjO
         5p3kSA59uBylieexkJGbIMs6ldC6Z7TcWzzxTZrrCzYK+W+Xia/R0HO4CM9yx4Bd+hy2
         1DbAbkM9rDBOk4KjNQt3f1dpszBfZVptDwg9Zxw5nj3DqYdwKxVZcWmjFDHd7GKJKMUs
         /M1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784120387; x=1784725187;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wXmSB/fZgpo1wJ9NHr1MARO2u1xBe0vIjZpMWVhRSx8=;
        b=rGFlbZROQUqivJ1HuVdDY7e3J6wCWSyqntt4Wbs2mxQVrmJMTZ6WoWUScw95LNqux+
         E3jSOvthjuamp1qV13D2fYkb8796crHOM7XKP7JqJ5rbI9q5vg0KVl5lnZlvUJqRtdAf
         CnGvtqKKM0KVe4gk9IX7B4GJ/ANGMlfol0VxXn6xlarAYM8BFQbKfFmwsN9uxKupWdH+
         lex6IMTOA66wQ9scNCy6m5mAoJPvWdI5vZwsSmT1vFtNuAoDciBL/DHKGADkXG9JAXfR
         I94gy6vlvbwE7FDyKD0swdwYpdbFus6rqzI9B6+bRmXWIGMLM7KNet3YLwvsI47YexE1
         k0BA==
X-Forwarded-Encrypted: i=1; AHgh+Rr9j4sKywg8X5hJj4EsM+QBfta29tg0H97FPXMLmyr0RmQELHQpnfBfm4BvA/hQvMPUu9p7F7KL9SU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywk2H7BBCBcEc3rYl3KyZs7CCg63+E/zltWfj8/N2PbTEZ6k1dX
	7H/PPPFLERvqWlKwET20INEIP0YebB8r9IVH+8Rci5ZPdnrIcuxa7Q8yz1WQkw==
X-Gm-Gg: AfdE7cmDd9s0EhpqNuAeCu2+1jR409vzSyk2Cp/Blw+2vYFnnsztvSvnIfWtrFB3vUP
	AiczYkyToqtfps+wohaU5pVLkLZrfkUQwY1NLbGrRHW/GaqY9PiDDSUlWI6G6O7iPHb8KMGECun
	v+NsRTR+NCXWvNxgoZHDzMkQsBSUNtWe7IPrK/kmdkaA2x2nFbKqOX7HtWgZeQKZTRvfhIPukyV
	9FujmHupn2uJCtd+CRv9Ih1yUmy0a7YORopYS18wB/jkb/gjj1AgGdA7/2PH8AGRLTNekMwbtal
	5hXnnbmCaQZVTpQEjIaI2phaSILEMYWLMh85bC8PHeO7DomlqfJxAGarnpKuwgRzP+j8saqniXs
	+AY9forN/VaJ/+6dT2VUr8gP6NEJOeoTXPu/JT4cUxBn73MkA2AwevXoAVPQh4NEtzcHWli4MCB
	0xH4Aw6xD/z6XlHMqQWlTkkr3FKAg3IOw6KmbmgyEzl4LgzmunnTf8StMl7BHY69eMp6j5VAO3n
	keNnkV94ql3catg1v6IbXnKSUtvwxpXQ+Y7xiadhfVfsEqQ9RavxDezYuS1/A0S5/4zP4SEWlvU
	m3gyzUV4iy5Gmk2lJf6bOrqriye4jwXXGBIlQGtFmBORYYkgkHDImDI6nWlmPo/wXNXNzfidqtt
	V3BfpRAu9GVhBWCVQhA5x9/o=
X-Received: by 2002:a05:600c:34c9:b0:492:3e44:214b with SMTP id 5b1f17b1804b1-4953905c59emr70009845e9.13.1784120386545;
        Wed, 15 Jul 2026 05:59:46 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4950a2f951asm157537975e9.14.2026.07.15.05.59.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 05:59:46 -0700 (PDT)
Date: Wed, 15 Jul 2026 14:59:44 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Esben Haabendal <esben@geanix.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Nikita
 Travkin <nikita@trvn.ru>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] iio: light: ltr501: Power down chip if request
 irq fails
Message-ID: <20260715145944.00001de5@gmail.com>
In-Reply-To: <20260715-liteon-ltr329-v2-4-d18af55edab5@geanix.com>
References: <20260715-liteon-ltr329-v2-0-d18af55edab5@geanix.com>
	<20260715-liteon-ltr329-v2-4-d18af55edab5@geanix.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 15 Jul 2026 14:27:26 +0200
Esben Haabendal <esben@geanix.com> wrote:

> In case request irq failed, we were leaving the chip powered instead of

devm_request_threaded_irq(), please mention functions and structs by their
full name to prevent ambiguity.

> powering it down again.

+ a very short explanation of what you did, 1 sentence

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

While you're at it, you can remove the dev_err() call as devm_request_threaded_irq
already calls dev_err_probe on failure, creating duplicate messages.

> -			return ret;
> +			goto powerdown_on_error;
>  		}
>  	} else {
>  		indio_dev->info = data->chip_info->info_no_irq;
> 

-- 
Kind regards

CJD
