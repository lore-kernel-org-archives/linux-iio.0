Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8EA5218592
	for <linux-iio@vger.kernel.org>; Sat,  4 Jul 2026 15:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783180255; cv=none; b=kswSC/+5LCS7yy+Roso7UOwMYA+4JR2O2slSe0jiDg2KKyvhPOXVF2M2J0R4Cl3J/pm45XYFRQxnNqSirzM9gRT61VSciJftGtm2QysEca2VXFHVqalY1K1bpADsdQP8iXVKRU24CsLnL7PXsKwqKoJOe0RL86QWi/iGnsL2kp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783180255; c=relaxed/simple;
	bh=29UlwnEadw/8IQft975RJXbQ05EEelJsTRCf3zzvFos=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=EJX2SdHm7sRMIyTNmw2EZhphpIsVIGooy6mA+NZVQOrMt4LSX7s820xMifTBKuyxxAaU29Es1kZNgNHLH1CNyaDh1bFK26ySa2zP4FGI5hRIcTDHgzkYEAie3LvInA/oJ8eMIeXBO2i0Z3ZFWuaE3PzIbEClCnihC5R4yDyhsdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kAiktSjB; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kAiktSjB"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c9ef3e1337fso1100288a12.2
        for <linux-iio@vger.kernel.org>; Sat, 04 Jul 2026 08:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783180254; x=1783785054; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=29UlwnEadw/8IQft975RJXbQ05EEelJsTRCf3zzvFos=;
        b=kAiktSjBXcbMX2vc0Bl7hc2iW8q+mgzmwIp1hn3xhMzbks92nGBsSwhJkJmZyJddE3
         698ydrVywmkXqLa213FxFFWg7bS3o108STMaLYpX8Lq7FPXvAXnZj3ItCOOipuVTmvbh
         EmMm9SYnDtLdQg9EoC2kLD6z+7qb78XmwQSdIv0QMxUHpyQtkrO/RXIiGvTBArR+CXZs
         dzNzJEVg4AlvFi+Z8AYJCIumSnXf/YGCE7OhEChOFcwr5FmmWpCHk/gvpuVq8Ji1QTmN
         J2rXCvoTw4Cg0lQhNA8TOYT4mp5uWkTOa07JbTMjEEu0rH6a6v1iv7IFdfLnnDVJIEp+
         WhPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783180254; x=1783785054;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=29UlwnEadw/8IQft975RJXbQ05EEelJsTRCf3zzvFos=;
        b=ku/XScDq7wYK4hN16F0cT/I8wBlJOOKbfQTs8rNVzchWqhE0wYq7OBAQ3Oa71p+Ib2
         TMw72C9z6rHCxB+7ZrpzAu+vZf63JZhs4dg67rrkNmqLbNlvg177NY8LRwDFrDuI6UkR
         YHtyx9bkZr9fzGISGXWSW45EltfxWwJe3qnnmaD1zaLUYGOLS9irb9N8CzOfVh42aHUX
         Wo/oiKJ/pCJcoEy1K/1b/Kug4q6Bj6RMo5f9LuHjBnmyu1CWZhvZXtWnuclWDqz0LUpg
         H7PXGIFJYozpH1AhBIRv/uTW6eJ926PIfq63mKu5rqdTD58MvworhHwH14TyOl2Shyb3
         0Vxg==
X-Forwarded-Encrypted: i=1; AFNElJ9zrnN4zw0BgJJ7jiNdasd2G+xjlgLeIMcUk9n97UmJSziTBt9Fdx5xY/0f7AESWRMJhn39XMOCM3Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0yM0toDf27ZwGO0mCjtogrwaKKS/nVZ4Ayz01R1BQljzyg/RH
	7770IJfIl9b46R/X7z5RJvZ9V13te2IxT6jZZCMyxdHeR4oAcjVz6Oj5
X-Gm-Gg: AfdE7cnKaK2aiizmtnGfrB5EM3V/rWKl1M5H51r0aTX9mvwfDgugK/jq1rb9bR/azDk
	eIfSqFQzJ3qmjrqCN4RxufVzOxshRvXdmQQ0jMEsgAhf1qeBu8gpCf6TCgTCIoInZon3/j1UgHv
	6ZlKnMnQirTPGbEJqi81oZkOLkOUPXJIVdXRol2izipS0rglENHPkhsh+Cdpgyrnc5cW187GKaY
	WjcifafCuGvtNZTZbsJ11Io7Bb+pR2oVSSzwXy8ku/TGXAqI3jQ4kJvTqQADfG7MrP0ZQqrduy1
	EVPRaQAQnPD4kcLFouJJJIgi50dq1oTJatONVE1wUsfaJv0XEgLKACAu3jcQOv/wkqvtVS366HC
	GPhyVRe7VribBjZdsKSnZv0Sb69a7vlH+OWsdVC/C1vGdZmrSgY6HuZipF7PLgHnF9Lkqp6p9P9
	Elr6+0ZIDUHNpVDKR98JWNlLyU5h8gVGWCCY3WQpop93TtDUlSU0DvTAOfPjtLdYquU3Fcn63q9
	A69
X-Received: by 2002:a05:6a20:d493:b0:3bf:49c8:f8a with SMTP id adf61e73a8af0-3c03e4a33b2mr4174365637.36.1783180254030;
        Sat, 04 Jul 2026 08:50:54 -0700 (PDT)
Received: from localhost ([45.64.226.42])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f39e07e0bsm14704269eec.30.2026.07.04.08.50.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Jul 2026 08:50:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 04 Jul 2026 21:20:46 +0530
Message-Id: <DJPWN45EI416.1GR6QTDHBU6SC@gmail.com>
Subject: Re: [PATCH v2 4/5] iio: adc: ti-adc161s626: log buffer setup
 failure in probe
From: "Prashant Rahul" <prashantrahul23@gmail.com>
To: "Jonathan Cameron" <jic23@kernel.org>, "Andy Shevchenko"
 <andriy.shevchenko@intel.com>
Cc: "Prashant Rahul" <prashantrahul23@gmail.com>,
 <linux-iio@vger.kernel.org>, "David Lechner" <dlechner@baylibre.com>,
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy Shevchenko"
 <andy@kernel.org>, "Petr Mladek" <pmladek@suse.com>, "Oleg Nesterov"
 <oleg@redhat.com>, "Sebastian Andrzej Siewior" <bigeasy@linutronix.de>,
 "John Ogness" <john.ogness@linutronix.de>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260620174708.111470-1-prashantrahul23@gmail.com>
 <20260620174708.111470-5-prashantrahul23@gmail.com>
 <20260623203636.69a7429a@jic23-huawei>
 <DJH77MBX1U37.1JJ1Z6UGLF0LT@gmail.com>
 <aju-_HSz6jNkR_NM@ashevche-desk.local>
 <20260625120952.471ec21a@jic23-huawei>
 <aj01H48IHTyhn4ZR@ashevche-desk.local>
 <20260703013907.57b0f114@jic23-huawei>
In-Reply-To: <20260703013907.57b0f114@jic23-huawei>

On Fri Jul 3, 2026 at 6:09 AM IST, Jonathan Cameron wrote:
> For now I've picked up the two straight conversions to dev_err_probe()
> because I'm keen to (slowly) stop using dev_err() in probe functions.

I can look for places where dev_err() is used and can be replaced with
dev_err_probe() in other probe functions, then create a new patch
series for it. Without adding new logs or removing any existing ones, of co=
urse.
Shouldn't take a lot of time, what do you think?
