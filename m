Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422A3364959
	for <linux-iio@vger.kernel.org>; Mon, 17 Aug 2026 18:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786992633; cv=none; b=G0nxos0fX2uGO9cqQ+51+YTWO4Ucd3LG7jG+Tio9Z1QqnSs5Fu2RWWIls9op8FyZW39fT55EIvWVSht9ufQz4lG5cRb2MnwZoKubOWQlTZd6/a1XNzFTGVNjTJv8OLq5hLVPRawEFdURyUMQ28L/EaSX7GXOFyqxLJpTOOunb3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786992633; c=relaxed/simple;
	bh=91QUV3SpI4knxSagoDLmNTEKVmp2iPNd/Epz+oQNh2s=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:In-Reply-To:
	 Subject:References; b=EyG4H92KZRnAaLZV6OU3yaJT2Qlg/aDPj+ldnHtLz9jOotCCXcp4oIItM4te8q/dQQTp1MeGnCTyDFE9bQqn0WoE+Bik/lmCDdIyH4zVJPZ4WNhAElJABDK0pvrLsMOCuOLG3/ExCBYPAhCifUb9YS+QKCUOrabZ8oFLn+eqvUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=maxwelld.cc; spf=pass smtp.mailfrom=maxwelld.cc; dkim=pass (2048-bit key) header.d=maxwelld.cc header.i=@maxwelld.cc header.b=AeZRyaaq; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=lSfAn5mL; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=maxwelld.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maxwelld.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maxwelld.cc header.i=@maxwelld.cc header.b="AeZRyaaq";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="lSfAn5mL"
DKIM-Signature: a=rsa-sha256; b=AeZRyaaq1aR6KabvWuNzeZWeLnFNKGLHI9EVfpfxKwQ6l2L3IMH4s1VoOLT3dT+D6u1vG7lWcg8tnSWZrboK8/4mdsyD4oya607JKoRc9z7cR9IzvGonabFYVv8t3XrhJWrGGzfYGNsXafUbjgefbqCqdq6aBoOlYY6D7iZPCMxSo7C+48WTk8hIRinFGNIRGvp80fcxSdIbQRkFIU0A1IYztT9usSttDTupDGlFOO+FVBFK061onqvfPSewe8j6eOyUAXBepPaV2VhI6BIebjJmfq5L24s/1z2VKkHtPv/96EZtPZlsXWtPpNimKbwWZbSOupq/VdLKgRhHtETHgA==; s=purelymail3; d=maxwelld.cc; v=1; bh=91QUV3SpI4knxSagoDLmNTEKVmp2iPNd/Epz+oQNh2s=; h=Received:Date:From:To:Subject;
DKIM-Signature: a=rsa-sha256; b=lSfAn5mL4Zou3IqO4M4cpDthvMAJutik5RFPY++pRxnYKTIb6pfU609EixUwaw7q+SgX0ELYTywfTYAgWcCPIycmIC6QwTMFPFp8Y5H3CqD3vMEp7ORpMQXe8eih3gdssav82UodEb1v8YyorGeychFE55YFlHJLNNkQ3AIxtlJuoN+EhTa6gjPt5fmJM5b5nYNxbdJJAClFkwOjkiq2k/okyBwXlesPjcGRBoePJbX1512PyLhC28VEweSxb3sYSWWy+3WjtCIVTSB0o+fujFpcB2IGZkdzsL5j6miJw7eC6XslEeqcI0v+rHabHPmFkfjxEFN8oNA8FvFu7ERMEg==; s=purelymail3; d=purelymail.com; v=1; bh=91QUV3SpI4knxSagoDLmNTEKVmp2iPNd/Epz+oQNh2s=; h=Feedback-ID:Received:Date:From:To:Subject;
Feedback-ID: 1013395:40550:null:purelymail
X-Pm-Original-To: linux-iio@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 308909866;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Mon, 17 Aug 2026 18:50:30 +0000 (UTC)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 17 Aug 2026 13:50:29 -0500
Message-Id: <DKRG0P23P5NA.171S6RGSLSI3W@maxwelld.cc>
From: "Maxwell Doose" <maxwell@maxwelld.cc>
To: "Joshua Crofts" <joshua.crofts1@gmail.com>, <linux-iio@vger.kernel.org>,
 <jic23@kernel.org>, <andy@kernel.org>, <dlechner@baylibre.com>,
 <nuno.sa@analog.com>
In-Reply-To: <20260817111825.000063f6@gmail.com>
Subject: Re: [RFC] Maintainer entry profile/contributor guide for IIO
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260817111825.000063f6@gmail.com>

On Mon Aug 17, 2026 at 4:18 AM CDT
Joshua Crofts <joshua.crofts1@gmail.com> wrote:

> Hi all,
>
> I was browsing lore and checked out the ksummit mailing list, where the
> topic about guiding new contributors arose [1]. New contributors tend to
> make the same mistakes when sending patches, causing reviewers to point
> these out all the time over and over again. For IIO, this is definitely t=
he
> case (I myself send an email telling people not to send a v2 in reply to =
a
> v1 several times a week). Other subsystems have a "Maintainer entry profi=
le"
> that contains subsystem-specific process info (DAMON for example [2]) and=
=20
> (sometimes even [3]) a document describing the code style of the subsyste=
m
> (this would be a great place where to mention things like not using
> kernel.h in new drivers etc.). I'm happy to create both of the documents
> but it's always great to hear other people's ideas!=20
>

Took a look at [1] and it looks like these are issues across multiple
mailing lists so maybe we should add these to the main
submitting-patches documentation? And then for other IIO-specific things
we can put those in a maintainer entry profile.

> Second of all, the idea of having a bot that would automatically detect n=
ew
> contributors (i.e. the email they're submitting the patch with doesn't sh=
ow
> up in `git log --author`) and send an email reminding them of the basic r=
ules
> (while also referring to the entry profile mentioned above) sounds like a
> great idea, but of course hosting and maintaining are pain points.
>

Hm...this one is more difficult. I guess a good first question to ask
would be "can this be hosted on kernel.org infastructure?" But maybe we
can also ask Greg KH about how he does his automated bot.

thanks,
max

> Please let me know what you think of the above ideas!
>
> [1] https://lore.kernel.org/ksummit/87y0ekm9nw.fsf@trenco.lwn.net/
> [2] https://github.com/torvalds/linux/blob/master/Documentation/mm/damon/=
maintainer-profile.rst
> [3] https://github.com/torvalds/linux/blob/master/Documentation/hwmon/sub=
mitting-patches.rst

