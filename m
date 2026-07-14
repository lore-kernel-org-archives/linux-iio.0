Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC6C3546C0
	for <linux-iio@vger.kernel.org>; Tue, 14 Jul 2026 09:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784019654; cv=none; b=XhUqaenPdX85/NBifJrffbRUTMeYINIhYEWOy86A81dUZzjzlCyqz3tqpcb+AHapnXPHKNgK9RCaT7ZbGOnPojxWg05qrxFDHwXI1vRzSvbWqdq/+6XA/HJ5d2UCZt9e4/Y3GASZK/vwJFf/Intl/Eru4LsCRT52CsWtgIDTZ+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784019654; c=relaxed/simple;
	bh=Iv9cW1WMfjs2KT9ZFJDJCOoD8pmxsWtmyCLi4HyjpS4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SvdD7V8TLxqYaRfzlSUTTnZ4jpfvkzXA94JdX4z5g0Py2pgiujKNR4vqO6ki3c6/OoRBbjkYy5btP+1B/beyK98tATbN0JB1t7aPcs+9HWuZQXdOKx4Kh+iRoG+opCoQsszvsYWzhL5Ut1T5ppqMx7OXz2Hp79/gEWbg2PDJ8Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=loAVRKvn; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="loAVRKvn"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-47f365afc5aso1219661f8f.0
        for <linux-iio@vger.kernel.org>; Tue, 14 Jul 2026 02:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784019651; x=1784624451; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=iUXAkYB1p6vSFLZE1EeyIPSmBDvSrDnuYpUUHLagoMA=;
        b=loAVRKvnAElIv003UyJfu48Jf6FHniwG5z4WClM4Oi6mfgpyU5wjP3Han7lbbCovEO
         AXO5P9IghdYOUekVsSkY/fESShQ66Yf4h5fn3PtEtyMRfOhnxI4h/uyY8shD4CWXAlz5
         egURNc+ZxAcuoVt0oKqrwcs5+Aenirqmqym1b7oMYkij7Tuns0VQbs2xsoNu7GnMP1Xs
         216xNAP7iGgk9rH3Bc8TaxK6qfr0pG/fWOqckWaZc/YGFZJt9lv6Odd4MhKg6tLJ6UOI
         SJCIud4YSF+JmYvPk29LPeC40ScfDlJCsWm673wcDXqj+hauNPVsf5xEHV4DaTEcTbwT
         U12Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784019651; x=1784624451;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iUXAkYB1p6vSFLZE1EeyIPSmBDvSrDnuYpUUHLagoMA=;
        b=l4EhbxQ/Jle//qKmhCCuSAJZbx0iUgYuiHpFpYhOXkrHgSKf/HYwn5e19DHMoF3Vgw
         PZGL0lEs7WQ/8t+tmpQLVbGOLDAM1cGc78EguccdJCbI1SkG/LTmn3RMd/Lobuj5jFvv
         IVl+nwpWKeYhdV2KEmvYupKyG2iT+lsO7ir10xLxJcJH0q9g2M/Zc3/ETQlsfuH/Djtq
         zNKNiMUUPX/1Frb0QW5i45iJ4rJ8e5ZsUWyQnl4GVtFSlOmDEhEjEbS5h3UTOA/Jjhjx
         QdZnxb/rLKPz0pWkekltwUYWPEX3CL1sJN+iGBVqs9a8xUuI8zhJv1TUatotM6leRRbE
         HVVg==
X-Forwarded-Encrypted: i=1; AHgh+Ro4SPGuQzkmGTgOXNCLaFWiv6RHjN+T2N+3qRT2WmQFSnh3N/DuyNrBAe58teq+ENBgup2UgS6Jtzo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEqQpAzHMOOv6JOQB1Kz2brGRUPJT6bo+OJE6Q0KmVq4awhQe3
	L3FrOsvWgosaMwVDf+ollb/MC1eRZsAPJ1blpeWLhK8Xl/oHsHdqtmcp
X-Gm-Gg: AfdE7cka3AHLgplTbA7hrkOJsIT4B6RDGnLM+lD5O82X5K7WOwe8AWIEUFFW+ohmzw0
	EFa5U+cTCRfOaKlQRVM0K+BvCGH14hmWcfpOQeKGQwTaiKoC+i5Cl4tP47q+Z2XPVIXWlX5/kez
	vlg9B7UwRRUxp32Obv9+ZCs8LthhBeAnpc5B7pR29KpYovFgKJ+5Lz0CKDo0CTgPYpNwjDZk1LH
	4jkqgBsls8Pb4fBEV+zHVtipj0kq9bqflFky2rxNW609zWHpRfLhcQ6Www3620JRnTceSXc1RQB
	eMF6xvfSlp8wxKu96oKilOdZHXVeCAa+VUW2i1QDjw6HhtlebTyQlnW8slXx5Xx+z5s+jw5Kqlx
	9NxpL0D42IQp0NuNgKm4JjlFgMz2UAG3dKbkF/vuvMATMM8XiU+hJeNKx1qPUrl31jE9WycczJn
	gI6dM1CLpVYyrR93NHcgayVL/D2acmqq2iOGx16JBy9+2/YspCWGHU6Uhb373t26COBwN25D35E
	RcZiBAjr6xdbCbstlLvaA/FCxCjcXGCph04+zVmQtKd72rbkB8bmdhV5lFAGzp5PWqwUjZBGDYH
	/fOSWCjwun9djBxhU8/zXSLrTyntCYdDLXuWVDWVeqc7Q1IsiWnryN04qCNGYP9CwNeZC614TYU
	jdcPVtBAhISf4hjL1c/ZyOc0=
X-Received: by 2002:a05:6000:40ca:b0:462:e086:35f with SMTP id ffacd0b85a97d-47f4887e210mr1712526f8f.21.1784019650771;
        Tue, 14 Jul 2026 02:00:50 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f464c9cc3sm6495818f8f.35.2026.07.14.02.00.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 02:00:50 -0700 (PDT)
Date: Tue, 14 Jul 2026 11:00:49 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: OrangeBlack0765@outlook.com, Jonathan Cameron <jic23@kernel.org>, David
 Lechner <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: light: tsl2583: migrate to sysfs_emit() and
 sysfs_emit_at()
Message-ID: <20260714110049.00001c34@gmail.com>
In-Reply-To: <alX5FkSyqo6taYl9@ashevche-desk.local>
References: <OS3PR01MB82448EEC71E6AD3236F39E3FAFFA2@OS3PR01MB8244.jpnprd01.prod.outlook.com>
	<alX5FkSyqo6taYl9@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 14 Jul 2026 11:53:42 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> >  	for (i = 0; i < ARRAY_SIZE(chip->als_settings.als_device_lux); i++) {
> > -		offset += sprintf(buf + offset, "%u,%u,%u,",
> > +		offset += sysfs_emit_at(buf, offset, "%u,%u,%u,",
> >  				  chip->als_settings.als_device_lux[i].ratio,
> >  				  chip->als_settings.als_device_lux[i].ch0,
> >  				  chip->als_settings.als_device_lux[i].ch1);  
> 
> Now the indentation becomes broken.

I seem to be blind when reviewing.

-- 
Kind regards

CJD
