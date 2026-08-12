Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB9823ABB9
	for <linux-iio@vger.kernel.org>; Wed, 12 Aug 2026 08:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786524505; cv=pass; b=bk0ugLmELpfz4ilnqrQwlrkacunp8iOOs+nIjLr8yc9y1ojiko9TUcAX0AWeHG91UyosjbobASA8WsZMipmPx8vi5QfonP8MDKYsYDlZnXerFG0IGk6pmyDeQuD9UtZH/lpL5Wn66u1XJguKf/Vbn5t4m1yoXNqhN3MIR8yQVfY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786524505; c=relaxed/simple;
	bh=9NvP3s/dyhM7ohI8AouovYBTcuSGiqF4Xz940L/QClI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ESx8HPFjbldh5kRMcH2jJ//9R49krolQD1mxkbTvx9Op990eHaw5rspR2WBqm5MI4K4ahbxoRiqh7/IFD+43sD06WZzxIZ5C35tUr2mri97wxu2YSnCqeB6HL4Wve+wIaGDE3eWnzvi9jtG8EdIrvvG20dELOWUBhIXaK4hOpz8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HHfwIPfI; arc=pass smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HHfwIPfI"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5b00d083818so1816956e87.1
        for <linux-iio@vger.kernel.org>; Wed, 12 Aug 2026 01:48:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786524502; cv=none;
        d=google.com; s=arc-20260327;
        b=N7e3PSrNUyLHUbBnCCTG+Pi0iV6lI7ts/LEYSxteqpv0mkFQKIO4LWVLOb2sA7dOep
         ZELb7narLjyp5+5HBCrS9+Bw4vB4zJRH/DizKFnMqaG4U03yd5qPIOOpCRQfkVwVnH/k
         v4R46GE3Gnko3mq9/7bvXfbY4pVjKIp0NctKDTHpKX+BwReG90z46bHhEl6riWG2rwTJ
         M67glfJsgCroE5teNGby0Lc5upeT9zVELFtHTw4e1ICp2SbC0sW1Xk99GfdfcC3HizX+
         PDO/OLVBJrjhBir97PL2eHTqviFBJiMNXuQNx/ZQuHb/OtDV+05/dy5bj22iCu+x4gE6
         XxqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OlnRbXrMzvM11HciwJ+tnrX7tsgXaPOfRuDz+RfwHQo=;
        fh=du4JWI1d3WNJzXpbeZcA0WFFIYfRuoCFvc9QzL2mguM=;
        b=Qe/OFSTd3mLZruVqeHS+nx62mlv9Lxzfa2QzjaQplIAB2x0CE27B9iiaTN8rgk7cZ4
         ta+AiiGtR9MqqiNgyrxcozQv2JBHv7KNuNLP9PAcudP979M2yEzT0D2IIcV4xRwuLj8K
         Ytl0zybqXcbUTqwVxsN84kC2hQdqp3dMHQJCLWDbtFISatqsthNyh5uSa6AJ3WznU8/C
         8m1IEUPHRMFxMhHNM2L+/noV6wZtBJFQTDEEsXQh7GnyVjDuYV5zzqbGUt2JYg9CBTQ9
         UjQxiob2bkuLI5HlM1JA07rxlSMlEQUBPgfbvdKPJ6DAwufPxXeHQdOdWILP4DNDpsis
         iK/Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786524502; x=1787129302; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OlnRbXrMzvM11HciwJ+tnrX7tsgXaPOfRuDz+RfwHQo=;
        b=HHfwIPfIzD7xjEKCB3Mp9I/yLEGaAY+5AZGkZ9VhkQMyulS5X7tB9LRwQruuvD7Wjx
         aT/qeUS36XN2n0fIsOhLtjLTMA2nbxUwBKn3nBg7Nx8gQ3tEUJMnOYLDwPanOaTlI/Zi
         FJmr8l1Qx3azKMV/NB8QRLkBHJub9siM5L59sgvp5kmqlJyUxOLbYnQcJ/Lry3AyBttY
         QeMMDVoUl4luCIj0ez/d+iQN0oympwynvHYM95l+ZvVCb//GLl1oph2jRrocgqRvZF44
         r4QgWmei6gBOH1yWj+5fdPrQXPM/IfgzfEt7n6K3nEa+cRWp++YlQCErBfs0BW6OqrZZ
         J6FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786524502; x=1787129302;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OlnRbXrMzvM11HciwJ+tnrX7tsgXaPOfRuDz+RfwHQo=;
        b=gUZN66oZt9uEahd+yHSzgpbSyEndF+5uv4/WJ5r/BkFSR2NFJJv97LfEvTesYaCtO0
         REVuX0WxEUfm9uDgr0+CA2fSJ//rnBcy7SphY2QZIE1nAB2+fu2dW/zng4oMia8itlnv
         bNeFQynEPoekmklaghM5+s7l8kQ5DzTIF9DCe9GW/T/A2B5xeOYLfrqF696RvReKIy50
         QG4U02ezMBGzlf2msu+b+6Ou70v3ZaHaP+4S7gbMKpeDchIG0t6Po5H5nrpK/6et6W5/
         hbFYr37+6PfwbNIU5dXglrtrZzAiLcVd/U6jmJL/soGTEHvdZB7BpGVc4I6Lv3DsJd5S
         9khg==
X-Forwarded-Encrypted: i=1; AHgh+Rp7EgFgonMlsk/xUowm/0WX3aKox0230Btp1weesi/1uCIhdvhAPihx1cOxDiv/hrmL5oirCIw7Irs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiETXoLYBX+f4fTFD9hQIVXoYvyLvhSNcCFKjTeAP8pWTy/+Th
	P9xiLv2lHhmj8QIRB77j/kJSu75hFO1uKN2LNDzRjJ31k4hfVcji9uGNNBx6W/JQRxSSXjJArSc
	SGm/X8bYhp1AY9HbxYiEg36ZjTxa4PIE=
X-Gm-Gg: AR+sD10SA5peUcVurTsa29GXBnKZNnmbQ+WnCcX3XXTs0bhod8VHeob6FxravI0QBlw
	xY96Nfcr4LTxi7OV1kM12yKl36sERO9ojubOhA9/CZPUqaZF8CJFz/w4AG59TvW9ev8aZTZsHJc
	fPCvfVPaXqOq+YRznvNHyOwBr8EPjFldzWhJpVsVnhRAc3sG2MSkmxrLzXriQ8oU67ubU2blLTC
	6Ixc8UXG9XcSULdFPjhiBi971VM8XKe6la4yM/GFhyh4zYYD9D6erSWNeUHD+ZApgwSh9XABT9F
	UVsUKZwtyrFmpFm8J7IGCw3vwza/0LLBgGoqhpOLFf9TETSZeW0=
X-Received: by 2002:a05:6512:ace:b0:5ae:bf3b:c96 with SMTP id
 2adb3069b0e04-5b44e951a5dmr529743e87.19.1786524501776; Wed, 12 Aug 2026
 01:48:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260811-ti-ads112c04-driver-v4-0-ae704ac17241@gmail.com>
 <20260811-ti-ads112c04-driver-v4-2-ae704ac17241@gmail.com>
 <anrt5mJBz5h-a3OL@ashevche-desk.local> <CAF7HswP7+79Y5M92PVoHJ_H_J6rU=Q0p5qWDm1gcA2mPfg0VDw@mail.gmail.com>
 <anwhFL8PeCMmT9xS@ashevche-desk.local>
In-Reply-To: <anwhFL8PeCMmT9xS@ashevche-desk.local>
From: Kyle Hsieh <kylehsieh1995@gmail.com>
Date: Wed, 12 Aug 2026 16:51:12 +0800
X-Gm-Features: AUfX_mysTYJdzGQvQzK6px-DDPjL9Q17jJ6tnw8oJ8juQdaYgfumooZwBWopT4o
Message-ID: <CAF7HswPvpdgGz_B_cYWBze6ab=+q=X1UG_LTKgdCj1i9Tyz1Ug@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] iio: adc: ti-ads112c04: Add support for TI ADS112C04
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 12, 2026 at 3:30=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
...

> You quoted tons of comments to which you haven't replied. Are you agree w=
ith
> them?

Sorry - I agreed with all of them and have already applied them in v5,
I just didn't say so. To be explicit:

- wait_for_completion_timeout() is now used directly in the if condition
- err/ret swapped in ads112c04_wait_for_data()
- i is unsigned int, declared separately from the assignment
- reference-sources uses fwnode_property_match_property_string()
- single-channel has its own variable instead of reusing pair[0]
- ARRAY_SIZE(pair) instead of the hardcoded 2
- fsleep(1 * USEC_PER_MSEC) instead of fsleep(1000)
- the internal reference macro is ADS112C04_INT_REF_mV and now sits at
  the top of the file with the other defines
- the IRQ is no longer disabled at all, so the unbalanced depth issue
  is gone

I'll trim quoted text and reply per comment from now on.

...

> I'm not sure how the binding might be affected by that. reset-gpio should=
 be
> direct replacement of the custom "reset" GPIO handling in the driver.

You're right, I had that wrong - reset-gpio builds the reset controller
from the existing reset-gpios property, so the binding is unchanged and
David's Reviewed-by is unaffected. Switched to
devm_reset_control_get_optional_exclusive() in v5.

Thanks,
Kyle Hsieh
