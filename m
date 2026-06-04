Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F7F3D6690
	for <linux-iio@vger.kernel.org>; Thu,  4 Jun 2026 20:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780603741; cv=pass; b=RBurUWzAOx6nnlpN6RJXDun3gtYGSWt61mvg74OhpEk7EZXApGZ4v1DSbAcqrysH9DfDvY/MLwwaaia7qJszvGKSF7GLYM2xFkL6CRgHSooyhBUZ5ls35v0oMaYQhtzyYuuGZYFK8xjiIWpwvEpi0aHByREcI3P+jx59E3+Um8g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780603741; c=relaxed/simple;
	bh=/soW6BEPfrOeKA/nsKv4OoTJanbV4JKjESUCQeexEus=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GvSuWQILlaTPZ1bQjkYRA+yt/YM5I4eZaqVgRdKv3LxW6J3AB6mDCMv7PJ7VUjdmKMousKhGN24gHckGcWY666e+WULiTt43hbZuX42QUNGUV1Cy0WH22Xl/F/1ozBEt0Mw0stMdsAyk+rlm4AGTM01uUzNMBpMmFBVXePhknyw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aBbGtWqx; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aBbGtWqx"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-68f36e1663cso2203553a12.3
        for <linux-iio@vger.kernel.org>; Thu, 04 Jun 2026 13:08:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780603737; cv=none;
        d=google.com; s=arc-20240605;
        b=SH4nJoaAgnrRMscmUwcNXIudgU3Gzrj9tO+mio+xV9mFSMp/XqY8k+oLbYtinjysvs
         kgspIr3MFbb5UaOEVWQ4Cq5XS/l6pc7iIttpI8tNQPnOg8zuvTCn6s6+rwIqqknE4GLU
         QoFjpd6nxhjMhCNe6j15IQxDBhxtaVaw8ggx7aKIcu5Pczt0sHSuzOZCjteyWyPHRXBA
         FIGw5WbAFfVbe32CfVLL5hl43Vt6Y3Ygzc3PKLnrtGiXzrvKdJ4+DVG6RzZPwKWpX2cB
         e9yhz2JEF5iIyTiMuHJ4NDoHJmpZEfcYdh4riER04TQknLhsWw3A7EKzQDtaVeWXpRck
         k3gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=As6cI0xJmfFIjfcHLl2ewQP4QW4Lwd77NZvCltE72AE=;
        fh=Ow1+uLNb/1fFPbdrD+Tt+GrShQIFgRMnDQ921d1ABkA=;
        b=aW0GzyU9XJtgbGD4HiGt025eMZPZoq6ab05hVxv0jn1uDzh9M1qp5o5ey2dYf50Fuu
         EUcpPQiju78uarM7r1Yuoiv/0rZfavLoUEmIbHmemVbQJ0YuNX5rN1Sdf4t9QoyXsvLF
         hIqVTd+K4gHlXQqTtmDTGzUUqZkjdnOCWfnni59zkyBh3j+LlPgEofHVphYmv4aCWlJD
         zmbqXi+VAvtM45IqXmz7eZpBMf2+E0odaCM8gAbUqWkdmih1Vbn9sPgO3DoY/QoFuDYq
         64jOxuG5fkvyzSLmhX2+hvEpDgbh5LMmG2gMPK/Hdzuq1DsVmTP+pfjfJWPgp7xFd6BJ
         mH4Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780603737; x=1781208537; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=As6cI0xJmfFIjfcHLl2ewQP4QW4Lwd77NZvCltE72AE=;
        b=aBbGtWqxNApv6L8b6jEXXGjEEXu9VcssODPzo0iLQnd47adRhKKt3UlWrvpOjUwADw
         InNGdaEkbxlHhN4BYGtWlCLM/EqNKSaegwVf+8KHrMEdIhsj+PY4nStCYDbtVZb03WTb
         CzHST5Muhi+3P1GtvgNNIxMgobJ6VraLZa7VL55WOkC7Bi89E+O1XlH4SlLmVDM57OVj
         qWPDfwo4AFmL3Dl4nl3FRq6JITxww3n+NMfHI204Iay4XtKIWLxVoSsFlBYf+Pcaja2s
         axMKKDiL9Ib9Z3C9sMHQZ9XfCYh2yVSpnAa28penQSRvL/jlH12A0Yfe3ulkAr4hAGMu
         7+DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780603737; x=1781208537;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=As6cI0xJmfFIjfcHLl2ewQP4QW4Lwd77NZvCltE72AE=;
        b=qKtnTUt89m9UG9pFdv8iaGNexq1R5nlS/HXzprcppz1leQKl1w3dCH4ddBQhYlDjTq
         u7JP+uPl5OwzI/NzP+89NVWVLDB7jHzx6VSQuHtWBLr1ZhzactVHonvRWWCigrNrX0w2
         L1N9TJWq3vbPNkwWTazeQ/1aXjCa4sQKohnH7EMcaAMhgESe+qgFwiK0QKHl5u9/hk4i
         6t2B51Tbmg5zJ8s44iuBy7bq1Nkl3/d+2HzkjrzzABqzNwkD6glUaIOB9hS7IyuQzQnO
         DkSlWH1vGlrZFV1m7k9Rd0A2IX2Uml9gf7R9iwAMBb2bR30vdqbIkmA21hiVCKHGwCFV
         uudw==
X-Gm-Message-State: AOJu0YwfhSce0p2lEUCLYtu8M2efSp+4jo4bnDpsjhxQd2c3NhPAUt5q
	XVg+kjQGAElZeOvj8l9hD4PIFgMfewLpIr7ltsEhJlQtBLAAmrDgSxLp5ZZ69mZ7jTWw7WvCzrr
	0FnczXDdB59Fcs3sl6zUbEZp3z+1d1qk=
X-Gm-Gg: Acq92OFSs2nfEfWAQtqj8q6xPOwx0fQEpwQ/MeVNzNisjlZJPjhcQszFsTs2xWTaZMM
	QvlfNF9pAVXc7zrhTgdNn+uU5HLoLfe2S6ei/ZYb4pkBjak9rLwPhR2WX5+7CesE4FWC++gAFZ8
	dXx34AKmyPy7QDwnHQdA7m5F6KVPCUVULxQe1IKfXf8wzssemW+wTSlXj4vosZQTvfZeTC6Uu5L
	dqee46HqYqzZ6fUQAMN5v5z5o2LA6u6AXkABTrhbX/rAhECScVVt7RHw3Ox0ut5CIQj23Oxp3Kn
	b6oJegMZ5akvFmZ89h1h9zOPf32ifv+/2bgM8ZhnmFtpZAwIaroL7GCmIpGlRjl8+8u+VavsJJK
	xveMlCsTeEuAeDZHnAYkXBW7LokqSDfl79mtOmaEjRqCG3pkuVB2JMuG7oxcZ84582yIgIY7XAH
	Vds9I=
X-Received: by 2002:a17:907:c70f:b0:beb:2de3:1ba3 with SMTP id
 a640c23a62f3a-bf370379589mr13347666b.2.1780603736721; Thu, 04 Jun 2026
 13:08:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260604120201.116925-1-vo.kratky@seznam.cz> <20260604120201.116925-7-vo.kratky@seznam.cz>
In-Reply-To: <20260604120201.116925-7-vo.kratky@seznam.cz>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 4 Jun 2026 23:08:19 +0300
X-Gm-Features: AVHnY4JXzP3mwf8Q3a9RtgDYoteo-Nofo0i6eByKjDXT41BcdfxJeNpLI0AyVLc
Message-ID: <CAHp75VcKGfzQePh0TzsNBKPjHxr=ey8uO=4_+_oaioSNKkS8_A@mail.gmail.com>
Subject: Re: [PATCH v2 06/11] iio: gyro: change from %ld to %pe for PTR_ERR() printing
To: =?UTF-8?B?Vm9qdMSbY2ggS3LDoXRrw70=?= <vo.kratky@seznam.cz>
Cc: linux-iio@vger.kernel.org, Rui Miguel Silva <rmfrfs@gmail.com>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 4, 2026 at 3:03=E2=80=AFPM Vojt=C4=9Bch Kr=C3=A1tk=C3=BD <vo.kr=
atky@seznam.cz> wrote:
>
> Replace numeric PTR_ERR() logging with the %pe format specifier
> so that error values are printed in a more readable form.
>
> This change was identified using a Coccinelle semantic patch.
>
> No functional change intended.

NAK (in this form). See below why.
Also note, the same applies to the similar cases in all patches like this.

...

>         regmap =3D devm_regmap_init_i2c(i2c, &fxas21002c_regmap_i2c_conf)=
;
>         if (IS_ERR(regmap)) {
> -               dev_err(&i2c->dev, "Failed to register i2c regmap: %ld\n"=
,
> -                       PTR_ERR(regmap));
> +               dev_err(&i2c->dev, "Failed to register i2c regmap: %pe\n"=
,
> +                       regmap);
>                 return PTR_ERR(regmap);

This should be simply moved to dev_err_probe(). With that %pe will be
implied. Also it will save the time to move to dev_err_probe()
directly without any trampoline like this.

>         }

--=20
With Best Regards,
Andy Shevchenko
