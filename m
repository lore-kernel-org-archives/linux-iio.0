Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA88D3B4E94
	for <linux-iio@vger.kernel.org>; Mon, 27 Apr 2026 10:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777284854; cv=pass; b=An54kLjPxfx5nzLubxL0LcKPbuUmw031xRODpDogGO5z7NTDCXgjCDnkx272sAJv/XoK1qC44St2GjfVg/u1n8WKGrOhjEGu2fqLzwyXH7Nb6YU/oyk90egfw1mEvjwVb2d6gWraBz5zMkuOSbijYov1vLq7onrWVKanXA8q6IE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777284854; c=relaxed/simple;
	bh=kLVrbtGb3Z/jyJkvryAl505lEQveEhSXVdgjFCLme88=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dDje55EmxOayq7gDkmAQMIxcyjFUR4ikOf8S7aicsiuQm7XGCJZLADoZ084LByggsrNWEuf+bpgUdAvN0Oo+eEy3ug+ftKWYH7RXVEuMJLXv7hm/OCQuJzP2PyXNICYJfM5aSWVrcOyxP2wAfa0q+RUzU9y3MFnOA0iqn1l0vgc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IDagzM0R; arc=pass smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IDagzM0R"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-43d7645adbdso5485519f8f.1
        for <linux-iio@vger.kernel.org>; Mon, 27 Apr 2026 03:14:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777284851; cv=none;
        d=google.com; s=arc-20240605;
        b=cWjENZEWvk5lYxRTT+WidDGr1vH9Nm83ZYVwzibt/uK697La/PZve0BnJ08T7GKr9Z
         NO2bc7+IldHphjOOLcYoYpp7tELBl6afr6ZbMLDiMU6/CY4N+yPBaCUAkTa/h509Ghs6
         K6WfNzuN/cNLU58lyRJB6nKdgSdVlvFMNwsgMZoYG+rqCQj21uwmh0lVqmIb6D9fU+gz
         PWev+3pi5uSwJMThOeOxRGMcmykIlZ7THGy4+HWP7nNmSS6Uo1NJZzptPB90ferE/r9p
         3E3WXSDZ3b97+jBljOwemzC6+JmRadNUY6oaD+YjkBjtm55RhpmjcxQ715UPfTQLVwb9
         hKmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=3ticvjZqLK2mR+v/9BqedHeOGS58dg/3vZ7tEXWk/Z0=;
        fh=pSSo/U9geGOmxzc8cprWulMkmtkJzye6ggOXpFoIUQ8=;
        b=hFZwf6qVUT09Cp4Ebg1wA5HuS35UNt6bp7OdAPSib9fTB7z89zPERdqiK1j4c3J/5n
         MuqBJbsmBDc4GxvfTQefbkuN/iqr9q0FQbaz+c2l/Hmp60M83Zpa2yg/28Gz40fvMC6f
         fPQDOAMp5zug3QOHFLHY/G7JdEPv9Vlu4Qn2z3OdzCshg7im0tOjqmuAtZY5pOvsgur+
         2shrVRThDsB2PvNBoszQ1JMRqkS0euk/QRjDoxKy9d4oDSKDPAiNUJZaLSK/5tcFHygc
         Wspcs4qxjcOO6lhJvZ0avZ0CP/sYZ/Ri9JbN7tdCUd89fEANkLv0Ynh/1rk5HKBNtkfw
         9kQQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777284851; x=1777889651; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3ticvjZqLK2mR+v/9BqedHeOGS58dg/3vZ7tEXWk/Z0=;
        b=IDagzM0RaEHPvCl7BHvA4i4JnlrZb1aN0SWcdM7TH8beKOm5773TFpunAnwkU03tpx
         qGLxG8ddpjn7/ZjSWyqqhXX7V2LEafj44mOfGuYYMFYga4FEisyX3ZhUF+/pGw4jJYVz
         NHqq5/qLkoDjUJACNLld0+WGrrPHnXSW9U10uY1KbHnNjujNr3FPq7xQ6WShCBWIlNvc
         PwlwMK0Ihrs1leEmSK+6Cu55S+/b6H14z/umAo0qmo1JWLUVAurGpngvEH4Leuzz55Xd
         0tKyMKOTEd7vzW1Kjo9H9i5i2BuOcfeMb3NDzlASgucThLK0XwIoBhmo0BhnCR6hChDY
         WeUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777284851; x=1777889651;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3ticvjZqLK2mR+v/9BqedHeOGS58dg/3vZ7tEXWk/Z0=;
        b=lIzTYR/AGGOn7t5GtN1nbBnf+Lwc/xjAAYpQ5Jkn9zdKgXk9m/BtzBLTgnmjkbNW7E
         hutKpjje4JyHau2Q8yo9tLe+kVGhovMW+B5KuCtjYrvMPtFGPaCYum8W9BxEgu3G+WR1
         5kbpgODl0sRJaowqhDgG0oLceHXsGzHu5v+CJZhOrAX2hJfpvz+h+u6u0+6cVZGcTCue
         DRLOx+Es3t4W1/G6GlaOmANUgUAgHItGW8A5Mtpot61N0BhCc8Kd1azHMjD/JJiAByO+
         NylzG4ftbfEM3ZqIc7XtjPmfokLLdqZzFbLhAgvlDauS8Vv6YEwWsbp5KoV8eRRj2VPS
         P7Rw==
X-Forwarded-Encrypted: i=1; AFNElJ9dgdej19814uOUUv5fEvxPbAktrO4c237Ull26KA2SSMocsf7v5g4KcLYDcl9FpggqxB5+5hUCzvM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiDdkh2uWWKKV3yCaXPCDCuFp69x/s4zh+B94SgXpg+aA579ES
	Q5mDCzaMFaEj3qQ8DwJynkVCLfRMe7tcmyxRTPnPAp1t84Xfc0A1hzA0OvLrkIpB/qouAoWBt/t
	fy2/EO3US5D145Pd2VhnegsPANJnQw8hi89GWzVc=
X-Gm-Gg: AeBDietr2L5bPk4jkshQTdx5rwmKotJqdF0lQ6Pr5krfMQeZlQS+p0ULKWdDMhvxSnk
	VkIxFtYqDFM94VHl25v3FsweenGwCrnsUVrnLIfFQtQ5ob9yEh6nGL+XT40WxoexMP6w1qVBLtY
	Yf+6fkDCX4wdKHZcc+F4vXiXGwmwhGcOCzrr20YbV8cCkYRDpBj3RFLenMlP6Zl+6DS62hUEBK2
	ev8NO60kBqWrixV8mfuQwhwlk/GT6fAd/2mzxjvsSueqWHm75klzZGMcVaeWQMmd2HOCtjynK4p
	TbM05ST+gx67o7IRQh6KsddHzLfkY6cwj6YqJndUvmSW216LYKFnmwUEwdjN0TqRh63DR2GQM7P
	IFwWGMCkcgcWs+ejupD57AqhKha/AFAj+WTFH1N31wR6w86ycK3mOiDMVihXSRT8GKdxQBR/+Xy
	8iy5Uc4TF+2yBu/imK
X-Received: by 2002:a05:6000:2088:b0:441:36b7:7262 with SMTP id
 ffacd0b85a97d-44136b773aemr18082012f8f.13.1777284851138; Mon, 27 Apr 2026
 03:14:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427094313.81460-1-limiao870622@163.com>
In-Reply-To: <20260427094313.81460-1-limiao870622@163.com>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Mon, 27 Apr 2026 12:13:59 +0200
X-Gm-Features: AVHnY4IF3ncE_8wRUfZgZN102oO9nUajIRduHTjaXXY7kMFTGJeKYm_cp_TcZkI
Message-ID: <CALoEA-xjd9esvHZh_R--xvCpL9S16qw3iPmUnZBACw_fhYr-Gw@mail.gmail.com>
Subject: Re: [PATCH] iio: light: stk3310: Deal with the ps interrupt issue in PM
To: Miao Li <limiao870622@163.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, waqar.hameed@axis.com, dixitparmar19@gmail.com, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Miao Li <limiao@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"

On Mon, 27 Apr 2026 at 11:48, Miao Li <limiao870622@163.com> wrote:
> @@ -296,8 +299,15 @@ static int stk3310_write_event(struct iio_dev *indio_dev,
>
>         buf = cpu_to_be16(val);
>         ret = regmap_bulk_write(data->regmap, reg, &buf, 2);
> -       if (ret < 0)
> +       if (ret < 0) {
>                 dev_err(&client->dev, "failed to set PS threshold!\n");
> +               return ret;
> +       }
> +
> +       if (reg == STK3310_REG_THDH_PS)
> +               data->ps_thdh = val;
> +       else
> +               data->ps_thdl = val;
>
>         return ret;
>  }

Maybe add mutex_lock() and mutex_unlock() here as well? Just
as stk3310_write_event_config().

-- 
Kind regards

CJD
