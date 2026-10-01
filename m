Received: from mail-wr2-f34.google.com (mail-wr2-f34.google.com [74.125.225.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC070476684
	for <linux-iio@vger.kernel.org>; Thu,  1 Oct 2026 07:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790838651; cv=none; b=auLvGnEukemK3uOtFW+I7O5aF4JR7Kk2NKLidQ/F+5kzcbtVeb0x5Qcp0BI9KPmyqbS9PMc96gm+rpwe2G7qQWXG5VeXMkbo0wyt7L6egJPU7ypYc0q5R0bW/rPowLwgZzs84aa+IQVjhvO7XQHkg80Ne5koRsjUFIxTDGYlnyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790838651; c=relaxed/simple;
	bh=Iv4M5crlHvDjmW2HZr0hScIJlR7oG5vccxpwEJd6NaI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jKqmtXN7BhAen/+ava1ptBk5seAQNRwTjVbjOWxlfTkNSL3zBSx1+R00vAXzDKvFW2oPuR7anF6+sW9sRdHicN10wGUh1RejQYJKoxHG2pNJsKKNfhV/MSFIGHw4mt3So6f7Y7mVLCh3tgFsqV76F839j2qr1m8Xb6cVl5IWTV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h4BYTRtG; arc=none smtp.client-ip=74.125.225.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h4BYTRtG"
Received: by mail-wr2-f34.google.com with SMTP id ffacd0b85a97d-48afd5b1678so896130f8f.2
        for <linux-iio@vger.kernel.org>; Thu, 01 Oct 2026 00:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790838642; x=1791443442; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fR2joc6EXlPj2tJlUEfZeXdkIMyGc6pqdS8NyNfp3tE=;
        b=h4BYTRtGghkuAo+HBw9s783xPfe4EHSip4IL3Mlj/q5kSgpAlx3/sYtlT+IEizILkY
         XLVFLPOgrFxMGraD8mZ1f+el0O+Lz1Xy2FtFHOcyrCaOqldaGTOmCtGltMCTIZvlypd4
         gQ5J0xk68OtbdFVvReF6ni2lSb53kHYthmXiL3JlZt8Gzl7twfdDxX7tizJvhftC41T2
         VFe6ZEdB9XN0tNPhybxkCXpmLbY28T6t8sItAeZEFsJK+2IH6SIwwf1JX2LalG5nZLul
         OI9l/ZObqhsHfyx5oPCLIea5LzErs5B/nZwoL+QJrTaXrJQnP8aLbPVLGd8MErc0VBx8
         9XPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790838642; x=1791443442;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fR2joc6EXlPj2tJlUEfZeXdkIMyGc6pqdS8NyNfp3tE=;
        b=pvmf9Yb4zVjCUVeCCf2YXA/SGLJbR+vofQXZa4ly/w4uzuJEF2uyCUXwBXj8nM7vLy
         NKBZSxnmK6Z72NYaDYMSs34yMDu4Dmmmjju3Bz+Tb9exz6UmjBbrwcctAw3YW+puelv2
         kYkP3k7qu+0XrRM7FpXJwLD3Hou2Y5h4ufF1SVJqHbC68BMcfseCeVvJhJUXGwkO96x2
         mj8IRShI2Vj092OvRXF+Mbn6RWLKzz3clYEZrmiULq8NYK1/JhTdRPcmhGEuJ/lMKRSU
         Ge+cWNhp5MEpsyB768oRXbj37cIRFMnudlT8/qgq3wf0TkVlw8NLigtXkAUzJobQs0K9
         idhg==
X-Forwarded-Encrypted: i=1; AKwUvBya9B4Vn2+grzPPu0fz553w3/PxW7SGRs9FGI+S8ZW33dKbM7FsFnt0m76odB/ZoD/PB/YsJigjiRg=@vger.kernel.org
X-Gm-Message-State: AFq9FYKf1IstElgCD0KSSYg9ciJ1WZKzMBtIwL0UDKvUtw+xiOMnQ7sb
	XxZfnkZmPVi6akYpA3zNJcuxj8DcC8uDEARBJTjjrGT6s9Rf1mwX5AvF
X-Gm-Gg: AYBFou2Vzp6+/SA3gpIHWVP7LePZEQyBZ1+sEqBEMzTvghOFlRVKacQAOTYlwyv/uNB
	vIW+5Rs4do4O5YJYhKwpOVOG6xZCLheGm8K3Xanp5FPphoB1RN7vaSUDsaY2mZ7juRGrIl8NKdx
	dy4Pug4M1sogXrvOO7N7P2Lm+kEaDUawGcQ1l9gAY1tRqDKgRNYJ7It1KJQ4PHmYNkXFrNN8zOj
	sGdi5xMbmrgEyFkJSEupmD2F5ev6UVsLIKNi7NM9RHfp816xLLsqnHLOpvZLPF4qaY/+CgYrO96
	4ZSViefusG1ToVAsNkGiuRMtjDwSnB0JFmeSEklLG4bch6Tm73H/mri97zHzLc8ybULVz2xX2Tc
	191GCfngS2CaLSwTXGw8BwG5bKYTIhzS2TI87xlhGTLS8Qidx1SFXCflZ9442CGnIxlDp12M3ON
	ZjJ8gI03NJ8YyfMgQMkZP/B4ueDFJVa2/46NLRUcdjamIy00jdMsvYXYH2VLZAaVnVywXa3N+7G
	zxLvnbSLWn8HLZImx5GzinWA6eNSpZi1FLg/Ky8Ubf8ZyWeRAAIgesw32yYdp9vT6e7EUOGl9Gq
	tp9KVil0ISBh+uv5IHGj+fT4JV/2goCcVdHsqKO4x9/U13KIBQ5YWwANcy7Uqm+HgByhq65EFpM
	YkFQFFpCzjSx59ppZZ02DMr9QfbuTez39Mqcy+PI1pFcKZv1+hLyoqM1PqDJFsc5+cQvok/M5kR
	VJZGIVOiLHnRrKcoA=
X-Received: by 2002:a05:6000:2890:b0:487:27f6:a4df with SMTP id ffacd0b85a97d-48b02538519mr6466998f8f.47.1790838642433;
        Thu, 01 Oct 2026 00:10:42 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48b068ff6f9sm4954333f8f.7.2026.10.01.00.10.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 00:10:42 -0700 (PDT)
Date: Thu, 1 Oct 2026 09:10:41 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Archit Anant <architanant5@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, andy@kernel.org,
 nuno.sa@analog.com, u.kleine-koenig@baylibre.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 05/10] iio: adc: ti-ads1015: use dev_err_probe() for
 error handling
Message-ID: <20261001091041.00006430@gmail.com>
In-Reply-To: <20260930171204.12863-6-architanant5@gmail.com>
References: <20260930171204.12863-1-architanant5@gmail.com>
	<20260930171204.12863-6-architanant5@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 30 Sep 2026 22:41:59 +0530
Archit Anant <architanant5@gmail.com> wrote:

> Simplify the error handling paths in ads1015_probe() and
> ads1015_client_get_channels_config() by converting dev_err()
> calls that are immediately followed by a return statement
> over to the modern dev_err_probe() helper.
> 
> Note: This patch takes advantage of the previously introduced
> local 'dev' pointer when converting the legacy
> dev_err(&client->dev, ...) calls, avoiding unnecessary
> code churn.

This paragraph should be removed, no need to mention this.

-- 
Kind regards,
Joshua Crofts
