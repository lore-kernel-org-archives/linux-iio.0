Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8135D29E0E5;
	Tue,  5 May 2026 12:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777985148; cv=none; b=etpDqeJNQvOIXmIoKExUBRvKo029V4tcStk4rLi7fu/8z1j0Sy2OXotoYQrffPG/8IYF6TNKLc7B6OScT+ZRMG8ZdFZu6CjTxb3XqWHuZLqP8ssCzA6zlAW8BERMvE8+gARlqAI/5HUsZioVO7XD6bgpFtZ/Rx6otn5AfxF5680=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777985148; c=relaxed/simple;
	bh=zwOrN98m/SaRFMCAwmpixGy+grUxDhg+CKzd8MuBoN8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DpRYgMiSMlAPO1l0ICsk92043orr5OS3kNxXNb/CIXOgXGMxsjxZa5mFyTiW1yFFhoL9mu2GrTLpNNmXRfXigg2SVvsUqSpGA1/Tc69KAfawOi0JGfruL1OPpviYA7Z8b2sSCU9UbbyuwnH6ivKWG2kcYQOLyswTsqm0t1HfGFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T8Qd3yKH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T8Qd3yKH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 666D5C2BCB9;
	Tue,  5 May 2026 12:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777985147;
	bh=zwOrN98m/SaRFMCAwmpixGy+grUxDhg+CKzd8MuBoN8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=T8Qd3yKHnUQd4xPb4CRvAfOuLWG0rIW3dcIJjVDgb1fIYWvaYAHwxR7b8k5vDJ2wD
	 qZLeiX71Uc5Bqu78oVI0hdlX54oNHM4zruw286tS1dR+bWu+eHqRjoFtUot/Fl0/kv
	 CPqP6Ei6IwxBl63i+yVcWF+6EoULoFoO93m4DTeUc47wQ0RkRctQzYxHsQeMf37C51
	 zht31RfYwPnSc9S3EvXN2rnvo4+Zjb16e8Gb64nRfktf76/wekPf2U1nGPx5VhJq08
	 S2mHdhOXXO5x+UR7x+cL7FarnoFlnrBmxFRcLY6sfhNsG9K1bPru8sOVe31POa/JBA
	 1EXF9UldKzOxg==
Date: Tue, 5 May 2026 13:45:38 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Maxwell Doose <m32285159@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>,
 songqiang1304521@gmail.com, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 "open list:PNI RM3100 IIO DRIVER" <linux-iio@vger.kernel.org>, open list
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5] iio: magnetometer: rm3100: Modernize locking and
 refactor control flow
Message-ID: <20260505134538.73b5fec5@jic23-huawei>
In-Reply-To: <CAKqfh0FrKeAL7+guUMmsvm3EkjFZjEUXQUMHk=x9adU+ZWv1eQ@mail.gmail.com>
References: <20260430124148.11572-1-m32285159@gmail.com>
	<afNR1Apx86FeAcKd@ashevche-desk.local>
	<CAKqfh0FrKeAL7+guUMmsvm3EkjFZjEUXQUMHk=x9adU+ZWv1eQ@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 30 Apr 2026 10:43:58 -0500
Maxwell Doose <m32285159@gmail.com> wrote:

> On Thu, Apr 30, 2026 at 7:58=E2=80=AFAM Andy Shevchenko
> <andriy.shevchenko@intel.com> wrote:
> >
> > I confirm that my Rb stays with or without this change.
> > Maxwell, no need to resend for this.
> > =20
>=20
> Alright, sounds good.
>=20
> Best regards,
> Maxwell Doose
Applied to the testing branch of iio.git with that tweak.

Thanks,

Jonathan

>=20
>=20
>=20
>=20
>=20
> > --
> > With Best Regards,
> > Andy Shevchenko
> >
> > =20

