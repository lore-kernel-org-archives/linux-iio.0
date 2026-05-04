Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0DF37F8C6
	for <linux-iio@vger.kernel.org>; Mon,  4 May 2026 10:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777889640; cv=pass; b=FO2xxG6/BI3nk35r6qCjMpgb0PidJnMOjN8sdq0U6rHNU+beZRx1rJr9ZRSTuV54Uiay+dflTQ8vI8TvcBDTzkh1ZTWfLieWok4prO+ncyHWxkqGfDRtvYEfDTTUpYrc5S7EdKOzSmBORMll3rw/2pZFQfhGl2dICmhmIn6KiLc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777889640; c=relaxed/simple;
	bh=fOGbJaDjy5XK8CFhXw2KLfutauBNSWvV1+va56oxb6E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iVJVckd3xNu62TUNQJBr+C6mLxSDYrtoWYbVgAGuK05cQQ+VVBeXZkWEKuunU80AAIWV+t0iJFovOU+hUjx0331XVTQ7cr1VcQlHy32KZ6KfoqMpSrljLgDYSUTW92wDSuOegXtsJLgllHSKym11m6mQFbhF/u6yGF8Ebx0Nda8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J1mqhaW0; arc=pass smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J1mqhaW0"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-44a786a9a35so1754660f8f.3
        for <linux-iio@vger.kernel.org>; Mon, 04 May 2026 03:13:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777889637; cv=none;
        d=google.com; s=arc-20240605;
        b=WC+wGRyWq1Q0BnSTNMm/gojHK/Eg3igaebAoOUOIew2SSAJA/F6FqXvAXjywXhNToS
         sMOUuOnf5X3KT5sf7xq/Pl3fxT+oRf/IPukcYuUwx+quGk5WEmqyLAChg1teACdjvXtK
         vFRidlbvOxN+UWkB30iMjKTuU/7UbUIWgdCJIm4pTWui2+I58gO6vPXpmgKFdli3UrSs
         lLCYmD+wX6fpGnM6nEGK3/Wm37twbCkFCSJtxOLa7Y5C65ucB3iQV8eshQEGwe8t7GmM
         PyhG4MS700s1UxCfFaTMCrvJxwapQc9/7gJXpj/WTR+OSCuZH6Uet7ad9iZuuRoEpFR7
         8rwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=iUKo9MweIEBwAjwYMydLcRmpjPYUhqZQNpOrwXDA/m8=;
        fh=Mqut8QgaHUsPF3o9FdeotWyYZ4NMhIa2lDMKQ21UWkQ=;
        b=i8Ukq8PfbwOxzYPNGRsDQzeMdivudbanjT1v/LRf9nbDPVG/gngrJzZMPK2iz94aDZ
         eChsKHiXQYmWubDr7/leiStT8EmOdPgBRwsYz9XjF6Cu5s32wZi1MitC73EBnLyGIcAE
         3qsy7UCQ61jFyqQpanQqazkmX9BvuqdcNJ5pk/CmZ0P13zgCDuqJYpoztB9gGsF6xplb
         TgrnWlMnHPGIsbhoOMx2TQkQdbN2leEci8yvn5tzcY+t1N5wJ4tt5IPnZHuPlEufbOj1
         +vQUGBtex+seFSXuVkG3UfSAt8kuqyra2ah5whG0dWobAZipBrSKVcuF0+4TJQKdv9OG
         qseQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777889637; x=1778494437; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iUKo9MweIEBwAjwYMydLcRmpjPYUhqZQNpOrwXDA/m8=;
        b=J1mqhaW0OEglM8Qv+fE9vXBLrNRgdqsZ+vSVjmf8vlWJQJyVZBkO+AlA72eIEw/yOG
         oQOmd5vhn3wohrgfH5wld3CaJeWge9DaP9meeZKv1ra5YNt7bG1SvuT63UGtY5eNE0nV
         xD5jnpYgEUY4q6M7qK7cgwsXgprqvagBWSpZHmTa6hgA80TAVdJ4GXugUK0VAsy69LJs
         8hti7qBm1mrsF/6eqIfIP1dtz1TWx3/v31R3LFf3NRcIG9VLz1Yw4p2dOiB8cND5D7Hf
         cBg3TPtWZItK0FDAs2ZdWjawZkIKoLiIVTk5v2n04/QJdbkKHs3AxprYHRQ/7BPcNICE
         Q1qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777889637; x=1778494437;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iUKo9MweIEBwAjwYMydLcRmpjPYUhqZQNpOrwXDA/m8=;
        b=HZRyNhDYr9lzKCOWx9FFvOmycWeKhYPgj8WgDZO1YCnjN3xNELk2tdqM3euVZSijsU
         rAqN3XOwu/wEsi59HLCht+OM/dk1VcsKlTMBeFfbusbjK0UAGfsfJb/ox8z1jHx7Oglz
         11Zqb5QFII+ORmJzWlOxtEkAaVyq5I8N60OqQCFhQ3/WhQvez9RFoLhxc1s4Q2N0DKhq
         61675hOekdj1T2nBCfoKH5QSrUhcm9el9QQFbnM3Au5yFRTin4lRyKVl9ENU8hpFQhaX
         8N4ZnS6Q0tqyKw8LyoKfkMG+QYClH/o1GugsrXnskOo/SDrxvXb6pOuh32yzIqznm2/V
         a//Q==
X-Forwarded-Encrypted: i=1; AFNElJ+gzh5vZ6WbvS2sRuyb7o0a0zHt0So6eCSX5XU1julUlhOVs3ox3qAtTyH0G9ErUkrTfwWt+KgT2Jo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXD3aJIiWtKM9Chuo00XD9EFy7vQW5SatRH7GdA3sX76SKikqL
	eTs0xj3Gf0/4AoF1KOLp1dvJE3gdmjk2fiS0LzpuW8FgFiJvMOMhNG9lCVQWQXX8JqkMAm0LSBS
	04fMfuK/J0eULbAofgUx/bM2miugYbHY=
X-Gm-Gg: AeBDietuGcGw6/2KSygb7XahZB/gcjxvSUXDpOhjo4cUfqa4yUZ4dO6ras+cjgOe/aS
	rva5w0s0bNb8haoSOTyxxRO2gxw/eUTj+NoY8bhQhPwMWr0cxobbgWT2MIQ1K9ZFh1hcGNNzVSd
	dni5VvLr+1T8diuif/JnNRfRMslEIdjMCfeHUUJF7P/mHMx9P5zOMexCX13z2guHY3Uslzbk3Hy
	elMnMss7es3usHZCEpWJZGihx7rKSOTiZpbODS2J3XMcIdZRpT1uY6ACw7DQFFbR+0iClDxnF7n
	+eiAKtq0LyUXZg77bwjt1IoIsTRQHcRHe0zJZn/dGEOrU73HP13fdqLqguZsHoBLAA3CGb+xKIj
	Tefq24Bf4rwt6b0xVQfe2WO4meZYeggUqWUwerDrqSWGaJMXOLBDENvcniv8PY0QHsa3KGktEF/
	RPQMDFOiloBJzEN8yE
X-Received: by 2002:a05:6000:2910:b0:43c:fde6:212d with SMTP id
 ffacd0b85a97d-44bb65dfd74mr14357604f8f.33.1777889636812; Mon, 04 May 2026
 03:13:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427201412.3067235-1-andriy.shevchenko@linux.intel.com>
 <20260428173540.28b7913e@jic23-huawei> <CALoEA-xm0FGRk1rUWOO1YvzczC86Bgvu-t4Fe4iy3S_LCTygRg@mail.gmail.com>
 <afhkdxsxDbUDqG9g@ashevche-desk.local>
In-Reply-To: <afhkdxsxDbUDqG9g@ashevche-desk.local>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Mon, 4 May 2026 12:13:45 +0200
X-Gm-Features: AVHnY4IKcBNVczcbbbBWhQGUMUakCRDf96FhLvXr-gSB5-t5NlwtteofEMSbSSc
Message-ID: <CALoEA-ybX_RPQaxCviS03mHvneWzH-WxNvbgBMxXXEmrfc3fGw@mail.gmail.com>
Subject: Re: [PATCH v0 00/14] iio: magnetometer: ak8975: Additional changes to
 the driver
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 4 May 2026 at 11:18, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Mon, May 04, 2026 at 11:13:36AM +0200, Joshua Crofts wrote:
> > On Tue, 28 Apr 2026 at 18:35, Jonathan Cameron <jic23@kernel.org> wrote:
>
> ...
>
> > Given the relatively big backlog of email in the list, should I wait a
> > bit longer sending the combined series?
>
> I'm fine if you send it today or this week.

Is it fine if I do a RESEND PATCH after rebasing or should I wait? Sashiko
reported "failed to apply".

-- 
Kind regards

CJD
