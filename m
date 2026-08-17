Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED9940BCA0
	for <linux-iio@vger.kernel.org>; Mon, 17 Aug 2026 12:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786968792; cv=none; b=N+w1koJw559RZCGO5hA8JhvyzqWvYcYSxCcE3g2QrqwfEOG9+hRaMfPFRXGsDj/tF8jHyc/MYOneVNXvkdzItjAOMgIA0GeQEvV0UUIf3YnLDlnvQAmvgFcujzYCnrNwMiK1i8CxGebilGSZDQDCDQ2cgi3LdIpAxVjIQYWyLpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786968792; c=relaxed/simple;
	bh=fDvF2o86CpX/eUBAtOLTtFXPtLP8pTqWPEOo7SqLNmM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PaHaQViwlSDwLK79Sqqp235GYtNFu8pvYh+LqUKtp8JVshCh0/he482Mr1zEjA0Uq3mS5786BoPeVAvKG23Mo04KIebJvlUKm3bmz9LFsw2BSv8dofUbblm8ava5pBd3wjX9jegQoFiiOiDsAb+GyWe9/N6+Yu9Y1nivvfuKQ1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FOf6Mp7I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FOf6Mp7I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 127861F01560
	for <linux-iio@vger.kernel.org>; Mon, 17 Aug 2026 12:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786968791;
	bh=fDvF2o86CpX/eUBAtOLTtFXPtLP8pTqWPEOo7SqLNmM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=FOf6Mp7ILFvlN/SPCqPK/Jo7hW00u/svsJhDlq66Q/HdlgILeLy5JAsuwpmoo+RpY
	 DSYr+vS2b5oCH6L1myCqKIrQL+WxFGdKnmv80vGxnF/13FanSSnegotPCaHWHfI7NL
	 M4yA+1pMbFfRB0Gp6iqtV/r9d8mg32jlh8ZC8QgTOkFtp9TD1w1C2/WcDkb+kJfQau
	 E4n7yngqwuFOgwD6WZ0O0gvxmkRA5CPoBbAPo4lQMJuAxiK2gKB3WjtpaUyJfB+enX
	 ghT9bCcNAQf8oHMMFeZFgFDYPYgaKsfAiXOKvgittj4vO0MpZWIWF1auJ9Mz458iB0
	 6/WQ4+wnsNp4w==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5b011edaf7dso3782518e87.2
        for <linux-iio@vger.kernel.org>; Mon, 17 Aug 2026 05:13:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rr8oXXdoECJfrFlMJEIi2vgy4aZ1dadj5njrVTRu7cp5cx9c+CpV+X/+roupBQdHmFAgoTczXf4b0U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVg420rBpWnXj59F/aW2kMiFKtLsuiNenFNTK+9hIi9Ckb5b49
	623kuya8feLFXUvKz1ZPL2ntagJ2cWJ8I6okwQTRjMsepKJbQBaPkFcXafpuk76wG654IMrQLgD
	Pk6sfnhM4wi2xK6ARZRzBxGmL6dWgdKk=
X-Received: by 2002:a05:6512:2382:b0:5b1:4c6f:92f9 with SMTP id
 2adb3069b0e04-5b47067f197mr7540e87.20.1786968789825; Mon, 17 Aug 2026
 05:13:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260816060648.4030-1-farbere@amazon.com> <20260816060648.4030-13-farbere@amazon.com>
In-Reply-To: <20260816060648.4030-13-farbere@amazon.com>
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 17 Aug 2026 14:12:58 +0200
X-Gmail-Original-Message-ID: <CAD++jLn2V3DP=8qQmkKo0KSh87ZdjHy6XGn2DeHdL-Ui0_OM=w@mail.gmail.com>
X-Gm-Features: AcwNN1U4JrOxzsv9KlcvcECVLI6UdHKCqisJUWamsMkkrKOZr3X21Ct07ozVb8o
Message-ID: <CAD++jLn2V3DP=8qQmkKo0KSh87ZdjHy6XGn2DeHdL-Ui0_OM=w@mail.gmail.com>
Subject: Re: [PATCH v5 12/13] gpio: gpiolib-kunit: use devm_blocking_notifier_chain_register()
To: Eliav Farber <farbere@amazon.com>
Cc: rafael@kernel.org, tony.luck@intel.com, bp@alien8.de, guohanjun@huawei.com, 
	mchehab@kernel.org, xueshuai@linux.alibaba.com, lenb@kernel.org, 
	laurent.pinchart@ideasonboard.com, brgl@kernel.org, orsonzhai@gmail.com, 
	baolin.wang@linux.alibaba.com, zhang.lyra@gmail.com, jic23@kernel.org, 
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, 
	dmitry.torokhov@gmail.com, hansg@kernel.org, ilpo.jarvinen@linux.intel.com, 
	W_Armin@gmx.de, ukleinek@kernel.org, fabio.m.de.francesco@linux.intel.com, 
	kaihengf@nvidia.com, ankita@nvidia.com, leitao@debian.org, pedro.pbg@usp.br, 
	paulmck@kernel.org, frederic@kernel.org, kees@kernel.org, 
	saket.dumbre@intel.com, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-pwm@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
	acpica-devel@lists.linux.dev, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 16, 2026 at 8:09=E2=80=AFAM Eliav Farber <farbere@amazon.com> w=
rote:

> Replace the blocking_notifier_chain_register() +
> devm_add_action_or_reset() pattern with a single call to
> devm_blocking_notifier_chain_register(), removing the
> gpio_unbind_unregister_notifier() callback.
>
> Signed-off-by: Eliav Farber <farbere@amazon.com>
> Acked-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
