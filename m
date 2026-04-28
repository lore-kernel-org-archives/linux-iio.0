Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA233FA5C2
	for <linux-iio@vger.kernel.org>; Tue, 28 Apr 2026 11:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777375138; cv=pass; b=KlcJwjEMqzW4Qiz423WjiETSkAxU3xVRW3vP8RlheZkyNkGoX9f29wSq1JZeLHjOGM3+rlJ5BP/n7adUlNtMRmbi1nljDf1Y3rydaqGs7VkbF/XwClycnHYPRENkfN2fRitEWqDFTVFRlcV49xLPcIrQCFUZwyHA8P0dJXrmF4Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777375138; c=relaxed/simple;
	bh=2t82ydqDyieTciMsYYFVm0amP9/b6az/aZB0xzsExhs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QLFJUtTrFHU28NI9JhptRWnRxz8THzris3oheJYLFqRNIcsekSvIuNd2vlYyIOfoiDpOi5Rn+VU0ob6eFZ2wa8a7aRo2XmKRVZg/cjmTz5fmUSuyewlq0XsCJX6WVlXQL1rPe+u3kM6raq+x/egGgl14zKPHId7CNxHmkefFbeM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hxQ0kY0k; arc=pass smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hxQ0kY0k"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-651c366f7efso11343069d50.1
        for <linux-iio@vger.kernel.org>; Tue, 28 Apr 2026 04:18:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777375136; cv=none;
        d=google.com; s=arc-20240605;
        b=TEPNDoKZhMi7DLueWsYH8BAyR2jXPShz9CindhtxCCra8uZcBL0qb9/9bgw4OwIOmY
         1YU0B03yAhxHyJJZFS5YHGaNkk9KZJ0+q33gKIZR8p/fkb5ig0gjj4WFAVD75hrVVw1N
         miF/noPE5zxdd8y3EEJIuCx0yVuAFW/r5Y5F8rSzVLlBnfeOEP/y2/fp6sHAYlWsR4Is
         8k+7peZC0nRe/SQgZbECp661Vklwd22YgfmjIrWmpmvg11JnhM/CaW9NZDoLwpXUUOB0
         dnB/QmsO5I2AgOXxEev/Kk+Eyq1+xu+NFGi0fJct7/DE9n10gs90UvP8+vBBV/xauC08
         1vHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xtPQea/2DwX3/4//+c4wgD58p7NYpBw8GZYp0J5uGSs=;
        fh=bqSApQTRLdWLVCbB7xmxreueOsp+I9d2OQOepLHoJXk=;
        b=jeLf8pvXly1X8+nToLSgrmM4tuXhJLk/olJBBK1x/J5d+a6TfOUQYIqag4hCdToGG9
         Bk8DnbuzxTzh9MsvQgIqz0wxlVW/bFqkS5eOgTAgcOimimQUOFwninuGKmLeUw41zakx
         py6dJRF+6/G6Wrp9dO8iXgwDQjOckPuZd5nGRNUe0pZgCV7G0xrSmeJetFzjmpmops4+
         jjpR6W/P9hXn4SVE7g8a17eztAXNxd1Dc7gyhbb/t6LqsvkmU0WVesgwJYjjYyaenRvU
         r0Po+aWVruGFlbpATWAQgkSmox7jgFuBQI1JGO9afhpY9HrJAr5ofKUELk/A0dplz5fp
         NBRg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777375136; x=1777979936; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xtPQea/2DwX3/4//+c4wgD58p7NYpBw8GZYp0J5uGSs=;
        b=hxQ0kY0kRmtLwANYcbK2wzXExNG7hNp+x0Qyl1uVn2GgEJSjGL39SUMcS4JEsSR/yK
         4f2PjbiHvNSzNM25XtHA3yz81GPwdTUGyeknQWDzUEMK+m8E9E97t2zOMGG3ZrxFUB7Z
         4GxVVgJ7f+tUeyx10YhNcUEvqU30YgH0zod8e3bgOTzBY+a1xGO33MggWELK6+dG8me9
         bnwGGbusnbnVpXXJOmJgocEC/LhD0WdSd6REClq6Cc2LClfcCDkvbmZ1yuhgcprsqbxc
         TQijDWPoRE/XSupaThao+VW4qXs8sb3hSz4EKRJZGlsZHprPQifuNNzFL5IX6TRD7dxu
         GYTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777375136; x=1777979936;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xtPQea/2DwX3/4//+c4wgD58p7NYpBw8GZYp0J5uGSs=;
        b=mU2Hq8qIdySryaasvRjy890qWhWQ5J1y+H1QKasGF8j5atqSoa9y6XBdIPQWRQDGkB
         X/fxdXt10IGqrzMAtttPfGpa0iiWHYJI+gT1yc7iJDmgZYJpG1cAtbxOhSBKbFCtzqPW
         TcixRWDBqxrVdQaPTsT/XsYXCfXsY79F5Cl8eebiC9e00qknQ+EruYNSq0lE6OpL4auO
         Kg/PKJODfez3x+FBZSlAQJl0Q4gpvAG0lw3t7EHT2maqeJq/nO0yKrz5nzfbJAvXwXSl
         seBG9eZErlI4a2XcyJXu4us6Z5CEg0Td2dp8KXu/wtue/rUV6kU3A2wYlpy5DYn76pBk
         NZZw==
X-Forwarded-Encrypted: i=1; AFNElJ8qimUExR3BKptChqWZ6DqueIP1QFiqARlVTxxWOWC8HT9xssodFZ/E+yxFxBVB7v8Ela6qYXxaULY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywo+z+29hUVwLNAau/9v0s+Lx1PK4wpIGnyzjOxvKcgPmdAigw5
	Ep25m1q71PL9i/eqYlPk8d7NBsVv2M67gdOywyJXIU1L20Hxgm3xpHUpPQsO0EhcGe2BJ2OCm9j
	9BqKaJYuYRjf/d6N3pic0bpjOlWKvD9Y=
X-Gm-Gg: AeBDieuFO2VqcMOOL5Gf0K8USdHluZ+CjQOGdh1xkAnlZA/9oo/6Brj8Cs7KaFQR0QZ
	ve8pvTbyM6BFycTQDJ0mAfDsowvaVu/q4TkYrMDIplLovexwW6w9X9U0rbflPR6cmXX9N1ZbdfX
	FiMsF6yM0TErqOzubOHm1CwYWu8RmO0mNUp/GkHZ2Vh8EXkyX1/Dr8iGz4RRlrLb1OZuRMr69R+
	RJYMiV+7Yaa4XavqF3z3lgw3U4x2NB+xoV7t5IwuBFykWRhEYC7jNiBBBpuzaGkrrO3nTY4vyT2
	eE2CWHQkWG+88JM=
X-Received: by 2002:a05:690e:4182:b0:651:cf23:6612 with SMTP id
 956f58d0204a3-65beee43e1cmr1798515d50.34.1777375135823; Tue, 28 Apr 2026
 04:18:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260428024339.45109-1-m32285159@gmail.com> <20260428024339.45109-4-m32285159@gmail.com>
 <afBvvPhS8Hqs03Y6@ashevche-desk.local>
In-Reply-To: <afBvvPhS8Hqs03Y6@ashevche-desk.local>
From: Maxwell Doose <m32285159@gmail.com>
Date: Tue, 28 Apr 2026 06:18:45 -0500
X-Gm-Features: AVHnY4J-rIUJhOgue5Q5S0ukSw6EFdCie8eLZcmpFdYipKiOCGDwRW8av1IdTs8
Message-ID: <CAKqfh0GA=aQXt0kgZi5nx2EK5HHKnLoSa97mpWXMF8M3gO+c0A@mail.gmail.com>
Subject: Re: [PATCH 3/4] iio: magnetometer: rm3100: Use guard(mutex)() in rm3100_set_samp_freq()
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: songqiang1304521@gmail.com, jic23@kernel.org, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 28, 2026 at 3:28=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> ...
>
> > -     mutex_lock(&data->lock);
> > +     guard(mutex)(&data->lock);
>
> + Blank line now.
>

Sounds good, I'll get that done while I'm fixing up some of the other patch=
es.

best regards,
maxwell
