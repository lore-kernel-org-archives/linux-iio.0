Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA1237EFF0;
	Sun, 19 Jul 2026 23:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784502159; cv=none; b=lL23hod0ukC4oCW/2DYQgRPBYDYC3GcJJVqM2A1uptKGgcvJFL1oUft4Gp2nzVKOJzraKUTPHgQ4LuzuFQLw+AHauJwY2038Zgq80X4R7+NcmUDk/u65wP0tT1X8h06PnEkxRvNCwhzpOGIIWtxCX/eXmYN03qEiZkV/icpaG8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784502159; c=relaxed/simple;
	bh=MzlsrQhUdx7eju5luy5yPFf1HwMUhrdqZtSNThdSjrs=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=liy716Diz8zPqbiZc5BX+Sjq+FoD/wWtI6ERQOQEOfDTykEt8DdZW1I0tpSMJgCOwOBHpUfwCZpOnfosMsGMfk47tUNmgv2SW0nMGOVgA3BPHmwxISKUqMCCKoyER07Fww5ePZ2Dof2bmIxwsPN5cd8rUJRrlAQiyTot5wpzWXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gNX7gpxJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gNX7gpxJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D96881F000E9;
	Sun, 19 Jul 2026 23:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784502158;
	bh=MzlsrQhUdx7eju5luy5yPFf1HwMUhrdqZtSNThdSjrs=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To;
	b=gNX7gpxJoncq0Qm2/1RAM1mD9/GZXybhoveDBKGhJBvP6+ew7jagKnpaQ1bwemSqk
	 KKKzHQCCMwFoOM9DqS82Lwcw96euvZh65qM3aVqy8BwMtAPA/ZWBQHXHy78qHahoSE
	 lgEk9+HKlU9FBGXWf0ywGIzWIib50Z9i4kqBP8/3nUaZD79IuJJt4ZlgDbGyHP7a4N
	 ug15cVKaFnJjGGp6PwbojGdjL5X1uP4Vl0NcwS11yQKS6UBFUmbh3EjXTLgByhkRff
	 hs65GVGPEsW/37HzHQtJyEeXnLr3RIkpHEWfFHuY3up7R44fAkKao2HMb8UMH7oknY
	 uQVyawjTlAl/g==
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 20 Jul 2026 01:02:34 +0200
Message-Id: <DK2X7WBPOPWC.TY09ODVGYUVM@kernel.org>
Subject: Re: [RFC PATCH v4 1/3] i2c: rust: implement SMBus read abstraction
 via kernel::io::Io for I2cClient
Cc: "Igor Korotin" <igor.korotin@linux.dev>, <jic23@kernel.org>,
 <lars@metafoo.de>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-i2c@vger.kernel.org>,
 <andi.shyti@kernel.org>, <wsa+renesas@sang-engineering.com>,
 <ojeda@kernel.org>, <branstj@gmail.com>
To: "Muchamad Coirul Anwar" <muchamadcoirulanwar@gmail.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260707151542.91997-1-muchamadcoirulanwar@gmail.com>
 <20260707151542.91997-2-muchamadcoirulanwar@gmail.com>
 <178376430529.16552.7043868463863908196@linux.dev>
 <CAO26r3Ttyfqhs3_jWDFym7FpswqFW4-UA8p1pQBcuWzDGGzstg@mail.gmail.com>
In-Reply-To: <CAO26r3Ttyfqhs3_jWDFym7FpswqFW4-UA8p1pQBcuWzDGGzstg@mail.gmail.com>

On Tue Jul 14, 2026 at 6:08 PM CEST, Muchamad Coirul Anwar wrote:
> Agreed. I will rework on top of Danilo's FallibleIoCapable approach
> in v5. I checked rust-next and neither FallibleIoCapable nor
> io_projection v6 has landed yet.

The patch series is merged in driver-core-next [1]. You can check the
MAINTAINERS file to see how patches for certain subsystems, components and
drivers are usually routed.

If unsure you can also check the linux-next integration tree [2] which merg=
es
all development trees in a daily effort.

> Danilo, should I wait for io_projection to land first before rebasing,
> or should I carry FallibleIoCapable as a preparatory patch in my series?

As mentioned, I/O projections did land already. Regarding the FallibleIoCap=
able
change, please feel free to pick up the diff I posted and send it as a
prerequisite patch in your series.

Thanks,
Danilo

[1] https://git.kernel.org/pub/scm/linux/kernel/git/driver-core/driver-core=
.git/log/?h=3Ddriver-core-next
[2] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/
