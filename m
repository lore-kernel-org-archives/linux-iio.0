Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625214AB1A8
	for <linux-iio@vger.kernel.org>; Mon, 19 Oct 2026 12:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792414413; cv=pass; b=coElN4+DZlWOdghcUMHSrwe1wgZPkOznPZpwICr7vuagoQCxTLjRoVbMfEHvbTrzgzzPEfk+fJAI0NRGqhSVDfx3lyUQzvGFTeDBulHzBDYMANYUJfsm5vU7zIBuhOFOy0HMPHvESGDq0O2ieqfqj7cJw9xbaW/6UAAoWXbHTgc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792414413; c=relaxed/simple;
	bh=FNwgn3FhczlTdrGyWzEHio80X7+yKZEdfs8EY7scwzU=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ex74S55C69tqj1yqX897DXM2PEOZhxrHylSW7QTzG3MuCIC16NizRo6qNs7Ivl10Upfa20WA8+kS7MU9DQrxt/4MpsK7D1ljU0HUK0TwRmiJJCAibcxqHHy5ivCDCn2qZNt6e57IBpUF7AYjnP5q4LRl7bbVT7k+3NCj+soFyt4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qaR1nuTi; arc=pass smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qaR1nuTi"
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-9903fde8db8so454471241.2
        for <linux-iio@vger.kernel.org>; Mon, 19 Oct 2026 05:53:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792414409; cv=none;
        d=google.com; s=arc-20260327;
        b=f4uAbVEEi1BJeWsiUzLYuOn+bcuiuLevvbjWhKeT/F310AxxTjOv9laHxKrIGJwErO
         I8sYSGr8vcefc/oEDbG9AzKu6TjBXdhY9S3np9FSEgiUQ4eCnTXM5yipm986nbOKW2aE
         gmpOWXygYtyWm+cU+0mVgPWb77RPeKSGtPm5AiKn4y3rjkFh8bv05SZu6XuhVk33fma6
         /TFISYfY1EBALs7VgauetzG/GrYdbQy47geVTp0l5GXDZHYmRD4LX82y+17ccjYpgHdR
         OCWxWztwRtZKYb4SH8swetU/78gri17ZwBS3/s9akgBEO2F7gObaVTJKYPgMr1gQ75B8
         xueA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature;
        bh=FNwgn3FhczlTdrGyWzEHio80X7+yKZEdfs8EY7scwzU=;
        fh=yzyh2PVZ7nCev7ysAMybnc1NWVRDD83YQZpjG8vnZGc=;
        b=LxkW6j4aM0Y7eAqwzG67sbgtsOYn6672lkBMCVXVMrmnxPn2/BKuxCKEtPHxOrCGN7
         doyeFCSSQnM4odCkX6fFi7lnFUEiyghkt5Av+TtY3wyjl7GPDAsHKVZkxsrYXWVZAqIH
         XvrxMOMvjiyjUGSCdNE5iriH7buCoMnv8Sj0pk1iDyE+tbiORzUnFlLLB+90dPRP/4q1
         /ua5wq0wmaQNkl9PlQLIIjWECsPbvXBcTdO2NkNajjbLgRZUxMO22jckisWT1OU8lMLd
         btk+ki8qTWOXqVEHmxmhwt/REiuJEViLE5EvhQtB1u7Ln4SF8QlPvWhuBXf5D/eEZVbq
         vPDw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792414409; x=1793019209; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=FNwgn3FhczlTdrGyWzEHio80X7+yKZEdfs8EY7scwzU=;
        b=qaR1nuTixVyQmk2u80KxUFYI1gpZ8VyZ91daEtMon/CZyBUvM3a1nuimJenFCLAjwa
         5jQyHju8ir3Rcqbel4SfS5LKHrucKT38Ak6jFDSk1Lg7DJqAgRnShmK5u1R2gow1oRlE
         Xj1x1G35/ocveih6KIKNO3+XvhNyvxtzIwSNzq3zj3E66/KXjYnGf5OF+CFEocpp3sRd
         YBCE2ZEkngsKiCBi9VRGaYFX+CzG+JzXALmXmSpokQSBxgJW/7Sv/5XwYa8S/iZBnkbk
         NFngZlhms+Po8190oTHHTt8s0R0ULEGY8ErukFeHJThWE0UGP6xR91TGjCKCEeZx7WhU
         SJNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792414409; x=1793019209;
        h=content-type:cc:to:subject:message-id:date:from:references
         :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=FNwgn3FhczlTdrGyWzEHio80X7+yKZEdfs8EY7scwzU=;
        b=w3elOv23ZL0FAYrwS//8RfZ4sXIO+/BsiQbfoLS9qWWl6xeRP5zXrUqIBY3gzud5iH
         YcBZ4PSL2tjW5yl2vvM92ZEMKR2nuoqQrgFlsSzv8R+GfLsOeV2/etMiJWZSrCoisWd0
         gtv+elmWtD4autU0bWsF+adNzqk20I4gmwXTeiqocr2J2u+WpucI62G1WwhH7wzWZZC9
         RqPk6iwr/iGAHYRAmf0LBWy+LEWyONae5YLSUYVI+oXwIwBhC7H5dR73yqiZZ8gagnd3
         qX5X0FPyOm6Yj7s5y1RjMZh9GYTptd/BBtGdNymWuM2JdwV1gwLNagFi+H4uWoh5aEZg
         R1SA==
X-Forwarded-Encrypted: i=1; AKwUvByGqlx0+7Uk33omaq+uMI9y5zwIRsdCuT+x2GvMJjlXcp/vE0S/K3X2Ui//ePtlVRsRX2PGABGbge0=@vger.kernel.org
X-Gm-Message-State: AFq9FYIQhPU+MQRV8W7QMd+117Lx+twg12n7f6QRo2SuETU2gXZmoW43
	wv87kIxXJ70lXsyyjE9HLfJqmS3WH5Vu2Hjmcv6b/XQSg24qiCuJnOyEQD6kQk0lSkg2WMbnViA
	U5qPSOXJlUfwc/2RR9AqjjirAvkOXKlQ=
X-Gm-Gg: AYBFou0UBNc6NmcANrPwXnd32QdDrjiwpBMk45DeJ9HLZU/HcsqSnh01bT0xdbzFHTJ
	1cdzx797Uw+cqsTDhmb/i9mYwUublOIaLEhEMrs6x1+f4pM3lmycyw/yp8gj28CUUiyE2hHuZ+S
	JkDzjcItV4GNUUHc2BhBemnec2Et3QUts536BOhoxwOBsEHxF4Hr/s/olGMg6sNmjc8P8KBm66T
	IUmXuCzjhNbsotGHnjqMcxf9qTsO2EqaaDdCLmTmYR+xUUjkR8T2o+K4n67JqW72enrx4KqRUkX
	A3DMUG2sEIlpn4BkoQwsSH36abK6NpNkdXD1pTK7JfmLMOevZlE=
X-Received: by 2002:a05:6102:f86:b0:7cb:288a:b66d with SMTP id
 ada2fe7eead31-7cc369ac7b5mr1600977137.20.1792414409122; Mon, 19 Oct 2026
 05:53:29 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Mon, 19 Oct 2026 07:53:28 -0500
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Mon, 19 Oct 2026 07:53:28 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <atXvOA40_3qE2HA-@ashevche-desk.local>
References: <20261018-adxl345-period-cache-v2-resend-1@gmail.com> <atXvOA40_3qE2HA-@ashevche-desk.local>
From: Iron Berrington <berringtoni36@gmail.com>
Date: Mon, 19 Oct 2026 07:53:28 -0500
X-Gm-Features: AclHuK8Y7-0ZzVzseArWZiC8I0v3U9VeRhuq6uTpYC42bhbZYLVi-yDkZavvr_A
Message-ID: <CAF2O-sPB3ggqwEA1LXsrA=tCpZGJMdx8KAXLXrW7RcaEk9y1iA@mail.gmail.com>
Subject: Re: [PATCH v2 RESEND] iio: accel: adxl345: update period cache after
 successful write
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, 
	Andy Shevchenko <andy@kernel.org>, linux@analog.com, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Andy,

Thanks for the review and the Reviewed-by tag. I'll address the
time-unit constants in a separate cleanup patch, keeping this fix
focused on updating the cache after successful writes.

Best regards,
Wenqiang


On Mon, 19 Oct 2026 13:21:44 +0300, Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
> On Sun, Oct 18, 2026 at 09:42:00PM +0800, Wenqiang Zhao via B4 Relay wrote:
>
> > The ADXL345 event-period read path returns st->inact_time_ms. The setters
> > for inactivity, free-fall and the ODR-derived default currently update
> > this cache before writing TIME_INACT or TIME_FF. If the regmap write
> > fails, the sysfs write reports an error but a subsequent read returns
> > the requested period even though it was not programmed.
> >
> > Update the cached period only after the corresponding regmap write
> > succeeds.
>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> Assuming that my comments may lead to a separate cleanup patch later on.
>
> --
> With Best Regards,
> Andy Shevchenko
