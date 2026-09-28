Received: from mail-oi2-f42.google.com (mail-oi2-f42.google.com [74.125.231.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62AE47F3C2
	for <linux-iio@vger.kernel.org>; Mon, 28 Sep 2026 21:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.234
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790629676; cv=pass; b=HD7JHGU3nhIoaU57OROWhD1OLlRmu1I77+rCBS1whMIg1TfPqmhAKKtvRVwjPy7jupa/Qx54gIUj/FKYMz7mDjkNmCkPcGQ1JoyLmmGdshmWUzN66pnd05Ysh4koZ40u9wLxmlHp6PfZrkSzUgpzNBe2G1UT5RBj3JSP1vHQ6d8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790629676; c=relaxed/simple;
	bh=y6msfbNFuQcpgJ7i9i+gI5S8bcxxgxGClBG3WW+qGzE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nKxXZjfxPKfkUENyWcQi6SLyfp3Cjr2KBngBlT2Au/24ZCsciwobRAIouakbU5Mbkwqyy1SxS5mq3I+LzMZkJArE/oBOq1m/rnfdyJEhE3RhNtqwqNAMhMin6OpEk/FxP4yCmOL8YxiXSxwFlA4OfNGy/pp3k9KihJdDaKzyHAc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PiOpfAnt; arc=pass smtp.client-ip=74.125.231.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PiOpfAnt"
Received: by mail-oi2-f42.google.com with SMTP id 5614622812f47-4e6e6dd1e66so850068b6e.0
        for <linux-iio@vger.kernel.org>; Mon, 28 Sep 2026 14:07:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790629673; cv=none;
        d=google.com; s=arc-20260327;
        b=AbvoJXqyBZcCbKIQT9IwOpN9DbE/ToYLf6xfQli6GhPLFcbvxIIj2O4ZULV7fEdcHa
         jR9HhC/pZavglusnb6NWCEyhJXULTlBuBl72PyuFgyKtYQiUSJPpcJ6dfRWCdcBt+vCF
         z81w9sOIZaB7hdYI5SG+4NtOiAVaDK01bosVQmSfzuMdeJoLr0cEyFL89qKLBAze5bi9
         SNeQP7JmmXLzwTGMD9AeUImhi1RXp4KiuCShFLFjCeZWFYZITwPb0Y1dpZOTcWl1tAyh
         lSIOAgFRdmx0hRrGLhm0vdTtVaRdsX7IMASqb0yteu6QtrR/aMvMaLwylxjvMiEY0NyA
         hlMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=y6msfbNFuQcpgJ7i9i+gI5S8bcxxgxGClBG3WW+qGzE=;
        fh=ckLlac3a+8uYYVwzY9RXufaI4Rlbi/xbSoOx7lQfxlA=;
        b=Hhz8LLr4c5ahPMh/k3GwWskh5Kse8IQF88RW9j2ta/ptI4viGq+XtlUAwJ6o6/HU72
         fWF0RDtLds5ZIyL/Vl2WpeCGYhJ2PFKEFrEhEoxi9eBycyO++rskgVzAF0vw7hzzECRJ
         n9uVwkQWaBQCO389gXFyRpaeBjo+ehmU9jLfVIFwhn9xZDTj6bAqxt+Gnjl5YB3520aI
         xaicOSHiqpGezAnUa2w+DPBwMAjrT7EG3FZIzLAKkAQugQuyyVSbu3OXTs9Z7ceRoTXS
         qhZBDpHI2Uy6bEYWNtCUcdcfZNkXBS9Nx3A8/yzG2yGzBP32aPQV+wfEktJimggopvHg
         8gFg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790629673; x=1791234473; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=y6msfbNFuQcpgJ7i9i+gI5S8bcxxgxGClBG3WW+qGzE=;
        b=PiOpfAntCZ8yLPGEeKI+hyFBkvuihK4h3SMkN0//sQ4oh4MFs9l+OC7i1iAc380Uy3
         OnZyBnCoPodHAXb34xATDT5kyc7bsLf6m4rWYCyLxpVdQ/QuvztXl4wPDjNS0NWOCAkG
         t++l5Fb+kIoXz47wu+S4vDU1agAugdHSGWUBhvmHCMfQJ4k+mrrirm57KQBRvZ+W6I8s
         ZFeZcEVzLL0KLbQqxKi5vm7KssnsxO4fUC8REFJNeDUgsZXClUOzJTJfOkTIehGCrUB3
         yAhV91D13gQUb8hCJpYAumFf5s5B2ksA3H1ptMddinnH/0mqzI3q7lbWHJX3WKgBky0a
         cjPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790629673; x=1791234473;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=y6msfbNFuQcpgJ7i9i+gI5S8bcxxgxGClBG3WW+qGzE=;
        b=HK78cKIQZ7Li0MrlNiiHfv5SKhFr1z28gz6xX1bZJXB8tkbvPrMKHnPYwD7jolfFLN
         igBNReYSRnmjaNRkzD+kVgn12tix6x2hlQEr+6SOOIzbQItCf4EPagaVJVrCrGdV16w6
         Vr9OtwjCYVrDDPiXucSmBP8iARph0e4qONkYHIk42nwlOF4J4FLC/fwFnnxh/K84Bm0Q
         7eE7rgeGK7hgoHEcJubVUM0tuZge+HkoFiGMWTZ8JpOmLsysupFzzfDJGgdfOYwYPoDJ
         kIzTDzhRsN/HgcjPRnmqUr5vUMbmqQPBMNXDyVPJHXhsNeax32eRhYGdQ+fx+ZbCeubN
         ZnWw==
X-Forwarded-Encrypted: i=1; AKwUvBzhQQfltpmpmjUqLuYZX3EmqQgpWNhaXXlLe3puVdl60Mtk7bep1e1e+4+U5jfEQeS8Q+1Wuyz+YEA=@vger.kernel.org
X-Gm-Message-State: AFuF++nyMpeqjaOekTcmGZ4wDzstPLGE9HNTWsinegHmFivWEeYc1COZ
	bQOSRzMrvOMwbig8NhwQH5KhoyO33cpjR67nq7X23pywBmNwehNKNE+SM44PWIO7pWFbKgwrl5k
	ukOrnb0HKsn2qVfMRXd4IG1Hf6ScVvbA=
X-Gm-Gg: AYBFou1q+vWqA4Wb3YL9EobRXhAMbL/56rwec3pytRRlAyNSRIs9jf13fqGYc/RO9Wh
	/6/uVVmJw2Mb23ZpHLy4sfoFU9xtuUBA4uhUh2Bo3Bcp+U35W7ExhLRI8WGJWVXod3egg9LAYv8
	s9BLCQpmAwFKN8v3Z97vegvRBst0taSQduM23wWYuWuLu0je1dEGo3bWEcp3NBTKrK1oa2fvFEv
	IVt7JRa5KfY5C4pZWIGYytXj2kJJZ49jceIMG+ZPpCxAWwu+i0MP59U2VK5SJtOwHivebaDuaFx
	ldVFf4w84Axuu1wwRnxFpg9YO8rNbMad5g7mH48yyriO5QSjFOO1jiJKT3GfBE3T0wQDxa2B9Wf
	8OXdA3FHi+tuO
X-Received: by 2002:a05:6808:198a:b0:4b3:75cb:b856 with SMTP id
 5614622812f47-4d72a2562e9mr16552925b6e.9.1790629673450; Mon, 28 Sep 2026
 14:07:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260928142450.103799-1-vidhu.linux@gmail.com> <CAHp75VcW3ADQdf68Whmo7yhqu9rdi54YVYgyh5PRLPccH6aUBg@mail.gmail.com>
In-Reply-To: <CAHp75VcW3ADQdf68Whmo7yhqu9rdi54YVYgyh5PRLPccH6aUBg@mail.gmail.com>
From: Vidhu Sarwal <vidhu.linux@gmail.com>
Date: Tue, 29 Sep 2026 02:37:41 +0530
X-Gm-Features: AclHuK8JYQr6zVy-MVLb9YJgMPw7_y1Mm2flQRhzFloJn7TG5F9PXG6HsjEjJBs
Message-ID: <CAFqz8LL0bgOu3TKfxz0Ri=qw09wVHC68CbVS2yZZjv7oKTGwVw@mail.gmail.com>
Subject: Re: [PATCH] iio: humidity: am2315: fix negative temperature decoding
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Matti Vaittinen <mazziesaccount@gmail.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	Siratul Islam <email@sirat.me>, Tiberiu Breana <tiberiu.a.breana@intel.com>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"

Hi Andy,
On Mon, Sep 28, 2026 at 9:01 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:

> Can you use sign_extend32()?

I checked whether sign_extend32() can be used here, but I don't
think itcan be applied since as per datasheet [1], The temperature value
is sign-magnitude such that bit 15 is the sign and bits 14 to 0
contain the magnitude. For eg., 0x8065 represents -101.
sign_extend32(temp_raw, 15) would instead interpret 0x8065 as a
two's-complement value, giving us -32667.

So I think the sign bit needs to be decoded explicitly by masking
bit 15 and negating the magnitude when set.

[1] https://cdn-shop.adafruit.com/datasheets/AM2315.pdf

Regards,
Vidhu Sarwal
