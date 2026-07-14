Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA5137BE8D
	for <linux-iio@vger.kernel.org>; Tue, 14 Jul 2026 14:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784039601; cv=none; b=hx4KrBjhGzi6UlrOhTrGk1imdIdfHAsGcKz/ObUAmpE6Rlx3/P8UUZK3WnOay2B2O6ki7c81FP7yaROr0RmnLHpmFqRmgqDqd/+Cfm3sJLXXbV5WHvaGFessO4uVdD33uVcDzNKYZQeVUaGK79MXuwCOHTPeCvPJcpoI4s16MvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784039601; c=relaxed/simple;
	bh=SUP1kQE5p1aa+G20qYy1Hucdars0a6q884T9xd3sclY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N922wBNvTkIV2A9lUtGlr1JLy/Hced/ou2FNyjvgIqVR5pPBxmWOB+ZOaTztNF9Qnxhc51JRwZFU6tCDk8y4X1R7bh3Ad42V6Cz5o8Z+0y9EHI9GhY80N5kEZq9WLucTuQKM9zTG5dlYo/rp0jEr33EI3JdPhqJJNQ0+1gqf+WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E9xwor7f; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E9xwor7f"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-475417f010dso2058676f8f.2
        for <linux-iio@vger.kernel.org>; Tue, 14 Jul 2026 07:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784039596; x=1784644396; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=BCR2ojKh9CG9hna9RsCPgdIHB0rwbpF+LXlEWMO+i64=;
        b=E9xwor7fHrqQo54tObeJ34KzvDtNJnxqqFeEU1Mf5tYNN9LFWa6dS53TlkFb1I1AxI
         xAbTYx773b0pYJvOCgh0yrAijuHmzVygJkefC4Ik/Cd5et49KCPEYRYbCM2Klf0WrU5F
         xSn3E2I9jJCFUmwzDwuWa1IAhdBUDV+snGZlVsvNIPlBKNpVu/FSHf8v0JkvlxlG83n5
         5my4Lti/Ajw11pNzNCVEjoy/yUhf4ASxCuguoQWUyEEvkZc/UJFSd36YPFZXkJYnSjmv
         KdbQPkQlUubJ+lXCnfTZBK3nG8l+KHB/UToE+jocwtN/yXKrb0Avu5nEpJLtItdWa4Yf
         TAiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784039596; x=1784644396;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=BCR2ojKh9CG9hna9RsCPgdIHB0rwbpF+LXlEWMO+i64=;
        b=IMki1k5sSFn4dUjlBClP69YPfvsjMdIHL34LsXP2p7JGmVcm7+aGtckBIVmaMExd10
         haRY8N5YBkPuSpltyh/29drjLjUkHwEwPwbudcdUQd90JAFF6DtAvH2y3aqmWWS9iEcT
         rzCF5vV+rChYMZGPPKGQ9JL8mG7WA4xTDR+OUUaU0Qt3K+AVQPHOJiIcAwaX/lp8BzIw
         h/ttdzGGjnxgxsBzw7lOMslGc7nqOLq7v+18ZnTFu+86+1wJ24bVkhyQ0Dn2YJmp7HFC
         MWYqCEveJTsOFhZZ7bLXfSvkFfZ4opL5MiFSPoIv7x/5QCWZ3VKtl92fU/PhBIKPJzTj
         Qn2A==
X-Forwarded-Encrypted: i=1; AHgh+RpdFnk5DRdGlU6BXurbB6D1mE74vzvOz7jXVkFVHhE4Q+YEEzolv+UqrKmvuZFDeWp2skyxDYjj5pI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywl/k0Q9XNjHu7naci3TZBhkQ9qjd6qGJ6bTKAMZSKrp8vNan8F
	0nuFH4QwpnNRl9Za7TfvH5/LVEBzViDUKSFNcDoW7FhJnRjUaHLUI4XT
X-Gm-Gg: AfdE7cmPM2+iN2SJ8OvD5etFwbYDIk+5DTey8J0BlFuoyc5/I5xp+fFPVYE361qHgOl
	QWLqfFRrIiqGx6X72RyVgvGQb6/F9eTedk7U7aoCL9BlQ0XVnRjhmXcu0BriLdIU5P1xAGvvlyN
	jJfJGsxfkJQrqoqfCHPRTUFSVAVCtDMnprta2zC0O8Pu0NriGwjKaE+8QM0UYZDef5LSVA3JCwD
	m6wRt2jZVZOUa1QvVQAZsj8G1WfN97n0x0coh640F6Gprcv3Ny+CDJZy5wuedoaqI6GTH6NbQy+
	PLjchXSipaNPcE+9TmW2mtnu4pkk970XEFoH6r/4o3NYjWMfb2p17zk/U4YXwFYm5CLMmIGoF0M
	Xb2ghC1Td2derqPk5UUxMn42h10II5t/8xhcjR/j4VGohnU7u6UN5tO9BOT8bSU3lUHQu7DPYKL
	b/KBU7vgccJJIyXz6Uh4QfshU4Zi4=
X-Received: by 2002:a5d:64c7:0:b0:466:6d18:ae93 with SMTP id ffacd0b85a97d-47f2dcb7453mr15499691f8f.21.1784039595520;
        Tue, 14 Jul 2026 07:33:15 -0700 (PDT)
Received: from NSA-L02.ad.analog.com ([137.71.226.102])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f464c7c96sm8599276f8f.33.2026.07.14.07.33.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 07:33:15 -0700 (PDT)
Date: Tue, 14 Jul 2026 16:33:11 +0200
From: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Janani Sunil <janani.sunil@analog.com>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Olivier Moysan <olivier.moysan@foss.st.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, linux@analog.com, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-doc@vger.kernel.org, jananisunil.dev@gmail.com
Subject: Re: [PATCH 3/6] iio: adc: adi-axi-adc: Add support for CRC
Message-ID: <4mtugzv3q72yizfw62b2ijjrwi7r2hro2fbjljeziuotyhuod3@6waqlwzufruh>
References: <20260709-ad7768-driver-v1-0-44e1194fd96a@analog.com>
 <20260709-ad7768-driver-v1-3-44e1194fd96a@analog.com>
 <20260710014617.323acf6e@jic23-huawei>
 <ucrlt75xiwbv3rrc4gvgdop24u54eizhuqzf2av2qsa6ceymdp@kfkuiwuvakhl>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ucrlt75xiwbv3rrc4gvgdop24u54eizhuqzf2av2qsa6ceymdp@kfkuiwuvakhl>

On Tue, Jul 14, 2026 at 04:18:24PM +0200, Nuno Sá wrote:
> On Fri, Jul 10, 2026 at 01:46:17AM +0100, Jonathan Cameron wrote:
> > On Thu, 9 Jul 2026 10:50:14 +0200
> > Janani Sunil <janani.sunil@analog.com> wrote:
> > 
> > > Add support for enabling and disabling Cyclic Redundancy Check (CRC)
> > > processing in the AXI ADC backend. CRC provides data integrity verification
> > > for high-speed ADC data streams, ensuring reliable data transfer between
> > > the ADC frontend and backend processing systems.
> > > 
> > > Signed-off-by: Janani Sunil <janani.sunil@analog.com>
> > The 'other things' I found bit from Sashiko is interesting. Far as I can
> > tell it is right and [devm_]mutex_init() is missing for lock
> > in struct adi_axi_adc_state().  
> > 
> 
> Ouch! Yes, I was also wondering about the lock comment.
> 
> > Nuno, looks like it was from:
> > 7ecb8ee5c93b ("iio: adc: adi-axi-adc: support digital interface calibration")
> > 
> > Which indeed adds the lock with a mutex_init()
> 
> You mean without :)?
> 
> I'll send a patch fixing it!

Actually, to make it easier, Janani will include the fix in v2.

- Nuno Sá

> - Nuno Sá
> > 
> > Jonathan
> > 
> > >  static const struct iio_backend_info adi_axi_adc_generic = {
> > > 
> > 
