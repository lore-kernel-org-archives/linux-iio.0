Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8BE481FB7
	for <linux-iio@vger.kernel.org>; Tue, 19 May 2026 11:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779188882; cv=pass; b=jGuTL+9ZYp+ZbNQo82YItuG1hm+QRYkwzIqOwa3lAEYTizUWmMLTW0bkS228509MvsxzfQCEzCKyxh/TER+pkHdqk7HTzWCiGuCsDWgM5RL6kMjTyPwxb+bEXNLFK38XX1Xwy2vjK5JvM6ILtSnPoCNCbH7cpgp+vcqSs8JyMGg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779188882; c=relaxed/simple;
	bh=nhTmhA7EtvBhVzOtpkjubbcdCBekT90z9FnlkG56Nt4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WJx5MlhHfBSkXLWTKL7ijyMk0UCVz0wXrZhLAdoS5GvW96IM8hwpNRp/yloWdxYYVNxq2ksSQ5daxuGt+MJL5Z2IR5zemuz3IsB6101k31Q39pFxVqT4UJNG91Q+z/fDmxRhMau7OUWxqCDbmtbXL5Z09chLOtDkyhdhoL188P0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NkzOT8mX; arc=pass smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NkzOT8mX"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-2f16c892babso172314eec.0
        for <linux-iio@vger.kernel.org>; Tue, 19 May 2026 04:08:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779188879; cv=none;
        d=google.com; s=arc-20240605;
        b=VYx6quXkJ6EOAJ4qUO2Zndfv/Ze/zuqh6Gg3OYqCOw1Ur4elYaxyRz8o0SjBbtdNZ0
         WEhhnbkHfDE+jK6SxMSoJY3gzy81GXDMEaciSNIaeBxlSIwmhdvgsNkPbxPL+udnzgAd
         YgNhDz2/eGfadLk+eS6MypsOz2qYZgefS7ScfTbP2GQ0WRLHUbY1Q6B9/vAtW3R8TfiJ
         aeUfKOkt9txyifMW6TqiGRFXKRgqDlqSSpgfqVX1Wn8L3/nUbvXBm4GtsenCoZWZ9KzH
         QzH77T2XfM2VzN0QKefA9ODdgGMR4W1pKnmb1grxoT4c7Elul/qchWjpAiEXWzZxFCO6
         OZdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nhTmhA7EtvBhVzOtpkjubbcdCBekT90z9FnlkG56Nt4=;
        fh=RxIr70OPwa3J1g9c0dnw58lDIaupyEJiBCgZr+Gp+TU=;
        b=l27dGHKwtSGqEJIzY486oP2n59RBEnUAQZBtAoTaY5XKQn2bwhmuIDrZo3xkTLT9sK
         8ojU8//ObZvOkrdnDzAaGYggkhUZ96FhLUfyTvhozahtrT4XXvTVTO3pVqncIaY48rR9
         tpn3MroEIx5Oj9OM5XaDky3hF/OYp4lZYhws19vF5g3TsMBAEv4LWeKf/d4e8aeT1gb7
         53O5nN87QWOxnYDPPGiU5+M6dp/E0TiJZPO28peVKGy4a7PvoeEYrLYPMQn6BSXRj27p
         lyrfa15kKoLFvvG+kzIQ/01c9mClag+ApOIhQ68/rAWuz2bsPghqWmMoEb5gsHylYG0d
         jcJA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779188879; x=1779793679; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nhTmhA7EtvBhVzOtpkjubbcdCBekT90z9FnlkG56Nt4=;
        b=NkzOT8mXh6bXhnJvqEtApaE4S4veNhy2u4ev1hghBlqH6x0n92yVBDsJ2dVI/ZJivu
         9A8hpggl+UV+EG+gZ3coLNVauocffm06kPS6Vsilr4oCfGSd+pU0V/7UWBN7MJ69Qwj4
         R1O1gypG77mvtOgIEZmtoiOoxIxx/0pznmMVmWyQ4agGZcSLDIFoxyo9RDUI+MxRlN+5
         IdgW+epOIw+p0gT6dT9gkmNG7DD8Tr7Gq7TAph8w2yFKfIgDr2gJ4ppcyT6UkCIFCNyf
         8Jw0CWqYMJEIAQUcdMZMca1DkDroniAfLQjNSAqdcZYDK/d8nqv1CAJ1GQZJXX93ZFJ9
         eCEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779188879; x=1779793679;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nhTmhA7EtvBhVzOtpkjubbcdCBekT90z9FnlkG56Nt4=;
        b=Dy8aFhIk6qsnn/n9Aj2Msz+2Sr3NoLTZAgTBP3Y066W5BZuK8Sh6inYfvqIyvNrwS2
         OZUJgEe4apI1Jcw947Wx9h74F92JfeGATvggwNmytvZn92zk6cgX32yKzTubdX9Bumv9
         Sap2tJ9tfygdI6qzkmYeSrQsXctSr826+qlISFqLCdRSUdDygT9y0bbgfbpm6au77WL2
         1jiLEwjhhEpNqnlfbHrdeTvRiAQaOiMkQmxQdcjFlNefoAr9u/+2BDRsdspVjQTNhcQw
         xFsmpxuH8uwgeABY7ZZ6NXrINpp8A4BDX4t7liFSqGLlPDNqxEm6KHRrtXLJMEvNTEZr
         GUkw==
X-Forwarded-Encrypted: i=1; AFNElJ8TSUnKNlNRCXyjE21ScVlxUmEWTmEXIiBCOso/1e3WftOV00SLud5fGZ390F6AxXQ0kaVjBkT4zK4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbTKEulVQZnVBXwv5t1AiT3xCF/gkKUU8kfCgnviNYiqobbJpf
	osRQXgR3mYRv83ieG+55KVITsglOqo+DAIRp4JzshTj9nG5+HTY4kLN4XVc9jbWkpSrDfEJtFGV
	ysvG33xr4aSxug6eAXHPw2eOLCQenQxY=
X-Gm-Gg: Acq92OFVwkCCfNZHW+easX9WgkmaAC7qHoargONnMfsBb+N4/DvUl0/+0qTg1oNmYs2
	H2802afPjdLW6MeibZyUyYYG5yYQ8cQtY81l7jyIsXXr418uVOuHvwHezUGJilz8f8RSwunF5zs
	LIr6QepfEBkKP1xQNso/5xAKfBHl/khpubR5QL6M4Ggy5C2Axa8JlM4aOfhXlKXBLOSHzZZZ4jV
	5vAGPB+GRKdZ2prb1b6x7ZP49tsqEe+5CW+cmRc48VumOI388kpUxAwjrpCgxPC/jpjhd8hgd5K
	0WVMKdiy9pm/8h/Y9VZ/RPYz/PrJO/PtQAasHbX9KvmUOqhglWAuehpqm2ZJUQVjoH9znf/E1sp
	JT/u/8UcycDEQxveMabyUlxQ=
X-Received: by 2002:a05:7301:6785:b0:2f3:3835:2010 with SMTP id
 5a478bee46e88-3039870650cmr4323491eec.6.1779188879399; Tue, 19 May 2026
 04:07:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260518042833.272221-1-enelsonmoore@gmail.com>
 <d40b1e80-37fc-4c88-9d7f-dae6458efe6c@app.fastmail.com> <20260518105735.GW3126523@noisy.programming.kicks-ass.net>
 <20260518172444.zyd47mcagrcwu7wt@dev-vm-schuster> <CADkSEUjhq6HSdg4ignzbuJiN5uXATsTdxFbRJ3BMxs5=WUWLDg@mail.gmail.com>
 <20260519103012.blot4bssgiqfer6p@dev-vm-schuster>
In-Reply-To: <20260519103012.blot4bssgiqfer6p@dev-vm-schuster>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 19 May 2026 13:07:46 +0200
X-Gm-Features: AVHnY4KWOiWEY77zuE66kq3xKsBRyVSkUGj1e6jCXaPb6QA3ygej9CY3aqSmM8c
Message-ID: <CANiq72=6oYtHf0Q1NaLXZ+25uQyYbej2xnvUhtgpHyvozhP7_Q@mail.gmail.com>
Subject: Re: [PATCH] nios2: remove the architecture
To: Simon Schuster <schuster.simon@siemens-energy.com>
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Peter Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>, Dinh Nguyen <dinguyen@kernel.org>, 
	linux-doc@vger.kernel.org, devicetree@vger.kernel.org, 
	workflows@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>, 
	dmaengine@vger.kernel.org, linux-i2c@vger.kernel.org, 
	linux-iio@vger.kernel.org, Netdev <netdev@vger.kernel.org>, 
	linux-pci@vger.kernel.org, linux-pwm@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	"linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Alex Shi <alexs@kernel.org>, 
	Yanteng Si <si.yanteng@linux.dev>, Dongliang Mu <dzm91@hust.edu.cn>, 
	Hu Haowen <2023002089@link.tyut.edu.cn>, Kees Cook <kees@kernel.org>, 
	Oleg Nesterov <oleg@redhat.com>, Will Deacon <will@kernel.org>, 
	"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Nicholas Piggin <npiggin@gmail.com>, Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
	Dave Penkler <dpenkler@gmail.com>, Andi Shyti <andi.shyti@kernel.org>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof WilczyDski <kwilczynski@kernel.org>, 
	Andreas Oetken <andreas.oetken@siemens-energy.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 19, 2026 at 12:41=E2=80=AFPM Simon Schuster
<schuster.simon@siemens-energy.com> wrote:
>
> Sure, I'd be glad to do so, but so far I refrained from it as I was a bit
> unsure about the netiquette (can I simply do so by self-proclamation? At
> least the git history seems to suggest so...).

Up to the existing maintainer, in general.

I would also suggest changing the support level to "Supported",
instead of "Maintained" -- that would help justify keeping it in
mainline.

I hope that helps a bit...

Cheers,
Miguel
