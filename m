Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A3D3115A5
	for <linux-iio@vger.kernel.org>; Mon, 11 May 2026 07:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778483096; cv=pass; b=hVJ2MusX2aXUeF3cxtHlWh1iTmDrEK2emnvYbHP3dH6saRSMd4Q5MU1bIKopZOWYY1T0PFeLuMgUTa96S4QoS9jqr2gi9du/UBjQslaqQ/NGWOq99YRn6QPH3sJ6chR8Vdb7b1I3HxejrNFoAf5Ww8XxJ5BthLXU95DPSz7JJZE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778483096; c=relaxed/simple;
	bh=yMsoHLPFj5jOYYriRrqbGS66YfBY2agEu4el6FmosyQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SeXckcPP+kkrXwu7CUGylRnNN1R+IhYaY3wN3YpWVQ1598wv6kr01iLiHH01SNuE3lrwxpKy5lGHVMg9EkgDpgnak6ofYOEQgbfT1PrWgVF0MhCV/wNx+1EMV2G9IvI+nnHlt+K8BCLs27bpHaBSF3mYBcNvx6iPMjBl5Uy77fc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lDSns0sH; arc=pass smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lDSns0sH"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-488b0046078so32122425e9.1
        for <linux-iio@vger.kernel.org>; Mon, 11 May 2026 00:04:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778483093; cv=none;
        d=google.com; s=arc-20240605;
        b=TQSJv44v+/db+NPjy2qz3Er4uBkg0sxszDyPy/AhwPfn6GMY0d1BGCpKj89WfhCTzw
         KSlxWP8oZsXu3vQAZSD6aWeDp/Pk5M5aoE2Z0t2KqV67r9sF2GY7qKFlco0+Idnwbip7
         x4oSDm4hf8YPgooyHjWVzgDsEzFe0bCT6GTRDZnw71L/cm+eWf8LMrm6Y+po+YQ0SaQQ
         Y3KdKc5oYo2gjLaYniFhuyHnFEDnS/ugpXHOc1vTPaodD+Mek98glLfoM+MMGin5gitq
         1H/r3HCzHrbwdhPYtxwwtNIGa3azCeqjNG6AC54S30ym+Q3elp6RRKUBFokVHgmWA7QA
         qMsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yMsoHLPFj5jOYYriRrqbGS66YfBY2agEu4el6FmosyQ=;
        fh=XsicwoZ9MAjgLd2k0ZNmlAwUJFx09GhYSBRG03kkfyA=;
        b=Ki9VCdTm1SYG4QayZEZSZron0Vok7QrN7COq5w7eoDsPBhClriCoKne1MWdR8oM3+A
         bFBXmOPaXHyZBoNTCXWMFlWIah20zpD5arAA8sVIdlrLRoQ/QzAfv3EYMnZrlIY/AmEE
         5+quku7YpcJcLM3Ee+bzOmpODjvhAsFQloVsnYY9EAwS7aFjLd1f+xYEKskSMiNBpmbE
         aS+q3jZKXCV0k9nfkXdqjeGB4soEYXsmK9dzfX5FZXapxiqX183uvo7Cqvs6AkbQpkoc
         CVjVFohFdaAJl41Vj9CTrQZLeSkSW4mJmEs16f2VOUalzjdoIauSWMiMXXUZ+873yePn
         s9eA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778483093; x=1779087893; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yMsoHLPFj5jOYYriRrqbGS66YfBY2agEu4el6FmosyQ=;
        b=lDSns0sHpW09Ww1bm/+E0OXyrOmu8cxKyNUvRBvCCB2qnJ5/el3rtDHCgbqpwPkMV3
         /Ae6hRptrd71+QCNbowO7r7QRFJZ4Xbw2Wy4PLNzXMNsem2nZlLRZ5rPMVrKAXDcB9pq
         ONqdIxyeLBf2XqS9mpt9fbKK2W/MLu+R/52oAIg+Ccqj9ozlag8gieXOngaPP4VV+LEn
         oqEFf/nHO3LgCUvgxvBYaC7BYsnlzHcj3Pbl4MFraBHjov5p6JmbD77y+EuwcCZQ4PWp
         7yV/QAqWWhQWPwc/x/yBWrmEcEFusS2X/K5pfePgofVYd+rke1OyLpAhj5EBwFfEf6TA
         ySxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778483093; x=1779087893;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yMsoHLPFj5jOYYriRrqbGS66YfBY2agEu4el6FmosyQ=;
        b=pMI6lgQCxvs19MHo9gSe6zLuHCmyQ0GUqp//oMvgKSWJOakFbOi5l3CZcU3uxYJbWb
         rljmEJIW7OhPGNC2n73ukogxG7odRZF6bigFx3H7f1Bh+yhOqyo8pcfh4H7DZKV8R1+x
         iQlot4BhOEnWRpxnTekxSvh8aA4yyEWYTA+gd4MUCh3ifNBibL6XAOwSmB4EoO40Gusf
         JRm5ufltcfUKO05bs/CR7/Wv3bp/J55yzZcZnTD71C2IiRH17IvY6Mvp89UmriK88hCr
         wxQwHi1S7Ms7I09LAFWB1Fjxs7Qr4cZSlIq2i23jtvFAWr8rZfYHEaU41etSti24CoE3
         EOjw==
X-Forwarded-Encrypted: i=1; AFNElJ9Pa/VYVghBqRBouuDk8wzQq93cshXp/0A/rzkL1qV73YxhaGd5PRDDHRL9LX+VcxJBeErjGkYoUMU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzuFjYFbAuFMt4TJS3QS4I0pdqQxbz3xYv9319YXkfLQpWjHEs
	ubseAITpBIzPbknv+87hhuhUTtCJS620mAVwq/UBbhzmpgG0o6kToCJ9bLoB0q2eJ1fUbLR/z2Q
	O49oXoMB/7e8eivoX5dKhWk0lpUS22Ak=
X-Gm-Gg: Acq92OFnNv7Tvv6HLzjiz7y3PyE033FaYopSYjzGNlsTFYMjrHagY3c39J/koe3pl6N
	yXXtB2CULLbvUzY1hpq2G3tnsUcb9/ORqQOph8hjixAJR2D9a6jDOVO2nAoM4CXsacGzwBk3rA4
	g3DxPjtbLV1w3RkmDIAiZHMJ9mm+xmlP87lTQnkwzvE9eC/q8APYaEcs6w8jz3fCzRGNyTAOnZl
	MvwOK7P/nOC+5VvN7GB1v2HtOlGoX2z7xKvODRVsCCKj4oGFu9XoUTzDSYHnYdzsBIWUkuzaM0m
	ETMAfDAuRoSmUJ6+PdolnLU9Va/DJTGGGxYIg90sNnOImEeg4wYXsL369lIrlPPpipm4BRxZp3G
	1tCddUZ9xA3+qOE60Hva4gINUtuVyqnNkFe7QPoNizwOoSsfkpNVkWs9KGkU25bQfqaB7H8DxXG
	eaQMTfZw==
X-Received: by 2002:a05:600c:3107:b0:48a:93d2:60d2 with SMTP id
 5b1f17b1804b1-48e7045624bmr133348025e9.0.1778483093061; Mon, 11 May 2026
 00:04:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260507-magnetometer-fixes-post-pickup-v1-0-37827ca68fb3@gmail.com>
 <20260507-magnetometer-fixes-post-pickup-v1-3-37827ca68fb3@gmail.com>
 <0a3e455c86cef14fe3481019031ebf04f98470f7.camel@gmail.com> <af9rpWwL-rdwmQYJ@ashevche-desk.local>
In-Reply-To: <af9rpWwL-rdwmQYJ@ashevche-desk.local>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Mon, 11 May 2026 09:04:43 +0200
X-Gm-Features: AVHnY4JXYk7uwDLVZ0WM65yjsgqAiZt3uhcrDQZOhlDF4t_qySkJVpO2z3AOFjc
Message-ID: <CALoEA-wqzLknSsj-ijzn3LsX7euiJTHcqsVbA7y7LoYiWoT34A@mail.gmail.com>
Subject: Re: [PATCH 3/8] iio: magnetometer: ak8975: switch to using managed resources
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: =?UTF-8?B?TnVubyBTw6E=?= <noname.nuno@gmail.com>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 9 May 2026 at 19:15, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Sat, May 09, 2026 at 10:03:38AM +0100, Nuno S=C3=A1 wrote:
> > On Thu, 2026-05-07 at 16:35 +0200, Joshua Crofts via B4 Relay wrote:
>
> > > Switch the driver to use managed resources (devm_*) which simplifier
> > > error handling and allows removing ak8975_remove() method from
> > > the driver.
> > >
> > > Note, on error path we now also set mode to POWER_DOWN state which is
> > > fine. Even if the device is in that mode, there is no problem to set
> > > that mode again, it should be no-op.
> > >
> > > Additionally, remove any pm_runtime_get/put*() function calls that
> > > dummy cycled the counter to autosuspend the device.
>
> ...
>
> > Maybe it would make sense to move this before devm_iio_device_register(=
). At the
> > point we register the device, userspace can start to interact with the =
device where
> > we have pm calls? Not that it is a problem (I think) but makes sense to=
 me to enable
> > PM before exposing the device.
>
> When you called devm_iio_device_register(), it's already user space inter=
action
> there, so device has to be prepared for that. Do we guarantee that device=
 is
> power enabled at that point?

Okay, I'm all for moving devm_pm_runtime_enable() before
devm_iio_device_register(),
it makes sense to set up pm_runtime before opening the driver to
userspace. I'll push
out a (hopefully final) fix today so we can wrap up this series.

--=20
Kind regards

CJD
