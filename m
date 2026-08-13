Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B557F388893
	for <linux-iio@vger.kernel.org>; Thu, 13 Aug 2026 17:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786643677; cv=none; b=ItCcbOTEl+FwupEvepMWMEuHlxeRxxT1kjgQqA7AcCUE4TTng1tRBHDuHEhtSE41B83b7WySXdOmLmEs9EDzpAYgOYwcEhOz3N7G3mRAK+TEGJj9BlbmglHD1k1T7htMAOvdpgyJ8chTU/Qk0zy/Le4yZZOPrn7WAqnUQwcNjmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786643677; c=relaxed/simple;
	bh=d48pfILS4QZgdmOaDvSMdHmLNM9gMRAorxt9K34NoHw=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:In-Reply-To:
	 Subject:References; b=N81fkYcU+ACYyrJwu3QNXFBoPD4CIMLb8DcOaAdckLYm9YASujOLwxCL8fwmJuPnZfUC21falAFLJeP/xbFY8052fJs69eY9mE3UpdNqNEzuxaCrFhUOVHkXTCzVEZ50ZkjY/EfA+jjnx8+GqQ1IGvoHpRQts1xY7UteS1GLQHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=maxwelld.cc; spf=pass smtp.mailfrom=maxwelld.cc; dkim=pass (2048-bit key) header.d=maxwelld.cc header.i=@maxwelld.cc header.b=Ys7PvHtU; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=lgvzgUcR; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=maxwelld.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maxwelld.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maxwelld.cc header.i=@maxwelld.cc header.b="Ys7PvHtU";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="lgvzgUcR"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=Ys7PvHtUOXG665AtKjeI05uvOevsLynsFpCs4yuT8Uj5fmHlUyiO06urqqjkN2F45KASYmHgrJyXYptWvWhOG3jqpBOXgUchrJ9HvlolxTF5I7RgiJYa1bU0X2zegAiXhWI3q8pkRY4xnIyp9IVVMLZ4TkRhIEYjZu8/5unTBcEj40BbAHawx65ph+tnZO4IWQBA0yDeodUEX/Pbjo7+i+/hE7+2b6UWFT2IBEXZdHJpLU5k5IYyLXlUmEYI/AS2RY5wJS5ahbA3j5NUjfLRFJPM3z1ulgoPRQI/QJKzipM5O5uCOUww4gl4gGBapXzbtWklJF+wWdewEl3I/7jk1w==; s=purelymail3; d=maxwelld.cc; v=1; bh=d48pfILS4QZgdmOaDvSMdHmLNM9gMRAorxt9K34NoHw=; h=Received:Date:From:To:Subject;
DKIM-Signature: a=rsa-sha256; b=lgvzgUcRgWWV9B/3eYPcfgIyu/M7F1FXVzuTb8JaQTi3h614OIYDcDwnzHsRTox5s6cjYASZ895ZW5fDahIrbsTuhm3Ch5NOyr2LHJrWSVw1k4R9exhSd/CUm7KrTdi1tCM6rDZziKLQq7PuC4sSW/WOrDjL7qtPYRo5FHaf1ogq59VIfCJhtza7ISvMqTcIIhkzuOF6xcZK9ukvyoLPOP3hQIrYaV5uxJZK4fa+OLlVseExlb87QCVVAwRCIRJaP04vdPIVboojucDw5IFM6N9Hs1x0nlL9CcAvM+jTfitBKf4NvPLGYxrNQilsH6oEhBasfAdn5SiVo7R99WgZYg==; s=purelymail3; d=purelymail.com; v=1; bh=d48pfILS4QZgdmOaDvSMdHmLNM9gMRAorxt9K34NoHw=; h=Feedback-ID:Received:Date:From:To:Subject;
Feedback-ID: 1013395:40550:null:purelymail
X-Pm-Original-To: linux-iio@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 1889956087;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Thu, 13 Aug 2026 17:54:23 +0000 (UTC)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 13 Aug 2026 12:54:22 -0500
Message-Id: <DKO0BJR8UYSW.J6XR6HJA7G71@maxwelld.cc>
From: "Maxwell Doose" <maxwell@maxwelld.cc>
To: "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>, "Jonathan
 Cameron" <jic23@kernel.org>, "Maxwell Doose" <maxwell@maxwelld.cc>, "Sakari
 Ailus" <sakari.ailus@linux.intel.com>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Cc: "Marius Cristea" <marius.cristea@microchip.com>, "David Lechner"
 <dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 "Andy Shevchenko" <andy@kernel.org>, "Tomasz Duszynski"
 <tduszyns@gmail.com>, "Jean-Baptiste Maneyrol"
 <jean-baptiste.maneyrol@tdk.com>
In-Reply-To: <20260813071912.2465208-5-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 4/4] iio: adc: pac1934: Unshadow error codes in
 ->store()
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260813071912.2465208-1-andriy.shevchenko@linux.intel.com>
 <20260813071912.2465208-5-andriy.shevchenko@linux.intel.com>

On Thu Aug 13, 2026 at 2:16 AM CDT
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> kstrtox() may return different error codes.
>
> Unshadow them in the ->store() callback to give better error report.
>
> While at it, add missing kstrtox.h inclusion.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/iio/adc/pac1934.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>

Reviewed-by: Maxwell Doose <maxwell@maxwelld.cc>

thanks,
max
