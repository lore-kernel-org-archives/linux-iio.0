Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41413B0ADF
	for <linux-iio@vger.kernel.org>; Tue, 21 Apr 2026 09:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776764959; cv=pass; b=EWR6lfz6aqCJaOzFfMt9Rbz0qo5wEh9wzTkj6spo+piEOy9EdRNiwqM5oAAUfqKOsZIIg1G+9OU4MXfExuzGAXtXxc2YuNIY5PzX6HkKEYCniIqI0h8VhIHw5WHyyidQgb/raN7G6DYJo4Yc7EH0IHQzDj4pSppaNIDWVozjz1w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776764959; c=relaxed/simple;
	bh=YXy/1+WV5O4imXKlloP9TggNn7W+ZDz4Sg0HPiawucY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KAQE/fpFibxHlR1CGoRgkTdISGt+43J133d6f6CeErUs5VOgKh0bFiDN6E59/e7WwfPY7vdzRCCfmkcgrSLIlZJ4rj3aLe0aWkDqLwRIuVfn1yzAcFlZud+TP0iZliPi1xzG7LyrSZ09xGkrgr/kyckYxEKWAWv7prpL/g7Y0r0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NtenQqU5; arc=pass smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NtenQqU5"
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-12c750eaf4cso127269c88.0
        for <linux-iio@vger.kernel.org>; Tue, 21 Apr 2026 02:49:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776764957; cv=none;
        d=google.com; s=arc-20240605;
        b=UiK0wCKvqLMrVM95Q5oxfGAyn9g0o3JdgwHTgEdVJxZvVr3ScSlgcS2CBjErkPxTok
         wS9mWs6nk8u62NDqJ5MQyMFcsnbMZ+/l9ajLCKGdgKMfGw6X554FLyI3uKgS8t11VzIh
         KHaY1J4sVx20l055ZkGf2gvuwUi0mFZSaUEN6Jza6bjqwT8z/BTlaDcRRNBKMfD5LsSz
         9jcDNrGK8cvx+jRx7DwB2A4jBxv2R2Ujs6lT934a+iRvNvJTvNpU6gkyp3rS/9ggZWp7
         7gibmMbep4hGpnPn/w8OrpFhUIvw+WLzMk9/J5dOkJdxcNYmTzWA/g8pNDSwqBrdusZx
         NsFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rcIuPWx+5GLeMldNKEJ++icQE8nEP0msdBF7TbQJvOg=;
        fh=qhr/cJKAW59o58vovl4GZ5m90OAnPzVpQiXsQbC3Ta0=;
        b=Ulp403a2vO4sZhQf7jr+FRfXsRR9wd2zqMqCRP/Nul20C+GG0dxkFMmpyj41Ej74X4
         ThPqUzCa0iTJK3vIP8svyqKRnmXVzSXKk08pI0Aq29zjLsVhziRq3HRwMezSs53svs/u
         fJUxp9fIanC4DjK3OrqNfZQMg5vRQjcP5l39mkqmpfZKjF7xURCPuPm6D5/DmKRhGKr1
         bxkqje9W3Eng2Kj4hLPj4M7gUdFNZk2FJF9phnqSp5wIy4gxVaFXlu3EOBsWfd9NABjn
         QG5rwsfEA7gEOwL7NAGhRh+voDg4p01szX3jB3Uv1asfIKMB5rPXGUeHINbm5tWPDQFm
         k39Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776764957; x=1777369757; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rcIuPWx+5GLeMldNKEJ++icQE8nEP0msdBF7TbQJvOg=;
        b=NtenQqU5UoyWqKUh55GXGO+I7P9MK2dCEBtxRT+/zbb6SJlQGnC5Hl/j1s5BHEykrV
         G0X+w9weknHr0V9bKTSWWOBCa51d8qRT942FXES//nTW4elZpWt+gkjq+mcvDcZA3zAh
         mZeiZb7YHkeUmcmQI1llToU/qJsuS07qgpIRNnw4Zj4FPkzW+IWpdlwVyymMleEFrYdr
         OVcebvAwt0pFt775pgw9alto7NCVJgqpJtEtI2Ic+VEZMuSDoxIBrhxJCqYaUxL99sU4
         laSs0ZlCpk6j3Ui6LXc2dOgelqpQPWrCPhPssjn5Tx2ygzfzN9jGFDt/HDVnc2VrGk17
         zEog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776764957; x=1777369757;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rcIuPWx+5GLeMldNKEJ++icQE8nEP0msdBF7TbQJvOg=;
        b=K9nCb08YJ+xFlQ9WiaY7jNmhRXemaoYwhh5agD1XwlpLqH6tMLTnqIbU3PDOudEcSF
         kx+/QDYLG2AvnIwMEy1uALu+LQI66s5boCK/iVjztBqRSudFb7S+vxFDyGclJ42F1UNI
         Z6TPIJ6GgovIKpADFhnC+VUmgOhlvYY3hfh7dV5diV5wUUQuHtW4WeZcY54UkcQiXE1H
         mPw81wZqAuu3R5Tz9UiYs0Eh1jAevJDaQoPaAgDyb2kdpHbTDd885xF6CRFDogxZiBMU
         0Zonq0XNjKzO0VHsPBb1hbi3iQPMBco2R7LhAd0sHfRdHwzlLv5co6XYpB3oH2dBNYSF
         iyKw==
X-Forwarded-Encrypted: i=1; AFNElJ+UQVapztCo220eBhBs1+scA0Pc8vdbgbOat8Z1Ywnt2RF3SQQm7piT+VFtUOXQe2wrsRqgoLuXcJo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNAel912216Ve4PQIvc1y04hbz1cPDX4frySzKMoIUArj2Uf0B
	0cor6FByuo2CNuy5KG3pkslDt7+77QPxjOiIotfrzccxX349CfgTEIkfFe+1hX8bwzRc+6BYFNv
	0/p/GHSxCTPzlFn3J77+HnenURAta8Qc=
X-Gm-Gg: AeBDieunIf0R0+uapP0tM9FWDVvVbIy49F2CiVdIQfomRAbRnNzKWS55KlHTngMSTTN
	2JiWPeluDdul2wynToyX16YJ2MgHNLjtwhFpSTSNZRPOVBbPnJNFE5iJktyUOfju0Al0l9k32S+
	7fUswrukTS/we+fE/7DR4EE1fekdYpE7dYwndr34DqSX1fn/NVHcujSQt/tHeR0xKmEDrWpjJ4Z
	phnLnfuZFld6qaxYuQPfObc0oLVF0SjL7Fg35waHkvItfqZ2XmVRjf1t9Cev575I6suFbzBofDI
	x7yyB1CCj3LECEVaWffKtTf97r9ig9fRvpieqOhoVSGK4UTrdPRD3DQtBmQbXEfYVMuWVC9/s0T
	ivuj5+jKHuw8fLHxaB8EUr+IK5gaZ8AzeNwDBXGxM5zKp
X-Received: by 2002:a05:7301:128d:b0:2dd:5641:ef0 with SMTP id
 5a478bee46e88-2e47930f7b4mr4083612eec.6.1776764956745; Tue, 21 Apr 2026
 02:49:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260419151327.26306-1-muchamadcoirulanwar@gmail.com> <20260420193320.22df4979@jic23-huawei>
In-Reply-To: <20260420193320.22df4979@jic23-huawei>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 21 Apr 2026 11:49:03 +0200
X-Gm-Features: AQROBzDAAzftt6pbRJZemN5AYHUZ7t5X_PvujovlzEk77pQ5L8tWWRpcKeKc4uc
Message-ID: <CANiq72kKkRW7vwYKi38dvsM4HCtKGwzOF4ujMS-X=peGb_Vi3Q@mail.gmail.com>
Subject: Re: [RFC PATCH] [RFC PATCH] iio: position: rust: add initial AS5600 driver
To: Jonathan Cameron <jic23@kernel.org>
Cc: Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>, 
	Miguel Ojeda <ojeda@kernel.org>, Frank Zago <frank@zago.net>, linux-iio@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 20, 2026 at 8:33=E2=80=AFPM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> Do we have a rust equivalent of BIT()?  That tends to be easier to compar=
e with
> datasheets that don't use hex for this.

We do! Please see:

  https://rust.docs.kernel.org/kernel/bits/

Cheers,
Miguel
