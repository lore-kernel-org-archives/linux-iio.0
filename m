Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF9F3A7833
	for <linux-iio@vger.kernel.org>; Mon, 17 Aug 2026 18:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786992779; cv=none; b=RtFeH8UWtV98g3IbEXlaKq4i5lXjCGzFfEz+46P1cpU2svFzvSKRbAKPonbkyeNT+7d1AeYoKUZ5GepzX4rdMUSekod8Cgv+HRLJrdHvo8qqN5VT3WNJzXeUrBz4A9jYCl/nXuJBfDONxDKIj3EL0Is055FWuRNzaurbM62soy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786992779; c=relaxed/simple;
	bh=ZEgn8ET16IVVd2irGFbKTPP+IeRhBNRQbXBuEgVqNcg=;
	h=Mime-Version:Content-Type:Date:Message-Id:In-Reply-To:Subject:
	 From:To:Cc:References; b=FWCLPLhVkpJO1lI8vjJjwDszAGj5X38P7mcxGEOKyxO6pSuNozURlqd1XRrF+oiqmqyz0m3nv6LmZAwEe5Hp7coB3pCddCGAiFuU1GH1dI4toZCs9i7EijvnnK4etxmHdlNW2oRic03FHPxhZDV01v0t1yIfsnm+1tRCssREtAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=maxwelld.cc; spf=pass smtp.mailfrom=maxwelld.cc; dkim=pass (2048-bit key) header.d=maxwelld.cc header.i=@maxwelld.cc header.b=pV3mU4o0; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=rVYWkbFP; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=maxwelld.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maxwelld.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maxwelld.cc header.i=@maxwelld.cc header.b="pV3mU4o0";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="rVYWkbFP"
DKIM-Signature: a=rsa-sha256; b=pV3mU4o0dYtV/ukCfDf1HSWYhXbzGfe6xIn9RD9uwyo2aPclBWsnLfNsqlYta9tXQX2zkNy+pcw79TPStZ5XKWMXXACe+bscxH1SSZvIfLKse/NH34NvWxEoYep+jUfkM7jKmelTh0Z4c2FuOIzHbS/buyB8fCBT1jaJz+PHOOyUNjHlBZBW499qHlB4JmTFVWiqtbM9ncZsVbXbay6gJe1WRcUrcLkyvBxMgZr4fyN0OyS4S8yq/4kvR0z0FTtTxzbTCyJ7sLn8qGh+Ut+GjTn5Ow9S6rdw3zeirM1wuGixlEzYo/muvjJGW+yRhnlh/pSt1lZJukpi1jekzPfIwg==; s=purelymail3; d=maxwelld.cc; v=1; bh=ZEgn8ET16IVVd2irGFbKTPP+IeRhBNRQbXBuEgVqNcg=; h=Received:Date:Subject:From:To;
DKIM-Signature: a=rsa-sha256; b=rVYWkbFPG7T/7wYMJZhSGWA2rD9BeiLvbEyWO9ItdfaAL6pe1uDxJ/NiNtEkRaoh4PMq8mj4bF7Ca/CY7smtJkqH2BIxSRkmOEb5FdWUJHr6mbiPjELzIwZVM21eqGuhNEPN9JuCP48PCjaaGmMXseWK+vXV1jS01Y06xNwbM6QZnphaKEnSQUAk+lpLdny45Lx+7/mWP2yEtGFvHlHS/BUt8JdHUqqlk967cI5PXrKdhiGe+YfKxJ5u04uLJtBest42c1uT7NRewEPMpO84Y93aWOaPDl1/L5ASLk7hjoldh9sCknis5CvSMdBDY7UzC9+2i8jrkQ8uHtP7l8/YwA==; s=purelymail3; d=purelymail.com; v=1; bh=ZEgn8ET16IVVd2irGFbKTPP+IeRhBNRQbXBuEgVqNcg=; h=Feedback-ID:Received:Date:Subject:From:To;
Feedback-ID: 1013395:40550:null:purelymail
X-Pm-Original-To: linux-iio@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 633454166;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Mon, 17 Aug 2026 18:52:51 +0000 (UTC)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 17 Aug 2026 13:52:50 -0500
Message-Id: <DKRG2HMOXB6G.58NDUBP44GM6@maxwelld.cc>
In-Reply-To: <20260817113738.1324-1-joshua.crofts1@gmail.com>
Subject: Re: [PATCH] MAINTAINERS: add patchwork link to iio entry
From: "Maxwell Doose" <maxwell@maxwelld.cc>
To: "Joshua Crofts" <joshua.crofts1@gmail.com>, "Jonathan Cameron"
 <jic23@kernel.org>, "Andy Shevchenko" <andy@kernel.org>, "David Lechner"
 <dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Cc: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260817113738.1324-1-joshua.crofts1@gmail.com>

On Mon Aug 17, 2026 at 6:37 AM CDT
Joshua Crofts <joshua.crofts1@gmail.com> wrote:

> The IIO subsystem entry in MAINTAINERS is missing the link to the IIO
> patchwork system, making its existence lesser known.
>
> Add the missing link.
>
> Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>

Reviewed-by: Maxwell Doose <maxwell@maxwelld.cc>

thanks,
max
