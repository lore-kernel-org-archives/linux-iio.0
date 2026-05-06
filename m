Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8FDD480326
	for <linux-iio@vger.kernel.org>; Wed,  6 May 2026 15:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778079764; cv=pass; b=rmx6TyfFeAMWSrj8DjWP69s5zx3Sz5nn1ZDCs9C2hlSryEDmjrigco71ecTRbLy7jD8P6bLOTJ5lePehK8B265n0B0LVou42xOBX9hwXCboUuEPOgCjiyQ1tgduKceEtMQLH+phCt67yFgO5g4x3Rk1TDac3JndQSen9wPnGOLY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778079764; c=relaxed/simple;
	bh=uWL+cciMOLIwRqjgGz+1Rpz/YpRM2uhGvg7KxbZ/Qzg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MnlJzVblZOjT3peOBEo6IJjCdZbHdS1nikst7/p81dJk+jWV7Z0Bpkj4/ltVzK4hqLlzuPzT8t5ZJoFIJ3v1I5WL7AdiZbiaA6nZmsNhUNAX98RMVMw6D5qn4EiA4o+aFVPpG5Gg8kfVTmZgQ6gaTd0cbq5jxLPMwFDBUH34dn4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S+83dIcQ; arc=pass smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S+83dIcQ"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-651d6347a69so975331d50.0
        for <linux-iio@vger.kernel.org>; Wed, 06 May 2026 08:02:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778079762; cv=none;
        d=google.com; s=arc-20240605;
        b=ZP4V4p2uGeok3FyeUG720GYBUd1yxWIdlIbLSS/olXqA92c7jqLHmpLpUECJcdHesA
         N1sZz6sA//8b43zngVWrB3VxTIpquJM59R+HIfCEQybJhmAJvlgOJ9R5MYc+zhsfOFrU
         PtkGcl7tbcIYkFZW1A2vl/yQulVrFy3uAWuPkSLivE8o7O95l/K/YOyqSWIFTr5AMJfa
         Zw1W8G3IQq+L59uToYyhikDuTQwoAynTVY1v56nEarIIPWJ9e+hRD+VpdoE1T6670xYW
         WFLd3tH3aagCVdgHiRBQqTNbXitFc6MvxT0JmZemsqCmWfvPWSJP4bsTNFYGtWyLh4l0
         2+fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pCVWUq9vMu9LZiZ7LfA5RJOFwIrMBguh0jVvIxdfV5w=;
        fh=b5MC+6Dyv0QzqQMdYEKLiuvFJjs2qlcvXCMBoTFChrU=;
        b=DgW80TY+ZSpl4nXPxPDrNvAjg+nKxAsT5jYca394gu78WtF4WKOAME94Z7EXVX4ghz
         oO8WAjdBMQ7PhmZMpCnXvz67MM/m0XzgYRwmtUL/P/wFRzsbsa9U//3FDA72uF6OlAsr
         IUQP51/vXb3NekdrHMnyTla5VrWSDQNozWBDi6R/xZb0+EX4s+ADmXJElvjQbyXrduM8
         NaOKmM6XKbvX0WZQzq+jTPRZIm964CUp8NCYglSLPkOWLyJtlEu4P6LemQH6SBF3EGUM
         xuhhx0yeQcD5izQ6uATIt4kh46jGL6t3wH5YSfqZxCiZWiBjB7zfhI0DRSZbjgiRLu+H
         Lavg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778079762; x=1778684562; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pCVWUq9vMu9LZiZ7LfA5RJOFwIrMBguh0jVvIxdfV5w=;
        b=S+83dIcQ3f1G4+Fm/o/Nv0QV288/IxdDpxIh0Qd24PqssDn8joqkmjbL4+SY5u9g75
         CMQwcpVDEbMNmIzNnL12jOs5LSRpu1MkTI2YsnXr4pZ1MqAhGGyOBJQ6BzbJDmxFmr9e
         3c5gxAzuZRp53ELYR1ZmCEKxk8xbWVbkJPYitIFudTALKzSAvPvV2anQqcdv2fHfOvuT
         HmBMLx2Lgezr3ZRty9AQXcz8J82KjCPVZ6kCmPQWmNVqLwGBcE2gE3f2GK7gc2DdkaQO
         muR2EeVlSwgYOyHCJqCHOpTT7uOAf0ylBDUy6BOEyt3GxDWqPipjGynwJWx2Sam7yiaQ
         bLGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778079762; x=1778684562;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pCVWUq9vMu9LZiZ7LfA5RJOFwIrMBguh0jVvIxdfV5w=;
        b=fuTN8ERsz5pcjjSWjQ1U9iPP/W5Y3DBxOu5CkWp6ev1shHNNy9d8ttt9mbpMigHI+K
         6n9+W2FUP6zzfQ+5aPmc+XzTvXidePQtuuvIrVkBPIgpi7n2ek8UPJuaz9fHLjSF3Xt+
         lG05YLjsQxjbIBGGea4ldxCn2AP5cyiDmClQkhjgJo/J0pLWWQ21AsXoaMmoEkqDSUUi
         P4Ny+kfkD3hIIWrD0nQvNrFnVPqUiOY6N7o7JtzBkqWp+4UQVfn/6NxhsX4+AQxu+vpu
         w707/oRN1DaLO6olTK/7MEv5gLCtKWLrAzI9+8Ysnw8WF4wo8wz6WhS7jglrW2pZ9/vG
         FouA==
X-Forwarded-Encrypted: i=1; AFNElJ+R6yf9fhWSOmaFhYLpBP4bINo1Mw9S9PhzsOqWuNG1OI4NFPTZ+LBEdOgolsryGIj1D1Kh1Zs1m7A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxM3WBOAUSb6J/MUBas36kj/fauBWVc/tQ/9JU0OffaVCgsQWFB
	/h6tsiIlxlmigrN9atajYSQ7NLFIIyXnIutyFD5ioqxH6pjv56qvmy32dYOoz3b75aiElHiWarE
	8vRJbUts7EKmBzYObLW9vYvRTTywU8x4=
X-Gm-Gg: AeBDieu5ye8EcVpknhC/s8gpw0zzBfa0RTJIyxcsq245LKuyqyJnfsuNFh0Tlh7Jx72
	6r9dvOh/H3xXth89N4GlnEmBfiTenrnayQudqTSwqhO8hTp3aAipwlncwwWD+k3vgl7VkIWHFPO
	wcxcO3niybJIBEP5MIOpDGf1j0Llm4sD5J3lv2V3h1t6Xy/Gh5G9hpY7RkJShO2CnsyOAz34Ung
	kEaYOZxfIJyUIlyqRranLujcAMRQWabRl9LI1ZDmN+LYYeQWXKHSzFVePhjGwtvFKQO4fuVgBie
	3DMyUwdEHukx0INev85Y
X-Received: by 2002:a05:690e:1402:b0:654:6450:19f7 with SMTP id
 956f58d0204a3-65c7a125b95mr3294992d50.0.1778079760314; Wed, 06 May 2026
 08:02:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260505174943.94093-1-salah.triki@gmail.com> <afr-KvM756ZAn2hh@ashevche-desk.local>
 <afr-UujhzuwZWzhT@ashevche-desk.local>
In-Reply-To: <afr-UujhzuwZWzhT@ashevche-desk.local>
From: Maxwell Doose <m32285159@gmail.com>
Date: Wed, 6 May 2026 10:02:29 -0500
X-Gm-Features: AVHnY4JfGzf7qkMLgun_QJ53hHMchZBKZk8HUR6tngFXXsndUjRuOO3JBBSs8HA
Message-ID: <CAKqfh0E+4WUBsMHH0Rj1UH0MFdGo7E1crmHzJ+E6c0XXz3qvCw@mail.gmail.com>
Subject: Re: [PATCH v3] iio: humidity: ens210: Fix missing I2C functionality checks
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Salah Triki <salah.triki@gmail.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 6, 2026 at 3:40=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Wed, May 06, 2026 at 11:39:11AM +0300, Andy Shevchenko wrote:
> > On Tue, May 05, 2026 at 06:49:43PM +0100, Salah Triki wrote:
>
> ...
>
> > > +                           !i2c_check_functionality(client->adapter,
> > > +                                   I2C_FUNC_SMBUS_EMUL)) {
> >
> > This one is now wrong.
>
> I meant this *indentation* is now wrong.
>

Did something happen to that when I sent the email? Or maybe I'm just
going insane...

slightly confused,
max



> --
> With Best Regards,
> Andy Shevchenko
>
>
>
