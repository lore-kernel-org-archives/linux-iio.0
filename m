Received: from mail-oo2-f42.google.com (mail-oo2-f42.google.com [74.125.231.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D1F328610
	for <linux-iio@vger.kernel.org>; Wed, 30 Sep 2026 11:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790768132; cv=pass; b=sPmnTP5uOj2MNLFe/jgaPIPKFDjaXQd0TYkBjttTpJXkT2+Fv68lkpn02FJYcJ765uxg2qlLZK078Iek7NJrG/WorjCG0Bpghvwr7oFy+bAeRvO+2zD/P7xz851keZ9l3tx/PAnWLoFfp1QEYnhS3wVRD38+LU2XbQNealdwK+o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790768132; c=relaxed/simple;
	bh=Ai/Jf8BwEUO5H8StrVs1vR9aM5EMKcYU9MwuHF4t1kQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NDv9vkV6URRf0Db5NL9jxXDh66RQkuZhr34Lvr8FxTUn4s5QoJoyuQV6clTHqyzTyJaKkuAz3NpSSwOcgEPfnmrrETyb8bdJrqiEjtBZcHBtePC9Y4I7iNV0GwGrqUekck19gG7qbm9ejhOBhhlCktJFczY0leg11VLfHtIeMH8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HdddWs63; arc=pass smtp.client-ip=74.125.231.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HdddWs63"
Received: by mail-oo2-f42.google.com with SMTP id 006d021491bc7-6d79b1f928cso1907528eaf.2
        for <linux-iio@vger.kernel.org>; Wed, 30 Sep 2026 04:35:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790768129; cv=none;
        d=google.com; s=arc-20260327;
        b=a4FaiT1yqMmEgrciiwgXh1sxnfVrDt+q9g060Vu3Lp5L4OIn921YcOVNsjGRWafGAH
         Eu8xtlK3gYzmfy34L9k9Xrbj15vmbWq3wIeljW/Pt7egY8a7dqO+0wK9bS9+BhGVjDy1
         TqEywkCBw26eFrfVQRAFBP+Wzqa2ZBrkKdwdP7v8mc/3jUyE5OpfD6pq07kJMH4EiSXa
         eyvZ5wSfG76npr4bi5nYaqbqSj0UxyZhKJRC1Uw6PgDXOP64zIpTabpndslt6kXpiBsk
         bnDEDZbkn+E5o7oQ1TyP8bYu5zdGCQHRFtfwJvOrz9ADNPoP2DQkRctGgu9l5RxWd3uK
         81yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Ai/Jf8BwEUO5H8StrVs1vR9aM5EMKcYU9MwuHF4t1kQ=;
        fh=biKpWGDmAheDqHv3ksMbEbPP3GGp2nMgNssgB97PJwU=;
        b=Svbrx+FO9/KgTss1sLXgwQduV4HouYLFYZYybpC2yp9UFF6HulLvRkmn/SIIuJ93Y1
         uDFzMdjg3TRC0JcVBaLFg4Al6el76ShON64ZsavOhClvuCVAlyEdPpoJXrkS57XLk8eP
         4wMpBxLMmw2BIe81bIH35m0bzdXrE5m4jeSW/c8W33xtrOiI3gbjo39XWzCenv7CBC54
         XMnia4sjBUoRTuHmKk0ZxaIZKy3JDU5UKKL79BUtm1DU53VxoZe6GvZdN/M9/Hk9PilS
         8GRKjv2hWlrEPspkwEXigb67XgqxPdJZwN58BrS8G5fIkh5+R54Dqg5SHuBXnRA+mTJ0
         khbg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790768129; x=1791372929; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ai/Jf8BwEUO5H8StrVs1vR9aM5EMKcYU9MwuHF4t1kQ=;
        b=HdddWs632Rj73PqM+qaWPqerAlxbkA7jCCfT7PyN/fSPH1zqNwLYIKTgFVXaFuTVos
         fmotyEKoR1KMjKh/1NJZw1q15XRCC2EA/H+yJeI3s2OO0JHmZLcSrghRoF3qSPzV9s/i
         p5wfiklKsQtDW42GxqF0XoCTj+lTpui3g+0v/7GtDZ6Hfc1Da/CdWrBHYSo0RyHal+oI
         pGzo64gUftbPOBmyLIlELJ8dcJSlTuG96KZlA2ydJEWfkjGWkGlfIab7de+7aKRuRbGv
         rD3gQ8k/0KqJ2t7+Phaa5wAyT1BwWqmqFpmZ3wf25AZyGvtZSfo/l8EbI2L4ImTo22hk
         G6yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790768129; x=1791372929;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Ai/Jf8BwEUO5H8StrVs1vR9aM5EMKcYU9MwuHF4t1kQ=;
        b=uZ1AZn/JcxY2Thf1QOt2htO0FxWCOYR3RrVkshUgpJSgwETaV7te5OhO1I/Ncs7ilp
         t2QNRn0i366KrOyDxf3UhGbxe3JKThtwjtPnvwNulS8k6QfNoJpwiSBQveI9/3RsdMwC
         reHauMAt6HCXKaVIUqKWguq6cmjdFgeSiq57MyVCFdyil+MFQRoeBrgQxdby9GU581nT
         3cSF5z0OabqJkqAZfYESCL6fp+RvKHl4bloBaD4vOHBudwg6jTuag+Vv7/TjL5rQHg+a
         DBuPU3tQA2DRfVNFg1q4XoXkd/agqqUQU81JseD9i6X8yIFBCgHCWGITHD7/0F87DP7K
         KBuw==
X-Forwarded-Encrypted: i=1; AKwUvByRw7nhVfFzxlMhMJh/Wm4RYXViaG+qESxR9kzuz1fSrdPDI5rx9wwW1r468XBVCAXF4oZFOAxyGp4=@vger.kernel.org
X-Gm-Message-State: AFuF++nu2IkEegPWRFKH5mV4m3pwAax4hjpyLCd6kapTJWMtpTrBDN6c
	HggSfd+XeYFf1MviqPoehupt3LQB2ALGzdw+lfwlIub+qajZpJKoPWjpzzPR9AOi/jz7OmdqvoW
	Ha/IxLmsfUOzVvAlpIJJLowiQoiREuVM=
X-Gm-Gg: AYBFou01IFdue9/43q5Lh6lwLdnT/xFiNu1JQKioYxUjNbOKORXvh4gk3qfAgAFq/Eh
	hbvDO+9PySO2WNkxmBzi3nMZBqkLmnvCunNlDEzjofYj/RksuT/5e+NbdO9CT1OIpgF52LuonXB
	6hVgKzfF9w3Ajj2lB2u7gBC8y5D3So/KZQqjsfG6zXhb7EUxrh789GwKr4xW9VHC8ZWwOVtplRU
	fVvcWnZmR9v4ZUzecn34ENHZAlxz3WUnyVnyZF+2v8EPtMREQz7a6TD/EbAtP1gLZu4KvebeXUv
	O5/085a0lIjaR1WNL+fcD+eXx4IU+WyjBPpAI3as3GIIxIlfYBcOYteMnA==
X-Received: by 2002:a05:6820:4df3:b0:6ae:8fc0:dbaf with SMTP id
 006d021491bc7-6dcf1fa7093mr1040549eaf.1.1790768129547; Wed, 30 Sep 2026
 04:35:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260929184900.39515-1-abdelnasserhussein11@gmail.com>
 <20260929184900.39515-3-abdelnasserhussein11@gmail.com> <20260930085640.00000377@gmail.com>
In-Reply-To: <20260930085640.00000377@gmail.com>
From: nasser <abdelnasserhussein11@gmail.com>
Date: Wed, 30 Sep 2026 14:35:18 +0300
X-Gm-Features: AclHuK8untSyrCd6-KRO0IrW6AMVzxM1NtGbJFcEt_bom4eFkclVEvnnxJY74KM
Message-ID: <CANpqX3bDL-C_w1ttuarPyUvOysCPYOsoLMS6Ri24oFnYmzjOVw@mail.gmail.com>
Subject: Re: [PATCH 2/3] staging: iio: accel: adis16203: add missing
 spi_device_id table
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: jic23@kernel.org, gregkh@linuxfoundation.org, nuno.sa@analog.com, 
	Michael.Hennerich@analog.com, dlechner@baylibre.com, andy@kernel.org, 
	linux@analog.com, linux-iio@vger.kernel.org, linux-staging@lists.linux.dev, 
	linux-kernel@vger.kernel.org, error27@gmail.com, narcisaanamaria12@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hi Joshua,

Thank you for taking the time to review this.

> No need for mod_devicetable.h, this is imported using spi.h
> C99 initializers please.
> Additionally, you should delete the MODULE_ALIAS("spi:adis16203") line.

I will drop the unnecessary header, update the spi_device_id array to
use C99 initializers, and remove the redundant MODULE_ALIAS in the
upcoming v2.

Best regards,
Abdelnasser
