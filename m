Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E612D0614
	for <linux-iio@vger.kernel.org>; Thu,  6 Aug 2026 12:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786020928; cv=none; b=XEggI/qU51efYA7aLCm5WDbad8c0AJPnJsHoh5Tbxew/8B08GD8ULYJr5Xboj24k1A8nz4KU6Vb8HcJ0nfXH4ZvpCVzAbDG6VK/S3Qwr73JQ0X7K3BkvhLurfWFqNSqRU/zjXspGvG8NxTtR+rs+fYtAZG5xfoFZnpsBJjIM2Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786020928; c=relaxed/simple;
	bh=aYkON+w1cvWz64PcaoerIEUwxylH1wQ7nbm75N5PQsw=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=Yzn7ZQjzDoV8VpPjuJCVn/DQwoDZFSXQZC479VVXr6td3wtOvpHfG4lbgmkwZd4/XIfbv05A82VqUlR8czMKHnly7BWXWcleA4NcNBGuT8kU92jdqa4H5Tcg/Aj52Bl2Qb583b5gXK2Ogl+9j5ow+owbI20lO1vXRGzNGEMvSmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hzF2tI9m; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hzF2tI9m"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c167aa9500dso301571766b.3
        for <linux-iio@vger.kernel.org>; Thu, 06 Aug 2026 05:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786020925; x=1786625725; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=WTmj5FYe3yse6KML3UCWlkLbz6Awba2heIHPiZBa1KE=;
        b=hzF2tI9mXAJKvWAWq5MDa0QL7CfZvu/3Cvbac1vX071TaFsM/qSiORysjk7bg8YO99
         S3r6mtbo+KZmsjXf1dTNa0N5r7cb6e7b0X5uFkeTT5/ACFnjD5c4Pg8iyY9r7+1FHGPD
         zLJzLRbEakdX3GoM+mLfBAbQc7cfO7XWJarS6+OCWzJp4ue/CtkeDO2FgDqnvQa8QHz1
         tUDSPa2Ci823EtwqC3rxn0LtRz5sT5ZUEJRp+67O2WXxvSRt4cdRuZUzD+Ryhox4vDbt
         OfbBjqvX+nGg140jKG5YCts/WTpxAkQjDUi3MEroyEteZgdgYrwAUM2pY196tYkdfgD9
         5jFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786020925; x=1786625725;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WTmj5FYe3yse6KML3UCWlkLbz6Awba2heIHPiZBa1KE=;
        b=J5K7U4+cgVpreOrgU7M0UkeoQW13fBcqMBdVfSBXddhsPoqWFagXg18duivqVYcST0
         NivB+3T63PHS78iewkok3UAoGRndOyoP4JMisLhfA+oC26lcGCubaxCQbTZmg0qSZDWC
         gTe0m/8u297zq6WmIii67yobFxGQZrEVJJC3We5DfxKj868CvIBZVAtnUXO8Zx/jRCTP
         nQ5/vIUjO0b16tCrB2reO8U5uWzDoI2IGFb/SMnOTyfgGJfoT71ThyJ0qmVdySVlJG5I
         BfI7tHFriOq4mcBiDeIZk7kfnwws0QQoFJpRszNlZ+IR0RUCJvLRIr2oxGWCdg9xzwhL
         LNDg==
X-Forwarded-Encrypted: i=1; AHgh+RoWQvvpZbPWKVIhqfrF/1n9uPF3ELvu9PFRLhK0ydh656BWUqmYjfKF+Ic6W3rXPq3PLm3x4mvJLtk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0NSaTcUcylOzC37jkzSb5Lqp6vc39vvW45DdmPXc3mojD/7o2
	WhCnjImNoHR4UZnPqMa1dOKd5l4H4UoFJm0CnnWBYQxiIS59uETMIWygyD+I8baQ
X-Gm-Gg: AR+sD13wFkJyqxlCTzwu0hp1N6Vd8a/qAzdG+Sp31fyQHOHixDemOkuRZFW5s94cCKw
	knao///TDbOUmSRr7Es9jd0jCsv7xJbhnZ283cejzhCoNngop467Rd2SFIlI3gceraQCwj58iwQ
	YEiUQp0QcxNCNscwpRxQ6YovBBJ+FN7VruvaS2J+Qpfch62MiYGUfKIJLlBgOIX90XzAf5f51Fa
	51YERDcAEO6JebKXuB7lHmC9B5ZdCnCevZ7+S48yEYihhgFa7odOkBak6UA/1vuLv+1DrKmWy5H
	4byDijfKB2Q/YIc7r/RojP9nYhyzGTTcCe//+bF/lH9Z+mRcYqHkqTu95xl1VI1lckmgAjU/raf
	XFuiRrSHN0R3VjuoqL+K+Hred/8lFfIcYBXMsIw5d/5WqLlLKBew6phPbzcDyX0fFen3yDypqN/
	bgcPHKu9ykMAAWUxqXD2pG0E+MEHqY0cV4gvGEm6vypJWx5H2h3pgAyAI=
X-Received: by 2002:a17:907:398c:b0:c12:b2db:873d with SMTP id a640c23a62f3a-c2039c03328mr804230666b.5.1786020925435;
        Thu, 06 Aug 2026 05:55:25 -0700 (PDT)
Received: from localhost ([87.129.199.250])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2036276e58sm252606166b.28.2026.08.06.05.55.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Aug 2026 05:55:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 06 Aug 2026 14:55:25 +0200
Message-Id: <DKHVKU2TZOGF.3D3IRM9JEZS2Z@gmail.com>
To: =?utf-8?q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>, "Linmao Li"
 <lilinmao@kylinos.cn>
Cc: "Jonathan Cameron" <jic23@kernel.org>, "Maxwell Doose"
 <maxwell@maxwelld.cc>, "David Lechner" <dlechner@baylibre.com>,
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy Shevchenko"
 <andy@kernel.org>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: flow: slf3s: restart measurement if VDD disable
 fails
From: "Wadim Mueller" <wafgo01@gmail.com>
X-Mailer: aerc 0.17.0
References: <20260805110255.504576-1-lilinmao@kylinos.cn>
 <anRUF3ucjK7n4iN-@nsa>
In-Reply-To: <anRUF3ucjK7n4iN-@nsa>

On Thu Aug 6, 2026 at 11:39 AM CEST, Nuno S=C3=A1 wrote:
> On Wed, Aug 05, 2026 at 07:02:55PM +0800, Linmao Li wrote:
>
> I'm also not sure about the above. If the regulator fails to disable I
> would say things are already in a bad state anyways. Is there any strong
> reason to do `slf3s_send_cmd(sf->client, slf3s_cmd_stop_meas)` before
> disabling vdd? I would assume that without vdd things will terminate
> anyways. Asking because if we just disable it then the above stops
> being a question. Though I do understand it's better to gracefully
> terminate things. Just not sure if there's any added value for that in
> this path.

on quite a few boards vdd is tied directly to the always-on rail, so there'=
s
no real supply node in the DT and the regulator core falls back to a dummy =
regulator there
regulator_disable() becomes a pure no-op that always returns success withou=
t  actually removing power.
so we can't rely on cutting vdd to stop the sensor

Wadim

>
> Just my 2 cents. No strong feelings so if the driver author is fine with
> this, also looks like a sensible change.
>
> - Nuno S=C3=A1
>
> >  }
> > =20
> >  static int slf3s_resume(struct device *dev)
> >=20
> > base-commit: 0efaefce4e95a3331550329c0078b2fb38b3ff1f
> > --=20
> > 2.25.1
> >=20

