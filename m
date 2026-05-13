Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59AC93E9C28
	for <linux-iio@vger.kernel.org>; Wed, 13 May 2026 09:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778665893; cv=pass; b=P4NybqfiSUFSm8eSJFhyzay6mYUvvuskF/DxvJVck++matYWM2Bv48DZywYpeu4meCR9minoh9wRVQed8EtHuOD90qqLGzkj7qRj8ip8rC3SbfEFzJyXe2AUzh2RS8V29aYD9VVp3/YiLp8PbtEmQ5dHjg7P5xRf5E3xt53KLRk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778665893; c=relaxed/simple;
	bh=0X1D8weRx1XlR4/9bFNrfB17A1+4bazFtOO+uzBk4wY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=paXOwSt7BFVUeGdGlZq4N0IZfHfCuFOXQtyTr0fLgvHBW3Nx5woGAHBRU6kA9+CQv8iUg5xlZ4xRrBcrScoMIv4ZBE4obALVkV2ImZE0K9MY/N7D8b0wTnBYL3L66vGfrsjYFNVkLaF3MFWHiQI+M973n5CNghNlubhJrMQnIV4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k/li7ubG; arc=pass smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k/li7ubG"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-bce57c132b2so524432966b.0
        for <linux-iio@vger.kernel.org>; Wed, 13 May 2026 02:51:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778665888; cv=none;
        d=google.com; s=arc-20240605;
        b=USRmV80NSZEjDYMiTa292mR3TGkRY9ghocTiMoNzL/F7EIUAIbBjKAcarK28Ubtzeq
         PC/DsMkJSefJS1qx8M/RoJ5Bc5WFXb332aEiVVUr56OOwsb8ruHzl1fXHdHQWp8hlGUq
         h0Lh/yOlpAGHpnTxiXd8oYQOOeUhnr4i/ofJw7ZrD9MZBRAspC1fkF8aIK7titmVRUri
         kasizmMf32OR21uFS6F9lkViya8uFVslwk/8ywa0bKHSfUrNGUxJBFgaUtUew/LEy6oi
         4eRNYjKjGX0qD1sg6UqdhBp1LDf79P+dt+4vcP+BVpk3CO1ju8hhcGQrhdMHOqKQrVAX
         3pLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0X1D8weRx1XlR4/9bFNrfB17A1+4bazFtOO+uzBk4wY=;
        fh=4UpSqnNJPkVvhDdtn1hIUxz/HtLuSHM4rmjIFfQn12Y=;
        b=ArJ3FHpN+WwSaorfv0CCC5rkv3qc9/5NY4fCqeT1Ac9TmjjDDcmzX4kfpExRCyjzUM
         JGERuSro65wZeoEDRGC26KJP9wzyRuPGYpu7LU/+ETR9IAunY1bcjHmZC/AXTl3KdsAr
         9A9+zwlHVaOtFObFAO9xnx+SFW1yJ5RB6KHVqnNAaDpmP89nDSeIf32iIe7DxF1pBvpZ
         xuxcFljgTSYP1n3YvayJgqrdLkWB6YRfmPA53JgrlW6LVdJ7R0RgXMfbvBQqyX/mudfO
         gmCYM1JdZnj/LZzXFwiY/UIj/IH9Wqo9LndIxGhbCiHqNT57NfM5U05XlFvdqz/6G7mF
         egjA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778665888; x=1779270688; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0X1D8weRx1XlR4/9bFNrfB17A1+4bazFtOO+uzBk4wY=;
        b=k/li7ubG3pXNDCR7ZbhAbEZzWYd9GAQLulkkvV3IGoddyG3W8TZrbdmulETwe9YiDg
         NP+xcUJAdXUapAgsk7rIqoxqdz7b9MAmpBY9qHECzupGKHO7g7bRqROpC1W7Eo9F/4HS
         itKYXjJlt+4j0ugVZ5FM5hvWuRxVOYa3JcOh1Gab/cNKwYzCmqIoZT9zZte5MpIo7OLb
         o5RuZypYw45PXO+VQYWuRKSh27l7+yze/a+HqSWRh7gPDaAGJettn2G74cB6wrAnEeZm
         zOH9FS//rqX0M2vHxE7ch9IlwiINnPbTKUABIxRiiA5X4+bEEY4pQSDXLMB5owl/ckD4
         Y+6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778665888; x=1779270688;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0X1D8weRx1XlR4/9bFNrfB17A1+4bazFtOO+uzBk4wY=;
        b=lhpwOTZ5KGZvkkNgA13BeTn1nJyg2p5aRsSMXGVIoqHZMC7vVch3SfbtfokRQE8dQI
         QkpYH1JedyPBQiVmdeRS4SkdNOGoC35HDNh8g649WH9kfpZztueIT/sh6lCjAqE3GmJK
         lvHKxSDWGddM40MNoiolV38ZenNdNA4Iaj8vECsaWd/rRaTdFIZEvNUuCyyfvg3TKkLn
         pk1S9HUMrfvXPdJrsJ91hWN8zNblsZUFOQwx+RD1T84ajwVUkfd8CWZi3BRjvt0jO5ic
         AHhoPjqYHgbh+OJZYZNSY0QnQPqF6IkTaTrFd0lb2hFhFWAzkjaEEaoF8Tovla6I6cWN
         pbOQ==
X-Forwarded-Encrypted: i=1; AFNElJ/4JwqCzTLddbD5OwAgJQuqkGY9beoS5apB9ZKSQa0xVO7fi0aLeNiBdSEYwx014AJKcJZTu2BiFU4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywwxqdq0HwGlWWFnrixQRWPbCK2gK1PBylKYK9+IB8S8Pgnw+AY
	MBF0HczA0V5WNmPPxr4htOwroBSOZPAYCJf4yOzDWr2xrItACdWBOCRm1EfE/vwLXN8SyMfO+HF
	3f8rfRodL3wj/mCcTFZbM+CqcbfOxo1w=
X-Gm-Gg: Acq92OFy2ZmHB2qG7Y0oT0DcCVKg5hjLngPH8ns3Zefe9nqVcNC9nZLWNq/IWttgDN6
	3WHpcmHCpFykT+eeAk54wbtHjyYoMTXy6Z69Pi2SOaHooBQMmAURCcxXijnxa4+2ur6Sbpv22RN
	NMtqigqvOPPFT/mJZZuesxEwbZihKs5vc47xPIKpuJKFheioEcj+i1mg17kmqMZvFaUwx1zYhre
	UflKroSXxm/j2KRc5XamWm+xQV55uzrhBHjUzjwYpYCyvuH9jZST8nvjFZtY79G+M8iMx3QX4RH
	gqUmXtja1UvZl81Dwg+I9BBKn9TM4Bz26dFTalS6lcpFnZVPYQ7HVBplSNMLiGhMv02V8hACA/r
	0BCCGn2c=
X-Received: by 2002:a17:906:f5a3:b0:bd2:be3:572a with SMTP id
 a640c23a62f3a-bd3abea020amr163641266b.6.1778665887795; Wed, 13 May 2026
 02:51:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260513094536.8038-1-sozdayvek@gmail.com>
In-Reply-To: <20260513094536.8038-1-sozdayvek@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 13 May 2026 12:50:51 +0300
X-Gm-Features: AVHnY4LL61UXKMNhL-KvCGlTE_H4LX4RmAnjYJyzCc94eVdpIS0eWA5Yke-l-_Y
Message-ID: <CAHp75VegkXgyv3zp+=RcsHZ=kdm9vYFiVgw3BvRSP8ZwhB4ztg@mail.gmail.com>
Subject: Re: [PATCH] iio: light: veml6040: add suspend/resume support
To: Stepan Ionichev <sozdayvek@gmail.com>
Cc: jic23@kernel.org, arthur.becker@sentec.com, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, gregkh@linuxfoundation.org, 
	hcazarim@yahoo.com, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 13, 2026 at 12:46=E2=80=AFPM Stepan Ionichev <sozdayvek@gmail.c=
om> wrote:
>
> The VEML6040 RGBW light sensor stays in auto-measurement mode at all
> times once probed, drawing its full active current (~200 uA per
> Vishay VEML6040 datasheet, Doc# 84276 Rev. 1.7). On system suspend
> there is no need to keep the sensor running.
>
> Add system sleep PM callbacks that toggle the SD (shutdown) bit in
> CONF register 00H to put the chip into shutdown on suspend and back
> into normal operation on resume. The bit semantics are documented in
> the datasheet Tables 2-1 and 2-2.
>
> The existing veml6040_shutdown_action() is unchanged; it still runs
> on module unload to leave the chip shut down.

We also have regmap_set_bits() and regmap_clear_bits(). This will make
your code shorter and easier to understand.

--=20
With Best Regards,
Andy Shevchenko
