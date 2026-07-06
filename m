Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF713321A2
	for <linux-iio@vger.kernel.org>; Mon,  6 Jul 2026 07:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783321473; cv=pass; b=etW7CxjdltkmYOFYpTLC8EfZPvdXHfbjkjB9Sc5wYpkO2BG2dRooGqun2lp4UYCIb7o1uQJN/aggxMpZyR3ov2Op71YAvQEQfG9mrwpYXrP8MhlHMfvY6xQuibXlQbADxB5n+ZsI+2fK7WyxWSIBuWMhUU/VhSDqSHvjzrjfcBE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783321473; c=relaxed/simple;
	bh=E9hQasR6dwZK8+EBO9Z+TZpz131Rl37Vi8LINWECFTI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=btP7zcVRPtR4IFix0KmjXeNqA9wXFk8j3tVQ+Gf9trOK5KSQGik9Mybg38lPEKnuzCr6z0+9chq7Jp/R2GPJXnbzmGvC+IGiuwjlNsqBHJoNEMeiuO3vUsFM5705xXU3UHiXhzvTCi5l08/qVvxCGBcF4pCtSGwIxhkBH3Y38yc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gbz7rKkZ; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gbz7rKkZ"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-69531108f25so4621227a12.2
        for <linux-iio@vger.kernel.org>; Mon, 06 Jul 2026 00:04:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783321465; cv=none;
        d=google.com; s=arc-20260327;
        b=SwUHAOboaRkjIyWGc26eSquir5JidV6thiQRZ9303eNtABlsp4dA+KJDmlhB6Z1maz
         3SG1OoBt3nAMdEAbtyXWC9EGgFg1EY3cExK4FQPRU7cRaI1e8O3f/2cxRYlPXkbdZ/zr
         pFcmMEeS6TV/nvMHTdVugGdLUwSjaNyb9oMNtBo+ZaKITBhmW5fEKhzjGbEihCj9zg5K
         bY0R1mC/RwwgomUmdYm9a6yYQq+lyrwpVWjAe+FsjfjCMwYinHCPbIqz4wpYn6wUnMwG
         ehSWFz8/B6hQVtqS5DhaZAy9MlCNAFKgEDfo0Z3HX4tOVVubYBuZNXnsBZqrXeeqMT7r
         xnPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=klAeP2HSugGCLuS0ctH65+dRTY6E0KXiwNeomFrA+Qg=;
        fh=bPUco0/jv2ZwrcgQTxZAngOIHB+ROk7z0j4+ZKeGv0E=;
        b=GDByaeir93FVDo2T3LWy0rePyGLjU6KhgATaZPY33PbmjqtpHIwkRDlstnMAcwffF1
         iwHssfIW8ZM4WIIO4r3kSP8NIDMtJtectjDaejGXnXypCFIcihnpFCHzMBYRB+XTu9uk
         mzcs8k9OPEBta3Oukf3+eHQuaLTpI7PtZ7ZXN4B3w/k+IX6yQ4OC8C/Y8cDJ9MMAOj17
         bp0d2w9+ydeDY+9lw9fMdu5ySFmB6pHRqqL+vwvfWDemIXK5XQFsITR9a4RE8owSWvAG
         vH9AvlQeX8QAEhqS/c0amtmwXhoDvW1maMyrXzYAH7CLzlhiftmsG6nGvOMRfOA/jIxL
         TKlw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783321465; x=1783926265; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=klAeP2HSugGCLuS0ctH65+dRTY6E0KXiwNeomFrA+Qg=;
        b=gbz7rKkZTRB0YtlIpzOQJd1atyXbSNXaPm+ekeohgnHkKw9gH2c4yp/ss4wBy9Nm53
         yMCDiXhLs1tPWQx7p8PrwiiIGlPQ6TEn76wXTdxu0c+gJQMgLIhetw3kyZP0uSZClDZj
         U2rQ0lCv32i6urBKu46ob9PZn6ptAPpLH9HrezMDggl2DwDyQw1ZpccPstdQqR6lJsaY
         41fMGKv/yWT13nvchLmmuUL41VDG4ke5MC2ppxw7awV3OebpNn2eJLHs66QA9Iae3kkv
         kmnLZhaZvS8Q8uLsyaHRE1Ok8Ezk+vbJ31K+WgnKApEBV4FiEB7GTFtE9TS4uNfiluaB
         6/aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783321465; x=1783926265;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=klAeP2HSugGCLuS0ctH65+dRTY6E0KXiwNeomFrA+Qg=;
        b=JwqN764zrlEgC2rev3o5bPd2dITHb49a0/67hnHMIoKEXSCPByMDmHr3wwlMf/aWTt
         1yQvxAGP0DvSXqzdGQpHC/STu8BnIcwxJcPNr9tPhtNuxVj4hczAw7P8jLvfv3ylwxJL
         VopDRph3VJ5tlURS80RCj8eJxYySOF0r3bdYj8Y45rFxslEqvHPOaUjMFd2rDyqRTwz5
         yAKQCgHNgPjhkLfTIvqcPy90xHN5LQXiIJR6XzDQOkrdLoXeF3Fjeb/MY4zDH613bwyp
         KDy2t+9OX2FO95NN/pGzbk1APhy3Qq7XyCz3iQE4B0FpH84QDIMZsWvZfj9MpsncK1ci
         77cA==
X-Forwarded-Encrypted: i=1; AHgh+RoCIJXV98ruA6Whrwb3p5h0knoHXo4pO+cTjH06uwC2bZ9SYZHn2/RxqW7nuKqHLpWXbS2LGFoPZZA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yys0JtA9sbasCSP+n7Eq/H7uEb3ly304bkz1590Lf54+QUwANen
	IUxPa0Tb3FnoBBbrAiVStCk7iCkuVDMzkWVV74Cj4cIXE+66kMneou4TYUh0CJRnRIdz7wSY6as
	7yIB0+sQdex8snRtKpkFF8VqZfdhUXG8=
X-Gm-Gg: AfdE7clr2T4snJT8dsbLqT/pdshjaeNswd/MIytMMsWZqoFXKh5ep/WL5mZZ8DqTS9y
	Fkq+YqtiIpMT56yRUM9Q4lSwkl5AGmfoGoVrofQW2eRGBi61jrlIdDeS4/2WiLolztSOs8iFvbe
	EvTMFgQHK+acN7AN5G2eYbbZlP0nCpIj1EAhAoxCV2SCvADWZYdEY9WK+DwRZXz9La6mjtVf9Bd
	Z74jSIBu0uRC388NHPnTeHFmaRWyfI9PqUwX3b/kmHE8ThDnISVS6U/qixmxBE3upEW4C3Vwqz8
	1BaqZB79pmsw6TFYy4AOaYLMFYhjzaye84TFarK3wsL++UrKA855fVv7wBSaSu9lMEN3WmIWAbc
	Sd2s/+yD2q5qsYdG8QaBKZjT3pNDSw/jTvcscLZnrvQQNGef6AcEr89dsV8Llf8V2kdnB
X-Received: by 2002:a17:907:a03:b0:c12:94ec:1ee6 with SMTP id
 a640c23a62f3a-c12e6c34f89mr337290766b.60.1783321464633; Mon, 06 Jul 2026
 00:04:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260705172438.119204-3-krzysztof.kozlowski@oss.qualcomm.com>
 <20260706003712.753a5870@jic23-huawei> <aktFUqFUR0-Zx8uJ@ashevche-desk.local> <11ddf106-9b69-4872-8635-aa934e4dc20a@oss.qualcomm.com>
In-Reply-To: <11ddf106-9b69-4872-8635-aa934e4dc20a@oss.qualcomm.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 6 Jul 2026 10:03:48 +0300
X-Gm-Features: AVVi8CdFvSswE-AANPUGtemRJ2DavtQam7vfjnUP88bouP0ptvhRf4lKGjHKYS4
Message-ID: <CAHp75Vdti_Y6YFma-vukvpYwvYJ5QvYGv991qewHG3BVPTyjFA@mail.gmail.com>
Subject: Re: [PATCH 1/2] iio: adc: ti-ads131m02: Drop redundant NULL check on devm_clk_get_enabled()
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, Jonathan Cameron <jic23@kernel.org>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Antoniu Miclaus <antoniu.miclaus@analog.com>, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, linux@analog.com, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 6, 2026 at 9:55=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@oss.qualcomm.com> wrote:
> On 06/07/2026 08:04, Andy Shevchenko wrote:
> > On Mon, Jul 06, 2026 at 12:37:12AM +0100, Jonathan Cameron wrote:
> >> On Sun,  5 Jul 2026 19:24:39 +0200
> >> Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com> wrote:
> >>
> >>> devm_clk_get_enabled() does not return NULL (only valid clock or ERR
> >>> pointer), so simplify the code to drop redundant IS_ERR_OR_NULL().
> >>>
> >>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.=
com>
> >> See the stub.
> >>
> >> static inline struct clk *devm_clk_get_enabled(struct device *dev,
> >>                                             const char *id)
> >> {
> >>      return NULL;
> >> }
> >> Not sure what the reasoning behind that is.  Maybe that
> >> clock could be already on?
> >>
> >> We could I guess make this driver depend on one of the clk
> >> related configs, but today it doesn't. So to me this NULL check smells
> >> of protection we don't need so I think the change is fine, but the
> >> patch description should reflect that stub and it being considered
> >> reasonable to plough on regardless.
> >
> > Ah, good catch! I have thought for a moment about this possibility, but=
 I gave
> > tag anyway as the stub thingy should be addressed separately anyway as =
there
> > are many drivers (I think) that do not check for NULL.
>
> Except these ~8 cases I found (I sent a bunch of patches), no one checks
> for NULL...

Thanks for confirming. So, I think this patch is good to go (maybe
with the updated commit message), but the stub perhaps should also be
addressed at some point somehow.

--=20
With Best Regards,
Andy Shevchenko
