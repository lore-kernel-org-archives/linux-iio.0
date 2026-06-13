Received: from mail-24418.protonmail.ch (mail-24418.protonmail.ch [109.224.244.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5352984039
	for <linux-iio@vger.kernel.org>; Sat, 13 Jun 2026 07:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781336128; cv=none; b=abJK3o7ay1tK8wDAioWivGSlTpPhZnPcxL5DCfciWF8bfPcaPvUxfwDcdzLfMTICMLzp/3WOGTufi97lCVHiZk+mI5j8dK0R3asxckgJZyVqHs7HjbacFGU7ptM3XFnT7Og2+sIbg2DYVTcRv/JeeKfcX/7P75CCUxClePVBlqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781336128; c=relaxed/simple;
	bh=3XJZ1J9oWgYD/IjK1U+r7zqufXSKRyqkCBO4NDLtKAI=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=cLGNAR9w/nmJgbc4gHJRti2NjVcOT7ZlI88sFmPGRG02yyH2oktXtxa9mqBfweQqR//J+Tls2VTWlilpeVuxw58JWHjrm9uskxIlgm+4g+AZ3ETZI2LvOTIjJ26qP2+g5Fttlg9NpvfM1mGiLg/ryJT8aeRud8MO5B+lC3tiVYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=ZKCiFf5l; arc=none smtp.client-ip=109.224.244.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="ZKCiFf5l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=u7dovgts3facxb4h6mju454o6y.protonmail; t=1781336116; x=1781595316;
	bh=62Qj2B1ZGPXQDg2S3MHWkUrOrjr3PUWyPmghTLuwPK0=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=ZKCiFf5lsWcerIdlRynZAYdIEEJtuIMXvwirBARbeHl43DNNXd9VZtTrRfE+1CzlH
	 inm0WIy7IrYVpJ/JFjJ3N37Xi7WF5u2Tt8zVpFCWXLUMKbPJpyAUCZZ/TaPgy6SZst
	 3yEaqhFvEdSepsRzcHmp+94m6T1XupWAo7YKDIo3LA/V+dUJ05WNnb8n0sBZLNZyVq
	 X+mVJGk1ZukWkYSfxu9daJGkqB9LVQVeOtU/Zo9wqgEbpUC3BtxoBVIh7gMt0Y33ae
	 Dc1zag1MtE8152l2D3EJbRfY1W/G1oG5tBeB/owbVvSCsBOJe7BF6nN30veGHWBWYz
	 jQrYdieAC3APg==
Date: Sat, 13 Jun 2026 07:35:09 +0000
To: Jonathan Cameron <jic23@kernel.org>
From: Bryam Vargas <hexlabsecurity@proton.me>
Cc: =?utf-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, David Lechner <dlechner@baylibre.com>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: accel: bmc150: clamp the device-reported FIFO frame count
Message-ID: <20260613073504.168858-1-hexlabsecurity@proton.me>
Feedback-ID: 199661219:user:proton
X-Pm-Message-ID: 1bba523b52315f3ac8ada9cea31e8ece63058061
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

A couple of things that belong with the patch I just sent: the reproducer
I used, and a heads-up about an in-flight series on this file.

Reproducer
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
I reproduced the out-of-bounds write with an in-kernel test that drives the
__bmc150_accel_fifo_flush() buffer geometry verbatim under KASAN
(CONFIG_KASAN_STACK=3Dy), with the device-supplied frame count:

  count=3D127, samples=3D0 (flush-all), no clamp:
    BUG: KASAN: stack-out-of-bounds in ...fifo_flush
    Write of size 762 ... 'buffer'   (the 192-byte buffer)
  with the patch (clamp to BMC150_ACCEL_FIFO_LENGTH): the transfer is
    bounded to 32 samples, no KASAN report.
  a well-formed (<=3D 32 sample) flush is unaffected, no KASAN report.

The full 762-byte write -- a 570-byte overflow past buffer[] that smashes t=
he
stack canary and the return address -- reproduces the same way under usersp=
ace
AddressSanitizer on -m32 and -m64. The FIFO frame count is read over I2C/SP=
I
from the accelerometer, so triggering this requires a malicious or defectiv=
e
device, or tampering on the bus. No CVE has been assigned.

In-flight series on this file
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
There is an in-flight cleanup from Gabriel Rondon converting this driver's
locking to guard(mutex):

  [PATCH v3] iio: accel: bmc150: use guard(mutex) for mutex handling
  https://lore.kernel.org/all/20260525110130.61284-1-grondon@gmail.com/

That series only rewrites the mutex_lock()/mutex_unlock() pairs -- includin=
g
the bmc150_accel_fifo_flush() wrapper -- and does not touch the count handl=
ing
in __bmc150_accel_fifo_flush(), so this fix is independent of it and the tw=
o
apply cleanly together. This patch is against mainline; if the guard(mutex)
series lands first it needs only a context-line refresh.

Thanks,
Bryam

