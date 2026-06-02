Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA563DB62F
	for <linux-iio@vger.kernel.org>; Tue,  2 Jun 2026 11:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780400705; cv=none; b=fs1xcBJBFojKc/3Alw5twkWXit4vAJ3tE2rGaBJ7aovZa9ejEclM8SqZ2ysVtsF8zPT6ouZDvqek7n3EYNRSoayGXHTaNyiw8RkNtb9utRTBxHnHcchYoF6iawHtxjSs/zVE73Z8v22AYWv94oA1hxIaAyZoABJNpzWRpzFCH1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780400705; c=relaxed/simple;
	bh=aOrDuQ2Tm0lJP3blA7WVN2huWRSYPyzQna+BYkEOMtk=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=E5a3NR47aTxXTlHMjbeZgrLhSNNkFMkrOG22cd1Krq0APr63T7zcr7aKqo8mJUvqVGxA86wLn0M5J7DGxGMrFR2fzSHxO7JP7qfXMnwurgSUsNU2NMN1hQyMD3Mfb3veFDw/CDzgk08klo5y1X7gurQQtnOOEvcn9MfDucawlMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iaHj6zI4; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iaHj6zI4"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-45ef82204c6so1842888f8f.3
        for <linux-iio@vger.kernel.org>; Tue, 02 Jun 2026 04:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780400701; x=1781005501; darn=vger.kernel.org;
        h=in-reply-to:references:cc:subject:from:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aOrDuQ2Tm0lJP3blA7WVN2huWRSYPyzQna+BYkEOMtk=;
        b=iaHj6zI4FxcmgLThWYP4aDQCQi72YeEaVPadwQwoQyjDbTZCT35NHRJdSXm90rovuF
         BsOOS1IZGjeVTbWEatrvrCQAioMrxfGj5BgTf0XWjOgBG01yAwadYoSqHR7uv0O0ggIM
         eZrKUpzrJwkoB8xE3Pdb/yODkXAXg5800/j58AkWV/hq17t2ohT4Ym/vO/UKPE0EGmYI
         DuXL+ljZg5ZGYsxnfhXRfvYHVF/94vIe6fWFO0No2tgWrv4niqcNeySMvO1wJQi2IsZP
         jIL1jmqTYINvXmaP7ZVVkjb+KxL8MsJ1NgSGcNeUstDQrTB2Uwd9XgaR0uBypZ7N+bQG
         MkJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780400701; x=1781005501;
        h=in-reply-to:references:cc:subject:from:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aOrDuQ2Tm0lJP3blA7WVN2huWRSYPyzQna+BYkEOMtk=;
        b=Wstcvz525qFu4pdDITl1bRk1VozyKzFrV8cR3yHg/7lmdJ7FMqyWA6SHTIFNXNRc3z
         quIt2BTeJl19LHJPbsCWImkBYQplqSpSn27FFiV97S2Zz7eiO1hj59pDMgGnTwyUihm0
         gACk9/f4xblgzCEYympF2QM9hTmDrkMM3DHrmMZQCWsyqqq8l2vykIbGD5AdPFm724dD
         l1qY1fsznNhsRyJNbo+rtLOUklkAuvh/p2hhIvU+FjQEJJuk6JoVuP3vjdObqCxuaAUg
         mZpwsFCnZn4VxP9Sm28h54yNyVIYBVCiidPC5LoqsrzkzFTpKuEb7Jq02jlYmftsa81v
         nqtw==
X-Forwarded-Encrypted: i=1; AFNElJ/4U2BfXB5WpxwL+XS0VbBnauQUxB8HVWULf/uM3XQv2enwnNEQG65x5NeYShk9kc2enZttWVcsCkY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywx71y6PFaRFUZrlnY+HWRWBoywiipg52WEQcmocgbhHyKMYfbe
	QU+XmTMKeF0PV9rqpv6bGYiqWG8x0tE8pP10DXCH/Upo40kPaDlQvMCw
X-Gm-Gg: Acq92OFQ7s1ofiHRuVugC4qbNq9//Gzy6Zsr96s23qQQa5wSyXzF737UoxEtGtHWKq0
	7+r1Gw3TLpjLZEnDT1+goO4W819Ay33sU0kutMk4ruSmK5NIOu+3gkG2MmnZImAEXi/dM68e8DX
	bPPX33YCw9abonP9JYV2Mzu/+9/vTwtdkGSfanHGM8P+2Dfibs7P+jszYJPvnAAF+TfuM9Kd7JJ
	dlG9sRH5+iIkECPoUeDs+xJCZcQHXwauWBO9jRwZMV/aJSWY64852+IO5jZYqKLHX1md7aCGLZZ
	kKLyVlt9TqXM8TibinAzjiBMKZGYrBfWg4aarLwVU8PJw9/fhMwdNOlQhocHN8ESl9GcxOkLwQM
	2l86msk2P7vWa0xMEPyL4W8fGG16Z5+1gOQPcnTSLmBk44Uq5zA2A2ydkG99XWkIQNJ4+/Qjb/7
	OXBJzWiTCoLsUie4fQzylngHoi2tX0HC88bzn2hUM1/feLZzI=
X-Received: by 2002:a05:6000:1285:b0:43d:1c4a:37c with SMTP id ffacd0b85a97d-45ef6af6c2cmr23180496f8f.4.1780400701264;
        Tue, 02 Jun 2026 04:45:01 -0700 (PDT)
Received: from localhost ([2001:4bb8:152:df59:3b69:56ea:a39b:adb4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef354cd87sm31232994f8f.24.2026.06.02.04.44.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jun 2026 04:45:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 02 Jun 2026 13:44:58 +0200
Message-Id: <DIYJDHPWP52T.2HU8B815AVKXF@gmail.com>
To: "Javier Carrasco" <javier.carrasco.cruz@gmail.com>, "Andy Shevchenko"
 <andriy.shevchenko@intel.com>
From: "Javier Carrasco" <javier.carrasco.cruz@gmail.com>
Subject: Re: [PATCH v4 2/4] iio: light: add support for veml6031x00 ALS
 series
Cc: "Jonathan Cameron" <jic23@kernel.org>, "Lars-Peter Clausen"
 <lars@metafoo.de>, "Rob Herring" <robh@kernel.org>, "Krzysztof Kozlowski"
 <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>, "Rishi Gupta"
 <gupt21@gmail.com>, "David Lechner" <dlechner@baylibre.com>,
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy Shevchenko"
 <andy@kernel.org>, "Matti Vaittinen" <mazziesaccount@gmail.com>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.21.0-143-g2f3a2e260c09
References: <20260531-veml6031x00-v4-0-e64f7fdce38d@gmail.com>
 <20260531-veml6031x00-v4-2-e64f7fdce38d@gmail.com>
 <ah6p-f2RCW8VcuDR@ashevche-desk.local>
 <DIYI40YK6CSX.2P4017PHVJHCT@gmail.com>
 <ah66ljSiIc0ywFC2@ashevche-desk.local>
 <DIYJBS4F362A.2LIDZAKU7GBBU@gmail.com>
In-Reply-To: <DIYJBS4F362A.2LIDZAKU7GBBU@gmail.com>

On Tue Jun 2, 2026 at 1:42 PM CEST, Javier Carrasco wrote:
>>> > Hmm... But why? Wouldn't this be problematic with reference count on =
the failed
>>> > devm_iio_device_register() below?
>>>
>>> I could move this a bit further down after devm_iio_device_register(),
>>> but as I replied to a Sashiko complaint, the reference count will never
>>> underflow in this configuration.
>>
>> Please, add a comment elaborating on that, it's not clear at glance.
>
> I will provide the link to the message where I explained this instead of
> copying the explanation to keep the discussion in one place. The mail
> belongs to the discussion thread for [2/4] (this patch) anyway:
>
> https://lore.kernel.org/all/20260531-veml6031x00-v4-0-e64f7fdce38d@gmail.=
com/
>
> Best regards,
> Javier

Sorry, I think I gave you the link to the cover letter, this is the
right one:

https://lore.kernel.org/all/DIXZFV822HRI.2SBIT7ADW9LUK@gmail.com/

The relevant information is at the very end.

Best regards,
Javier
