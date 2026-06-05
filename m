Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA5E37C110;
	Fri,  5 Jun 2026 11:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780660662; cv=none; b=jZa0jMjnL7b5wLV+QUzlC7830CDMmAZo+rEpnfQSliEySf+OYAw8AJpR13l4Wu6u6rKsi2ZQRZhd6VadNIOhkEELeOP5Z3l8WqEjD61EALNYDicPWIeM00t9EwnI6fLKQVkgO0awd1aQAoaTD/dKJCPpTF1ChS2T5I9XeqG23o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780660662; c=relaxed/simple;
	bh=8N3gtKgXpW448kNJvjGEG4cP41LSxw1mwHfYfmicV4U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uEP+muLq9Nocg3a3IQns8Jz0WvalAoHa4N/Cb+o/NBSUFAP+rL8XIGPK3pbn2KICu2jlpGueoR3bu1/LC2vGq+kdO+XDf87RIYGjvPe3UI3sI+2E9c+CpeOl+x62xB5U+zha3o41VoAlWGG0lS68cL/FfrBZ65VbHQYa3uPHbqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XZioyqyN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XZioyqyN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 309811F00893;
	Fri,  5 Jun 2026 11:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780660661;
	bh=RtegHCZEdh/vAsspCklV0Y9YLnNn3EjJ8UeVkf/8/4o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=XZioyqyNswy95i3e1BED+LttGbxAj+LKuVhDBodIzDGDS/mv9R112VjOrzsTyp7uw
	 1DDhQMa8aGX6IkNzTiLgKRnUosoGCgDMNam6RepM5p3x7EweJPUy3AtKSLjDFvOP/5
	 TnWQeZqCUW2zo5fwSu/nvQB2mZeScGooiqMjLoio6MLYJqm1hwZoziLkTcuRPxVbjv
	 iG/ITGw7z5dAvr9PcBNXYhGcTowtX5V3i5mrBdq6Wr2TD+7K4P+3zIyw4/0C7oPjWx
	 fTU5PvXeBZ3QZGv/3szBQpJ02NvvROuXQu3HJiQbKisNqtM79h7e58+aFeaoWXD2uM
	 r/vVaqi6a7/1w==
Date: Fri, 5 Jun 2026 12:57:35 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: =?UTF-8?B?Vm9qdMSbY2ggS3LDoXRrw70=?= <vo.kratky@seznam.cz>,
 linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Lucas Stankus
 <lucas.p.stankus@gmail.com>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Puranjay Mohan <puranjay@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/11] iio: accel: change from %ld to %pe for
 PTR_ERR() printing
Message-ID: <20260605125735.3cc193c1@jic23-huawei>
In-Reply-To: <CALoEA-zSroEAxiN1L81+JERksLC2Oba=u9ya6j4--gcwpn6m0w@mail.gmail.com>
References: <20260604120201.116925-1-vo.kratky@seznam.cz>
	<20260604120201.116925-2-vo.kratky@seznam.cz>
	<CALoEA-zSroEAxiN1L81+JERksLC2Oba=u9ya6j4--gcwpn6m0w@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 4 Jun 2026 14:13:56 +0200
Joshua Crofts <joshua.crofts1@gmail.com> wrote:

> On Thu, 4 Jun 2026 at 14:11, Vojt=C4=9Bch Kr=C3=A1tk=C3=BD <vo.kratky@sez=
nam.cz> wrote:
> >
> > Replace numeric PTR_ERR() logging with the %pe format specifier
> > so that error values are printed in a more readable form.
> >
> > This change was identified using a Coccinelle semantic patch.
> >
> > No functional change intended.
> >
> > Signed-off-by: Vojt=C4=9Bch Kr=C3=A1tk=C3=BD <vo.kratky@seznam.cz>
> > --- =20
>=20
> Thanks for the change, but in the future, please slow down! Let the curre=
nt
> version sit for at least 24 hours before sending a new version so that
> everyone has an opportunity to review it.
>=20

Further to this, when doing a change across a bunch of drivers, send one or=
 two
as a test first to see what feedback you get.  You'd have gotten the reply =
from
Andy to such a patch without wasting as much of your time!

Jonathan

