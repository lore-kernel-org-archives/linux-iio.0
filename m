Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF33223DE7
	for <linux-iio@vger.kernel.org>; Fri, 10 Jul 2026 14:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783695246; cv=none; b=uZ6LlvQqxObkU+RZcRhBQlh3J0mPdW/vTHueIN6DUdv6KGjyHw14V3AyNTUG0lbQhPyKHptY2TOUf+KKSR3lcXWaf36iZkFWUXnnCufuWPkaPlVjlZhiVT0acYXMsbjHqIj8lbPoJLULuEhn8A6S64IX+WZy/hmS2OqECN70F6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783695246; c=relaxed/simple;
	bh=zjjM4SgtY2ZYsY/pfHW4NTPajyUYDKNVs1BgTxWTkMI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hrz4hMqurND+Mtica+jj2EMFDTjeOf5GBpvtugF39MAET/RrA9u7wSN+Wttu4Yf4FE3NciH2NfENHp5HjtTcich3kcj7kpT71SoPCWNL05RAE1RfuXqjvq2F5Db3lKoPm0DwIahjnxxqCkbwqFqr8w/uOtbEgzCfA5LbbYxTE2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rm1wYWQq; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rm1wYWQq"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-39c8dbf4ef0so9825921fa.2
        for <linux-iio@vger.kernel.org>; Fri, 10 Jul 2026 07:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783695244; x=1784300044; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gl9mT3P5+btuz519aywW8mP891xmb+W2d22pXd2NmlU=;
        b=rm1wYWQqfe9kNet0YRksaxshVnFvKlMQqu1NqflcK2skyrb21qaVVlEVtzG1briICD
         jfsAHsqEKR6lzqSFpYTliMwS1mP/2MSwI6DuLIPixqdSwy8GPcLQX6aVNnwBCRBEntBn
         RQFz/n6OyHk26ucWOMM3DaZULDWe5Xj/Yrj7erHzBER4ZfYtOjzqmuXLo7DSmX5L12ON
         QxZ39XkG1BluztfCBNdaPHksd5i0htwpVjNg+1PAVyMc1kjyT2+XK9ZhA/ojARKBTFmM
         RVbWXXGwQEZT6f2/iREw18054rHpwffPzVY/G9Pu9zmwUN2v49WnD6m7rhQtKDataa8j
         Oh9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783695244; x=1784300044;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gl9mT3P5+btuz519aywW8mP891xmb+W2d22pXd2NmlU=;
        b=T8U3ubhiXqaFJf4aS7Wp1Pf93CBlglHqCxwavzpFigcuXBQkmOs827GDpLKBQYrJHo
         JpEMk1cuh2PwCxOD3PxteInS6ESEWm++2TKDd851qa5FOPia97yJcKEnXtqNdkXe5EJZ
         SZZjnNMgqmp9uHNdAwgtdbmgjoSfmZMlh8N5seXM5q6E6R724ZbhWQtFtrWlRX805hk6
         zHwEGizkhKLPAUEJlbZv3rIlNqrNdh19rsd5JIkXVb1k0J2bCHveZEDAZxPY1V5Dr0PL
         LXtw81R16xiHHwY7T5z65zvbC4ydoSehroh1HAvfoOW/ZLyYX0OZCSYTK7tHDNLiOP6m
         fSBw==
X-Forwarded-Encrypted: i=1; AHgh+RpMa2DzuLWrRrN72yZl4k8EXeifR6KxgRIt652oFDXbAQ8wp/VvLv6jfcD1BXKKFBG46rs+x9IHhfI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywa6dRu8HajdTAls84RuT+b27lJr0IJgMkaFAxs4EzubCF4VMwp
	q1WG47l+ap8F9Kwn2ZO+4eFZSJkQOWGI/eP6m7b1TOHxfos3miP56YEz
X-Gm-Gg: AfdE7ckOsXnoRHDLrsNrtJcA2bc5CUhsOtEf/vLkI5AR29ltAzUNCoJP6jP9zpqWUdt
	bFp5vf0CZOdZf0xNKtqwebxKQyffvOl4Rs5jGKEvRmP0G+7P1dDVPxio1dWtpUeW27eP91foIMe
	QKAns/GH9Gxsw6UqpfyLccS7swbGrQDwYAIfZHHxG29rMr1mqKRNuuKJWP6heo3qXjnYqNbazgg
	TO08iEtVZYlrkj3D+ZQrGWcdSMeTnakPSyKWvXOmuXhylGsXCfiSFIa1LOJM507HWxHZzwPJt/Z
	oHDxAELNsOKWADYP1bfzF9XiFIyRtnGpeUFOM/tmjdmty2JJDQcr6wASwy7o5aZkPLA8IUlOXwE
	OuMVCJzGkqvdGkAxXZzHGq99NHYMcYHPwVmVbGlQFw1RNCVDQDdY3wewsDNXjHy9dOGt3q94Mt1
	vcJDuvQlteZM6sZjUCxBabpat3f/td0fcLK3VSPOILcmKgskT44wgtc421POHaIgFfgenf2QSpH
	UXvbWyoER+40X2po0ZA7FLUnYxrQ6gjZVSiNEAJ/Qdl90M50y85/EwnjvUmII1gNSBfDzyKGKxN
	CwenGiiYcS8hP4SonPFz2nye+vzEu0lz4m+rrrQD1x0FGxTk2GGMCTaVWAdf6T+3reBbMhBG7Ie
	r6VAu75zURUt5ISCTFvopZsg=
X-Received: by 2002:a05:6512:159c:b0:5ae:bcc4:c071 with SMTP id 2adb3069b0e04-5b0113f95c0mr2985552e87.0.1783695243458;
        Fri, 10 Jul 2026 07:54:03 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b01caa60e4sm680375e87.60.2026.07.10.07.54.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 07:54:03 -0700 (PDT)
Date: Fri, 10 Jul 2026 16:54:00 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Yasin Lee <yasin.lee.x@gmail.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] iio: proximity: hx9023s: validate firmware size
Message-ID: <20260710165400.00005108@gmail.com>
In-Reply-To: <20260710142212.52225-1-acharyalaxman8848@gmail.com>
References: <20260710142212.52225-1-acharyalaxman8848@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 10 Jul 2026 20:07:12 +0545
Laxman Acharya Padhya <acharyalaxman8848@gmail.com> wrote:
> @@ -1058,6 +1065,7 @@ static void hx9023s_cfg_update(const struct firmware *fw, void *context)
>  	}
>  
>  	ret = hx9023s_send_cfg(fw, data);
> +	release_firmware(fw);

Why not move this after the if? Keep the call/retval check coupled.

>  	if (ret) {
>  		dev_warn(dev, "Firmware update failed: %d\n", ret);
>  		goto no_fw;
> 

Otherwise this looks good. Feel free to add my tag with the v2:

Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>

-- 
Kind regards

CJD
