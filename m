Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387F83D1CB6
	for <linux-iio@vger.kernel.org>; Mon,  4 May 2026 12:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777898045; cv=pass; b=ljpWibpfWTVfkVmD4B462ltw2M19mMtnZ5Zoe29va4wolEEX+c2EzAlz3xXVWFdnE/sryKlA14/U0PSC7Nxcp7RQSIN2R+zdIEKiJNX4H8rY7asUy6Zp28yr0P8+u9ZNl1ZUzh9nVMFXC9I4iRW/2ttBeKdHhXnu2EYQGymoGk0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777898045; c=relaxed/simple;
	bh=fdRzuOE2JukbcFuhzpeBC4aQS7QxeNaOt6L7+0oD+r8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iE623669vggteFqaDMZV06Q33fzbdet52AjIs7mOlrlMX2K2MDjmBaSk8g4EhBc+asq9jV9cAmgiLbZlco8MDBbHzCbjr1IJ3vqfjoLmgh4wZH6KwkMqirRr61w8Y/SNNUOxkRYhZuinwvO9s0cah5EaTluhZbsnP2en90EjwQU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wg2bktm5; arc=pass smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wg2bktm5"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-79cd8f8e261so28900787b3.3
        for <linux-iio@vger.kernel.org>; Mon, 04 May 2026 05:34:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777898043; cv=none;
        d=google.com; s=arc-20240605;
        b=cWx3BzajiEDHc/tYzncZWwizJT4BTQM07sFh/LUKTFiVxHTMHJfH6APstu2PZv+u0k
         p4f2MWsQ1DJtMGnrWlQH7KL4bwbSLePbvyh1doWFwTLYfUL+1PDCOKM2dIHmWcJgOCCW
         JnkhgeWSafKJr0VKtqhYr2RVTiRUB2kQ5GCDLgWMiWxen+vvZMSJmhhPTfV7IqC+lN78
         Hlb76q8Cjz+aMw1P2/lsyC8fFgTnnWuMe7w9e7q8rI59xeCvvGxTkMsAF3W7UiTDUOdn
         Z4JQdrFx8Wdqi8l+nRLO1KFXg+VQuB3vwMrdZsitiUGtr/ZY9cyL3MaMJGkzu7dqbnKv
         9P9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Lpwh7LTdKk3iuzrAc4lIytt+Woc4z1HLw/5auAee8Dc=;
        fh=uRsetCR8kf7C1Jr7oP2k+YJdb56Yj5DY/oCkv8tpkEM=;
        b=ae8q6Uc9rTxORstl0IIzB9C4xSQGxU8xVZ0kApq5YCgHUvuqIBQsPgvTt9URdPO3RH
         JF/FaSaNF8mzFdjP9xpVP5Rp7RdMwXo7a2/wMfauo4r1IzUzxLkV/ooz6y2gLpXv+02U
         Wkv/+VO/h//vZKNL5IF85wiKnyGaU3u7BLa0+FcXAsTUc+vMPWUYFyx/dd75JTGoeygf
         ekcvevPY34gaOLoDlZHZi9K2HRiJwdSuRS4guWMvrrX9GujA2iUFv/KChd2wWIPaFoQG
         eLmAE6qgmf74tXQ03e+S2+EoC7tEuG9Ui72L+eBeg5V1UXoTPDdEMrbQDC10/mOsmm2Q
         A+Qw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777898043; x=1778502843; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lpwh7LTdKk3iuzrAc4lIytt+Woc4z1HLw/5auAee8Dc=;
        b=Wg2bktm5iypROhHmaHXHpSUTsJid1bpRFaOHeoeFQM+QguUEWRhazAYVdKdOBkZUGy
         mUdf54XHFK0tpFzIt6kkBfkXnfpJ/BnLV2INf9Itl7F/ZIoAoTc2gS9pW9dh0v2H0JgZ
         lvvr9bjYTOkvchbVeX81mQfTIo5NWqH8UtlVEgKoBHEeJtjG5c5NtBEFMLEHWWQ3TMfU
         fcDvSj9OvbjD2sXoS+mVvWupMAqvbiSYVjFJXNS4jPYjFz6eP9pDnWrGsEibF1sM+Fg6
         3ekzsn3IeGcJVCmIUXk1dWmUCW7JJMC1O+rO1nuiqqYIilT0u5j8s6+bor2qvkhqIjXG
         08Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777898043; x=1778502843;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Lpwh7LTdKk3iuzrAc4lIytt+Woc4z1HLw/5auAee8Dc=;
        b=ENx1jvoJphKzKq0d1aP+0VwF8eG5OtZUsqON9MNSsHJLcpEuNeB0IYvsz9pAQ24FSc
         4zlxw/5Tu5bFWZmDOk5MAgZmcuvLXKZIGpufSn1kGwOEbG/4Z18iGSxubPcTND6comGT
         P1ibTvuc7zE01MXp6CzjVV+NKGOO2MQKHCN4e/CoLtjvizP2UPXmDPcuvAz4uNb1yYie
         y3RFNR26e71gpQYFGcriia4PkyXz6oCY55sUPacnUQTdrzQTdKx4YuPTy+J4F8+C1a+S
         Vkkq1ijcwzqtdcVAQS6v03b1y32QYuz8qu08aMMymArFNMtPfGKvDplHUOUF+PqVKydv
         mVtQ==
X-Gm-Message-State: AOJu0YygSAhlBLDJ1RISRZLXDerfIlS7WskM8lv3uavCIBoiTeN7Ko/f
	6sRQQpYsFrEhJVy1Nri7lsSYAH55SSIa9DSoC85zajUcBLFNmJ5zY7v4WqBzGJqZNYPf6YAGkvr
	7rGfJtm48mNVmPprYMCwi4Qscy/ds8Do=
X-Gm-Gg: AeBDiesjft8WlV665g0UOnEmQzj94YNuJf3OuBhCe2M5lTlRZwgF7P82rLDvhXKXebb
	KVqboC2h1eJgPxacg4Ntnpjfoc0nidgjtYiVG8Fob0l4xEhGyonIBFIuuRnNhj5iTsMI/8bGNSM
	JYX0ZsFuOn5NDCppMRHMmx9nuXWnJKZjcXgomYg6nEyZ/eu3EX3oyvGMFM8ivusFPT0SIPVmxj0
	PchpGAyZ9txuAfRNMez7ZJnz9CbgDdJKAnC0iiw629T/p7aXHCpmnPAa1xdTtdmJtoD6GdjSlH/
	+mSZ29yAUKQJHGw=
X-Received: by 2002:a05:690c:e094:b0:79b:e346:fcfb with SMTP id
 00721157ae682-7bd770df5b9mr91665357b3.32.1777898043205; Mon, 04 May 2026
 05:34:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260504092059.1536094-1-angusg778@gmail.com> <20260504092059.1536094-4-angusg778@gmail.com>
In-Reply-To: <20260504092059.1536094-4-angusg778@gmail.com>
From: Maxwell Doose <m32285159@gmail.com>
Date: Mon, 4 May 2026 07:33:52 -0500
X-Gm-Features: AVHnY4JyzW74CEzgIwtXgm7P2OtMfbQwu5ChxR-G6flb6oLVOdZORlY_wrThGGQ
Message-ID: <CAKqfh0Gfwnaj+chzWUvujSVrw6wmqJAhSL9O2eYuZ136QbbD7w@mail.gmail.com>
Subject: Re: [PATCH 3/3] staging: iio: ad9834: fix chip name typo in comments
To: Angus Gardner <angusg778@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-staging@lists.linux.dev, 
	gregkh@linuxfoundation.org, jic23@kernel.org, lars@metafoo.de, 
	Michael.Hennerich@analog.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 4, 2026 at 4:21=E2=80=AFAM Angus Gardner <angusg778@gmail.com> =
wrote:
>
> Two comments incorrectly refer to 'AD9843' instead of 'AD9834'.
> Fix the copy-paste typo.
>
> Signed-off-by: Angus Gardner <angusg778@gmail.com>
> ---
>  drivers/staging/iio/frequency/ad9834.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
[snip]

Looks good to me.
Reviewed-by: Maxwell Doose <m32285159@gmail.com>

best regards,
maxwell
