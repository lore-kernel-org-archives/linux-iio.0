Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3F61534EC
	for <linux-iio@vger.kernel.org>; Thu, 26 Feb 2026 15:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772119834; cv=none; b=FygOcyGGgME81FOuofCZg1HtE0Qp4B6HeCKuRl4wMIoLab496eS9f/g2pzsCWXW/JOOO1WKX03LWcOPH3N+Ep5TZV0NFmfB7+KCqO9H9zxs4W2GKyrunnKqGzSvS5C91S07QOnKLiAcA1biwkEOKuHKqtmQfY5SWp78+2pmnELc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772119834; c=relaxed/simple;
	bh=8R0cGvCqhs/c6nrRUwVlohFfv2pENyMK7afKYw8TBLY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HtUPcgx3bueSAEx+R/HzrpDY1ukDxqglDTXhSjfT6ycH6ooak1pZQ7aE/sN1LC/nSx24KKILPzcW706r/dMxntPI05AdzXzVD81gj2mJ3jbsBGARamApWnHxa/+HjbJmxJbNsOuU5fCfJTsG3FYjkWkCXO7TlgMJxqbXWkUgxD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=gwgY3CmP; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="gwgY3CmP"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8cb4acdacb2so110224885a.3
        for <linux-iio@vger.kernel.org>; Thu, 26 Feb 2026 07:30:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1772119831; x=1772724631; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8R0cGvCqhs/c6nrRUwVlohFfv2pENyMK7afKYw8TBLY=;
        b=gwgY3CmPpRCtLJoIS3yc1JHM/H9Zc++wU+Zkr0MdXghf6Q8EY1jCtUdrEuDIjiSTh7
         YmPtrco1ibOyzlDmzPW6hJW0Hy/GbHViDx5ZOPL8ScrytVb/uqXgLB6a1ICWzlVSsQym
         hPJ4A7H/UxbefAW7NsWO455e/Rh7WIpXjWo57d3wCd/arv4oPiKfz2p0NbuN8Y6lb1VP
         ky7EvmJWp18dsq/uYZBscNMDTrQavK8xQj0FwZ/WVflnym2ggZzeww5tKBllVCiiEWeX
         s5NsCJJ7SV25UDDXDoc30tYJkXaUMSNlp1SvN6WNlZjc+tE4pyca5zcCedJt+y7EFnB5
         xAzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772119831; x=1772724631;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8R0cGvCqhs/c6nrRUwVlohFfv2pENyMK7afKYw8TBLY=;
        b=cyQScp3fD4Zx0el2DyIsdFnYDaWUoU+0FNO6XP4UVd1/Lq6dXk9Mj923wPNfN7HJkB
         KJ+gaD5BFpBEM1eVemGuPaNVBQJkRYb5O+ZXeY7kgXELhTVC3IzdKs2/e1BgE2rWburA
         WVchoJKNcTJjNgMRVT8fcXduj8OWfnX0t84ragoPDqHI0gq5ZVo15s92vOpm/oQeassQ
         8jyPITXnumJPXfB7jARfqMK5IYlx97jxUmbHQqx5cu8jiJHXCyMauFHwnsimu1TG870L
         Bde9TQQ0R3rg4SUer1tiZovSNKM49Iw4bkAWIK38FoPVAaPM2b7vIRlEvYa43HfgE6/e
         t13w==
X-Forwarded-Encrypted: i=1; AJvYcCVVlMj7vOaw0Za7dRiIgShTHFGYRnPnRaPJjZO3B5rZnFw9ulHfGc6BOkm841WiizVjlR/TfHpMzHo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqKvXqeaCpbN/7/8SeIO8htIY2y7Y4brKRXQrStZj6l71R2Vlb
	H9Gu3hfAiXDpOCjn8T2f1WkteIDQ9bWspOTr0vw5pf+Xclk9aShzwRpIdaI6SEKMpHs=
X-Gm-Gg: ATEYQzzKX3ZOkLJgmZgJIZcsgz3hRJfMb/xPS68d9ELbu2KrCY0KAtKE/VKaTrTHfXv
	T9aROx2HAujcjt459bac5IMgvn0CZUKvthij5DI+6hv8zWfVXTgQvaIc11lokdPfFuikFvKQ+jQ
	qJIdoQjUfbL9H2YkgU/P3Y975yxhu4V9fW96T+RNXMtzZ4oEBwxX9AjI6U4M7SPX18IBtgTWX0O
	CubLSNyiKcXhkz6cbt8OHgXGMwgJNQbpBB+7p2HyLdr891JIg0pBVoiQi8dPnRn54AtCXuZfP+m
	3LsvWjZcBjhN2h+ag+BDSMc+J7otcmsrCMSFJ6528U2yWlzqGdnbJ89oCnupw/HbAzRxQszTLps
	3daN4m5XFDd6ne8Wyc1m+3gCphAAZi8mIsR31JA+ysfrOHF5vmP6ui/Q4sYAjuzm5WTAzMNCejE
	p647FygSF8jR6eb3EA5HBmERqio2f8dS6YyUGhPA==
X-Received: by 2002:a05:620a:3185:b0:8c7:1952:789f with SMTP id af79cd13be357-8cbbd07b64bmr569539285a.71.1772119831183;
        Thu, 26 Feb 2026 07:30:31 -0800 (PST)
Received: from [10.203.83.161] ([151.37.162.132])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cbbf659210sm227240985a.8.2026.02.26.07.30.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 07:30:30 -0800 (PST)
Message-ID: <f637d8075569613f97fbe7ff6219e6adde53646d.camel@baylibre.com>
Subject: Re: [PATCH v6 6/7] iio: ABI: Add custom data type
From: Francesco Lavra <flavra@baylibre.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>, David Lechner
	 <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Nuno =?ISO-8859-1?Q?S=E1?=
	 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 26 Feb 2026 16:30:27 +0100
In-Reply-To: <aaAQtJ5WTDtkxi08@smile.fi.intel.com>
References: <20260225100421.2366864-1-flavra@baylibre.com>
	 <20260225101806.2368391-1-flavra@baylibre.com>
	 <aZ7gdO58NV6gjgWC@smile.fi.intel.com>
	 <eeb28077-0886-42b4-b468-21f5c6a6444a@baylibre.com>
	 <aaAQtJ5WTDtkxi08@smile.fi.intel.com>
Organization: BayLibre
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-02-26 at 11:21 +0200, Andy Shevchenko wrote:
> On Wed, Feb 25, 2026 at 03:27:55PM -0600, David Lechner wrote:
> > On 2/25/26 5:43 AM, Andy Shevchenko wrote:
> > > On Wed, Feb 25, 2026 at 11:18:06AM +0100, Francesco Lavra wrote:
> > > > This type is used when the data received from or sent to a device
> > > > cannot be
> > > > identified with a standard type and must be processed by custom
> > > > userspace.
> > > > Any driver using the custom type must provide a driver-specific
> > > > document
> > > > that explains what the data represents and how it is to be
> > > > interpreted by
> > > > userspace.
> > >=20
> > > This rises the same Q as for other firmware-hidden algos, et cetera:
> > > How
> > > can we prevent the kernel from being just a simple proxy between HW
> > > and
> > > the userspace? What would be the point of having the "driver" in the
> > > kernel
> > > space?
> >=20
> > I tend to agree that this opens the door for misuse or an excuse to not
> > make the effort to develop something more generally useful on future
> > drivers.
> >=20
> > For this patch series, could we still use IIO_ROT and introduce a
> > new IIO_MOD_PARTIAL_QUATERNION that is defined according to the
> > description in the documentation patch in this series? This may be
> > the only driver that ever uses it, but it is still clearly defined.
> >=20
> > Or perhaps we could even say that if a IIO_MOD_QUATERNION has
> > .repeat =3D 3 instead of .repeat =3D 4, then it should be interpreted
> > this way?
>=20
> Not sure about the latter, but something explicit like
> IIO_MOD_PARTIAL_QUATERNION sounds good to me.

Another option could be having a custom iio_modifier instead of a custom
iio_chan_type. I think this would address the concern of drivers being just
a proxy between hardware and userspace. A custom modifier would be used
when the data representation for a given channel is too exotic to warrant a
generic iio_modifier enum value (but would still need to be documented so
that userspace can make use of it).
I can imagine a generic userspace application that interfaces with (in this
case) rotation sensors (i.e. looks for IIO_ROT channels) and can support
not only "standard" rotation data types (yaw, pitch, roll, quaternion, etc)
but also "manufacturer-specific" types.
We could even think about allowing more than one custom modifier (e.g.
everything >=3D IIO_MOD_CUSTOM is a custom modifier) so that a sensor can
have its "manufacturer-specific" data in multiple separate channels; and of
course each such custom modifier would have to be described in a per-driver
doc.
